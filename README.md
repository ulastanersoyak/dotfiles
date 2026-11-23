# dotfiles

my fedora + hyprland setup, built on top of [panacea](https://github.com/ensixd/panacea).

## what's here

- `.config/hypr`, `.config/panacea`: hyprland and the panacea shell, with my changes
- `.config/nvim`, `.config/fish`, `.config/foot`, `.config/zathura`, `.config/btop`, `.config/fastfetch`: everything else
- `.local/src/Panacea`: my panacea fork (`tan` branch) as a submodule
- `.local/bin/wallset`: sets wallpaper and recolors everything

## usage

this is a bare repo with your home dir as the work tree:

```sh
git clone --bare git@github.com:ulastanersoyak/dotfiles.git ~/.dotfiles
alias dot="git --git-dir ~/.dotfiles --work-tree ~"
dot checkout
dot config status.showuntrackedfiles no
dot submodule update --init
```

then use `dot add`, `dot commit`, `dot push` like normal git.

## panacea updates

panacea's updater pulls from my fork, so my changes survive. to bring in upstream:

```sh
cd ~/.local/src/Panacea
git fetch upstream && git merge upstream/main && git push
~/.config/panacea/scripts/update.sh apply
```

## gpu mode

`gpumode intel` / `gpumode nvidia`, then log out and back in. on battery it always uses intel only.
