---
title: Agent Skills
navOrder: 1
---

# Building presentations with AI agents

`flutter_deck` ships [Agent Skills](https://agentskills.io) - small, structured packages of domain knowledge that AI coding agents load on demand. They teach the agent the framework's conventions, gotchas, and idiomatic patterns so it can scaffold a new deck, add a slide, register a plugin, or restyle a theme without you having to copy-paste examples from the docs.

If you've ever asked an AI agent to "add a slide that shows this image" and it produced something that compiled but ignored `FlutterDeckSlide.image`, ignored `preloadImages`, or hard-coded a layout - that's the gap these skills are designed to close.

## Compatible agents

Agent Skills are an open, vendor-neutral format. The skills shipped with `flutter_deck` work in any compatible client, including [Claude Code](https://claude.ai/code), [Cursor](https://cursor.com), [OpenAI Codex](https://developers.openai.com/codex), [OpenCode](https://opencode.ai), [Gemini CLI](https://geminicli.com), [GitHub Copilot](https://github.com/), [VS Code](https://code.visualstudio.com/), and many [other supported agents](https://agentskills.io/clients).

## Available skills

Five skills cover the surface area of `flutter_deck`. Each is scoped to a single area so the agent loads only what's relevant to the task at hand.

- **`flutter-deck-presentation-setup`** - Scaffolding a new presentation, converting an empty Flutter project into a deck, or restructuring existing code.
- **`flutter-deck-configuration`** - Defining `FlutterDeckConfiguration` or `FlutterDeckSlideConfiguration`, choosing transitions, slide size, controls, marker, etc.
- **`flutter-deck-slides`** - Adding a new slide using one of the eight built-in factories (title, image, split, quote, bigFact, blank, template, custom).
- **`flutter-deck-theming`** - Configuring `FlutterDeckThemeData`, light/dark modes, per-slide overrides, typography, or component-level themes.
- **`flutter-deck-plugins`** - Building or wiring up `FlutterDeckPlugin`s - autoplay, PDF/PPTX export, the web client for the presenter view, custom controls.

Each skill is a folder with a `SKILL.md` file living under [`skills/`](https://github.com/mkobuolys/flutter_deck/tree/main/skills) in the repository.

## How activation works

Agents use **progressive disclosure** to manage context efficiently:

1. **Discovery** - at startup, the agent loads only the `name` and `description` of every available skill (a few hundred tokens total).
2. **Activation** - when your prompt matches a skill's description, the agent loads that skill's full `SKILL.md` body into context.
3. **Execution** - the agent follows the instructions in the skill, calling out to the framework's source or examples when needed.

This means you don't pay any context cost for skills you aren't using, and a single agent can host many skills (not just `flutter_deck`'s) at once.

## Installing the skills

Skills are managed via the [`skills`](https://www.npmjs.com/package/skills) CLI. Run the commands below from inside your `flutter_deck` project (or anywhere - they accept a project flag).

### Install all five skills

```sh
npx skills add mkobuolys/flutter_deck --all
```

This installs every `flutter_deck` skill into the current project's local agent skills directory (typically `.agents/skills/` or your client's equivalent).

### Install a specific skill

If you only want, say, the slides skill:

```sh
npx skills add mkobuolys/flutter_deck --skill flutter-deck-slides
```

### Target a specific agent or install globally

To install to a specific agent's skills directory (instead of the auto-detected default), pass `-a` / `--agent`. To install globally for your user, pass `-g`. To skip prompts, pass `-y`:

```sh
npx skills add mkobuolys/flutter_deck --skill flutter-deck-slides -a claude-code -g -y
```

### List available skills without installing

```sh
npx skills add mkobuolys/flutter_deck --list
```

### Manage installed skills

```sh
npx skills list                           # show what's installed
npx skills remove flutter-deck-slides     # uninstall a single skill
```

## Tips for working with the skills

A few things to keep in mind once the skills are installed:

- **Be specific about intent, not implementation.** "Add a slide that shows this gradient background image" works better than "use `FlutterDeckSlide.image`". The skill's description includes both natural-language phrasing and API names so triggering works either way.
- **Mention `flutter_deck` if the project context is ambiguous.** If your repo also contains non-deck Flutter code, naming the framework helps the agent pick the right skill.
- **Open the example app.** The canonical example at [`packages/flutter_deck/example/`](https://github.com/mkobuolys/flutter_deck/tree/main/packages/flutter_deck/example) is the ground truth for idiomatic usage. Many agents will read it when a skill points to it; pre-loading it in your editor speeds things up.
- **Skills don't replace the docs.** They give the agent the right defaults and warn it about non-obvious gotchas (e.g. `marker`, `slideSize`, and `templateOverrides` are globally locked - slide-level overrides are silently ignored). For deeper dives, you'll still want to read these guides yourself.

## Updating to the latest version

`npx skills add` re-fetches the latest version of the skill from the GitHub repository. Re-run any of the install commands to pull updated guidance after a new `flutter_deck` release.

## Contributing

The skills live alongside the framework in the [`skills/`](https://github.com/mkobuolys/flutter_deck/tree/main/skills) directory of the `flutter_deck` repository. If you spot incorrect guidance, missing API coverage, or a non-obvious gotcha worth surfacing, file an issue or open a PR - the same way you would for any framework code or doc change.
