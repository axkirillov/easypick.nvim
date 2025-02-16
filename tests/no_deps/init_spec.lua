require("plenary")
require("plenary.busted")
local easypick = require("easypick")

describe("setup", function()
	it("should succeed configuring with telescope ", function()
		assert.error(
			function() easypick.setup({ provider = "telescope" }) end,
			"You have to install nvim-telescope/telescope.nvim"
		)
	end)
	it("should print an error message for fzf-lua dependency when configured", function()
		assert.error(
			function() easypick.setup({ provider = "fzf-lua" }) end,
			"You have to install ibhagwan/fzf-lua"
		)
	end)
end)
