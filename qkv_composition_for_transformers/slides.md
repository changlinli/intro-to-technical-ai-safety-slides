# Circuits in transformers

+ Traditionally transformers are presented "horizontally"
    * Layer by layer
+ Interpretability seems predicated on "vertical" paths through a transformer

# Restructuring an attention head

+ Attention heads nominally have four sets of parameters
    * $Q$ (query) matrix
    * $K$ (keys) matrix
    * $V$ (values) matrix
    * $O$ (output) matrix
+ Can regroup as fundamentally just two matrices
    * $Q^T K$: The "QK circuit"
    * $OV$: The "OV circuit"
    * This is inefficient in execution (exercise: why?) but easier for analysis
        - Reason inefficient is because $Q^T K$ and $OV$ will usually be
          low-rank matrices if `d_head` < `d_model`
+ Why can't we go one step further and regroup as just one matrix?
    * Nonlinear softmax in the middle

# QK circuit

+ Think of it as a function of two arguments
    * First argument is the "query" (i.e. residual stream of current token position)
    * Second argument is the "key" (i.e. residual stream of some other token position in the
      context window)
+ Number it outputs is the attention that a given query should pay to the key
  (pre-softmax)

# OV circuit

+ Think of it as a function of one argument that is "map-reduce"-ed
    * Is mapped over the residual stream of all token positions if bidirectional
      attention
    * Is mapped over the residual stream of all previous token positions if
      causal attention
    * Then combine together all the function outputs, scaling by the attention
      scores computed by the QK circuit

# Thinking of transformers via programming

+ A model for a rough approximation of an attention head that allows for easier
  mental models than opaque matrices
    * This rough approximation is sufficient to establish a lower bound on how
      many layers of attention some particular behavior requires
+ Starting tokens (assume one token per word): "These are some words"
+ Start with array of tuples going into attention head: `[("These", 0), ("are", 1), ("some", 2), ("words", 3)]`
+ Then QK circuit is approximately a function that takes two tuples and
  returns a boolean of whether to "pay attention"
+ Then OV circuit is a approximately a per-tuple function applied if QK circuit
  returns true.
+ Output of attention head is summed output of the OV circuit (where QK circuit is
  true) concatenated to every tuple; concat `null` if QK is false for all tokens
    * Can decide to overwrite instead of concat

# Using programming model to give informal QK and OV descriptions

+ Here's a first attention head working again on "These are some words"
    * `[("These", 0), ("are", 1), ("some", 2), ("words", 3)]`
+ Might say informally that a QK circuit "looks at previous word"
    * `f((x_query, i_query), (x_key, i_key)) = i_query - 1 == i_key`
+ Might say informally that an OV circuit "copies the token"
    * `f((x, i)) = x`
+ What does this attention head output? (Let's go token by token)
    * `[("These", 0, null), ("are", 1, "These"), ("some", 2, "are"), ("words", 3, "some")]`
    * This attention head "outputs the previous token"
+ Now our next attention layer gets access to 3-tuples instead of 2-tuples

# Limitations of attention

+ Attention can only ever do pair-wise comparisons in QK and element-wise
  functions in OV
+ So there are many more complicated tasks that require multiple layers of
  attention that use the information concated to the residual stream from
  previous layers
+ E.g. induction heads: "x y ... x [y]"

# Failing to implement induction heads with one layer of attention

+ Induction head: "x y ... x [y]"
+ So if you have "x w b p a x w b p ", we should guess "a" as the next token
+ Called "induction" head because this is a basic form of induction: "I've seen
  y follow x so the next time I see x I should predict y"
+ But if I'm at the second occurence of `x`, one pair-wise comparison isn't
  enough to identify `y`! (Go over this in more detail)

# Implementing induction heads with two layers of attention

+ Use "copy previous token" attention head
+ Combine wih "copy if equal" attention head
    * QK: `f((x_query, i_query, y_query), (x_key, i_key, y_key)) = x_query == y_key`
    * OV: `f((x, i, y)) = y`
    * Let this layer overwrite instead of concatenating
+ Start with `[("a", 0), ("b", 1), ("c", 2), ("a", 3)]`
+ Then get `[("a", 0, null), ("b", 1, "a"), ("c", 2, "b"), ("a", 3, "c")]`
+ Finally `[null, null, null, "b"]`
+ Notice that our QK circuit used an additional piece of information in the key
  (`y_key`) that was placed there by our first attention head
    * This is an example of key-composition (K-composition)

# More examples

+ Check your understanding: can a single layer of (bidirectional) attention implement
    * Shift by 1 (hint: we implemented this one)? Given `a b c d <stop>` output `b c d <stop> *` (where `*` is "whatever")
        - Yes! We just implemented this above
    * Shift by n? Given `a b c d n <stop>` output `c d <stop> * *` if `n` is 2
        - No! One layer of pair-wise attention can't take into account both `n`
          and two other tokens. Need one layer of attention to identify and pull `n` into the
          residual stream at every location and then another layer to do the
          necessary selection.
    * Token reversal for exactly four tokens? Given tokens `a b c d <stop>` output `d c b a <stop>`
        - Yes!
    * Token reversal for arbitrary long token sequences?
        - No!

# Vertical composition of two attention heads

+ Since real world transformers have multiple layers of attention, we care about
  how they interact with each other
+ We'll focus on pairs of attention layers
+ Three main mechanisms (that can happpen either in isolation or simultaneously)
  for how pairs of attention layers can interact
    * Query composition: Q-composition
    * Key composition: K-composition
    * Value composition: V-composition

# Q-composition

+ Q-composition: composition via queries
+ An earlier attention head puts information in the residual stream that the QK
  circuit in a later attention head uses in its query argument (i.e. its first argument)

# K-composition

+ K-composition: composition via keys
+ An earlier attention head puts information in the residual stream that the QK
  circuit in a later attention head uses in its key argument (i.e. its second argument)

# V-composition

+ V-compositon: composition via values
+ An earlier attention head puts information in the residual stream that the OV
  circuit

# Examples

+ An attention head that copies the previous element can combine with an
  attention head that copies if a query and key are equal to each other to form
  an induction head via K-composition
+ An attention head that copies the index of a key if it is equal to the query
  can combine with a head that copies the key if the index of a key is equal to the
  index + 1 of the query can form an induction head via Q-composition
+ Two attention heads each of which copies the previous element can combine via
  V-composition to form an attention head that copies an element two positions
  back

