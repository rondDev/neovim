local opt = vim.opt

-- Enable relative line numbers
opt.nu = true
opt.rnu = true

-- Set tabs to 2 spaces
opt.tabstop = 2
opt.softtabstop = 2
opt.expandtab = true

-- Enable auto indenting and set it to spaces
opt.smartindent = true
opt.shiftwidth = 2

opt.breakindent = true -- Enable smart indenting (see https://stackoverflow.com/questions/1204149/smart-wrap-in-vim)

-- Enable incremental searching
opt.incsearch = true
opt.hlsearch = true

opt.wrap = false -- Disable text wrap

-- Set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better splitting
opt.splitbelow = true
opt.splitright = true

opt.mouse = "a" -- Enable mouse mode

-- Enable ignorecase + smartcase for better searching
opt.ignorecase = true
opt.smartcase = true

opt.updatetime = 50 -- Decrease updatetime to 200ms

opt.completeopt = { "menuone", "noselect" } -- Set completeopt to have a better completion experience

opt.undofile = true -- Enable persistent undo history

opt.termguicolors = true -- Enable 24-bit color

opt.signcolumn = "yes" -- Enable the sign column to prevent the screen from jumping

opt.clipboard = "unnamed,unnamedplus" -- Enable access to System Clipboard

opt.cursorline = true -- Enable cursor line highlight

-- Set fold settings
-- These options were reccommended by nvim-ufo
-- See: https://github.com/kevinhwang91/nvim-ufo#minimal-configuration
opt.foldcolumn = "0"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

opt.scrolloff = 8 -- Always keep 8 lines above/below cursor unless at start/end of file

opt.colorcolumn = "80" -- Place a column line

-- GUI stuff
vim.o.guifont = "JetBrainsMonoNL\\ Nerd\\ Font\\ Mono:h11"

-- Set theme and background color
-- vim.cmd.colorscheme("oxocarbon")
opt.background = "dark"

opt.cmdheight = 1

vim.g.instant_username = "rond"
opt.autoread = true
opt.confirm = true
opt.fileformat = "unix"
opt.showmode = false
opt.shell = "nu.exe"
