uname -a
#wmctrl -xa terminator.Terminator || terminator
# set -U fish_prompt_pwd_dir_length 0
# omf install fox

#s rsync -axAXH --numeric-ids 
#--exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} 
#--info=progress2 / /mnt/arch-20170301/

alias l="ls -la"
alias s="sudo"
alias m="micro"

alias u="yaourt -Syu --noconfirm"
alias uu="yaourt -Syua --noconfirm"
alias i="yaourt -Syu; yaourt -S --noconfirm $1"


alias h="htop"


alias ss='git add -A -v; git commit -m "commit"'
alias sp="ss; git push origin master"


#apm install esformatter file-icons language-babel linter linter-eslint minimap


alias c="code-insiders  ./"

alias e="electron ."
 




