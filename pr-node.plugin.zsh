#!/usr/bin/env zsh

: ${NODE_VERSION_PREFIX:=' '}
: ${NODE_VERSION_SUFIX:=''}

typeset -g pr_node

if (( $+commands[node] )); then
  function _pr_node() {
    pr_node=''

    if is-recursive-exist package.json; then
      pr_node="$NODE_VERSION_PREFIX"

      if is-recursive-exist gulpfile.js || is-recursive-exist gulpfile.babel.js; then
        pr_node+="%{$c[red]$c_bold$c_dim%}%{$c_reset%} "
      fi

      if is-recursive-exist Gruntfile.js; then
        pr_node+="%{$c[yellow]$c_bold$c_dim%}%{$c_reset%} "
      fi

      if is-recursive-exist webpack.config.js; then
        pr_node+="%{$c[blue]$c_bold$c_dim%}ﰩ%{$c_reset%} "
      fi

      nodev=$(node -v)
      nodev=${nodev#'v'}

      pr_node+="%{$c[green]${c_bold}%}⬢%{$c_reset%} %{$c[blue]$c_bold%}$nodev%{$c_reset%}"
      pr_node+="$NODE_VERSION_SUFIX"
    fi
  }

  autoload -Uz add-zsh-hook
  add-zsh-hook chpwd _pr_node
  _pr_node
fi
