return {
  {
    "kndndrj/nvim-dbee",
    -- lazy = true,
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    build = function()
      -- Install tries to automatically detect the install method.
      -- if it fails, try calling it with one of these parameters:
      --    "curl", "wget", "bitsadmin", "go"
      require("dbee").install("go")
    end,
    opts = {},
    keys = {
      {
        "<leader>td",
        "<cmd>Dbee toggle<CR>",
        "[T]oggle [D]atabase UI",
      },
    },
  },
  -- {
  -- 	"xemptuous/sqlua.nvim",
  -- 	lazy = true,
  -- 	cmd = "SQLua",
  -- 	config = function()
  -- 		require("sqlua").setup()
  -- 	end,
  -- 	keys = { {
  -- 		"<leader>od",
  -- 		"<cmd>SQLua<CR>",
  -- 		desc = "SQLua",
  -- 	} },
  -- },
  -- {
  -- 	"kristijanhusak/vim-dadbod-ui",
  -- 	dependencies = {
  -- 		{ "tpope/vim-dadbod", lazy = true },
  -- 		{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
  -- 	},
  -- 	cmd = {
  -- 		"DBUI",
  -- 		"DBUIToggle",
  -- 		"DBUIAddConnection",
  -- 		"DBUIFindBuffer",
  -- 	},
  -- 	init = function()
  -- 		-- Your DBUI configuration
  -- 		vim.g.db_ui_use_nerd_fonts = 1
  -- 	end,
  -- },
}
