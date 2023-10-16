return {
	{
		-- Session management
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" } },
    -- stylua: ignore
    keys = {
      { "<leader>sr", function() require("persistence").load() end,                desc = "Restore Session" },
      { "<leader>sl", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>su", function() require("persistence").stop() end,                desc = "Don't Save Current Session" },
    },
	},
}
