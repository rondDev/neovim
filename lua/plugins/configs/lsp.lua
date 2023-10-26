local M = {}

local function bind(op, outer_opts)
	outer_opts = vim.tbl_extend("force", { noremap = true, silent = true }, outer_opts or {})

	return function(lhs, rhs, opts)
		opts = vim.tbl_extend("force", outer_opts, opts or {})
		vim.keymap.set(op, lhs, rhs, opts)
	end
end

M.map = bind("")
M.nmap = bind("n", { noremap = false })
M.nnoremap = bind("n")
M.vnoremap = bind("v")
M.xnoremap = bind("x")
M.inoremap = bind("i")
M.tnoremap = bind("t")

M.map_lsp_keybinds = function(buffer_number)
	M.nnoremap("<leader>rn", vim.lsp.buf.rename, { desc = "LSP: [R]e[n]ame", buffer = buffer_number })
	M.nnoremap("<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: [C]ode [A]ction", buffer = buffer_number })

	M.nnoremap("gd", vim.lsp.buf.definition, { desc = "LSP: [G]oto [D]efinition", buffer = buffer_number })

	-- Telescope LSP keybinds --
	M.nnoremap(
		"gr",
		require("telescope.builtin").lsp_references,
		{ desc = "LSP: [G]oto [R]eferences", buffer = buffer_number }
	)

	M.nnoremap(
		"gi",
		require("telescope.builtin").lsp_implementations,
		{ desc = "LSP: [G]oto [I]mplementation", buffer = buffer_number }
	)

	M.nnoremap(
		"<leader>bs",
		require("telescope.builtin").lsp_document_symbols,
		{ desc = "LSP: [B]uffer [S]ymbols", buffer = buffer_number }
	)

	M.nnoremap(
		"<leader>ps",
		require("telescope.builtin").lsp_workspace_symbols,
		{ desc = "LSP: [P]roject [S]ymbols", buffer = buffer_number }
	)

	-- See `:help K` for why this keymap
	M.nnoremap("K", vim.lsp.buf.hover, { desc = "LSP: Hover Documentation", buffer = buffer_number })
	M.nnoremap(
		"<leader>k",
		vim.lsp.buf.signature_help,
		{ desc = "LSP: Signature Documentation", buffer = buffer_number }
	)
	M.inoremap("<C-k>", vim.lsp.buf.signature_help, { desc = "LSP: Signature Documentation", buffer = buffer_number })

	-- Lesser used LSP functionality
	M.nnoremap("gD", vim.lsp.buf.declaration, { desc = "LSP: [G]oto [D]eclaration", buffer = buffer_number })
	M.nnoremap("td", vim.lsp.buf.type_definition, { desc = "LSP: [T]ype [D]efinition", buffer = buffer_number })
end

