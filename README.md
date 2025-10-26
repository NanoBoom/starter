# 💤 My Neovim Configuration

A feature-rich Neovim configuration built on [LazyVim](https://github.com/LazyVim/LazyVim), enhanced with AI integration, productivity tools, and custom workflows.

## ✨ Features

- **AI-Powered Development**: Integrated Claude Code support for intelligent coding assistance
- **16+ Curated Plugins**: Carefully selected tools for modern development workflow
- **Emacs-Style Keybindings**: Familiar insert-mode navigation for productivity
- **REST API Testing**: Built-in HTTP client with kulala.nvim
- **Beautiful UI**: Gruvbox theme with enhanced visual elements
- **Modular Configuration**: Easy to customize and extend

## 🛠️ Tech Stack

- **Editor**: Neovim (>= 0.9.0)
- **Framework**: LazyVim
- **Plugin Manager**: lazy.nvim
- **Language**: Lua
- **Theme**: Gruvbox

## 📋 Prerequisites

Before installation, ensure you have:

- **Neovim** >= 0.9.0
- **Git** for cloning and plugin management
- **A Nerd Font** installed and configured in your terminal (for icons)
- **clipboard-provider** command (optional, for clipboard synchronization)

## 🚀 Installation

1. **Backup your existing configuration** (if any):
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Clone or symlink this repository**:
   ```bash
   git clone <your-repo-url> ~/.config/nvim
   # or symlink if you manage dotfiles elsewhere
   ln -s /path/to/this/repo ~/.config/nvim
   ```

3. **Launch Neovim and install plugins**:
   ```bash
   nvim
   ```
   Wait for lazy.nvim to automatically install all plugins.

4. **Configure environment variables**:
   Create a `.env` file in the config directory with required API keys:
   ```bash
   OPENAI_API_KEY=your_openai_key_here
   OPENAI_BASE_URL=https://openrouter.ai/api/v1
   CONTEXT7_API_KEY=your_context7_key_here
   GOOGLE_GEMINI_API_KEY=your_gemini_key_here
   # Add other keys as needed
   ```

5. **Optional: Setup MCP servers**:
   Configure `.mcp.json` for Model Context Protocol integration (e.g., context7).

## 🔌 Plugins

### AI Integration
- **[ClaudeCode.nvim](https://github.com/NanoBoom/claudecode.nvim)** - Claude Code MCP server integration for AI-powered assistance

### File Management
- **[nvim-tree](https://github.com/nvim-tree/nvim-tree.lua)** - File explorer with advanced features and custom keybindings

### Search & Navigation
- **[telescope](https://github.com/nvim-telescope/telescope.nvim)** - Fuzzy finder for files, buffers, and more
- **[dropbar](https://github.com/Bekaboo/dropbar.nvim)** - Winbar showing current code context
- **[outline](https://github.com/hedyhli/outline.nvim)** - Symbol outline and navigation

### Code Completion
- **[blink.cmp](https://github.com/saghen/blink.cmp)** - Fast and feature-rich completion engine

### UI Enhancement
- **[gruvbox](https://github.com/ellisonleao/gruvbox.nvim)** - Retro groove color scheme
- **[bufferline](https://github.com/akinsho/bufferline.nvim)** - Enhanced buffer and tab line
- **[colorful-menu](https://github.com/doodleEsc/colorful-menu.nvim)** - Colorized completion menu
- **[snacks](https://github.com/folke/snacks.nvim)** - Collection of QoL improvements

### Development Tools
- **[rest.nvim (kulala)](https://github.com/mistweaverco/kulala.nvim)** - REST API client with .http file support
- **[openapi](https://github.com/doodleEsc/openapi.nvim)** - OpenAPI specification integration
- **[markdown-preview](https://github.com/iamcco/markdown-preview.nvim)** - Live markdown preview in browser

### Utilities
- **[translator](https://github.com/doodleEsc/translator.nvim)** - AI-powered text translation
- **[fortune](https://github.com/doodleEsc/fortune.nvim)** - Display random quotes and tips
- **[tmux](https://github.com/aserowy/tmux.nvim)** - Seamless tmux integration

## ⌨️ Key Bindings

### Insert Mode (Emacs-style)
- `<C-b>` / `<C-f>` - Move cursor left/right
- `<C-a>` - Move to line start
- `<C-n>` / `<C-p>` - Move cursor down/up
- `<C-s>` - Save file

### Claude Code Integration
- `<leader>ab` - Add current buffer to Claude context
- `<leader>aw` - Send selection (visual mode) or add file from tree
- `<leader>ar` - Restart Claude Code server
- `<leader>aj` / `<leader>ak` - Accept/reject diff (vim-style j/k)

### REST Client
- `<leader>Rs` - Send HTTP request
- `<leader>Rt` - Toggle headers/body view
- `<leader>Rb` - Open REST scratchpad
- `<leader>Rc` - Copy request as cURL

> **Note**: For a complete list of keybindings, see [`lua/config/keymaps.lua`](lua/config/keymaps.lua)

## 🛠️ Development

### Format Code

Use StyLua for consistent Lua formatting:

```bash
stylua .
```

Configuration: 2-space indentation, 120 column width (see `stylua.toml`)

### Manage Plugins

In Neovim:

```vim
:Lazy              " Open plugin manager UI
:Lazy sync         " Install/update/clean plugins
:Lazy update       " Update all plugins
:Lazy clean        " Remove unused plugins
:Lazy restore      " Restore from lazy-lock.json
```

### Configuration Files

- **Core config**: `lua/config/` - Options, keymaps, autocmds, lazy.nvim setup
- **Plugin configs**: `lua/plugins/` - Individual plugin configurations
- **Environment**: `.env` - API keys and environment variables
- **Code style**: `stylua.toml` - Lua formatter configuration

### Adding New Plugins

1. Create a new file in `lua/plugins/` (e.g., `my-plugin.lua`)
2. Return a lazy.nvim spec table:
   ```lua
   return {
     "author/plugin-name",
     event = "VeryLazy",
     opts = {},
   }
   ```
3. Restart Neovim - plugins are auto-loaded from `lua/plugins/`

## 📚 Resources

- **[LazyVim Documentation](https://lazyvim.github.io/)** - Comprehensive guide to LazyVim
- **[lazy.nvim](https://github.com/folke/lazy.nvim)** - Plugin manager documentation
- **[CLAUDE.md](CLAUDE.md)** - AI assistant guidance and detailed implementation notes

## 📄 License

This configuration is released under the MIT License. See [LICENSE](LICENSE) for details.
