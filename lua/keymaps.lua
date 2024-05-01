-- Keymaps for better default experience
-- See `:help vim.api.nvim_set_keymap()`
-- vim.keymap.set({ 'n', 'v' }, '<leader>', '<Nop>', { silent = true })

vim.api.nvim_set_keymap(
    'n',
    '<leader>w',
    '<CMD>w<CR>',
    { silent = true, desc = '[w]rite current buffer' }
)
vim.api.nvim_set_keymap(
    'n',
    '<leader>W',
    '<CMD>wa<CR>',
    { silent = true, desc = '[W]rite all buffers' }
)

vim.api.nvim_set_keymap(
    'n',
    '<leader>q',
    '<CMD>wq<CR>',
    { silent = true, desc = 'write and [q]uit' }
)
vim.api.nvim_set_keymap(
    'n',
    '<leader>Q',
    '<CMD>wqa<CR>',
    { silent = true, desc = 'write all and [Q]uit buffers' }
)

-- Allow for using t inside nvim {{{
vim.api.nvim_set_keymap('n', '<C-t>', '<CMD>!t<CR>', { silent = true })
-- }}}

-- X Remap for dealing with word wrap{{{
-- vim.api.nvim_set_keymap(
--     'n',
--     'k',
--     "v:count == 0 ? 'gk' : 'k'",
--     { expr = true, silent = true }
-- )
-- vim.api.nvim_set_keymap(
--     'n',
--     'j',
--     "v:count == 0 ? 'gj' : 'j'",
--     { expr = true, silent = true }
-- )
-- }}}

-- Easier visual mode indents {{{
vim.api.nvim_set_keymap('v', '>', '> gv', { noremap = true })
vim.api.nvim_set_keymap('v', '<', '< gv', { noremap = true })
-- }}}

-- g[y|d|p|P] uses to system clipboard{{{
vim.keymap.set(
    { 'n', 'v' },
    'gy',
    '"+y',
    { desc = '[y]ank to system clipboard' }
)
vim.keymap.set(
    { 'n', 'v' },
    'gd',
    '"+d',
    { desc = '[d]elete to system clipboard' }
)
vim.keymap.set(
    { 'n', 'v' },
    'gp',
    '<CMD> set paste<CR>"+p<CMD>set paste!<CR>',
    { desc = '[p]aste System Clipboard' }
)
vim.keymap.set(
    { 'n', 'v' },
    'gP',
    '<CMD> set paste<CR>"+P<CMD>set paste!<CR>',
    { desc = 'reverse [P]aste System Clipboard' }
) -- }}}

-- Middle positioned C+ D/U{{{
vim.api.nvim_set_keymap(
    'n',
    '<C-d>',
    '<C-d>zz',
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    'n',
    '<C-u>',
    '<C-u>zz',
    { noremap = true, silent = true }
)
-- }}}

-- Run/Compile code inside{{{
vim.keymap.set(
    'n',
    '<leader>rgc',
    function()
        local file = vim.api.nvim_buf_get_name(0)
        local file_noext = file:match('^(.+)%.+')
        os.execute('gcc ' .. file .. ' --debug -o ' .. file_noext)
        vim.api.nvim_command('echo "Compiled to ' .. file_noext .. '"')
    end,
    -- '<CMD>!gcc % --debug -o %<CR>',
    { desc = '[c]ompile' }
)
vim.keymap.set(
    'n',
    '<leader>rgr',
    "<CMD>!gcc % --debug -o /tmp/a.out<CR><CMD>!'/tmp/a.out<CR>'",
    { desc = '[r]un' } -- runs in
)
vim.keymap.set(
    'n',
    '<leader>rgR',
    function()
        os.execute(
            'gcc ' .. vim.api.nvim_buf_get_name(0) .. ' --debug -o /tmp/a.out'
        )
        vim.ui.input({ prompt = 'Prompt: ' }, function(input)
            vim.api.nvim_command('!/tmp/a.out ' .. input)
        end)
    end,
    { desc = '[R]un with parameters' } -- runs in
)
-- vim.keymap.set('n', '<leader>rgd', '<CMD><CR>', { desc = '[d]ebug' })
vim.keymap.set(
    'n',
    '<leader>rx',
    '<CMD>!chmod +x %<CR>',
    { desc = 'chmod +[x] %' }
)
-- }}}

