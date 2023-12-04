% Elaboration on slides

# Mixed tensor product

$h(x) = (\text{Id} \otimes W_O) \cdot (A \otimes \text{Id}) \cdot (\text{Id} \otimes W_V) \cdot x$


$h(x) = (\text{Id}_{1 \times n} \otimes W_O) \cdot (A \otimes \text{Id}_{d \times d}) \cdot (\text{Id}_{n \times 1} \otimes W_V) \cdot x$

where

$W_0$ has dimension $d \times d$, $A$ has dimension $n \times n$, and $W_V$ has
dimension $d \times d$

Note that the intermediate tensor products have very large dimensions! The
dimensions are respectively

$(d \times dn) \cdot (dn \times dn) \cdot (dn \times d) \cdot (d \times n)$
