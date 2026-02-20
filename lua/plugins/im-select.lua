return {
  "NanoBoom/im-select.nvim",
  event = "VeryLazy",
  config = function()
    require("im_select").setup({
      default_im_select = "com.apple.keylayout.ABC",
      insert_im = "im.rime.inputmethod.Squirrel.Hans",
    })
  end,
}
