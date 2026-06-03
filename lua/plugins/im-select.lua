return {
  "NanoBoom/im-select.nvim",
  event = "VeryLazy",
  config = function()
    local opts = {
      set_default_events = { "InsertLeave", "CmdlineLeave", "FocusGained" },
    }
    if vim.fn.has("macunix") == 1 then
      opts.default_im_select = "com.apple.keylayout.ABC"
      opts.insert_im = "im.rime.inputmethod.Squirrel.Hans"
    elseif vim.fn.has("win32") == 1 or vim.fn.has("wsl") == 1 then
      opts.default_im_select = "im-select-mspy.exe"
      opts.insert_im = "中文模式"
    end
    -- Linux: 不设置 default_im_select / insert_im，使用插件默认值
    require("im_select").setup(opts)
  end,
}
