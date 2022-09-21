#!/usr/bin/env sh

# Thanks: https://www.seanh.cc/2021/01/02/change-between-light-and-dark-themes-in-tmux/


# Toggle the current window (all panes) between light and dark themes.
set -e

# Dark
default_window_style='fg=#c0cfcc,bg=#333333'
default_active_window_style='fg=#ffffff,bg=#111111'
default_pane_active_border_style='fg=#ffffff,bg=#666666'
default_pane_border_style='fg=#888888,bg=#000000'

# Light
alternate_window_style='fg=#171421,bg=#eeeeee'
alternate_active_window_style='fg=#000000,bg=#ffffff'
alternate_active_border_style='fg=#440000,bg=#ff8888'
alternate_pane_border_style='fg=#000000,bg=#ffffff'
alternate_pane_active_border_style='fg=#440000,bg=#ff8888'


current_window_style=$(tmux show -Av window-style)

case $current_window_style in
    $default_window_style|'default')
        # Change to the alternate window style.
        tmux set window-style $alternate_window_style
        tmux set window-active-style $alternate_active_window_style
        tmux set pane-active-border-style $alternate_pane_active_border_style
        tmux set pane-border-style $alternate_pane_border_style
        ;;
    *)
        # Change back to the default window style.
        tmux set window-style $default_window_style
        tmux set window-active-style $default_active_window_style
        tmux set pane-active-border-style $default_pane_active_border_style
        tmux set pane-border-style $default_pane_border_style
        ;;
esac

