-- toggle inlay hints
vim.api.nvim_create_user_command("RToggleInlay", function()
	if vim.fn.has("nvim-0.10") == 1 then
		vim.lsp.inlay_hint(0, nil)
		require("notify")("Toggled Inlay Hints")
	else
		require("notify")("Toggling inlay hints requires at least Neovim 0.10")
	end
end, {})

-- only useful in neovide or similar
vim.api.nvim_create_user_command("ToggleStream", function()
	vim.o.guifont = "JetBrainsMonoNL\\ Nerd\\ Font\\ Mono:h16"
end, {})

