vim.cmd('set clipboard=unnamedplus')
vim.g.mapleader = " "

-- Must be loaded quickly
vim.g.vimwiki_folding = 'expr'
vim.g.vimwiki_ext2syntax = {['.Rmd']= 'markdown', ['.rmd']= 'markdown',['.md']= 'markdown', ['.markdown']= 'markdown', ['.mdown']= 'markdown'}
vim.g.vimwiki_list = {{path = '~/Nextcloud/Notes/', path_html = '~/Nextcloud/Notes/html/', syntax = 'markdown', ext = '.md'}}

--------------------------------------------------------------------------------
-----Lazy-----------------------------------------------------------------------
--------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

plugins = {
	{
		'nvim-telescope/telescope.nvim', branch = '0.1.x',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{ 'rose-pine/neovim', name = 'rose-pine' },
	{{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"}},
	'theprimeagen/harpoon',
	'mbbill/undotree',
	'tpope/vim-fugitive',

	-- LSP Setup
	'neovim/nvim-lspconfig',
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-buffer',
	'hrsh7th/cmp-path',
	'hrsh7th/cmp-cmdline',
	'hrsh7th/cmp-vsnip',
	'hrsh7th/vim-vsnip',
	'hrsh7th/nvim-cmp',

	"tpope/vim-commentary",
	'github/copilot.vim',
	'junegunn/goyo.vim',
	'tpope/vim-speeddating',
	'tpope/vim-surround',
	'vimwiki/vimwiki',
	'farmergreg/vim-lastplace',
	'ap/vim-css-color',
	'nvim-orgmode/orgmode',
	'jbyuki/instant.nvim',

	{ 'mlochbaum/BQN', dir = '/home/sandman/Developer/BQN/editors/vim' },
	'https://git.sr.ht/~detegr/nvim-bqn',
}

require("lazy").setup(plugins, opts)

--------------------------------------------------------------------------------
-----Sets-----------------------------------------------------------------------
--------------------------------------------------------------------------------
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.go = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.laststatus = 0
vim.opt.mouse = 'a'
vim.opt.title = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.cmd.colorscheme('rose-pine')
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
-- vim.opt.colorcolumn = "80"
vim.g.instant_username = "Adrian"

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

local augroup = vim.api.nvim_create_augroup
local ThePrimeagenGroup = augroup('ThePrimeagen', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

autocmd('TextYankPost', {
	group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({"BufWritePre"}, {
    group = ThePrimeagenGroup,
    pattern = "*",
    command = "%s/\\s\\+$//e",
})


vim.cmd([[
autocmd BufNew,BufNewFile,BufRead *.rkt* setlocal ft=racket

augroup skeletons
au!
autocmd BufNewFile *.* silent! execute '0r ~/.config/nvim/templates/skeleton.'.expand("<afile>:e")
augroup END

" define line highlight color
highlight LineHighlight ctermbg=black guibg=black
" highlight the current line
nnoremap <silent> <Leader>l :call matchadd('LineHighlight', '\%'.line('.').'l')<CR>
" clear all the highlighted lines
nnoremap <silent> <Leader>L :call clearmatches()<CR>

autocmd BufRead,BufNewFile Xresources,Xdefaults,xresources,xdefaults set filetype=xdefaults
autocmd BufWritePost Xresources,Xdefaults,xresources,xdefaults !xrdb %
]])

--------------------------------------------------------------------------------
-----Keymaps--------------------------------------------------------------------
--------------------------------------------------------------------------------
vim.keymap.set("n", "S", ":%s//g<Left><Left>")
-- vim.keymap.set("x", "<leader>P", "\"+p")

-- LuaSnip binding
vim.cmd("imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'")

vim.keymap.set("", "<C-h>", "<C-w>h")
vim.keymap.set("", "<C-j>", "<C-w>j")
vim.keymap.set("", "<C-k>", "<C-w>k")
vim.keymap.set("", "<C-l>", "<C-w>l")

vim.keymap.set("", "<leader>c", ":w! | !compiler \"<c-r>%\"<CR>")
vim.keymap.set("", "<leader>p", ":!opout <c-r>%<CR><CR>")

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", "\"_dP")

-- next greatest remap ever : asbjornHaland
-- vim.keymap.set("n", "<leader>y", "\"+y")
-- vim.keymap.set("v", "<leader>y", "\"+y")
-- vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format()
end)

-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
