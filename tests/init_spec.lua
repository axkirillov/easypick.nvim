require("plenary")
require("plenary.busted")
local easypick = require("easypick")

describe("setup", function()
	it("should validate fzf-lua dependency when configured", function()
		assert.not_error(function()
			easypick.setup({ provider = "telescope" })
		end)
	end)
	it("should validate fail for fzf-lua dependency when configured", function()
		assert.error(
			function() easypick.setup({ provider = "fzf-lua" }) end,
			"fzf-lua is not supported yet"
		)
  end)
end)
