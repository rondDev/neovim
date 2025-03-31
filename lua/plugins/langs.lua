return {
	-- Zig.
	{
		"ziglang/zig.vim",
		ft = "zig",
	},

	-- Rust
	{
		"mrcjkb/rustaceanvim",
		version = "^5", -- Recommended
		lazy = false, -- This plugin is already lazy
	},
	-- {
	-- 	"simrat39/rust-tools.nvim",
	-- 	ft = "rust",
	-- },

	-- typescript
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		lazy = true,
		opts = {},
	},

	-- svelte
	{
		"nvim-svelte/nvim-svelte-snippets",
		dependencies = "L3MON4D3/LuaSnip",
		opts = {
			-- your configuration comes here
			-- or leave empty for defaults
		},
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
}
