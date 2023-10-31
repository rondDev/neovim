require("core")
require("core.utils").load_mappings()

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local hotpotpath = vim.fn.stdpath("data") .. "/lazy/hotpot.nvim"

-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
	require("core.bootstrap").lazy(lazypath)
end

if not vim.loop.fs_stat(hotpotpath) then
	require("core.bootstrap").fennel(hotpotpath)
end


-- dofile(vim.g.base46_cache .. "defaults")
vim.opt.rtp:prepend({hotpotpath, lazypath})
require("plugins")
