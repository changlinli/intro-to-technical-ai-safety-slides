## Matrix Rank

Let's start again with some exercises to review linear subspaces and matrices:

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

*Exercise*:

> Let's say you have a real-valued matrix of size $m \times n$. As a reminder
> this means that this corresponds to a linear function $f$ whose domain has
> dimension $n$ and codomain has dimension $m$. Can you come up with values for
> that matrix such that its rank is less than $m$ and no value is zero?

## Matrix computations

One of the most important parts of matrices is that they allow us to express more things as computation which can be easily carried out on a computer. We've already seen how we can treat matrices as lookup tables. Let's look again at $R^2$ with the standard basis vectors and review the exact sequence of steps we perform.

Given the matrix

```math
\begin{bmatrix} 0 & -1\\\ 1 & 0 \end{bmatrix}
```

and the vector

```math
(3, 2)
```

Keeping in mind again that $(3, 2) = 3 \cdot (1, 0) + 2 \cdot (0, 1)$ let's go again over the full sequence of how to compute the result.

1. $f((3, 2)) = 3\cdot f((1, 0)) + 2\cdot f((0, 1))$
2. $3\cdot f((1, 0)) + 2\cdot f((0, 1)) = 3\cdot(0\cdot (1, 0) + 1\cdot(0, 1)) + 2
   \cdot (-1 \cdot (1, 0) + 0 \cdot (0, 1))$
3. So our final result is $(0, 3) + (-2, 3) = (-2, 3)$

Let's focus some more on the second step there.

```math
3 \cdot (0\cdot (1, 0) + 1\cdot(0, 1)) + 2 \cdot (-1 \cdot (1, 0) + 0 \cdot (0, 1))
```

This is the same thing (by distributing the multiplication) as 

```math
3 \cdot 0 \cdot (1, 0) + 3 \cdot 1 \cdot (0, 1) + 2 \cdot -1 \cdot (1, 0) + 2 \cdot 0 \cdot (0, 1)
```

which in turn is the same thing (by rearranging some of the additive terms) as

```math
3 \cdot 0 \cdot (1, 0) + 2 \cdot -1 \cdot (1, 0) + 3 \cdot 1 \cdot (0, 1) + 2 \cdot 0 \cdot (0, 1)
```

Since we're using the standard basis here, this whole thing is equal to

```math
(3 \cdot 0 + 2 \cdot -1, 3 \cdot 1 + 2 \cdot 0)
```

So if we make sure that we keep the same set of basis vectors and those basis vectors happen to be the standard basis throughout our entire computation, we have a much more compact way of computing a linear function applied to a vector given its matrix.

Namely take each row of the matrix, do component-wise multiplication with the vector, then sum up that result and that's one component of the resulting vector. In our previuos example, we notice that $0$ and $-1$ are the first row of our matrix so we multiply by $3$ and $2$ respectively and add them together to the first component of our resulting vector and then we do the same for $1$ and $2$ as the second row of our matrix.

For people who have learned matrix multiplication rules this should look very familiar! It might not have been apparent back then why we do multiplication that way, but now we can see that this particular order of multiplication and summation falls out as an inevitable consequence of how matrices represent linear functions.

*Exercise*:

> Using the above ordering, compute the result of applying the function represented by the following matrix
>
> ```math
> \begin{bmatrix} 2 & 1 \\ -4 & 0 \end{bmatrix}
> ```
>
> to the vector $(2, 3)$.
>
> Now do the same for the function represented by 
>
> ```math
> \begin{bmatrix} 2 & 1 & 8 \\ 1 & -4 & 0 \end{bmatrix}
> ```
>
> to the vector $(1, 2, 3)$.
>
> We assume that we are in $R^n$ and using the standard
> basis vectors for our matrix.

For any people who remember matrix multiplication from school, there's still one operation we haven't yet justified, which is the multiplication of matrices themselves, rather than just a matrix and a vector.

So we'll start with a motivating question: *thought of as linear functions, what exactly is matrix multiplication?*

We can already get a hint from simplying thinking about the "type signature" of matrix multiplication what it might be. We take two matrices and get back another matrix. That means whatever matrix multiplication "really is," it's some operation that takes in two linear functions and gives you back another linear function.

