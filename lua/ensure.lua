-- A single file listing Treesitter, LSP, Mason, Formatting and Linting specs.
M = {}

M.treesitter = { -- {{{
    -- Go
    'go',
    'gomod',
    'gosum',
    'templ',
    -- Webdev
    'html',
    'css',
    'javascript',
    -- Languages
    'python',
    'bash',
    'sql',
    'lua',
    'c',
    -- Data/Config Formats
    'json',
    'yaml',
    'toml',
    -- Markup
    'markdown',
    'markdown_inline',
    'org',
    'typst',
    -- Other
    'vim',
    'vimdoc',
    'diff',
    'gitcommit',
    'query',
    'regex',
} -- }}}

M.mason = {
    -- Lua
    'lua-language-server',
    'stylua',

    -- Go
    'gopls',
    'golangci-lint',

    --- Webdev
    -- HTML
    'html-lsp',
    'emmet-language-server',
    -- 'htmx-lsp',
    -- CSS
    'css-lsp',
    'tailwindcss-language-server',
    -- Javascript
    'typescript-language-server',
    'prettierd',
    'quick-lint-js',

    -- C
    'clangd',
    'clang-format',

    -- Typst / General Text
    'typst-lsp',
    'ltex-ls',

    -- Python
    'ruff',
    'pyright',
} -- }}}

M.lsp = { -- {{{
    --[[ Example
    x_language_server = {
      cmd = {...},
      filetypes = { ...},
      capabilities = {},
      settings = {...},
    },]]

    lua_ls = {
        settings = {
            Lua = {
                completion = { autoRequire = true, callSnippet = 'Replace' },
                workspace = { checkThirdParty = false },
            },
        },
    },

    gopls = {
        settings = {
            gopls = {
                usePlaceholders = true,
                analyses = { unusedparams = true },
            },
        },
    },

    -- Webdev
    html = {},
    -- htmx = {},
    emmet_language_server = {},
    cssls = {},
    tailwindcss = {},
    tsserver = {},

    clangd = {},

    ltex = {
        filetypes = {
            'gitcommit',
            'markdown',
            'org',
            'html',
            'text',
            'typst',
        },
        on_attach = function(client, bufnr) -- rest of your on_attach process.
            require('ltex_extra').setup({ your_opts })
        end,

        settings = {
            ltex = {
                additionalRules = {
                    languageModel = '~/Other/ngrams/',
                },
            },
        },
    },
    typst_lsp = {
        settings = {
            exportPdf = 'never', -- Choose onType, onSave or never.
            -- serverPath = "" -- Normally, there is no need to uncomment it.
        },
    },

    pyright = {},
}

M.format = { -- {{{
    lua = { 'stylua' },
    css = { 'prettierd' },
    html = { 'prettierd' },
    json = { 'prettierd' },
    javascript = { 'prettierd' },
    markdown = { 'prettierd' },
    yaml = { 'prettierd' },
    c = { 'clang-format' },
    cpp = { 'clang-format' },
    go = { 'gofmt' },
    python = { 'ruff_format' },
}

M.formatextra = {
    python = {
        prepend_args = { '--config', '~/.ruff.toml' },
    },
} -- }}}

M.lint = { -- {{{
    python = { 'ruff' },
    javascript = { 'quick-lint-js' },
    go = { 'golangcilint' },
} -- }}}

-- For debuggers
-- M.mason_dap = { -- {{{
--     'delve',
--     'cppdbg',
-- } -- }}}

return M
