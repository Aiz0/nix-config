{...}: {
  programs.zed-editor = {
    enable = true;
    installRemoteServer = true;

    userSettings = {
      auto_indent_on_paste = true;
      auto_update = false;
      autosave.after_delay.milliseconds = 1000;

      minimap.show = "auto";
      indent_guides = {
        enabled = true;
        coloring = "indent_aware";
      };

      use_on_type_format = true;
    };
  };
}
