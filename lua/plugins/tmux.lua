-- Tmux integration - seamless navigation between vim and tmux panes
return {
  "christoomey/vim-tmux-navigator",
  lazy = false,
}

-- USAGE:
-- <C-h> - Move to left pane (vim or tmux)
-- <C-j> - Move to bottom pane (vim or tmux)
-- <C-k> - Move to top pane (vim or tmux)
-- <C-l> - Move to right pane (vim or tmux)
--
-- This works seamlessly between Neovim splits and tmux panes!
