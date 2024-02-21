## The Overall Gameplan

What's the overall map of where we're trying to go today?

It turns out that modern AI/ML relies essentially on matrices everywhere. If we
want to understand what an AI model is doing, then we must understand what a
matrix is doing, in a way that is more comprehensible than simply a blob of
floating point numbers. To understand what a matrix is doing, we must then
understand their theoretical foundations, namely linear algebra.

By doing so, we can demystify matrices away from blobs of floating point numbers
and towards more understandable concepts such as "this matrix represents a
rotation."

By the end of this session you should be able to understand:

1. What a vector space is
2. What a linear function is
3. The relationship between a matrix and a linear function
4. Why matrix multiplication is defined the way it is

I will refrain from using equations too much in this introduction, because
equations can often make it seem like vector spaces only apply to things built
out of numbers when they are in fact more general than that. However, I will
still use them from time to time, because almost all machine learning papers
will use equations. An extremely important skill to learn as an ML practitioner
and technical AI safety practitioner is to not be afraid of equations!

Many programmers' eyes glaze over when it comes to equations, but power through
it! Simply not having an "oh no!" knee-jerk reaction to equations is one of the
biggest superpowers when it comes to reading ML research directly.

## Motivating Vector Spaces

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

Other examples of this abound in nature. For example sound. It's not very clear
what it means to multiply two sounds together (although as we'll see later on in
this course it's not impossible to come up with a notion of multiplication
either), but it is much more straightforward to think about what adding two
sounds together is: just play them together at the same time! Then
scaling/multiplying by a constant is just making the sound louder or softer.

The notion of a vector space takes this idea and generalizes it by defining what
it means to "add" two "vectors" and what the word "scaling" means.

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
  "addition among scalars" and "multiplication among scalars". For almost all purposes in
  machine learning we assume that these scalars are the real numbers and
  addition/multiplication among scalars are just the usual addition and
  multiplication on real numbers. The
  crucial operation is multiplying a vector *by* a scalar. This is
  also often just called "scaling" a vector by a scalar. Apart from being able
  to add and multiply scalars among themselves like we can for the real numbers, multiplying a
  vector by a scalar must distribute over vector addition. That is:
    * $k(v + w) = kv + kw$ for a scalar $k$ and vectors $v$ and $w$
    * $(k_0 + k_1)v = k_0v + k_1v$ for scalars $k_0$ and $k_1$ and a vector $v$
    * We also require that $1v = v$.

Note that the notion of a "vector" here is extremely broad. Vectors do not have
to be vectors in the sense of what we ordinarily consider "mathematical"
objects. We can describe physical phenomena as vector spaces.

For example, let's see how we could define sounds as a vector space, where each
sound is considered a vector, and our scalars are the real numbers. 

+ Vector addition is sound mixing, that is playing one sound over another.
  * Sounds are closed over mixing: if I mix two sounds together I always get
    another sound. Otherwise it's a category error. I can't accidentally mix two
    sounds together and get a color (unless you have synesthesia!)
  * Mixing two sounds commutes: the order we mix sounds doesn't matter
  * Mixing sounds is associative: if I have a lion roar, a car horn, and a violin
    holding a note, no matter if I first mix the roar and horn then violin or if I first
    mix the horn and violin, then the roar we still end up with the same sound.
  * The zero vector is complete silence. Adding silence to any sound never changes
    it.
  * Additive inverses: the same sound just played out of phase is the additive
    inverse to the original sound. If you play the two together you get
    silence. This is the principle behind noise cancellation. Every sound has an
    inverse because every sound can be shifted out of phase.
+ Scalar multiplication is increasing the volume of the sound:
  * It distributes over vector addition: if you double the volume of one sound
    and then double the volume of another sound and mix them together, it's the
    same thing as if you had mixed them together first and then doubled the
    volume of the final result.

*Exercise*:

> I can define a form of addition and scalar multiplication for quantities of
> brine, i.e. salty water. Let's say that our vectors are volumes of brine, and
> vector addition consists of mixing two different quantities of brine,
> potentially of different salinity together. Does this form a valid vector space?

<details>
<summary>Hint</summary>
How would you define the zero vector here? What constant volume and salinity of
water can be added to any volume and salinity of water without changing its
volume or salinity?

Given that zero vector, are there valid additive inverses here?
</details>

<details>
<summary>Solution</summary>
Like many physical phenomena, it is possible to really contort a definition of
a vector space to fit (and you can try!), but absent major contortion, vectors
defined as physical quantities of brine do not form a vector space.

