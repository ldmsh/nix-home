{ config, lib, pkgs, home-manager, options, ... }:

with lib;

let
  mkOptStr = value:
    mkOption {
      type = with types; uniq str;
      default = value;
    };

  # copied from https://github.com/cmacrae/config
  mailAddr = name: domain: "${name}@${domain}";
in {

  options = with types; {
    my = {
      username = mkOptStr "ldnsh";
      name = mkOptStr "Liam Nyhan";
      email = mkOptStr (mailAddr "ldnshy" "gmail.com");
      hostname = mkOptStr "ldnsh-mac";
      gpgKey = mkOptStr "BF2ADAA2A98F45E7";
      homeDirectory = mkOptStr "/Users/ldnsh";
      font = mkOptStr "PragmataPro";
    };
  };
}
