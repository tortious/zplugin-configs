# https://github.com/NICHOLAS85/dotfiles/blob/master/.zshrc

# Install zplugin if not installed
if [ ! -d "${HOME}/.zplugin" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"
    if [[ ! -d "$ZPFX" ]]; then
    mkdir -v $ZPFX
    fi
    if [[ ! -d "$ZPLGM[HOME_DIR]/user" ]]; then
    mkdir -v "$ZPLGM[HOME_DIR]/user"
    curl -fsSL https://raw.githubusercontent.com/NICHOLAS85/dotfiles/master/.zplugin/user/personal -o "$ZPLGM[HOME_DIR]/user/personal"
    curl -fsSL https://raw.githubusercontent.com/NICHOLAS85/dotfiles/master/.zplugin/user/theme -o "$ZPLGM[HOME_DIR]/user/theme"
    fi
fi

### Added by Zplugin's installer
source "${HOME}/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin's installer chunk

# Functions to make configuration less verbose
zt() { zplugin ice wait"${1}" lucid               "${@:2}"; } # Turbo
z()  { [ -z $2 ] && zplugin light "${@}" || zplugin "${@}"; } # zplugin

# Theme
zt "" pick'spaceship.zsh' compile'{lib/*,sections/*,tests/*.zsh}' atload'source $ZPLGM[HOME_DIR]/user/theme'
z denysdovhan/spaceship-prompt

# Oh-my-zsh libs
zt "" atinit'ZSH_CACHE_DIR="$HOME/.zcompcache"'
z snippet OMZ::lib/history.zsh

zt 0a
z snippet OMZ::lib/completion.zsh

# Plugins

zt 0b atclone"git reset --hard; sed -i '/DIR/c\DIR                   34;5;30' LS_COLORS; dircolors -b LS_COLORS > c.zsh" atpull'%atclone' pick"c.zsh" nocompile'!'
z trapd00r/LS_COLORS

zt 0a has'systemctl'
z snippet OMZ::plugins/systemd/systemd.plugin.zsh

zt 0a
z snippet OMZ::plugins/extract/extract.plugin.zsh

zt 0b compile'{hsmw-*,test/*}'
z zdharma/history-search-multi-word

zt 0b
z ael-code/zsh-colored-man-pages

zt 0a make
z sei40kr/zsh-fast-alias-tips

zt 0b has'git' as'command'
z paulirish/git-open

zt 0b has'git'
z wfxr/forgit
#replaced gi with local git-ignore plugin

zt 0b has'git' pick'init.zsh' atload'alias gi="git-ignore"' blockf
z laggardkernel/git-ignore

zt 0a as'program' atpull'!git reset --hard' pick'wd.sh' mv'_wd.sh -> _wd' atload'wd() { source wd.sh }; WD_CONFIG="$ZPFX/.warprc"' blockf
z mfaerevaag/wd

zt 0a as'command' pick'updatelocal' atload'updatelocal() { source updatelocal }'
z NICHOLAS85/updatelocal

zt '[[ -n ${ZLAST_COMMANDS[(r)gcom*]} ]]' atload'gcomp(){ \gencomp $1 && zplugin creinstall -q RobSis/zsh-completion-generator; }' pick'zsh-completion-generator.plugin.zsh'
z RobSis/zsh-completion-generator
#loaded when needed via gcomp

zt 0b as'program' pick'rm-trash/rm-trash' atclone"git reset --hard; sed -i '2 i [[ \$EUID = 0 ]] && { echo \"Root detected, running builtin rm\"; command rm -I -v \"\${@}\"; exit; }' rm-trash/rm-trash" atpull'%atclone' atload'alias rm="rm-trash ${rm_opts}"' \
compile'rm-trash/rm-trash' nocompile'!'
z nateshmbhat/rm-trash

zt 0b has'thefuck' trackbinds bindmap'\e\e -> ^[OP^[OP' pick'init.zsh'
z laggardkernel/zsh-thefuck

zt 0a
z snippet OMZ::plugins/sudo/sudo.plugin.zsh

zt 0b
z snippet OMZ::plugins/command-not-found/command-not-found.plugin.zsh

zt 0a atload'unalias help; unalias rm'
z snippet OMZ::plugins/common-aliases/common-aliases.plugin.zsh

zt 0a as'program' pick'bin/git-dsf'
z zdharma/zsh-diff-so-fancy

zt 0b nocompletions
z hlissner/zsh-autopair

zt 0a blockf atpull'zplugin creinstall -q .'
z zsh-users/zsh-completions

zt '[[ $isdolphin != true ]]'
z load desyncr/auto-ls

zt 0c atload'bindkey "$terminfo[kcuu1]" history-substring-search-up; bindkey "$terminfo[kcud1]" history-substring-search-down'
z zsh-users/zsh-history-substring-search

zt 0b compile'{src/*.zsh,src/strategies/*}' atload'_zsh_autosuggest_start' 
z zsh-users/zsh-autosuggestions

zt 0b pick'manydots-magic' compile'manydots-magic'
z knu/zsh-manydots-magic

source "$ZPLGM[HOME_DIR]/user/personal"

zt 0b atinit'_zpcompinit_fast; zpcdreplay'
z zdharma/fast-syntax-highlighting

zt 0c id-as'Cleanup' atinit'unset -f zt z'
z zdharma/null 

#dotscheck
