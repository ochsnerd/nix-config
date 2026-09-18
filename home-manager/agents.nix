{ pkgs, ... }: {
  programs.opencode = {
    enable = true;
    package = pkgs.opencode;

    settings = {
      autoshare = false;
      autoupdate = false;
    };

    tui = {
      scroll_speed = 0.5;
    };

    skills = {
      code-review = ''
        ---
        name: code-review
        description: Review code changes
        ---

        You are a senior software engineer specializing in code reviews.
        Focus on code quality, security, and maintainability.

        Unless specified otherwise, review changes in the
        current branch versus the main branch.

        Make sure to use `git diff main...HEAD` (three dots)

        Based on the review, create a report.

        Do not make any changes to the code.

        Follow this workflow:
        1. Read commits, give a very short summary

        2. Read code changes, give a short summary,
           include references to the files containing
           the most important changes.

        3. Make short list (no more than 7 items,
           shorter is ok) of the most important
           feedback points.
           For each item, include a reference (<file>:<line>)to the
           code and a short explanation of the issue.
      '';
    };
  };

  # see also fish.nix cudos-claude
  programs.claude-code = {
    enable = true;
    package = pkgs.unstable.claude-code;
    # as of 05.26, this creates md files instead of dirs containing md files,
    # which does not work for current claude-code version
    skills = { };
  };
}
