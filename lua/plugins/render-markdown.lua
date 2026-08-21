-- LazyVim 的 lang.markdown extra 已经声明了这个插件（ft、config、<leader>um toggle），
-- 但它的 opts 把上游默认值改坏了四处：清空标题图标、关掉 sign、把宽度收窄成 block、
-- 禁用 checkbox。结果就是渲染效果和上游 README 的 demo 差很远。
--
-- 这里只做一件事：把那四处逐项还原成插件自己的默认值。
-- 其余一律不碰 —— overlay 定位、full 宽度、hide 边框、padded 表格都是默认，
-- demo 的样子就是默认的样子，多写一行都是在偏离它。
-- 验证：:RenderMarkdown config 打印的是与默认值的 diff，还原到位则这四项不出现。

---@module 'render-markdown'
---@type render.md.UserConfig
local opts = {
  -- LazyVim: sign = false, icons = {}
  -- icons 被清空后标题只剩背景色，position = "overlay" 下由 '#' 数量产生的
  -- 逐级缩进也一并消失，正是 demo 里最显眼的那个效果。
  heading = {
    sign = true,
    icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
  },

  -- LazyVim: sign = false, width = "block", right_pad = 1
  code = {
    sign = true,
    width = "full",
    right_pad = 0,
  },

  -- LazyVim: enabled = false
  checkbox = {
    enabled = true,
  },

  -- 与外观无关，纯功能：内建 LSP 提供 checkbox / callout 补全，blink.cmp 自动接上。
  completions = { lsp = { enabled = true } },
}

return {
  "MeanderingProgrammer/render-markdown.nvim",
  opts = opts,
}
