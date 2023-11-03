local null_ls = require "null-ls"

local b = null_ls.builtins

local goimports = b.formatting.goimports
local e = os.getenv "GOIMPORTS_LOCAL"
if e ~= nil then
  goimports = goimports.with { extra_args = { "-local", e } }
end

local sources = {

  -- webdev stuff
  b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  b.formatting.prettier.with { filetypes = { "html", "markdown", "css", "formatting" } }, -- so prettier works only on these filetypes

  -- Go
  goimports,

  -- Lua
  b.formatting.stylua,

  -- cpp
  b.formatting.clang_format,

  -- php
  b.formatting.phpcsfixer,

}

null_ls.setup {
  debug = true,
  sources = sources,
}
