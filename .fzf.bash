# Requires fzf 0.48.0 or newer.
if [[ $- == *i* ]] && command -v fzf > /dev/null 2>&1; then
  eval "$(fzf --bash)"
fi
