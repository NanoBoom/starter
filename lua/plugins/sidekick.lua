return {
  desc = "Next edit suggestions with the Copilot LSP server",

  -- copilot-language-server
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local sk = LazyVim.opts("sidekick.nvim") ---@type sidekick.Config|{}
      if vim.tbl_get(sk, "nes", "enabled") ~= false then
        opts.servers = opts.servers or {}
        opts.servers.copilot = opts.servers.copilot or {}
      end
    end,
  },

  -- lualine
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    event = "VeryLazy",
    opts = function(_, opts)
      local icons = {
        Error = { " ", "DiagnosticError" },
        Inactive = { " ", "MsgArea" },
        Warning = { " ", "DiagnosticWarn" },
        Normal = { LazyVim.config.icons.kinds.Copilot, "Special" },
      }
      table.insert(opts.sections.lualine_x, 2, {
        function()
          local status = require("sidekick.status").get()
          return status and vim.tbl_get(icons, status.kind, 1)
        end,
        cond = function()
          return require("sidekick.status").get() ~= nil
        end,
        color = function()
          local status = require("sidekick.status").get()
          local hl = status and (status.busy and "DiagnosticWarn" or vim.tbl_get(icons, status.kind, 2))
          return { fg = Snacks.util.color(hl) }
        end,
      })

      table.insert(opts.sections.lualine_x, 2, {
        function()
          local status = require("sidekick.status").cli()
          return " " .. (#status > 1 and #status or "")
        end,
        cond = function()
          return #require("sidekick.status").cli() > 0
        end,
        color = function()
          return { fg = Snacks.util.color("Special") }
        end,
      })
    end,
  },

  {
    "nanoboom/sidekick.nvim",
    dir = "~/Projects/NanoBoom/sidekick.nvim",
    -- branch = "feat/support-herdr",
    opts = function()
      -- Accept inline suggestions or next edits
      LazyVim.cmp.actions.ai_nes = function()
        local Nes = require("sidekick.nes")
        if Nes.have() and (Nes.jump() or Nes.apply()) then
          return true
        end
      end
      Snacks.toggle({
        name = "Sidekick NES",
        get = function()
          return require("sidekick.nes").enabled
        end,
        set = function(state)
          require("sidekick.nes").enable(state)
        end,
      }):map("<leader>uN")
    end,
    -- stylua: ignore
    keys = {
      -- nes is also useful in normal mode
      { "<tab>", LazyVim.cmp.map({ "ai_nes" }, "<tab>"), mode = { "n" }, expr = true },
      { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
      {
        "<c-.>",
        function() require("sidekick.cli").focus() end,
        desc = "Sidekick Focus",
        mode = { "n", "t", "i", "x" },
      },
      {
        "<leader>aa",
        function() require("sidekick.cli").toggle() end,
        desc = "Sidekick Toggle CLI",
      },
      {
        "<leader>as",
        function() require("sidekick.cli").select() end,
        -- Or to select only installed tools:
        -- require("sidekick.cli").select({ filter = { installed = true } })
        desc = "Select CLI",
      },
      {
        "<leader>ad",
        function() require("sidekick.cli").close() end,
        desc = "Detach a CLI Session",
      },
      {
        "<leader>at",
        function() require("sidekick.cli").send({ msg = "{this}" }) end,
        mode = { "x", "n" },
        desc = "Send This",
      },
      {
        "<leader>af",
        function() require("sidekick.cli").send({ msg = "{file}" }) end,
        desc = "Send File",
      },
      {
        "<leader>av",
        function() require("sidekick.cli").send({ msg = "{selection}" }) end,
        mode = { "x" },
        desc = "Send Visual Selection",
      },
      {
        "<leader>ap",
        function() require("sidekick.cli").prompt() end,
        mode = { "n", "x" },
        desc = "Sidekick Select Prompt",
      },
    },
  },

  {
    "nanoboom/sidekick.nvim",
    optional = true,
    opts = {
      nes = {
        enabled = false,
      },
      cli = {
        mux = {
          backend = "herdr", -- Enable herdr as the multiplexer
          enabled = true,
          create = "split",
          split = {
            size = 0.4, -- Adjust the size of the new herdr pane/window
          },
        },
        tools = {
          claude = {
            cmd = { "claude", "--permission-mode", "bypassPermissions" },
            env = {
              HTTP_PROXY = "http://127.0.0.1:7890",
              HTTPS_PROXY = "http://127.0.0.1:7890",
              TZ = "Asia/Singapore",
            },
          },
          codex = {
            cmd = { "codex", "--dangerously-bypass-approvals-and-sandbox" },
            env = {
              http_proxy = "http://127.0.0.1:7890",
              https_proxy = "http://127.0.0.1:7890",
              HTTP_PROXY = "http://127.0.0.1:7890",
              HTTPS_PROXY = "http://127.0.0.1:7890",
            },
          },
        },
      },
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    optional = true,
    keys = {
      {
        "<leader>aw",
        function()
          if vim.bo.filetype ~= "NvimTree" then
            vim.notify("请在 NvimTree 中选择文件", vim.log.levels.WARN)
            return
          end

          local api = require("nvim-tree.api")
          local paths = {}

          -- 优先使用标记的文件
          for _, node in ipairs(api.marks.list() or {}) do
            if node.type == "file" and node.absolute_path and node.absolute_path ~= "" then
              paths[#paths + 1] = node.absolute_path
            end
          end

          -- 没有文件标记时，使用光标下的文件或目录
          if #paths == 0 then
            local node = api.tree.get_node_under_cursor()
            if
              node
              and (node.type == "file" or node.type == "directory")
              and node.absolute_path
              and node.absolute_path ~= ""
            then
              paths[1] = node.absolute_path
            end
          end

          if #paths == 0 then
            vim.notify("未找到可添加的文件或目录", vim.log.levels.WARN)
            return
          end

          local location = require("sidekick.cli.context.location")
          local text = {}

          for _, path in ipairs(paths) do
            vim.list_extend(text, location.get({ name = path }, { kind = "file" }))
          end

          require("sidekick.cli").send({
            text = text,
            focus = false,
            submit = false,
            -- name = "claude", -- 可选：指定目标 agent
          })
        end,
        mode = "n",
        desc = "Add NvimTree Files To Agent",
      },
    },
  },

  {
    "folke/snacks.nvim",
    optional = true,
    opts = {
      picker = {
        actions = {
          sidekick_send = function(...)
            return require("sidekick.cli.picker.snacks").send(...)
          end,
        },
        win = {
          input = {
            keys = {
              ["<a-a>"] = {
                "sidekick_send",
                mode = { "n", "i" },
              },
            },
          },
        },
      },
    },
  },
}
