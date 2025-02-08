local state = require("easypick.state")

local M = {}

function M.nvim_commandf(template)
	return function()
		state.provider.actions.nvim_commandf(template)
	end
end

return M
