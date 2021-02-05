{ config, pkgs, options, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      tango-icon-theme
      kitty
      libnotify
      theme-vertex
      pavucontrol
      sxiv
      nitrogen
      firefox
      tridactyl-native
      libreoffice
      gimp
      zathura
      mpv
      zotero
      transmission_gtk
      calibre
      nextcloud-client
      gnome3.libsecret

      spotify-tui
      spotifyd

      efm
      nixpkgs-fmt
      yamllint
      vim-vint
      shellcheck
      shfmt
      unstable.sumneko-lua-language-server
      stylua

      i3status-rust

    ] ++ (with nodePackages; [
      vim-language-server
      bash-language-server

    ]);
  };

  fonts = {
    enableFontDir = true;
    fonts = with pkgs; [
      noto-fonts
      gentium
      jetbrains-mono
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
  };

  hardware = {
    pulseaudio = {
      enable = true;
    };
  };

  services = {
    gnome3.gnome-keyring.enable = true;
  };
}
