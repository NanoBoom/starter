-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.mousemoveevent = true
vim.opt.jumpoptions = "stack"
vim.opt.relativenumber = false

-- 命令写成列表而不是字符串：字符串会被 jobstart 交给 &shell -c 执行，
-- 于是每次 yank/delete 都要多起一个 zsh。列表直接 exec。
vim.g.clipboard = {
  name = "uniclipboard",
  copy = {
    ["+"] = { "clipboard-provider", "copy" },
    ["*"] = { "clipboard-provider", "copy" },
  },
  paste = {
    ["+"] = { "clipboard-provider", "paste" },
    ["*"] = { "clipboard-provider", "paste" },
  },
  cache_enabled = 1,
}

vim.g.root_spec = { ".git", "lsp" }

vim.g.lazyvim_python_lsp = "ty"
