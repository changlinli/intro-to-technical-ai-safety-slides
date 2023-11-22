% LLMs and the Transformer Architecture

# The Problem with Vanilla Neural Nets for Language Models

+ Theoretically universal
+ But they tend to learn spurious relationships
    * Very difficult to coax a vanilla neural net into learning to take context
      into account properly with a sequence of words
    * Unclear what the best way to even encode a sequence is for a vanilla
      neural net

# Strategically Setting Restrictions

+ So the problem (as always with neural nets) is of *over-*generality.
+ Can we find a set of restrictions that
    * Restrictive enough to "force" a model to consider context?
    * Permissive enough to allow the model flexibility in deciding *how* to
      consider context?
+ Enter the Transformer Architecture (i.e. "Attention is all you need")

# Our Final Goal

At the end of this we want to be able to explain at a high-level how we end up
with a model that takes in a bunch of text, and spits back what it thinks the
next word is. Note that we allow for the model to just keep generating text by
concatenating the word generated back into our input and then ask it to generate
the next word after that.

Three high-level steps:

+ Transform text into blobs of floats
+ Do a bunch of analysis on those blobs of floats. Gives us another set of blobs
  of float (We'll focus first on this because it affects the other two steps
  intimately)
+ Translate the output of that analysis to a probability distribution over all
  possible words of what the next word is. Choose the word with the highest
  probability.

# Transformer Architecture

+ Vanilla neural nets (MLPs) are made up of layers
+ Transformers are made of transformer blocks
    * In the simplest case they might just be stacked like neural net layers
      (this is the case with the GPT family of models)
    * Can be rearranged in somewhat more complicated ways
    * The original transformers paper showed just one particular way of stacking
      them
+ So we're going to focus mainly on understanding a single transformer block

# Transformer Block

Remember MLP is just a vanilla neural net.

```
----------------------------
|      Output              |
|        ^                 |
|        |                 |
|   Normalization <-----|  |
|        ^              |  |
|        |              |  |
|       MLP             |  |
|        ^              |  |
|        | -------------|  |
|        |                 |
|   Normalization <-----|  |
|        ^              |  |
|        |              |  |
| Multi-Head Attention  |  |
|        ^              |  |
|        |              |  |
|      Input -----------|  |
|                          |
----------------------------
```

# Idea At a High-Level

+ Use "attention" to encourage the model to take context into account
    * Attention mechanism promotes considering context
    * Keeping parameters of attention mechanism learnable by the model gives
      flexibility on _how_ to consider the context.
+ Feed the (normalized) sum of attention and input to the MLP
+ Then normalize sum 

# Attention

But what is "attention?"

+ Brief high-level intuition here: I want to "look up" the "context" that a word
  appears in.
+ E.g. when I search on Google to understand an unfamiliar word, I have the following mental model:
    - My word gets encoded into some sort of query
    - Every webpage has some lookup key associated with it
    - Google compares my query against every webpage's lookup key, the better the
      match the more importance/the higher weight it gets
    - Every webpage also some lookup value associated with it, and that lookup
      value is extracted and weighted it by how well the query matches the lookup
      key
    - Finally I merge all the lookup values with their associated weights into a
      single result page, using the weights to decide how to display the page
+ Note technically a transformer uses "multi-head attention," which really is
  just `n` copies of a single attention mechanism. We'll talk about it more in
the attention-specific presentation.

# Abstract Sequence of Attention Operations

Let's generalize what I just did with Google.

+ Have some element
+ Encode the element as a query
+ Generate lookup keys and lookup values
+ Compare query against every key to generate "lookup weights"
+ Use lookup weights to proportionally extract lookup values
+ Combine all lookup values using some sort of merge function to generate a
  single "context" for my element

# Turning Back to Attention Proper

+ Attention is the same basic idea
+ For every word in our sequence, assign it a "key," a "value," and a "query"
    - Note that we generate a query for every word in addition to a lookup
      key and lookup value because ultimately we want to generate context for
      every word in our sequence. If we only cared about the context of a single word
      we'd still need keys and values for every word, but only one query
+ For any given word, I want to be able to create a context vector for it
+ So I encode that word into its associated query
+ I compare my query against every word's key
+ I "extract" some proportional amount of every word's value based on how
  well my query compares against the key
+ Then I merge that all together into a single context vector
 
# Tracing Input to Output through a Architecture consisting of a Single Transformer Block