-- LSP {{{
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        vim.keymap.set(
            'n',
            '<leader>lD',
            vim.lsp.buf.declaration,
            { buffer = ev.buf, desc = 'LSP [D]eclaration' }
        )
        vim.keymap.set(
            'n',
            '<leader>ld',
            vim.lsp.buf.definition,
            { buffer = ev.buf, desc = 'LSP [d]efinition' }
        )
        vim.keymap.set(
            'n',
            '[d',
            vim.diagnostic.goto_prev,
            { desc = 'Previous diagnostic' }
        )
        vim.keymap.set(
            'n',
            ']d',
            vim.diagnostic.goto_next,
            { desc = 'Next diagnostic' }
        )
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = ev.buf })
        vim.keymap.set(
            'i',
            '<C-h>',
            vim.lsp.buf.signature_help,
            { buffer = ev.buf }
        )
        vim.keymap.set(
            'n',
            '<leader>lw',
            vim.lsp.buf.workspace_symbol,
            { buffer = ev.buf, desc = 'LSP [w]orkspace Symbol' }
        )
        vim.keymap.set(
            'n',
            '<leader>ld',
            vim.diagnostic.open_float,
            { buffer = ev.buf, desc = 'LSP [d]iagnostics' }
        )
        vim.keymap.set(
            'n',
            '<leader>lc',
            vim.lsp.buf.code_action,
            { buffer = ev.buf, desc = 'LSP [c]ode actions' }
        )
        vim.keymap.set(
            'n',
            '<leader>lr',
            vim.lsp.buf.references,
            { buffer = ev.buf, desc = 'LSP re[f]erences' }
        )
        vim.keymap.set(
            'n',
            '<leader>lr',
            vim.lsp.buf.rename,
            { buffer = ev.buf, desc = 'LSP [r]ename' }
        )
        vim.keymap.set(
            'n',
            'gi',
            vim.lsp.buf.implementation,
            { buffer = ev.buf }
        )
        require('which-key').register({
            l = { name = '[l]sp' },
        }, { prefix = '<leader>' })
    end,
})

-- }}}

-- Telescope {{{
-- vim.api.nvim_set_keymap(
--     'n',
--     '<leader>fD',
--     '<CMD>Telescope lsp_definitions<CR>',
--     { noremap = true }
-- ) -- Goto declaration
vim.api.nvim_set_keymap(
    'n',
    '<leader>fr',
    '<CMD>Telescope oldfiles<CR>',
    { desc = 'Find [r]ecent' }
) -- Show recent files
vim.api.nvim_set_keymap(
    'n',
    '<leader>fg',
    '<CMD>Telescope git_files<CR>',
    { desc = 'Find [g]it Files' }
) -- Search for a file in project
vim.api.nvim_set_keymap(
    'n',
    '<leader>ff',
    '<CMD>Telescope find_files<CR>',
    { desc = 'Find [f]iles' }
) -- Search for a file (ignoring dotfiles)
vim.api.nvim_set_keymap(
    'n',
    '<leader>fa',
    '<CMD>Telescope find_files hidden=true no_ignore=true<CR>',
    { desc = 'Find [a]ll Files' }
) -- Search for a file (with dotfiles)
-- vim.api.nvim_set_keymap(
-- 	'n',
-- 	'<leader>fp',
-- 	'<CMD>Telescope jumplist<CR>',
-- 	{ noremap = true }
-- ) -- Show jumplist (previous locations)
vim.api.nvim_set_keymap(
    'n',
    '<leader>fb',
    '<CMD>Telescope git_branches<CR>',
    { noremap = true }
) -- Show git branches
vim.api.nvim_set_keymap(
    'n',
    '<leader>fl',
    '<CMD>Telescope live_grep<CR>',
    { desc = 'Find text using [l]ive grep' }
) -- Find a string in project
-- vim.api.nvim_set_keymap(
--     'n',
--     '<leader>fb',
--     '<CMD>Telescope buffers<CR>',
--     { desc = 'Find [b]uffers' }
-- ) -- Show all buffers
vim.api.nvim_set_keymap(
    'n',
    '<leader>f?',
    '<CMD>Telescope<CR>',
    { desc = 'Find ?' }
) -- Show all commands
vim.api.nvim_set_keymap(
    'n',
    '<leader>fs',
    '<CMD>Telescope persisted<CR>',
    { desc = 'Find sessions' }
) -- Show all sessions
-- vim.api.nvim_set_keymap(
--     'n',
--     '<leader>fs',
--     '<CMD>Telescope lsp_dynamic_workspace_symbols<CR>',
--     { desc = 'Find [s]ymbls' }
-- ) -- Search for dynamic symbols
-- vim.api.nvim_set_keymap(
-- 	'n',
-- 	'<leader>fn',
-- 	'<CMD>Telescope notify<CR>',
-- 	{ noremap = true , desc = 'Find [N]otification History' }
-- ) -- Show nvim-notify history
-- vim.api.nvim_set_keymap(
--     'n',
--     '<leader>fp',
--     '<CMD>Telescope project<CR>',
--     { desc = 'Find [p]rojects' }
-- ) -- Show projects
vim.api.nvim_set_keymap(
    'n',
    '<leader>fd',
    '<CMD>Telescope diagnostics<CR>',
    { desc = 'Find [d]iagnostics' }
) -- Show diagnostics
vim.api.nvim_set_keymap(
    'n',
    '<leader>f/',
    '<CMD>Telescope current_buffer_fuzzy_find<CR>',
    { desc = '[/] Fuzzily search in current buffer' }
) -- Show diagnostics
-- vim.keymap.set('n', '<leader>f/', function()
--     -- You can pass additional configuration to telescope to change theme, layout, etc.
--     require('telescope.builtin').current_buffer_fuzzy_find(
--         require('telescope.themes').get_dropdown({})
--     )
-- end, { desc = '[/] Fuzzily search in current buffer' })

-- }}}

