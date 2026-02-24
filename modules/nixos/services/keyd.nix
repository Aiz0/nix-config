{
  config,
  lib,
  ...
}: {
  options.myNixOS.keyd.enable = lib.mkOption {
    default = false;
    description = "Enable keyd service for colemak layout with home row modifiers";
    type = lib.types.bool;
  };

  config = lib.mkIf config.myNixOS.keyd.enable {
    services.keyd = {
      enable = true;
      keyboards = {
        default = {
          ids = ["*"];
          settings = {
            main = let
              delay = "200";
            in {
              # top row left
              "q" = "q";
              "w" = "w";
              "e" = "f";
              "r" = "p";
              "t" = "b";
              # top row right
              "y" = "j";
              "u" = "l";
              "i" = "u";
              "o" = "y";
              "p" = ";";
              # home row left
              "a" = "overloadi(a, overloadt2(alt, a, ${delay}), 150)";
              "s" = "overloadi(r, overloadt2(control, r, ${delay}), 150)";
              "d" = "overloadi(s, overloadt2(shift, s, ${delay}), 150)";
              "f" = "overloadi(t, overloadt2(meta, t, ${delay}), 150)";
              "g" = "g";

              # home row right
              "h" = "m";
              "j" = "overloadi(n, overloadt2(meta, n, ${delay}), 150)";
              "k" = "overloadi(e, overloadt2(shift, e, ${delay}), 150)";
              "l" = "overloadi(i, overloadt2(control, i, ${delay}), 150)";
              ";" = "overloadi(o, overloadt2(alt, o, ${delay}), 150)";

              # bottom row left
              "102nd" = "z"; # < character
              "z" = "x";
              "x" = "c";
              "c" = "d";
              "v" = "v";
              "b" = "z"; # extra key
              # bottom row right
              "n" = "k";
              "m" = "h";
              "," = ",";
              "." = ".";
              "/" = "/";

              "]" = "]";
              "'" = "'";
              "[" = "[";

              "capslock" = "backspace";

              # thumb keys
              leftalt = "overloadt2(special, tab, ${delay})";
              space = "overloadt2(navigation, space, ${delay})";

              rightalt = "overloadt2(symbol, enter, ${delay})";
              rightcontrol = "overloadt2(symbol, backspace, ${delay})";
            };
            navigation = {
              #Home row modifiers
              a = "layer(alt)";
              s = "layer(control)";
              d = "layer(shift)";
              f = "layer(meta)";

              # vi style navigation
              h = "left";
              j = "down";
              k = "up";
              l = "right";
              # extra navigation
              u = "pagedown";
              i = "pageup";
              y = "home";
              o = "end";
            };

            symbol = {
              # top row left
              "q" = "'";
              "w" = "<";
              "e" = ">";
              "r" = "\"";
              "t" = ".";
              # top row right
              "y" = "&";
              "u" = ";";
              "i" = "[";
              "o" = "]";
              "p" = "%";

              # home row left
              "a" = "!";
              "s" = "-";
              "d" = "+";
              "f" = "=";
              "g" = "#";

              # home row right
              "h" = "|";
              "j" = ":";
              "k" = "(";
              "l" = ")";
              ";" = "`";

              # bottom row left
              "102nd" = "^";
              "z" = "/";
              "x" = "*";
              "c" = "\\";
              "v" = "";
              "b" = "^";
              # bottom row right
              "n" = "~";
              "m" = "$";
              "," = "{";
              "." = "}";
              "/" = "@";
            };

            special = {
              j = "G-w";
              k = "G-a";
              l = "G-o";
            };
          };
        };
      };
    };
  };
}
