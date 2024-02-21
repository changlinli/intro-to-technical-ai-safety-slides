So based on what we've said so far about matrices, one way to think about them
is that they are essentially lookup tables.

For example, the matrix 

```math
\begin{bmatrix} 0 & -1\\\ 1 & 0 \end{bmatrix}
```

(given the basis vectors $(1, 0)$ and $(0, 1)$ for both the domain and codomain
of the function) ultimately represents

| (1, 0) | (0, 1) |
| ------ | ------ |
| $0 \cdot (1, 0)$ | $-1 \cdot (1, 0)$ |
| $1 \cdot (0, 1)$ | $0 \cdot (0, 1)$ |

which means that we can think of the columns and rows of the matrices as being
associated with different basis vectors, where we read off what what the
underlying function $f$ does by going down each column of a matrix:

|        | (1, 0) | (0, 1) |
| ------ | ------ | ------ |
| (1, 0) | 0 | -1 |
| (0, 1) | 1 | 0 |

means $f : (1, 0) \mapsto 0 \cdot (1, 0) + 1 \cdot (0, 1)$ (just reading down
the first column) and $f : (0, 1) \mapsto -1 \cdot (1, 0) + 0 \cdot (0, 1)$
(just reading down the second column).

Likewise for another $f$ where $f : R^2 \to R^3$, the following matrix

```math
\begin{bmatrix} 0 & -1 \\\ 1 & 0 \\\ 1 & 0 \end{bmatrix}
```

Note that the number of columns of the matrix always correspond to the dimension
of the domain and the number of rows to the dimension of the codomain, since we
have as many columns as we have basis vectors in the domain and as many rows as
we have basis vectors in the codomain.

Remember, however, that the range of a function does not have to be equal to its
codomain. In particular the range of a function is a linear subspace of its
codomain and a linear subspace can have a dimension!

*Exercise*:

> Take the vector space $R^2$ and the subspace that consists of the set of all
> vectors $(x, y)$ such that $x$ and $y$ are equal to each other.
>
> Can you come up with a set of basis vectors for that subspace, i.e. a set of
> vectors within that subspace ? How large is that set?

*Exercise*:

> Let's take another look at another $3 \times 2$ matrix. As is usual we'll
> assume that we are working with $R^2$ and $R^3$ and that are bases are the
> standard basis vectors.
>
> ```math
> \begin{bmatrix} 0 & 1 \\\ 1 & 0 \\\ 1 & 0 \end{bmatrix}
> ```
> As we can see from the 3 rows of the matrix, the codomain of this function has a
> dimension of three. What is the dimension of the range of this function? That
> is how many elements form a basis of its range?

In general it turns out that the dimension of the range of a function cannot
exceed the dimension of its domain.

<details>
<summary>Optional Exercise</summary>
Prove this.
</details>

So for example, we know that the dimension of the range of a function
represented by a $3 \times 2$ matrix cannot be equal to the dimension of its
codomain.

However, even for a square matrix, the dimension of the range of its associated
function may not be equal to its codomain.

*Exercise*:

> Let's look at the following $3 \times 3$ matrix for $R^3$ with the standard
> basis vectors:
>
> ```math
> \begin{bmatrix} 1 & 1 & 1 \\\ 1 & 1 & 1 \\\ 1 & 1 & 1 \end{bmatrix}
> ```
>
> What is the range of this function? What is the dimension of its range?

It turns out it is often useful to know what the dimension of the range is of
the function that a matrix represents. It is useful enough that it has its own
name, the rank of a matrix. A matrix is considered "low-rank" if its rank is
less than the number of rows it has, that is the range of the associated
function is smaller than the codomain of the associated function.

Let's take what we've defined so far and do some more calculations with them in
$R^n$ with the standard basis vectors.

Given the vector 

A column vector

This is similar to how in theory in a programming language with

You can represent 

Now we understand how to use matrices to perform

*Exercise*:

> If $f$ and $g$ are linear functions represented by the matrices $M_f$ and
> $M_g$, then their product $M_f M_g$ is also a matrix, which means that it must
> correspond to a linear function. What is that linear function?

*Exercise*:

> Let's say you have a real-valued matrix of size $m \times n$. As a reminder
> this means that this corresponds to a linear function $f$ whose domain has
> dimension $n$ and codomain has dimension $m$. Can you come up with values for
> that matrix such that its rank is less than $m$ and no value is zero?



## Inner Products

We've now covered matrices, 

But for understanding, say the transformer architecture, one other thing that is
important will be the notion of inner products.

To motivate the idea of an inner product, let's first return to the idea of
vectors again. We've define vectors abstractly so far, 

