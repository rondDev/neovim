return {
	{
		"simrat39/symbols-outline.nvim",
		cmd = { "SymbolsOutline", "SymbolsOutlineOpen", "SymbolsOutlineClose" },
		config = function()
			require("symbols-outline").setup({
				symbols = {
					File = { icon = "", hl = "@text.uri" },
					Module = { icon = "", hl = "@namespace" },
					Namespace = { icon = "", hl = "@namespace" },
					Package = { icon = "", hl = "@namespace" },
					Class = { icon = "", hl = "@type" },
					Method = { icon = "ƒ", hl = "@method" },
					Property = { icon = "", hl = "@method" },
					Field = { icon = "", hl = "@field" },
					Constructor = { icon = "", hl = "@constructor" },
					Enum = { icon = "", hl = "@type" },
					Interface = { icon = "", hl = "@type" },
					Function = { icon = "", hl = "@function" },
					Variable = { icon = "", hl = "@constant" },
					Constant = { icon = "", hl = "@constant" },
					String = { icon = "", hl = "@string" },
					Number = { icon = "#", hl = "@number" },
					Boolean = { icon = "", hl = "@boolean" },
					Array = { icon = "", hl = "@constant" },
					Object = { icon = "", hl = "@type" },
					Key = { icon = "", hl = "@type" },
					Null = { icon = "", hl = "@type" },
					EnumMember = { icon = "", hl = "@field" },
					Struct = { icon = "", hl = "@type" },
					Event = { icon = "", hl = "@type" },
					Operator = { icon = "", hl = "@operator" },
					TypeParameter = { icon = "", hl = "@parameter" },
					Component = { icon = "", hl = "@function" },
					Fragment = { icon = "", hl = "@constant" },
				},
			})
		end,
	},

	{
		"gelguy/wilder.nvim",
		keys = {
			":",
			"/",
			"?",
		},
		config = function()
			local wilder = require("wilder")
			-- local oxocarbon = require("oxocarbon")

			-- Create a highlight group for the popup menu
			-- local text_highlight = wilder.make_hl("WilderText", { { a = 1 }, { a = 1 }, { foreground = oxocarbon.text } })
			-- local mauve_highlight = wilder.make_hl("WilderMauve", { { a = 1 }, { a = 1 }, { foreground = oxocarbon.mauve } })

			-- Enable wilder when pressing :, / or ?
			wilder.setup({ modes = { ":", "/", "?" } })

			-- Enable fuzzy matching for commands and buffers
			wilder.set_option("pipeline", {
				wilder.branch(
					wilder.cmdline_pipeline({
						fuzzy = 1,
					}),
					wilder.vim_search_pipeline({
						fuzzy = 1,
					})
				),
			})

			wilder.set_option(
				"renderer",
				wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
					highlighter = wilder.basic_highlighter(),
					-- highlights = {
					-- 	default = text_highlight,
					-- 	border = mauve_highlight,
					-- 	accent = mauve_highlight,
					-- },
					pumblend = 5,
					min_width = "100%",
					min_height = "25%",
					max_height = "25%",
					border = "rounded",
					left = { " ", wilder.popupmenu_devicons() },
					right = { " ", wilder.popupmenu_scrollbar() },
				}))
			)
		end,
	},
}
