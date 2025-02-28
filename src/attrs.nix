{ lib, ... }:
rec {
  filter = lib.filterAttrs;
  filterByName = fn: filter (name: _: fn name);
  filterByValue = fn: filter (_: value: fn value);

  values = lib.attrValues;

  map = lib.mapAttrs';
  entry = lib.nameValuePair;
  mapToValues = builtins.mapAttrs;
}
