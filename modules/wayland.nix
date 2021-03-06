{ config, pkgs, options, ... }:
{
  # remember to load the video card kernel module in hardware-configuration

  hardware.opengl = {
    enable = true;
    driSupport = true;
  };

  programs = {
    adb.enable = true;
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      extraSessionCommands = ''
        export QT_QPA_PLATFORM=wayland
        export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
        export _JAVA_AWT_WM_NONREPARENTING=1
        export MOZ_ENABLE_WAYLAND=1
        export XDG_CURRENT_DESKTOP=sway
      '';
      extraPackages = with pkgs; [
        swaylock-fancy
        swayidle
        wl-clipboard
        sway-contrib.grimshot
        mako
        wofi
        xdg-desktop-portal-wlr
        xdg-desktop-portal
        xdg_utils
      ];
    };
  };
}
