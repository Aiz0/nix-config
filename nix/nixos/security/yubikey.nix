# https://github.com/joinemm/nix-infra/blob/master/modules/yubikey.nix
# https://joinemm.dev/blog/yubikey-nixos-guide
_: {
  flake.nixosModules.default = {
    pkgs,
    lib,
    config,
    ...
  }: {
    options = {
      myNixOS.profiles.yubikey = {
        owner = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = "aiz";
          description = "owner of the yubikey";
        };
      };
    };
    config = {
      assertions = [
        {
          assertion = config.myNixOS.profiles.yubikey.owner != null;
          message = "config.myNixOS.profiles.yubikey.owner cannot be null.";
        }
      ];

      services = {
        pcscd.enable = true;
        udev.packages = [pkgs.yubikey-personalization];
      };

      security.pam = {
        u2f = {
          enable = true;
          settings = {
            cue = true;
            cue_prompt = " Touch the Yubikey to continue...";
            interactive = false;
            origin = "pam://yubi";

            # generated with pamu2fcfg -n -o pam://yubi
            authfile = pkgs.writeText "u2f-mappings" (
              lib.concatStrings [
                config.myNixOS.profiles.yubikey.owner
                ":HAFjwUB8XxjhoTPemSWnpyjXBPRrHtvb0/T33MpyauOqF8Y6bhfqgOpTLn7yz2Jsw67UT46iZzTZEteGcMtcjg==,le2ejODZxKJSwiYt2FqCT8aRN4x0/YL7XLe3bXoWgdRTxjbeZ8vdJEDSDkMkGMtk4KueLuVV0C2ulmm8K5L8cA==,es256,+presence" # keychain
                ":dnxSh3IQkJ1jTrv+La7jdMm42Q1gewao6DngmIG0eXyJMnKV72RjCI+18AtH+xC8LOEYIhQB2Vh57gTUEWFw+Q==,CPK7cAgQxGMqx610fEo7/KA8TQW8l8YoIwkUndp2wndMxODnsMBB3Y3kruv3+PgEHzDJOEM5CaWAcUv1Y1x1eA==,es256,+presence" # backup
              ]
            );
          };
        };

        services = {
          sudo.u2fAuth = true;
          login.u2fAuth = true;
        };
      };

      environment.systemPackages = with pkgs; [
        yubikey-manager # provides ykman
        cryptsetup
      ];
    };
  };
}
