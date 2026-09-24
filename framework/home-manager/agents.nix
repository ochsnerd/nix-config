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

      static-research = ''
        ---
        name: Static Codebase Research
        description: Use this skill when the user asks a question about the current architecture, logic, data flow, or location of components within the codebase. Do NOT use this skill if the user requests code modifications, bug fixes, script execution, or dynamic testing (e.g., "start the app and check X").
        ---

        ## Execution Steps

        1. Identify Core Entities: Extract the specific functions, classes, modules, or patterns mentioned in the user's query.
        2. Search and Traverse (Read-Only): Use file-reading and search tools to locate the relevant code. If the question involves data flow, trace the imports and function calls statically.
        3. Extract Exact References: Note the exact file paths, line numbers, and relevant code blocks that directly answer the query.
        4. Synthesize: Write a clear explanation of how the code works or where it is located, grounding every technical claim in the extracted references.

        ## Constraints & Anti-Patterns

        * Strictly Read-Only: Never use file-writing, file-editing, or patching tools.
        * No Execution: Never run shell commands (other than `grep`/`find`), execute scripts, or start development servers. Rely entirely on static analysis.
        * No Unsubstantiated Claims: Never explain a mechanism without pointing to the exact file and line number that implements it.
        * Avoid Massive Dumps: Do not copy-paste entire files into the final answer. Extract only the specific functions or lines necessary to prove your point.
        * No Hallucinated Paths: If a requested component cannot be found via search, explicitly inform the user it does not exist in the current workspace rather than guessing a standard framework path.

        ## Output Template
        Format your final response to the user using this exact structure:

        **Summary**
        [Provide a concise, direct answer to the user's question in 1-2 paragraphs.]

        **Code References**

        * `path/to/file.ext` (Lines X-Y)
          ```[language]
          [Paste only the most relevant 3-10 lines of code]
          ```
          *Context:* [1-2 sentences explaining how this specific snippet contributes to the answer.]

        * `path/to/second_file.ext` (Lines A-B)
          ```[language]
          [Paste snippet]
          ```
          *Context:* [1-2 sentences explaining context.]
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
