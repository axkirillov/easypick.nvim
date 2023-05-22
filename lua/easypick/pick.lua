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
		attach_mappings = actions.nvim_command("Easypick")
	}):find()
end

local function run_command(command)
	local handle = io.popen(command)

	if (handle == nil) then
		print('could not run specified command:' .. command)
		return
	end

	local output = handle:read("*a")

	handle:close()

	return output
end

local function parse_command_output(output)
	local list = {}

	-- check if output is a string
	if type(output) ~= 'string' then
		print('command did not return a string')
		return
	end

	for token in string.gmatch(output, "[^%c]+") do
		table.insert(list, token)
	end

	return list
end

local function one(picker_name, pickers)
	if picker_name == '' then
		return all(pickers)
	end
	local command = ''
	local previewer = {}
	local action = function()
		-- dont do anything
	end
	local entry_maker = function(entry)
		return {
			value = entry,
			display = entry,
			ordinal = entry,
		}
	end
	local opts = {}

	for _, value in pairs(pickers) do
		if value.name == picker_name then
			command = value.command
			previewer = value.previewer
			action = value.action
			entry_maker = value.entry_maker
			opts = value.opts
		end
	end

	if command == '' then
		print('picker with name ' .. picker_name .. ' does not exist')
		return
	end

	local result = run_command(command)

	local list = parse_command_output(result)

	telescope_pickers.new(opts, {
		prompt_title = picker_name,
		finder = finders.new_table {
			results = list,
			entry_maker = entry_maker,
		},
		sorter = conf.generic_sorter(opts),
		previewer = previewer,
		attach_mappings = action
	}):find()
end

local function one_off(command)
	local result = run_command(command)

	local list = parse_command_output(result)

	telescope_pickers.new({}, {
		prompt_title = command,
		finder = finders.new_table {
			results = list,
		},
		sorter = conf.generic_sorter({}),
	}):find()
end

return {
	all = all,
	one = one,
	one_off = one_off,
}
