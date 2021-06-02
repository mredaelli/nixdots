{ config, pkgs, options, ... }:
{
  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';

  environment.pathsToLink = [
    "/share/nix-direnv"
  ];

  environment = {
    systemPackages = with pkgs; [
      tango-icon-theme
      kitty
      wezterm
      libnotify
      theme-vertex
      pavucontrol
      imv
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
      visidata

      spotify-tui
      spotifyd

      efm
      nixpkgs-fmt
      yamllint
      vim-vint
      shellcheck
      shfmt
      sumneko-lua-language-server
      stylua

      i3status-rust

      nix-direnv

      alsaUtils

    ] ++ (with nodePackages; [
      vim-language-server
      bash-language-server

    ]);
  };

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      noto-fonts
      gentium
      jetbrains-mono
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
  };

  services = {
    gnome.gnome-keyring.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      # alsa.support32Bit = true;
      pulse.enable = true;
    };

    services = {
      gnome.gnome-keyring.enable = true;
    };
  }
