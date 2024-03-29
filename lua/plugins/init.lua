local plugins = {

	--   ╭───────────────────────────────────────────────────────────────────────╮
	--   │ ------------------------------ coding ------------------------------- │
	--   │      Section for general improvements for code flow                   │
	--   │ --------------------------------------------------------------------- │
	--   ╰───────────────────────────────────────────────────────────────────────╯
	--#region coding

	-- autocomplete

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

	-- manage parentheses, brackets, quotes etc.
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

	{
		"folke/flash.nvim",
		event = "BufReadPost",
		opts = {
			modes = {
				char = {
					jump_labels = true,
				},
			},
		},
		keys = {
			-- {
			-- 	"f",
			-- 	mode = { "n", "x", "o" },
			-- 	function()
			-- 		require("flash").jump()
			-- 	end,
			-- 	desc = "Flash",
			-- },
			-- { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			-- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
			-- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
		},
	},

	--#endregion

	--   ╭───────────────────────────────────────────────────────────────────────╮
	--   │ ------------------------------ ui ----------------------------------- │
	--   │      Section for general improvements in the ui                       │
	--   │ --------------------------------------------------------------------- │
	--   ╰───────────────────────────────────────────────────────────────────────╯
	--#region UI

	-- color scheme
	{
		"rondDev/oxocarbon.nvim",
		priority = 1000,
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
	-- TODO:
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = { "BufReadPost" },
		config = function()
			require("todo-comments").setup()
		end,
	},

	-- pretty diagnostics
	{
		"folke/trouble.nvim",
		event = { "BufReadPost" },
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

	-- show symbols in a nice list

	-- pretty dashboard

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
			require("gitsigns").setup({
				attach_to_untracked = true,
			})
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

	-- statusline

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

	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		-- event = { "BufReadPre" },
		keys = { "<leader>wd" },
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		opts = {
			-- configurations go here
		},
	},

	{
		"sidebar-nvim/sidebar.nvim",
		event = { "VeryLazy" },
		config = function()
			require("sidebar-nvim").setup({
				disable_default_keybindings = 1,
			})
		end,
	},

	{ "LudoPinelli/comment-box.nvim" },

	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		event = { "BufEnter" },
		config = function()
			-- Turn on LSP, formatting, and linting status and progress information
			require("fidget").setup({
				text = {
					spinner = "dots_negative",
				},
			})
		end,
	},

	--#endregion

	-- ╭─────────────────────────────────────────────────────────╮
	-- │                           LSP                           │
	-- ╰─────────────────────────────────────────────────────────╯

	--#region LSP

	--#endregion

	-- ╭─────────────────────────────────────────────────────────╮
	-- │                       Treesitter                        │
	-- ╰─────────────────────────────────────────────────────────╯

	--#region treesitter

	{
		"LhKipp/nvim-nu",
		config = function()
			require("nu").setup()
		end,
	},

	--#endregion

	-- ╭─────────────────────────────────────────────────────────╮
	-- │                          other                          │
	-- ╰─────────────────────────────────────────────────────────╯

	--#region other

	-- make command line easy and pretty

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
		config = function()
			require("which-key").register({
				b = {
					name = "Buffer",
				},
				c = {
					name = "Code",
				},
				g = {
					name = "Git",
				},
				n = {
					name = "Noh",
				},
				o = {
					name = "Open",
				},
				r = {
					name = "Rename/Rotate",
				},
				s = {
					name = "Search",
				},
				t = {
					name = "Tab/Trouble/Toggle",
				},
				u = {
					name = "Toggle conceal",
				},
				w = {
					name = "Window/Winbar",
				},
				["["] = {
					name = "Goto previous",
				},
				["]"] = {
					name = "Goto next",
				},
			}, { prefix = "<leader>" })
			-- code
		end,
	},

	-- TODO: remove, prioritize markdown notes instead
	{
		"nvim-orgmode/orgmode",
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter", lazy = true },
		},
		event = "VeryLazy",
		config = function()
			-- Load treesitter grammar for org
			require("orgmode").setup_ts_grammar()

			-- Setup treesitter
			require("nvim-treesitter.configs").setup({
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = { "org" },
				},
				ensure_installed = { "org" },
			})

			-- Setup orgmode
			require("orgmode").setup({
				org_agenda_files = "~/orgfiles/**/*",
				org_default_notes_file = "~/orgfiles/refile.org",
			})
		end,
	},

	-- essentially just helper functions that are annyoing to write
	"nvim-lua/plenary.nvim",

	-- fennel development
	{
		"rktjmp/hotpot.nvim",
		event = "VeryLazy",
	},

	{
		"alexghergh/nvim-tmux-navigation",
		init = function()
			require("nvim-tmux-navigation")
		end,
	},

	{
		"xiyaowong/telescope-emoji.nvim",
		cmd = { "Telescope" },
		config = function()
			require("telescope").load_extension("emoji")
		end,
	},

	{
		"toppair/peek.nvim",
		event = { "VeryLazy" },
		build = "deno task --quiet build:fast",
		config = function()
			require("peek").setup()
			-- refer to `configuration to change defaults`
			vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
			vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
		end,
	},

	--#endregion
	--

	-- ╭─────────────────────────────────────────────────────────╮
	-- │                          langs                          │
	-- ╰─────────────────────────────────────────────────────────╯

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
		version = "^3", -- Recommended
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
	--
	-- --#endregion
	{ import = "plugins.configs" },
}
-- local config = require("plugins.configs.lazy")

local config = {

	defaults = { lazy = false },
	-- install = { colorscheme = { "nvchad" } },

	ui = {
		icons = {
			ft = "",
			lazy = "󰂠 ",
			loaded = "",
			not_loaded = "",
		},
	},

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
}

require("lazy").setup(plugins, config)
