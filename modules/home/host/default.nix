{ lib, host ? null, format ? "unknown", ... }:

let
  inherit (lib) types;
  inherit (lib.dafos) mkOpt;
in
{
  options.dafos.host = {
    name = mkOpt (types.nullOr types.str) host "The host name.";
  };
}
