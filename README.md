# Kickstart nvim

Source is [kickstart-nvim](https://github.com/nvim-lua/kickstart.nvim) (but started from [ChrisTitusTech/neovim](https://github.com/ChrisTitusTech/neovim))

Has been converted to nix with the template from [nixCats-nvim](https://github.com/BirdeeHub/nixCats-nvim)

The following features can be needed to run this config:

```bash
experimental-features = nix-command flakes
```

## Run and open nvim

```bash
nix run "github:jarneamerlinck/kickstart.nvim"
```

## Run in shell

```bash
nix shell github:jarneamerlinck/kickstart.nvim
```

## Install on system

```bash
nix profile install github:jarneamerlinck/kickstart.nvim
```