That sounds a lot like function composition (as a reminder function composition takes in two functions $f(x)$ and $g(x)$ and gives you back a new function $h(x) = f(g(x))$)! But is it? (spoiler it is: but let's go and make sure that it is)






So it turns out that multiplying a matrix by a one-column matrix is exactly how we
can calculate applying a function to a vector!

In particular, now it makes sense why an $m \times n$ matrix can only be
multiplied with an $n \times 1$ column vector, and why the resulting column
matrix is $m \times 1$: an $m \times n$ matrix is a function from a vector space
of dimension $n$ to a codomain of dimension $m$. Therefore it can only take in
vectors of dimension $n$ as input and outputs vectors of dimension $m$.

As an aside, you may wonder what it means for a vector $v$ to be turned into a
one-column matrix. After all, aren't all matrices functions not vectors? Well
a one-column matrix is a function that goes from a vector space of one dimension
and just maps that single basis vector to a single linear combination of $n$
bsais vectors in the codomain, i.e. just maps a single basis vector to $v$ in
the codomain.

This function can be identified, i.e. thought of, as just a vector.

This is similar to how in programming, we can write

```
x : Int
x = 5
```

but we could also write

```
f : () -> Int
f(()) = 5
```

and these are basically the same thing, just up to an extraneous function
application!

But this then brings us to another question: what exactly is matrix
multiplication? Well let's say we're given the matrix $M_0$ for some function
$f_0 : V_0 -> V_1$ and another matrix $M_1$ for some other function $f_1 : V_1
-> V_2$.

Let's let $v_0$ be a vector in $V_0$. Then applying $f_1(f_0(v_0))$ would look
like multiplying $v_0$ (as a one column matrix) by $M_0$ and then $M_1$. That is 
$f_1(f_0(v_0))$ can be represented by $M_1 \times (M_0 \times v_0)$.

So then a fairly natural question arises. Instead of writing $f_1(f_0(v_0))$, we
could also write this as function composition, i.e. $(f_1 \circ f_0)(v_0)$. Can
we do the same thing for $M_1 \times (M_0 \times v_0)$? The answer is yes! We
can re-associate the parentheses!

That means that matrix multiplication is just the same thing as function
composition!

*Exercise*:

> Let's work out an example of this by hand. Again we'll assume all domains and
> codomains of all functions are $R^2$ with the standard basis vectors. Let's
> let $M_0$ be 
> ```math
> \begin{bmatrix} 0 & -1\\\ 1 & 0 \end{bmatrix}
> ```
> and let $M_1$ be
> ```math
> \begin{bmatrix} -1 & 0\\\ 0 & -1 \end{bmatrix}
> ```
>
> 1. What does $M_1$ mean as a function?
> 2. Calculate what $f_1(f_0(v_0))$ is where $v_0 = (3, 2)$ by the usual trick
>    of thinking of matrices as lookup tables. You will need to do this twice,
>    once for $M_0$ and once for $M_1$.
> 3. Do the usual matrix multiplication of multiplying rows by columns and
>    adding them together and multiply $M_1 \times M_0$. Now do the same lookup
>    trick, but now you should only do it once.
> 4. You should observe the same answer. What is it?

From thinking of matrices as functions, we observe all sorts of properties

1. Matrix dimensions must agree for matrix multiplication to make sense, i.e. a
   $a \times b$ dimensional matrix can only be multiplied with a $b \times c$
   dimensional matrix.
2. Matrix multiplication is not commutative.

*Exercise*:

> Prove each of these properties by thinking of these matrices as functions.

Let's remind ourselves again that matrices don't have to just represent linear
functions from $R^n \to R^m$. As an optional exercise, we can generate a matrix
that works with polynomials.

<details>
<summary>Optional Exercise</summary>
Let's look at an example of an even more general function. In particular,
differentiation itself can be thought of as a function. If we restrict ourselves
to polynomials, then differentiation can be viewed as a function that takes in
one polynomial and generates another. It takes in a polynomial of the form

```math
a_n x^n + a_{n - 1} x^{n - 1} + \cdots + a_0
```

and returns a polynomial of the form

```math
n a_n x^{n - 1} + (n - 1) a_{n - 1} x^{n - 2} + \cdots + 0
```
.

Show that there is a way to view the collection of all polynomials as a vector
space and a way to view differentiation as a linear operator. What are the
vector addition and scalar multiplication operators? Using that can you show
that differentiation obeys the linear laws for vector addition and scalar
multiplication?

Let's restrict our attention to only those polynomials which have degree less
than or equal to 4. That is only polynomials of the form

```math
a_4 x^4 + a_3 x^3 + a_2 x^2 + a_1 x + a_0
```

Come up with a basis for the vector space of all polynomials with degree less
than or equal to four. Using that basis create a matrix that represents
differentiation of a polynomial with degree less than or equal to four.

Is differentiation in general a linear operator? Why or why not? Is it always
possible to create a matrix for it? Why or why not?
</details>

## Inner Products

We've now covered matrices, 

But for understanding, say the transformer architecture, one other thing that is
important will be the notion of inner products.

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

> Let's say we have a vector $v$ in a vector space equipped with an inner
> product. Among all the vectors $w$ that have the same length, i.e. $\lVert w
> \rVert = \lVert v \rVert$, which vector produces the greatest inner product?
> 
> Let's narrow our focus to vectors in $R^2$ with the inner product as the dot
> product. For the vector $(1, 1)$, which vectors of the same length create the
> largest inner product with it? The smallest inner product? An inner product of
> zero?

The previous exercise demonstrates how inner products capture a notion of
similarity. The larger the inner product is between two vectors, the more
similar they are!

And you're done!
