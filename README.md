## lolfish

such rainbow, wow.

![lolfish][screenshot1]
![lolfish][screenshot2]


### Features

  * git branch/status info while PWD in git repositories
  * Only the most rainbow friendly xterm colors!
  * Return value from the last command if there was an error.
  * Right prompt displays backgrounded jobs, backgrounded tmux sessions, and the time.
  * Compact and scp friendly user@hostname:path format
  * rainbow


### The Prompt

## Left Prompt:
  * username@short_hostname:path
  * Git branch: [master]
  * Git status: [master:3]
  * Exit status of previous command on error: (127)
  * You currently are not root:  >>
  * You currently are root:  #

## Right Prompt:
  * Background jobs: [&:2]
  * Number of tmux sessions: [tmux:7]
  * The date:  Hour:Min Day-Month-Year


### Install

## Download both left and right prompts source files

  ```
  wget -O $HOME/.config/fish/lolfish_prompt.fish       https://github.com/er0/lolfish/raw/master/fish_prompt.fish
  wget -O $HOME/.config/fish/lolfish_right_prompt.fish https://github.com/er0/lolfish/raw/master/fish_right_prompt.fish
  ```

## Source the prompt files from your primary fish config
  ```
  echo "source $HOME/.config/fish/lolfish_prompt.fish"       >> $HOME/.config/fish/config.fish
  echo "source $HOME/.config/fish/lolfish_right_prompt.fish" >> $HOME/.config/fish/config.fish
  ```

[screenshot1]: http://i.imgur.com/InJELf3.png
[screenshot2]: http://i.imgur.com/v6aI9AB.png
