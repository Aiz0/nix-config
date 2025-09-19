{self, ...}: {
  age.secrets = {
    tailscaleAuthKey.file = "${self.inputs.secrets}/tailscale/auth.age";
    # TODO: move to home or git module when i figure out how to make it work;
    gitWorkConfig = {
      file = "${self.inputs.secrets}/git/workConfig.age";
      path = "/home/aiz/local/config/git/workConfig";
      mode = "777";
      owner = "aiz";
    };
  };
}
