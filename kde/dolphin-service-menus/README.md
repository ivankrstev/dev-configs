## Dolphin Right-Click Context Menus

Custom KDE Dolphin service menus that add actions to the file and folder right-click context menu,
stored in:

```text
~/.local/share/kio/servicemenus/
```

Included actions:

- `open-folder-in-konsole.desktop` — opens the selected folder in Konsole.
- `open-with-vscode.desktop` — opens the selected file or folder in VS Code.
- `view-disk-usage.desktop` — opens the selected folder in Filelight.

The internal action IDs use `a_`, `b_`, and `c_` prefixes to control their order in Dolphin's context menu.

### Installation

```bash
mkdir -p ~/.local/share/kio/servicemenus
cp *.desktop ~/.local/share/kio/servicemenus/
chmod +x ~/.local/share/kio/servicemenus/*.desktop
kbuildsycoca6 --noincremental
```

Reopen Dolphin after installation.
