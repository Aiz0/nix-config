{
  config,
  lib,
  ...
}: {
  options.myHome.aiz.programs.zed-editor.enable = lib.mkEnableOption "zed editor";

  config = lib.mkIf config.myHome.aiz.programs.zed-editor.enable {
    programs.zed-editor = {
      enable = true;
      installRemoteServer = true;

      userSettings = {
        auto_indent_on_paste = true;
        auto_update = false;
        autosave.after_delay.milliseconds = 1000;

        theme = "Ayu Dark";

        minimap.show = "auto";
        indent_guides = {
          enabled = true;
          coloring = "indent_aware";
        };

        use_on_type_format = true;
      };
    };
  };
}
