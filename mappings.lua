---@type MappingsTable
local M = {}

M.general = {
  n = {
    --    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>go"] = {
      ":vs<CR>:term cd /Volumes/develop/rrzuji/data_center/data_center_server && source .env && go build && ./go-admin server<CR>",
      "编辑运行",
      opts = { nowait = true },
    },
    ["s"] = {
      "<nop>",
    },
    ["<leader>yp"] = {
      ":let @+ = expand('%:p') <CR> \n",
      opts = { nowait = true },
    },
    ["<C-n>"] = {
      "<Down>",
      "Move down",
    },
    ["<leader>cc"] = {
      ":cclose <CR>",
      opts = { nowait = true },
    },
    ["<leader>cl"] = {
      ":lclose <CR>",
      opts = { nowait = true },
    },
    ["<leader>lds"] = {
      "<cmd>lua vim.lsp.buf.document_symbol()<CR>",
      "Show code struct",
    },
    -- git
    ["<leader>gq"] = {
      ":Gitsigns setqflist <CR>",
      opts = { nowait = true },
    },
    ["<leader>gl"] = {

      function()
        local filename = vim.api.nvim_call_function("expand", { "%:p" })

        local escapedFileName = vim.api.nvim_call_function("shellescape", { filename, 1 })
        local content =
          vim.api.nvim_call_function("system", { "git log --patch --oneline --follow -- " .. escapedFileName })
        local bufnr = vim.api.nvim_create_buf(true, false) -- 设置第二个参数为 false

        vim.api.nvim_buf_set_lines(bufnr, 0, -1, true, vim.split(content, "\n"))
        vim.api.nvim_set_current_buf(bufnr)
      end,
      "Show git log file  detail",
    },

    ["<leader>qs"] = {
      function()
        require("persistence").load()
      end,
      "open session",
    },
    -- ["<leader>qq"] = {
    --   "<cmd>:qa<cr>",
    --   "退出程序",
    -- },
    ["<leader>lg"] = {
      "<cmd>:LazyGit<cr>",
      "open session",
    },
    ["<leader>gg"] = {
      "<cmd>:Telescope git_status<cr>",
      "open session",
    },

    -- tmux 配置
    ["<C-h>"] = { ":TmuxNavigateLeft<CR>", opts = { silent = true } },
    ["<C-j>"] = { ":TmuxNavigateDown<CR>", opts = { silent = true } },
    ["<C-k>"] = { ":TmuxNavigateUp<CR>", opts = { silent = true } },
    ["<C-l>"] = { ":TmuxNavigateRight<CR>", opts = { silent = true } },
    -- ["<Previous-Mapping>"] = { ":TmuxNavigatePrevious<CR>", opts = { silent = true } },

    -- ["<LEADER>y"] = {
    --   "<cmd>y+",
    --   "Copy",
    -- },
    -- ["<C-m>"] = { // <C-m> 代表回车键
    --   "<nop>",
    -- }
    --
    -- 配合 iterm 终端 分离 ctrl+i 和 tab 键
    ["<esc>CI"] = { '<C-i>', opts = { noremap = true, silent = true } },

    -- telescope file browser
    ["<leader>fe"] = {
      function()
        require("telescope").extensions.file_browser.file_browser()
      end,
      "Telescope file browser",
    },

    -- telescope file browser
    ["<leader>mm"] = {
      function()
        require("bookmarks").add_bookmarks()
      end,
      "添加标签",
    },

    ["<leader>md"] = {
      function()
        require("bookmarks.list").delete_on_virt()
      end,
      "删除标签",
    },

    ["<leader>ms"] = {
      function()
        require("bookmarks").toggle_bookmarks()
      end,
      "显示标签",
    },

  },
  v = {
    [">"] = { ">gv", "indent" },
  },
  t = {
    ["<leader>\\"] = {
      "<C-\\><C-n>",
      opts = { noremap = true, silent = true },
    },
  },
}

M.nvimtree = {
  plugin = true,

  n = {
    -- focus
    ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "Focus nvimtree" },
  },
}

-- 用 akinsho/bufferline 替换 nvchad.tabufline
M.tabufline = {
  plugin = false,
}

