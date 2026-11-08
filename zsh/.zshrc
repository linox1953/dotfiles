export KEYTIMEOUT=1

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# 历史记录配置
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt inc_append_history
setopt share_history
setopt histignorespace
setopt hist_ignore_dups

# 加载 fzf (模糊搜索)
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh

# 加载自动补全插件
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# 加载 Powerlevel10k 主题
source ~/powerlevel10k/powerlevel10k.zsh-theme

# 应用 p10k 配置
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# 加载别名和工具
alias bat='batcat'
alias ls='eza --icons'
alias ll='eza -lh --icons --group-directories-first'
alias la='eza -lah --icons --group-directories-first'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
eval "$(zoxide init zsh)"

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Zsh 的 Vi 模式
bindkey -v

# 光标形状动态切换
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
    echo -ne '\e[2 q'
  elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ $1 = 'beam' ]]; then
    echo -ne '\e[6 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set globally)
    echo -ne '\e[6 q'
}
zle -N zle-line-init
echo -ne '\e[6 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[6 q' ;} # Use beam shape cursor for each new prompt.

# 修复 Vi 插入模式下的退格键失效问题

# 将两种常见的退格键编码（^? 和 ^H）绑定到删除动作
bindkey '^?' backward-delete-char
bindkey '^H' backward-delete-char

# 确保在 Vi 插入模式 (viins) 下强行绑定
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^H' backward-delete-char

# 确保 Delete 键正常删光标右边的字符
bindkey -M viins '^[[3~' delete-char
