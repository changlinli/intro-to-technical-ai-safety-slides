# Layer-by-layer is not great

+ Problems with the logit lens approach
+ Privileges impact of later layers
+ Much harder to see impact of earlier layers
+ If I tell you a given layer accounts for 99% of the final distribution and all
  other heads only account for 1% in total, still not convincing explanation
  that that layer is the only responsible element
    * Could be that layers previous to that head were responsible and that final
      head is only an extremely simple passthrough/aggregation

# Transformers involve a lot of sums!

+ Multi-head attention is the just the sum of multiple attention heads
+ Attention layer and MLP just sum back into residual stream
+ One of the most important things that the mathematical framework for
  transformers does is rewrite everything as sums

# Rewriting things as sums

+ Residual streams as the 
+ Rewriting multi-head attention as the sum of 

# End-to-end sum decomposition of a single MLP

+ $f(x^T W^{in}) W^{out} = \sum_{i=1}^{d_{mlp}} f(x^T W^{in} _{\left[ :, i \right]}) W_{\left[ i, : \right]} ^{out}$
+ Left-hand side of the equation munges together things on a per-layer basis
+ Right-hand side of the equation allows us to split vertically into key vectors
  and value vectors
    * Dot product a key vector with an input vector and get back a similarity
      score (that is passed to an activation function)
    * Write out a value vector scaled by the activation amount
+ Can identify individual "neurons"

# Fun fact about MLPs

+ That talk about "keys" and "vectors" seems mighty suggestive!
+ In fact you can (more or less) completely implement transformers purely via
  attention and use attention to emulate the MLPs
    * This creates an explosion in the number of attention heads though
    * Unclear to me how much leverage this gives, will need to think more
+ https://arxiv.org/pdf/2309.08593.pdf
+ Note that other direction is not true: cannot use a series of MLPs to emulate
  attention
    * At least not without letting the MLP look at the entire input stream of
      tokens
    * Remember that MLPs work on a per-token basis

# Getting end-to-end explanations

+ Sums + linear functions give us end-to-end explanations
+ Each individual "thread" of an end-to-end

# End-to-end has more convincing explanations

+ Let's say that a single end-to-end path accounts for 99% of the final
  distribution and the remaining paths only sum to 1% of the final distribution
  and each individually don't exceed 0.1% of the final distribution
+ Much more convincing to say that that end-to-end path is almost entirely
  responsible for our distribution than a given layer
+ These end-to-end paths are often called "full circuits" (as opposed to just
  normal circuits which may not be end-to-end)

# One version of a holy grail

+ Build out a human-understandable and searchable catalog of these paths
+ Turns out all interesting behavior is some combination of these paths
+ A comprehensive manual of all of these things
+ The universality hypothesis: the same paths/patterns will show up in different
  models and perhaps even architectures

# The Power of Linearity

+ Let's zoom out from the matrices
+ Let's say I want to answer the question "how much of my attention is based off
  of the position of a token and how much is based off the token's contents"
+ This is hard


+ We have two linear functions, $Q$ and $K$.
+ $\langle Q(x), K(y) \rangle = \langle x, Q^T(K(y))$



+ $\langle Q(x + x_p), K(y + y_p) \rangle = $

# Decomposing Parts of the Transformer



# Understanding the QK-circuit

+ The QK-circuit is a function from $d_{model} \to d_{model}$.

# Refresher on matrices

+ All tied to linearity
+ Thinking of them as bilinear forms (attention)
+ Thinking of them as linear functions


# Circuit Advantages

+ No need to look at individual points
+ Can talk about how things decompose
+ Can think about what's truly "fundamental" in a transformer


# QK Circuit is more "fundamental" than Q or K alone

+ There are multiple different values for Q and K that would result in
  *absolutely no* change to the transformer behavior.
+ Just have to make sure that $Q^TK$ does not change
+ Hint that $Q$ and $K$ are in some sense "implementation details"

# OV Circuit is more "fundamental" than O or V alone

+ There are multiple different values for O and V that would result in
  *absolutely no* change to the transformer behavior.
+ Just have to make sure that $OV$ does not change.
+ Hint that $O$ and $V$ are in some sense "implementation details"

# Decomposing Transformers




+ Why fixing an attention pattern A means that we've "cut off" the rest of the
  elements of the computation graph


# Thinking of linear functions as bilinear functions

+ For any linear function $f: R^n \to R^n$, we can think of it
  as a bilinear function $g : (R^n, R^n) \to R$ via the dot product:
  $g(x, y) = \langle x, f(y) \rangle$
+ E.g. an $n \times n$ matrix can either be thought of as something that
  multiplying by a column vector gives another column vector, which you can dot
  with another column vector to give a single number, or as something that you
  multiply with a column vector and row vector at the same time
+ Bilinear function:
    * $f(ax, y) = f(x, ay) = af(x, y)$
    * $f(x + y, z) = f(x, z) + f(y, z)$
    * $f(x, y + z) = f(x, y) + f(x, z)$

# Thinking of it as matrices

```
[ 1 2 3    [1     same as   [ 1 2 3    [1      and then multiply/dot by [ 1 2 3 ]
  4 5 6     2                 4 5 6     2
  7 8 9 ]   3]                7 8 9 ]   3]

[ 1 2 3 ]
```

# Decomposing Attention Heads

+ Attention head is fully determined by four linear functions: $Q$, $K$, $V$,
  and $O$.
+ But this description is not a unique identifier (in the same way that
  $\frac{1}{2}$, $\frac{2}{4}$, etc. all refer to the same number, there are
  combinations of different $Q$ and $K$ and $V$ and $O$ that result in the exact
  same attention head).
+ So we can rewrite things in a more minimal way: attention head is fully
  determined by two linear functions: $f_{Q^TK}$ and $g_{OV}$ (we'll just call
  them $QK$ and $OV$ for simplicity)

# Understanding 

# Checking for things involving the compositon of attention head mechanisms

+ We need to check for the 


# Verifying the composition of attention heads

+ Remember, two functions were enough to fully determine a single attention head
+ Let's say I come up with a specification of an attention head by specifying
  the behavior of $OV$ and $QK$:
    * E.g. an attention head is a "previous-token head" if $OV$ is similar to
      the identity matrix and $\langle pos_{n}, QK(pos_{n - 1}) \rangle$ is high 
+ So if you give me an arbitrary attention head, I just need to calculate $OV$
  and $QK$ and verify whether it has those behaviors to call this a
  "previous-token head"
+ How many functions are required to fully determine the composition of two
  attention heads in a transformer
    * $QK^0$, $OV^1$, $QK^1 \circ OV^0$, and $OV^0^T \circ QK^1$, $OV^0 \circ QK^1
      \circ OV^0$
    * Attention that 


$C^1(x_k) = W_E^TW^h_{QK}W_E(x) + \sum _{i < k} $


# The power of OV

    


# What does it mean to find a circuit in a transformer?
