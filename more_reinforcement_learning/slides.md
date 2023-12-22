% More Reinforcement Learning

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

# Reminder of key terms

+ Reward function $R$: immediate reward
+ Value function $Q$: maximum possible reward
+ Policy $\pi$: the learned strategy that an agent actually performs
+ If we know $Q$ we have an implicit $\pi$ (do the action htat
  has the best maximum possible reward)
+ If we know the best $\pi$ we have a way of computing $Q$ (keep playing the
  policy and sum all rewards). Note this is complicated by stochasticity.
+ Approximation parameters $\theta$: These are usually just the weights of your
  underlying neural net
+ Episode/Trajectory: one "playthrough" of a game

# Different Ways of Saying the Same Thing

+ $\pi_{\theta}(s, a)$
+ $\pi(s, a \mid \theta)$
+ $\pi_{\theta}(a \mid s)$
+ $\pi$ for now outputs a boolean. For a given action $a$ in a state $s$ with
  weights $\theta$, either we say "yes do $a$" or "no, don't do $a$."

# Reminder of Q-Learning

+ Self-consistency checks via Bellman's Equation
+ $Q(s, a) = R(s, a) + max_{i} Q(s_{a}, a_i)$

# Downsides of Q-Learning

+ Can have convergence issues (either it successfully converges to a global
  optimum, or goes absolutely wild)
+ Intermediate versions of the model can be very bad

# Policy Gradient

+ Q-Learning was an example of a "value function-based" reinforcement learning
  approach
+ We can have a policy-based approach as well
+ Policy-based approaches correspond closer to natural intuitions about
  reinforcement learning
    * Do more of those things that give you more reward
    * Do less of those things that give you less reward
    * Reminder different from the "self-consistency check" of Q-Learning
+ Downsides:
    * For Q-Learning you are always able to use any training example to get
      better
    * For policy gradient approaches, often you have training limitations, e.g.
      you can only use training examples where you were using the same version
      of $\pi$ as the version you currently have
    * Policy gradient has no formal guarantee of converging to a global optimum
      whereas for certain restricted scenarios Q-Learning has convergence
results
+ Upsides:
    * Intermediate training optimums often are more useful than Q-Learning
    * A lot easier to handle stochastic scenarios

# Basic Strategy behind Policy Gradient Methods

+ Keep iterating on different versions of our policy
+ Just like all RL algorithms, we will be "creating our own training examples as
  we go," in this case using our current policy itself to create trajectories
+ For each trajectory, add up all the rewards we get to end up with a function
  from $\theta$ to overall "return" $G$ (the sum of all the $R$ we got)
+ Update $\theta$ to try to increase $G$

# Reminder of what this looks like relative to Supervised Learning

+ Supervised learning:
    * Each training example/batch ends up with a function $f$ from $\theta$ to loss
      $L$ and then we calculate the gradient of $f$ and use that to update
      $\theta$
+ Policy gradient method:
    * Each episode/trajector (or batch of episodes/trajectories) ends up
      creating a function $f$ from $\theta$ to returns $G$ and then we calculate
      the gradient of $f$ and use that to update $\theta$

# But There are Problems

+ With our current definition of $\pi$ we don't have a differentiable function
    * Either no we decide not to perform this action in the future (so subtract
      the associated $r$ from $G$) or yes we do (keep $G$ the same)
+ No way of increasing the value of $G$!
    * We don't have "counter-factuals" other than potentially (and even this has
      problems) just subtracting out reward for actions we don't take
+ Also our information is incredibly sparse
    * A lot of times the answer will be "keep doing what you're doing!"

# Modification

+ Re-configure $\pi$ so that it always outputs probabilities of actions
+ Instead of calculating $G$ directly, calculate the expected value of $G$, that
  is just multiply all rewards by the probability output by $\pi$.
+ This is now differentiable!
+ We now have a reasonable way of increasing $G$ in a given batch of
  episodes/trajectories
    * Because probabilities must sum to 1, if we started with 0.5 and 0.5 for
      two different actions that each had reward 2 and 4, if we modify to 0.1
      and 0.9, we end up with a better overall sum.
    * This does require us to have some diversity in our batch, e.g. different
      actions taken from the same state

# Recap

+ Make your policy $\pi$ some sort of probability function
+ Generate a bunch of training examples (episodes/trajectories) by having your
  policy play the game
+ Calculate the expected returns (overall rewards multiplied by probabilities)
  of each of those episodes
+ This ends up with a function from $\theta$ to $G$. Modify $\theta$ in each
  training iteration to maximize $G$.

# REINFORCE

+ That's REINFORCE! Congrats!
+ We have a bit of a difference between what I've present and the usual update
  algorithm: $\theta_{next} = \theta + \alpha \gamma^t G_t \nabla _\theta
\text{ln}(\pi _\theta (a_t \mid s_t))$
+ I *think* what I've presented ends up being basically equivalent. But not 100%
  sure, let's discuss!
