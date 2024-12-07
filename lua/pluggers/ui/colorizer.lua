return { -- colorizer.nvim Visualize color codes in code
    'catgoose/colorizer.nvim',
    cmd = { 'ColorizerToggle' },
    keys = {
        {
            '<leader>ch',
            '<CMD>ColorizerToggle<CR><CMD>ColorizerReloadAllBuffers<CR>',
            desc = 'highlight colors',
        },
    },
    opts = {
        user_default_options = {
            css = true,
            tailwind = true,
        },
    },
}
