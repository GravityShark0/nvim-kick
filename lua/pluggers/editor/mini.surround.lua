return { -- mini.surround Surround text with any character
    'echasnovski/mini.surround',
    keys = {
        { 'S', mode = 'v' },
        { 'ys', desc = 'Add surrounding' },
        { 'ds', desc = 'Delete surrounding' },
        { 'cs', desc = 'Change surrounding' },
        -- { 'sf', desc = 'Find right surrounding' },
        -- { 'sF', desc = 'Find left surrounding' },
        -- { 'sh', desc = 'Highlight surrounding' },
        -- { 'sn', desc = 'Update `MiniSurround.config.n_lines`' },
    },
    config = function()
        require('mini.surround').setup({
            mappings = {
                add = 'ys',
                delete = 'ds',
                find = '',
                find_left = '',
                highlight = '',
                replace = 'cs',
                update_n_lines = '',

                -- Add this only if you don't want to use extended mappings
                suffix_last = '',
                suffix_next = '',
            },
            search_method = 'cover_or_next',
        })

        -- Remap adding surrounding to Visual mode selection
        vim.keymap.del('x', 'ys')
        vim.keymap.set(
            'x',
            'S',
            [[:<C-u>lua MiniSurround.add('visual')<CR>]],
            { silent = true }
        )

        -- Make special mapping for "add surrounding for line"
        vim.keymap.set('n', 'yss', 'ys_', { remap = true })
    end,
}
