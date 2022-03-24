{ config, pkgs, options, lib, ... }:
{
  services.udev.extraRules = ''
    SUBSYSTEM=="power_supply", ATTR{status}=="Discharging", ATTR{capacity}=="[0-5]", RUN+="/run/current-system/systemd/bin/systemctl suspend"
  '';
}
