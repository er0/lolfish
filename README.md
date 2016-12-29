# lolfish

such rainbow, wow.

![lolfish][screenshot1]
![lolfish][screenshot2]

## Easy Install

Using [oh-my-fish](https://github.com/oh-my-fish/oh-my-fish):

```fish
omf theme lolfish
```
### Less Easy Install

Download both left and right prompts source files, and
Source the prompt files from your primary fish config:

```Bash
mkdir -p $HOME/.config/fish
wget -O $HOME/.config/fish/lolfish_prompt.fish https://github.com/er0/lolfish/raw/master/fish_prompt.fish
wget -O $HOME/.config/fish/lolfish_right_prompt.fish https://github.com/er0/lolfish/raw/master/fish_right_prompt.fish
echo "source $HOME/.config/fish/lolfish_prompt.fish" >> $HOME/.config/fish/config.fish
echo "source $HOME/.config/fish/lolfish_right_prompt.fish" >> $HOME/.config/fish/config.fish
```

## Features

  * Only the best rainbow xterm colors!
  * git branch/status info
  * Return value from the last command
  * Right prompt displays number of backgrounded jobs, tmux sessions, and the time.

[screenshot1]: http://i.imgur.com/InJELf3.png
[screenshot2]: http://i.imgur.com/v6aI9AB.png
