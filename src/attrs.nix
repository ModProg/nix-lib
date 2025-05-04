{ lib, ... }:
rec {
  filter = lib.filterAttrs;
  filterByName = fn: filter (name: _: fn name);
  filterByValue = fn: filter (_: value: fn value);

  names = lib.attrNames;
  values = lib.attrValues;

  map = lib.mapAttrs';
  entry = lib.nameValuePair;
  mapToValues = builtins.mapAttrs;

  hasKey = lib.hasAttr;
  hasKey' = attrs: key: lib.hasAttr key attrs;

  getOptional = key: attrs: if hasKey key attrs then attrs.${key} else null;
  getOptional' = attrs: key: getOptional key attrs;
}
