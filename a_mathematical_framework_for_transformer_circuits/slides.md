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
+ E.g. can I identify a part of the transformer that understands addition, another
  part that understands multiplication, and then recombine them to build a neural net
  that performs arithmetic without any need for re-training/fine-tuning?

# Re-Framing Transformers

+ What are language models?
    - Ideally they are probability distributions over all possible word
      sequences in language
        * Theoretical starting point
        * Note that this probability distribution in practice is some infinite
          list of parameters since we're talking about *all possible* sequences
    - Task of making a language model is to find a good approximation
