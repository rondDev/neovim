local M = {}

M.setup = function()
	-- local harpoon = require("harpoon.mark")
	local git_blame = require("gitblame")

	-- local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
	-- local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
	-- local modified = vim.api.nvim_get_option_value("modified", { buf = 0 }) and "bold,italic" or "bold"

	local function truncate_branch_name(branch)
		if not branch or branch == "" then
			return ""
		end
			return branch
	end

	vim.g.gitblame_display_virtual_text = 0

	-- A lot of the code here has been taken from: https://github.com/nvim-lualine/lualine.nvim/blob/master/examples/evil_lualine.lua
	local colors = {
		bg = "#202328",
		fg = "#bbc2cf",
		yellow = "#ECBE7B",
		cyan = "#008080",
		darkblue = "#081633",
		green = "#98be65",
		orange = "#FF8800",
		violet = "#a9a1e1",
		magenta = "#c678dd",
		blue = "#51afef",
		red = "#ec5f67",
		grey = "#303030",
		black = "#080808",
	}

	local conditions = {
		buffer_not_empty = function()
			return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
		end,
		hide_in_width = function()
			return vim.fn.winwidth(0) > 80
		end,
		check_git_workspace = function()
			local filepath = vim.fn.expand("%:p:h")
			local gitdir = vim.fn.finddir(".git", filepath .. ";")
			return gitdir and #gitdir > 0 and #gitdir < #filepath
		end,
	}

	local rond_theme = {
		normal = {
			c = { bg = colors.black },
		},

		insert = {
			a = { fg = colors.black, bg = colors.magenta },
		},
	}

	local config = {
		options = {
			theme = "auto",
			-- theme = rond_theme,
			globalstatus = true,
			section_separators = { left = "", right = "" },
			component_separators = "",
			disabled_filetypes = {
				winbar = {
					"dashboard",
				},
			},
		},
		sections = {
			lualine_b = {},
			lualine_y = {},
			lualine_z = {},

			lualine_a = {},
			lualine_c = {},
			lualine_x = {},
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_y = {},
			lualine_z = {},

			lualine_c = {},
			lualine_x = {},
		},
		winbar = {
			lualine_a = {},
			lualine_b = {
				{ "branch", icon = "", fmt = truncate_branch_name },
				{ git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available },
			},
			lualine_c = {},
			lualine_x = { "b:gitsigns_status" },
			lualine_y = {
				{ "diff", symbols = { added = " ", modified = " ", removed = " " } },
			},
			lualine_z = { { "filetype", icon_only = true }, { "filename", path = 1 } },
		},

		inactive_winbar = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {},
			lualine_x = { "b:gitsigns_status" },
			lualine_y = {
				"diagnostics",
				{ "diff", symbols = { added = " ", modified = " ", removed = " " } },

			},
			lualine_z = { { "filetype", icon_only = true }, "filename" },
		},
	}

	local function ins_a(component)
		table.insert(config.sections.lualine_a, component)
	end

	-- Inserts a component in lualine_c at left section
	local function ins_left(component)
		table.insert(config.sections.lualine_c, component)
	end

	-- Inserts a component in winbar lualine_x at right section
	local function ins_right(component)
		table.insert(config.sections.lualine_x, component)
	end

	ins_a({
		"mode",
		seperator = { left = "", right = "" },
		right_padding = 2,
	})

	ins_left({
		"filesize",
		cond = conditions.buffer_not_empty,
	})

	ins_left({
		"filename",
		cond = conditions.buffer_not_empty,
		color = { fg = colors.magenta, gui = "bold" },
	})

	ins_left({ "progress", color = { fg = colors.fg, gui = "bold" } })

	ins_left({
		"diagnostics",
		sources = { "nvim_diagnostic" },
		symbols = { error = " ", warn = " ", info = " " },
		diagnostics_color = {
			color_error = { fg = colors.red },
			color_warn = { fg = colors.yellow },
			color_info = { fg = colors.cyan },
		},
	})

	ins_left({
		-- "vim.api.nvim_win_get_cursor(0)[1]",
		"%10([%l/%L%)]",
	})

	ins_left({
		function()
			return "%="
		end,
	})

	ins_left({
		-- Lsp server name .
		function()
			local msg = "No Active Lsp"
			local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
			local clients = vim.lsp.get_active_clients()
			if next(clients) == nil then
				return msg
			end
			for _, client in ipairs(clients) do
				local filetypes = client.config.filetypes
				if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
					return client.name
				end
			end
			return msg
		end,
		icon = " LSP:",
		-- color = { fg = "#ffffff", gui = "bold" },
		seperator = { left = "", right = "" },
	})

	-- Add components to right sections
	ins_right({
		"o:encoding", -- option component same as &encoding in viml
		fmt = string.upper, -- I'm not sure why it's upper case either ;)
		cond = conditions.hide_in_width,
		color = { fg = colors.green, gui = "bold" },
	})

	ins_right({
		"fileformat",
		fmt = string.upper,
		icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
		color = { fg = colors.green, gui = "bold" },
	})

	ins_right({
		"branch",
		icon = "",
		color = { fg = colors.violet, gui = "bold" },
	})

	ins_right({
		"diff",
		-- Is it me or the symbol for modified us really weird
		symbols = { added = "", modified = "", removed = "" },
		diff_color = {
			added = { fg = colors.green },
			modified = { fg = colors.orange },
			removed = { fg = colors.red },
		},
		-- cond = conditions.hide_in_width,
	})

	ins_right({
		function()
			return "▊"
		end,
		color = { fg = colors.blue },
		padding = { left = 1 },
	})

	require("lualine").setup(config)
end

return M
