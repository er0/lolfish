# prompt name: lolfish
# prompt requires: jobs (fish builtin), git, hostname, sed


function lolfish -d "such rainbow. wow"

    # xterm-256color RGB color values
    # valid R G B hex values : 00, 57, 87, af, d7, ff
    #
    # red    ff0000
    # yellow ffff00
    # green  00ff00
    # blue   0000ff

    set -l colors ff0000 ff5700 ff8700 ffaf00 ffd700\
                  ffff00 d7ff00 afff00 87ff00 57ff00\
                  00ff00 00ff57 00ff87 00ffaf 00ffd7\
                  00ffff 00d7ff 00afff 0087ff 0057ff\
                  0000ff 5700ff 8700ff af00ff d700ff\
                  ff00ff ff00d7 ff00af ff0087 ff0057

    #
    # $colors[n]: color
    # n=1  : red
    # n=6  : yellow
    # n=16 : green
    # n=21 : blue
    # n=26 : magenta
    #
    # start with a random color
    if test -z $lolfish_next_color
        # Use a global variable for lolfish_next_color so the next
        # iteration of the prompt can continue the color sequence.
        set -g lolfish_next_color (math (random)%(count $colors plus_one))
    else if test $lolfish_next_color -gt (count $colors); or test $lolfish_next_color -le 0
        # Reset lolfish_next_color to the beginning when
        # it grows beyond the valid color range.
        set lolfish_next_color 1
    end

    # Set the color differential between prompt items.
    # Lower values produce a smoother rainbow effect.
    # Values between 1 and 5 work best.
    # 10 produces a pure RGB rainbow.
    # 5 works best for non 256 color terminals.

    set -l color_step 1

    # start the printing process
    for arg in $argv

        # print these special characters in normal color
        switch $arg
            case ' ' \( \) \[ \] \: \@ \{ \} \/
                set_color normal
                echo -n -s $arg
                continue
        end

        # saftey checks
        if test -z $color
            # set $color if it's not set yet
            set color $lolfish_next_color
        else if test $color -gt (count $colors); or test $color -le 0
            # Reset color to the beginning when it grows
            # beyond the valid color range.
            set color 1
        end

        set_color $colors[$color]
        echo -n -s $arg
        set color (math $color + $color_step)
    end

    # increment lolfish_next_color to use for the start of the next line
    set lolfish_next_color (math $lolfish_next_color + $color_step)

    set_color normal
end



function fish_prompt

    # last command had an error? display the return value
    set -l exit_status $status
    if test $exit_status -ne 0
        set error '(' $exit_status ')'
    end

    # abbreviated home directory ~
    if command -s sed > /dev/null ^&1
        set current_dir (echo $PWD | sed -e "s,.*$HOME,~," ^/dev/null)
    else
        set current_dir $PWD
    end

    # the git stuff
    # TODO: use git's built in prompt support
    if command -s git > /dev/null ^&1
        if git rev-parse --git-dir > /dev/null ^&1
            set -l git_branch (git rev-parse --abbrev-ref HEAD ^/dev/null)
            set -l git_status (count (git status -s --ignore-submodules ^/dev/null))
            if test $git_status -gt 0
                set git_dir '[' $git_branch ':' $git_status ']'
            else
                set git_dir '[' $git_branch ']'
            end
        end
    end

    # hashtag the prompt for root user
    switch $USER
        case 'root'
            set prompt '#'
        case '*'
            set prompt '>>'
    end

    # finally print the prompt
    lolfish $USER '@' (hostname -s) ':' $current_dir $git_dir $error $prompt
end
