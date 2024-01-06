local options = {
	ensure_installed = {
		"bash",
		"c",
		"css",
    "diff",
		"html",
		"javascript",
    "jsdoc",
		"json",
		"jsonc",
		"lua",
		"luadoc",
		"luap",
		"graphql",
		"markdown",
		"markdown_inline",
		"prisma",
    "python",
    "query",
    "regex",
		"svelte",
    "toml",
		"tsx",
		"typescript",
		"vim",
		"vimdoc",
		"yaml",
	},
	sync_install = false,
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	},
	autopairs = {
		enable = true,
	},
	autotag = {
		enable = true,
	},
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<c-space>",
			node_incremental = "<c-space>",
			scope_incremental = "<c-s>",
			node_decremental = "<c-backspace>",
		},
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
	},
}

return {

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
			return options
		end,
		config = function(_, opts)
			---@diagnostic disable: missing-fields
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
