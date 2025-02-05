# DeepSeek r1

# What is it?

+ A new "reasoning" AI from the Chinese company DeepSeek
+ Takes world by storm, kind of for hype reasons
    * It's not terribly surprising for industry people
    * Sort of similar to how ChatGPT wasn't surprising for anyone who played
      with GPT-3

# Why is it significant?

+ Open source
    * Although with some important details still hidden
    * Exact RL training regimen
    * Training set data
+ Apparently done for cheap (but not crazy cheap)
    * $5.6 million dollars for training DeepSeek v3
    * _NOT_ for company
    * _NOT_ for all model training
    * So cheap, but not as crazy cheap as some people are hyping it up
+ Dealing with memory bandwidth constraints
    * H800s vs H100s

# "Reasoning" AI

+ All LLMs seem to do better with chain of thought
+ Can we optimize chain of thought?
+ Leads to reasoning AIs

# How LLMs are trained

+ Pre-training
+ (Supervised Fine-Tuning) SFT
+ RL (this is where "reasoning" AI stuff mainly comes in)

# Finetuning vs Training

+ Not really fundamentally different
+ Finetuning is just "training-lite"
    * Freeze parts of the network
    B* Limit magnitude of parameter updates

# Role of RL vs just SFT

+ RL empirically seems to work better
+ We don't *really* understand why RL works better, but we have hand-wavy
  theories
    * Most compelling one to me is that RL allows for negative reinforcement

# Exact innovations

+ Reuses MoE architecture that is all the rage these days
    * Mixture of Experts is not what you think it is
+ New RL algorithm: GRPO vs PPO
+ "Mult-head Latent Attention" (from DeepSeek v2 and v3)
+ R1 zero vs R1 (R1 zero skips SFT)

# Interesting things that happened

+ R1 Zero results in pretty crazy, hard to interpret reasoning "traces"
    * This is bad for safety
+ But R1 Zero still working is pretty wild

# What does this mean for AI/AI safety

+ Pretraining data running out seems to not really be an issue
+ Timelines might be short
