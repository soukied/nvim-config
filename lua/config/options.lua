local opt = vim.opt

opt.encoding = 'utf-8'
opt.autoindent = true
opt.smartindent = true
opt.softtabstop = 4
opt.termguicolors = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.backup = false
opt.swapfile = false
opt.undofile = true
opt.undodir = os.getenv("HOME") .. "/.nvim/undo"
opt.cursorline = true
opt.relativenumber = true
opt.number = true
opt.splitbelow = true
opt.splitright= true
opt.scrolloff = 5
opt.winborder = 'rounded'

vim.api.nvim_create_autocmd({'User'}, {
	pattern = {'LazyDone'},
	callback = function(ev)
		vim.cmd.colorscheme "tokyonight-night"
		opt.bg='dark'
	end,
	group = vim.api.nvim_create_augroup('set_colorscheme', {clear=true}),
})

