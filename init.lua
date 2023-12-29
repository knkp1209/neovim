-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
local opt = vim.opt
local autocmd = vim.api.nvim_create_autocmd

opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false
opt.scrolloff = 5
opt.sidescroll=10

opt.wrap = true
opt.cursorline = true
opt.showcmd = true
opt.wildmenu = true


-- 自动删除行尾空格
autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        vim.cmd [[%s/\s\+$//e]]
    end
})

autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    vim.lsp.buf.format { async = false }
  end,
})

-- 设置 go 不换行及空格数
autocmd("FileType", {
	pattern = "go",
	command = "setlocal shiftwidth=4 tabstop=4  nowrap"
})

-- 设置 php 不换行及空格数
autocmd("FileType", {
	pattern = "php",
	command = "setlocal shiftwidth=4 tabstop=4  nowrap"
})

-- 记录当前输入法
Current_input_method = vim.fn.system("/usr/local/bin/macism")

-- 切换到英文输入法
function Switch_to_English_input_method()
    Current_input_method = vim.fn.system("/usr/local/bin/macism")
    if Current_input_method ~= "com.apple.keylayout.ABC\n" then
        vim.fn.system("/usr/local/bin/macism com.apple.keylayout.ABC")
    end
end

-- 设置输入法
function Set_input_method()
    if Current_input_method ~= "com.apple.keylayout.ABC\n" then
        vim.fn.system("/usr/local/bin/macism " .. string.gsub(Current_input_method, "\n", ""))
    end
end

-- 进入 normal 模式时切换为英文输入法
-- autocmd InsertEnter * :lua Set_input_method()
vim.cmd([[
augroup input_method
  autocmd!
  autocmd InsertLeave * :lua Switch_to_English_input_method()
augroup END
]])


-- vim.cmd([[
-- augroup waitpluginsloaded
--   autocmd!
--   autocmd vimenter * :lua require("persistence").load()
-- augroup END
-- ]])

-- 代码片段
-- vim.g.snipmate_snippets_path = "/Users/yangwenhang/.config/nvim/lua/custom/snippets"
vim.g.vscode_snippets_path = "/Users/yangwenhang/.config/nvim/lua/custom/snippets"
-- vim.g.lua_snippets_path = "/Users/yangwenhang/.config/nvim/lua/custom/snip"
--
--

-- local actions = require("telescope.actions")

-- tmux
vim.g.tmux_navigator_no_mappings = 1

-- gitsigns
-- 函数用于设置 highlight 组的颜色
local function set_highlight(group, guifg, guibg, ctermfg, ctermbg)
    vim.cmd(string.format('highlight %s guifg=%s guibg=%s ctermfg=%s ctermbg=%s', group, guifg, guibg, ctermfg, ctermbg))
end
-- 设置 GitSigns 插件颜色
set_highlight('GitSignsChange', '#38E8FF', 'NONE', 'NONE', 'NONE')
