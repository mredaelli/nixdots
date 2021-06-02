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
  services.blueman.enable = true;
}
