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
brew tap homebrew/versions homebrew/completions caskroom/cask caskroom/fonts caskroom/versions

for i in ack bash-completion brew-cask cassandra12 coreutils git lesspipe pip-completion python reattach-to-user-namespace tmux vim; do
    brew install $i
done

for i in alfred font-sauce-code-powerline gitx-rowanj google-chrome hipchat intellij-idea iterm2 kdiff3 p4merge spotify spotify-notifications vagrant virtualbox; do
    brew cask install $i
done
```

# Fonts

Source Code Pro 14pt
https://github.com/Lokaltog/powerline-fonts

Solarized iTerm2
https://github.com/altercation/solarized/tree/master/iterm2-colors-solarized
