local provider = require("easypick.provider")
local command = require("easypick.command")
local state = require("easypick.state")

---@class Easypick
---@field defaults Easypick.Config
---@field setup function
---@field previewers table
---@field actions table
---@field one_off function
local M = {}

---@class Easypick.Config
---@field pickers table
---@field provider "telescope" | "fzf-lua"
M.defaults = {
	provider = "telescope",
	pickers = {},
}

M.previewers = require("easypick.previewers")
M.actions = require("easypick.actions")

---@param opts Easypick.Config
M.setup = function(opts)
	opts = vim.tbl_deep_extend('force', M.defaults, opts or {})
	state.provider = provider.new(opts.provider)
	command.create(opts.pickers)
	M.one_off = state.provider.one_off_picker
end

return M
