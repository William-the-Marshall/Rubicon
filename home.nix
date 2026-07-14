{ config, lib, pkgs, inputs, ... }:

    # Home Rubicon - Jonf
    let
      dotfiles = "${config.home.homeDirectory}/nixos/config";
      create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

        configs = {
          nvim = "nvim";
          niri = "niri";
          kitty = "kitty";
          noctalia = "noctalia";
        };

    in
{
    imports = [ inputs.noctalia.homeModules.default
    ];
    
    home.username = "jonf";
    home.homeDirectory = "/home/jonf";
    home.stateVersion = "26.05";

    programs.home-manager.enable = true;
    
    programs.git = {
      enable = true;
        settings = {
          user = {
            name = "Jonathon Frye";
            email = "jdfrye96@gmail.com";
            };
        };
    };
    
    programs.noctalia = {
      enable = true;
      
      settings = {
      	lib.importTOML = "./config/noctalia/config.toml";
      };
    };
      
    # Home Files
     xdg.configFile = builtins.mapAttrs (name: subpath: {
        source = create_symlink "${dotfiles}/${subpath}";
        recursive = true;
    }) configs;
    
    # Home Packages
    home.packages = with pkgs; [
      neovim
	    ripgrep
	    nil
	    nixpkgs-fmt
	    nodejs
      gcc
    ];

}
