{
  ...
}:
{
  # https://nix-community.github.io/nixvim/plugins/snacks/index.html
  plugins.snacks = {
    enable = true;
  };
  extraConfigLua = ''
    local function devenv_tasks()
    	local result = vim.system({
    		"sh",
    		"-c",
    		"devenv tasks list |  sed 's/[│└─ ├]//g' | grep -v 'devenv:'",
    	}, {
    		text = true,
    	}):wait()

    	if result.code ~= 0 then
    		vim.notify(result.stderr, vim.log.levels.ERROR)
    		return
    	end

    	local items = {}
    	local seen = {}

    	for line in result.stdout:gmatch("[^\r\n]+") do
    		-- Add the parent task (e.g. "git", "nix-update")
    		local parent = line:match("^([^:]+)")
    		if parent and not seen[parent] then
    			seen[parent] = true
    			table.insert(items, {
    				text = parent,
    				task = parent,
    			})
    		end

    		-- Add the full task (e.g. "git:precommit")
    		if not seen[line] then
    			seen[line] = true
    			table.insert(items, {
    				text = line,
    				task = line,
    			})
    		end
    	end

    	Snacks.picker({
    		title = "Devenv Tasks",
    		items = items,
    		format = function(item)
    			return { { item.task } }
    		end,
    		confirm = function(picker, item)
    			picker:close()
    			vim.cmd(
    				"FloatermNew! --disposable --position=bottom --height=0.3 devenv tasks run "
    					.. vim.fn.shellescape(item.task)
    			)
    		end,
    	})
    end
    vim.api.nvim_create_user_command("DevenvTasks", devenv_tasks, {})
  '';

}
