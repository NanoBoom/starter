return {
  "NanoBoom/im-select.nvim",
  cond = function()
    -- WSL 使用 Windows 输入法；原生 Linux 需要 Fcitx 的切换工具。
    return vim.fn.has("linux") ~= 1
      or vim.fn.has("wsl") == 1
      or vim.fn.executable("fcitx5-remote") == 1
      or vim.fn.executable("fcitx-remote") == 1
  end,
  event = "VeryLazy",
  opts = function(_, opts)
    opts.set_default_events = { "InsertLeave", "CmdlineLeave", "FocusGained" }
    if vim.fn.has("macunix") == 1 then
      opts.default_im_select = "com.apple.keylayout.ABC"
      -- opts.insert_im = "im.rime.inputmethod.Squirrel.Hans"
      opts.default_im_select = "com.apple.keylayout.ABC"
    elseif vim.fn.has("win32") == 1 or vim.fn.has("wsl") == 1 then
      opts.default_im_select = "im-select-mspy.exe"
      opts.insert_im = "中文模式"
    end
    -- Linux: 不设置上述参数，使用插件默认值
  end,
}
