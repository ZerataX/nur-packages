{ systemConfig, lib, pkgs, ... }:
with lib;
types.submodule ({ config, ... }:
  let
    settingsFormat = pkgs.formats.yaml { };
  in
  {
    options = rec {
      package = mkOption {
        type = types.nullOr types.package;
        example = "pkgs.bukkit-plugins.harbor";
        description = ''
          The package for the plugin.
        '';
      };

      settings = mkOption rec {
        type = types.attrsOf settingsFormat.type;
        default = null;
        example = literalExample ''
          {
            "config.yaml" = {
              blacklist = [
                "world_nether"
                "world_the_end"
              ]
            }
          };
        '';
        description = ''
          Configuration files for plugin
        '';
      };

      prepareScript = mkOption {
        type = types.str;
        default = "";
        description = ''
          Script that prepares the plugin.
        '';
      };
    };
  })
