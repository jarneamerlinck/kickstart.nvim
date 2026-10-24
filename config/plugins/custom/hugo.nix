{ ... }:
{
  # # https://nix-community.github.io/nixvim/plugins/img-clip/index.html
  plugins.img-clip = {
    enable = true;
    settings = {
      default = {
        # Save images in Hugo's static directory
        dir_path = "static/images";

        # Generate unique, timestamped filenames
        file_name = "%Y-%m-%d-%H-%M-%S";

        # Paths in Markdown should be Hugo URLs, not filesystem paths
        relative_to_current_file = false;
        use_absolute_path = false;

        prompt_for_file_name = false;
      };

      filetypes = {
        markdown = {
          # Hugo serves static/images/foo.png at /images/foo.png
          template = "![$LABEL](/images/$FILE_NAME)";
        };
      };
    };
  };
}
