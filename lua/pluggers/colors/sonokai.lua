return {
    'sainnhe/sonokai',
    lazy = false,
    enabled = true,
    opts = { disable_background = true },
    config = function()
        vim.opt.termguicolors = true
        vim.g.sonokai_style = 'andromeda'
        vim.g.sonokai_better_performance = 1
        vim.g.sonokai_transparent_background = 1
        vim.g.sonokai_enable_italic = 1
        vim.cmd.colorscheme('sonokai')
    end,
}