M.bufferline = {
  n = {
    -- cycle through buffers
    ["<tab>"] = {
      "<cmd>BufferLineCycleNext<cr>",
      "Goto next buffer",
    },

    ["<S-tab>"] = {
      "<cmd>BufferLineCyclePrev<cr>",
      "Goto prev buffer",
    },

    -- close buffer + hide terminal buffer
    ["<leader>x"] = {
      "<cmd>BufferLineCyclePrev<cr><cmd>BufferLineCloseRight<cr>",
      "Close current buffer",
    },
  },
}

M.dap = {
  plugin = true,
  n = {
    ["<LEADER>db"] = {
      "<cmd> DapToggleBreakpoint \n",
      "Add breakpoint at line",
    },
    ["<LEADER>dc"] = {
      "<cmd> DapContinue \n",
      "Debug launch",
    },
    ["<LEADER>dsi"] = {
      "<cmd> DapStepInto \n",
      "Debug step into",
    },
    ["<LEADER>dso"] = {
      "<cmd> DapStepOut \n",
      "Debug step out",
    },
    ["<LEADER>dsj"] = {
      "<cmd> DapStepOver \n",
      "Debug step over",
    },
    ["<LEADER>dus"] = {
      function()
        local widgets = require "dap.ui.widgets"
        local sidebar = widgets.sidebar(widgets.scopes)
        sidebar.open()
      end,
      "Open debugging sidebar",
    },

    -- Telescope frecency
    ["<leader>ff"] = { "<cmd> Telescope frecency workspace=CWD <CR>", "Find files" },
  },
}

M.lspconfig = {
  -- plugin = true,

  -- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions

  n = {
    ["gD"] = {
      function()
        vim.lsp.buf.declaration()
      end,
      "LSP declaration",
    },

    ["gd"] = {
      function()
        -- vim.lsp.buf.definition()
        require("telescope.builtin").lsp_definitions()
      end,
      "LSP definition",
    },

    ["K"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "LSP hover",
    },

    ["gi"] = {
      function()
        -- vim.lsp.buf.implementation()
        require("telescope.builtin").lsp_implementations()
      end,
      "LSP implementation",
    },

    ["<leader>ls"] = {
      function()
        vim.lsp.buf.signature_help()
      end,
      "LSP signature help",
    },

    ["<leader>D"] = {
      function()
        -- vim.lsp.buf.type_definition()
        require("telescope.builtin").lsp_type_definitions()
      end,
      "LSP definition type",
    },

    ["<leader>ra"] = {
      function()
        require("nvchad.renamer").open()
      end,
      "LSP rename",
    },

    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "LSP code action",
    },

    ["gs"] = {
      function()
        -- vim.lsp.buf.references()
        require("telescope.builtin").lsp_document_symbols()
      end,
      "LSP references",
    },

    ["gr"] = {
      function()
        -- vim.lsp.buf.references()
        require("telescope.builtin").lsp_references()
      end,
      "LSP references",
    },

    ["<leader>lf"] = {
      function()
        vim.diagnostic.open_float { border = "rounded" }
      end,
      "Floating diagnostic",
    },

    ["[d"] = {
      function()
        vim.diagnostic.goto_prev { float = { border = "rounded" } }
      end,
      "Goto prev",
    },

    ["]d"] = {
      function()
        vim.diagnostic.goto_next { float = { border = "rounded" } }
      end,
      "Goto next",
    },
    --
    -- ["<leader>q"] = {
    --   function()
    --     require("telescope.builtin").diagnostics()
    --   end,
    --   "Telescope Diagnostic ",
    -- },

    ["<leader>wa"] = {
      function()
        vim.lsp.buf.add_workspace_folder()
      end,
      "Add workspace folder",
    },

    ["<leader>wr"] = {
      function()
        vim.lsp.buf.remove_workspace_folder()
      end,
      "Remove workspace folder",
    },

    ["<leader>wl"] = {
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      "List workspace folders",
    },
  },

  v = {
    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "LSP code action",
    },
  },
}

-- M.dap_go = {
--   plugin = true,
--   n = {
--     ["<LEADER>dgt"] = {
--       function()
--         require("dap-go").debug_test()
--       end,
--       "Debug go test",
--     },
--     ["<LEADER>dgl"] = {
--       function()
--         require("dap-go").debug_last()
--       end,
--       "Debug last go test",
--     },
--   },
-- }

-- more keybinds!

return M
