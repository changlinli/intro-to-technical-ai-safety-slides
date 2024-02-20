Linear algebra, as the name suggests, is the study of linear functions.

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

Note that vectors do not have to be vectors in the sense that they are often
described in, say, mechanical engineering, that is things that have a magnitude
and direction. Let's look at some more exotic examples of vector spaces.

Let our vectors be the positive, non-zero real numbers. How can we define vector
addition and the zero vector such that this forms a real vector space? Remember our
zero vector cannot be the real number $0.0$ because we have only the positive,
non-zero real numbers. How can we define scalar multiplication using all real
numbers (positive, negative, and zero) as our scalars (so our vectors are the
positive real numbers while our scalars are all possible real numbers)?

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
</details>

Let's turn our attention to the Fibonacci numbers, i.e. the numbers $1, 1, 2, 3,
5, \ldots $ where $$

Notice that the first two elements of the Fibonacci sequence ($1$ and $1$) are
essentially an arbitrary choice. We can always generate a Fibonacci-like
sequence from any two starting real numbers. E.g. if we chose $100.2, 1.1$  as our
first two elements, we would have the sequence $100.2, 1.1, 101.3, 102.4, 203.7, 306.1,
\ldots$. Or if we chose $-5$ and $3$ as our first two numbers we would have $-5,
3, -2, 1, -1, 0, -1, -1, -2, \ldots$.

Let $F_{x, y}$ denote the Fibonacci sequence starting with the real numbers $x$
and $y$. How can you form a real vector space

Let our vectors be the fibonacci sequences whose first two 


Let our vectors be colors perceived by humans. What is vector addition here?
What is a reasonable basis for this vector space?

Can you make a vector space out of the colors? What is a reasonable basis?
