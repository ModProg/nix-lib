{ ... }:
rec {
  push = list: elem: list ++ [ elem ];
  filterMap =
    fn:
    builtins.foldl' [ ] (
      acc: elem:
      let
        value = fn elem;
      in
      if value == null then acc else push acc elem
    );
}
