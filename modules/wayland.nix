{ config, pkgs, options, lib, ... }:
{
  # remember to load the video card kernel module in hardware-configuration

  hardware.opengl = {
    enable = true;
    driSupport = true;
  };

  # environment.noXlibs = true;

  programs = {
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      wrapperFeatures.base = true;
      extraSessionCommands = ''
        export SDL_VIDEODRIVER=wayland
        export QT_QPA_PLATFORM=wayland
        export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
        export _JAVA_AWT_WM_NONREPARENTING=1
        export MOZ_ENABLE_WAYLAND=1
        export XDG_CURRENT_DESKTOP=sway
        export MOZ_WEBRENDER=1
        export GTK_THEME=Matcha-dark-sea
        export XCURSOR_SIZE=64
        export XCURSOR_THEME=Qogir-dark
        ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface cursor-theme $XCURSOR_THEME
        ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface cursor-size $XCURSOR_SIZE
      '';
      extraPackages = with pkgs; [
        swaylock-fancy
        swayidle
        waybar
        playerctl
        wl-clipboard
        sway-contrib.grimshot
        unstable.swaynotificationcenter #mako
        unstable.rofi-wayland
        wlsunset
        xdg-desktop-portal-wlr
        xdg-desktop-portal
        xdg-desktop-portal-gtk
        xdg_utils
        imv
        kanshi
        firefox-wayland
      ];
    };
  };

  boot.kernelParams = [ "console=tty1" ];
  services.greetd = {
    enable = true;
    vt = 2;
    settings = {
      default_session = {
        command = "${lib.makeBinPath [pkgs.greetd.tuigreet] }/tuigreet --time --cmd sway";
        user = "greeter";
      };
    };
  };
}
