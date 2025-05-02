{ mod, ... }:
let
  inherit (builtins) isFunction;
  strings = mod ./strings.nix;
  attrs = mod ./attrs.nix;
  lists = mod ./lists.nix;
  nix = mod ./nix.nix;
in
rec {
  inherit strings attrs;
  inherit (strings) startsWith;
  not = a: if isFunction a then (b: not (a b)) else !a;
  notNull = not isNull;
  equals = a: b: a == b;
}
