{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.myHome.profiles.defaultApps;
  mimeTypes = import ./mimeTypes.nix;
in {
  options.myHome.profiles.defaultApps = {
    enable = lib.mkEnableOption "enforce default applications";
    forceMimeAssociations = lib.mkEnableOption "force mime associations for defaultApps";

    audioPlayer = {
      package = lib.mkOption {
        type = lib.types.package;
        default = pkgs.mpv;
        description = "The default audio player package.";
      };

      exec = lib.mkOption {
        type = lib.types.str;
        default = lib.getExe cfg.audioPlayer.package;
        description = "The executable path for the default audio player.";
      };
    };

    editor = {
      package = lib.mkOption {
        type = lib.types.package;
        default = pkgs.zed-editor;
        description = "The default text editor package.";
      };

      exec = lib.mkOption {
        type = lib.types.str;
        default = lib.getExe cfg.editor.package;
        description = "The executable path for the default text editor.";
      };
    };

    fileManager = {
      package = lib.mkOption {
        type = lib.types.package;
        default = pkgs.kdePackages.dolphin;
        description = "The default file manager package.";
      };

      exec = lib.mkOption {
        type = lib.types.str;
        default =
          if cfg.fileManager.package == pkgs.kdePackages.dolphin
          then lib.getExe' cfg.fileManager.package "dolphin"
          else lib.getExe cfg.fileManager.package;
        description = "The executable path for the default file manager.";
      };
    };

    imageViewer = {
      package = lib.mkOption {
        type = lib.types.package;
        default = pkgs.oculante;
        description = "The default image viewer package.";
      };

      exec = lib.mkOption {
        type = lib.types.str;
        default = lib.getExe cfg.imageViewer.package;
        description = "The executable path for the default image viewer.";
      };
    };

    pdfViewer = {
      package = lib.mkOption {
        type = lib.types.package;
        default = pkgs.papers;
        description = "The default PDF viewer package.";
      };

      exec = lib.mkOption {
        type = lib.types.str;
        default = lib.getExe cfg.pdfViewer.package;
        description = "The executable path for the default PDF viewer.";
      };
    };

    terminal = {
      package = lib.mkOption {
        type = lib.types.package;
        default = pkgs.ghostty;
        description = "The default terminal emulator package.";
      };

      exec = lib.mkOption {
        type = lib.types.str;
        default = lib.getExe cfg.terminal.package;
        description = "The executable path for the default terminal emulator.";
      };
    };

    terminalEditor = {
      package = lib.mkOption {
        type = lib.types.package;
        default = pkgs.helix;
        description = "The default terminal text editor package.";
      };

      exec = lib.mkOption {
        type = lib.types.str;
        default = lib.getExe cfg.terminalEditor.package;
        description = "The executable path for the default terminal text editor.";
      };
    };

    videoPlayer = {
      package = lib.mkOption {
        type = lib.types.package;
        default = pkgs.mpv;
        description = "The default video player package.";
      };

      exec = lib.mkOption {
        type = lib.types.str;
        default = lib.getExe cfg.videoPlayer.package;
        description = "The executable path for the default video player.";
      };
    };

    webBrowser = {
      package = lib.mkOption {
        type = lib.types.package;
        default = config.programs.zen-browser.finalPackage;
        description = "The default web browser package.";
      };

      exec = lib.mkOption {
        type = lib.types.str;
        default = lib.getExe config.programs.zen-browser.finalPackage;
        description = "The executable path for the default web browser.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = with cfg; [
        audioPlayer.package
        editor.package
        fileManager.package
        imageViewer.package
        pdfViewer.package
        terminal.package
        terminalEditor.package
        videoPlayer.package
        webBrowser.package
      ];

      sessionVariables = {
        BROWSER = "${builtins.baseNameOf cfg.webBrowser.exec}";
        EDITOR = "${builtins.baseNameOf cfg.terminalEditor.exec}";
        TERMINAL = "${builtins.baseNameOf cfg.terminal.exec}";
      };
    };

    xdg = {
      mimeApps = lib.mkIf cfg.forceMimeAssociations {
        enable = true;

        defaultApplications = let
          mkDefaults = files: desktopFile: lib.genAttrs files (_: [desktopFile]);
          audioTypes =
            mkDefaults mimeTypes.audioFiles
            "defaultAudioPlayer.desktop";

          browserTypes =
            mkDefaults mimeTypes.browserFiles
            "defaultWebBrowser.desktop";

          documentTypes =
            mkDefaults mimeTypes.documentFiles
            "defaultPdfViewer.desktop";

          editorTypes =
            mkDefaults mimeTypes.editorFiles
            "defaultEditor.desktop";

          folderTypes = {"inode/directory" = "defaultFileManager.desktop";};

          imageTypes =
            mkDefaults mimeTypes.imageFiles
            "defaultImageViewer.desktop";

          videoTypes =
            mkDefaults mimeTypes.videoFiles
            "defaultVideoPlayer.desktop";
        in
          audioTypes
          // browserTypes
          // documentTypes
          // editorTypes
          // folderTypes
          // imageTypes
          // videoTypes;
      };

      desktopEntries = let
        mkDefaultEntry = name: exec: {
          exec = "${exec} %U";
          icon = "${builtins.baseNameOf exec}";
          name = "Default ${name}";
          terminal = false;

          settings = {
            NoDisplay = "true";
          };
        };
      in
        lib.mkIf cfg.forceMimeAssociations {
          defaultAudioPlayer = mkDefaultEntry "Audio Player" cfg.audioPlayer.exec;
          defaultEditor = mkDefaultEntry "Editor" cfg.editor.exec;
          defaultFileManager = mkDefaultEntry "File Manager" cfg.fileManager.exec;
          defaultImageViewer = mkDefaultEntry "Image Viewer" cfg.imageViewer.exec;
          defaultPdfViewer = mkDefaultEntry "PDF Viewer" cfg.pdfViewer.exec;
          defaultVideoPlayer = mkDefaultEntry "Video Player" cfg.videoPlayer.exec;
          defaultWebBrowser = mkDefaultEntry "Web Browser" cfg.webBrowser.exec;
        };
    };
  };
}
