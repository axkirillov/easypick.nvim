local has_telescope, telescope = pcall(require, 'telescope')
local telescope_pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local previewers = require('easypick.previewers')

if not has_telescope then
  error('This plugin requires nvim-telescope/telescope.nvim')
end

local picker = function(telescope_picker_opts, pickers)
	local command = ''
	local previewer = {}
	local picker_name = telescope_picker_opts.args or ''

	for key, value in pairs(pickers) do
		if value.name == picker_name then
			command = value.command
			previewer = value.previewer
		end
	end

	if command == '' then
		print('picker with name ' .. telescope_picker_opts.args .. ' does not exist')
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

	telescope_pickers.new(telescope_picker_opts, {
		prompt_title = picker_name,
		finder = finders.new_table {
			results = files
		},
		sorter = conf.generic_sorter(telescope_picker_opts),
		previewer = previewer
	}):find()
end


local setup = function(args)
	local pickers = args.pickers
	local picker_names = {}
	for key, value in pairs(pickers) do
		table.insert(picker_names, value.name)
	end
	local command_opts = {
		nargs = 1,
		complete = function()
			-- return completion candidates as a list-like table
			return picker_names
		end
	}
	vim.api.nvim_create_user_command('Easypick', function(opts) picker(opts, pickers) end, command_opts)
end

return {
	setup = setup,
	previewers = previewers
}
