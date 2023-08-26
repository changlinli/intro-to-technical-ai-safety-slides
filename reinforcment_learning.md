% Reinforcement Learning

# Reinforcement Learning

+ Last time with image classification (handwritten digits) that was *supervised
  learning*
    * Give the machine examples of answers
    * Use those answers to train the machine
    * Assumes high confidence in the correctness of your training examples
+ Reinforcement learning is another paradigm
    * What happens if you aren't sure of the correctness of your training
      examples?

# Problem Statement of Reinforcment Learning

+ I have an agent that can be modeled as a state machine
+ That state machine has to perform actions with some form of feedback
+ Some actions do well in the short-term, but are catastrophic in the long-term
+ I want the agent to find the optimal long-term strategy
    * At least some examples of immediate feedback are very clear
    * But *I don't know the optimal long-term strategy*
+ This is very general! Almost every form of planning can be recast as a
  reinforcement learning problem

# Examples

+ Solving a maze
    * Clear immediate feedback
        - You made it to the exit!
    * Unclear longer-term strategy
        - This is a bit of a toy example, humans know how to solve mazes
+ Playing chess
    * Clear immediate feedback
        - Next move is checkmate!
    * Unclear longer-term strategy
        - Humans don't know the optimal strategy for e.g. guaranteeing checkmate
          from the starting position (or if one exists)
+ Self-driving car
    * Clear immediate feedback
        - Crash is bad
        - Hit a pedestrian is bad
        - Arrive at destination is good
    * Unclear longer-term strategy
        - Does changing a lane now result in a crash 10 seconds from now?
+ AI policymaker
    * Clear immediate feedback
        - Resulting in millions of deaths is bad
    * Unclear longer-term strategy
        - What policies will cause ~10 years from now widespread famine causing
          millions of deaths?

# Reinforcment Learning Can Train Superhuman Agents

+ Supervised learning seems unlikely to produce agents that are "smarter" than
  their training examples
+ Reinforcement learning can easily lead to superhuman performance since it
  learns a long-term optimal strategy "from scratch"

# Reinforcement Learning and Neural Nets

+ A more abstract concept (namely a paradigm) than neural nets
+ Neural nets can be used to implement reinforcement learning
    * In practice we almost always use neural nets to implement RL
    * In theory though you could use another type of machine learning algorithm

# We have two optimizers

# The Reward 

+ The reward function is used to optimize the underlying neural net, but the
  resulting agent does not necessarily optimize for the reward function!
