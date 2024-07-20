# Goals of this intro talk

+ Briefly go over today's schedule
+ AI "Situational Awareness"
+ In light of that, what is AI safety

# General overview of today

+ We'll have three tracks with breaks in-between
+ Lot of pair programming for technical tracks
+ Lot of discussion groups for non-technical track

# Non-technical track (exploring AI safety and governance)

+ 11:00 - 11:15 a.m.: Kick off talk and mingling
+ 11:15 a.m. - 12:15 p.m.: Fundamentals of AI and AI safety
+ 12:15 p.m. - 1 p.m.: Break (lunch not included; lunch spots nearby) + mingling (potential tech help for people who want to do the technical tracks)
+ 1 p.m. - 5 p.m.: Guided reading and discussion group on AI safety topics
    * Selected readings for discussion and critique of 4 topics, each approximately will have an hour of time including breaks scheduled at the end
        - Company safety statements from frontier AI labs
        - Deeper dive into current state of AI and regulation
        - Examining public requests for comment from government agencies
	    - Talking about how you can get involved

# Technical track (building an LLM from scratch)

+ 11:00 - 11:15 a.m.: Kick off talk and mingling
+ 11:15 a.m. - 12:15 p.m.: Fundamentals of AI and AI safety
+ 12:15 p.m. - 1 p.m.: Break (lunch not included; lunch spots nearby) + mingling (potential tech help for people who want to do the technical tracks)
+ 1 p.m. - 1:30 p.m.: Lecture on GPT-2 and the transformer architecture
+ 1:30 p.m. - 5 p.m.: Pair programming sessions with other participants to build GPT-2

# Technical track (analyzing an LLM from scratch)

+ 11:00 - 11:15 a.m.: Kick off talk and mingling
+ 11:15 a.m. - 12:15 p.m. (12:00 p.m.): Fundamentals (led by Mackenzie)
+ 12:15 p.m. - 1 p.m.: Break (lunch not included; lunch spots nearby) + mingling (potential tech help for people who want to do the technical tracks)
+ 1 p.m. - 1:30 p.m.: Lecture on GPT-2 and the transformer architecture (good refresher before we dive into analysis)
+ 1:30 p.m. - 1:45 p.m.: Break
+ 1:45 p.m. - 2:15 p.m.: Lecture on analyzing the transformer architecture mathematically
+ 2:15 p.m. - 5 p.m.: Pair programming sessions with other participants to analyze an LLM

# The Current State of AI

There is a big gap between what AI researchers at top labs believe and what the
general public believes, i.e. a big gap in "situational awareness"

> By 2025/26, these machines will outpace college graduates. By the end of the
> decade, they will be smarter than you or I [sic]...
>
> Everyone is now talking about AI, but few have the faintest glimmer of what is
> about to hit them. Nvidia analysts still think 2024 might be close to the
> peak. Mainstream pundits are stuck on the willful blindness of "it's just
> predicitng the next word"
>
> Before long, the world will wake up. But right now, there are perhaps a few
> hundred people, most of them in San Francisco and AI labs, that have
> *situational awareness*.... [they] correctly predict[ed] the AI advances of
> the past few years. Whether these people are also right about the next few
> years remains to be seen. But these are very smart people -- the smartest
> people I have ever met -- and they are the ones building the technology.... If
> they are seeing the future even close to correctly, we are in for a wild ride.
>
> *Leopold Aschenbrenner, Former OpenAI researcher, June 2024*


# Thoughts on Situational Awareness

+ There is a big gap between what AI researchers at top labs believe and what
  the general public believes
+ Only several hundred people having "situational awareness" is bad, this
  technology will affect everyone
+ People deserve to know about and form opinions about crazy things that might
  be happening before those things smash into them

# Progress in AI has been extremely rapid

+ 19 months ago ChatGPT was released
    * Hacky product
    * Still fastest product launch ever
    * By today's standards a terrible AI
+ Since then, we have had roughly *three* more generations of LLMs each of which
  blows the previous out of the water
    * GPT-4, GPT-4o (this was mostly a speed improvement over a perf
      improvement), Claude 3.5, (GPT-5 is currently training and will likely
      finish its training in another few weeks; likely several more months until
      it's ready for prime time)

# Demos

+ The easy failures of ChatGPT have long since been corrected
+ You are reading a book. You have a bookmark on page 120. A friend picks up the book and moves the bookmark to page 145. When you return to the book, what page do you expect to find the bookmark on?
+ ![failure of theory of mind example](./theory_of_mind_failure_chatgpt_3.jpg)
+ Which is heavier, 10 kg of iron or 10 kg of cotton?
+ ![iron or cotton failure](./iron_or_cotton.jpg)

# Broadly Superhuman AI is coming soon

> These next three years might be the last few years that I work. I am not ill,
> nor am I becoming a stay-at-home mom, nor have I been so financially fortunate
> to be on the brink of voluntary retirement. I stand at the edge of a
> technological development that seems likely, should it arrive, to end
> employment as I know it. 
>
> *Avital Balwit, Chief of Staff to the CEO of Anthropic*

[https://www.palladiummag.com/2024/05/17/my-last-five-years-of-work/](https://www.palladiummag.com/2024/05/17/my-last-five-years-of-work/)

# We're not on track for it to go well

+ Enormous misbalance in resources allocated to safety vs capabilities
+ U.S. AISI expected to be funded according to Schumer et al. up to 10 million
  dollars
    * Salary of only a few researchers at top AI labs
+ AI experts are worried because *nobody* really understands how these AI
  systems work
    * Turing Award winner [Yoshua Bengio](https://yoshuabengio.org/2024/07/09/reasoning-through-arguments-against-taking-ai-safety-seriously/): "...while we are racing towards AGI or even ASI, nobody currently knows how such an AGI or ASI could be made to behave morally, or at least behave as intended by its developers and not turn against humans.. As of now, however, we are racing towards a world with entities that are smarter than humans and pursue their own goals – without a reliable method for humans to ensure those goals are compatible with human goals."
+ And AI experts are worried about things going very wrong:
    * Median response to this question was 10% from this [survey](https://blog.aiimpacts.org/p/2023-ai-survey-of-2778-six-things): "What probability do you put on human inability to control future advanced AI systems causing human extinction or similarly permanent and severe disempowerment of the human species?"

# The pace of improvement is increasing

+ Remember that now is the worst AI will ever be
+ Pace of AI improvement is quickening, not slowing

# Don't fall into the trap of "status quo" thinking

Don't be like these people!

> I'm part of an "AI Futures" group at an intergov org whose purpose is to
> consider the long-term implications of the tech.... [2/3 of them] imagine AI in
> 2040 as having today's capabilities and no more. [@danfaggella]

[https://x.com/danfaggella/status/1812171380449763430](https://x.com/danfaggella/status/1812171380449763430)

# So what is "AI Safety?"

+ Broadly the field that encompasses making sure that a lot of the above goes
  well!
+ This includes:
    * Worsening of current societal problems
    * Mass unemployment/economic disruption
    * Mass catastrophe/loss of life scenarios/destruction of the human race

# If you're interested in this what can you do?

+ Need people to know about this and talk about it and get involved in making
  sure that the right governance controls are in place!
    * We'll also be going over that today
+ If you have a technical background, jump into technical research!
    * We'll be going over some of that today!
