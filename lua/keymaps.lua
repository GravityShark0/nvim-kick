-- Plugin remaps are located in the respective plugin definition
-- under their keys map

-- Run/Compile code inside {{{
-- Saved compile arguments are stolen from here
-- https://github.com/xiyaowong/transparent.nvim/blob/b075d5bb07fa1615b09585e1a2f7d2418c251562/lua/transparent/cache.lua
-- Just precreate the directory ~/.local/share/nvim/compile/
vim.keymap.set('n', '<leader>r', function()
    local path = vim.fn.stdpath('data')
        .. '/compile/'
        .. vim.api.nvim_buf_get_name(0):gsub('/', '@')
    local exists, lines = pcall(vim.fn.readfile, path)
    if exists and #lines > 0 then
        vim.b.runwithparameters = lines[1]
    end
    vim.ui.input({
        prompt = 'Run: ',
        default = vim.b.runwithparameters,
        completion = 'shellcmd',
    }, function(input)
        if input == nil or input == '' then
            print('See :h cmdline-special and :h filename-modifiers')
            return
        end
        vim.b.runwithparameters = input
        vim.fn.writefile({ input }, path)
        vim.cmd.split('term://' .. input)
        vim.opt_local.relativenumber = false
        vim.opt_local.number = false

        vim.api.nvim_buf_set_keymap(
            0,
            't',
            '<C-space>',
            '<C-\\><C-n><C-w>h',
            { silent = true }
        )
        vim.cmd.startinsert()
    end)
end, { desc = 'run command' })
vim.keymap.set('n', '<leader>R', function()
    local path = vim.fn.stdpath('data')
        .. '/compile/'
        .. vim.fn.getcwd():gsub('/', '@')
    local exists, lines = pcall(vim.fn.readfile, path)
    if exists and #lines > 0 then
        vim.g.runwithparametersglobally = lines[1]
    end
    vim.ui.input({
        prompt = 'Run Globally: ',
        default = vim.g.runwithparametersglobally,
        completion = 'shellcmd',
    }, function(input)
        if input == nil or input == '' then
            print('See :h cmdline-special and :h filename-modifiers')
            return
        end
        vim.g.runwithparametersglobally = input
        vim.fn.writefile({ input }, path)
        vim.cmd.split('term://' .. input)
        vim.opt_local.relativenumber = false
        vim.opt_local.number = false
        vim.cmd.startinsert()
        vim.api.nvim_buf_set_keymap(
            0,
            't',
            '<C-space>',
            '<C-\\><C-n><C-w>h',
            { silent = true }
        )
    end)
end, { desc = 'run command save globally' })
--}}}
-- Save and quit binings{{{
vim.api.nvim_set_keymap(
    'n',
    '<leader>w',
    '<CMD>w<CR>',
    { silent = true, desc = 'write current buffer' }
)
vim.api.nvim_set_keymap(
    'n',
    '<leader>W',
    '<CMD>wa<CR>',
    { silent = true, desc = 'Write all buffers' }
)

vim.api.nvim_set_keymap(
    'n',
    '<leader>q',
    '<CMD>wqa<CR>',
    { silent = true, desc = 'quit with saving' }
)
vim.api.nvim_set_keymap(
    'n',
    '<leader>Q',
    '<CMD>qa!<CR>',
    { silent = true, desc = 'Quit forcefully' }
) -- }}}
-- Allow for using the script ~t~ inside nvim {{{
vim.api.nvim_set_keymap('n', '<C-g>', '<CMD>silent !t<CR>', { silent = true })
-- }}}
-- Visual mode indents reenters visual mode {{{
vim.api.nvim_set_keymap('v', '>', '> gv', { noremap = true })
vim.api.nvim_set_keymap('v', '<', '< gv', { noremap = true })
-- }}}
-- g[y|d|p|P] uses to system clipboard{{{
vim.keymap.set({ 'n', 'v' }, 'gy', '"+y', { desc = 'Yank to system clipboard' })
vim.keymap.set(
    { 'n', 'v' },
    'gd',
    '"+d',
    { desc = 'Delete to system clipboard' }
)
vim.keymap.set(
    { 'n', 'v' },
    'gp',
    '<CMD> set paste<CR>"+p<CMD>set paste!<CR>',
    { desc = 'Paste system clipboard' }
) -- }}}
-- Middle positioned C+[D/U] and [n/N] {{{
vim.keymap.set(
    { 'n', 'v' },
    '<C-d>',
    '<C-d>zz',
    { noremap = true, silent = true }
)
vim.keymap.set(
    { 'n', 'v' },
    '<C-u>',
    '<C-u>zz',
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap('n', 'n', 'nzzzv', { silent = true })
vim.api.nvim_set_keymap('n', 'N', 'Nzzzv', { silent = true })
-- }}}
-- Netrw {{{
-- Open netrw on the left as nerdtree
-- vim.api.nvim_set_keymap('n', '<leader>>', '<CMD>Lex<CR>', { desc = 'nerdtree' })
-- Open current window as netrw
vim.api.nvim_set_keymap(
    'n',
    '<leader>.',
    '<CMD>Ex<CR>',
    { desc = 'file explorer' }
)
-- }}}
-- Closing buffers {{{
vim.api.nvim_set_keymap(
    'n',
    '<leader>c',
    '<CMD>bdelete<CR>',
    { desc = 'close buffer' }
)
vim.api.nvim_set_keymap(
    'n',
    '<leader>C',
    '<CMD>bdelete!<CR>',
    { desc = 'Close forcefully' }
) -- }}}
-- cnext cprev {{{
vim.api.nvim_set_keymap('n', 'cn', '<CMD>cnext<CR>zz', { desc = 'cnext' })
vim.api.nvim_set_keymap('n', 'cp', '<CMD>cprev<CR>zz', { desc = 'cprev' })
-- }}}
-- blazingly fast https://github.com/ThePrimeagen/init.lua/blob/master/lua/theprimeagen/remap.lua {{{
-- greatest remap ever
vim.api.nvim_set_keymap('x', '<leader>p', '"_dP', { desc = 'paste empty' })
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"_d', { desc = 'delete empty' })
vim.api.nvim_set_keymap(
    'n',
    '<leader><leader>',
    '<CMD>so<CR>',
    { desc = 'shout out' }
)
-- }}}
-- square bracket motions {{{
vim.api.nvim_set_keymap(
    'n',
    '[b',
    '<CMD>bprevious<CR>',
    { desc = 'Next buffer' }
)
vim.api.nvim_set_keymap('n', ']b', '<CMD>bnext<CR>', { desc = 'Next buffer' })
-- }}}

-- vim:foldmethod=marker:
