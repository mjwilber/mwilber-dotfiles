#
# Simplified down to only base liquidprompt settings
# Archived a bunch of stuff to the archive folder in this directory
# 
echo "(promptrc.bash)"

# [[ $- = *i* ]] && source ~/.dotfiles/liquidprompt/liquidprompt


# change to starship
# Make sure to install starship
# brew install starship
[[ $(type -P "starship") ]] || echo "Starship is not installed!!!!"
eval "$(starship init bash)"

function update_window_title() {
  echo -ne "\033]0; ${USER}@$(hostname -s):$(pwd)\007"
}
starship_precmd_user_func="update_window_title"