M.setup = function()
	local null_ls = require("null-ls")

	-- Use neodev to configure lua_ls in nvim directories - must load before lspconfig
	require("neodev").setup()

	-- Setup mason so it can manage 3rd party LSP servers
	require("mason").setup({
		ui = {
			border = "rounded",
		},
	})

	-- Configure mason to auto install servers
	require("mason-lspconfig").setup({
		automatic_installation = { exclude = { "ocamllsp" } },
		ensure_installed = {
			"bashls",
			"biome",
			"cssls",
			"graphql",
			"html",
			"jsonls",
			"lua_ls",
			"marksman",
			"prismals",
			"pyright",
			"rust_analyzer",
			"solidity",
			"sqlls",
			"svelte",
			"tailwindcss",
			"tsserver",
			"yamlls",
			"zls",
		},
	})

	-- require("lsp_lines").setup()

	-- Override tsserver diagnostics to filter out specific messages
	local messages_to_filter = {
		"This may be converted to an async function.",
		"'_Assertion' is declared but never used.",
		"'__Assertion' is declared but never used.",
		"The signature '(data: string): string' of 'atob' is deprecated.",
		"The signature '(data: string): string' of 'btoa' is deprecated.",
	}

	local function tsserver_on_publish_diagnostics_override(_, result, ctx, config)
		local filtered_diagnostics = {}

		for _, diagnostic in ipairs(result.diagnostics) do
			local found = false
			for _, message in ipairs(messages_to_filter) do
				if diagnostic.message == message then
					found = true
					break
				end
			end
			if not found then
				table.insert(filtered_diagnostics, diagnostic)
			end
		end

		result.diagnostics = filtered_diagnostics

		vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
	end

	-- LSP servers to install (see list here: https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers )
	local servers = {
		bashls = {},
		biome = {},
		clangd = {},
		cssls = {},
		graphql = {},
		html = {},
		jsonls = {},
		lua_ls = {
			settings = {
				Lua = {
					workspace = {
						checkThirdParty = false,
						telemetry = false,
					},
					hint = {
						enable = true,
					},
				},
			},
		},
		marksman = {},
		-- ocamllsp = {},
		prismals = {},
		pyright = {},
		rust_analyzer = {},
		solidity = {},
		sqlls = {},
		svelte = {
			settings = {
				enable_ts_plugin = true,
			},
		},
		tailwindcss = {},
		tsserver = {
			settings = {
				experimental = {
					enableProjectDiagnostics = true,
				},
			},
			handlers = {
				["textDocument/publishDiagnostics"] = vim.lsp.with(tsserver_on_publish_diagnostics_override, {}),
			},
		},
		yamlls = {},
		zls = {},
	}

	-- Default handlers for LSP
	local default_handlers = {
		["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
		["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
	}

	-- nvim-cmp supports additional completion capabilities
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	local default_capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

	local on_attach = function(_, buffer_number)
		-- Pass the current buffer to map lsp keybinds
		M.map_lsp_keybinds(buffer_number)

		-- Create a command `:Format` local to the LSP buffer
		vim.api.nvim_buf_create_user_command(buffer_number, "Format", function(_)
			vim.lsp.buf.format({
				filter = function(format_client)
					-- Use Prettier to format TS/JS if it's available
					return format_client.name ~= "tsserver" or not null_ls.is_registered("prettier")
				end,
			})
		end, { desc = "LSP: Format current buffer with LSP" })

		-- if client.server_capabilities.codeLensProvider then
		-- 	vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "CursorHold" }, {
		-- 		buffer = buffer_number,
		-- 		callback = vim.lsp.codelens.refresh,
		-- 		desc = "LSP: Refresh code lens",
		-- 		group = vim.api.nvim_create_augroup("codelens", { clear = true }),
		-- 	})
		-- end
	end

	-- Iterate over our servers and set them up
	for name, config in pairs(servers) do
		require("lspconfig")[name].setup({
			on_attach = on_attach,
			capabilities = default_capabilities,
			settings = config.settings,
			handlers = vim.tbl_deep_extend("force", {}, default_handlers, config.handlers or {}),
		})
	end

	-- Congifure LSP linting, formatting, diagnostics, and code actions
	local formatting = null_ls.builtins.formatting
	local diagnostics = null_ls.builtins.diagnostics
	local code_actions = null_ls.builtins.code_actions

	null_ls.setup({
		border = "rounded",
		sources = {
			-- formatting
			formatting.prettier,
			formatting.stylua,
			-- formatting.ocamlformat,

			-- diagnostics
			diagnostics.eslint_d.with({
				condition = function(utils)
					return utils.root_has_file({ ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.json" })
				end,
			}),

			-- code actions
			code_actions.eslint_d.with({
				condition = function(utils)
					return utils.root_has_file({ ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.json" })
				end,
			}),
		},
	})

	-- Configure borderd for LspInfo ui
	require("lspconfig.ui.windows").default_options.border = "rounded"

	-- Configure diagostics border
	vim.diagnostic.config({
		-- virtual_text = false,
		float = {
			border = "rounded",
		},
	})
end

return M
