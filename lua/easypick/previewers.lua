local state = require("easypick.state")

local M = {}

function M.default(opts)
	return function()
		return state.provider.previewers.default(opts)
	end
end

function M.branch_diff(opts)
  return function()
    return state.provider.previewers.branch_diff(opts)
  end
end

function M.file_diff(opts)
	return function()
    return state.provider.previewers.file_diff(opts)
  end
end

return M