-- netrw {{{
-- Open netrw on the right
vim.api.nvim_set_keymap('n', '<leader>n', '<CMD>Sex!<CR>', { desc = 'SEEX!!!' })
-- vim.api.nvim_set_keymap(
--     'n',
--     '<leader>l',
--     '<CMD>Lex<CR><CMD>vertical resize 50<CR>',
--     { desc = 'Lex??' }
-- )
-- Open current window as netrw
vim.api.nvim_set_keymap(
    'n',
    '<leader>e',
    '<CMD>Ex<CR>',
    { desc = '[e]xplorer in current window' }
)
-- }}}

-- Buffers {{{
-- Tabs to move around buffers
vim.api.nvim_set_keymap('n', '<Tab>', '<CMD>bnext<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<S-Tab>', '<CMD>bprev<CR>', { noremap = true })

-- function BufRem(number)
--     local bufremove = require('mini.bufremove')
--     if not bufremove.delete(number, false) then
--         local choice = vim.fn.confirm(
--             'Save changes to ' .. vim.fn.expand('%:p'),
--             '&Yes\n&No\n&Cancel',
--             3
--         )
--
--         if choice == 1 then
--             vim.cmd('update')
--             bufremove.delete(number, false)
--         elseif choice == 2 then
--             bufremove.delete(number, true)
--         end
--     end
--     CheckTabline()
-- end

vim.api.nvim_set_keymap(
    'n',
    '<leader>c',
    -- '<CMD>lua BufRem(0)<CR>',
    "<CMD>lua require('mini.bufremove').delete(); CheckTabline()<CR>",
    { desc = '[c]lose current buffer' }
)

vim.api.nvim_set_keymap(
    'n',
    'gb',
    '<CMD>lua ToggleBar()<CR>',
    { desc = 'Toggle buffer [b]ar' }
)

for i = 0, 9 - 1 do
    vim.api.nvim_set_keymap(
        'n',
        '<A-' .. i .. '>',
        -- '<CMD>lua if MiniTabline ~= nil then MiniTabline.select, ('
        --     .. i
        --     .. ') end<CR>',
        -- '<CMD>lua if MiniTabline ~= nil then pcall(MiniTabline.select, '
        --     .. i
        --     .. ') end<CR>',
        '<CMD>lua pcall(MiniTabline.select, '
            .. i
            .. ')<CR>',
        { silent = true }
    )
end
-- }}}

