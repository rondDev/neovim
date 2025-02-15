return {
	-- manage parentheses, brackets, quotes etc.
	{
		"tpope/vim-surround",
	},

	{
		"nyoom-engineering/oxocarbon.nvim",
		config = function()
			vim.cmd.colorscheme("oxocarbon")
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

	{
		"LhKipp/nvim-nu",
		build = ":TSInstall nu",
		config = function()
			require("nu").setup()
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
	-- org mode :D
	{
		"chipsenkbeil/org-roam.nvim",
		tag = "0.1.1",
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter", lazy = true },
			{
				"nvim-orgmode/orgmode",
				build = ":TSInstall org",
				tag = "0.3.7",
			},
		},
		config = function()
			require("org-roam").setup({
				directory = "~/org_roam_files",
				-- optional
				org_files = {
					"~/org",
				},
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

	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration

			-- Only one of these is needed.
			-- "nvim-telescope/telescope.nvim", -- optional
			"ibhagwan/fzf-lua", -- optional
			-- "echasnovski/mini.pick",         -- optional
		},
		config = true,
	},
}
