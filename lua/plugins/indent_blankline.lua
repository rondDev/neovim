return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
		event = "BufEnter",
		config = function()
			require("ibl").setup({
				scope = {
					enabled = true,
					show_start = true,
					show_end = true,
				},
			})
		end,
	},
}
