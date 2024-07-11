return { -- colorizer.nvim Visualize color codes in code
    'JosefLitos/colorizer.nvim',
    cmd = { 'ColorizerToggle' },
    keys = {
        {
            '<leader>h',
            '<CMD>ColorizerToggle<CR><CMD>ColorizerReloadAllBuffers<CR>',
            desc = '[h]ighlight colors',
        },
    },
    opts = {
        user_default_options = {
            names = 'tailwind',
        },
    },
}
