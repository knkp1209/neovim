local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local configs = require 'lspconfig.configs'

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "clangd", "intelephense", "phpactor", "gopls", "golangcilsp"}

local current_directory = vim.fn.getcwd()
local golangcilspconfigfile = current_directory .. "/.golangci.yaml"

-- print("Current Directory:", current_directory)

configs.golangcilsp = {
  default_config = {
    cmd = { "golangci-lint-langserver" },
    filetypes = { "go" },
    root_dir = lspconfig.util.root_pattern("go.mod", ".git"),
		init_options = {
			command = {
				"golangci-lint",
				"run",
				"--config=" .. golangcilspconfigfile,
				"--fast",
				"--out-format",
				"json",
			},
		},
    on_attach = on_attach,
  },
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end


--
-- lspconfig.pyright.setup { blabla}
