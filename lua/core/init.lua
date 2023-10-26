local opt = vim.opt
local g = vim.g
local config = require("core.utils").load_config()

g.nvchad_theme = config.ui.theme
g.base46_cache = vim.fn.stdpath("data") .. "/base46/"
g.transparency = config.ui.transparency

-- -- vim options from old config

-- Enable relative line numbers
opt.nu = true
opt.rnu = true

-- Set tabs to 2 spaces
opt.tabstop = 2
opt.softtabstop = 2
opt.expandtab = true

-- Enable auto indenting and set it to spaces
opt.smartindent = true
opt.shiftwidth = 2

opt.breakindent = true -- Enable smart indenting (see https://stackoverflow.com/questions/1204149/smart-wrap-in-vim)

-- Enable incremental searching
opt.incsearch = true
opt.hlsearch = true

opt.wrap = false -- Disable text wrap

-- Set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better splitting
opt.splitbelow = true
opt.splitright = true

opt.mouse = "a" -- Enable mouse mode

-- Enable ignorecase + smartcase for better searching
opt.ignorecase = true
opt.smartcase = true

opt.updatetime = 50 -- Decrease updatetime to 200ms

opt.completeopt = { "menuone", "noselect" } -- Set completeopt to have a better completion experience

opt.undofile = true -- Enable persistent undo history

opt.termguicolors = true -- Enable 24-bit color

opt.signcolumn = "yes" -- Enable the sign column to prevent the screen from jumping

opt.clipboard = "unnamed,unnamedplus" -- Enable access to System Clipboard

opt.cursorline = true -- Enable cursor line highlight

-- Set fold settings
-- These options were reccommended by nvim-ufo
-- See: https://github.com/kevinhwang91/nvim-ufo#minimal-configuration
opt.foldcolumn = "0"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

opt.scrolloff = 8 -- Always keep 8 lines above/below cursor unless at start/end of file

-- opt.colorcolumn = "80" -- Place a column line

-- GUI stuff
vim.o.guifont = "JetBrainsMonoNL\\ Nerd\\ Font\\ Mono:h11"

opt.background = "dark"

opt.cmdheight = 1

opt.autoread = true
opt.confirm = true
opt.showmode = false

opt.showtabline = 2

-- disable some default providers
for _, provider in ipairs({ "node", "perl", "python3", "ruby" }) do
	vim.g["loaded_" .. provider .. "_provider"] = 0
end

local autocmd = vim.api.nvim_create_autocmd
local function augroup(name)
	return vim.api.nvim_create_augroup("rond_" .. name, { clear = true })
end

-- stolen from https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua#L8C1-L11C3
autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup("checktime"),
	command = "checktime",
})

-- spell checking in gitcommit, markdown and txt
autocmd({ "FileType" }, {
	group = augroup("edit_text"),
	pattern = { "gitcommit", "markdown", "txt" },
	desc = "Enable spell checking and text wrapping for certain filetypes",
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- format on save
autocmd("BufWritePre", {
	group = augroup("format_on_save"),
	pattern = "*",
	desc = "Run LSP formatting on a file on save",
	callback = function()
		if vim.fn.exists(":Format") > 0 then
			vim.cmd.Format()
		end
	end,
})

-- vertical help
autocmd("FileType", {
	group = augroup("vertical_help"),
	pattern = "help",
	callback = function()
		vim.bo.bufhidden = "unload"
		vim.cmd.wincmd("L")
		vim.cmd.wincmd("=")
	end,
})

autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	pattern = "*",
	desc = "Highlight selection on yank",
	callback = function()
		vim.highlight.on_yank({ timeout = 200, visual = true })
	end,
})

-- close some filetypes with <q> -- taken from https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua#L49C1-L72C3
autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"PlenaryTestPopup",
		"help",
		"lspinfo",
		"man",
		"notify",
		"qf",
		"query",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"neotest-output",
		"checkhealth",
		"neotest-summary",
		"neotest-output-panel",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- create folder if not exist -- taken from https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua#L85C1-L94C3
autocmd({ "BufWritePre" }, {
	group = augroup("auto_create_dir"),
	callback = function(event)
		if event.match:match("^%w%w+://") then
			return
		end
		local file = vim.loop.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

-- Autocmd to recompile dwmblocks
vim.cmd(
	"autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid dwmblocks & }"
)

autocmd({ "FileReadPost" }, {
	group = augroup("set_unix_ff"),
	callback = function()
		vim.cmd("set ff=unix")
	end,
})
