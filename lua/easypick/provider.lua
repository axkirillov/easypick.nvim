local M = {}

---@class Easypick.Provider
---@field all function
---@field one function
---@field one_off function
---@field previewers table
---@field actions table
---@field one_off_picker function

---@param provider "telescope" | "fzf-lua"
---@return Easypick.Provider
M.new = function(provider)
	if provider == "telescope" then
		local has_telescope, _ = pcall(require, 'telescope')
		if not has_telescope then
			error('You have to install nvim-telescope/telescope.nvim')
		end
		return require("easypick.providers.telescope.picker")
	end
	if provider == "fzf-lua" then
		local has_fzf_lua, _ = pcall(require, 'fzf-lua')
		if not has_fzf_lua then
			error('You have to install ibhagwan/fzf-lua')
		end
		return require("easypick.providers.fzf-lua.picker")
	end
	error('Unknown provider: ' .. provider)
end

return M
