-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.hlsearch = true -- 高亮所有搜索结果
opt.incsearch = true -- 输入搜索词时实时预览

opt.timeoutlen = 500 -- 组合键等待时间
opt.ttimeoutlen = 10 -- 特殊键
