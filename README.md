## lolfish

lolfish is a Git-aware fish theme inspired by [lolcat][lolcat] and [bobthefish][bobthefish].

![lolfish][screenshot1]
![lolfish][screenshot2]

You will not need any special patched fonts for this to work.


### Features

 * Some of the things you need to know about Git in a glance.
 * A return value from the last command if there was an error.
 * Wow such color


### The Prompt

 * ssh style user@hostname:path format
 * Flags:
     * Current project's Git branch: (master)
     * Number of dirty files in the Git project: (master:3)
     * Background jobs: &[n]
     * Exit status of previous command: !![n]
     * You currently are a normal user: %
     * You currently are root: #

[screenshot1]: http://i.imgur.com/InJELf3.png
[screenshot2]: http://i.imgur.com/v6aI9AB.png
[lolcat]:     https://github.com/tehmaze/lolcat
[bobthefish]: https://github.com/bpinto/oh-my-fish/tree/master/themes/bobthefish  
