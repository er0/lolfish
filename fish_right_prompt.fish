# Right side prompt
#
# Requires the lolfish function provided in lolfish:fish_prompt.fish source
#
# Displays the number of background processes [&:2]
# Displays the number of active tmux sessions [tmux:4]
# Displays the time and date in Minute:Hour Day:Month:Year

function fish_right_prompt

    #
    # background jobs
    #
    set -l background_jobs (count (jobs -p ^/dev/null))
    if test $background_jobs -gt 0
        set background_jobs_prompt '[' '&' ':' $background_jobs ']'
    end

    #
    # Display the number of background tmux sessions
    # only if the shell is running outside of tmux
    #
    if test -z $TMUX
        if command -s tmux > /dev/null ^&1
            set -l tmux_sessions (count (tmux list-sessions ^/dev/null))
            if test $tmux_sessions -gt 0
                set tmux_sessions_prompt '[' 'tmux' ':' $tmux_sessions ']'
            end
        end
    end

    #
    # Display the time and date
    #
    if command -s date > /dev/null ^&1
        set time (date +'%H:%M' ^/dev/null)
        set date (date +'%d-%m-%Y' ^/dev/null)
    end

    lolfish $background_jobs_prompt $tmux_sessions_prompt $time ' ' $date
end
