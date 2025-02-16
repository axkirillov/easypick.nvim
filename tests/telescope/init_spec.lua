require("plenary")
require("plenary.busted")
local easypick = require("easypick")

describe("setup", function()
	it("should succeed configuring with telescope ", function()
		assert.not_error(
			function() easypick.setup({ provider = "telescope" }) end
		)
	end)

	it("should succeed running Easypick command", function()
		assert.not_error(
			function()
				vim.api.nvim_command("Easypick")
			end
		)
	end)

	it("should print an error message for fzf-lua dependency when configured", function()
		assert.error(
			function() easypick.setup({ provider = "fzf-lua" }) end,
			"You have to install ibhagwan/fzf-lua"
		)
	end)
end)
