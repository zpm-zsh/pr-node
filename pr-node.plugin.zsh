#!/usr/bin/env zsh

DEPENDENCES_ZSH+=( zpm-zsh/helpers zpm-zsh/colors )

NODE_VERSION_PREFIX=${NODE_VERSION_PREFIX:-" "}
NODE_VERSION_SUFIX=${NODE_VERSION_SUFIX:-""}

if (( $+functions[zpm] )); then
  zpm zpm-zsh/helpers zpm-zsh/colors
fi

_pr_node() {
  if (( $+commands[node] )); then
    if is-recursive-exist package.json >/dev/null ; then
      pr_node="$NODE_VERSION_PREFIX"
      
      if is-recursive-exist gulpfile.js   >/dev/null || is-recursive-exist gulpfile.babel.js >/dev/null ; then
        pr_node+="%{$c[red]$c_bold$c_dim%}%{$c_reset%} "
      fi
      
      if is-recursive-exist Gruntfile.js   >/dev/null ; then
        pr_node+="%{$c[yellow]$c_bold$c_dim%}%{$c_reset%} "
      fi
      
      if is-recursive-exist webpack.config.js   >/dev/null ; then
        pr_node+="%{$c[blue]$c_bold$c_dim%}ﰩ%{$c_reset%} "
      fi
      
      nodev=$(node -v)
      nodev=${nodev#'v'}
      
      pr_node+="%{$c[green]${c_bold}%}⬢%{$c_reset%} %{$c[blue]$c_bold%}$nodev%{$c_reset%}"
      pr_node+="$NODE_VERSION_SUFIX"

      return 0
    fi
  fi
  
  pr_node=""
}

_pr_node
add-zsh-hook chpwd _pr_node
