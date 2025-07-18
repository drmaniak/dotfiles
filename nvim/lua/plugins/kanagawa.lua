return {
	"rebelot/kanagawa.nvim",
	opts = {
		compile = false,
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
			local theme = colors.theme
			return {
				LineNr = { fg = colors.palette.dragonGray2 },
				NormalFloat = { bg = "none" },
				FloatBorder = { bg = "none" },
				FloatTitle = { bg = "none" },

				-- Damn Kanagawa doesn't auto-set StatusLine transparency even if transparent=true
				StatusLine = { bg = "none" },
				StatusLineNC = { bg = "none" },

				BufferTabpageFill = { bg = "none" },
				BufferOffset = { bg = "none" },
				BufferTabpages = { bg = "none" },

				-- Save an hlgroup with dark background and dimmed foreground
				-- so that you can use it where your still want darker windows.
				-- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
				NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

				-- Popular plugins that open floats will link to NormalFloat by default;
				-- set their background accordingly if you wish to keep them dark and borderless
				LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
				MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

				WinSeparator = { fg = theme.ui.fg_dim, bg = "none" },
				NeoTreeWinSeparator = { fg = theme.ui.fg_dim, bg = "none" },
			}
		end,
		theme = "wave", -- Load "wave" theme when 'background' option is not set
		background = { -- map the value of 'background' option to a theme
			dark = "wave", -- try "dragon" !
			light = "lotus",
		},
	},
}
