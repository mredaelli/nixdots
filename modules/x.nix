{ config, pkgs, options, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      rofi
      dunst
      flameshot
      firefox
    ];
  };

  services = {
    xserver = {
      enable = true;
      displayManager.defaultSession = "none+i3";
      xkbOptions = "eurosign:e,compose:ralt,terminate:ctrl_alt_bksp,caps:swapescape";
      windowManager.i3.enable = true;

      xautolock = {
        enable = true;
        enableNotifier = true;
        notifier = "${pkgs.libnotify}/bin/notify-send -u critical -t 30000 -- 'LOCKING screen in 30 seconds'";
        notify = 30;
        time = 5;
        extraOptions = [ "-detectsleep" ];
      };
    };
  };
}
