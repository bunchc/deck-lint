# Kong Deck File Linting with Spectral

This project uses [Spectral](https://stoplight.io/open-source/spectral/), a flexible JSON/YAML linter, to validate Kong Declarative Configuration (Deck) files against custom rules.

## Installation

First, you need to install Spectral. If you have Node.js installed, you can install Spectral globally on your machine by running:

```bash
npm install -g @stoplight/spectral
```

## Usage

Once Spectral is installed, you can use it to lint your Kong Deck files with the custom rules defined in `plugin-update-check.yaml`.

1. Clone this repo
2. Install Spectral
3. Run `spectral lint` from within this project's directory (see example below)

To do this, run the following command:

```bash
spectral lint -r plugin-update-check.yaml your-deck-file.yaml
```

Replace `your-deck-file.yaml` with the path to the Kong Deck file you want to lint.

## Custom Rules

The custom rules for linting are defined in `plugin-update-check.yaml`. This ruleset checks for plugins with schema changes for Kong 3.x and ensures they are configured correctly.

For more information on how to modify these rules or add new ones, check out the [Spectral rulesets documentation](https://stoplight.io/p/docs/gh/stoplightio/spectral/docs/guides/7-authoring-rulesets.md).
