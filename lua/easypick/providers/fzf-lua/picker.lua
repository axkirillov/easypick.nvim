local utils = require("easypick.utils")
local fzflua = require("fzf-lua")

local M = {}

function M.all(pickers)
	local names = utils.get_names(pickers)
	fzflua.fzf_exec(names, {
		actions = {
			["default"] = function(selected) print(selected) end
		}
	})
end

function M.one(picker_name, pickers)
	if picker_name == '' then
		return M.all(pickers)
	end
	local command = ''

	for _, value in pairs(pickers) do
		if value.name == picker_name then
			command = value.command
		end
	end

	if command == '' then
		print('picker with name ' .. picker_name .. ' does not have a command configured')
		return
	end

	fzflua.fzf_exec(command, {
	})
end

return M
