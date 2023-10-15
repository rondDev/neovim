-- stolen from https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua#L3C1-L5C4
local function augroup(name)
	return vim.api.nvim_create_augroup("rond_" .. name, { clear = true })
end

-- stolen from https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua#L8C1-L11C3
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup("checktime"),
	command = "checktime",
})

-- spell checking in gitcommit, markdown and txt
vim.api.nvim_create_autocmd({ "FileType" }, {
	group = augroup("edit_text"),
	pattern = { "gitcommit", "markdown", "txt" },
	desc = "Enable spell checking and text wrapping for certain filetypes",
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- format on save
vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup("format_on_save"),
	pattern = "*",
	desc = "Run LSP formatting on a file on save",
	callback = function()
		if vim.fn.exists(":Format") > 0 then
			vim.cmd.Format()
		end
	end,
})

-- vertical help
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("vertical_help"),
	pattern = "help",
	callback = function()
		vim.bo.bufhidden = "unload"
		vim.cmd.wincmd("L")
		vim.cmd.wincmd("=")
	end,
})



vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	pattern = "*",
	desc = "Highlight selection on yank",
	callback = function()
		vim.highlight.on_yank({ timeout = 200, visual = true })
	end,
})


-- close some filetypes with <q> -- taken from https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua#L49C1-L72C3
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"PlenaryTestPopup",
		"help",
		"lspinfo",
		"man",
		"notify",
		"qf",
		"query",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"neotest-output",
		"checkhealth",
		"neotest-summary",
		"neotest-output-panel",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- create folder if not exist -- taken from https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua#L85C1-L94C3
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = augroup("auto_create_dir"),
	callback = function(event)
		if event.match:match("^%w%w+://") then
			return
		end
		local file = vim.loop.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})
