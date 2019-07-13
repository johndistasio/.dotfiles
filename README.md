# dotfiles

Homespun artisnal application configuration, the way grandad used to do it.

## Setup

Common stuff is scripted; run:

```
$ bash install.sh
```

## Manual setup

Site-local/personal stuff isn't scripted.

### git User Setup

Create `~/.gitconfig.local` as follows:

```
# vi: set ft=gitconfig:
[user]
  name = "<name>"
  email = "<email>"
```
