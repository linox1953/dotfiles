-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- fcitx5 输入法自动切换
if vim.fn.executable('fcitx5-remote') == 1 then
  local function fcitx2en()
    if vim.trim(vim.fn.system('fcitx5-remote')) == '2' then
      vim.b.inputtoggle = 1
      vim.fn.system('fcitx5-remote -c')
    end
  end

  local function fcitx2zh()
    if vim.b.inputtoggle == 1 then
      vim.fn.system('fcitx5-remote -o')
      vim.b.inputtoggle = 0
    end
  end

  local aug = vim.api.nvim_create_augroup('FcitxToggle', { clear = true })

  vim.api.nvim_create_autocmd('InsertLeave', {
    group = aug,
    callback = function()
      if vim.fn.reg_executing() == '' then fcitx2en() end
    end,
  })

  vim.api.nvim_create_autocmd('InsertEnter', {
    group = aug,
    callback = function()
      if vim.fn.reg_executing() == '' then fcitx2zh() end
    end,
  })

  vim.api.nvim_create_autocmd('CmdlineEnter', {
    group = aug,
    pattern = { '/', '?' },
    callback = function()
      if vim.fn.reg_executing() == '' then fcitx2zh() end
    end,
  })

  vim.api.nvim_create_autocmd('CmdlineLeave', {
    group = aug,
    pattern = { '/', '?' },
    callback = function()
      if vim.fn.reg_executing() == '' then fcitx2en() end
    end,
  })
end
