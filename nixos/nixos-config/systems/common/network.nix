{ ... }:
let
  consts = import ../../lib/consts.nix;
in with consts; {
  networking.extraHosts = ''
    ${archIp} rui-arch
    ${piIp} pi
    ${piIp} ha.${homeDomain}
    ${piIp} atuin.${homeDomain}
  '';
}
