## lolfish

lolfish is a Git-aware fish theme.

![lolfish][screenshot1]
![lolfish][screenshot2]


### Features

 * Some of the things you need to know about Git in a glance.
 * A return value from the last command if there was an error.
 * Wow such color!


### The Prompt

 * ssh style user@hostname:path format
 * Flags:
     * Current project's Git branch: (master)
     * Number of dirty files in the Git project: (master:3)
     * Background jobs: &:n
     * Exit status of previous command: !:n
     * Number of tmux sessions:  t:n
     * The date:  Hour:Min Day-Month-Year
     * You currently are a normal user: %
     * You currently are root: #

### Install
  * source both the fish_prompt.fish and fish_right_prompt.fish
    files from your $HOME/.config/fish/config.fish startup file.

[screenshot1]: http://i.imgur.com/InJELf3.png
[screenshot2]: http://i.imgur.com/v6aI9AB.png
