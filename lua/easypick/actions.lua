local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

-- deprecated, use nvim_command
local function run_nvim_command(prompt_bufnr, _)
	actions.select_default:replace(function()
		actions.close(prompt_bufnr)
		local selection = action_state.get_selected_entry()
		vim.cmd(selection[1])
	end)
	return true
end

local function nvim_command(prefix, postfix)
	if prefix == nil then
		prefix = ''
	else
		prefix = prefix .. ' '
	end

	if postfix == nil then
		postfix = ''
  end

	return function(prompt_bufnr, _)
		actions.select_default:replace(function()
			actions.close(prompt_bufnr)
			local selection = action_state.get_selected_entry()
			vim.cmd(prefix .. selection[1] .. postfix)
		end)
		return true
	end
end

return {
	run_nvim_command = run_nvim_command,
	nvim_command = nvim_command
}
