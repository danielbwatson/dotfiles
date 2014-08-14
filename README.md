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
