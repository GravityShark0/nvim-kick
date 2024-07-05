-- Setsup lazy.nvim{{{
-- Initialize lazy.nvim

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        '--branch=stable',
        lazyrepo,
        lazypath,
    })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
            { out, 'WarningMsg' },
            { '\nPress any key to exit...' },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Setup plugins
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

require('lazy').setup({
    spec = {
        { import = 'pluggers' },
    },
    defaults = { lazy = true, version = false },
    change_detection = { notify = false },
    rocks = { enabled = false },
    checker = {
        enabled = true,
        notify = true, -- get a notification when new updates are found
    },

    performance = {
        rtp = {
            disabled_plugins = {
                'editorconfig',
                'gzip',
                'rplugin',
                'fzf',
                'spellfile',
                'tarPlugin',
                'tohtml',
                'tutor',
                'zipPlugin',
                'osc52',
                -- 'man',
                -- "matchit",
                -- "matchparen",
                -- 'netrwPlugin',
                -- "shada",
            },
        },
    },
}) -- }}}
-- Sets the keymaps and settings
require('keymaps')
require('settings')
require('autocmd')
-- vim:foldmethod=marker:
