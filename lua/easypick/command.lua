local state = require("easypick.state")

local M = {}

---@param pickers table
M.create = function(pickers)
	local picker_names = {}
	for _, value in pairs(pickers) do
		table.insert(picker_names, value.name)
	end
	local command_opts = {
		nargs = "*",
		complete = function()
			-- return completion candidates as a list-like table
			return picker_names
		end
	}
	vim.api.nvim_create_user_command(
		'Easypick',
		function(opts) state.provider.one(opts.args, pickers) end,
		command_opts
	)
end


return M
