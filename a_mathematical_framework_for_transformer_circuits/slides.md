% Transformer Circuits

# The Paper We're Focusing On

+ "A Mathematical Framework for Transformer Circuits"
+ Elhage, Nanda, Olsson et al.
+ [https://transformer-circuits.pub/2021/framework/index.html](https://transformer-circuits.pub/2021/framework/index.html)

# Quick Recap of the Goal of Circuits

+ Circuits are theorized *factorizable* parts of a model
    - E.g. image classification model, can we carve out the part of the model
      that identifies "cats" and the part that identifies "dogs?"
+ One important benchmark of whether it's truly factorizable is whether we can
  mix and match
    - If we carved out "cats" and "dogs" correctly we should be able to create a new
      model from our old model that exclusively identifies cats vs dogs without
      needing to retrain, by just combining the "cats" circuit and "dogs"
      circuit
+ Relation to alignment
    - If we understand circuits and can mix and match then we should be able to
      exactly tune models to what we want them to do more precisely than just
      the blunt sledgehammer of gradient descent training

# Transformer Circuits

+ Can we identify circuits in a transformer architecture?
+ E.g. can I identify a part of the transformer that understands symmetry, another
  part that understands swapping, and then recombine them to build a neural net
  that reverses strings without any need for re-training/fine-tuning?

# Re-Framing Transformers

+ What are language models?
    - Ideally they are probability distributions over all possible word
      sequences in language
        * Theoretical starting point
        * Note that this probability distribution in practice is some infinite
          list of parameters since we're talking about *all possible* sequences
    - Task of making a language model is to find a good approximation

# Notion of Residual Streams

+ A transformer over an input of `n` tokens, can be thought of as having `n`
  residual streams flowing through the transformer
+ Streams are almost entirely independent (element-wise operations)
    * Only thing that isn't element-wise is attention!
+ Single stream that gets attention and MLP results added periodically

# Change in Perspective

+ Residual connections are not connecting the input back to the output of a
  layer
+ Residual connections are keeping the original input and connecting the output
  of that layer back to the input!

# What is Attention Really?

+ Attention moves information from one residual stream to another

# Zero-Layer Transformers

+ Bigram estimation
