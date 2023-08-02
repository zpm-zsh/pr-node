#!/usr/bin/env zsh

: ${PR_NODE_GULPFILE:=''}
: ${PR_NODE_WEBPACK:='ﰩ'}
: ${PR_NODE_SYMBOL:=''}

typeset -g pr_node

if (( $+commands[node] )); then
  function _pr_node() {
    pr_node=''

    if is-recursive-exist package.json; then
      pr_node=' '

      if is-recursive-exist gulpfile.js || is-recursive-exist gulpfile.babel.js; then
        pr_node+="%{${c[red]}${c[bold]}${c[dim]}%}${NODE_GULPFILE}%{${c[reset]}%} "
      fi

      if is-recursive-exist webpack.config.js; then
        pr_node+="%{${c[blue]}${c[bold]}${c[dim]}%}ﰩ%{${c[reset]}%} "
      fi

      nodev=$(node -v)
      nodev=${nodev#'v'}

      pr_node+="%{${c[springgreen]}${c[bold]}%}${PR_NODE_SYMBOL}%{${c[reset]}%} %{${c[blue]}${c[bold]}%}$nodev%{${c[reset]}%}"
    fi
  }

  autoload -Uz add-zsh-hook
  add-zsh-hook chpwd _pr_node
  _pr_node
fi
