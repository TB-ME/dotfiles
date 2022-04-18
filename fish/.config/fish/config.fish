# Set values
## Hide welcome message
set fish_greeting
set VIRTUAL_ENV_DISABLE_PROMPT "1"
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

## Export variable need for qt-theme
if type "qtile" >> /dev/null 2>&1
   set -x QT_QPA_PLATFORMTHEME "qt5ct"
end

## Environment setup
# Apply .profile
if test -f ~/.fish_profile
    source ~/.fish_profile
end

# Commands to run in interactive sessions can go here
if status is-interactive
    ## Starship prompt
    if test -f /usr/bin/starship
    	source ("/usr/bin/starship" init fish --print-full-init | psub)
    else if test -f /usr/bin/local/starship
    	source ("/usr/bin/local/starship" init fish --print-full-init | psub)
    end
end

# Add ~/.cargo/bin to PATH
if test -d ~/.cargo/bin
    if not contains -- ~/.cargo/bin $PATH
        set -p PATH ~/.cargo/bin
    end
end

# Add ~/.local/bin to PATH
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
    	set -p PATH ~/.local/bin
    end
end

<<<<<<< HEAD
# Add depot_tools to PATH
if test -d ~/Applications/depot_tools
    if not contains -- ~/Applications/depot_tools $PATH
        set -p PATH ~/Applications/depot_tools
    end
end


## Starship prompt
if status --is-interactive
   if test -f /usr/bin/starship
      source ("/usr/bin/starship" init fish --print-full-init | psub)
   else if test -f /usr/bin/local/starship
      source ("/usr/bin/local/starship" init fish --print-full-init | psub)
   end
end

=======
>>>>>>> personal
## Functions
# Function needed for !! and !$
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

if [ "$fish_key_bindings" = fish_vi_key_bindings ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end

# Fish command history
function history
    builtin history --show-time='%F %T '
end

function backup --argument filename
    cp $filename $filename.bak
end

## Aliases
# Replace ls with exa
if test -f /usr/bin/exa
    alias ls='exa -al --color=always --group-directories-first --icons' # preferred listing
    alias la='exa -a --color=always --group-directories-first --icons'  # all files and dirs
    alias ll='exa -l --color=always --group-directories-first --icons'  # long format
    alias lt='exa -aT --color=always --group-directories-first --icons' # tree listing
    alias l.="exa -a | egrep '^\.'"                                     # show only dotfiles
end

# Get fastest mirrors
<<<<<<< HEAD
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"

# Help people new to Arch
alias apt='man pacman'
alias apt-get='man pacman'
alias please='sudo'
alias tb='nc termbin.com 9999'

# Cleanup orphaned packages
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# Recent installed packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"


## Run neofetch if session is interactive
#if status --is-interactive && type -q neofetch
#   neofetch
#end

=======
if test -f /usr/bin/reflector
    alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
    alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
    alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
    alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"
else if test -f /usr/bin/pacman-mirrors
    alias mirror="sudo pacman-mirrors --fasttrack"
end
if test -f /usr/bin/pacman
    alias cleanup="sudo pacman -Rns (pacman -Qtdq)"
end

# faster grep
if test -f /usr/bin/rg
    alias grep="rg"
end
>>>>>>> personal
