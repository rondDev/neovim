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

local lazy = require("lazy")

lazy.setup({

	-- Install the catppuccin theme
	-- "catppuccin/nvim",

	"nyoom-engineering/oxocarbon.nvim",
	-- rond doesn't know keybindings
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			-- todo
		},
	},

	-- Install treesitter for better syntax highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
		dependencies = {
			-- Additional text objects for treesitter
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
	},

	-- Install nvim-notify for better notifications
	"rcarriga/nvim-notify",

	-- Install LSP
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "LspInfo", "LspInstall", "LspUninstall" },
		dependencies = {
			-- Plugin and UI to automatically install LSPs to stdpath
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

			-- Install null-ls for diagnostics, code actions, and formatting
			"jose-elias-alvarez/null-ls.nvim",

			-- Install neodev for better nvim configuration and plugin authoring via lsp configurations
			"folke/neodev.nvim",

			-- Progress/Status update for LSP
			{ "j-hui/fidget.nvim", tag = "legacy" },
		},
	},

	-- Install Autocomplete dependencies
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
			"onsails/lspkind.nvim",
		},
	},

	-- Install telescope
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},

	-- Install fuzzy finder for telescope
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		cond = vim.fn.executable("make") == 1,
	},

	-- Install nvim-lsp-file-operations for file operations via lsp in the file tree
	{
		"antosha417/nvim-lsp-file-operations",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-neo-tree/neo-tree.nvim",
		},
	},

	-- Install neo-tree for a vscode-like file tree/explorer
	{
		"nvim-neo-tree/neo-tree.nvim",
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
	{ "nvim-lualine/lualine.nvim", event = "VeryLazy" },

	-- Install gitsigns for git decorations/indicators
	"lewis6991/gitsigns.nvim",

	-- Install Comment to enable easy/quick (un)commenting
	"numToStr/Comment.nvim",

	-- Install indent_blankline to style indentation
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
	},

	-- Install nvim-autopairs  and nvim-ts-autotag to auto close brackets & tags
	"windwp/nvim-autopairs",
	"windwp/nvim-ts-autotag",

	-- Install vim-surround for managing parenthese, brackets, quotes, etc
	"tpope/vim-surround",

	-- Install maximizer as a depedency to easily toggle max/min a split buffer
	"szw/vim-maximizer",

	-- Install dressing to create better ui/pop ups for vim.ui.input and vim.ui.select elements
	"stevearc/dressing.nvim",

	-- Install harpoon easy tracking/switching of multiple buffers
	"ThePrimeagen/harpoon",

	-- Install wilder to improve the wildmenu
	"gelguy/wilder.nvim",

	-- Install symbol-outine for a sidebar toggle for the current buffers symbols
	"simrat39/symbols-outline.nvim",

	-- Install context-commentstring to enable jsx commenting is ts/js/tsx/jsx files
	"JoosepAlviste/nvim-ts-context-commentstring",

	-- Install vim-illuminate to hightlight other uses of the word under your cursor
	"RRethy/vim-illuminate",

	-- Install tsc.nvim to enable project-wide type checking and diagnostics
	-- use({ "dmmulroy/tsc.nvim" })
	"dmmulroy/tsc.nvim",

	-- Install vim-kitty-navigator to enable better navigation between neovim and kitty
	-- "knubie/vim-kitty-navigator",
	"dmmulroy/vim-kitty-navigator",

	-- Install nvim-spectre for global find/replace
	{
		"nvim-pack/nvim-spectre",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},

	-- "stevearc/oil.nvim",

	--Install nvim-ufo for better folds
	{ "kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async" },

	"ThePrimeagen/git-worktree.nvim",

	"f-person/git-blame.nvim",

	{
		"max397574/better-escape.nvim",
	},

	{
		"nvim-neorg/neorg",
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
	{
		"VonHeikemen/fine-cmdline.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
	},
	"voldikss/vim-floaterm",
	{
		"Rawnly/gist.nvim",
		cmd = { "GistCreate", "GistCreateFromFile", "GistsList" },
		config = true,
	},
	-- `GistsList` opens the selected gif in a terminal buffer,
	-- nvim-unception uses neovim remote rpc functionality to open the gist in an actual buffer
	-- and prevents neovim buffer inception
	{
		"samjwill/nvim-unception",
		lazy = false,
		init = function()
			vim.g.unception_block_while_host_edits = true
		end,
	},
	{
		"b0o/incline.nvim",
		branch = "main",
		-- event = "BufReadPost",
		opts = {
			-- ignore = { buftypes = function(bufnr, buftype) return false end },
			render = function(props)
				if vim.bo[props.buf].buftype == "terminal" then
					return {
						{ " " .. vim.bo[props.buf].channel .. " ", group = "DevIconTerminal" },
						{ " " .. vim.api.nvim_win_get_number(props.win), group = "Special" },
					}
				end

				local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
				local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
				local modified = vim.api.nvim_get_option_value("modified", { buf = 0 }) and "bold,italic" or "bold"

				local function get_git_diff()
					local icons = { removed = "", changed = "", added = "" }
					icons["changed"] = icons.modified
					local signs = vim.b[props.buf].gitsigns_status_dict
					local labels = {}
					if signs == nil then
						return labels
					end
					for name, icon in pairs(icons) do
						if tonumber(signs[name]) and signs[name] > 0 then
							table.insert(labels, { icon .. signs[name] .. " ", group = "Diff" .. name })
						end
					end
					if #labels > 0 then
						table.insert(labels, { "┊ " })
					end
					return labels
				end
				local function get_diagnostic_label()
					local label = {}
					local icons = { error = "", warn = "", info = "", hint = "" }

					for severity, icon in pairs(icons) do
						local n = #vim.diagnostic.get(
							props.buf,
							{ severity = vim.diagnostic.severity[string.upper(severity)] }
						)
						if n > 0 then
							table.insert(label, { icon .. n .. " ", group = "DiagnosticSign" .. severity })
						end
					end
					if #label > 0 then
						table.insert(label, { "┊ " })
					end
					return label
				end

				local buffer = {
					{ get_diagnostic_label() },
					{ get_git_diff() },
					{ ft_icon .. " ", guifg = ft_color, guibg = "none" },
					{ filename .. " ", gui = modified },
					-- { " " .. vim.api.nvim_win_get_number(props.win), group = "Special" },
				}
				return buffer
			end,
		},
	},
	{
		"folke/twilight.nvim",
	},
	{
		"mfussenegger/nvim-dap",
	},
	-- lazy.nvim
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
	},
	"unblevable/quick-scope",
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"sindrets/diffview.nvim",
			"ibhagwan/fzf-lua",
		},
		config = true,
		init = function()
			vim.cmd([[
      let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
      ]])
		end,
	},
	"ziglang/zig.vim",
	"simrat39/rust-tools.nvim",
	"wakatime/vim-wakatime",
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	},
})
