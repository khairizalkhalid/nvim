# Neovim Config

> A minimal, purposeful Neovim configuration built from scratch.

Inspired by kickstart.nvim but stripped down to essentials. Every line is intentional. Every plugin serves a clear purpose. Zero bloat.

## ✨ Features

- **Modular Structure** - Organized into `config/` and `plugins/` directories
- **Modern UI** - Catppuccin Mocha with transparency and colorful statusline
- **Fuzzy Finding** - Telescope for files, grep, buffers
- **LSP Support** - Language servers with Mason auto-installation
- **Smart Completion** - Blink.cmp with icons and borders
- **Git Integration** - Gitsigns for hunks and blame
- **Tmux Integration** - Seamless navigation between vim and tmux panes
- **Claude Code** - Integrated AI coding assistant
- **Keybinding Help** - Which-key popup on demand

## 📦 Installation

### Prerequisites

- Neovim >= 0.10.0
- Git
- A [Nerd Font](https://www.nerdfonts.com/) (optional, for icons)
- [ripgrep](https://github.com/BurntSushi/ripgrep) (for telescope grep)
- A C compiler (for Treesitter)

### Install

```bash
# Backup your existing config (if any)
mv ~/.config/nvim ~/.config/nvim.backup

# Clone this config
git clone https://github.com/khairizalkhalid/nvim.git ~/.config/nvim

# Launch Neovim
nvim
```

On first launch, lazy.nvim will automatically install all plugins. Give it a minute to download and compile everything.

## 🗂️ Structure

```
~/.config/nvim/
├── init.lua                    # Entry point
├── lua/
│   ├── config/
│   │   ├── options.lua        # Vim options (no plugins)
│   │   ├── keymaps.lua        # Core keybindings
│   │   └── autocmds.lua       # Autocommands
│   └── plugins/
│       ├── colorscheme.lua    # Catppuccin + alternatives
│       ├── telescope.lua      # Fuzzy finder
│       ├── treesitter.lua     # Syntax highlighting
│       ├── lsp.lua            # Language servers
│       ├── completion.lua     # Blink.cmp
│       ├── git.lua            # Gitsigns
│       ├── statusline.lua     # Lualine
│       ├── claude.lua         # Claude Code CLI
│       ├── tmux.lua           # Tmux navigator
│       └── which-key.lua      # Keybinding helper
```

## ⌨️ Key Bindings

Leader key: `<Space>`

### Core Navigation
| Key | Action |
|-----|--------|
| `<C-h/j/k/l>` | Navigate windows/tmux panes |
| `<C-d/u>` | Scroll down/up (centered) |
| `[d` / `]d` | Previous/next diagnostic |
| `<Esc>` | Clear search highlights |

### Telescope (Fuzzy Finder)
| Key | Action |
|-----|--------|
| `<leader>sf` | **[S]earch [F]iles** |
| `<leader>sg` | **[S]earch by [G]rep** |
| `<leader><leader>` | Find buffers |
| `<leader>sh` | Search help tags |
| `<leader>sk` | Search keymaps |
| `<leader>sw` | Search word under cursor |
| `<leader>sd` | Search diagnostics |
| `<leader>sr` | Search resume |
| `<leader>/` | Search in current buffer |

### LSP (when attached to buffer)
| Key | Action |
|-----|--------|
| `grd` | **[G]oto [D]efinition** |
| `grr` | **[G]oto [R]eferences** |
| `gri` | **[G]oto [I]mplementation** |
| `grt` | **[G]oto [T]ype definition** |
| `grn` | **[R]e[n]ame** |
| `gra` | **Code [A]ction** |
| `K` | Hover documentation |
| `gO` | Document symbols |
| `gW` | Workspace symbols |

### Git (Gitsigns)
| Key | Action |
|-----|--------|
| `]h` / `[h` | Next/previous hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line |
| `<leader>hd` | Diff this |

### AI & Productivity
| Key | Action |
|-----|--------|
| `<leader>cc` | Open Claude Code |
| `<leader>ct` | Toggle Claude Code |
| `<leader>?` | **Show keybinding help** |

### Completion (Insert Mode)
| Key | Action |
|-----|--------|
| `<C-n>` / `<C-p>` | Next/previous suggestion |
| `<C-y>` | Accept completion |
| `<C-Space>` | Trigger completion |
| `<C-e>` | Close completion menu |

## 🔧 Customization

### Add Language Servers

Edit `lua/plugins/lsp.lua` and add servers to the `servers` table:

```lua
local servers = {
  lua_ls = { ... },     -- Lua (installed by default)
  gopls = {},           -- Go
  rust_analyzer = {},   -- Rust
  clangd = {},          -- C/C++
  pyright = {},         -- Python
  ts_ls = {},           -- TypeScript/JavaScript
}
```

Mason will auto-install them on next launch.

### Switch Colorschemes

Edit `lua/plugins/colorscheme.lua` and change the `vim.cmd.colorscheme()` call:

```lua
-- Options: "catppuccin", "tokyonight", "rose-pine"
vim.cmd.colorscheme("catppuccin")
```

### Adjust Leader Timeout

Edit `lua/config/options.lua`:

```lua
opt.timeoutlen = 1000  -- Change to your preference (in milliseconds)
```

## 🔌 Plugins

- [lazy.nvim](https://github.com/folke/lazy.nvim) - Plugin manager
- [catppuccin](https://github.com/catppuccin/nvim) - Colorscheme
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) - Fuzzy finder
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Syntax highlighting
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - LSP configuration
- [mason.nvim](https://github.com/williamboman/mason.nvim) - LSP/tool installer
- [blink.cmp](https://github.com/saghen/blink.cmp) - Autocompletion
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) - Git decorations
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) - Statusline
- [claude-code.nvim](https://github.com/greggh/claude-code.nvim) - Claude CLI integration
- [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) - Tmux integration
- [which-key.nvim](https://github.com/folke/which-key.nvim) - Keybinding hints

## 🎨 Philosophy

This config is built on these principles:

1. **Minimal** - Only essential plugins, no bloat
2. **Modular** - Each plugin in its own file
3. **Readable** - Every line is commented and clear
4. **Fast** - Lazy loading where appropriate
5. **Purposeful** - Every feature serves a real need

## 🤝 Credits

Built from scratch with inspiration from:
- [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
- The Neovim community

## 📝 License

MIT License - Do whatever you want with it!
