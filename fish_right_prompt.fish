#
# the right side prompt
#
function fish_right_prompt

	#
	# background jobs
	#
	set -l bjobs (count (jobs -p 2>/dev/null))
	test $bjobs -ne 0; and set -l background_jobs '[' '&' ':' $bjobs ']'

    #
	# display the date and number of tmux sessions
	# but not inside the tmux session
    #
	if not test $TMUX
		if test (count (tmux list-sessions 2>/dev/null)) -gt 0
			set tmux '[' '&' ':' 'tmux' ']'
		end
		# date in default tmux format, [Hour:Minute Day-Month-Year]
		set date '[' (date +'%H:%M %d-%m-%Y' 2>/dev/null) ']'
	end

	lolfish $error $background_jobs $tmux $date
end
