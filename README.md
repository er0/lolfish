# lolfish

such rainbow, wow.

![lolfish][screenshot1]
![lolfish][screenshot2]

## Easy Install

Using [oh-my-fish](https://github.com/oh-my-fish/oh-my-fish):

```Bash
omf theme lolfish
```
### Less Easy Install

Download and source the prompt file

```Bash
mkdir -p $HOME/.config/fish
wget -O $HOME/.config/fish/lol.fish https://github.com/er0/lolfish/raw/master/lol.fish
echo "source $HOME/.config/fish/lol.fish" >> $HOME/.config/fish/config.fish
```

## Features

  * Only the best rainbow xterm colors!
  * git branch/status info
  * Return value from the last command
  * Right prompt displays number of backgrounded jobs, tmux sessions, and the time.

[screenshot1]: http://i.imgur.com/InJELf3.png
[screenshot2]: http://i.imgur.com/v6aI9AB.png
