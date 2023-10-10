return {
	{
		"b0o/incline.nvim",
		branch = "main",
		event = "BufReadPost",
		config = function()
			vim.o.laststatus = 3
			require("incline").setup({

				render = function(props)
					if vim.bo[props.buf].buftype == "terminal" then
						return {
							{ " " .. vim.bo[props.buf].channel .. " ", group = "DevIconTerminal" },
							{ " " .. vim.api.nvim_win_get_number(props.win), group = "Special" },
						}
					end

					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
					local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
					local modified = vim.api.nvim_get_option_value("modified", { buf = 0 }) and "bold,italic" or "bold"

					local function get_git_diff()
						local icons = { removed = "", changed = "", added = "" }
						icons["changed"] = icons.modified
						local signs = vim.b[props.buf].gitsigns_status_dict
						local labels = {}
						if signs == nil then
							return labels
						end
						for name, icon in pairs(icons) do
							if tonumber(signs[name]) and signs[name] > 0 then
								table.insert(labels, { icon .. signs[name] .. " ", group = "Diff" .. name })
							end
						end
						if #labels > 0 then
							table.insert(labels, { "┊ " })
						end
						return labels
					end
					local function get_diagnostic_label()
						local label = {}
						local icons = { error = "", warn = "", info = "", hint = "" }

						for severity, icon in pairs(icons) do
							local n = #vim.diagnostic.get(
								props.buf,
								{ severity = vim.diagnostic.severity[string.upper(severity)] }
							)
							if n > 0 then
								table.insert(label, { icon .. n .. " ", group = "DiagnosticSign" .. severity })
							end
						end
						if #label > 0 then
							table.insert(label, { "┊ " })
						end
						return label
					end

					local buffer = {
						{ get_diagnostic_label() },
						{ get_git_diff() },
						{ ft_icon .. " ", guifg = ft_color, guibg = "none" },
						{ filename .. " ", gui = modified },
						-- { " " .. vim.api.nvim_win_get_number(props.win), group = "Special" },
					}
					return buffer
				end,
			})
		end,
	},
}
