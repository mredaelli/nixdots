{ config, pkgs, options, ... }:
{
  users = {
    extraUsers.turing = {
      isNormalUser = true;
      uid = 1000;
      shell = pkgs.elvish;
      extraGroups = [ "audio" "wheel" "networkmanager" "davfs2" "adbusers" "docker" "scanner" "lp" "sway" "video"];
    };
  };
}
