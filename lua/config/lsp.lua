local capability = vim.lsp.protocol.make_client_capabilities()
capability.textDocument.completion.completionItem.snippetSupport = false

local lsp_configs = {
	lua_ls = {
		capabilities = capability,
		cmd = { "lua-language-server" },
		filetypes = { "lua" },
		root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git" }
	},
	clangd = require('config.lsp.clangd'),
	ts_ls = require('config.lsp.ts_ls'),
}

for k, v in pairs(lsp_configs) do
	if v then
		vim.lsp.config(k, v)
	end
	vim.lsp.enable(k)
end

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		vim.opt.completeopt = {'menuone','noselect','popup'}
		if client == nil then return end
		if client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, ev.buf, {autotrigger = true})
			vim.keymap.set('i', '<C-Space>', function()
				vim.lsp.completion.get()
			end)
		end
	end
})

vim.keymap.set('i', '<Tab>', function()
	return vim.fn.pumvisible() == 1 and '<C-n>' or '<Tab>'
end, { silent = true, expr = true})

vim.keymap.set('i', '<S-Tab>', function()
	return vim.fn.pumvisible() == 1 and '<C-p>' or '<S-Tab>'
end, { silent = true, expr = true})

vim.keymap.set('i', '<CR>', function()
	return vim.fn.pumvisible() == 1 and '<C-y>' or '<CR>'
end, { silent = true, expr = true})

vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = ' ',
			[vim.diagnostic.severity.WARN] = ' ',
			[vim.diagnostic.severity.INFO] = ' ',
			[vim.diagnostic.severity.HINT] = ' ',
		}
	}
})
