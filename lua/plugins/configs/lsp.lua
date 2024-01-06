local Utils = require("core.utils")

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
      { "folke/neodev.nvim",  opts = {} },
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",

      -- "nvimtools/none-ls.nvim",

      -- "nvim-lua/plenary.nvim",

      -- Progress/Status update for LSP
      -- {
      -- 	"j-hui/fidget.nvim",
      -- 	tag = "legacy",
      --
      -- 	config = function()
      -- 		-- Turn on LSP, formatting, and linting status and progress information
      -- 		require("fidget").setup({
      -- 			text = {
      -- 				spinner = "dots_negative",
      -- 			},
      -- 		})
      -- 	end,
      -- },
    },
    --@class PluginLspOpts
    opts = {

      diagnostics = {
        globals = { "vim" },
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
          -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
          -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
          -- prefix = "icons",
        },
        severity_sort = true,
      },
      inlay_hints = {
        enabled = false,
      },
      capabilities = {},
      format = {},
      servers = {
        bashls = {},
        biome = {},
        clangd = {},
        cssls = {},
        gopls = {},
        graphql = {},
        html = {},
        jsonls = {},

        lua_ls = {
          -- mason = false, -- set to false if you don't want this server to be installed with mason
          -- Use this to add any additional keymaps
          -- for specific lsp servers
          ---@type LazyKeysSpec[]
          -- keys = {},
          settings = {
            Lua = {
              workspace = {
                library = {
                  [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                },
                checkThirdParty = false,
                telemetry = false,
              },
              completion = {
                callSnippet = "Replace",
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
          handlers = {},
        },
        yamlls = {},
        zls = {},
      },
      setup = {

      },
    },
    config = function(_, opts)
      if Utils.has("neoconf.nvim") then
        local plugin = require("lazy.core.config").spec.plugins["neoconf.nvim"]
        require("neoconf").setup(require("lazy.core.plugin").values(plugin, "opts", false))
      end

      -- Utils.format

      if opts.autoformat ~= nil then
        vim.g.autoformat = opts.autoformat
        Utils.deprecate("nvim-lspconfig.opts.autoformat", "vim.g.autoformat")
      end

      Utils.on_attach(function(client, buffer)
        require("plugins.lsp.lsp_keymaps").on_attach(client, buffer)
        vim.api.nvim_buf_create_user_command(buffer, "Format", function(_)
          vim.lsp.buf.format({
          })
        end, { desc = "LSP: Format current buffer with LSP" })
      end)

      local register_capability = vim.lsp.handlers["client/registerCapability"]

      vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
        local ret = register_capability(err, res, ctx)
        local client_id = ctx.client_id
        ---@type lsp.Client
        local client = vim.lsp.get_client_by_id(client_id)
        local buffer = vim.api.nvim_get_current_buf()
        require("plugins.lsp.lsp_keymaps").on_attach(client, buffer)
        return ret
      end

      -- diagnostics
      for name, icon in pairs(require("core.config").icons.diagnostics) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      end

      if opts.inlay_hints.enabled then
        Utils.on_attach(function(client, buffer)
          if client.supports_method("textDocument/inlayHint") then
            Utils.inlay_hints(buffer, true)
          end
        end)
      end

      if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
        opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
            or function(diagnostic)
              local icons = require("core.config").icons.diagnostics
              for d, icon in pairs(icons) do
                if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
                  return icon
                end
              end
            end
      end

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      local servers = opts.servers
      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        opts.capabilities or {}
      )

      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup["*"] then
          if opts.setup["*"](server, server_opts) then
            return
          end
        end
        require("lspconfig")[server].setup(server_opts)
      end

      -- get all the servers that are available through mason-lspconfig
      local have_mason, mlsp = pcall(require, "mason-lspconfig")
      local all_mslp_servers = {}
      if have_mason then
        all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
      end

      local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
          if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end

      if have_mason then
        mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
      end
    end,
  },

  {

    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
        -- "flake8",
      },
    },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      mr:on("package:install:success", function()
        vim.defer_fn(function()
          -- trigger FileType event to possibly load this newly installed LSP server
          require("lazy.core.handler.event").trigger({
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },
}

-- M.setup = function()
--   -- local null_ls = require("null-ls")
--
--   -- Use neodev to configure lua_ls in nvim directories - must load before lspconfig
--   require("neodev").setup()
--
--   -- Setup mason so it can manage 3rd party LSP servers
--   require("mason").setup({
--     ui = {
--       border = "rounded",
--     },
--   })
--
--   -- Configure mason to auto install servers
--   require("mason-lspconfig").setup({
--     automatic_installation = { exclude = { "ocamllsp" } },
--     ensure_installed = {
--       "bashls",
--       "biome",
--       "cssls",
--       "gopls",
--       "graphql",
--       "html",
--       "jsonls",
--       "lua_ls",
--       "marksman",
--       "prismals",
--       "pyright",
--       "rust_analyzer",
--       "solidity",
--       "sqlls",
--       "svelte",
--       "tailwindcss",
--       "tsserver",
--       "yamlls",
--       "zls",
--     },
--   })
--
--   -- LSP servers to install (see list here: https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers )
--   local servers = {
--   }
--
--   -- Default handlers for LSP
--   local default_handlers = {
--     ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
--     ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
--   }
--
--   -- nvim-cmp supports additional completion capabilities
--   local capabilities = vim.lsp.protocol.make_client_capabilities()
--   local default_capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
--
--   local on_attach = function(_, buffer_number)
--     -- Pass the current buffer to map lsp keybinds
--     M.map_lsp_keybinds(buffer_number)
--
--     -- Create a command `:Format` local to the LSP buffer
--     vim.api.nvim_buf_create_user_command(buffer_number, "Format", function(_)
--       vim.lsp.buf.format({
--         -- filter = function(format_client)
--         -- -- Use Prettier to format TS/JS if it's available
--         -- return format_client.name ~= "tsserver" or not null_ls.is_registered("prettier")
--         -- end,
--       })
--     end, { desc = "LSP: Format current buffer with LSP" })
--
--     -- if client.server_capabilities.codeLensProvider then
--     -- 	vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "CursorHold" }, {
--     -- 		buffer = buffer_number,
--     -- 		callback = vim.lsp.codelens.refresh,
--     -- 		desc = "LSP: Refresh code lens",
--     -- 		group = vim.api.nvim_create_augroup("codelens", { clear = true }),
--     -- 	})
--     -- end
--   end
--
--   -- Iterate over our servers and set them up
--   for name, config in pairs(servers) do
--     require("lspconfig")[name].setup({
--       on_attach = on_attach,
--       capabilities = default_capabilities,
--       settings = config.settings,
--       handlers = vim.tbl_deep_extend("force", {}, default_handlers, config.handlers or {}),
--     })
--   end
--
--   -- Congifure LSP linting, formatting, diagnostics, and code actions
--   -- local formatting = null_ls.builtins.formatting
--   -- local diagnostics = null_ls.builtins.diagnostics
--   -- local code_actions = null_ls.builtins.code_actions
--
--   -- null_ls.setup({
--   -- 	border = "rounded",
--   -- 	sources = {
--   -- 		-- formatting
--   -- 		formatting.biome,
--   -- 		-- formatting.prettier,
--   -- 		formatting.stylua,
--   -- 		-- formatting.ocamlformat,
--   --
--   -- 		-- diagnostics
--   -- 		diagnostics.eslint_d.with({
--   -- 			condition = function(utils)
--   -- 				return utils.root_has_file({ ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.json" })
--   -- 			end,
--   -- 		}),
--   --
--   -- 		-- code actions
--   -- 		code_actions.eslint_d.with({
--   -- 			condition = function(utils)
--   -- 				return utils.root_has_file({ ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.json" })
--   -- 			end,
--   -- 		}),
--   -- 	},
--   -- })
--
--   -- Configure borderd for LspInfo ui
--   require("lspconfig.ui.windows").default_options.border = "rounded"
--
--   -- Configure diagostics border
--   vim.diagnostic.config({
--     -- virtual_text = false,
--     float = {
--       border = "rounded",
--     },
--   })
-- end
--
-- return M
