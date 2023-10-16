-- Lazy install bootstrap snippet
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

-- Set leader key so lazy mappings are correct
vim.g.mapleader = " "

require("lazy").setup({
	defaults = {
		lazy = true,
	},
	install = { colorscheme = { "oxocarbon" } },
	checker = { enabled = true },
	performance = {
		rtp = {
			disabled_plugins = {
				"2html_plugin",
				"tohtml",
				"getscript",
				"getscriptPlugin",
				"gzip",
				"logipat",
				"netrw",
				"netrwPlugin",
				"netrwSettings",
				"netrwFileHandlers",
				"matchit",
				"tar",
				"tarPlugin",
				"rrhelper",
				"spellfile_plugin",
				"vimball",
				"vimballPlugin",
				"zip",
				"zipPlugin",
				"tutor",
				"rplugin",
				"syntax",
				"synmenu",
				"optwin",
				"compiler",
				"bugreport",
				"ftplugin",
			},
		},
	},
	{
		"nyoom-engineering/oxocarbon.nvim",
		config = function()
			vim.cmd.colorscheme("oxocarbon")
		end,
	},

	-- Showcase what keys do what
	-- Install treesitter for better syntax highlighting
	-- Moved to /plugins/treesitter.lua

	-- Install nvim-notify for better notifications
	-- Moved to /plugins/nvim_notify.lua

	-- Install LSP
	-- Moved to /plugins/lsp.lua

	-- Install Autocomplete dependencies
	-- Install nvim-autopairs  and nvim-ts-autotag to auto close brackets & tags
	-- Moved to /plugins/autopairs_and_nvim_cmp.lua

	-- Install telescope
	-- Install fuzzy finder for telescope
	-- Moved to /plugins/telescope.lua

	-- Install nvim-lsp-file-operations for file operations via lsp in the file tree
	{
		"antosha417/nvim-lsp-file-operations",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-neo-tree/neo-tree.nvim",
		},
	},

	-- Install neo-tree for a vscode-like file tree/explorer
	{
		"nvim-neo-tree/neo-tree.nvim",
		cmd = "Neotree",
		branch = "v3.x",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			{
				"s1n7ax/nvim-window-picker",
				version = "2.*",
			},
		},
	},

	-- Install lualine for a better status line
	-- Install harpoon easy tracking/switching of multiple buffers
	-- Install git-blame to see who to curse out in the slack channel
	-- Moved to /plugins/lualine.lua

	-- Install gitsigns for git decorations/indicators
	-- Moved to /plugins/gitsigns.lua

	-- Install Comment to enable easy/quick (un)commenting
	-- Install context-commentstring to enable jsx commenting is ts/js/tsx/jsx files
	-- Moved to /plugins/comment.lua

	-- Install indent_blankline to style indentation
	-- Moved to /plugins/indent_blankline.lua

	-- Install vim-surround for managing parenthese, brackets, quotes, etc
	{
		"tpope/vim-surround",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
	},

	-- Install maximizer as a depedency to easily toggle max/min a split buffer
	{
		"szw/vim-maximizer",
		cmd = { "MaximizerToggle" },
	},

	-- Install dressing to create better ui/pop ups for vim.ui.input and vim.ui.select elements
	-- Moved to /plugins/dressing.lua

	-- Install wilder to improve the wildmenu
	-- TODO: make this actually pretty
	-- Moved to /plugins/wilder.lua

	-- Install symbol-outine for a sidebar toggle for the current buffers symbols
	-- Moved to /plugins/symbols_outline.lua

	-- Install vim-illuminate to hightlight other uses of the word under your cursor
	-- Moved to /plugins/illuminate.lua

	-- Install tsc.nvim to enable project-wide type checking and diagnostics
	-- Moved to /plugins/tsc.lua

	-- Install vim-kitty-navigator to enable better navigation between neovim and kitty
	-- "knubie/vim-kitty-navigator",
	-- Disabled due to not using kitty
	-- "dmmulroy/vim-kitty-navigator",

	-- Install nvim-spectre for global find/replace
	{
		"nvim-pack/nvim-spectre",
		keys = "S",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},

	{
		"stevearc/oil.nvim",
		config = function()
			require("oil").setup({
				keymaps = {
					["g?"] = "actions.show_help",
					["<CR>"] = "actions.select",
					["<C-s>"] = "actions.select_vsplit",
					-- ["<C-h>"] = "actions.select_split", -- this is used to navigate left
					["<C-t>"] = "actions.select_tab",
					["<C-p>"] = "actions.preview",
					["<C-c>"] = "actions.close",
					["<C-l>"] = "actions.refresh",
					["-"] = "actions.parent",
					["_"] = "actions.open_cwd",
					["`"] = "actions.cd",
					["~"] = "actions.tcd",
					["gs"] = "actions.change_sort",
					["gx"] = "actions.open_external",
					["g."] = "actions.toggle_hidden",
				},
				use_default_keymaps = false,
			})
		end,
	},

	-- Install nvim-ufo for better folds
	-- Moved to /plugins/ufo.loa

	-- Worktrees in neovim
	{
		"ThePrimeagen/git-worktree.nvim",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
	},

	-- Install better_escape to exit insert with "jj"
	-- Moved to /plugins/better_escape.lua

	-- Plugin to take better notes
	{
		"nvim-neorg/neorg",
		cmd = { "Neorg" },
		build = ":Neorg sync-parsers",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {},
					["core.concealer"] = {},
					["core.dirman"] = {
						config = {
							workspaces = {
								todo = "~/norg/todo",
								notes = "~/norg/notes",
								projects = "~/norg/projects",
								scratch = "~/norg/scratch",
							},
							default_workspace = "notes",
						},
					},
				},
			})

			vim.wo.foldlevel = 99
			vim.wo.conceallevel = 2
		end,
	},

	-- Plugin for floating term (good for things like `npm run dev`)
	-- Will most likely look into replacing with FTerm https://github.com/numToStr/FTerm.nvim
	{
		"voldikss/vim-floaterm",
		cmd = {
			"FloatermToggle",
			"FloatermNew",
			"FloatermPrev",
			"FloatermNext",
			"FloatermFirst",
			"FloatermLast",
			"FloatermUpdate",
			"FloatermShow",
			"FloatermHide",
			"FloatermKill",
			"FloatermSend",
		},
	},

	-- Plugin for creating and viewing gists
	{
		"Rawnly/gist.nvim",
		cmd = { "GistCreate", "GistCreateFromFile", "GistsList" },
		config = true,
	},
	-- `GistsList` opens the selected gif in a terminal buffer,
	-- nvim-unception uses neovim remote rpc functionality to open the gist in an actual buffer
	-- and prevents neovim buffer inception

	-- Prevent neovim inside neovim
	{
		"samjwill/nvim-unception",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		lazy = false,
		init = function()
			vim.g.unception_block_while_host_edits = true
		end,
	},

	-- Install incline to have floating filename
	-- Moved to /plugins/incline.lua

	-- Focus on what's currently in focus
	{
		"folke/twilight.nvim",
		cmd = { "Twilight" },
	},

	-- Debug adapter protocol, still TODO setting this up properly
	{
		"mfussenegger/nvim-dap",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
	},

	-- Makes using the f key trivial
	{
		"unblevable/quick-scope",
		keys = { "f", "F", "t", "T" },
		init = function()
			vim.cmd([[
      let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
      ]])
		end,
	},

	-- Git in neovim!
	{
		"NeogitOrg/neogit",
		cmd = { "Neogit" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"sindrets/diffview.nvim",
			"ibhagwan/fzf-lua",
		},
		config = true,
	},

	-- Zig.
	{
		"ziglang/zig.vim",
		ft = "zig",
	},

	-- Rust
	{
		"simrat39/rust-tools.nvim",
		ft = "rust",
	},

	-- Track what you do in neovim :p
	{
		"wakatime/vim-wakatime",
		event = "BufReadPost",
	},

	-- Make LSP errors show under lines (better for smaller windows, but might be less readable)
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
	},

	-- Install barbar for nice looking tab-bar
	-- Moved to /plugins/barbar.lua
	"kdheepak/tabline.nvim",

	{ import = "plugins" },
})
