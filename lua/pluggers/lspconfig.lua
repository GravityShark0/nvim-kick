-- -- [[ Configure LSP ]]{{{
-- --  This function gets run when an LSP connects to a particular buffer.
-- local on_attach = function(_, bufnr)
-- 	-- NOTE: Remember that lua is a real programming language, and as such it is possible
-- 	-- to define small helper and utility functions so you don't have to repeat yourself
-- 	-- many times.
-- 	--
-- 	-- In this case, we create a function that lets us more easily define mappings specific
-- 	-- for LSP related items. It sets the mode, buffer and description for us each time.
-- 	local nmap = function(keys, func, desc)
-- 		if desc then
-- 			desc = 'LSP: ' .. desc
-- 		end
--
-- 		vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
-- 	end
--
-- 	nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
-- 	nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
--
-- 	nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
-- 	nmap('gr', '<cmd>Telescope lsp_references<CR>', '[G]oto [R]eferences')
-- 	nmap(
-- 		'gI',
-- 		'<cmd>Telescope lsp_implementations<CR>',
-- 		'[G]oto [I]mplementation'
-- 	)
-- 	nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
-- 	nmap(
-- 		'<leader>ds',
-- 		'<cmd>Telescope lsp_document_symbols<CR>',
-- 		'[D]ocument [S]ymbols'
-- 	)
-- 	nmap(
-- 		'<leader>ws',
-- 		'<cmd>Telescope lsp_dynamic_workspace_symbols<CR>',
-- 		'[W]orkspace [S]ymbols'
-- 	)
--
-- 	-- See `:help K` for why this keymap
-- 	nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
-- 	nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
--
-- 	-- Lesser used LSP functionality
-- 	nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
-- 	nmap(
-- 		'<leader>wa',
-- 		vim.lsp.buf.add_workspace_folder,
-- 		'[W]orkspace [A]dd Folder'
-- 	)
-- 	nmap(
-- 		'<leader>wr',
-- 		vim.lsp.buf.remove_workspace_folder,
-- 		'[W]orkspace [R]emove Folder'
-- 	)
-- 	nmap('<leader>wl', function()
-- 		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
-- 	end, '[W]orkspace [L]ist Folders')
--
-- 	-- Create a command `:Format` local to the LSP buffer
-- 	vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
-- 		vim.lsp.buf.format()
-- 	end, { desc = 'Format current buffer with LSP' })
-- end
--
-- -- document existing key chains
-- require('which-key').register({
-- 	['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
-- 	['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
-- 	['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
-- 	['<leader>h'] = { name = 'More git', _ = 'which_key_ignore' },
-- 	['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
-- 	['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
-- 	['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
-- })
--
-- -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
--
-- Ensure the servers above are installed
local mason_lspconfig = require("mason-lspconfig")

local servers = require("ensure").mason

mason_lspconfig.setup({ servers })

mason_lspconfig.setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
			filetypes = (servers[server_name] or {}).filetypes,
		})
	end,
}) -- }}}
