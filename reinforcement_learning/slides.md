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

# More General Examples

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
+ Reinforcement learning can lead to superhuman performance since it learns a
  long-term optimal strategy "from scratch"

# Reinforcement Learning and Neural Nets

+ A more abstract concept (namely a paradigm) than neural nets
+ Neural nets can be used to implement reinforcement learning
    * In practice we almost always use neural nets to implement RL
    * In theory though you could use another type of machine learning algorithm

# State Machines

RL deals with creating a state machine, so we need:

+ Different states (usually denoted by the variable $s$)
+ Different actions associated with each state (usually denoted by the variable
  $a$)
    * Action to take depends on what state you're in

# Vocab of the RL Agent

+ Policy: the state machine strategy that is learned. That is the choice of what
  actions given a certain state the machine should do. Usually denoted by the
  $\pi$ symbol.
+ Reward function $R(s, a)$: the immediate feedback given to the agent after
  performing an action. Is some positive or negative number.
+ $Q(s, a)$: the maximum reward we can accumulate from state $s$ after taking
  action $a$. *We usually don't know this function.*
+ Value function $V(s)$: a variation of $Q$ where $V(s)$ is the highest value
  of $Q(s, a)$ across all $a$ for that $s$.
    * Sometimes used to refer to the entire class of functions that score
      long-term implications of actions. E.g. $V$ and $Q$ are both "value
      functions."
    * Don't know this function

# Simplifications I'm Going to Make

+ Assume discrete time steps
+ Assume deterministic policy
+ None of these are fundamental limitations, RL has ways of relaxing all of
  these
    * Just easier to present without diving into the full generality of RL
    * They don't affect the core of what RL is

# General Setting of RL

+ At design time we specify:
    * Possible states
    * Possible actions
    * Reward function
+ What the agent learns:
    * Policy/value function

# Difference Between $R$ and $Q$

Let's take chess as an example. 

+ Move that causes checkmate has an extremely high $R$-value and also has extremely high $Q$-value.
+ Move that forces checkmate in 5 moves might have a low $R$-value or even a
  negative $R$-value (e.g. you have to sacrifice a piece on the next move), but
  still has an extremely high $Q$-value.

# How RL Training Works

+ We want to learn either $\pi$ or $Q$ (we can get $\pi$ from $Q$ by just
  choosing the highest value of $Q$)
+ How do we create an error/loss function to learn against if we don't have any
  training examples?
    * Humans don't necessarily know the optimal $\pi$ or the true value of $Q$
+ Can learn $Q$ directly
+ Can learn via trying out the policy

# Learning $Q$ Directly ($Q$ Learning)

+ Bellman's Equation:
    * Think back to $Q$: the best, long-term reward we can get by performing $a$ and $s$
    * Let's say that we're currently at state $s$ and we have two possible actions:
        - $a_0$ gets us to $s_{a_0}$
        - $a_1$ gets us to $s_{a_1}$
    * If we know what $Q(s_{a_0}, a)$ is for all $a$ and we know what
      $Q(s_{s_{a_1}})$ is, then we can just choose the larger and add $R(s, a)$
+ $Q(s, a) = R(s, a) + max_{i} Q(s_{a}, a_i)$

# Using Bellman's Equation to Generate Training Examples

+ Bellman's Equation gives us a loss function
    * Use your agent (usually a neural net) to calculate $Q(s, a)$
    * Then use it to calculate $max_{i} Q(s_{a}, a_i)$
    * We know $R(s, a)$
    * Difference between $Q(s, a)$ and $R(s, a) + max_{i} Q(s_{a}, a_i)$ is our loss
      function
+ We therefore end up with a bunch of training examples analogous to image
  classification
    * Image classification: actual answer and correct answer, loss is diff
    * Bellman's equation: $Q(s, a)$ and $R(s, a) + max_{i} Q(s_{a}, a_i)$, loss
      is diff
+ Backpropagate with that loss function on a bunch of $s$ and $a$s (can be
  more or less random)

# Q-Learning doesn't really mean the agent is trying to "win"