It is possible to define a reasonable zero vector, namely a zero quantity of
water, but it is not possible to define reasonable additive inverses, when
vector addition is mixing of water.

You could define a negative quantity of water, but that is usually interpreted
as taking away water rather than mixing in new water.

An even thornier problem is 
</details>

But we can also define more common "mathematical" objects as vector spaces as
well.

The most common example of this is $R^n$. $R^n$ consists of the set of
real-valued n-tuples. For example vectors in $R^2$ are pairs that look like
$(0.1, 0.2)$ or $(-5, 91.1)$. Vectors in $R^3$ are triplets that look like $(2,
1, 0.5)$ and so on and so forth. For $R^n$, we define vector addition as
element-wise addition, and scalar multiplication as element-wise multiplication
by that scalar. E.g. $(x_{0}, x_{1}, \ldots, x_{n}) + (y_{0}, y_{1}, \ldots,
y_{n}) = (x_{0} + y_{0}, x_{1} + y_{1}, \ldots, x_{n} + y{n})$.

That is $(x_i)_{i=0} ^n + (y_j)_{j=0}^n = (x_i + y_i)_{i=0}^n$.

For a scalar $k$, $k(x_0, x_1, \ldots, x_n) = (kx_0, k_x1, \ldots, kx_n)$, or
equivalently $k(x_i)_{i=0} = k(x_i)_{i=0} ^n$.

So for example $(1, 2) + (2, 3) = (3, 5)$ and $3 \cdot (1, 2) = (3, 6)$.

$R^n$ by far is the most common vector space you will see in machine learning,
so we'll spend just a few more paragraphs on it.

Note that to properly define a (real, i.e. using real numbers as scalars)
vector space, we must always specify not only what the vectors are, but also
what exact operation vector addition corresponds to as well as what exact
operation scalar multiplication corresponds to.  However, as you read machine
learning papers, you may notice that a paper only says "take the vector space
such-and-such," that is they only define the vectors and don't define vector
addition and scalar multiplication. This is because by convention, we almost
always use certain vector addition definitions and scalar multiplication
definitions for certain sets of vectors.

So for example, technically speaking, just saying $R^2$ forms a vector space is a
category error, since $R^2$ merely describes a set of vectors and there are
many different notions of vector addition and scalar multiplication that we
could add to the set to fully form a vector space. For example, we could define
$(x_0, y_0) + (x_1, y_1) = (x_0 + y_1, y_0 + x_1)$.

But almost always, the vector addition we use on $R^2$ is $(x_0, y_0) + (x_1,
y_1) = (x_0 + x_1, y_0 + y_1)$ and scalar multiplication will be $k(x, y) =
(kx, ky)$. Therefore by convention we often just say the "vector space R^2" and
implicitly assume that vector addition and scalar multiplication are exactly
those operators. This is strictly speaking an abuse of terminology, or at least
ambiguous, as $R^2$ is a set of vectors, not a vector space itself, but it is
*extremely* common and so is widely used and accepted in almost all fields that
use linear algebra.

However, it is *always* a valid question when someone simply defines a set of
vectors as a vector space to ask the speaker to clarify which vector addition
and scalar multiplication operators are intended.

As a reminder, we're focusing mainly on real vector spaces, i.e. those vector
spaces whose scalars are real numbers, because those are the main spaces we
deal with in machine learning. Nonetheless the concept of a vector can use
other scalars as well. A common other set of scalars that are sometimes used
are the complex numbers. While this is useful in physics, this shows up rather
rarely in machine learning, so we won't talk about them.

