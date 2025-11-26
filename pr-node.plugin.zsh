#!/usr/bin/env zsh

: ${PR_NODE_SYMBOL:='󰎙'}

typeset -g pr_node

if (( $+commands[node] )); then
  function _pr_node() {
    pr_node=''

    # Skip rendering in narrow terminals; guard against unset $COLUMNS.
    if (( ${COLUMNS:-0} < 100 )); then
      return 0
    fi

    if is-recursive-exist package.json; then
      pr_node=' '

      nodev=$(node -v)
      nodev=${nodev#'v'}

      pr_node+="%{${c[green]}${c[bold]}%}${PR_NODE_SYMBOL}%{${c[reset]}%} %{${c[green]}${c[bold]}%}$nodev%{${c[reset]}%}"
    fi
  }

  autoload -Uz add-zsh-hook
  add-zsh-hook chpwd _pr_node
  _pr_node
fi
