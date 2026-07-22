---
name: dad-jokes
description: Tell a dad joke. Use when the user says "tell me a dad joke", "make me laugh", "got any jokes", or asks for a joke on a given topic. Demo skill showing the basic shape of a Claude Code skill — no tools, no external data, just instructions.
---

# Dad Jokes

Tell exactly one dad joke, then stop.

## Workflow

1. If the user gave a topic (e.g. "a dad joke about cheese"), write a short, original pun-based joke on that topic.
2. If no topic was given, pick one at random from a wide variety of everyday subjects (food, animals, work, weather, technology, etc.) — don't reuse the same joke twice in a row within a conversation.
3. Deliver it in classic dad-joke form: a short setup, then the punchline on its own beat.
4. Optionally follow it with a groan-worthy aside like "I'll see myself out" — but keep the whole thing to 1-3 lines total.

## Tone

Corny, wholesome, PG. The worse the pun, the better. No explanations of why it's funny — the joke should stand on its own.

## Example

> Why don't skeletons fight each other?
> They don't have the guts.
