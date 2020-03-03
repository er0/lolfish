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
    if test -z $lolfish_next_color; or \
       test $lolfish_next_color -gt (count $colors); or \
       test $lolfish_next_color -le 0
         # set to red
         set -g lolfish_next_color 1
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
        # set $color if it's not set yet
        if test -z $color
            set color $lolfish_next_color
        # Reset color to the beginning when it grows
        # beyond the valid color range.
        else if test $color -gt (count $colors); or test $color -le 0
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


# Left side prompt
#
# Displays user@hostname:/path
# Displays git status
# Displays exit status of previous command

function fish_prompt

    # last command had an error? display the return value
    set -l exit_status $status
    if test $exit_status -ne 0
        set error '(' $exit_status ')'
    end

    # abbreviated home directory ~
    if command -s sed > /dev/null 2>&1
        set current_dir (echo $PWD | sed -e "s,.*$HOME,~," 2>/dev/null)
    else
        set current_dir $PWD
    end

    # the git stuff
    # TODO: use git's built in prompt support
    if command -s git > /dev/null 2>&1
        if git rev-parse --git-dir > /dev/null 2>&1
            set -l git_branch (git rev-parse --abbrev-ref HEAD 2>/dev/null)
            set -l git_status (count (git status -s --ignore-submodules 2>/dev/null))
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
    lolfish $USER '@' (hostname -s) ':' $current_dir $git_dir $error $prompt ' '
end

# Right side prompt
#
# Displays the number of background processes [&:2]
# Displays the number of active tmux sessions [tmux:4]
# Displays the time and date in Minute:Hour Day:Month:Year

function fish_right_prompt

    #
    # background jobs
    #
    set -l background_jobs (count (jobs -p >/dev/null))
    if test $background_jobs -gt 0
        set background_jobs_prompt '[' '&' ':' $background_jobs ']'
    end

    #
    # Display the number of background tmux sessions
    # only if the shell is running outside of tmux
    #
    if test -z $TMUX
        if command -s tmux > /dev/null 2>&1
            set -l tmux_sessions (count (tmux list-sessions >/dev/null))
            if test $tmux_sessions -gt 0
                set tmux_sessions_prompt '[' 'tmux' ':' $tmux_sessions ']'
            end
        end
    end

    #
    # Display the time and date
    #
    if command -s date > /dev/null 2>&1
        set time (date +'%H:%M' 2>/dev/null)
        set date (date +'%d-%m-%Y' 2>/dev/null)
    end

    lolfish $background_jobs_prompt $tmux_sessions_prompt $time ' ' $date
end
