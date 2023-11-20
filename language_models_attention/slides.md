% Language Models

# What is a Language Model

+ Abstractly: A machine learning model that works with natural language text
+ More concretely: A neural net (or arrangement of neural nets) that takes in text
  and spits out either more text or embedding
+ For a lot of this presentation we're going to focus in on one use case: natural language translation

# Caveat

+ I'm shakier about some of these concepts
+ I believe I understand the fundamentals, but I still haven't implemented this
  from scratch in code yet!
+ We're going to be stacking a lot of things on top of each other
    * It's totally okay (and expected!) that a lot of this won't stick (didn't
      for me the first time!)
    * Think of it as "pre-soaking" your brain so that you can consume more
      material about this if you're interested further
    * We'll mainly be focusing on "attention" today

# Brief recap of neural nets

!["Neural net visualization"](./neural_net.svg)

# Brief recap of neural nets (more)

+ Individually simple neurons connected via layers
+ Weights and biases are changed in training
    * Number of neurons and layer structures do not change in training
+ Theoretically universal
    * In practice often learns spurious relationships without more safeguards
    * Architectures provide these safeguards and are therefore subtractive not
      additive
+ Calculating with weights and biases can be rewritten as matrix multiplication
  and addition
    * Every layer-to-layer connection of weights can be interpreted as a matrix of size n x m
        - n is the size of the previous layer and m is the size of the next layer
        - Entries in matrices are connection weights between two neurons
        - Passing the outputs of one layer as the inputs to the next is
          multiplication of those inputs by the matrix
    * Every set of biases of a layer of neurons can be interpeted as a matrix (with a single column)
        - Each neuron in the layer has one bias entry in the matrix

# Questions about basic neural nets?

+ Pause for questions (we're going to keep stacking matrices!)

# The Problem of Memory and Reference

+ "The car was driving too quickly through the field. *It* crashed into a tree."
+ "La voiture roulait trop vite dans le champ. *Elle* s'est écrasé contre un arbre."
+ How do we correctly translate *it* (should be "elle" not "il")?
    * How can the model learn that "it" refers to "car" not "field?"

# Vanilla Neural Nets

+ In theory a vanilla neural net should be able to learn how to do this
    * After all neural nets are universal
+ In practice it's almost impossible to get it to work
    * Almost always learns spurious relationships
    * We need to be able to "coax" it, i.e. add a variety of guardrails
    * Hence new architectures combining neural nets in predefined ways that
      cannot be modified by training

# Historical approaches

+ LSTM (long short-term memory)
+ RNN (recurrent neural nets)
+ No longer as popular as *transformers*
    * So I haven't studied them much and can tell you very little about them...

# Transformers

+ "Attention is all you need" (2017)
    * Previous approaches had tried to combine attention with other mechanisms
    * This discards everything except attention

# Overview of a transformer

+ Encoder-decoder architecture (not transformer specific)
+ Text encoding (not transformer specific)
+ Attention (not transformer specific, but only using attention without other
  mechanisms is!)

!["Transformers Architecture"](./transformer_arch.webp)

# Encoder + decoder

+ Have one neural net (or set of nets) that outputs some abstract representation
  of text
+ Have another neural net (or set of nets) decode that abstract representation
  back to natural language

# Attention

+ Inspired by the idea of human attention
+ Trying to prod the model towards learning a notion of "attention"
+ When translating a single word you're thinking about others things in "context"

# Attention as a DB query

+ I have a database with keys and values. Keys are chosen to play nicer with
  queries, values are what I actually return in the data.
+ `[("Alice", "some data about Alice"), ("Bob", "some data about Bob")]`
+ Query "Get me data about keys/names that start with 'A'"
+ Match query against key

# Abstract steps of DB query

+ Split data into keys and values
+ Generate a query
+ Compare queries with keys
+ Use comparison to select which values to return

# What about a "fuzzy" DB query?

+ Split data into keys and values
+ Generate a query
+ Instead of binary comparison, yes/no, do a fuzzy match score between 0 and 1
+ Multiply each value by the fuzzy match and combine them all together to return
  a "fuzzy" match
+ This degenerates to a normal DB query if we just constrain the fuzziness to
  either 0 or 1

# Equivalents in attention

+ Generate a key and value vector from a given word
+ Generate a query vector from the word
+ Dot product the query vector against the key vector to generate weights
+ Multiply each value vector by the weights

# Generating the key, value, and query vectors

+ We have matrices for each key, value, and query
    * $W_k$, $W_v$, and $W_q$
+ These matrix values are learned during training

# Working through a specific example

+ "The car was driving too quickly through the field. *It* crashed into a tree."
+ Look at a single given word "it", which has some vector form after embedding
+ Multiply *every word*'s embedding by $W_k$ to generate key vectors for all of
  them
+ Multiply *every word*'s embedding by $W_v$ to generate value vectors for all
  of them
+ Multiply "it" embedding by $W_q$ to generate a single query vector
+ Dot product query vector against every key vector to get weights against every
  value
+ Multiply every value by weight and add them altogether to the final attention
  result
+ ![Attention weight visualization](attention_example.png)

# Why Multi-Head Attention?

+ Empirical tuning (like so much of ML!)
+ The entirety of the reasoning in the original paper: "We found it beneficial"
  [the original paper](https://arxiv.org/pdf/1706.03762.pdf)


# Stacking attention on top of attention

+ Keep stacking attention matrices on top of rounds of merging multiple
  attention streams
+ Query, key, value intuition kind of falls apart
    * What is attention "*really*"?
    * At the end of the day a particular set of guardrails on neural nets that
      seems to make models good at language
    * Again no reason in theory why a sufficiently large single neural net
      couldn't subsume the idea of attention
        - It just doesn't happen in practice
        - Too many spurious relationships
        - The guardrails provided by attention cut down on spurious
          relationships (i.e. subtractive, not additive new capabilities)

# Position matters!

+ Notice that nothing about attention

# Following the life of a input through a transformer

+ Input: "I like dogs."
+ Tokenization: `[2349, 9, 23]`
+ After embedding + positional encoding: `[[0.2, ..., 0.9], [0.1, ..., ]]`

# Transformers in the wild

+ Many models only use one half of the transformer
+ E.g. BERT only uses the encoder half of the transformer
    * So BERT ultimately ends with a set of encodings, *not* natural language
      output!
+ GPT uses only the decoder half of the transformer (which is a input = text,
  output = input + more stuff model)
