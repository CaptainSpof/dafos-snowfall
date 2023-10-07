{ flake-checker, ... }:

_final: prev:
{
  inherit (flake-checker.packages.${prev.system}) flake-checker;
}
