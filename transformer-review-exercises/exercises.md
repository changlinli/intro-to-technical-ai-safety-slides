# A few warmup questions

Let's first review some questions for 

*Exercise*:

> Exercise: Why do we need a positional embedding for our tokens in a
> transformer?

*Exercise*:

> What pros and cons can you think of when it comes to using RoPE, a
> learned positional embedding, or the original 

*Exercise*: 

> Why does a decoder-only, one layer transformer require causal masking during
> training, but not during inference?

# Main coding exercise

Build a single attention head (consisting of the usual query, key, value, and
output matrices) in PyTorch and use it to perform an extremely simple task.

Given four one-hot encoded values, i.e. `[1, 0, 0, 0]`, `[0, 1, 0, 0]`, `[0, 0,
1, 0]`, and `[0, 0, 0, 1]`, we want to train an attention head to create a "skip
trigram."

In particular, given an input sequence of consisting of `n` one-hot encoded
vectors where `n` is greater than or equal to 2, if there is exactly one vector in the
sequence equal to the  last vector (and not the last vector itself), then the
attention head should output `[0, 0, 0, 1]`. If there are no vectors equal to
the last vector, the attention head should output the zero vector.

So for example, given the following sequence

> [[1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 1, 0], [1, 0, 0, 0]]

we should get back (when calculating the output of the attention head at index
3)

> [0, 0, 0, 1]

or if we were to run the attention head (with a causal mask) over the entire
sequence, we should get as outputs

> [whatever_you_want, [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 1]]

where the output of the attention head when you have only a single vector can be
whatever you'd like it to be. Likewise, if there is more than vector that is
equal to the last vector, you can output whatever you'd like.

You can set the internal dimensions of your attention head matrices to whatever
you want, subject only to the restriction that the attention head should take in
vectors of size 4 and also output vectors of size 4.

This is a simple enough task that I would recommend hand-coding what the values
of the query, key, value, and output matrix could be to fulfill the task.
Otherwise, you can also train this attention head using standard gradient
descent.


