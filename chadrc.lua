---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "nightfox",
  theme_toggle = { "nightfox", "one_light" },

  -- 透明
  transparency = true,

  hl_override = highlights.override,
  hl_add = highlights.add,

  lsp_semantic_tokens = true, -- needs nvim v0.9, just adds highlight groups for lsp semantic tokens

  statusline = {
    -- modules arg here is the default table of modules
    overriden_modules = function(modules)
      modules[2] = (function()
        local filename = vim.api.nvim_call_function("expand", { "%:p" })
        local length = string.len(filename)
        if length > 60 then
          filename = string.sub(filename, length - 60)
        end
        -- return "%{strpart(expand('%:p'), len(), 10)}"
        return filename
      end)()
    end,
  },

  -- lazyload it when there are 1+ buffers
  tabufline = {
    show_numbers = false,
    enabled = false,
    lazyload = true,
    overriden_modules = nil,
  },

}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
