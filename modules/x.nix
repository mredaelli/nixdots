{ config, pkgs, options, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      tango-icon-theme
      kitty
      libnotify
      rofi
      dunst
      theme-vertex
      networkmanagerapplet
      pavucontrol
      volumeicon
      flameshot
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
    ];
  };

  fonts = {
    enableFontDir = true;
    fonts = with pkgs; [
      noto-fonts
      gentium
      jetbrains-mono
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      # mredaelli.fontin
      # mredaelli.fontin-sans
    ];
  };

  hardware = {
    pulseaudio = {
      enable = true;
    };
  };

  services = {

    gnome3.gnome-keyring.enable = true;
    xserver = {
      enable = true;
      #xkbVariant = "colemak";
      xkbOptions = "eurosign:e,compose:ralt,terminate:ctrl_alt_bksp,caps:swapescape";
      windowManager.i3 = {
        enable = true;
        extraSessionCommands = ''
          xmodmap -e "keycode 117 = Prior"
          xmodmap -e "keycode 112 = Next"
        '';
      };

      xautolock = {
        enable = true;
        enableNotifier = true;
        locker = "/home/turing/bin/fuzzy_lock.sh";
        notifier = "${pkgs.libnotify}/bin/notify-send -u critical -t 30000 -- 'LOCKING screen in 30 seconds'";
        notify = 30;
        time = 5;
        extraOptions = [ "-detectsleep" ];
      };

      libinput.enable = true;
    };
  };
}
