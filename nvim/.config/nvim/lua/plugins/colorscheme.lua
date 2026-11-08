-- ~/.config/nvim/lua/plugins/colorscheme.lua
return {
  {
    "tomasr/molokai",
    lazy = false, -- 主题必须在启动时立即加载
    priority = 1000, -- 优先级最高，覆盖 LazyVim 默认的 tokyonight
  },
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "molokai" },
  },
}
