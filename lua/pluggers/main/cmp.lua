return {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
        -- Paths to sources
        'https://codeberg.org/FelipeLema/cmp-async-path',
        -- LSP completion capabilities
        'hrsh7th/cmp-nvim-lsp',
        -- Built-in vim auto-complete
        'hrsh7th/cmp-buffer',
        -- Add Snippets as possible completion
        {
            'garymjr/nvim-snippets',
            opts = {
                friendly_snippets = true,
            },
            dependencies = { 'rafamadriz/friendly-snippets' },
        },
        -- }}}
    },
    config = function() -- {{{
        local cmp = require('cmp')

        local kind_icons = {
            Text = '󰉿',
            Method = '󰆧',
            Function = '󰊕',
            Constructor = '',
            Field = '󰜢',
            Variable = '󰀫',
            Class = '󰠱',
            Interface = '',
            Module = '',
            Property = '󰜢',
            Unit = '󰑭',
            Value = '󰎠',
            Enum = '',
            Keyword = '󰌋',
            Snippet = '',
            Color = '󰏘',
            File = '󰈙',
            Reference = '󰈇',
            Folder = '󰉋',
            EnumMember = '',
            Constant = '󰏿',
            Struct = '󰙅',
            Event = '',
            Operator = '󰆕',
            TypeParameter = '',
        }

        ---@diagnostic disable-next-line: missing-fields
        cmp.setup({

            preselect = true and cmp.PreselectMode.Item
                or cmp.PreselectMode.None,

            window = {
                completion = {
                    completeopt = 'menu,menuone,noinsert',
                    border = 'rounded',
                    scrollbar = true,
                    winhighlight = 'FloatBorder:SpecialChar',
                },
                documentation = {
                    winhighlight = 'FloatBorder:SpecialChar',
                    border = 'rounded',
                    scrollbar = true,
                },
            },

            mapping = cmp.mapping.preset.insert({
                ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ['<C-Space>'] = cmp.mapping.complete({}),
            }),
            behavior = cmp.SelectBehavior.Select,

            completion = {
                completeopt = 'menu,menuone,noinsert',
            },

            sources = {
                { name = 'nvim_lsp' },
                { name = 'snippets' },
                { name = 'async_path' },
                { name = 'buffer' },
                -- Org mode
                { name = 'orgmode' },
            },

            ---@diagnostic disable-next-line: missing-fields
            formatting = {
                fields = { 'abbr', 'kind', 'menu' },
                format = function(entry, vim_item)
                    vim_item.menu = ({
                        buffer = 'Buf',
                        nvim_lsp = 'LSP',
                        snippets = 'Snp',
                        async_path = 'Pth',
                        orgmode = 'Org',
                    })[entry.source.name]
                    vim_item.kind = string.format(
                        '%s %s',
                        kind_icons[vim_item.kind],
                        vim_item.kind
                    )
                    return vim_item
                end,
            },

            experimental = {
                ghost_text = {
                    hl_group = 'CmpGhostText',
                },
            },
        })
    end, -- }}}
}
