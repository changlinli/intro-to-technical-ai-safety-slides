Linear algebra, as the name suggests, is the study of linear functions.

One motivation for vector spaces arises from an intuition that in our world
both addition and multiplication play very central roles. However, it often
seems a lot easier to define how to add things together than it is to define how
to multiply things together.

Let's take colors for example. It seems pretty simple to define what it means to
"add" two colors together: just mix them together! But it's a lot trickier to
define what it means to "multiply" two colors together.

However, there is a restricted form of multiplication that seems much easier to
define in more cases, and that is multiplication by a constant, i.e. scaling a
value. While it seems a bit difficult to understand what it means to "directly
multiply two colors together," saying that I'm "adding 2.0 units of red and 0.9
units of blue" seems a lot easier to understand. There we have a restricted form
of multiplication in the form of "scaling red by 2.0 units" or "scaling blue by
0.9 units."

The notion of a vector space takes this idea and generalizes it.

A vector space consists of the following elements:

+ A set of elements each called a "vector" along with some operator called
  "(vector) addition," usually denoted with $+$. Vector addition must obey the
  following rules:
    * Our vectors are closed under addition: adding two vectors together must
      always result in another vector
    * Addition commutes: $v + w = w + v$
    * Addition is associative: $v + (w + x) = (v + w) + x$
    * There is a zero vector $0$ such that $0 + v = v + 0 = v$ for all $v$
    * There are additive inverses: for every $v$ there exists a vector $w$ such that $v + w = 0$
+ A set of elements each called a "scalar" along with operations called
  "(scalar) addition" and "scalar multiplication". For almost all purposes in
  machine learning we assume that these scalars are the real numbers. This is
also often just called "scaling" a vector by a scalar.

Let's see how that works for colors, where each color is considered a vector,
and our scalars are the real numbers. 

+ Vector addition is color mixing. For simplicity's sake here I'll say that we
  are adding colors as if they were light rather than as if they were pigment
  (so that all colors added together form white rather than black/gray).
+ Colors are closed over mixing: if I mix two colors I always get another color
+ Mixing two colors commutes: the order we mix colors doesn't matter
+ Mixing colors is associative: if I have red, green, and blue, no matter if I
  first mix red and green then blue or if I first mix green and blue, then red
  we still end up with white.
+ Since we are thinking of colors as light, the zero vector here should be the
  absence of light, i.e. black. Any light combined with the absence of light is
  still the same.
+ Additive inverses are the trickiest bit here. We can use colored filters here to
  represent color subtraction, but we need to strain a little bit to say that a
  colored filter is a "color."
+ Scalar multiplication is increasing the brightness of a color

Note that vectors do not have to be vectors in the sense that they are often
described in, say, mechanical engineering, that is things that have a magnitude
and direction. Let's look at some other examples of vector spaces.

*Exercise*: 

> Let our vectors be the positive, non-zero real numbers. How can we
define vector addition and the zero vector such that this forms a real vector
space? Remember our zero vector cannot be the real number $0.0$ because we have
only the positive, non-zero real numbers. How can we define scalar
multiplication using all real numbers (positive, negative, and zero) as our
scalars (so our vectors are the positive real numbers while our scalars are all
possible real numbers)?

<details>
<summary>Hint</summary>
Let's say that our zero factor is the real number $1.0$. Since if $+$ is the
usual addition on real numbers, $x + 1 \not= x$, to minimize confusion we'll
replace the usual $+$ notation with a $\circ$. What operation would cause $1.0
\circ v = v \circ 1.0 = v$? Does this operation satisfy all the other
requirements for vector addition? If you use this operation, what does scalar
multiplication become?
</details>

<details>
<summary>Solution</summary>
Vector addition is real number multiplication. The zero vector is $1.0$. Scalar
multiplication is exponentiation, where the exponent is the scalar and the base
is the vector. Note that a positive real number raised to any exponent, positive
or negative, is always still positive. Therefore we are closed under scalar
multiplication. Verifying the distributive properties relies on how
addition of exponents turns into multiplication of elements.

In particular:

+ Vectors are closed under addition: the product of two positive real numbers is always another positive real number
+ Vector addition commutes: real number multiplication commutes
+ Vector addition is associative: real number multiplication is associative
+ There is a zero vector: let the zero vector be the real number $1.0$ and
  notice that $1.0 \cdot r = r \cdot 1.0 = r$ for all positive real numbers $r$.
+ There are (vector) additive inverses: there are multiplicative inverses for
  every positive real number $r$, namely $\frac{1}{r}$.
+ There are 
</details>

*Exercise*:

> Let's turn our attention to the Fibonacci numbers, i.e. the numbers $1, 1, 2, 3,
5, \ldots $ where the $i$-th element $x_i$ is defined as $x_{i - 1} + x_{i -
2}$, except for $x_0$ and $x_1$, which here are $1$ and $1$.
>
> Notice that the first two elements of the Fibonacci sequence ($1$ and $1$) are
essentially an arbitrary choice. We can always generate a Fibonacci-like
sequence from any two starting real numbers. E.g. if we chose $100.2, 1.1$  as our
first two elements, we would have the sequence $100.2, 1.1, 101.3, 102.4, 203.7, 306.1,
\ldots$. Or if we chose $-5$ and $3$ as our first two numbers we would have $-5,
3, -2, 1, -1, 0, -1, -1, -2, \ldots$.
>
> Let $F_{x, y}$ denote the Fibonacci sequence starting with the real numbers $x$
and $y$. How can you form a real vector space where each vector is a sequence
$F_{x, y}$ for some $x$ and $y$?

