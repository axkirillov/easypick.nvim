local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local function run_nvim_command(prompt_bufnr, _)
	actions.select_default:replace(function()
		actions.close(prompt_bufnr)
		local selection = action_state.get_selected_entry()
		vim.cmd(selection[1])
	end)
	return true
end

local function nvim_command(prefix)
	if prefix == nil then
		prefix = ''
	else
		prefix = prefix .. ' '
	end

	return function(prompt_bufnr, _)
		actions.select_default:replace(function()
			actions.close(prompt_bufnr)
			local selection = action_state.get_selected_entry()
			vim.cmd(prefix .. selection[1])
		end)
		return true
	end
end

local function nvim_commandf(template)
	return function(prompt_bufnr, _)
		actions.select_default:replace(function()
			actions.close(prompt_bufnr)
			local selection = action_state.get_selected_entry()
			local count = select(2, string.gsub(template, "%%s", ""))
			if count ~= 1 then
				vim.notify("String does not have exactly one %s placeholder", vim.log.levels.ERROR)
				return false
			end
			vim.cmd(string.format(template, selection[1]))
		end)
		return true
	end
end

return {
	-- deprecated, use nvim_commandf
	run_nvim_command = run_nvim_command,
	-- deprecated, use nvim_commandf
	nvim_command = nvim_command,
	nvim_commandf = nvim_commandf
}
