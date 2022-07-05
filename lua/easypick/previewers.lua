local previewers = require "telescope.previewers"
local putils = require "telescope.previewers.utils"
local from_entry = require "telescope.from_entry"
local conf = require("telescope.config").values

local default = function (opts)
	opts = opts or {}
	return previewers.vim_buffer_cat.new(opts)
end

local branch_diff = function (opts)
	return previewers.new_buffer_previewer {
		title = "Git Branch Diff Preview",
		get_buffer_by_name = function(_, entry)
			return entry.value
		end,

		define_preview = function(self, entry, _)
			local file_name = entry.value
			local get_git_status_command = "git status -s -- " .. file_name
			local git_status = io.popen(get_git_status_command):read("*a")
			local git_status_short = string.sub(git_status, 1, 1)
			if git_status_short ~= "" then
				local p = from_entry.path(entry, true)
				if p == nil or p == "" then
					return
				end
				conf.buffer_previewer_maker(p, self.state.bufnr, {
					bufname = self.state.bufname,
					winid = self.state.winid,
				})
			else
				putils.job_maker({ "git", "--no-pager", "diff", opts.base_branch .. "..HEAD", "--", file_name }, self.state.bufnr, {
					value = file_name,
					bufname = self.state.bufname,
				})
				putils.regex_highlighter(self.state.bufnr, "diff")
			end
		end,
	}
end

local file_diff = function (opts)
	opts = opts or {}
	return previewers.git_file_diff.new(opts)
end

return {
	default = default,
	branch_diff = branch_diff,
	file_diff = file_diff
}
