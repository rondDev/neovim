return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			scope = {
				enabled = true,
				show_start = true,
				show_end = true,
			},
		},
		event = "VeryLazy",
		config = function() end,
	},
}
