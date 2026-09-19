_: {
  flake.homeModules.aizDesktop = {pkgs, ...}: {
    home.packages = [
      pkgs.nil
      pkgs.nerd-fonts.lilex
    ];

    programs.zed-editor = {
      enable = true;

      extensions = [
        "nix"
        "astro"
        "deno"
        "emmet"
        "toml"
        "zed-fish"
        "nu"
        "lua"
      ];

      userSettings = {
        auto_indent_on_paste = true;
        auto_update = false;
        autosave.after_delay.milliseconds = 1000;

        theme = "Ayu Dark";
        terminal.font_family = "Lilex Nerd Font";

        minimap.show = "auto";
        indent_guides = {
          enabled = true;
          coloring = "indent_aware";
        };

        use_on_type_format = true;
        languages = {
          Nix = {
            language_servers = [
              "nil"
              "!nixd"
            ];
            formatter = {
              external = {
                command = "alejandra";
                arguments = ["--quiet" "--"];
              };
            };
          };
        };
        project_panel.dock = "right";

        lsp = {
          nil = {
            settings = {
              nix = {
                flake = {
                  autoArchive = true;
                  autoEvalInputs = true;
                };
              };
            };
          };
        };
      };

      userKeymaps = [
        {
          context = "Workspace";
          bindings = {
            ctrl-shift-e = "workspace::ToggleRightDock";
            ctrl-alt-shift-e = "workspace::ToggleRightDock";
          };
        }
      ];
    };
  };
}