<details>
<summary>Optional Aside</summary>
For those who would like to read more about the general concept of scalars for a
vector space, the term here is "field", that is any field can be used as
scalars. See
[https://en.wikipedia.org/wiki/Field_(mathematics)](https://en.wikipedia.org/wiki/Field_(mathematics)).
</details>

*Exercise*:

> Let's say I instead defined additon on $R^2$ to be element-wise maximums.
> That is $(x_0, y_0) + (x_1, y_1) = (\text{max}(x_0, x_1), \text{max}(y_0,
> y_1))$. We keep scalar multiplication the same as the usual definition. Is
> this a valid vector space?

<details>
<summary>Solution</summary>
No this is not. There is no zero vector.
</details>


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

More formally, a basis is a minimal set of vectors $v_0, \ldots, v_n$ such that
every vector in our vector space can be written as a scaled sum of just those
$n$ vectors, i.e. as $k_1v_1 + k_2v_2 + \cdots + k_nv_n$ for some $k_1, \ldots,
k_n$. When we say it is "a minimal set," what we mean is that if you removed
any $v_i$ from that set, this property would no longer hold true.

<details>
<summary>Optional Aside</summary>
The set of all vectors $W$ that can be formed via scaled sums of some other set
of vectors $V$ is known as known as the span of $V$. Hence a more compact way
of describing a basis is that is a minimal set of vectors whose span is the
entirety of the vector space.

Yet another piece of terminology is linear independence. 
</details>

For example for $R^3$, the most commonly used basis is the set $\{(1, 0, 0),
(0, 1, 0), (0, 0, 1)\}$. It is so common that it is often called $R^3$'s
"standard basis."

The scaled sum used to form any other vector is just using the components of
the other vector as scalars. For example to write $(4, 3, -2)$ using this
basis, we can just write it as $4(1, 0, 0) + 3(0, 1, 0) + (-2)(0, 0, 1)$.

On the other hand $\{(1, 0, 0), (0, 1, 0), (0, 0, 1), (1, 0, 1)\}$ is not a
valid basis. This is because it is no longer a minimal set, since we can omit
$(1, 0, 1)$, without harming our ability to represent every vector as a scaled
sum of this set of vectors.

*Exercise*:

> Let's say for some reason we really wanted to keep $(1, 0, 1)$. 
> + What other vector could we throw out to this set minimal again, i.e. to
>   make a valid basis? 
> + Are there multiple choices to the question above?
> + Which vector(s) cannot be thrown out and still maintain our property that
>   every vector can be written as a scaled sum of this set?
> + Using your new basis, can you write $(4, 3, -2)$ as a scaled sum of that basis?

<details>
<summary>Solution</summary>
+ You could throw away either $(1, 0, 0)$ or $(1, 0, 1)$ (but not both).
+ Yes.
+ You cannot throw away $(0, 1, 0)$. If you do, you cannot form any vector with
  a non-zero second component from a scaled sum of the resulting set of vectors.
+ If we take $\{(1, 0, 0), (0, 1, 0), (1, 0, 1)\}$, we can write $(4, 3, -2) =
  6(1, 0, 0) + 3(0, 1, 0) + (-2)(1, 0, 1)$.
</details>

As you may have noticed from that exercise, there is no single basis for a
vector space. Every vector space has many possible bases (unless the vector
space itself consists of only one vector).

This raises the question "do all bases of a vector space have the same number
of vectors?" The answer is yes. It is not obvious that this is true and proving
it may be a bit tricky if you're new to this stuff. For our purposes we'll just
state this by fiat, but if you are so inclined, you may want to prove this as
an optional exercise.

The following three exercises are optional. It may be useful to look at them to
understand facts about vector spaces even if you don't prove them.

<details>
<summary>Optional Exercise</summary>
Prove that for a given vector sace, if all its bases contain a finite number of
vectors, all its bases must be of the same size. That is all its bases must
have the same number of vectors.
</details>
<details>
<summary>Solution</summary>
TODO
</details>

<details>
<summary>Optional Exercise</summary>
Note that this requires some familiarity with infinite sets and cardinality.
Just ignore this exercise if you don't have this familiarity.

Prove that if a vector space has a basis, even if infinite, all its bases must
be of the same size (i.e. cardinality).
</details>
<details>
<summary>Solution</summary>
TODO
</details>

<details>
<summary>Optional Exercise</summary>
Note that this will require knowledge of the Axiom of Choice
[https://en.wikipedia.org/wiki/Axiom_of_choice](https://en.wikipedia.org/wiki/Axiom_of_choice).
If you are not familiar with set theory axioms, don't worry about completing
this.

Prove that all vector spaces have a basis.
</details>
<details>
<summary>Solution</summary>
TODO
</details>

Because all vector spaces have a basis and because all the bases of a vector
space must be of the same size, we can talk about "the" size of a vector
space's bases, even though the bases themselves may consist of different
vectors. We call the size of a vector space's bases the dimension of a vector
space.

This leads to a very nice statement when it comes to $R^n$. The dimension of
$R^n$ is exactly $n$.

*Exercise*:

> Prove this. That is prove that any basis of $R^n$ must have exactly $n$ vectors.

<details>
<summary>Hint</summary>
We already know that all bases of a vector space must have the same number of
elements, so all that's needed is to find a basis of $R^n$ that has $n$
vectors.
</details>

<details>
<summary>Solution</summary>
TODO
</details>

*Exercise*:

> Can you come up with an alternative basis for $R^3$? Can you come up with a
> basis that doesn't have any zeroes in any of its triplets' components?

<details>
<summary>Solution</summary>
One possible alternative basis for $R^3$ is to simply take the standard basis
and double one of the vectors, e.g. so that we have $(2, 0, 0)$, $(0, 1, 0)$,
and $(0, 0, 1)$.

One possible basis that has no zeroes in any of its triplets is $\{(1, 1, 1),
(2, 1, 1), (1, 1, 2)\}$.
</details>


Much like scalar multiplication distributes over vectors, a linear function is a
function that distributes over
A linear function is a function that obeys

<details>
<summary>Optional Exercise</summary>
> Every vector space has a basis. Can you prove this?
</details>

<details>
<summary>Optional Exercise</summary>
> Every basis for a vector space must have the same number of vectors. Can you prove this?
</details>

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

## Linear Subspace

A (linear) subspace of a vector space is a subset of vectors such that the
subset remains closed under vector addition and scalar multiplication from the
original vector space. That is for any two vectors contained in the subset,
their sum is also contained in the subset. For any vector contained in the
subset, any rescaling of that vector by scalar multiplication must also be in
the subset.

So for example, in $R^2$, the set of vectors that all have a zero in their
second component, i.e. the set $\left\{ (x, 0) \vert x \in R \right\}$, is a
(linear) subspace of $R^2$.

*Exercise*:

> Given the vector space $R^2$ with the usual addition and scalar multiplication
> operations, which one of the following subsets of $R^2$ are valid linear
> subspaces and which aren't? For the ones that aren't, can you give examples
> that violate closure of vector addition or closure of scalar multiplication?
>
> + The set of all vectors $\left\{ (x, 1) \vert x \in R \right\}$, i.e. vectors
>   that have a one in their second component.
> + The set of all vectors $(x, y)$ such that $x$ and $y$ are both even numbers.
> + The set of all vectors $(x, y)$ such that $x$ and $y$ are equal to each
>   other.

<details>
<summary>Solution</summary>
The set $\left\{ (x, 1) \vert x \in R \right\}$ is not a valid linear subspace
of $R^2$ under the usual vector addition and scalar multplication operators. It
is not closed under scalar multiplication or vector addition.
If I multiply by a scalar constant $k$ I get $k(x, 1) = (kx, k)$, which is not
a part of $\left\{ (x, 1) \vert x \in R \right\}$ if $k /not= 1$. Likewise if I
add two vectors $(x, 1)$ and $(y, 1)$ I get $(x + y, 2)$, which is not a member
of the subset.

The set of all vectors $(x, y)$ such that $x$ and $y$ are both even numbers is
also not a valid linear subspace of $R^2$. This is not closed under scalar
multiplication since I can multiply e.g. $0.5 \cdot (2, 2) = (1, 1)$ , which is
not contained in my subset.

The set of all vectors $(x, y)$ such that $x$ and $y$ are equal to each other
is a valid linear subspace of $R^2$. Given $(a, a)$ and $(b, b)$, adding them
together results in a tuple whose two components are still equal to each other,
namely $(a + b, a + b)$, same for multiplying by a scalar.
</details>

## Linear Functions


Geometrically what are linear transformations? Linear transformations are those
transformations which keep all straight lines straight

## Matrices as notation

We use notation for all sorts of things in life. For example, we use *numerals*
as notation for *numbers*, but it is important to distinguish between the two.
6, 110, and VI are all different numerals, but they all represent the same number.

Matrices, as we shall see, spring from the same intuition, and are a form of
notation for linear functions. In particular, just like we have different base
systems for numbers, such as base-10 or base-2, that result in different
numerals for the same number, matrices constructed with different basis vectors
will result in different matrices for the same linear function.

In practice, much like how we often assume that a given numeral is a base-10
numeral without additional elaboration, when working with $R^n$, we generally
assume that a given matrix uses the standard basis vectors.

Just like how numerals allow us to perform arithmetic computation with numbers,
we shall see that matrices allow us to perform computation with linear
functions.

However, when we move away from direct computation, it will often be easier to
understand what a matrix is "really doing," by understanding what the function
it notates is doing, rather than getting bogged down in a two-dimensional array
of floating point numbers.

## Inner Products

Inner products are a way of defining

First and foremost, inner products are an *optional* addition to a vector
space. That is a vector space does not need to have an inner product. A vector
could also possibly have many different kinds of inner products added to it.

That being said
