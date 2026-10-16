_: {
  flake.homeModules.aiz = {
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
          diff-editor = ":builtin";
        };
        revset-aliases = {
          "closest_merge(to)" = "heads(::to & merges())";
        };

        aliases = {
          # `jj stack <revset>` to include specific revs
          stack = ["rebase" "--after" "trunk()" "--before" "closest_merge(@)" "--revision"];

          # `jj stage` to include the whole stack after the megamerge
          stage = ["stack" "closest_merge(@)+:: ~ empty()"];

          # `jj restack` to rebase your changes onto `trunk()`
          restack = ["rebase" "--onto" "trunk()" "--source" "roots(trunk()..) & mutable()" "--simplify-parents"];
        };
      };
    };
  };
}
