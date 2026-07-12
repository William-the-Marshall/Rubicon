{ config, lib, pkgs, inputs, ... }:

    # Home Rubicon - Jonf
    let
      dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
      create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

        configs = {
          nvim = "nvim";
          niri = "niri";
          kitty = "kitty";
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
      userName = "Jonathon Frye";
      userEmail = "jdfrye96@gmail.com";
    };
    
    programs.noctalia = {
      enable = true;

      systemd = {
        enable = true;
      };

      settings = {
        theme = {
          mode = "dark";
          source = "builtin";
          builtin = "Catppuccin";
        };

         # wallpaper = {
         # enabled = true;
         # default.path = "~/Downloads/";
        #};
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
