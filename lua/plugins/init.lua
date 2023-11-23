local nvim_config = require("core.config")

local plugins = {

	-------------------------------- coding -------------------------------
	--          Section for general improvements for code flow           --
	-----------------------------------------------------------------------
	--#region coding

	-- autocomplete
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter" },
		dependencies = {
			{
				"windwp/nvim-autopairs",
				config = function()
					require("nvim-autopairs").setup()
					local cmp_autopairs = require("nvim-autopairs.completion.cmp")
					require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
				end,
			},
			{
				"L3MON4D3/LuaSnip",
				dependencies = "rafamadriz/friendly-snippets",
				opts = { history = true, updateevents = "TextChanged,TextChangedI" },
				config = function(_, opts)
					require("plugins.configs.luasnip").setup(opts)
				end,
			},
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
			"onsails/lspkind.nvim",
			"windwp/nvim-ts-autotag",
		},
		opts = function()
			return require("plugins.configs.cmp")
		end,
		config = function(_, opts)
			require("cmp").setup(opts)
		end,
	},

	-- plugin for easy commenting -- TODO: test and compare to mini.comment
	-- {
	-- 	"numToStr/Comment.nvim",
	-- 	event = { "InsertEnter" },
	-- 	dependencies = {
	-- 		-- Install context-commentstring to enable jsx commenting is ts/js/tsx/jsx files
	-- 		"JoosepAlviste/nvim-ts-context-commentstring",
	-- 	},
	-- 	config = function()
	-- 		require("Comment").setup({
	-- 			pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
	-- 		})
	-- 	end,
	-- },

	-- easy commenting
	{
		"echasnovski/mini.comment",
		version = false,
		config = function()
			require("mini.comment").setup()
		end,
	},

	-- escape with jj and jk
	{
		"max397574/better-escape.nvim",
		event = { "InsertEnter" },
		config = function()
			require("better_escape").setup({
				mapping = { "jk", "jj" }, -- a table with mappings to use
				timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
				clear_empty_lines = false, -- clear line after escaping if there is only whitespace
				keys = "<Esc>", -- keys used for escaping, if it is a function will use the result everytime
			})
		end,
	},

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

	-- NOTE: this might be swapped out with tpope's vim-surround, that remains to be seen
	--
	-- manage parentheses, brackets, quotes etc.
	-- {
	-- 	"echasnovski/mini.surround",
	-- 	version = false,
	-- 	config = function()
	-- 		require("mini.surround").setup()
	-- 	end,
	-- },

	--
	{
		"tpope/vim-surround",
	},

	-- Search and replace
	{
		"nvim-pack/nvim-spectre",
		keys = "S",
		cmd = "Spectre",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},

	-- buffer-like file manager
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

	-- almost like magit inside neovim
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

	--#endregion

	-------------------------------- ui -----------------------------------
	--          Section for general improvements in the ui               --
	-----------------------------------------------------------------------
	--#region UI

	-- color scheme
	{
		"rondDev/oxocarbon.nvim",
		config = function()
			vim.cmd.colorscheme("oxocarbon")
		end,
	},

	-- improves the default vim.ui interfaces
	{
		"stevearc/dressing.nvim",
		config = function()
			require("dressing").setup()
		end,
	},

	-- nice looking todos
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	-- pretty diagnostics
	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle" },
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	-- nice icons everywhere
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup()
		end,
	},

	-- nice search ui
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				cmd = "Telescope",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
				cond = vim.fn.executable("cmake") == 1,
			},
		},
		opts = function()
			return require("plugins.configs.telescope")
		end,
		config = function(_, opts)
			require("telescope").setup(opts)
		end,
	},

	-- show symbols in a nice list
	{
		"simrat39/symbols-outline.nvim",
		cmd = { "SymbolsOutline", "SymbolsOutlineOpen", "SymbolsOutlineClose" },
		opts = function()
			return require("plugins.configs.symbols_outline")
		end,
		config = function(_, opts)
			require("symbols-outline").setup(opts)
		end,
	},

	-- pretty dashboard
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		opts = function()
			return require("plugins.configs.dashboard")
		end,
	},

	-- ultra folds in neovim
	{
		"kevinhwang91/nvim-ufo",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		dependencies = "kevinhwang91/promise-async",
		config = function()
			--- @diagnostic disable: missing-fields
			--- @diagnostic disable: unused-local
			require("ufo").setup({
				provider_selector = function(_bufnr, _filetype, _buftype)
					return { "treesitter", "indent" }
				end,
			})
		end,
	},

	-- hex color thing
	{
		"norcalli/nvim-colorizer.lua",
		event = { "InsertEnter" },
		config = function()
			require("colorizer").setup()
		end,
	},

	-- tailwindcss color thing
	{
		"themaxmarchuk/tailwindcss-colors.nvim",
		event = { "InsertEnter" },
		config = function()
			require("tailwindcss-colors").setup()
		end,
	},

	-- highlight all occurances of the word under your cursor similar to vim-illuminate
	{
		"echasnovski/mini.cursorword",
		version = false,
		config = function()
			require("mini.cursorword").setup()
		end,
	},

	-- visualize indents (with pretty animations)
	{
		"echasnovski/mini.indentscope",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		opts = {
			-- symbol = "▏",
			symbol = "│",
			options = { try_as_border = true },
		},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
					"oil",
				},
				callback = function()
					---@diagnostic disable-next-line: inject-field
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	},

	-- git integration for buffers
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		config = function()
			require("gitsigns").setup()
		end,
	},

	-- maximize current selected buffer
	{
		"szw/vim-maximizer",
		cmd = { "MaximizerToggle" },
	},

	-- indentation guides for neovim
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			scope = {
				enabled = true,
				show_start = true,
				show_end = true,
			},
			exclude = {
				filetypes = {
					"help",
					"dashboard",
					"lazy",
				},
			},
		},
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		-- config = function()
		-- 	require("ibl").setup({})
		-- end,
	},

	-- notification manager
	{
		"rcarriga/nvim-notify",
		event = { "VeryLazy" },
		config = function()
			require("plugins.configs.notify").setup()
		end,
	},

	-- statusline
	{
		"nvim-lualine/lualine.nvim",
		event = { "VeryLazy", "BufReadPost", "BufNewFile", "BufWritePre" },
		cond = function()
			if nvim_config.line == "lualine" then
				return true
			end
		end,
		dependencies = {
			-- "ThePrimeagen/harpoon",
			{
				"f-person/git-blame.nvim",
				event = { "BufReadPost", "BufNewFile", "BufWritePre" },
			},
		},
		config = function()
			require("plugins.configs.lualine").setup()
		end,
	},

	{
		"tamton-aquib/staline.nvim",
		event = { "VeryLazy", "BufReadPost", "BufNewFile", "BufWritePre" },
		cond = function()
			if nvim_config.line == "staline" then
				return true
			end
		end,
		config = function()
			require("plugins.configs.staline").setup()
		end,
	},

	-- tabs :)
	{
		"romgrk/barbar.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
			"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
		},
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		opts = {
			animation = true,
			clickable = true,
			icons = {
				buffer_index = true,
				button = "",
				preset = "slanted",
				diagnostics = {
					[vim.diagnostic.severity.ERROR] = { enabled = true, icon = " " },
					[vim.diagnostic.severity.WARN] = { enabled = true, icon = " " },
					[vim.diagnostic.severity.INFO] = { enabled = true, icon = " " },
					[vim.diagnostic.severity.HINT] = { enabled = true, icon = "󱧢 " },
				},
				gitsigns = {
					added = { enabled = true, icon = " " },
					changed = { enabled = true, icon = " " },
					deleted = { enabled = true, icon = " " },
				},
			},
			sidebar_filetypes = {
				["neo-tree"] = { event = "BufWipeout" },
			},
			-- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
			-- animation = true,
			-- insert_at_start = true,
			-- …etc.
		},
	},

	--#endregion

	------------------------------- LSP -----------------------------------
	--#region LSP

	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost" },
		cmd = { "LspInfo", "LspInstall", "LspUninstall", "Mason" },
		dependencies = {
			-- Plugin and UI to automatically install LSPs to stdpath
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

			-- Install none-ls for diagnostics, code actions, and formatting
			"nvimtools/none-ls.nvim",

			-- Install neodev for better nvim configuration and plugin authoring via lsp configurations
			"folke/neodev.nvim",

			-- Progress/Status update for LSP
			{
				"j-hui/fidget.nvim",
				tag = "legacy",

				config = function()
					-- Turn on LSP, formatting, and linting status and progress information
					require("fidget").setup({
						text = {
							spinner = "dots_negative",
						},
					})
				end,
			},
		},
		config = function()
			require("plugins.configs.lsp").setup()
		end,
	},

	--#endregion

	--------------------------- Treesitter --------------------------------
	--#region treesitter

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
		keys = {
			"<c-space>",
			"<c-s>",
			"<c-backspace>",
		},
		dependencies = {
			-- Additional text objects for treesitter
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				event = { "BufReadPost", "BufNewFile", "BufWritePre" },
			},
		},
		opts = function()
			return require("plugins.configs.treesitter")
		end,
		config = function()
			---@diagnostic disable: missing-fields
			require("nvim-treesitter.configs").setup({})
		end,
	},

	--#endregion

	------------------------------ other ----------------------------------
	--#region other

	-- make command line easy and pretty
	{
		"gelguy/wilder.nvim",
		keys = {
			":",
			"/",
			"?",
		},
		config = function()
			require("plugins.configs.wilder").setup()
		end,
	},

	-- session management
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" } },
    -- stylua: ignore
    keys = {
      { "<leader>sr", function() require("persistence").load() end,                desc = "Restore Session" },
      { "<leader>sl", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>su", function() require("persistence").stop() end,                desc = "Don't Save Current Session" },
    },
	},

	-- Prevent neovim inside neovim
	{
		"samjwill/nvim-unception",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		lazy = false,
		init = function()
			vim.g.unception_block_while_host_edits = true
		end,
	},

	-- create and manage gists
	{
		"Rawnly/gist.nvim",
		cmd = { "GistCreate", "GistCreateFromFile", "GistsList" },
		config = true,
	},

	-- time tracker for developers
	{
		"wakatime/vim-wakatime",
		event = "BufReadPost",
	},

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			-- Set delay for whichkey to popup to 300ms
			vim.o.timeoutlen = 300
		end,
		opts = {
			-- todo
			defaults = {},
		},
	},

	-- essentially just helper functions that are annyoing to write
	"nvim-lua/plenary.nvim",

	-- fennel development
	"rktjmp/hotpot.nvim",

	--#endregion
	--

	------------------------------ langs ----------------------------------
	--#region langs

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

	-- typescript / tsreact
	{
		"dmmulroy/tsc.nvim",
		ft = { "typescript", "typescriptreact" },
		config = function()
			require("tsc").setup()
		end,
	},

	-- haskell
	{
		"mrcjkb/haskell-tools.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		version = "^2", -- Recommended
		ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
	},

	-- go
	{
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("go").setup()
		end,
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
	},

	--#endregion
}
local config = require("plugins.configs.lazy")

require("lazy").setup(plugins, config.lazy)
