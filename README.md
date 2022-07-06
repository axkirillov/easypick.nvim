# easypick.nvim

Easypick is a neovim plugin that lets you easily create Telescope pickers (see [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)) from arbitraty console commands.

# installation

```
use {'axkirillov/easypick.nvim', requires = 'nvim-telescope/telescope.nvim'}
```

# configuration
```
local easypick = require("easypick")

-- only required for the example to work
local base_branch = "develop"

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
			previewer = easypick.previewers.branch_diff(base_branch)
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

![image](https://user-images.githubusercontent.com/32141102/176906224-3b8c138e-7707-42d8-b4d1-bbe47a0afa24.png)
