local ft = require('guard.filetype')

-- Assuming you have guard-collection
ft('css', 'html', 'json', 'javascript', 'markdown', 'typescript', 'yaml'):fmt(
    'prettier'
)

ft('python'):fmt({
    cmd = 'blue',
    args = { '--quiet', '-' },
    stdin = true,
})

ft('lua'):fmt('stylua')

ft('c', 'cpp'):fmt('clang-format')
ft('gdscript'):fmt({
    cmd = 'gdformat',
    args = { '-l 78', '-' },
    stdin = true,
})

-- Call setup() LAST!
require('guard').setup({
    -- the only options for the setup function
    fmt_on_save = true,
    -- Use lsp if no formatter was defined for this filetype
    lsp_as_default_formatter = false,
})