1. Start with list of `n` words
2. (Input to transformer block) Convert list of words to a `n` floating point
   vectors each of size `d_model`
3. (Finally enter the transformer block) Using Multi-Head Attention, create `n`
   floating point vectors each of size `d_model` again.
4. Normalize and sum attention output with input on a per vector basis, still have `n` vectors of size `d_model`
5. Pass normalized sum to MLP and get back another set of n vectors each of size
   `d_model`
6. Normalize and sum output of MLP with input to MLP to get back another set of
   n vectors of size `d_model`
7. Output final set of n vectors of size `d_model`
8. (Exit transformer block) Convert set of n vectors of size `d_model` to a
   `n` vectors of size `d_vocabulary`, i.e. the number of all possible words, this
   represents `n` probability distributions.
9. Take the last probability distribution, choose the word out of the
   `d_vocabulary` words that has the highest probability as the next word.

# Note About Element-Wise Operations

+ Attention is the only non-element-wise operation in a transformer block
    - And the only part about attention that is non-element-wise is the final
      merge operation to generate a single context value
        * N.B. an interesting experiment for people familiar with transformers
          to run: in theory if your merge operation is order-sensitive then you
          don't need positional encoding in your input! Can you replace
          positional encoding with a good merge operation?
+ Everything else operates on a per-element (i.e. per-word) basis
    * Attention Outputs are fed element-wise to the MLP (i.e. vanilla neural
      net) after attention
    * Normalization is performed element-wise (i.e. per-word)

# So How are Transformer Blocks Composed Together into a single Transformer?

+ Some popular models just stack them consecutively one after the other
    * The output of one transformer block is piped into another transformer
      block
    * These include the GPT family of models
+ Other models try to have slightly more complex ways of connecting transformer
  blocks
    * Won't cover those for now

# Hooking Up a Transformer to Real Words

+ Transformer blocks take in vectors of floats and return vectors of floats
    * This lets us stack blocks since they take in the same things and spit out
      the same things
+ But we want something that takes in text and spits out text
    * So once we're done stacking transformers, we want to wrap the whole thing
      in some sort of encoding-decoding layer to go from text to floats and back
+ How do we do that?

# Encoding Text to Vectors of Floats

+ Split text into "tokens" (roughly equal to words)
+ Assign numbers to tokens
    * Use a dictionary that maps every possible token to a number
+ We now have a number associated with each token, but this can cause trouble
  for a model when learning
    * "Dog" and "canine" are pretty much synonyms
    * But we probably encode "dog" and "canine" using completely different numbers
    * This can make it difficult for the model to learn that it should treat
      these two entities as almost the same thing and the model might learn
      spurious relationships that treat these very differently
+ So we add another layer called an "embedding"
    * This maps the number associated with a token to a vector of floats
    * Hope that this mapping maps things like "dog" and "canine" to be very
      close to each other
    * Can be done either through old-school statistical methods or by
      independently training another neural net to do the embedding (usually the
      latter these days)
+ So now we finally a bunch of vectors of floats, are we done?
+ No!

# Positional Encoding

+ Remember: almost everything in a transformer block operates in an
  element-wise/token-wise fashion
+ Only exception is the merge operation in attention
+ But the merge operation is usually commutative/order-independent!
+ So everything is either element-wise operations or commutative
    * _So transformer blocks have no way to incorporate the order in which tokens appear into their calculations!_
    * This is bad: "dog bites man" is different from "man bites dog"
+ Usual solution is to encode that information directly into the tokens
  themselves
+ This is called a *positional encoding*, where after embedding a token as a vector of floats, there is another operation that modifies the vector based on what the
  index of the token is in the input
+ Different choices of exact positional encodings that aren't terribly important to the core idea of transformers so we'll skip for now

# Encoding Text to Vectors of Floats Redux

So final encoding process from text to numbers is:

+ Split text into tokens
+ Assign each token a number from a global dictionary of all possible tokens
+ Use some pretrained embeddding to take each number and map it to a vector of
  floats
+ Use a positional encoding to take each vector of floats and modify them to
  take the index of where they appear in the input into account
+ Now we're finally ready to throw all this into some transformer blocks!

# Decoding Vectors of Floats Back to Text

+ What comes out of the transformer blocks is still vectors of floats
+ Now we need to transform those back to text
+ Remember that for LLMs generally the overall structure is
    + Input: A bunch of text
        - Covered by embedding + positional encoding then passing through
          transformer blocks
    + Output: Probability distribution over all known words of what the next
      word should be.
        - What we're trying to generate now
    + Glom the word with highest probability back to the input and then ask for
      the next word. Loop.

# Decoding Vectors of Floats Back to Text: Obstacles

+ First problem:
    * We feed `n` vectors of floats in, we get `n` vectors of floats out
    * How do we merge this down to single vector of floats to turn back into a
      single word?
        - We just throw away every single vector except the last one
        - Isn't this insanely wasteful? This waste is what enables the
          efficient training that propelled transformers to fame
+ Second problem:
    * How do we translate this single vector into to a distribution of
      probabilities over all words?
    * Stick another linear layer (i.e. an MLP/vanilla neural net with just one
      layer) to take in the vector and output a set of probabilities, one for
      each possible word/token.
+ Note that we actually usually implement this in the opposite order:
    * First map to a set of probability distributions
    * Then just choose the last probability distribution (not the last
      probability!)

# Putting It All Back Together

1. Start with an input text sequence consisting of `n` tokens
2. Convert that to `n` vectors of size `d_model` using some pretrained
   embedding (will use `n` x `d_model` as short-hand for this)
3. Add positional encoding: output is new set of `n` x `d_model` vectors
4. Pass into (multi-head) attention mechanism: output is new set of `n` x `d_model` vectors
5. Normalize the sum of input into attention and its output from the previous
   step: output is new set of `n` x `d_model` vectors
6. Pass vectors into MLP: output is new set of `n` x `d_model` vectors
7. Normalize the sum of input into MLP and its output from the previous step:
   output is new set of `n` x `d_model` vectors
8. Repeat steps 4-7 for as many transformer blocks as the model has: output is
   new set of `n` x `d_model` vectors
9. Pass into final linear layer: output is new set of `n` x `d_vocabulary`
   vectors (`d_vocabulary` is the number of possible distinct tokens)
10. Choose the last vector: output is `1` x `d_vocabulary` vector
11. Choose index of vector with highest scalar value: output is `1` scalar
12. Lookup that index using vocabulary dictionary back to a text token: output is a single new token

# As a Diagram

<img style="height: 800px;" src="./decode-only-transformer.svg"/>

# Context Window

We've heard of context windows for things like ChatGPT.

+ But might have noticed that nothing in theory limits the size of the input
+ So why do models have hard cut-offs for input size (context window sizes)?
+ Artificial limitation driven by empirical data
    - We notice that performance degrades very rapidly past the length of the
      longest sequences used in training (it looks almost like a cliff in
      performance drop-off)
    - Longer sequences quickly become more expensive in training (attention runs
      in quadratic time relative to sequence length)
    - So we draw a line in the sand and say "these are the longest sequences
      we'll use in training" and then that becomes a practical limit enforced by
      the API to prevent horrible breakdown in performance.

# Why Does Performance Drop Off a Cliff?

+ Look at the attention-specific presentation!
+ High-level intuition, the attention mechanism is tuned during training to only
  be able to "look back" as far as the longest sequences it's seen before
    * Remember although having an attention mechanism is how we encourage the
      model to use context, the exact weights that the model uses for attention
      change during training
+ This means that increasing context window size in practice *require
  re-training*
    * Need to re-tune attention and then re-tune all the cascading downstream
      effects of that
    * This is why it is a big deal when a model comes out with a new context
      size

# Why is Throwing Away Everything Except the Last Value Not Wasteful?

+ Remember that we throw away all vectors except the last one as one of our last
  steps in a transformer, at least during inference
+ When training, we don't. Instead we use all `n` outputs to drive loss and
  backpropagation, which we can do in parallel, because almost everything is
  done element-wise (and even the merge operation in attention is done once per
  every input token), greatly boosting efficiency
    - Can compare all `n` outputs at once against `n` expected outputs, instead
      of laboriously and sequentially generating one token at a time
    - But there's something missing here...
    - Can you see a problem with attention that might show up during training
      (but not during inference)?
    - I'll explain more in the attention-specific presentation

# Do Transformers Have to be Used for NLP?

+ No!
+ Many things can be solved with transformers
    * Image classification (Vision Transformer)
    * Image generation (Diffusion Transformer)
    * Speech Recognition (Speech-Transformer)
    * Etc.
+ But maybe in the end everything is just NLP...

