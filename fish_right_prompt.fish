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
	# of the last command !![exit_status]
        #
        test $exit_status -ne 0; and set -l error '!' '[' $exit_status ']'

        #
        # display the number of background jobs &[jobs]
        #
        test $jobs -ne 0; and set -l bjobs ' ' '&' '[' $jobs ']'

	lolfish $error $bjobs
end
