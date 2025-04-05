return {
	-- manage parentheses, brackets, quotes etc.
	{
		"tpope/vim-surround",
	},

	-- hex color thing
	{
		"norcalli/nvim-colorizer.lua",
		event = { "InsertEnter" },
		opts = {},
	},

	-- tailwindcss color thing
	{
		"themaxmarchuk/tailwindcss-colors.nvim",
		event = { "InsertEnter" },
		opts = {},
	},

	-- nice looking todos
	-- TODO:
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = { "BufReadPost" },
		opts = {},
	},

	-- pretty diagnostics
	{
		"folke/trouble.nvim",
		event = { "BufReadPost" },
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
	},

	-- nice icons everywhere
	{
		"nvim-tree/nvim-web-devicons",
		event = "VeryLazy",
		opts = {},
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
		event = "VeryLazy",
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

	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		event = "VeryLazy",
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

	{
		"LhKipp/nvim-nu",
		build = ":TSInstall nu",
		event = { "VeryLazy" },
		opts = {},
	},
	-- create and manage gists
	{
		"Rawnly/gist.nvim",
		event = { "VeryLazy" },
		cmd = { "GistCreate", "GistCreateFromFile", "GistsList" },
		config = true,
	},

	-- time tracker for developers
	{
		"wakatime/vim-wakatime",
		event = "BufReadPost",
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
		event = { "VeryLazy" },
		init = function()
			require("nvim-tmux-navigation")
		end,
	},

	{
		"xiyaowong/telescope-emoji.nvim",
		event = { "VeryLazy" },
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
	{ "akinsho/toggleterm.nvim", version = "*", config = true },

	{
		"vladdoster/remember.nvim",
		event = { "VeryLazy" },
		opts = {},
	},
	{
		-- NOTE: would like to sort this by category
		"mrjones2014/legendary.nvim",
		-- since legendary.nvim handles all your keymaps/commands,
		-- its recommended to load legendary.nvim before other plugins
		priority = 10000,
		lazy = false,
		-- sqlite is only needed if you want to use frecency sorting
		dependencies = { "kkharji/sqlite.lua" },
		opts = {
			extensions = {
				lazy_nvim = true,
				which_key = {},
			},
		},
		keys = {
			{
				"<M-x>",
				"<cmd>:Legendary<CR>",
				desc = "Emacs Like Search",
			},
		},
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration

			-- Only one of these is needed.
			-- "nvim-telescope/telescope.nvim", -- optional
			"ibhagwan/fzf-lua", -- optional
			-- "echasnovski/mini.pick", -- optional
		},
		-- config = true,
		opts = {},
		keys = {
			{
				"<leader>gg",
				"<cmd>Neogit<CR>",
				desc = "NeoGit",
			},
		},
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
		lazy = false,
		main = "rainbow-delimiters.setup",
		opts = {},
	},
	{ "tpope/vim-sleuth" },
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {
			modes = {
				char = {
					jump_labels = true,
				},
			},
		},
		-- stylua: ignore
		keys = {
			-- { "f",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
			-- { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
			-- { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
			{ "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
			-- { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
			-- { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		-- or                              , branch = '0.1.x',
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"pteroctopus/faster.nvim",
	},
	{ "nvim-treesitter/nvim-treesitter" },
	{
		"serenevoid/kiwi.nvim",
		opts = {
			{
				name = "work",
				path = "work-wiki",
			},
			{
				name = "personal",
				path = "personal-wiki",
			},
		},
		keys = {
			-- { "<leader>ww", ':lua require("kiwi").open_wiki_index()<cr>', desc = "Open Wiki index" },
			{ "<leader>ww", ':lua require("kiwi").open_wiki_index("work")<cr>', desc = "Open Wiki index" },
			{
				"<leader>wp",
				':lua require("kiwi").open_wiki_index("personal")<cr>',
				desc = "Open index of personal wiki",
			},
			{ "T", ':lua require("kiwi").todo.toggle()<cr>', desc = "Toggle Markdown Task" },
		},
		lazy = true,
	},
	{
		"folke/ts-comments.nvim",
		opts = {},
		event = "VeryLazy",
		enabled = vim.fn.has("nvim-0.10.0") == 1,
	},
}
