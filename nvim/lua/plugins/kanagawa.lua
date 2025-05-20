return {
	"rebelot/kanagawa.nvim",
	opts = {
		complie = false,
		undercurl = true,
		commentStyle = { italic = true },
		functionStyle = {},
		keywordStyle = { italic = true },
		statementStyle = { bold = true },
		typeStyle = {},
		transparent = true,
		dimInactive = false,
		terminalColors = true,
		colors = { -- add/modify theme and palette colors
			palette = {},
			theme = {
				wave = {},
				lotus = {},
				dragon = {},
				all = {
					ui = {
						bg_gutter = "none",
					},
				},
			},
		},
		overrides = function(colors) -- add/modify highlights
			return {
				LineNr = { fg = colors.palette.dragonGray2 },
			}
		end,
		theme = "wave", -- Load "wave" theme when 'background' option is not set
		background = { -- map the value of 'background' option to a theme
			dark = "wave", -- try "dragon" !
			light = "lotus",
		},
	},
}
