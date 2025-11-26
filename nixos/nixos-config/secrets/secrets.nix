let
  keys = import ../lib/keys.nix;
in
{
  "wg-privatekey.age".publicKeys = keys.ssh.rui-nixos;
  "wg-presharedkey.age".publicKeys = keys.ssh.rui-nixos;
  "cloudflare-token.age".publicKeys = keys.ssh.rui-nixos-pi;
}
