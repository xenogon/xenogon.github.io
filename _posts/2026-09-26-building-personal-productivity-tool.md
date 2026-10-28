---
title: "I Have a Reading Problem"
date: "2026-09-26"
draft: false
description: "And I've decided to finally try to do something about it."
tags: ""
categories: ""
toc: false
---

I want to be an avid reader and explore more topics related to my field, but **I'm struggling to break out of a negative spiral of my own making.** My attention span is short, I get overwhelmed by the pace at which new information gets published, but I'm stubborn about continuing to learn how to be better at what I do.

The stuff that catches my eye is usually related to my work, which is mainly data engineering and architecture. With LLMs dominating the tech world the last three years (more or less), my horizon for what content feels relevant to what I do has broadened. Add to that the fact that I was never trained to be an engineer; I haven't spent over ten years learning the craft from mentors and manually writing all the code for every single project I was a part of, getting my lumps "the hard way". In fact, the trajectory of my career as it stands is boosted a fair bit by the emergence of agent coding harnesses and the increasing capability of the models they run on.

What typically happens is that I catch a glimpse of something interesting, skim the first few paragraphs, then open a browser tab or download the file so that I will remember to come back to it later and read it in full. Before I ever get to that point, another bunch of pieces of content or even personal ideas and reflections have already come and gone. Reading something from start to finish now feels like way more intimidating because I am facing a collection of content that touches on similar themes and topics, instead of one think piece that I can consider canon. So instead, I hesitate and procrastinate.

My reading backlog just keeps piling up across all my devices; in browser tabs, piles of paper, YouTube's Watch Later playlist, sketchpads, Spotify saved podcasts, notes apps. And as I feel an increasing mixture of panic and disgust over this habit, I can't escapte the feeling that there is some sort of compunded knowledge that could be synthesized from all of it somehow, some way, if I only had the time and patience to do it.

None of what I jot down myself is complex and I don't believe most of what I want to read from others is particularly ground breaking. I just need help to see what I have thrown into my content pile, how it relates to my interests and which claims it can all be distilled into. If I can find a way to achieve this, it would be a huge source of personal pride.

Sure, there's probably already a set of tools that I could pick up and adapt to my needs with some practice (I already tried Obsidian and even began customizing it, then failed to integrate it into my ways of working) but where's the challenge in that? I will do my best to turn it into one of those classic *learning opportunities*.

***

What I will attempt to do is build a system for my personal use that will serve three purposes:
  1. help me collect and clean up every piece of reading material I stumble upon across all my devices
  2. nudge me into maintaining a reading discipline and point me towards the key insights I need to understand
  3. guide me when I look for the right thing to read and surface commonalities that I might have missed

The first key factor that I will try to optimise the system for will be **accuracy**. The worst possible scenario I can imagine is putting time into building a prototype, beginning to dogfood it and then realising that the synthesized output is missing the mark by a wide margin. Speed is also not a game changer, because the pattern I have observed in myself is that I find stuff that I want to save for later over the course of the day, set them aside, then intend to review them when I have a spare moment or when a relevant problem comes up at work. I expect this behavioural pattern to stay unchanged, which means there is no urgency for the system to produce output, it's more important to keep mistakes to a minimum so that I can trust what I consume.

The second will be **friction**, in the sense of the ease of use of the system. This is on par with accuracy in terms of importance, because the output hinges on what I curate as input. The bar for putting new content into the system has to be on the ground floor. I am already too lazy to actually put things like URLs into anything else than a fresh Chrome tab. Additionally, I need to able to use feed the system from both my laptop and smartphone, at the very least. I don't discover items of interest on only one device. Lastly, the system needs to support collecting content from a few different types of sources. At the very least, it should probably cover generic blogs, Github repositories, Youtube videos and PDF publications; all accessible via URL.

