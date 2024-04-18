-- See `:help vim.o`

-- Opts {{{
-- Allow switching buffers without saving them
vim.o.hidden = true

-- Global statusline
vim.opt.laststatus = 3

-- Line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- Undofile
vim.opt.undofile = true

-- For orgmode
vim.opt.conceallevel = 2
vim.opt.concealcursor = 'nc'

-- Disable that weird effect where it changes the color of your cursor
vim.opt.matchtime = 0

-- Leaves 8 lines of extra space
vim.opt.scrolloff = 8

-- Decrease update time
vim.o.updatetime = 250 -- 50
vim.o.timeoutlen = 300
vim.o.timeout = true -- whichkey

-- Enable break indent
vim.o.breakindent = true

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noinsert,noselect'
vim.opt.colorcolumn = '80'

vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new vertical splits to right

vim.opt.expandtab = true -- Use spaces by default
vim.opt.shiftwidth = 8 -- Set amount of space characters, when we press "<" or ">"

vim.opt.softtabstop = 8
vim.opt.tabstop = 8 -- 1 tab equal 2 spaces
vim.opt.smartindent = true -- Turn on smart indentation. See in the docs for more info

vim.opt.foldmethod = 'marker' -- Good

vim.opt.ignorecase = true -- Ignore case if all characters in lower case
vim.opt.joinspaces = false -- Join multiple spaces in search
vim.opt.smartcase = true -- When there is a one capital letter search for exact match
vim.opt.showmatch = true -- Highlight search instances

-- Undotree Layout
vim.g.undotree_WindowLayout = 3

-- Disable showing --Insert-- or --Visual-- in the cmdline
vim.opt.showmode = false

-- [[ Wild Menu ]]
-- already is the defalut in neovim
-- vim.o.wildmenu = true

-- Set wildcharm to trigger the wildmenu
-- vim.o.wildcharm = string.byte('<Tab>')
-- }}}

-- mini.basics{{{
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.mouse = 'a'
vim.opt.cursorline = true
vim.opt.linebreak = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.ruler = false
vim.opt.wrap = false

vim.opt.signcolumn = 'yes'
vim.opt.fillchars = 'eob: '

-- Editing
-- vim.opt.incsearch = true
-- vim.opt.infercase = true
vim.opt.virtualedit = 'block'
vim.opt.formatoptions = 'qjl1'

vim.opt.termguicolors = true

-- vim.opt.pumblend = 10
vim.opt.pumheight = 10
-- vim.opt.winblend = 10}}}

-- [[ Highlight on yank ]]{{{
-- See `:help vim.highlight.on_yank()`
local highlight_group =
    vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})
--}}}

-- LSP Diagnostics Signs {{{
local signs = { Error = ' ', Warn = ' ', Hint = '󰌵 ', Info = '󰋼 ' }
for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
-- }}}

-- Automatic disabling/renabling bufferline at 1 > Buffers ; 1 < Buffers {{{

function CheckTabline()
    -- Get the count of active buffers
    local buffers = vim.fn.len(vim.fn.getbufinfo({ buflisted = 1 }))

    if buffers == 1 then
        vim.o.showtabline = 0
    elseif buffers > 1 then
        vim.o.showtabline = 2
    end
end

TABLINE_AUTOCMD_ID = vim.api.nvim_create_autocmd({
    'BufAdd',
    'BufDelete',
    'UIEnter',
}, { callback = CheckTabline })

function ToggleBar()
    if vim.o.showtabline == 0 then
        vim.o.showtabline = 2
        TABLINE_AUTOCMD_ID = vim.api.nvim_create_autocmd({
            'BufAdd',
            'BufDelete',
            'UIEnter',
        }, { callback = CheckTabline })
    else
        if vim.o.showtabline == 2 then
            vim.o.showtabline = 0
            vim.api.nvim_del_autocmd(TABLINE_AUTOCMD_ID)
        end
    end
end

-- }}}

-- Formatting disable and enable{{{
vim.api.nvim_create_user_command('FormatDisable', function(args)
    if args.bang then
        vim.b.disable_autoformat = true
    else
        vim.g.disable_autoformat = true
    end
end, {
    desc = 'Disable autoformat-on-save',
    bang = true,
})
vim.api.nvim_create_user_command('FormatEnable', function()
    vim.b.disable_autoformat = false
    vim.g.disable_autoformat = false
end, {

    desc = 'Re-enable autoformat-on-save',
}) -- }}}
