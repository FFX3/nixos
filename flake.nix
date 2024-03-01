{

  description = ".dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
  };

outputs = { self, nixpkgs, home-manager, ...}@inputs:

  let 
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    pkgs = nixpkgs.legacyPackages.${system};
    users = [ 
      "justin" 
    ];
  in 

  {

    nixosConfigurations = {
      nixos-vm = lib.nixosSystem {
        inherit system;
	specialArgs = {
	  inherit users;
	};
        modules = [ 
          ./configuration.nix 
        ];
      };
    };

    homeConfigurations = builtins.listToAttrs (builtins.map (user: { name = user;
      value = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          ./${user}/home.nix 
          {

	    programs.zsh = {
	      enable = true;
	      autocd = true;
	      shellAliases = {
	        hm-switch = "home-manager switch --flake /etc/nixos";
          };
	    };

            home = {

              stateVersion = "23.11";
              username = "${user}";
              homeDirectory = if user == "root" then "/root/" else /home/${user};
              packages = with pkgs; [
                neofetch
              ];

            };

          }
        ];
      };
    }) (users ++ [ "root" ]));

  };

}