The third will be **cost**, since I don't want to sink hundreds of dollars into running cloud infrastructure before I can even prove to myself that this has an impact on my behaviour. I am certainly willing to burn some personal money up front to see if I my idea can get off the ground, but that investment will likely be made in the form of one monthly frontier coding agent subscription, some open source LLM API credits and a tightly budgeted proof of concept infrastructure. The goal is to lean on open source software as much as possible and have a coding agent build the backend with zero external dependencies.

I intend for the core usage loop to start at the current point of failure, which is that most potential reading material that I come across becomes a lost browser tab. I am not even properly capturing the intent and preserving it anwyhere. If I think of this as a failing workflow, the system I build needs to more or less effortlessly allow me to take all the content that is currently dead ending and divert into a new branch that automatically does something with it. At the very least, that would mean parsing the source into markdown and dumping a file into some cloud object storage.

***

To keep a low threshold for me to use my own system it needs to offer multiple ways to send a pointer to a source into the backend, a blog post URL, for example. The backend's main function would then be to follow the pointer, parse the source at the end of it and write to storage. A  pipeline for transforming HTML into Markdown would be the first thing to solidify. Once that seems reliable, I could add an extra step using an LLM provider API that supports structured output in order to generate summaries for each parsed source, turning it into a de facto LLM pipeline. I imagine these summaries being useful for a person or agent exploring the documents stored to quickly get a sense of what they're about.

Since the amount of data that the early version of the system will collect will be small (the actual documents written into storage numbering in the hundreds, at most) I am not even going to look at doing vector embeddings or RAG implementations. Even a model like GPT‑4.1 nano now has a context window of over 1,000,000 tokens. If I can design at least one simple mechanism for agents to judge what documents are about without reading the full body, then that should be enough. In my experience, agents are fairly greedy in collecting context before producing a response. The key will be to hand the right mix of system prompt, tools and structure to any agent that operates on the stored documents. My belief is that agents perform better when they are given the freedom to "problem solve" within certain boundaries, using a toolset that lets them both progressively explore their surroundings as well as quickly iterate on their goal.

I also don't think the expected document volume will be big enough to motivate generating something like a large knowledge graph. There are ready made libraries for this, but the technical cost probably outweights the benefits. I could of course be totally wrong about this, but I am betting that what will be enough is some kind of solution that combines parts of Andrej Karpathy's conceptual LLM Wiki framework with a custom ontology that can be serialised into a format that is agent friendly. By the time I have anything approaching a working prototype, there might also be new document types or formats that are more tailored to my use case than basic Markdown. There's a decent chance that granting an agent fairly open-ended tools, gating the tool calls with typed data models and then forcing it to validate output using an pre-defined ontology before writing data, is good enough for my needs.

The assumption is that the system will have an agent runtime for certain tasks, because part of the goal is to automate the maintenace of the library. This will require an agent loop with the capability to make changes to the corpus, except for the raw sources. This agent doesn't need an interactive chat interface to start, only a way to defer certain operations for my approval or surface issues that require my attention. It will be given a box to act in, but in that box I want to grant it quite a lot of freedom, not least because I expect that it will fail to produce accurate results some of the time. What it does is probabilistic, after all. To help it improve decision making over time, the system will need to guarantee that all the agent's actions will produce execution traces and let the agent read them.

***

I'm pretty sure that a proper solution that I can both make a habit of using and that makes me more knowledgeable will not be something that I can knock out quickly. I have limited free time so I will definitely use coding agents to make a dent in the problem, but it will still take some time. There is a good deal of reading and testing that I will need to do in order to direct the work and understand to results.

Some topics that I expect to have to familiarise myself with more or read about for the first time:
- Web scraping
- Unstructured data
- Text standardization
- Text summarisation
- Semantic clustering
- Text retrieval (without RAG)
- Ontologies
- OpenAI-compatible LLM APIs
- Agent workflows
- Agent loops
- Agent execution traces
- Full-stack applications

As soon as I am able to produce a working protoype, I will make it part of the work moving forward. It could basically serve as a way to collect and summarise a bunch of research, maybe even together with my own thoughts saved as annotations or notes. That will be a great way to see if what I am building helps me get better at building it.
