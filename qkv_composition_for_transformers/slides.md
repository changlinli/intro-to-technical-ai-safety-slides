# Thinking of transformers via programming

+ "These are some words"
+ Start with array of tuples: `[("These", 0), ("are", 1), ("some", 2), ("words", 3)]`

# Induction heads

+ "a b c a b"
+ The next thing that we should predict is "c" right?
+ But this is impossible with just one level of attention!
    * Trying to learn the pattern "x y ... x [y]"
+ `[("a", 0), ("b", 1), ("c", 2), ("a", 3), ("b", 4)]`
+ Pair-wise attention isn't enough
    * E.g. can look at attention `("a", 0)` and `("b", 1)` together and you'll get

# Attention only works pair-wise


