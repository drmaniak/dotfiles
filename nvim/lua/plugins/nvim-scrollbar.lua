return {
	"petertriho/nvim-scrollbar",
	config = function()
		require("scrollbar").setup({
			handle = {
				blend = 75,
				color = "#a6e3a1",
			},
		})
	end,
}
