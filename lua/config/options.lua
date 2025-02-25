-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.clipboard = "unnamedplus"
vim.opt.mousemoveevent = true
vim.opt.jumpoptions = "stack"

vim.g.clipboard = {
  name = "uniclipboard",
  copy = {
    ["+"] = "clipboard-provider copy",
    ["*"] = "clipboard-provider copy",
  },
  paste = {
    ["+"] = "clipboard-provider paste",
    ["*"] = "clipboard-provider paste",
  },
  cache_enabled = 1,
}
