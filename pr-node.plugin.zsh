#!/usr/bin/env zsh

DEPENDENCES_ARCH+=( node@nodejs )
DEPENDENCES_DEBIAN+=( node@nodejs )

NODE_VERSION_PREFIX=${NODE_VERSION_PREFIX:-" "}
NODE_VERSION_SUFIX=${NODE_VERSION_SUFIX:-""}

DEPENDENCES_ZSH+=( zpm-zsh/zsh-helpers )

_node_version_pre() {

  if (( $+commands[node] )); then
    if is-recursive-exist package.json >/dev/null ; then
      pr_node="$NODE_VERSION_PREFIX"

      if is-recursive-exist gulpfile.js   >/dev/null || is-recursive-exist gulpfile.babel.js >/dev/null ; then
        if [[ $CLICOLOR = 1 ]]; then
          pr_node+="%{$fg_bold[green]%} "
        else
          pr_node+=" "
        fi
      fi

      if is-recursive-exist Gruntfile.js   >/dev/null ; then
        if [[ $CLICOLOR = 1 ]]; then
          pr_node+="%{$fg_bold[green]%} "
        else
          pr_node+=" "
        fi
      fi

      if is-recursive-exist webpack.config.js   >/dev/null ; then
        if [[ $CLICOLOR = 1 ]]; then
          pr_node+="%{$fg_bold[green]%}ﰩ "
        else
          pr_node+="ﰩ "
        fi
      fi

      nodev=$(node -v)
      nodev=${nodev#'v'}
      if [[ $CLICOLOR = 1 ]]; then
        pr_node+="%{$fg_bold[green]%} %{$fg_bold[blue]%}$nodev%{$reset_color%}"
      else
        pr_node+=" $nodev"
      fi

      pr_node+="$NODE_VERSION_SUFIX"


    else
      pr_node=""
    fi
  else
    pr_node=""
  fi

}
chpwd_functions+=(_node_version_pre)
periodic_functions+=(_node_version_pre)
