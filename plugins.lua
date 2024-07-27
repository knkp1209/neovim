local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = require "custom.configs.gitsigns",
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit", -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "mfussenegger/nvim-dap",
    require("core.utils").load_mappings "dap",
    setup = function()
      local dap = require "dap"
      dap.adapters.delve = {
        type = "server",
        port = "${port}",
        executable = {
          command = "dlv",
          args = { "dap", "-l", "127.0.0.1:${port}" },
        },
      }

      -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
      dap.configurations.go = {
        {
          type = "delve",
          name = "Debug",
          request = "launch",
          program = "${file}",
        },
        {
          type = "delve",
          name = "Debug test", -- configuration for debugging test files
          request = "launch",
          mode = "test",
          program = "${file}",
        },
        -- works with go.mod packages and sub packages
        {
          type = "delve",
          name = "Debug test (go.mod)",
          request = "launch",
          mode = "test",
          program = "./${relativeFileDirname}",
        },
      }
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    requires = { "mfussenegger/nvim-dap" },
    -- stylua: ignore
    keys = {
      { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
      { "<leader>de", function() require("dapui").eval() end,     desc = "Eval",  mode = { "n", "v" } },
    },
    opts = {},
    config = function(_, opts)
      -- setup dap config by VsCode launch.json file
      -- require("dap.ext.vscode").load_launchjs()
      local dap = require "dap"
      local dapui = require "dapui"
      dapui.setup(opts)
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open {}
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close {}
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close {}
      end
    end,
  },
  {
    "leoluz/nvim-dap-go",
    -- cmd = "DebugGo",
    ft = "go",
    config = function(_, opts)
      require("dap-go").setup(opts)
    end,
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    opts = {
      -- add any custom options here
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  {
    "knkp1209/nvim-git",
    config = function()
      vim.api.nvim_create_user_command("ShowGitBlame", require("nvim-git").show_blame, {})
      vim.api.nvim_create_user_command("HideGitBlame", require("nvim-git").hide_blame, {})
    end,
    lazy = false,
  },
  {
    "knkp1209/nvim-ls",
    --   dependencies = { "benfowler/telescope-luasnip.nvim" },
    --   config = function()
    --     vim.api.nvim_create_user_command("Ll", require("telescope").extensions.my_extension.hello_telescope, {})
    --   end,
    lazy = false,
  },
  {
    "willothy/flatten.nvim",
    config = true,
    -- or pass configuration with
    -- opts = {  }
    -- Ensure that it runs first to minimize delay when opening file from terminal
    lazy = false,
    priority = 1001,
  },
  {
    lazy = false, -- 后续优化成判断启动
    "christoomey/vim-tmux-navigator",
  },
  {
    "robitx/gp.nvim",
    config = function()
      local config = {
        openai_api_key = os.getenv "OPENAI_API_KEY",
      }
      require("gp").setup(config)
    end,
    lazy = false,
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
    config = function()
      require("telescope").load_extension "frecency"
    end,
  },
  {
    "akinsho/bufferline.nvim",
    dependencies = {
      "nvim-tree/nvim-tree.lua",
      "nvim-tree/nvim-web-devicons",
    },
    event = "VeryLazy",
    config = function()
      require("bufferline").setup {
        options = {
          always_show_bufferline = false,
          show_buffer_close_icons = false,
          show_close_icon = false,
          offsets = {
            {
              filetype = "NvimTree",
              text = function()
                return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
              end,
              highlight = "Directory",
              separator = true,
            },
          },
          indicator = {
            icon = "", -- this should be omitted if indicator style is not 'icon'
            style = "icon",
          },
          -- max_name_length = 18,
          -- max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
          -- truncate_names = true,  -- whether or not tab names should be truncated
          -- tab_size = 18,
          diagnostics = "nvim_lsp",
          diagnostics_update_in_insert = false,
          diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local s = " "
            for e, n in pairs(diagnostics_dict) do
              local sym = e == "error" and " " or (e == "warning" and " " or "i")
              s = s .. n .. sym
            end
            return s
          end,
          -- diagnostics_indicator = diagnostics_indicator,
        },
        -- highlights = require("catppuccin.groups.integrations.bufferline").get(),
      }
    end,
  },
  {
    "crusj/bookmarks.nvim",
    keys = {
      { "<tab><tab>", mode = { "n" } },
    },
    branch = "main",
    dependencies = { "nvim-web-devicons" },
    config = function()
      require("bookmarks").setup()
      require("telescope").load_extension "bookmarks"
    end,
  },
  {
    "BYT0723/goctl.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
      require("goctl").setup()
    end,
    lazy = false,
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },
  {
    "luozhiya/fittencode.nvim",
    config = function()
      require("fittencode").setup()
    end,
    lazy = false,
  },
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },

  -- {
  --   "junegunn/fzf",
  --   lazy = false,
  -- },
  -- {
  --   "liuchengxu/vim-clap",
  --   lazy = false,
  -- },

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

return plugins
