So based on what we've said so far about matrices, one way to think about them
is that 

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

means $$


Let's take what we've defined so far and do some more calculations with them.

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


