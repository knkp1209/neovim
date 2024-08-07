local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "c",
    "markdown",
    "markdown_inline",
    "php",
    "go",
    "gomod",
    "gosum",
    "gowork",
    "comment",
    "jsdoc",
    "fish",
    "json",
    "yaml",
    "scss",
    "vue",
    "svelte",
    "python",
    "proto",
    "sql",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",

    -- c/cpp stuff
    -- "clangd",
    -- "clang-format",

    -- php
    "intelephense",
    "phpactor",
    "php-cs-fixer",

    -- go
    "gopls",
    "goimports",
    "gofumpt",
    "golangci-lint-langserver",

    -- python
    "jedi-language-server",

    -- vue
    -- "vue-language-server",
    -- "vetur-vls",
    "vue-language-server",

    -- proto
    "bufls",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
    ignore = false,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

M.telescope = {
  pickers = {
    find_files = {
      -- 设置 Telescope 默认在当前目录搜索
      cwd = vim.fn.expand "%:p:h",
    },
  },
}

return M
