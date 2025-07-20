{
  pkgs,
  lib,
  ...
}: {
  # Waybar configuration for Niri Laptop

  home.packages = with pkgs; [
    blueberry
    bluez
    libnotify
    pwvucontrol
    roboto
    uutils-coreutils-noprefix
  ];

  programs.waybar = {
    enable = false;
    systemd = {
      enable = true;
      enableInspect = true;
    };
    settings = {
      verticalBar = {
        layer = "top";
        output = ["*"];
        position = "left";
        reload_style_on_change = true;

        width = 48;

        modules-left = [];
        modules-center = ["niri/workspaces"];
        modules-right = ["group/hardware" "group/session" "clock"];

        "group/hardware" = {
          modules = ["pulseaudio" "bluetooth" "network" "power-profiles-daemon" "battery"];

          orientation = "inherit";
        };

        "group/session" = {
          modules = ["idle_inhibitor"];
          orientation = "inherit";
        };

        "niri/workspaces" = {
          format = "";
        };

        clock = {
          format = "{:%H\n%M}";
          interval = 60;
          tooltip-format = "{:%Y-%m-%d | %H:%M}";
        };

        battery = let
          checkBattery = pkgs.writeShellApplication {
            name = "check-battery";
            runtimeInputs = [pkgs.uutils-coreutils-noprefix];
            text = builtins.readFile ./scripts/check-battery.sh;
          };
        in {
          format = "{icon}";
          format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];

          #on-update = lib.mkIf (!config.services.batsignal.enable) "${lib.getExe checkBattery}";
          on-update = "${lib.getExe checkBattery}";
          tooltip-format = ''
            {capacity}%: {timeTo}.
            Draw: {power} watts.'';

          states = {critical = 20;};
        };

        idle_inhibitor = {
          format = "{icon}";

          format-icons = {
            activated = "󰅶";
            deactivated = "󰾪";
          };

          timeout = 45;

          tooltip-format-activated = ''
            Presentation mode enabled.
            System will not sleep.'';

          tooltip-format-deactivated = ''
            Presentation mode disabled.
            System will sleep normally.'';
        };

        bluetooth = {
          format = "";
          format-connected = "　{num_connections}";
          format-disabled = ""; # an empty format will hide the module
          on-click = "blueberry";
          tooltip-format = "{controller_alias}	{controller_address}";

          tooltip-format-connected = ''
            {controller_alias}	{controller_address}

            {device_enumerate}'';

          tooltip-format-enumerate-connected = "{device_alias}	{device_address}";
        };
        pulseaudio = {
          format = "{icon}";
          format-bluetooth = "{volume}% {icon}󰂯";
          format-muted = "";

          format-icons = {
            headphones = "󰋋";
            handsfree = "󰋎";
            headset = "󰋎";
            default = ["" "" ""];
          };

          ignored-sinks = ["Easy Effects Sink"];
          on-click = "pwvucontrol";
          #on-click-middle = helpers.volume.micMute;
          #on-click-right = helpers.volume.mute;
          scroll-step = 5;
        };

        network = {
          format-disabled = "󰀝";
          format-disconnected = "󰀦";
          format-ethernet = "󰈀";
          format-linked = "󰈁";
          format-icons = ["󰤟" "󰤢" "󰤥" "󰤨"];
          format-wifi = "{icon}";
          on-click = "networkmanager_dmenu -i";
          tooltip-format = "{ifname} via {gwaddr} 󰊗";
          tooltip-format-disconnected = "Disconnected";
          tooltip-format-ethernet = "{ifname} ";
          tooltip-format-wifi = "{essid} ({signalStrength}%) {icon}";
        };
        power-profiles-daemon = {
          format = "{icon}";

          format-icons = {
            balanced = "󰗑";
            default = "󰗑";
            performance = "󱐌";
            power-saver = "󰌪";
          };

          tooltip-format = ''
            Profile: {profile}
            Driver: {driver}'';

          tooltip = true;
        };
      };
    };
    style = ./style.css;
  };
}
