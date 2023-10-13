return {
	"themaxmarchuk/tailwindcss-colors.nvim",
	event = { "BufEnter" },
	config = function()
		require("tailwindcss-colors").setup()
	end,
}
