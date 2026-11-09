return {
  "iamcco/markdown-preview.nvim",
  optional = true,
  init = function()
    vim.g.mkdp_page_title = "${name}"
    vim.g.mkdp_preview_options = {
      mkit = {
        breaks = true,
      },
      katex = {},
      uml = {},
      maid = {},
      disable_sync_scroll = 0,
      sync_scroll_type = "top",
      hide_yaml_meta = 1,
      sequence_diagrams = {
        theme = "hand",
      },
    }
    vim.g.mkdp_preview_options = {
      disable_filename = 1,
      maid = {
        flowchart = {
          htmlLabels = false,
          nodeSpacing = 50,
          rankSpacing = 80,
          curve = "linear",
        },
      },
    }
  end,
}
