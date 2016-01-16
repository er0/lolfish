# prompt name: lolfish
# prompt requires: jobs, git, hostname, sed

#
# set the beginning color as an environment variable so
# the next prompt can continue the color sequence
#  1 : red
#  6 : yellow
# 16 : green
# 21 : blue
# 26 : magenta
#
set -g start_color 1


function lolfish -d "very rainbow. wow"

	#
	# xterm-256color RGB color values
	# valid R G B hex values : 00, 57, 87, af, d7, ff
	#
	# red	 ff0000
	# yellow ffff00
	# green  00ff00
	# blue   0000ff
	#
	set -l colors 	ff0000 ff5700 ff8700 ffaf00 ffd700 \
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
	set -l color_step 1

	#
	# set the starting color or default to the first in the color list
	#
	if test $start_color -gt 0
		set color $start_color
	else
		set color 1
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
		# print these characters in normal color
		#
		switch $arg
			case ' ' '(' ')' '[' ']' ':' '@'
				set_color normal
				echo -n -s $arg
				continue
		end

		#
		# rainbow! wow
		#
		test $color -gt (count $colors); and set color 1
		set_color $colors[$color]
		echo -n -s $arg
		set color (math $color + $color_step)
	end

	#
	# capture the next color to use for the start the next line
	#
	set start_color (math $start_color + $color_step)

	set_color normal
end


function fish_prompt

	#
	# last command had an error? display the return value
	#
	set -l exit_status $status
	if test $exit_status -ne 0
		set error '(' $exit_status ')'
	end

	#
	# abbreviated home directory ~
	#
	set -l current_dir (echo $PWD | sed -e "s,.*$HOME,~," 2>/dev/null)

	#
	# the git stuff
	#
	if test -d $PWD/.git
		set -l git_branch (git rev-parse --abbrev-ref HEAD 2>/dev/null)
		set -l git_dirty (count (git status -s --ignore-submodules 2>/dev/null))
		test $git_dirty -gt 0; and set -l dirty ':' $git_dirty
		set git_dir 'git' '[' $git_branch $dirty ']'
	end

	#
	# hashtag the prompt for root user
	#
	switch $USER
		case 'root'
			set prompt '#' ' '
		case '*'
			set prompt '>' '>' ' '
	end

	#
	# show username only if logged into remote via ssh
	#
	test -n $SSH_TTY; and set -l ssh_name $USER '@'

	#
	# finally print the prompt
	#
	lolfish $ssh_name (hostname -s) ':' $current_dir ' ' $git_dir $error $prompt

end
