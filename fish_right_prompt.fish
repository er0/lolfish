function fish_right_prompt
	set -l date
	set -l tmux_sessions 0
	set -l background_jobs '[' '&' ':' (count (jobs -p ^ /dev/null)) ']'

	if test -z "$TMUX"
		if command -s tmux > /dev/null
			set tmux_sessions (count (tmux list-sessions ^ /dev/null))
		end

		if test $tmux_sessions -gt 0
			set tmux_sessions '[' 'tmux' ':' $tmux_sessions ']'
		end

		# date in default tmux format, [Hour:Minute Day-Month-Year]
		set date '[' (date +'%H:%M %d-%m-%Y' ^ /dev/null) ']'
	end

	lolfish $background_jobs $tmux_sessions $date
end
