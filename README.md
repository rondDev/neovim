# neovim/

<a href="https://dotfyle.com/rondDev/neovim"><img src="https://dotfyle.com/rondDev/neovim/badges/plugins?style=flat" /></a>
<a href="https://dotfyle.com/rondDev/neovim"><img src="https://dotfyle.com/rondDev/neovim/badges/leaderkey?style=flat" /></a>
<a href="https://dotfyle.com/rondDev/neovim"><img src="https://dotfyle.com/rondDev/neovim/badges/plugin-manager?style=flat" /></a>

## Install Instructions

> Install requires Neovim 0.9+. Always review the code before installing a configuration.

Clone the repository and install the plugins:

```sh
git clone git@github.com:rondDev/neovim ~/.config/rondDev/neovim
NVIM_APPNAME=rondDev/neovim/ nvim --headless +"Lazy! sync" +qa
```

Open Neovim with this config:

```sh
NVIM_APPNAME=rondDev/neovim/ nvim
```

## Plugins

### color

- [folke/twilight.nvim](https://dotfyle.com/plugins/folke/twilight.nvim)

### colorscheme

- [nyoom-engineering/oxocarbon.nvim](https://dotfyle.com/plugins/nyoom-engineering/oxocarbon.nvim)

### command-line

- [gelguy/wilder.nvim](https://dotfyle.com/plugins/gelguy/wilder.nvim)

### comment

- [numToStr/Comment.nvim](https://dotfyle.com/plugins/numToStr/Comment.nvim)
- [JoosepAlviste/nvim-ts-context-commentstring](https://dotfyle.com/plugins/JoosepAlviste/nvim-ts-context-commentstring)

### completion

- [simrat39/rust-tools.nvim](https://dotfyle.com/plugins/simrat39/rust-tools.nvim)
- [hrsh7th/nvim-cmp](https://dotfyle.com/plugins/hrsh7th/nvim-cmp)

### cursorline

- [RRethy/vim-illuminate](https://dotfyle.com/plugins/RRethy/vim-illuminate)

### debugging

- [mfussenegger/nvim-dap](https://dotfyle.com/plugins/mfussenegger/nvim-dap)

### editing-support

- [windwp/nvim-autopairs](https://dotfyle.com/plugins/windwp/nvim-autopairs)
- [windwp/nvim-ts-autotag](https://dotfyle.com/plugins/windwp/nvim-ts-autotag)

### file-explorer

- [stevearc/oil.nvim](https://dotfyle.com/plugins/stevearc/oil.nvim)
- [nvim-neo-tree/neo-tree.nvim](https://dotfyle.com/plugins/nvim-neo-tree/neo-tree.nvim)

### fuzzy-finder

- [ibhagwan/fzf-lua](https://dotfyle.com/plugins/ibhagwan/fzf-lua)
- [nvim-telescope/telescope.nvim](https://dotfyle.com/plugins/nvim-telescope/telescope.nvim)

### git

- [lewis6991/gitsigns.nvim](https://dotfyle.com/plugins/lewis6991/gitsigns.nvim)
- [NeogitOrg/neogit](https://dotfyle.com/plugins/NeogitOrg/neogit)
- [f-person/git-blame.nvim](https://dotfyle.com/plugins/f-person/git-blame.nvim)
- [sindrets/diffview.nvim](https://dotfyle.com/plugins/sindrets/diffview.nvim)

### indent

- [lukas-reineke/indent-blankline.nvim](https://dotfyle.com/plugins/lukas-reineke/indent-blankline.nvim)

### keybinding

- [max397574/better-escape.nvim](https://dotfyle.com/plugins/max397574/better-escape.nvim)
- [folke/which-key.nvim](https://dotfyle.com/plugins/folke/which-key.nvim)

### lsp

- [simrat39/symbols-outline.nvim](https://dotfyle.com/plugins/simrat39/symbols-outline.nvim)
- [onsails/lspkind.nvim](https://dotfyle.com/plugins/onsails/lspkind.nvim)
- [jose-elias-alvarez/null-ls.nvim](https://dotfyle.com/plugins/jose-elias-alvarez/null-ls.nvim)
- [neovim/nvim-lspconfig](https://dotfyle.com/plugins/neovim/nvim-lspconfig)
- [j-hui/fidget.nvim](https://dotfyle.com/plugins/j-hui/fidget.nvim)

### lsp-installer

- [williamboman/mason.nvim](https://dotfyle.com/plugins/williamboman/mason.nvim)

### marks

- [ThePrimeagen/harpoon](https://dotfyle.com/plugins/ThePrimeagen/harpoon)

### note-taking

- [nvim-neorg/neorg](https://dotfyle.com/plugins/nvim-neorg/neorg)

### nvim-dev

- [folke/neodev.nvim](https://dotfyle.com/plugins/folke/neodev.nvim)
- [MunifTanjim/nui.nvim](https://dotfyle.com/plugins/MunifTanjim/nui.nvim)
- [nvim-lua/plenary.nvim](https://dotfyle.com/plugins/nvim-lua/plenary.nvim)

### plugin-manager

- [folke/lazy.nvim](https://dotfyle.com/plugins/folke/lazy.nvim)

### programming-languages-support

- [dmmulroy/tsc.nvim](https://dotfyle.com/plugins/dmmulroy/tsc.nvim)

### snippet

- [L3MON4D3/LuaSnip](https://dotfyle.com/plugins/L3MON4D3/LuaSnip)

### statusline

- [nvim-lualine/lualine.nvim](https://dotfyle.com/plugins/nvim-lualine/lualine.nvim)
- [b0o/incline.nvim](https://dotfyle.com/plugins/b0o/incline.nvim)

### syntax

- [nvim-treesitter/nvim-treesitter-textobjects](https://dotfyle.com/plugins/nvim-treesitter/nvim-treesitter-textobjects)
- [nvim-treesitter/nvim-treesitter](https://dotfyle.com/plugins/nvim-treesitter/nvim-treesitter)

### tabline

- [romgrk/barbar.nvim](https://dotfyle.com/plugins/romgrk/barbar.nvim)

### terminal-integration

- [samjwill/nvim-unception](https://dotfyle.com/plugins/samjwill/nvim-unception)
- [numToStr/FTerm.nvim](https://dotfyle.com/plugins/numToStr/FTerm.nvim)

### utility

- [folke/noice.nvim](https://dotfyle.com/plugins/folke/noice.nvim)
- [rcarriga/nvim-notify](https://dotfyle.com/plugins/rcarriga/nvim-notify)
- [stevearc/dressing.nvim](https://dotfyle.com/plugins/stevearc/dressing.nvim)
- [kevinhwang91/nvim-ufo](https://dotfyle.com/plugins/kevinhwang91/nvim-ufo)

## Language Servers

- bashls
- cssls
- eslint
- graphql
- html
- jsonls
- lua_ls
- marksman
- ocamllsp
- prismals
- pyright
- rust_analyzer
- solidity
- sqlls
- svelte
- tailwindcss
- tsserver
- yamlls
- zls

This readme was generated by [Dotfyle](https://dotfyle.com)
