return {
	"m4xshen/hardtime.nvim",
	dependencies = { "MunifTanjim/nui.nvim" },
	opts = {
		disable_mouse = false,
		max_count = 7,
		disabled_keys = {
			["<Up>"] = false, -- Allow <Up> key
			["<Down>"] = false, -- Allow <Down> key
			["<Left>"] = false, -- Allow <Left> key
			["<Right>"] = false, -- Allow <Right> key
		},
	},
}
