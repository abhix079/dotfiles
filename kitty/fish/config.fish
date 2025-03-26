if status is-interactive
    # Commands to run in interactive sessions can go here
    alias vi='nvim'
    alias tmux='tmux -u'
    alias fzfprev=' fzf --preview="bat --color=always {}" '
    alias ff='fastfetch'
    #alias ls='exa -l --icons'

    set -x PATH /usr/bin/go $PATH
end

#function fish_prompt
#    echo -n (hostname)' '(basename (pwd))' \$'
#end
