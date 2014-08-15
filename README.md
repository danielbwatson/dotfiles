dotfiles
========

Requires homeshick (https://github.com/andsens/homeshick)

```sh
git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick

source "$HOME/.homesick/repos/homeshick/homeshick.sh"

#homeshick clone git@github.com:danielbwatson/dotfiles.git
homeshick clone https://github.com/danielbwatson/dotfiles.git

homeshick link

./.homesick/repos/dotfiles/setup_system.sh home or work
```

# homebrew

```sh
brew tap homebrew/versions

for i in ack cassandra12 coreutils git kdiff3 lesspipe python reattach-to-user-namespace tmux vim; do
    brew install $i
done
```

# Fonts

Source Code Pro 14pt
https://github.com/Lokaltog/powerline-fonts

Solarized iTerm2
https://github.com/altercation/solarized/tree/master/iterm2-colors-solarized
