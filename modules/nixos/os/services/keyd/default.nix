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
            #Home row modifiers
            a = "overloadt2(alt, a, ${delay})";
            s = "overloadt2(control, s, ${delay})";
            d = "overloadt2(shift, d, ${delay})";
            f = "overloadt2(meta, f, ${delay})";

            j = "overloadt2(meta, j, ${delay})";
            k = "overloadt2(shift, k, ${delay})";
            l = "overloadt2(control, l, ${delay})";
            semicolon = "overloadt2(alt, semicolon, ${delay})";

            capslock = "overload(control, esc)";
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
