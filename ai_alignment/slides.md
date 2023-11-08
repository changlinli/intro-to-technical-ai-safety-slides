# AI Alignment (technical AI safety)

# Brief Word about AI Safety

+ Large umbrella
+ Roughly split into:
  * AI Alignment
    - Scalable Oversight
    - Interpretibility
    - Corrigibility
    - Agent Foundations
  * AI Governance
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

# Why Is This a Problem Now?

+ The lines separating us from sci-fi are starting to blur
  * Novel challenges: analogies to 
    - Corporations as AI 
+ AI safety is socially sort of in the place where climate change was in the
  1970s
  * First Earth Day in 1970 was criticized extensively for distracting from
    the Vietnam War and the Civil Rights Movement, viewed as a plot by
    "well-heeled" professors and environmental organizations to increase their own
    prestige
  * The idea of the *entire Earth* irreversibly changing was viewed as
    impossibly far-fetched sci-fi
  * Resources accumulated by traditional fossil fuel companies has 

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

+ Scalable Oversight
+ Mechanistic Interpretability
+ Corrigibility
+ Agent Foundations

# Scalable Oversight

How do you supervise an AI that is smarter or faster than you?

Fundamental bet: solution-verification is easier than solution-generation in a
way we can leverage.

+ Sandwich test

# Mechanistic Interpretability

How do we leverage the fact that we can examine the "brains" of an AI directly?

Fundamental bet: there are abstract structures that tend to appear in many
different intelligent systems that have commonalities we can explain and
understand.

+ Circuits work
+ Consistency checks on LLMs

# Corrigibility

If/when an AI makes a mistake, how do we ensure that the mistake it makes does
not wipe out our ability to correct the AI in the future?

# Agent Foundations

How exactly do we formalize safety? Can we come up with alternative architectures that are fundamentally safer?

# Inner vs Outer Alignment

+ Outer alignment/mis-specification: your specification was subtly wrong
+ Inner alignment/goal misgeneralization: the AI doesn't do what you specified
