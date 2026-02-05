# kickstart.nixvim

## Introduction

This repo contains my personal neovim config.


This first started as a [kickstart-nvim](https://github.com/nvim-lua/kickstart.nvim) (from [ChrisTitusTech/neovim](https://github.com/ChrisTitusTech/neovim)) project.
Then has been converted to nix with the template from [nixCats-nvim](https://github.com/BirdeeHub/nixCats-nvim).

As nixCats-nvim has been archived I moved to nixvim.

I archived the nixCats repo and went with a fork from [JMartJonesy/kickstart.nixvim](https://github.com/JMartJonesy/kickstart.nixvim). This will help to include future updates.

Major extra features compared to JMartJonesy repo:

- Stylix included
- Added plugins
- Personal keybinds


# Installation

If not using standalone setup this installation process assumes you understand the basics of importing and adding dependencies to your .nix configuration files.

## Install External Dependencies

- Clipboard tool (xclip/xsel/win32yank or other depending on platform)
- A [Nerd Font](https://www.nerdfonts.com/): optional, provides various icons
  - if you have it set `enable_nerd_fonts` in `nixvim.nix` to true

## Overview

You can use this repo in four ways:

| Use Case         | Method                                                                 |
|------------------|------------------------------------------------------------------------|
| Standalone Neovim| Run a bundled Neovim executable with kickstart.nixvim config, no setup |
| NixOS Module     | System-level integration on NixOS                                      |
| Home Manager     | User-level integration on any OS using Home Manager                    |
| nix-darwin       | User-level integration on macOS using nix-darwin                       |

---
## Use-cases

### 1. Standalone Usage (No Configuration Files Needed)

Run instantly without modifying any user or system configuration:
```nix
nix run github:jarneamerlinck/kickstart.nvim -- <FILE>
```
Or build your own runnable nvim that can be reused
```nix
nix build github:jarneamerlinck/kickstart.nvim
./result/bin/nvim <FILE>
```

### 2. NixOS Module
1. Add kickstart.nixvim to your `flake.nix`:
```nix
inputs.kickstart-nixvim.url = "github:jarneamerlinck/kickstart.nvim";
```
2. Import the nixosModules in your `configuration.nix`:
```nix
{
  imports = [
    inputs.kickstart-nixvim.nixosModules.default
  ];

  programs.nixvim.enable = true;
}
```

### (Optional) NixOS Module with stylix
1. Add kickstart.nixvim to your `flake.nix`:
```nix
inputs.kickstart-nixvim.url = "github:jarneamerlinck/kickstart.nvim";
```
2. Import the nixosModules in your `configuration.nix`:
```nix
{
  imports = [
    inputs.kickstart-nixvim.nixosModules.default
  ];

  programs.nixvim.enable = true;
}
```

### 3. Home Manager Module
1. Add kickstart.nixvim to your `flake.nix`:
```nix
inputs.kickstart-nixvim.url = "github:jarneamerlinck/kickstart.nvim";
```
2. Import the homeManagerModules in your `home.nix`:
```nix
{
  imports = [
    inputs.kickstart-nixvim.homeManagerModules.default
  ];

  programs.nixvim.enable = true;
}
```

### (Optional) Home Manager Module with stylix
1. Add kickstart.nixvim to your `flake.nix`:
```nix
inputs.kickstart-nixvim.url = "github:jarneamerlinck/kickstart.nvim";
```
2. Import the homeManagerModules in your `home.nix`:
```nix
{
  inputs,
  config,
  pkgs,
  ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) system;
  nixvim-package = inputs.nixvim-config.packages.${system}.default;
  extended-nixvim = nixvim-package.extend config.stylix.targets.nixvim.exportedModule;
in
{
  home.packages = [ extended-nixvim ];
}
```

### 4. nix-darwin Module (macOS)
1. Add kickstart.nxivim to your `flake.nix`:
```nix
inputs.kickstart-nixvim.url = "github:jarneamerlinck/kickstart.nvim";
```
2. Import the darwinModules in your `darwin-configuration.nix`:
```nix
{
  imports = [
    inputs.kickstart-nixvim.darwinModules.default
  ];

  programs.nixvim.enable = true;
}
```
## Local configuration

>**NOTE**
> Backup your previous configuration (if any exists)
> This can be found on Linux under the path `$XDG_CONFIG_HOME/nvim` or `~/.config/nvim`

1. [Fork](https://docs.github.com/en/get-started/quickstart/fork-a-repo) this repo
so that you have your own copy that you can update and version control.
2. Clone kickstart.nixvim
    * If you created your own fork
      ```sh
      cd ~
      git clone https://github.com/<YOUR-GITHUB-USERNAME>/kickstart.nixvim.git
      ```
3. a. If you are using kickstart.nixvim with your own flake then update your flake.nix to refer to your local kickstart.nixvim repo
```nix
inputs.kickstart-nixvim.url = "path:<PATH_TO>/kickstart.nixvim";
```
3. b. Or if you are running kickstart.nixvim standalone run in your cloned repo directory
Note: For quick testing you can add any custom nixvim configurations into `/config/default.nix`
```nix
nix build .
./result/bin/nvim
```
4. a. If you are using kickstart.nixvim with your own flake confirm the `init.lua` file has been created and loads without errors
```sh
nvim ~/.config/nvim/init.lua
```

# FAQ

* What should I do if I already have a pre-existing neovim configuration?
  * You should back it up and then delete all associated files.
  * This includes your existing init.lua and the neovim files in `~/.local`
    which can be deleted with `rm -rf ~/.local/share/nvim/`
* Can I keep my existing configuration in parallel to kickstart.nixvim?
  * Yes! You can use [NVIM_APPNAME](https://neovim.io/doc/user/starting.html#%24NVIM_APPNAME)`=nvim-NAME`
    to maintain multiple configurations. For example, move your old configuration to
    `~/.config/nvim-backup` and create an alias:
    ```
    alias nvim-backup='NVIM_APPNAME="nvim-backup" nvim'
    ```
    When you run Neovim using `nvim-backup` alias it will use the alternative
    config directory and the matching local directory
    `~/.local/share/nvim-backup`.
* What if I want to "uninstall" kickstart.nixvim:
   1. Remove kickstart-nixvim from your `flake.nix` and the module imports from you `configuration.nix`, `home.nix`, or `darwin-configuration.nix`
   2. Remove the kickstart.nixvim directory `rm -r ~/<PATH_TO>/kickstart.nixvim`
   3. Remove any .local nvim files `rm -rf ~/.local/share/nvim/`
   4. **Optional:** Move your previously backed up lua configuration files to `$XDG_CONFIG_HOME/nvim` or `~/.config/nvim`
   5. Rebuild your NixOS configuration `nixos-rebuild switch`


## Stylix


Stylix support has been added and has the following features

- fallback theme is tokyonight Dark
- Stylix can be included from home manager (or nixos config: Did not try this one)
