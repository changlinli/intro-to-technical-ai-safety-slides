# AI Alignment (technical AI safety)

# Brief Word about AI Safety

+ Large umbrella
+ Roughly split into:
  * Technical work (roughly associated with the term "AI alignment," although governance can play a role
    - Scalable Oversight
    - Interpretibility
    - Corrigibility
    - Agent Foundations
  * Social and 
    - AI Development Policy
    - AI Ethics
    - AI Safety Funding

# How could AI go wrong?

+ Entrench pre-existing problems in society
  * Fully automatic bias and prejudice
  * Centralization of power and wealth
+ Gradual disempowerment
  * Find it impossible for any humans
+ Direct loss-of-life catastrophes

# What is AI Alignment

+ How do we make AI do what a human wants it to do?
+ AI alignment sets aside who the human is (that is part of AI governance)
+ Can we make AI align with *any* human at all?

# Why Is This Hard?

+ Current AI paradigms are very "black-box"-y
  * Difficult to understand why an AI system "decides" to do something
  * AI/ML is built extensively on hand-wavy intuition and experimentation
    - Very little solid reasoning
+ Empirical evidence of AI going poorly
  * Cruise self-driving car 
+ We don't seem to get a lot of chances
  * Potential self-reinforcing improvement cycles ("takeoff")

# AI Governance

+ Government Policy
+ Technical work too!
  * Certain regulations would require technical advancements
    - If you want to monitor AI training runs, you need to be able to reliably
      detect when a certain workload is an AI training run

# Important AI-related Questions Outside the Scope of AI Safety

Many "internal" questions are very profound and valuable in and of themselves,
but not of immediate relevance for AI safety.

+ Is AI truly intelligent?
+ Does AI really demonstrate creativity?
+ To what extent is AI just "pretending," to what extent is it just a stochastic
  parrot?

# AI Safety is Focused Primarily on External Questions

__An AI that can pretend sufficiently well to be intelligent has many of the
same practical problems that a truly intelligent entity does. Stochastic parrots
can still kill you.__

Hence AI safety as a field does not usually spend too much distinguishing
between that which only externally "seems" to be intelligent and is in fact
internally "empty" vs "truly" intelligent entities.


# What would a solution look like in AI alignment?

Pre-paradigmatic: no single answer. But we have some ideas:

+ Be able to establish tight bounds on the behavior of superhuman AI
  * Make sure that it won't do crazy things in the moment
  * Make sure that over long
  * Make sure that these hold as bounds on the AI itself, rather than just the
    systems it's hooked up to
+ Come up with firm formalizations of what it means

# Why do we suspect that AI alignment is even possible?

+ We have access to all the moving parts
+ In many other domains, supervision and correction of a system seems to require
  less power than the system itself
  * E.g. P vs NP (verifying correctness of an answer easier than calculating the
    answer)
+ Remember things are pre-paradigmatic (really AI as a whole is
  pre-paradigmatic!) so a lot of hand-waving

# AI Alignment Redux

Some concepts that show up often:

+ Scalable Oversight
+ Mechanistic Interpretability
+ Evaluations
+ Agent Foundations
+ Inner vs Outer Alignment

# Scalable Oversight

How do you supervise an AI that is smarter or faster than you?

Fundamental bet: solution-verification is easier than solution-generation in a
way we can leverage.

+ Can we empower hybrid human-AI systems?
    * This does not seem to be a stable equilibrium (see chess engines
      eventually out-competing human-computer hybrid systems), but maybe is an
      important bridge
+ How do we effectively supervise AI systems in regimes that are too quick, too costly, or outright too complex for human evaluation?

# Mechanistic Interpretability

How do we leverage the fact that we can examine the "brains" of an AI directly?

Fundamental bet: there are abstract structures that tend to appear in many
different intelligent systems that have commonalities we can explain and
understand.

+ Circuits work
    * Golden Gate Claude!
+ Consistency checks on LLMs

# Evaluations

What kind of evaluations make sense for new AI systems?

+ Old evaluations are rapidly becoming obsolete (AI progress is sometimes hidden by the fact that a test tops out at 100% so going from 98% to 99% might be a huge leap in capabilities but looks unimpressive)
+ How can we use new advancements in AI safety to design better evaluations?
+ How do we reduce chances of gaming the system?
+ What kind of evaluations should we use for regulations?

# Agent Foundations

+ What does it mean for something to be an agent?
+ Can we get a good formal mathematical foundation for what it means for something to be aligned?

# Inner vs Outer Alignment

+ Outer alignment/mis-specification: your specification was subtly wrong
+ Inner alignment/goal misgeneralization: the AI doesn't do what you specified

# Why is this important now?

+ *There is still a lot of uncertainty, but there is enough worry that superhuman AI might be coming soon*
+ Time until we get broadly superhuman AI might be very short (3 - 5 years)
    * The top AI labs seem to be broadly in agreement on this
        - John Schulman (co-founder of OpenAI) estimates his job is obsoleted in a median of 5 years
        - Anthropic's CISO thinks that ASL-3 (low-level autonomous capability) happens
        - Anthropic's Chief of Staff to the CEO has publicly talked about this "I am 25. These next three years might be "
    * Top AI researchers generally seem to agree that we're nowhere close to
      exhausting "low-hanging fruit" and expect next-gen models, e.g. GPT-5, to
      be radically better than current-gen models
    * Some of our 
+ Even "longer timelines" no longer look that large
    * The overwhelming majority of AI researchers expect AGI to be developed within the lifetimes of today's working professionals
+ We're dealing with exponential growth curves
    * With exponential curves, any response usually seems either too early or too late, more or less impossible to tune it "just right"
+ Remember: The AI of today is the worst AI will ever be
+ Things might still fizzle out! But it seems very unwise to rely on that

# Increasing awareness of short timelines in AI safety-adjacent fields

+ From Anthropic's Chief of Staff to the CEO published an article about [this](https://www.palladiummag.com/2024/05/17/my-last-five-years-of-work/):
  > These next three years might be the last few years that I work. I am not ill, nor am I becoming a stay-at-home mom, nor have I been so financially fortunate to be on the brink of voluntary retirement. I stand at the edge of a technological development that seems likely, should it arrive, to end employment as I know it.
+ From Anton Korinek (professor of econ at University of Virginia working on economics of AI):
  > Scenario I (traditional, business as usual), Scenario II ()

# The future could get very wild very soon

+ Lines separating us from sci-fi start looking very blurry
+ It's noticeable that worlds like Futurama are kicked around as what happens if things

# What to do?

+ Concern is good. Panic is not.
+ Educate yourself about AI
    * Good to know even just as a technologist
+ Learn more about AI safety 
+ Think about what kind of futures you want, what kind of futures you don't
  want, and what kind of futures you think are most likely to happen

# Big takeaways

+ *Big* things could be happening
+ They are unlikely to go well by default
+ There's a lot of fertile ground for work to be done
+ The only way out is through
