local M = {}

function M.get_names(pickers)
	local picker_names = {}
	for i, value in ipairs(pickers) do
		picker_names[i] = value.name
	end
end

return M
