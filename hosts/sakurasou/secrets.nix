{self, ...}: {
  age.secrets = {
    tailscaleAuthKey.file = "${self.inputs.secrets}/tailscale/auth.age";
    tailscaleCaddyAuthKey.file = "${self.inputs.secrets}/tailscale/caddyAuth.age";
  };
}