It's often useful 

Inner products arise from a realization that every day concepts of "length,"
"angle," and "similarity" on vectors are not independent concepts, but in fact
very tightly bound together.

Let's illustrate this by thinking of $R^n$ with the usual vector addition and
scalar multiplication operators not as points, but as arrows starting at the
origin and extending out to a given point. Then vector addition can be thought
of putting one arrow at the tip of another and drawing a new arrow that goes
from the origin to the tip of the last arrow. This is illustrated below for
$R^2$:

![Vector addition as arrows](./Vector_sum.svg "Vector addition as arrows")

*Exercise*:

> Convince yourself and your partner/group that this is the same thing as the
> usual vector addition operation on $R^n$.

Thought of as arrows, vectors in $R^n$ definitely seem to have a physical
length. However, it's worth noticing that if I have two arrows $x$
and $y$ and I tell you what their lengths are, that alone is not sufficient
information to determine what the length of $x + y$, we need to know the angle
between the two arrow.

Likewise if two arrows are graphically very similar, then we would expect their
length and angle considered relative to some reference arrow (say an arrow that
corresponds to a basis vector), to also be quite similar.

This heavily suggests that our intuitions of "length," "angle," and "vector
similarity" are all connected together. An inner product then is trying to
capitalize on that by defining one notion from which we can derive each of these
three concepts, to try to capture the single underlying intuition behind all
three things.

Let's move on to a more formal definition of inner products. Inner products are
functions defined on a vector space that take in two vectors and return a
scalar. For vectors $v$ and $w$, they are usually denoted by angle brackets like
so: $\langle v, w \rangle$.

Hence for the real vector spaces we mainly care about in ML, inner products are
functions that take a vector and return a real number, so I'm going to provide a
definition of inner products specialized for real number scalars. Other scalars
may require minor tweaks to this definition.

1. Symmetry: $\langle v, w \rangle = \langle w, v \rangle$
2. Linearity (that is distribution over addition vector addition and scalar
   multiplication) in the first argument: $\langle k_0 v_0 + k_1 v_1, w \rangle = k_0 \langle v_0, w \rangle + k_1 \langle v_1, w \rangle$.
3. Positive-definite (i.e. positive for non-zero vectors): If $v$ is not the
   zero vector, $\langle v, v \rangle > 0$.

*Exercise*:

> We've only required linearity for the first argument of an inner product, but
> in fact an inner product is also linear in its second argument. That is
> $\langle v, k_0 w_0 + k_1 w_1 \rangle = k_0 \langle v, w_0 \rangle + k_1
> \langle v, w_1 \rangle$. Prove this.

<details>
<summary>Hint</summary>
Use symmetry.
</details>

This definition may seem a bit bizarre and abstract at first, but its power lies
mainly in being able to unify "length," "angle," and "similarity" as we
described earlier.

From this we can define we can define the length of a vector $v$ in a vector space
equipped with an inner product to be the inner product with itself $\langle v, v
\rangle$. This is also often denoted as $\lVert v \rVert$.

We can then use this to define a notion of angle $\theta$ (we use cosine here
because this notion of angle comes from thinking of the triangle when we add
arrows together tip to tail) between two vectors $v$ and $w$.

```math
\text{cos}(\theta) = \frac{\langle v, w \rangle}{\lVert v \rVert \lVert w \rVert}
```

Just like how there is a standard basis for $R^n$, if we decide to equip $R^n$
with an inner product, there is a standard choice there too, namely the dot
product. We sometimes denote the dot product specifically by $v \cdot w$ and
sometimes by $\langle v, w \rangle$ when we want to make clear that the dot
product is only one particular example of an inner product and there are other
potential examples.

For $(v_0, \ldots, v_n), (w_0, \ldots, w_n)$ in $R^n$ with the usual vector addition and scalar multiplication, we
define the dot product as

```math
(v_0, \ldots, v_n) \cdot (w_0, \ldots, w_n) = v_0w_0 + \cdots + v_nw_n
```

*Exercise*:

> Can you come up with an example of an inner product that is not the dot
> product? One way of doing this is to not use $R^n$ as your vector space.

Again I want to emphasize here is that inner products are *optional* additions
to a vector space. A vector space does not need to have an inner product. The
same vector space could have multiple different kinds of inner products that you
define for it. All the stuff we've done with linear functions and matrices have
not required


*Exercise*:

> Which vector


*Exercise*:

> Let's compute the 

Here are some final exercises to make sure that you understand the material.
These exercises will cover stuff that you've already answered, so don't be
worried 

*Exercise*:

> Why is matrix multiplication defined in the order it is? Can you derive its
> arithmetic purely from 
