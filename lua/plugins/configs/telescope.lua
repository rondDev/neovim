local actions = require("telescope.actions")

local options = {
	defaults = {
		mappings = {
			i = {
				["<C-k>"] = actions.move_selection_previous,
				["<C-j>"] = actions.move_selection_next,
				["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
				["<C-x>"] = actions.delete_buffer,
			},
		},
		file_ignore_patterns = {
			"node_modules",
			"yarn.lock",
			".git",
		},
		hidden = true,
	},
}

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

return {

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
			return options
		end,
		config = function(_, opts)
			require("telescope").setup(opts)
		end,
	},
}
