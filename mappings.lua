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
    ["<leader>gsq"] = {
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
    ["<leader>gg"] = {
      "<cmd>:LazyGit<cr>",
      "open session",
    },
    -- ["<LEADER>y"] = {
    --   "<cmd>y+",
    --   "Copy",
    -- },
    -- ["<C-m>"] = { // <C-m> 代表回车键
    --   "<nop>",
    -- }
  },
  v = {
    [">"] = { ">gv", "indent" },
  },
}

M.nvimtree = {
  plugin = true,

  n = {
    -- toggle
    ["<LEADER>m"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree", opts = { nowait = true } },
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
