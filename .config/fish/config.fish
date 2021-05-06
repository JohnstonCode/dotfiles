alias up='sudo apt update && sudo apt upgrade'
alias ls='exa -al --color=always --group-directories-first'
alias dc='docker-compose'

# This is needed to help save configs with git https://www.atlassian.com/git/tutorials/dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

function fish_greeting
	echo
	echo -e (lsb_release -d --short | awk '{print "\\\\e[1mOS: \\\\e[0;32m"$0"\\\\e[0m"}')
	echo -e (uptime -p | sed 's/^up //' | awk '{print "\\\\e[1mUptime: \\\\e[0;32m"$0"\\\\e[0m"}')
	echo -e (hostname -I | cut -d' ' -f1 | awk '{print "\\\\e[1mIP: \\\\e[0;32m"$0"\\\\e[0m"}')
	echo
end
