{ config, pkgs, options, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      blueman
    ];
  };

  hardware = {
    pulseaudio = {
      support32Bit = true;
      package = pkgs.pulseaudioFull;
    };
    opengl.driSupport32Bit = true;
    bluetooth.enable = true;
  };
  services.blueman.enable = true;
}
