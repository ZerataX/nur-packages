# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage

{ pkgs ? import <nixpkgs> { } }:

rec {
  # The `lib`, `modules`, and `overlay` names are special
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

 
  # applications
  matrix-registration = pkgs.callPackage ./pkgs/matrix-registration { };

  mirage-im = pkgs.libsForQt5.callPackage ./pkgs/mirage { inherit python3Packages; };

  # games
  srb2 = pkgs.callPackage ./pkgs/srb2 { };

  # python modules
  python3Packages = pkgs.python3Packages //pkgs.recurseIntoAttrs (
    pkgs.callPackage ./pkgs/development/python-modules { }
  );

  # bukkit/spigot/paper minecraft server plugins
  bukkitPlugins = pkgs.recurseIntoAttrs (
    pkgs.callPackage ./pkgs/bukkit-plugins { }
  );

  # vscode-extensions
  vscode-extensions = pkgs.recurseIntoAttrs (pkgs.callPackage ./pkgs/vscode-extensions {});
}
