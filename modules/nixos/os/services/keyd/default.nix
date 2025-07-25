{...}: {
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
            "a" = "overloadt2(alt, a, ${delay})";
            "s" = "overloadt2(control, r, ${delay})";
            "d" = "overloadt2(shift, s, ${delay})";
            "f" = "overloadt2(meta, t, ${delay})";
            "g" = "g";

            # home row right
            "h" = "m";
            "j" = "overloadt2(meta, n, ${delay})";
            "k" = "overloadt2(shift, e, ${delay})";
            "l" = "overloadt2(control, i, ${delay})";
            ";" = "overloadt2(alt, o, ${delay})";

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
            leftalt = "layer(navigation)";
          };
          navigation = {
            #Home row modifiers
            a = "alt";
            s = "control";
            d = "shift";
            f = "meta";

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
        };
      };
    };
  };
}
