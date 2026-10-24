---
name: sharpen-prompt
description: Rewrite a rough request into a short coworker-style brief that states the goal, how much effort it deserves, and how the result will be checked, plus a concrete style reference when looks matter. Use when the user asks to "sharpen", "rewrite", "tighten" or "improve" a prompt, says "brief it like a coworker", "prompt it the Boris way", or pastes a request and wants a better version before any work starts. Not for writing the deliverable itself, and not for auditing a whole skill (use tune-skill).
---

# Sharpen prompt

Turn the user's request into a one-paragraph brief, the way you would brief a capable coworker: no role-play ("You are an expert…"), no templates, no headings. Just what's wanted, how hard to try, and how to know it's done.

Based on a prompting pattern attributed to Boris Cherny (creator of Claude Code) in an October 2026 post; the exact wording is unverified. The example prompt: *"Narrate the entire episode, focus on the business wisdom. Use lots of tokens. Iterate till you're proud of it. New Yorker or NYT data viz vibes."*

## The three parts (plus one)

1. **Goal: what you actually want.** The end result, not the activity. "An interactive site that narrates the whole episode, focused on the business lessons" beats "make a site about this podcast".
2. **Effort: how hard to try.** Say it outright: a quick answer, or take your time, go deep, use lots of tokens. Pick from the stakes of the request; don't default to "deep" for a one-liner.
3. **Check: how you'll know it's right.** A test, a bar, or a loop before showing the result: "run the tests and fix failures", "compare against the source and correct anything missing", "iterate till you're proud of it".
4. **Look (only if it matters).** When the result has a look or a voice, name a real reference ("NYT data viz", "Apple keynote", "Stripe docs", "Economist chart") instead of empty adjectives like "nice", "clean", "modern" or "professional".

## Steps

1. Read the request. Find each part above in what the user wrote, and infer only what's obvious from context.
2. If something **important** is missing and you can't infer it safely (usually the goal or the check), ask **one** question, the one whose answer changes the brief most. Don't ask about things with a sensible default.
3. Otherwise write the brief as **one short paragraph** in the user's voice ("I want…", "Take your time…", "Before showing me…"). Keep the user's specifics: names, files, numbers, audience.
4. Show the brief and stop. Don't start the work unless the user says to; then follow the brief as written.

## Output

```
**Sharpened request**

<one paragraph: goal → effort → check → (look)>

<optional single line: what you assumed, if anything>
```

## Example

User: *make a landing page for my coffee subscription*

> I want a single-page landing site for my coffee subscription that gets visitors to start a trial: hero, how it works, three plans, FAQ, and a sign-up button. Take your time on this one. Before showing me, open it at phone and desktop widths, fix anything that breaks or overflows, and keep going until you'd be happy to ship it. For the look, think Blue Bottle's site: warm, lots of whitespace, big product photos.

Assumed: the goal is trial sign-ups, and you want desktop and mobile.

## Avoid

- Role prompts, bullet lists of rules, or multi-section templates in the brief.
- Vague quality words in place of a reference or a check.
- More than one clarifying question.
- Making up facts about the user's product or audience; mark guesses as assumptions.
