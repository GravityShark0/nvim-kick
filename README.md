# nvim-kick

## my own neovim config from kickstart

> its pratically done ngl
> i just edit ensure.lua and add new none-ls and other stuff for new languages
> nvim-dap is very interesting though

#### install

- on Linux and Mac

```bash
git clone https://github.com/GravityShark0/nvim-kick.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

then do this or just run nvim by itself

```bash
nvim --headless "+Lazy! sync" +a
```

- on Windows

```bash
git clone https://github.com/nvim-lua/kickstart.nvim.git %userprofile%\AppData\Local\nvim\
```

#### uninstall

- Linux / Macos (unix)

```bash
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
```

- Windows

```bash
rd -r ~\AppData\Local\nvim
rd -r ~\AppData\Local\nvim-data
```

### plugins to look into

- [ ] noice, notify
  - [ ] dressing.nvim
- [ ] nvim-dap
- [ ] none-ls/ linting, format
- [ ] navic / barbeque
- [ ] nvim-treesitter-textobjects
- [ ] under mini.comments. nvim-ts-context-commentstring
- [x] neoconf (i dont think i need this)
- [x] terminal in neovim
- [ ] [hydra.nvim](https://github.com/anuvyklack/hydra.nvim) is very interesting
- [ ] ("eandrju/cellular-automaton.nvim") fun

#### mini.nvim

- [ ] mini.base16 -- coolors
  - [ ] mini.colors
  - [ ] mini.hues
- [ ] mini.bracketed -- better bracket movement
- [x] mini.cursorword -- lighter vim-illuminate
- [ ] mini.files -- like a netrw
- [ ] mini.jump2d -- adds labels, kinda like how qutebrowser does it
- [ ] mini.move -- like that one ThePrimeagen keybinding with autoindenting selection
- [ ] mini.sessions -- persistence.nvim
- [ ] mini.starter or alpha-nvim -starting tihg
- [ ] mini.splitjoin -- cool way of like splitting lines like
  > but basically anything from https://www.lazyvim.org/plugins/ or lunarvim

### TODO

- [ ] a option to set for like 'lite' and 'full' graphics
- [ ] and also have mini.colors/base16 easy otions
  - [ ] setup highlighting to be better but thats like on the colors part idk
  - [ ] and have it use telescope as a selector of themes like nvchad
- [ ] maybe replace like the mini.clue with which-key or another whichkey cause mini.clue is very limited
- [ ] make nvim-lsp lighter and faster (probably can never change)
- [x] get html lsp to work
- [ ] setup treesitter keybindings and such
  - [ ] nvim-treesitter/nvim-treesitter-context
  - [ ] nvim-treesitter/playground
  - [ ] instead of harpoon have a function tha like lists the buffers in order and allows me to like do <a-1> to <a-9> and select that buffer in my tabline

### also remember [neovide](https://neovide.dev/)

### Shitty idea

- what if i make a neovim distro purely made to be mouse and input mode only
  - sounds stupid but there is a lack of extremely lightweight (i. e. cli/tui) text editors out there that have good functionality
  - and its made for people who wont even learn vim motions but be able to use its amazing ecosystem - im gonna name it devil.nvim or like good.nvim - or like neo as in taking the vim out of neovim

> Nows the rest of the uneditted readme

# kickstart.nvim

https://github.com/kdheepak/kickstart.nvim/assets/1813121/f3ff9a2b-c31f-44df-a4fa-8a0d7b17cf7b

### Introduction

A starting point for Neovim that is:

- Small
- Single-file (with examples of moving to multi-file)
- Documented
- Modular

This repo is meant to be used by **YOU** to begin your Neovim journey; remove the things you don't use and add what you miss.

Kickstart.nvim targets _only_ the latest ['stable'](https://github.com/neovim/neovim/releases/tag/stable) and latest ['nightly'](https://github.com/neovim/neovim/releases/tag/nightly) of Neovim. If you are experiencing issues, please make sure you have the latest versions.

Distribution Alternatives:

- [LazyVim](https://www.lazyvim.org/): A delightful distribution maintained by @folke (the author of lazy.nvim, the package manager used here)

### Installation

> **NOTE**
> [Backup](#FAQ) your previous configuration (if any exists)

Requirements:

- Make sure to review the readmes of the plugins if you are experiencing errors. In particular:
  - [ripgrep](https://github.com/BurntSushi/ripgrep#installation) is required for multiple [telescope](https://github.com/nvim-telescope/telescope.nvim#suggested-dependencies) pickers.
- See [Windows Installation](#Windows-Installation) if you have trouble with `telescope-fzf-native`

Neovim's configurations are located under the following paths, depending on your OS:

| OS      | PATH                                      |
| :------ | :---------------------------------------- |
| Linux   | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim` |
| MacOS   | `$XDG_CONFIG_HOME/nvim`, '~/.config/nvim` |
| Windows | `%userprofile%\AppData\Local\nvim\`       |

Clone kickstart.nvim:

```sh
# on Linux and Mac
git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim && nvim--headless "+Lazy! sync" +a
```

```
# on Windows
git clone https://github.com/nvim-lua/kickstart.nvim.git %userprofile%\AppData\Local\nvim\
```

### Post Installation

Run the following command and then **you are ready to go**!

```sh
nvim --headless "+Lazy! sync" +qa
```

### Recommended Steps

[Fork](https://docs.github.com/en/get-started/quickstart/fork-a-repo) this repo (so that you have your own copy that you can modify) and then installing you can install to your machine using the methods above.

> **NOTE**  
> Your fork's url will be something like this: `https://github.com/<your_github_username>/kickstart.nvim.git`

