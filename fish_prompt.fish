# name:		lolfish
# requires:	jobs, git, hostname, sed
# inspirationk:	lolcat

# set the seed color to start the prompt
# 1 starts at red
# 6 starts at yellow
# 16 starts at green
# 21 starts at blue
# 26 starts at magenta

set start_color 21

function lolfish -d "very rainbow. wow"

	#
	# valid xterm-256color r g b color space hex values
	# r g b can be any of 00, 57, 87, af, d7, ff
	# red    ff0000
	# yellow ffff00
	# green  00ff00
	# blue   0000ff
	#
	set -l colors ff0000 ff5700 ff8700 ffaf00 ffd700 \
		ffff00 d7ff00 afff00 87ff00 57ff00 \
		00ff00 00ff57 00ff87 00ffaf 00ffd7 \
		00ffff 00d7ff 00afff 0087ff 0057ff \
		0000ff 5700ff 8700ff af00ff d700ff \
		ff00ff ff00d7 ff00af ff0087 ff0057

	#
	# set the color differential between prompt items
	# lower values produce a smoother rainbow effect
	# values between 1 and 5 work the best
	# 10 has an interesting property
	# 5 works best for non 256 color terminals
	#
	set -l next_color 1

	#
	# set the start color or default to blue
	#
	if test $start_color -gt 0
		set color $start_color
	else
		set color 21
	end

	#
	# reset when it grows beyond the valid color range
	#
	if test $start_color -gt (count $colors)
		set start_color 1
	end

	#
	# start the printing process
	#
	for arg in $argv

		#
		# reset the color to the beginning when it rolls over
		#
		if test $color -gt (count $colors)
			set color 1
		end

		#
		# print these symbols in normal color
		#
		switch $arg
			case '[' ']' ':' '@' '%' ' ' '#'
				set_color normal
				echo -n -s $arg
				continue
		end

		#
		# print rainbow!
		#
		set_color $colors[$color]
		echo -n -s $arg
		set color (math $color+$next_color)

	end

	set start_color (math $start_color+$next_color)
	set_color normal
end

function fish_prompt

	#
	# store the previous command return status for later
	#
	set -l exit_status $status

	#
	# get the number of background jobs
	#
        set -l jobs (count (jobs -p ^/dev/null))

	#
	# set the user, short hostname (non-fully qualified domain name)
	# and current path (abbreviated home directory ~ ) in the standard
	# ssh style format user@hostname:path
	#
	set -l uname '[' $USER '@'
	set -l hname (hostname | sed 's/\..*//' ^/dev/null) ':'
	set -l cwd   (echo $PWD | sed "s,$HOME,~," ^/dev/null) ']' ' '

	#
	# the git bits
	#
	if set -l branch (git rev-parse --abbrev-ref HEAD ^/dev/null)
		set -l git_dirt (count (git status -s --ignore-submodules ^/dev/null))
		test $git_dirt -ne 0; and set -l dirty ':' $git_dirt
		set git 'git' '[' $branch $dirty ']' ' '
	end

	#
	# when a command errors, display the return value of the last command !![exit_status]
	#
	test $exit_status -ne 0; and set -l error '!' '!' '[' $exit_status ']' ' '

	#
	# display the number of background jobs &[jobs]
	#
	test $jobs -ne 0; and set -l bjobs '&' '[' $jobs ']' ' '

	#
	# hashtag the prompt for root
	#
	switch $USER
		case 'root'
			set prompt '#' ' '
		case '*'
			set prompt '%' ' '
	end

	#
	# finally print the prompt
	#
	lolfish $uname $hname $cwd $git $bjobs $error $prompt
end
