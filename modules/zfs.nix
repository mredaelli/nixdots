{ config, pkgs, options, ... }:
{
  boot.supportedFilesystems = [ "zfs" ];
  boot.initrd.supportedFilesystems = [ "zfs" ];
  services.zfs = {
    autoScrub.enable = true;
    trim.enable = true;
  };
}
