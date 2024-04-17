# easypick.nvim
Easypick is a neovim plugin that lets you easily create Telescope pickers (see [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)) from arbitrary console commands.

# installation
```lua
use {'axkirillov/easypick.nvim', requires = 'nvim-telescope/telescope.nvim'}
```

# configuration
```lua
local easypick = require("easypick")

-- only required for the example to work
local get_default_branch = "git rev-parse --symbolic-full-name refs/remotes/origin/HEAD | sed 's!.*/!!'"
local base_branch = vim.fn.system(get_default_branch) or "main"

easypick.setup({
	pickers = {
		-- add your custom pickers here
		-- below you can find some examples of what those can look like

		-- list files inside current folder with default previewer
		{
			-- name for your custom picker, that can be invoked using :Easypick <name> (supports tab completion)
			name = "ls",
			-- the command to execute, output has to be a list of plain text entries
			command = "ls",
			-- specify your custom previwer, or use one of the easypick.previewers
			previewer = easypick.previewers.default()
		},

		-- diff current branch with base_branch and show files that changed with respective diffs in preview
		{
			name = "changed_files",
			command = "git diff --name-only $(git merge-base HEAD " .. base_branch .. " )",
			previewer = easypick.previewers.branch_diff({base_branch = base_branch})
		},

		-- list files that have conflicts with diffs in preview
		{
			name = "conflicts",
			command = "git diff --name-only --diff-filter=U --relative",
			previewer = easypick.previewers.file_diff()
		},
	}
})
```

# usage
After the setup is called the Easypick command becomes available with all your pickers added to tab completion.

![image](https://user-images.githubusercontent.com/32141102/209808931-e7b7dd8b-75ed-419d-9c81-24fb409b3059.png)

Running the :Easypick command with no arguments should result in the picker picker being called
![image](https://user-images.githubusercontent.com/32141102/209807394-4dfe2b85-dcdf-45ec-b8d7-b8bfec0c4dc1.png)

## one-off picker
A one off picker can be created by calling

`require('easypick').one_off('type your command here')`

This will open up a picker just for the typed in command with default selection action and previewer

## actions
The default action opens a file. Specify the `action` field in your picker config if you want a custom action.

`easypick.actions.nvim_commandf(template)` takes a template string and inserts the selected entry at the `%s` position, then executes the command.

For example `'!make %s'` will insert the entry at `%s` position and execute the corresponding command

# recipes
More recipes are available in [wiki](https://github.com/axkirillov/easypick.nvim/wiki)

