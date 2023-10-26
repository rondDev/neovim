local plugins = {
	{},
}
local config = require("plugins.configs.lazy")

require("lazy").setup(plugins, config.lazy)
