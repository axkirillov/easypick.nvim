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

local function run_easypick(prompt_bufnr, _)
  actions.select_default:replace(function()
    actions.close(prompt_bufnr)
    local selection = action_state.get_selected_entry()
    vim.cmd('Easypick ' .. selection[1])
  end)
  return true
end

return {
	run_nvim_command = run_nvim_command,
	run_easypick = run_easypick
}
