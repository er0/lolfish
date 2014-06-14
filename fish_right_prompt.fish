
#
# Right prompt
#
function fish_right_prompt

	#
	# store the previous command return status for later
	#
	set -l exit_status $status

	#
	# get the number of background jobs
	#
	set -l jobs (count (jobs -p ^/dev/null))

	#
	# when a command errors, display the return value
	# of the last command, !:exit_status
	#
	test $exit_status -ne 0; and set -l error '!' ':' $exit_status ' '

	#
	# display the number of background jobs, &:jobs
	#
	test $jobs -ne 0; and set -l bjobs '&' ':' $jobs ' '

	# display the number of tmux sessions, t:tmux_sessions
	# but not in the tmux window
	if not test $TMUX
		set -l tmux_sessions (count (tmux list-sessions ^/dev/null))
		if test $tmux_sessions -gt 0
			set tmux 't' ':' $tmux_sessions ' '
		end
		# date in default tmux format, [Hour:Minute Day-Month-Year]
		set date (date +'%H:%M %d-%m-%Y' ^/dev/null)
	end


	lolfish $error $bjobs $tmux $date
end
