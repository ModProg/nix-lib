# Partial implementation of a nix evaluator in nix.
# https://nix.dev/manual/nix/2.25/language/
{ lib, mpLib, ... }:
let
  inherit (mpLib) startsWith not notNull;
in
{
  eval = string: {

  };
  tokenize =
    src:
    let
      todo = token: throw "Unimplemented token ${token}";
      recTokenize =
        src:
        let
          rest = "TODO";
          t = regex: builtins.match "^(${regex}).*" src;
          whiteSpace = t "[[:space:]]+";
          # regex sources https://nix.dev/manual/nix/2.25/language/string-literals
          stringStart = t "\"";
          multiLineStringStart = t "'";
          uri = t "[A-Za-z][+\\-.0-9A-Za-z]*:[!$%&'*+,\\-./0-9:=?@A-Z_a-z~]+";
          comment = t "#[^\\r\\n]*\r?\n";
          # 1: value 3: exponent
          float = t "([[:digit::]]\\.[[:digit:]]*|\\.[[:digit:]]+)(e(-?[[:digit:]]+))?";
          int = t "[[:digit::]]*[^.]";
          pathStart = t "(\\.|~)?/";
          listStart = t "\[";
          attrsetStart = t "\{";
          # 1: token span
          recStart = t "(rec)([^-_'[:alnum:]]|$)";
          type =
            if notNull stringStart then
              todo "string"
            else if notNull multiLineStringStart then
              todo "multi-line-string"
            else if notNull uri then
              throw "URI literals are not supported, use string literals instead"
            else if notNull comment then
              todo "comment"
            else if notNull float then
              todo "float" # builtins.fromJSON prefixed with `0`
            else if notNull int then
              todo "int" # builtins.fromJSON
            else if notNull pathStart then
              throw "path literals are not supported, use string literals instead"
            else if notNull recStart then
              throw "recursive attrsets are not supported"
            else if builtins.match "^[[:alpha:]_]" src |> not isNull then
              # This is probably not excaustive but should catch most usages
              "ident"
            else
              "TODO";
        in
        [ nextToken ] ++ recTokenize rest;
    in
    recTokenize src;
}