-- vim-fugtive {{{
vim.api.nvim_set_keymap(
    'n',
    '<leader>gg',
    '<CMD>Git<CR>',
    { desc = 'Git [g]it' }
)
vim.api.nvim_set_keymap(
    'n',
    '<leader>gd',
    '<CMD>Git diff<CR>',
    { desc = 'Git [d]iff' }
)
vim.api.nvim_set_keymap(
    'n',
    '<leader>gc',
    '<CMD>Git commit<CR>',
    { desc = 'Git [c]ommit' }
)
vim.api.nvim_set_keymap(
    'n',
    '<leader>gaa',
    '<CMD>Git add .<CR>',
    { desc = 'Git Add [a]ll' }
)
vim.api.nvim_set_keymap(
    'n',
    '<leader>gac',
    '<CMD>Git add %<CR>',
    { desc = 'Git Add [c]urrent buffer' }
)
vim.api.nvim_set_keymap(
    'n',
    '<leader>gs',
    '<CMD>Git show<CR>',
    { desc = 'Git [s]how' }
)
vim.api.nvim_set_keymap(
    'n',
    '<leader>gp',
    '<CMD>Git push<CR>',
    { desc = 'Git [p]ush' }
)

vim.api.nvim_set_keymap('n', 'gu', '<CMD>diffget //2<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'gh', '<CMD>diffget //3<CR>', { noremap = true })
-- }}}

-- Diagnostic keymaps{{{
-- vim.keymap.set(
--     'n',
--     '[d',
--     vim.diagnostic.goto_prev,
--     { desc = 'Go to previous diagnostic message' }
-- )
-- vim.keymap.set(
--     'n',
--     ']d',
--     vim.diagnostic.goto_next,
--     { desc = 'Go to next diagnostic message' }
-- )
-- vim.keymap.set(
-- 	'n',
-- 	'<leader>e',
-- 	vim.diagnostic.open_float,
-- 	{ desc = 'Open floating diagnostic message' }
-- )
-- vim.keymap.set(
-- 	'n',
-- 	'<leader>q',
-- 	vim.diagnostic.setloclist,
-- 	{ desc = 'Open diagnostics list' }
-- )
-- }}}

-- Luasnips{{{
vim.keymap.set({ 'i' }, '<C-K>', function()
    require('luasnip').expand()
end, { silent = true })
vim.keymap.set({ 'i', 's' }, '<C-L>', function()
    require('luasnip').jump(1)
end, { silent = true })
vim.keymap.set({ 'i', 's' }, '<C-J>', function()
    require('luasnip').jump(-1)
end, { silent = true })

vim.keymap.set({ 'i', 's' }, '<C-E>', function()
    if require('luasnip').choice_active() then
        require('luasnip').change_choice(1)
    end
end, { silent = true })
-- }}}

-- Resize windows {{{
-- https://github.com/echasnovski/mini.basics
vim.api.nvim_set_keymap(
    'n',
    '<C-Left>',
    '"<Cmd>vertical resize -" . v:count1 . "<CR>"',
    { expr = true, replace_keycodes = false, desc = 'Decrease window width' }
)
vim.api.nvim_set_keymap(
    'n',
    '<C-Down>',
    '"<Cmd>resize -"          . v:count1 . "<CR>"',
    { expr = true, replace_keycodes = false, desc = 'Decrease window height' }
)
vim.api.nvim_set_keymap(
    'n',
    '<C-Up>',
    '"<Cmd>resize +"          . v:count1 . "<CR>"',
    { expr = true, replace_keycodes = false, desc = 'Increase window height' }
)
vim.api.nvim_set_keymap(
    'n',
    '<C-Right>',
    '"<Cmd>vertical resize +" . v:count1 . "<CR>"',
    { expr = true, replace_keycodes = false, desc = 'Increase window width' }
)
vim.api.nvim_set_keymap(
    'n',
    '<C-H>',
    '<C-w>h',
    { desc = 'Focus on left window' }
)
vim.api.nvim_set_keymap(
    'n',
    '<C-J>',
    '<C-w>j',
    { desc = 'Focus on below window' }
)
vim.api.nvim_set_keymap(
    'n',
    '<C-K>',
    '<C-w>k',
    { desc = 'Focus on above window' }
)
vim.api.nvim_set_keymap(
    'n',
    '<C-L>',
    '<C-w>l',
    { desc = 'Focus on right window' }
)
-- }}}

-- Org{{{
vim.api.nvim_set_keymap(
    'n',
    '<leader>oc',
    '<Cmd>lua require("orgmode").action("capture.prompt")<CR>',
    { desc = 'Org [c]reate note' }
)

vim.api.nvim_set_keymap(
    'n',
    '<leader>oa',
    '<Cmd>lua require("orgmode").action("agenda.prompt")<CR>',
    { desc = 'Org [a]genda' }
) -- }}}
