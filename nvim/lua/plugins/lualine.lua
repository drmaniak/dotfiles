--- stylua: ignore
---

return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"kdheepak/tabline.nvim",
		"yavorski/lualine-macro-recording.nvim", -- display macro recording
	},
	config = function()
		-- Kanagawa Wave theme colors
		local colors = {
			sumiInk0 = "#16161D", -- Darkest background
			sumiInk1 = "#1F1F28", -- Dark background
			sumiInk2 = "#2A2A37", -- Lighter background
			sumiInk3 = "#363646", -- Lightest background
			sumiInk4 = "#54546D", -- Dark foreground
			waveBlue1 = "#223249", -- Dark blue
			waveBlue2 = "#2D4F67", -- Medium blue
			oldWhite = "#C8C093", -- Light yellow/beige
			fujiWhite = "#DCD7BA", -- Lighter yellow/beige
			carpYellow = "#E6C384", -- Muted yellow
			roninYellow = "#FF9E3B", -- Bright yellow
			autumnYellow = "#DCA561", -- Autumn yellow
			crystalBlue = "#7E9CD8", -- Blue
			dragonBlue = "#7FB4CA", -- Light blue
			springGreen = "#98BB6C", -- Green
			autumnRed = "#C34043", -- Red
			sakuraPink = "#D27E99", -- Pink
			oniViolet = "#957FB8", -- Purple
		}

		local theme = {
			normal = {
				a = { fg = colors.sumiInk1, bg = colors.springGreen, gui = "bold" },
				b = { fg = colors.springGreen, bg = colors.sumiInk3, gui = "bold" },
				c = { fg = colors.oldWhite, bg = "NONE", gui = "bold" },
				y = { fg = colors.sumiInk0, bg = colors.oniViolet, gui = "bold" },
				z = { fg = colors.sumiInk0, bg = colors.fujiWhite, gui = "bold" },
			},
			insert = {
				a = { fg = colors.sumiInk1, bg = colors.crystalBlue, gui = "bold" },
				b = { fg = colors.dragonBlue, bg = colors.sumiInk3, gui = "bold" },
				c = { fg = colors.oldWhite, bg = "NONE", gui = "bold" },
				y = { fg = colors.sumiInk0, bg = colors.oniViolet, gui = "bold" },
				z = { fg = colors.sumiInk0, bg = colors.fujiWhite, gui = "bold" },
			},
			visual = {
				a = { fg = colors.sumiInk1, bg = colors.autumnYellow, gui = "bold" },
				b = { fg = colors.roninYellow, bg = colors.sumiInk3, gui = "bold" },
				c = { fg = colors.oldWhite, bg = "NONE", gui = "bold" },
				y = { fg = colors.sumiInk0, bg = colors.oniViolet, gui = "bold" },
				z = { fg = colors.sumiInk0, bg = colors.fujiWhite, gui = "bold" },
			},
			replace = {
				a = { fg = colors.sumiInk1, bg = colors.autumnRed, gui = "bold" },
				b = { fg = colors.sakuraPink, bg = colors.sumiInk3, gui = "bold" },
				c = { fg = colors.oldWhite, bg = "NONE", gui = "bold" },
				y = { fg = colors.sumiInk0, bg = colors.oniViolet, gui = "bold" },
				z = { fg = colors.sumiInk0, bg = colors.fujiWhite, gui = "bold" },
			},
			inactive = {
				a = { fg = colors.sumiInk3, bg = "NONE" },
				b = { fg = colors.sumiInk3, bg = "NONE" },
				c = { fg = colors.sumiInk3, bg = "NONE" },
			},
		}

		local separators = {
			thin_line = "│", -- Vertical thin line
			thick_line = "┃", -- Vertical thick line
			dashed = "┆", -- Vertical dashed
			dotted = "┊", -- Vertical dotted
			double = "║", -- Double vertical line
			shadow = "▏", -- Thin vertical with shadow
			block = "█", -- Full block
			arrow_right = "", -- Right-pointing solid arrow
			arrow_left = "", -- Left-pointing solid arrow
			slant_right = "", -- Right-pointing slant
			slant_left = "", -- Left-pointing slant
			curve_right = "", -- Right-pointing curve
			curve_left = "", -- Left-pointing curve
			round_right = "", -- Right-pointing rounded
			round_left = "", -- Left-pointing rounded
			triangle_right = "▶", -- Right-pointing triangle
			triangle_left = "◀", -- Left-pointing triangle
			chevron_right = "❯", -- Right chevron
			chevron_left = "❮", -- Left chevron
			diamond = "◆", -- Diamond
			circle = "●", -- Circle
			flower = "❀", -- Flower
			nerd_right = "", -- nf-oct-chevron_right
			nerd_left = "", -- nf-oct-chevron_left
			nerd_arrow = "", -- nf-cod-arrow_right
			nerd_caret = "", -- nf-cod-triangle_right
			nerd_folded = "", -- nf-cod-chevron_right
			nerd_pointer = "", -- nf-seti-pointer_right
			curve_arrow_right = "", -- Combined curve + arrow
			curve_arrow_left = "", -- Combined curve + arrow
			fancy_left = "", -- Combined arrow + slant
			double_arrow_right = "", -- Double arrows
			double_arrow_left = "",

			double_line_arrow_left = "║",
			double_line_arrow_right = "║",

			double_line_slant_left = "║",
			double_line_slant_right = "║",

			double_line_round_left = "║",
			double_line_round_right = "║",

			triple_line_round_left = "║║",
			triple_line_slant_right = "║║",
			space_arrow = " ", -- Arrow with space
		}

		local custom_separator =
			{ left = separators.double_line_round_left, right = separators.double_line_slant_right }

		local vim_icons = {
			function()
				return " "
			end,
			separator = custom_separator,
			-- color = { fg = "#80A7EA" },
		}

		local space = {
			function()
				return " "
			end,
			color = { bg = "NONE" },
		}

		local filepath = {
			"filename",
			path = 1,
			-- color = { bg = "#80A7EA", fg = "#242735" },
			separator = custom_separator,
		}

		local filetype = {
			"filetype",
			icon_only = true,
			colored = true,
			color = {},
			separator = custom_separator,
		}

		local fileformat = {
			"fileformat",
			separator = custom_separator,
		}

		local encoding = {
			"encoding",
			separator = custom_separator,
		}

		local branch = {
			"branch",
			separator = custom_separator,

			color = { bg = colors.sumiInk2 },
		}

		local diff = {
			"diff",
			separator = custom_separator,
			color = { bg = colors.sumiInk2 },
		}

		local macro_recording = {
			"macro_recording",
			separator = custom_separator,
			color = { bg = colors.sumiInk2, gui = "bold" },
		}

		local modes = {
			"mode",
			fmt = function(str)
				return str:sub(1, 1)
			end,
			-- color = { bg = "#fab387		", fg = "#1e1e2e" },
			separator = custom_separator,
		}

		local navic = require("nvim-navic")

		local navic_component = {
			function()
				return navic.get_location()
			end,
			cond = function()
				return navic.is_available()
			end,
			padding = { left = 2, right = 2 },
			separator = custom_separator,
		}

		local function getLspName()
			local buf_ft = vim.bo.filetype
			local buf_client_names = {}

			-- Get LSP client names
			local clients = vim.lsp.get_clients()
			if next(clients) == nil then
				return "  No servers"
			end

			for _, client in pairs(clients) do
				table.insert(buf_client_names, client.name)
			end

			-- Get nvim-lint linters
			local lint_ok, lint = pcall(require, "lint")
			if lint_ok then
				local linters = lint.linters_by_ft[buf_ft]
				if linters then
					if type(linters) == "table" then
						for _, linter in ipairs(linters) do
							table.insert(buf_client_names, linter)
						end
					elseif type(linters) == "string" then
						table.insert(buf_client_names, linters)
					end
				end
			end

			-- Get conform formatters
			local conform_ok, conform = pcall(require, "conform")
			if conform_ok then
				local formatters = conform.formatters_by_ft[buf_ft]
				if formatters then
					for _, formatter in ipairs(formatters) do
						table.insert(buf_client_names, formatter)
					end
				end
			end

			-- Remove duplicates
			local hash = {}
			local unique_clients = {}
			for _, v in ipairs(buf_client_names) do
				if not hash[v] then
					table.insert(unique_clients, v)
					hash[v] = true
				end
			end

			if #unique_clients == 0 then
				return "  No servers"
			end

			return "  " .. table.concat(unique_clients, ", ")
		end

		local dia = {
			"diagnostics",
			separator = custom_separator,
			color = { bg = colors.sumiInk0 },
		}

		local lsp = {
			function()
				return getLspName()
			end,
			separator = custom_separator,
		}

		require("lualine").setup({

			options = {
				icons_enabled = true,
				-- theme = "catppuccin",
				theme = theme,
				-- theme = "kanagawa",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = true,
				refresh = {
					statusline = 100,
					-- tabline = 1000,
					winbar = 100,
				},
			},

			sections = {
				lualine_a = {
					modes,
					vim_icons,
				},
				lualine_b = {
					space,
					filepath,
				},
				lualine_c = {
					space,
					branch,
					diff,
					space,
					macro_recording,
					"%S",
				},
				lualine_x = {
					space,
				},
				lualine_y = {
					encoding,
					fileformat,
					space,
				},
				lualine_z = {
					dia,
					space,
					lsp,
				},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {

				lualine_a = { space },
				lualine_b = { navic_component },
				lualine_c = {},
			},
			inactive_winbar = {},
		})
	end,
}