<details>
<summary>Hint</summary>

</details>

Let our vectors be the fibonacci sequences whose first two 


Let our vectors be colors perceived by humans. What is vector addition here?
What is a reasonable basis for this vector space?

Can you make a vector space out of the colors? What is a reasonable basis?


A basis can be thought of as the "fundamental set" of vectors that carries all the
information about a vector space, such that every vector can be reduced to a sum
of those vectors.

More formally, a basis is a set of vectors $v_0, \ldots, v_n$ such that every
vector in our vector space can be written as a scaled sum of just those $n$
vectors, i.e. as $k_1v_1 + k_2v_2 + \cdots + k_nv_n$ for some $k_1, \ldots, k_n$.

Every vector space has a basis

Geometrically what are linear transformations? Linear transformations are those
transformations which keep all straight lines straight

A subspace of a vector space is some subset of 

*Exercise*:

> Can you come up with an alternative basis for $R^3$? Can you come up with a
> basis that doesn't have any zeroes in any of its tuples?

<details>
<summary>Solution</summary>

</details>


Much like scalar multiplication distributes over vectors, a linear function is a
function that distributes over
A linear function is a function that obeys

Optional Exercise:

> Every vector space has a basis. Can you prove this?

Optional Exercise:

> Every basis for a vector space must have the same number of vectors. Can you prove this?


Because every basis for a vector space has the same length, we can use this
length to define a global property about the vector space in question. The
length of every basis of a vector space is called the dimension of that vector
space.


*Exercise*:

> Which of the following functions on $R \to R$ is linear according to the
> definition we've given? For those which aren't linear, can you examples of $x$
> that violate our linearity requirements?
> 
> $f(x) = x$
> $f(x) = 2x$
> $f(x) = 2x + 1$
> $f(x) = x^2$

*Exercise*:

> Which of the following transformations $R^2 \to R^2$ is linear according to the
> definition we've given?
>
> 1. Rotating all our points by 90 degrees around the origin.
> 2. Point-wise doubling all the components of every point.

*Exercise*:

> Can you implement the linear function $f: R^2 \to R^2$ that rotates all points by
> 90 degrees around the origin by describing what it does to the basis vectors
> $(1, 0)$ and $(0, 1)$?
>
> What about for the basis vectors $(1, 1)$ and $(1, 2)$?

*Exercise*:

> Using the basis vectors $(1, 0)$ and $(0, 1)$ and your previous answer, can
> you describe what the result is of applying $f$ to the vector $(-1, 3)$?
>
> Can you do the same thing now but using the basis vectors $(1, 1)$ and $(1,
> 2)$?

*Exercise*:

> Given the basis vectors $(1, 0)$ and $(0, 1)$ for both the domain and codomain
> of $f$ and still taking $f : R^2 \to R^2$ as the function that performs a 90
> degree rotation, what is the resulting matrix that describes $f$?
>
> What about if I change the basis vectors to $(1, 1)$ and $(1, 2)$ for both the
> domain and codomain?
>
> What about if the basis for the domain is $(1, 0)$ and $(0, 1)$ but the basis
> vectors for the codomain are $(1, 1)$ and $(1, 2)$?

*Exercise*:

> Can you write what linear function this matrix corresponds to in English
> (assuming that our basis for both the domain and codomain are the standard
> basis $(1, 0, 0)$, $(0, 1, 0)$, $(0, 0, 1)$)?

*Exercise*:

> If $f$ and $g$ are linear functions represented by the matrices $M_f$ and
> $M_g$, then their product $M_f M_g$ is also a matrix, which means that it must
> correspond to a linear function. What is that linear function?

*Exercise*:

> Let's say you have a real-valued matrix of size $m \times n$. As a reminder
> this means that this corresponds to a linear function $f$ whose domain has
> dimension $n$ and codomain has dimension $m$. Can you come up with values for
> that matrix such that its rank is less than $m$? and no value is zero?

Note that unlike the function itself (e.g. "rotates points by 90 degrees around
the origin") or the dimension of a vector space, a matrix is basis-dependent.
That is, different basis vectors will generate different matrices for the same
function between the same vector spaces.

Let's think about the function $f$ that does $(x, y, z) \mapsto (x, 0)$. This is
technically a function from $R^3$ to $R^2$, but "in essence" all it's doing is
the same thing as our previous function from $R^3$ to $R$ defined as $(x, y)
\mapsto x$.

A (linear) subspace of a vector space is a subset of vectors such that 

Note that a vector space is always trivially a subspace of itself.

*Exercise*:

> Given the vector space $R^2$ with the usual addition and scalar multiplication
> operations, which one of the following subsets of $R^2$ are valid linear
> subspaces and which aren't?
>
> + The set of all vectors $\left{ (x, 1) \vert x \in R \right}$, i.e. vectors
>   that have a one in their second component.
> + The set of all vectors $(x, y)$ such that $x$ and $y$ are both even numbers.
> + The set of all vectors $(x, y)$ such that $x$ and $y$ are equal to each
>   other.
