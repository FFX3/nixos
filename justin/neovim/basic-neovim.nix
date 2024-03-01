{ config, pkgs, inputs, ... }:
{

  programs.zsh = {
    enable = true;
    shellAliases = {
      qwerty =
        "sed -i s/=\\s\"COLMAKDH\"/=\\s\"QWERTY\"/g /etc/nixos/justin/neovim/basic-neovim.nix && sed -i s/=\\s\"COLMAKDH\"/=\\s\"QWERTY\"/g /etc/nixos/justin/neovim/neovim.nix && hm-switch;";
      colmakdh = 
        "sed -i s/=\\s\"QWERTY\"/=\\s\"COLMAKDH\"/g /etc/nixos/justin/neovim/basic-neovim.nix && sed -i s/=\\s\"QWERTY\"/=\\s\"COLMAKDH\"/g /etc/nixos/justin/neovim/neovim.nix && hm-switch;";
    };
  };

  programs.neovim = 
  let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
    keyboardLayout = "QWERTY";
    toLuaWithKeyboardSetting = 
      file: toLua "LANGMAP_SETTING = \"${keyboardLayout}\"" + toLuaFile file;
    luaKeyboardSetting = "LANGMAP_SETTING = \"${keyboardLayout}\";";
  in
  {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraLuaConfig = ''
      ${luaKeyboardSetting}
      ${builtins.readFile ./nvim/langmaps.lua}
      ${builtins.readFile ./nvim/remaps.lua}
      ${builtins.readFile ./nvim/sets.lua}
    '';


  };

}
