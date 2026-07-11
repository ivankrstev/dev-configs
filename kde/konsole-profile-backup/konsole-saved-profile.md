## Back up and restore Konsole profiles

### Back up profiles

```bash
mkdir -p ~/konsole-profile-backup
cp ~/.local/share/konsole/*.profile ~/konsole-profile-backup
cp ~/.local/share/konsole/*.colorscheme ~/konsole-profile-backup/ 2>/dev/null
```

### Restore profiles

```bash
mkdir -p ~/.local/share/konsole
cp ~/konsole-profile-backup/* ~/.local/share/konsole/
# Restart Konsole after restoring
```
