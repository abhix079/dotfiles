return {
	"rcarriga/nvim-notify",
	config = function()
		require("notify").setup({
			background_colour = "#000000", -- Prevents transparency issues
			render = "minimal", -- Options: default, minimal, simple, compact
			timeout = 3000, -- Auto-hide after 3 seconds
		})
		vim.notify = require("notify") -- Replace default notify
	end,
}
