local telescope_pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "easypick.actions"
local themes = require "telescope.themes"

local function all(pickers)
	local opts = themes.get_dropdown({})
	local picker_names = {}
	for _, value in pairs(pickers) do
		table.insert(picker_names, value.name)
	end
	telescope_pickers.new(opts, {
		prompt_title = "Easypick",
		finder = finders.new_table {
			results = picker_names,
		},
		sorter = conf.generic_sorter(opts),
		attach_mappings = actions.run_easypick
	}):find()
end

return {
	all = all
}
