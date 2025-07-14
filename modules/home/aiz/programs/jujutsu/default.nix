{...}: {
  programs.jujutsu = {
    enable = true;

    settings = {
      user = {
        name = "Aiz";
        email = "dev@aiz.moe";
      };
      ui = {
        pager = "less -FRX";
        default-command = "st";
      };
    };
  };
}
