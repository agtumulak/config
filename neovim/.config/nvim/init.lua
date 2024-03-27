-- https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
vim.fn.system({
    "git", "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
{
	{"RRethy/base16-nvim"},
	{"neoclide/coc.nvim", branch="release"},
})

-- https://github.com/RRethy/base16-nvim?tab=readme-ov-file#nvim-base16
vim.opt.termguicolors = true
vim.cmd.colorscheme("base16-gruvbox-dark-hard")

-- https://github.com/neoclide/coc.nvim?tab=readme-ov-file#example-lua-configuration
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
vim.keymap.set("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
vim.keymap.set("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
vim.keymap.set("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)


-- Python 3 provider
vim.g.python3_host_prog = "/opt/homebrew/Caskroom/miniconda/base/envs/neovim/bin/python"

-- misc options
vim.opt.number = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
