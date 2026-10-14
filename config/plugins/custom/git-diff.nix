{
  ...
}:
{
  extraConfigLua = ''
    function git_branch_diff()
      local current_branch = vim.fn.system(
        { "git", "branch", "--show-current" }
      ):gsub("%s+", "")

      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")
      local pickers = require("telescope.pickers")
      local finders = require("telescope.finders")
      local conf = require("telescope.config").values
      local previewers = require("telescope.previewers")

      local function select_branch(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)

        if not selection then
          return
        end

        local branch = selection.value

        local files = vim.fn.systemlist({
          "git",
          "diff",
          "--name-only",
          current_branch .. "..." .. branch,
        })

        if vim.v.shell_error ~= 0 then
          vim.notify("Failed to get changed files", vim.log.levels.ERROR)
          return
        end

        pickers.new({}, {
          prompt_title = "Git Diff: " .. current_branch .. " vs " .. branch,

          finder = finders.new_table({
            results = files,
            entry_maker = function(file)
              return {
                value = file,
                display = file,
                ordinal = file,
              }
            end,
          }),

          sorter = conf.generic_sorter({}),

          previewer = previewers.new_buffer_previewer({
            title = "Branch Diff",
            define_preview = function(self, entry)
              local file = entry.value

              local diff = vim.fn.systemlist({
                "git",
                "--no-pager",
                "diff",
                "--no-ext-diff",
                "--color=never",
                current_branch .. "..." .. branch,
                "--",
                file,
              })

              vim.api.nvim_buf_set_lines(
                self.state.bufnr,
                0,
                -1,
                false,
                diff
              )

              vim.bo[self.state.bufnr].filetype = "diff"
            end,
          }),

          layout_strategy = "horizontal",
          layout_config = {
            width = 0.95,
            height = 0.90,
            preview_width = 0.65,
          },

          attach_mappings = function(_, map)
            local function open_diff(file_bufnr)
              local file = action_state.get_selected_entry()
              actions.close(file_bufnr)

              if not file then
                return
              end

              local diff = vim.fn.systemlist({
                "git",
                "--no-pager",
                "diff",
                "--no-ext-diff",
                "--color=never",
                current_branch .. "..." .. branch,
                "--",
                file.value,
              })

              vim.cmd("tabnew")
              vim.bo.buftype = "nofile"
              vim.bo.bufhidden = "wipe"
              vim.bo.swapfile = false
              vim.api.nvim_buf_set_lines(0, 0, -1, false, diff)
              vim.bo.filetype = "diff"
              vim.bo.modifiable = false
            end

            map("i", "<CR>", open_diff)
            map("n", "<CR>", open_diff)

            return true
          end,
        }):find()
      end

      require("telescope.builtin").git_branches({
        prompt_title = "Select branch to compare",
        attach_mappings = function(_, map)
          map("i", "<CR>", select_branch)
          map("n", "<CR>", select_branch)
          return true
        end,
      })
    end

    vim.api.nvim_create_user_command("GitBranchDiff", git_branch_diff, {})
  '';
}
