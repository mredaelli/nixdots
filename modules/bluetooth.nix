{ config, pkgs, options, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      blueman
    ];
  };

  hardware = {
    opengl.driSupport32Bit = true;
    bluetooth.enable = true;
  };

  services = {
    blueman.enable = true;
    pipewire.media-session.config.bluez-monitor.rules = [
        {
          matches = [{ "device.name" = "~bluez_card.*"; }];
          actions = {
            "update-props" = {
              "bluez5.msbc-support" = true;
              "bluez5.sbc-xq-support" = true;
              "bluez5.autoswitch-profile" = true;
            };
          };
        }
      ];
    };
}
