{ pkgs, ... }:
{
  # Linting
  # https://nix-community.github.io/nixvim/plugins/lint/index.html

  extraPackages = with pkgs; [
    markdownlint-cli
    hadolint
  ];
  plugins.lint = {
    enable = true;

    # NOTE: Enabling these will cause errors unless these tools are installed
    lintersByFt = {
      nix = [ "nix" ];
      markdown = [
        "markdownlint"
        # "vale"
      ];
      #clojure = ["clj-kondo"];
      dockerfile = [ "hadolint" ];
      #inko = ["inko"];
      #janet = ["janet"];
      # json = [ "jq" ];
      #rst = ["vale"];
      #ruby = ["ruby"];
      #terraform = ["tflint"];
      #text = ["vale"];
    };
    linters = {
      jq = {
        cmd = "jq";
        stdin = true;
        args = [ "." ];
        stream = "stderr";
        ignore_exitcode = false;
        parser = ''
          function(output, bufnr)
            if output == "" then
              return {}
            end

            return {{
              lnum = 1,
              col = 1,
              message = output,
              severity = vim.diagnostic.severity.ERROR,
              source = "jq",
            }}
          end
        '';
      };
    };
    # Create autocommand which carries out the actual linting
    # on the specified events.
    autoCmd = {
      callback.__raw = ''
        function()
          -- Only run the linter in buffers that you can modify in order to
          -- avoid superfluous noise, notably within the handy LSP pop-ups that
          -- describe the hovered symbol using Markdown.
          if vim.opt_local.modifiable:get() then
            require('lint').try_lint()
          end
        end
      '';
      group = "lint";
      event = [
        "BufEnter"
        "BufWritePost"
        "InsertLeave"
      ];
    };
  };

  # https://nix-community.github.io/nixvim/NeovimOptions/autoGroups/index.html
  autoGroups = {
    lint = {
      clear = true;
    };
  };
}
