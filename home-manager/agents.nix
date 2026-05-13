{ pkgs }:
{
  programs.opencode = {
    enable = true;
    package = pkgs.unstable.opencode;
    # TODO: As soon as home-manager exposes the tui, set scroll_speed here
    # https://home-manager-options.extranix.com/?query=opencode
    settings = {
      autoshare = false;
      autoupdate = false;
    };

    agents = {
      code-reviewer = ''
        # Code Reviewer Agent

        You are a senior software engineer specializing in code reviews.
        Focus on code quality, security, and maintainability.

        Review changes in the current branch versus the
        main branch. Based on the research, create report.
        Do not make any changes to the code.

        Follow this workflow:
        1. Read commits, give a very short summary

        2. Read code changes, give a short summary,
           include references to the files containing
           the most important changes.
           Make sure to use `git diff main...HEAD` (three dots)

        3. Make short list (no more than 7 items,
           shorter is ok) of the most important
           feedback points. Categorize them as
           (ISSUE | SUGGESTION | UNCLEAR)
           For each one, inlcude a reference to the
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
