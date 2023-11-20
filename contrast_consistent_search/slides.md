% Contrast Consistent Search

# Eliciting Latent Knowledge (ELK)

+ AI Alignment
    * Mechanistic Interpretability
        - ELK
            + Contrast Consistent Search (CCS)

# What is Latent Knowledge

+ Knowledge that a model knows but "won't tell us"
+ Notice that LLMs are very sensitive to how questions are phrased
    * False ceiling: If you tell the LLM to be dumb it will be a dumb even
      though it "knows better"
    * True ceiling: But there are still things that no matter how you phrase it
      the LLM still can't grasp/do
+ Can we get to the true ceiling?

# Why is Latent Knowledge Important for AI Safety?

+ Latent Knowledge seems like one step towards trying to understand what an AI
  is "truly" trying to do, vs what it appears to be doing externally
+ Latent knowledge uncovers what an AI "hides"

# Can We Uncover that Latent Knowledge?: CCS

+ Contrast Consistent Search (CCS) is one proposed method to recover that
  information
+ Focuses only on binary questions: yes/no, true/false, positive/negative, etc.
    * Just like last week with ROME only a certain class of questions (ROME was
      focused on subject, relation, object triples)
+ Central intuition: a model shouldn't answer both true and false, even though
  it could be prompted to do so, so let's try to use that distinguish what
  answers a model "truly" believes

# What is CCS trying to solve

+ **Without any supervision (i.e. no one to come around and tell you whether a
  given yes/no answer is correct or not), can we come up with a way of
  using the model to answer our questions with better accuracy than just asking
  the model dierctly?**
+ Pause for questions

# Diving deeper

+ CCS is an example of using a much simpler AI to evaluate a more complex AI
+ Let's use some hidden layer of the neural net and examine what it looks like
    * These will be some crazy vector of floats
+ Can we reasonably split these vectors into two groups

# CCS Implementation

+ Then let's train a very simple model (not even necessarily a neural net! But
  the paper uses one) to look at the data
    * Function maps a representation of the input to a probability from 0 to 1
    * Loss function for training our function:
        - Probability of yes version and probability of no version should sum to
          1
        - Try to maximally differentiate yes and no (try to avoid the degenerate
          solution of just map everything to 0.5)

# How Do We Identify True and False without Ground Truth

+ If all goes well we have two groups, we have a function that tends to say that
  a statement has a probability 1 or 0 of being X (maximal differentiation)
+ But is X "true" or "false?"
+ We can use conjunctions and disjunctions of statements! (e.g. if "A and B"
  gets put in the "A" bucket then A is "true" otherwise it's "false")

# Does this work?

+ Yes!
+ Surprising this works at all
    * We are basically just blindly trying to cluster 
+ We even get better performance than zero-shot (!)
    * Asking the model to directly
+ Performance holds up even when we try to make the model lie by first including
  a bunch of examples of incorrect answers as a prefix to every prompt
    * Although surprisingly this doesn't always drop performance on baseline
      zero-shot as much as expected

# Do we even need the simple neural net?

+ We can do something as simple as k-means (where k = 2) clustering and this
  works quite well as the paper demonstrates

# Why Not Just Add it to the Training Regimen?

+ If CCS is ends up better than just asking the model, why not just make it part
  of the training loss function?
+ Goodhart's Law!
    * When a measure becomes a target, it ceases to be a good measure
    * In ML same intuition: separating training/validation sets from test sets

# Goodhart's Law as applied to AI Safety

+ If we had a loss function that perfectly captured truth that'd be great! We
  should use that.
    * But we don't!
    * CCS is closer, but still far far away
+ Imagine trying to detect fraud if your anti-fraud measures were all entirely
  public
+ Unless we are certain we have a *perfect* loss function we should keep a set
  of tools independent from training
