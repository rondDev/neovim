local function config_files()
	vim.cmd("cd ~/.config/nvim")
	vim.cmd("lua require('telescope.builtin').find_files()")
end

return {
	-- thank you mr. folke for the dashboard
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		opts = function()
			local logo = [[
                                                /|  /|  ---------------------------
                                                ||__||  |                         |
                                               /   O O\__  I have a horny little  |
                                              /          \   operating system     |
                                             /      \     \                       |
                                            /   _    \     \ ----------------------
                             /    |\____\     \      ||
                            /     | | | |\____/      ||
                           /       \| | | |/ |     __||
                          /  /  \   -------  |_____| ||
                         /   |   |           |       --|
                        |   |   |           |_____  --|
                        |  |_|_|_|          |     \----
           /\                  |
          / /\        |        /
         / /  |       |       |
     ___/ /   |       |       |
    |____/    c_c_c_C/ \C_c_c_c
      ]]

			local logo2 = [[
b.
  88b
    888b.
    88888b
      888888b.
    8888P"
    P" `8.
          `8.
          `8
      ]]

			local logo3 = [[
,---,---,---,---,---,---,---,---,---,---,---,---,---,-------,
|ESC| 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 0 | + | ' | <-    |
|---'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-----|
| ->| | Q | W | E | R | T | Y | U | I | O | P | ] | ^ |     |
|-----',--',--',--',--',--',--',--',--',--',--',--',--'|    |
| Caps | A | S | D | F | G | H | J | K | L | \ | [ | * |    |
|----,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'---'----|
|    | < | Z | X | C | V | B | N | M | , | . | - |          |
|----'-,-',--'--,'---'---'---'---'---'---'-,-'---',--,------|
| ctrl |  | alt |                          |altgr |  | ctrl |
'------'  '-----'--------------------------'------'  '------'
]]

			logo = string.rep("\n", 8) .. logo .. "\n\n"

			local opts = {
				theme = "doom",
				hide = {
					-- this is taken care of by lualine
					-- enabling this messes up the actual laststatus setting after loading a file
					statusline = false,
				},
				config = {
					header = vim.split(logo, "\n"),
          -- stylua: ignore
          center = {
            { action = "Telescope find_files", desc = " Find file", icon = " ", key = "f" },
            { action = "ene | startinsert", desc = " New file", icon = " ", key = "n" },
            { action = "Telescope oldfiles", desc = " Recent files", icon = " ", key = "r" },
            { action = "Telescope live_grep", desc = " Find text", icon = " ", key = "g" },
            -- { action = Util.telescope.config_files(), desc = " Config", icon = " ", key = "c" },
            { action = function() config_files() end, desc = " Config", icon = " ", key = "c" },
            { action = 'lua require("persistence").load()', desc = " Restore Session", icon = " ", key = "s" },
            -- { action = "LazyExtras", desc = " Lazy Extras", icon = " ", key = "x" },
            { action = "Lazy", desc = " Lazy", icon = "󰒲 ", key = "l" },
            { action = "qa", desc = " Quit", icon = " ", key = "q" },
          },
					footer = function()
						local stats = require("lazy").stats()
						local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
						return {
							"⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
						}
					end,
				},
			}

			for _, button in ipairs(opts.config.center) do
				button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
			end

			-- close Lazy and re-open when the dashboard is ready
			if vim.o.filetype == "lazy" then
				vim.cmd.close()
				vim.api.nvim_create_autocmd("User", {
					pattern = "DashboardLoaded",
					callback = function()
						require("lazy").show()
					end,
				})
			end

			return opts
		end,
	},
	{
		"romgrk/barbar.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
			"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
		},
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		opts = {
			animation = true,
			clickable = true,
			icons = {
				buffer_index = true,
				button = "",
				preset = "slanted",
				diagnostics = {
					[vim.diagnostic.severity.ERROR] = { enabled = true, icon = "" },
					[vim.diagnostic.severity.WARN] = { enabled = true, icon = "" },
					[vim.diagnostic.severity.INFO] = { enabled = true, icon = "" },
					[vim.diagnostic.severity.HINT] = { enabled = true, icon = "" },
				},
				gitsigns = {
					added = { enabled = true, icon = "" },
					changed = { enabled = true, icon = "" },
					deleted = { enabled = true, icon = "" },
				},
			},
			sidebar_filetypes = {
				["neo-tree"] = { event = "BufWipeout" },
			},
			-- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
			-- animation = true,
			-- insert_at_start = true,
			-- …etc.
		},
	},
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
	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
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
		"b0o/incline.nvim",
		enabled = false,
		branch = "main",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
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

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		config = function()
			require("ibl").setup({
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
			})
		end,
	},

	{
		"echasnovski/mini.indentscope",
		version = false, -- wait till new 0.7.0 release to put it back on semver
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		opts = {
			-- symbol = "▏",
			symbol = "│",
			options = { try_as_border = true },
		},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	},

	{
		"themaxmarchuk/tailwindcss-colors.nvim",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		config = function()
			require("tailwindcss-colors").setup()
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		event = { "VeryLazy", "BufReadPost", "BufNewFile", "BufWritePre" },
		dependencies = {
			-- "ThePrimeagen/harpoon",
			{
				"f-person/git-blame.nvim",
				event = { "BufReadPost", "BufNewFile", "BufWritePre" },
			},
		},
		config = function()
			-- local harpoon = require("harpoon.mark")
			local git_blame = require("gitblame")

			-- local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
			-- local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
			-- local modified = vim.api.nvim_get_option_value("modified", { buf = 0 }) and "bold,italic" or "bold"

			local function truncate_branch_name(branch)
				if not branch or branch == "" then
					return ""
				end

				-- Match the branch name to the specified format
				local _, _, ticket_number = string.find(branch, "skdillon/sko%-(%d+)%-")

				-- If the branch name matches the format, display sko-{ticket_number}, otherwise display the full branch name
				if ticket_number then
					return "sko-" .. ticket_number
				else
					return branch
				end
			end

			-- local function harpoon_component()
			-- 	local total_marks = harpoon.get_length()
			--
			-- 	if total_marks == 0 then
			-- 		return ""
			-- 	end
			--
			-- 	local current_mark = "—"
			--
			-- 	local mark_idx = harpoon.get_current_index()
			-- 	if mark_idx ~= nil then
			-- 		current_mark = tostring(mark_idx)
			-- 	end
			--
			-- 	return string.format("󱡅 %s/%d", current_mark, total_marks)
			-- end

			vim.g.gitblame_display_virtual_text = 0

			require("lualine").setup({
				options = {
					theme = "auto",
					globalstatus = true,
					disabled_filetypes = {
						winbar = {
							"dashboard",
						},
					},
				},
				sections = {
					lualine_b = {
						{ "branch", icon = "", fmt = truncate_branch_name },
						-- harpoon_component,
						-- "diff",
						"diagnostics",
					},
					lualine_c = {
						{ "filename", path = 1 },
						{ git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available },
					},
					lualine_x = {
						"filetype",
					},
				},
				winbar = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {
						"diagnostics",
						{ "diff", symbols = { added = "", modified = "", removed = "" } },
					},
					lualine_z = { { "filetype", icon_only = true }, "filename" },
				},

				inactive_winbar = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {
						"diagnostics",
						{ "diff", symbols = { added = "", modified = "", removed = "" } },
					},
					lualine_z = { { "filetype", icon_only = true }, "filename" },
				},
			})
		end,
	},

	{

		"rcarriga/nvim-notify",
		event = { "VeryLazy" },
		config = function()
			local notify = require("notify")

			local filtered_message = { "No information available" }

			-- Override notify function to filter out messages
			---@diagnostic disable-next-line: duplicate-set-field
			vim.notify = function(message, level, opts)
				local merged_opts = vim.tbl_extend("force", {
					on_open = function(win)
						local buf = vim.api.nvim_win_get_buf(win)
						vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
					end,
				}, opts or {})

				for _, msg in ipairs(filtered_message) do
					if message == msg then
						return
					end
				end
				return notify(message, level, merged_opts)
			end

			-- Update colors to use catpuccino colors
			vim.cmd([[
        highlight NotifyERRORBorder guifg=#ed8796
        highlight NotifyERRORIcon guifg=#ed8796
        highlight NotifyERRORTitle  guifg=#ed8796
        highlight NotifyINFOBorder guifg=#8aadf4
        highlight NotifyINFOIcon guifg=#8aadf4
        highlight NotifyINFOTitle guifg=#8aadf4
        highlight NotifyWARNBorder guifg=#f5a97f
        highlight NotifyWARNIcon guifg=#f5a97f
        highlight NotifyWARNTitle guifg=#f5a97f
      ]])
		end,
	},

	{
		"RRethy/vim-illuminate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("illuminate").configure({
				under_cursor = false,
				filetypes_denylist = {
					"DressingSelect",
					"NvimTree",
					"Outline",
					"TelescopePrompt",
					"alpha",
					"harpoon",
					"toggleterm",
					"neo-tree",
					"Spectre",
					"dashboard",
				},
			})
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		config = function()
			require("gitsigns").setup()
		end,
	},

	{
		"stevearc/dressing.nvim",
		config = function()
			require("dressing").setup()
		end,
	},
}
