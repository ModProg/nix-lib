{ mpLib, lib, ... }:
let
  inherit (mpLib) not;
  inherit (lib) escapeRegex;
  inherit (builtins) match isNull;
in
{
  startsWith = prefix: string: match "^${escapeRegex prefix}.*" string |> not isNull;
}
