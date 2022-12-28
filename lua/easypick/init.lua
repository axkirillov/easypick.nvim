local has_telescope, _ = pcall(require, 'telescope')
local telescope_pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local previewers = require('easypick.previewers')
local actions = require "easypick.actions"
local themes = require "telescope.themes"
local pick = require "easypick.pick"

if not has_telescope then
	error('This plugin requires nvim-telescope/telescope.nvim')
end

local function easypick(pickers)
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

local picker = function(picker_name, pickers)
	if picker_name == '' then
		return pick.all(pickers)
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

	local handle = io.popen(command)

	if (handle == nil) then
		print('could not run specified command:' .. command)
		return
	end

	local result = handle:read("*a")

	handle:close()

	local files = {}

	for token in string.gmatch(result, "[^%c]+") do
		table.insert(files, token)
	end

	telescope_pickers.new(opts, {
		prompt_title = picker_name,
		finder = finders.new_table {
			results = files,
			entry_maker = entry_maker,
		},
		sorter = conf.generic_sorter(opts),
		previewer = previewer,
		attach_mappings = action
	}):find()
end

local setup = function(args)
	local pickers = args.pickers
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
	vim.api.nvim_create_user_command('Easypick', function(opts) picker(opts.args, pickers) end, command_opts)
end

return {
	setup = setup,
	previewers = previewers,
	actions = actions
}
