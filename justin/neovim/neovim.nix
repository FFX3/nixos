{ config, pkgs, inputs, ... }:
{
  imports = [
    ./basic-neovim.nix
  ];

  programs.neovim = 
  let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
    keyboardLayout = "COLMAKDH";
    toLuaWithKeyboardSetting = 
      file: toLua "LANGMAP_SETTING = \"${keyboardLayout}\"" + toLuaFile file;
  in
  {
    extraPackages = with pkgs; [
      lua-language-server
      rnix-lsp
    ];

    plugins = with pkgs.vimPlugins; [

      {
        plugin = nvim-lspconfig;
        config = toLuaFile ./nvim/plugin/lsp.lua;
      }

      {
        plugin = nvim-cmp;
        config = toLuaWithKeyboardSetting ./nvim/plugin/cmp.lua;
      }

      cmp-nvim-lsp

      cmp_luasnip

      {
          plugin = luasnip;
          config =  
              toLuaFile ./nvim/plugin/luasnip.lua
              + toLuaFile ./nvim/snippets/all.lua
              + toLuaFile ./nvim/snippets/lua.lua
              + toLuaFile ./nvim/snippets/react.lua;
      }

      neodev-nvim

      {
        plugin = rose-pine;
        config = "colorscheme rose-pine";
      }

      {
          plugin = harpoon;
          # using after/ftplugin Leader a binding gets overwritten otherwise
          # config = toLuaFile ./nvim/plugin/harpoon.lua;
      }

      { 
          plugin = nvim-treesitter.withPlugins (p: [
            p.tree-sitter-nix
            p.tree-sitter-vim
            p.tree-sitter-json
            p.tree-sitter-rust
            p.tree-sitter-scala
            p.tree-sitter-ocaml
            p.tree-sitter-python
            p.tree-sitter-php
            p.tree-sitter-bash
            p.tree-sitter-javascript
            p.tree-sitter-typescript
            p.tree-sitter-lua
          ]);
      }

      undotree

      telescope-nvim
    ];
  };
  
  xdg.configFile = {
    "nvim/after/ftplugin" = {
        source = ./nvim/ftplugin;
        recursive = true;
    };

    "nvim/after/plugin" = {
        source = ./nvim/plugin;
        recursive = true;
    };
  };

}
