-- markdownlint-cli2 的全局基础配置。
--
-- LazyVim 的 lang.markdown extra 同时把 markdownlint-cli2 挂在两处：
--   nvim-lint 走 stdin（args = { "-" }），按 cwd 找配置文件
--   conform   走 --fix $FILENAME，按文件目录找配置文件
-- 两处都没有 --config，所以在没有项目级配置的目录里只能吃默认规则。
-- 显式指向 nvim 配置目录下的 markdownlint.yaml，规则跟着 dotfiles 走。
--
-- --config 只是 base configuration：项目里的 .markdownlint*.{json,jsonc,yaml,yml}
-- 仍然会被找到并覆盖它，别人的仓库有自己的规矩就用他们的。

local config = vim.fn.stdpath("config") .. "/markdownlint.yaml"

return {
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters = {
        -- LazyVim 的 prepend_args 实为 list_extend，参数追加在 glob "-" 之后。
        -- markdownlint-cli2 的选项解析与位置无关，这样是对的。
        ["markdownlint-cli2"] = {
          prepend_args = { "--config", config },
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters = {
        ["markdownlint-cli2"] = {
          prepend_args = { "--config", config },
        },
      },
    },
  },
}