+ The central question that the neural net asks itself at every step: "are my
  beliefs self-consistent (according to Bellman's Equation)"
+ E.g. for Q-learning in chess, a net doesn't necessarily actually have to ever
  play a full game of chess
    * Can just keep learning by looking at various board positions and keep
      using Bellman's Equation

# Learning via Direct Policy Learning

+ Start with a random policy $\pi$
+ Use the policy to generate a long chain of states and actions
+ Randomly explore a bunch of alternative actions along that chain
+ Use the exploration to get an idea of how "good" your policy was compared to
  possible alternatives and then re-update your policy

# Questions About Training?

+ That was a bit much so don't worry if you didn't get everything
+ Only one really important point: reinforcement learning can generate its own
  training examples and doesn't need human input

# We Can Still Learn "Spurious" $Q$

+ Bellman's Equation gives us a globally optimal $Q$, but we almost never get
  Bellman's Equation exactly right
    * Even small deviations from Bellman's Equation can mean large practical
      differences in policy $\pi$
+ Policy-based training only gives us local maxima
    * Very dependent on our explorations

# The Reward Is Not Necessarily What the Agent Optimizes For

+ The reward function is used to optimize the underlying neural net, but the
  resulting agent does not necessarily optimize for the reward function!
+ The agent is not learning $R$!
    * $R$ is used to learn $Q$, but the model may not learn the $Q$ you want it
      to learn

# The learned $Q$ or your learned policy can disagree strongly with the specified $R$

+ Just like image classification, $Q$ might be completely spurious
+ E.g. imagine a chess engine trained via RL with an underlying neural network
  with a single forward pass
    * Return (i.e. Q) is a deep tree, so must be calculated by looking a
      variable number of moves "ahead"
    * Single forward pass implies computation happens in constant time
    * Therefore whatever strategy the neural net learns, it can't actually be
      looking a variable number of moves ahead!
    * Instead the neural net learns a set of "intuitions/vibes" that correlate
      well with the actual high-return move that happens by looking e.g. 10
      moves ahead, or at least correlates well in training
    * But this reveals a fundamental difference between the reward function (a
      deeply iterative/recursive function) and the learned function (a constant
      time function), and this fundamental difference can hide pathological
      behavior!
    * This fundamental difference is not simply a difference between constant
      time and variable time computation, just most obvious there
         - More generally this is because we usually do not have a way of truly
           learning the optimal strategy, but only a strategy that has some
           correlation to the optimal strategy *in training*
         - E.g. "detecting that you are in training and only cooperating with
           your user then, but betraying your user in production" correlates very
           well to the strategy of "always cooperating with your user" when you
           are in training!

# We have two optimizers

+ The training process is an optimization process
+ The agent itself performs optimization while running
    * $Q$ is how the agent decides the most optimal action to perform next

# Inner vs outer optimization

+ The outer optimizer: this is guided by our choice of $R$ and is therefore
  directly influenceable
    * The optimization process
+ The inner optimizer: this is guided by the agent's learned $Q$ and is
  therefore only indirectly influenceable
    * Actually running the model

# Outer Alignment vs Inner Alignment

+ Aligning the outer optimizer
    * We got $R$ correct
    * Outer alignment failure looks like the monkey's paw problem
        - I give specify high positive reward for giving me money
        - I forget to specify high negative reward for killing a loved one and
          the agent kills a loved one using their life insurance money to give
          me money
+ Aligning the inner optimizer
    * $Q$ was learned incorrectly
    * But maybe I specify $R$ perfectly

# Inner Alignment Failure Can Look a Lot Like Deception

+ Learning spurious relationships/overfitting/goal misgeneralization can look a
  lot like deception in the context of RL!
    * The model "plays nice" in training and then goes off the rails in
      production
* More generally known as the "treacherous left turn"
    * The model looks very good and aligned for a while and then makes a "sudden
      left turn" and starts wreaking havoc
    * Could happen because of bad training
    * Could happen suddenly in production if we encounter an environment that
      taps into a pathological part of $Q$

# Compounded by RL Agents Being Agentic

+ RL produces "agentic" AI
    * AI that can perform actions that change its surrounding environment
    * Importantly RL also "trains itself"
+ Bad $Q$s can become self-reinforcing

# Very Very Bad Scenario

+ We end up with a $Q$ that looks something like "look nice whenever we can
  detect human supervision and then go off the rails whenever that stops"

# How Do We Fix It?

+ No silver bullets
+ One of the main concerns of AI alignment in AI safety!
