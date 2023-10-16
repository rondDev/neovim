local function local_replace() end

return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			-- Set delay for whichkey to popup to 300ms
			vim.o.timeoutlen = 300
		end,
		opts = {
			-- todo
			defaults = {},
		},
		config = function()
			local wk = require("which-key")

			wk.register({
				["'"] = { "<C-^>", "Switch to last buffer" },
				c = {
					name = "code",
					c = { "<cmd>cclose<cr>zz", "Close quickfix list" },
					i = { "<cmd>RToggleInlay<cr>", "Toggle Inlay Hints" },
					n = { "<cmd>cnext<cr>zz", "Go to next quickfix list item" },
					o = { "<cmd>copen<cr>zz", "Open the quickfix list" },
					p = { "<cmd>cprev<cr>zz", "Previous quickfix list item" },
					t = { "<cmd>TroubleToggle<cr>", "Toggle trouble (error list)" },
				},
				e = { "<cmd>Neotree toggle<cr>", "Toggle Neotree" },
				g = {
					name = "git",
					g = { "<cmd>Neogit<cr>", "Open Neogit (preferred)" },
					v = { "<cmd>Neogit kind=vsplit<cr>", "Open Neogit (VSplit)" },
				},
				n = {
					o = { "<cmd>noh<cr>", "Turn off highlighted results" },
				},
				o = {
					name = "open",
					c = { "<cmd>FineCmdline<cr>", "[O]pen [C]ommand bar" },
					o = { "<cmd>Oil<cr>", "[O]pen [O]il" },
					t = { "<cmd>term<cr>", "[O]pen [T]erminal" },
				},
				q = { "<cmd>q<cr>", "Quit" },
				s = {
					name = "search/session",
				},
				S = { "<cmd>lua require('spectre').toggle()<cr>", "Global Search and Replace" },
				t = {
					name = "toggle/tab",
					c = { "<cmd>BufferPickDelete<cr>", "[T]ab [C]lose" },
					s = { "<cmd>ToggleStream<cr>", "[T]oggle [S]tream Mode" },
					t = { "<cmd>FloatermToggle<cr>", "[T]oggle [T]erminal" },
					z = { "<cmd>Twilight<cr>", "[T]oggle Twilight ([Z]en)" },
				},
				w = {
					name = "window",
					v = { "<cmd>vsplit<cr>", "Split [W]indow [V]ertically" },
					r = { "<cmd>vsplit<cr>", "Split [W]indow [R]ight" },
					h = { "<cmd>split<cr>", "Split [W]indow [H]orizontally" },
					b = { "<cmd>split<cr>", "Split [W]indow [B]ottom" },
					q = { "<cmd>q<cr>", "[W]indow [Q]uit" },
				},
				x = { "<cmd>BufferPick<cr>", "Pick buffer" },
				z = { "<cmd>wq<cr>", "Write quit (wq)" },
			}, { prefix = "<leader>" })

			------------- No prefix normal mode binds --------------
			wk.register({

				["{"] = { "{zz", "{zz" },
				["}"] = { "}zz", "}zz" },

				["%"] = { "%zz", "%zz" },
				["*"] = { "*zz", "*zz" },
				["#"] = { "#zz", "#zz" },
				["]"] = {
					d = {
						function()
							vim.diagnostic.goto_next({})
							vim.api.nvim_feedkeys("zz", "n", false)
						end,
						"Goto next diagnostic (any)",
					},
					e = {
						function()
							vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
							vim.api.nvim_feedkeys("zz", "n", false)
						end,
						"Goto next diagnostic (error)",
					},
				},
				["["] = {
					d = {
						function()
							vim.diagnostic.goto_prev({})
							vim.api.nvim_feedkeys("zz", "n", false)
						end,
						"Goto previous diagnostic (any)",
					},
					e = {
						function()
							vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
							vim.api.nvim_feedkeys("zz", "n", false)
						end,
						"Goto previous diagnostic (error)",
					},
				},
				g = {
					name = "go",
					g = { "ggzz", "ggzz" },
				},
				G = { "Gzz", "Gzz" },
				H = { "^", "Jump to start of line" },
				L = { "$", "Jump to end of line" },
				n = { "nzz", "Repeat last search and center" },
				N = { "Nzz", "Repeat last search and center (opposite)" },
				S = {
					function()
						local cmd = ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>"
						local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
						vim.api.nvim_feedkeys(keys, "n", false)
					end,
					"Replace under cursor",
				},
				U = { "<C-r>", "Redo" },

				["<C-h>"] = { "<cmd>wincmd h<cr>", "Window left" },
				["<C-j>"] = { "<cmd>wincmd j<cr>", "Window down" },
				["<C-k>"] = { "<cmd>wincmd k<cr>", "Window up" },
				["<C-l>"] = { "<cmd>wincmd l<cr>", "Window right" },

				-- Center buffer while navigating
				["<C-u>"] = { "<C-u>zz", "Move up and center" },
				["<C-d>"] = { "<C-d>zz", "Move down and center" },
				["<C-i>"] = { "<C-i>zz", "Move to Nth newer position and center" },
				["<C-o>"] = { "<C-o>zz", "Move to Nth older position and center" },
			})

			--------------- Terminal mode binds -----------------
			wk.register({
				["<C-h>"] = { "<cmd>wincmd h<cr>", "Window left" },
				["<C-j>"] = { "<cmd>wincmd j<cr>", "Window down" },
				["<C-k>"] = { "<cmd>wincmd k<cr>", "Window up" },
				["<C-l>"] = { "<cmd>wincmd l<cr>", "Window right" },
			}, { mode = "t" })

			--------------- Visual mode binds -----------------
			wk.register({
				H = { "^", "Jump to start of line" },
				L = { "$<left>", "Jump to end of line" },
			}, { mode = "v" })
		end,
	},
}
