-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("lazy").setup({
	{"nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate", opts = function()
		require'nvim-treesitter.configs'.setup {
			highlight = {
				enable = true, additional_vim_regex_highlighting = false
			}
		}
	end
	},
	{'mason-org/mason.nvim', tag = 'stable', opts={}},
	{'folke/tokyonight.nvim', priority=1000},
	{'folke/trouble.nvim', tag = 'stable', opts={}, cmd="Trouble"},
	{'rose-pine/neovim', priority=1000, name='rose-pine'},
	{ "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, opts = {}},
	{ "folke/lazydev.nvim", ft = "lua", opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
})
