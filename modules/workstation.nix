{ config, pkgs, options, ... }:
{
  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';

  environment = {
    pathsToLink = [
      "/share/nix-direnv"
    ];
    homeBinInPath = true;
    systemPackages = with pkgs; [
      kitty
      unstable.wezterm
      libnotify
      pavucontrol
      imv
      nitrogen
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
      fx
      mdcat
      rmlint
      gthumb

      git-trim

      ncspot

      efm-langserver
      nixpkgs-fmt
      yamllint
      vim-vint
      shellcheck
      shfmt
      sumneko-lua-language-server
      stylua
      pandoc

      i3status-rust

      nix-direnv

      alsaUtils

      matcha-gtk-theme
      qogir-icon-theme
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

  security.rtkit.enable = true;

  services = {
    gnome.gnome-keyring.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
  };
}