### Configuration And Extension

- Inside of your copy, feel free to modify any file you like! It's your copy!
- Feel free to change any of the default options in `init.lua` to better suit your needs.
- For adding plugins, there are 3 primary options:
  - Add new configuration in `lua/custom/plugins/*` files, which will be auto sourced using `lazy.nvim` (uncomment the line importing the `custom/plugins` directory in the `init.lua` file to enable this)
  - Modify `init.lua` with additional plugins.
  - Include the `lua/kickstart/plugins/*` files in your configuration.

You can also merge updates/changes from the repo back into your fork, to keep up-to-date with any changes for the default configuration.

#### Example: Adding an autopairs plugin

In the file: `lua/custom/plugins/autopairs.lua`, add:

```lua
-- File: lua/custom/plugins/autopairs.lua

return {
  "windwp/nvim-autopairs",
  -- Optional dependency
  dependencies = { 'hrsh7th/nvim-cmp' },
  config = function()
    require("nvim-autopairs").setup {}
    -- If you want to automatically add `(` after selecting a function or method
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    local cmp = require('cmp')
    cmp.event:on(
      'confirm_done',
      cmp_autopairs.on_confirm_done()
    )
  end,
}
```

This will automatically install [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs) and enable it on startup. For more information, see documentation for [lazy.nvim](https://github.com/folke/lazy.nvim).

#### Example: Adding a file tree plugin

In the file: `lua/custom/plugins/filetree.lua`, add:

```lua
-- Unless you are still migrating, remove the deprecated commands from v1.x
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  config = function ()
    require('neo-tree').setup {}
  end,
}
```

This will install the tree plugin and add the command `:Neotree` for you. You can explore the documentation at [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) for more information.

### Contribution

Pull-requests are welcome. The goal of this repo is not to create a Neovim configuration framework, but to offer a starting template that shows, by example, available features in Neovim. Some things that will not be included:

- Custom language server configuration (null-ls templates)
- Theming beyond a default colorscheme necessary for LSP highlight groups

Each PR, especially those which increase the line count, should have a description as to why the PR is necessary.

### FAQ

- What should I do if I already have a pre-existing neovim configuration?
  - You should back it up, then delete all files associated with it.
  - This includes your existing init.lua and the neovim files in `~/.local` which can be deleted with `rm -rf ~/.local/share/nvim/`
  - You may also want to look at the [migration guide for lazy.nvim](https://github.com/folke/lazy.nvim#-migration-guide)
- What if I want to "uninstall" this configuration:
  - See [lazy.nvim uninstall](https://github.com/folke/lazy.nvim#-uninstalling) information
- Are there any cool videos about this plugin?
  - Current iteration of kickstart (coming soon)
  - Here is one about the previous iteration of kickstart: [video introduction to Kickstart.nvim](https://youtu.be/stqUbv-5u2s). Note the install via init.lua no longer works as specified. Please follow the install instructions in this file instead as they're up to date.

### Windows Installation

Installation may require installing build tools, and updating the run command for `telescope-fzf-native`

See `telescope-fzf-native` documentation for [more details](https://github.com/nvim-telescope/telescope-fzf-native.nvim#installation)

This requires:

- Install CMake, and the Microsoft C++ Build Tools on Windows

```lua
{'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
```
