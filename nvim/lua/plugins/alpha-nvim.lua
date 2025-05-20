return {
	"goolord/alpha-nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"nvim-lua/plenary.nvim",
	},
	config = function()

    local dashboard = require("configs.alphaconfig").alpha_dashboard
		require("alpha").setup(dashboard.opts)
	end,
}
