---
title: "Shortcut to Show / Hide Terminal in Visual Studio Code"
date: 2022-01-06T20:31:13+05:30
lastmod: 2022-01-06T20:31:13+05:30
categories: [code, vscode, customization]

comment: true
toc: false

---

I wanted a single keyboard shortcut that would let me switch between the built-in
terminal and the editor in vscode. I couldn't find any, so I made a short macro
using the [VSCode Macros Extension](https://marketplace.visualstudio.com/items?itemName=geddski.macros)

First, you define your macros in `settings.json`. You can open up vscode settings
with `Cmd+,`, search for `macros`, and edit this under `Macros: List`.

```json

    "macros.list": {
        "showTerminal": [
            "workbench.action.terminal.toggleTerminal",
            "workbench.action.terminal.focus",
            "workbench.action.toggleMaximizedPanel"
        ],
        "hideTerminal": [
            "workbench.action.toggleMaximizedPanel",
            "workbench.action.terminal.toggleTerminal"
        ]
    }
```

Then you can bind a keyboard shortcut to it. Open `Preferences: Open Keyboard Shortcuts (JSON)`
from the command palette, and add this:

```json
    {
        "key": "cmd+t",
        "command": "macros.showTerminal",
        "when": "!terminalFocus"
    },
    {
        "key": "cmd+t",
        "command": "macros.hideTerminal",
        "when": "terminalFocus"
    },
```

`showTerminal` gets called when you are focused anywhere in the editor except
your terminal, and `hideTerminal` gets called when you are focused on your
terminal. This gives me the 'toggle' behavior I want.