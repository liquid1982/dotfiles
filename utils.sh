#!/bin/bash

set -e
set -u

function in_all_tmux_panes () {
  local orig_window_index=`tmux display-message -p '#I'`
  local orig_pane_index=`tmux display-message -p '#P'`
  local window_indexes=$((`tmux list-windows | wc -l`))

  for (( current_window_index=0; current_window_index <= $window_indexes; current_window_index++ )); do
    tmux select-window -t $current_window_index

    local panes_indexes=$((`tmux list-panes | wc -l`))

    for (( current_pane_index=0; current_pane_index <= $panes_indexes; current_pane_index++ )); do
      tmux select-pane -t $current_pane_index
      tmux send-keys "$1" C-m 2> /dev/null
    done
  done

  tmux select-window -t $orig_window_index
  tmux select-pane -t $orig_pane_index
}
