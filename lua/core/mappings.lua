-- n, v, i, t = mode name

local M = {}

local is_git_directory = function()
	local result = vim.fn.system("git rev-parse --is-inside-work-tree")
	if vim.v.shell_error == 0 and result:find("true") then
		return true
	else
		return false
	end
end

M.general = {
	i = {
		-- move with C + movement key
		["<C-h>"] = { "<Left>", "Move left" },
		["<C-l>"] = { "<Right>", "Move right" },
		["<C-j>"] = { "<Down>", "Move down" },
		["<C-k>"] = { "<Up>", "Move up" },
	},

	n = {
		-- move between windows
		["<C-h>"] = { "<C-w>h", "Window left" },
		["<C-l>"] = { "<C-w>l", "Window right" },
		["<C-j>"] = { "<C-w>j", "Window down" },
		["<C-k>"] = { "<C-w>k", "Window up" },

		-- move and center
		["{"] = { "{zz", "{zz" },
		["}"] = { "}zz", "}zz" },
		["%"] = { "%zz", "%zz" },
		["*"] = { "*zz", "*zz" },
		["#"] = { "#zz", "#zz" },
		["<leader>[d"] = {
			function()
				vim.diagnostic.goto_prev({})
				vim.api.nvim_feedkeys("zz", "n", false)
			end,
			"Goto previous diagnostic (any)",
		},
		["<leader>[e"] = {
			function()
				vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
				vim.api.nvim_feedkeys("zz", "n", false)
			end,
			"Goto previous diagnostic (error)",
		},
		["<leader>[w"] = {
			function()
				vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
				vim.api.nvim_feedkeys("zz", "n", false)
			end,
			"Goto previous diagnostic (warning)",
		},
		["<leader>]d"] = {
			function()
				vim.diagnostic.goto_next({})
				vim.api.nvim_feedkeys("zz", "n", false)
			end,
			"Goto next diagnostic (any)",
		},
		["<leader>]e"] = {
			function()
				vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
				vim.api.nvim_feedkeys("zz", "n", false)
			end,
			"Goto next diagnostic (error)",
		},
		["<leader>]w"] = {
			function()
				vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
				vim.api.nvim_feedkeys("zz", "n", false)
			end,
			"Goto next diagnostic (warning)",
		},

		["gg"] = { "ggzz", "ggzz" },
		["G"] = { "Gzz", "Gzz" },
		["<C-u>"] = { "<C-u>zz", "Move up and center" },
		["<C-d>"] = { "<C-d>zz", "Move down and center" },
		["<C-i>"] = { "<C-i>zz", "Move to Nth newer position and center" },
		["<C-o>"] = { "<C-o>zz", "Move to Nth older position and center" },

		-- more movement
		["H"] = { "^", "Jump to start of line" },
		["L"] = { "$", "Jump to end of line" },
		["n"] = { "nzz", "Repeat last search and center" },
		["N"] = { "Nzz", "Repeat last search and center (opposite)" },
		["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
		["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
		["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
		["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },

		-- quite nasty replace under cursor
		["S"] = {
			function()
				local cmd = ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>"
				local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
				vim.api.nvim_feedkeys(keys, "n", false)
			end,
			"Replace under cursor",
		},

		-- no prefix
		["<leader>'"] = { "<C-^>", "Switch to last buffer" },
		["<leader>="] = { "<C-w>=", "Resize split windows to equal size" },

		["U"] = { "<C-r>", "Redo" },

		-- TODO: create buffer management keybinds for leader-b

		-- c key prefix
		["<leader>cc"] = { "<cmd>cclose<CR>zz", "Close quickfix list" },
		["<leader>ci"] = { "<cmd>RToggleInlay<CR>", "Toggle Inlay Hints" },
		["<leader>cn"] = { "<cmd>cnext<CR>zz", "Go to next quickfix list item" },
		["<leader>co"] = { "<cmd>copen<CR>zz", "Open the quickfix list" },
		["<leader>cp"] = { "<cmd>cprev<CR>zz", "Previous quickfix list item" },
		["<leader>ct"] = { "<cmd>TroubleToggle<CR>", "Toggle trouble (error list)" },

		["<leader>d"] = {
			function()
				vim.diagnostic.open_float({
					border = "rounded",
				})
			end,
			"Show floating diagnostics",
		},

		["<leader>e"] = { "<cmd>Neotree toggle<CR>", "Toggle Neotree" },

		-- format
		["<leader>f"] = {
			function()
				vim.lsp.buf.format({ async = true })
			end,
			"Format document",
		},

		["<leader>gb"] = { "<cmd>Gitsigns ottgle_current_line_blame<CR>", "Toggle current line blame" },
		["<leader>gf"] = {
			function()
				local cmd = {
					"sort",
					"-u",
					"<(git diff --name-only --cached)",
					"<(git diff --name-only)",
					"<(git diff --name-only --diff-filter=U)",
				}

				if not is_git_directory() then
					vim.notify(
						"Current project is not a git directory",
						vim.log.levels.WARN,
						{ title = "Telescope Git Files", git_command = cmd }
					)
				else
					require("telescope.builtin").git_files()
				end
			end,
			"Search Git Files",
		},
		-- git keys
		["<leader>gg"] = { "<cmd>Neogit<CR>", "Open Neogit" },
		["<leader>gv"] = { "<cmd>Neogit kind=vsplit<CR>", "Open Neogit" },

		["<leader>m"] = { "<cmd>MaximizerToggle<CR>", "Maximizer Toggle" },

		-- NOTE: might remap to Esc
		["<leader>no"] = { "<cmd>noh<CR>", "Turn off highlighted results" },

		-- [o]pen keys
		["<leader>oo"] = { "<cmd>Oil<CR>", "Open Oil" },
		["<leader>ot"] = { "<cmd>term<CR>", "Open Terminal" },

		["<leader>q"] = { "<cmd>q<CR>", "Quit" },

		["<leader>rw"] = { "<cmd>RotateWindows<CR>", "Rotate Windows" },

		["<leader>S"] = { "<cmd>lua require('spectre').toggle()<CR>", "Global Search and Replace" },

		["<leader>uc"] = {
			function()
				if vim.o.conceallevel == 3 then
					vim.o.conceallevel = 0
					vim.notify("Conceal turned off", "info")
				else
					vim.o.conceallevel = 3
					vim.notify("Conceal turned on", "info")
				end
			end,
			"Toggle Conceal",
		},

		["<leader>wv"] = { "<cmd>vsplit<CR>", "Split [W]indow [V]ertically" },
		["<leader>wr"] = { "<cmd>vsplit<CR>", "Split [W]indow [R]ight" },
		["<leader>wh"] = { "<cmd>split<CR>", "Split [W]indow [H]orizontally" },
		["<leader>wb"] = { "<cmd>split<CR>", "Split [W]indow [B]ottom" },
		["<leader>wq"] = { "<cmd>q<CR>", "[W]indow [Q]uit" },

		["<leader>z"] = { "<cmd>xa<CR>", "Write quit (xa / wqa)" },

		-- Telescope keybinds --
		["<leader>?"] = {
			function()
				require("telescope.builtin").oldfiles()
			end,
			"[?] Find recently opened files",
		},
		["<leader>= sb"] = {
			function()
				require("telescope.builtin").buffers()
			end,
			"[S]earch Open [B]uffers",
		},
		["<leader>sf"] = {
			function()
				require("telescope.builtin").find_files({ hidden = true })
			end,
			"[S]earch [F]iles",
		},
		["<leader>sh"] = {
			function()
				require("telescope.builtin").help_tags()
			end,
			"[S]earch [H]elp",
		},
		["<leader>sw"] = {
			function()
				require("telescope.builtin").grep_string()
			end,
			"[S]earch current [W]ord",
		},
		["<leader>sg"] = {
			function()
				require("telescope.builtin").live_grep()
			end,
			"[S]earch by [G]rep",
		},
		["<leader>sd"] = {
			function()
				require("telescope.builtin").diagnostics()
			end,
			"[S]earch [D]iagnostics",
		},

		["<leader>sc"] = {
			function()
				require("telescope.builtin").commands(require("telescope.themes").get_dropdown({
					previewer = false,
				}))
			end,
			"[S]earch [C]ommands",
		},

		["<leader>/"] = {
			function()
				require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					previewer = false,
				}))
			end,
			"[/] Fuzzily search in current buffer]",
		},

		["<leader>ss"] = {
			function()
				require("telescope.builtin").spell_suggest(require("telescope.themes").get_dropdown({
					previewer = false,
				}))
			end,
			"[S]earch [S]pelling suggestions",
		},

		-- Symbol Outline keybind
		["<leader>so"] = { "<cmd>SymbolsOutline<CR>" },
	},

	t = {
		["<C-h>"] = { "<C-w>h", "Window left" },
		["<C-l>"] = { "<C-w>l", "Window right" },
		["<C-j>"] = { "<C-w>j", "Window down" },
		["<C-k>"] = { "<C-w>k", "Window up" },

		-- enter normal mode in terminal mode
		["<esc>"] = { "[[<C-\\><C-n>]]" },
	},

	v = {
		["H"] = { "^", "Jump to start of line" },
		["L"] = { "$", "Jump to end of line" },
		["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
		["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
		["<"] = { "<gv", "Indent line" },
		[">"] = { ">gv", "Indent line" },

		-- move selected text up/down
		["<A-j>"] = { ":m '>+1<CR>gv=gv" },
		["<A-k>"] = { ":m '<-2<CR>gv=gv" },
	},

	x = {
		-- Don't copy the replaced text after pasting in visual mode
		-- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
		["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', "Dont copy replaced text", opts = { silent = true } },
		["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
		["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
	},
}

return M
