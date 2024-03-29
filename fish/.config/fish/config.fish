set -gx PATH $HOME/.local/bin $HOME/.cargo/bin $PATH

# abbr
abbr -a t tig
abbr -a ts "tig status"
abbr -a o xdg-open
abbr -a b bat
abbr -a g git
abbr -a gp "git pull"

# Enable vi-like mappings
set -g fish_key_bindings fish_vi_key_bindings
# use C-k/C-j to navigate history
bind -M insert \ck history-search-backward
bind -M insert \cj history-search-forward
bind -M insert -k nul accept-autosuggestion

if test -e /usr/share/fish/vendor_functions.d/fzf_key_bindings.fish
    fzf_key_bindings
end

# Environment variables
set -x RUST_SRC_PATH $HOME/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src
set -x FZF_DEFAULT_COMMAND 'fd --type f --follow'
set -x FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"

# Base16 Shell
#if status --is-interactive
#    set BASE16_SHELL "$HOME/.config/base16-shell/"
#    source "$BASE16_SHELL/profile_helper.fish"
#end

# colored man output
# from http://linuxtidbits.wordpress.com/2009/03/23/less-colors-for-man-pages/
set -x LESS_TERMCAP_mb \e'[01;31m'       # begin blinking
set -x LESS_TERMCAP_md \e'[01;38;5;74m'  # begin bold
set -x LESS_TERMCAP_me \e'[0m'           # end mode
set -x LESS_TERMCAP_se \e'[0m'           # end standout-mode
set -x LESS_TERMCAP_so \e'[38;5;246m'    # begin standout-mode - info box
set -x LESS_TERMCAP_ue \e'[0m'           # end underline
set -x LESS_TERMCAP_us \e'[04;38;5;146m' # begin underline

# Prompt
eval (starship init fish)
