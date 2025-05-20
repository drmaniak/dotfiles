--- stylua: ignore

return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"kdheepak/tabline.nvim",
		"yavorski/lualine-macro-recording.nvim", -- display macro recording
	},
	config = function()
		local colors = {
			red = "#cdd6f4",
			grey = "#181825",
			black = "#1e1e2e",
			white = "#313244",
			light_green = "#6c7086",
			orange = "#fab387",
			green = "#a6e3a1",
			blue = "#80A7EA",
		}

		local theme = {
			normal = {
				a = { fg = colors.black, bg = colors.blue },
				b = { fg = colors.blue, bg = colors.white },
				c = { fg = colors.white, bg = colors.black },
				z = { fg = colors.white, bg = colors.black },
			},
			insert = { a = { fg = colors.black, bg = colors.orange } },
			visual = { a = { fg = colors.black, bg = colors.green } },
			replace = { a = { fg = colors.black, bg = colors.green } },
		}

		local vim_icons = {
			function()
				return " "
			end,
			separator = { left = "", right = "" },
			color = { bg = "#313244", fg = "#80A7EA" },
		}

		local space = {
			function()
				return " "
			end,
			color = { bg = "NONE", fg = "NONE" },
		}

		local filename = {
			"filename",
			color = { bg = "#80A7EA", fg = "#242735" },
			separator = { left = "", right = "" },
		}

		local filepath = {
			"filename",
			path = 1,
			color = { bg = "#80A7EA", fg = "#242735" },
			separator = { left = "", right = "" },
		}

		local filetype = {
			"filetype",
			icon_only = true,
			colored = true,
			color = { bg = "#313244" },
			separator = { left = "", right = "" },
		}

		local filetype_tab = {
			"filetype",
			icon_only = true,
			colored = true,
			color = { bg = "#313244" },
		}

		-- local buffer = {
		--     require 'tabline'.tabline_buffers,
		--     separator = { left = "", right = "" },
		-- }

		-- local tabs = {
		--     require 'tabline'.tabline_tabs,
		--     separator = { left = "", right = "" },
		-- }

		local fileformat = {
			"fileformat",
			color = { bg = "#b4befe", fg = "#313244" },
			separator = { left = "", right = "" },
		}

		local encoding = {
			"encoding",
			color = { bg = "#313244", fg = "#80A7EA" },
			separator = { left = "", right = "" },
		}

		local branch = {
			"branch",
			color = { bg = "#a6e3a1", fg = "#313244" },
			separator = { left = "", right = "" },
		}

		local diff = {
			"diff",
			color = { bg = "#313244", fg = "#313244" },
			separator = { left = "", right = "" },
		}

		local macro_recording = {
			"macro_recording",
			color = { bg = "#b4befe", fg = "#313244" },
			separator = { left = "", right = "" },
		}

		local modes = {
			"mode",
			fmt = function(str)
				return str:sub(1, 1)
			end,
			color = { bg = "#fab387		", fg = "#1e1e2e" },
			separator = { left = "", right = "" },
		}

		local navic = require("nvim-navic")

		local navic_component = {
			function()
				return navic.get_location()
			end,
			cond = function()
				return navic.is_available()
			end,
			-- color = { fg = "#c97a11", bg = "NONE", gui = "italic,bold" },
			color = { fg = "#c97a11", bg = "#241a52", gui = "italic,bold" },
			padding = { left = 2, right = 2 },
			separator = { left = "", right = "" },
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
			color = { bg = "#313244", fg = "#80A7EA" },
			separator = { left = "", right = "" },
		}

		local lsp = {
			function()
				return getLspName()
			end,
			separator = { left = "", right = "" },
			color = { bg = "#f38ba8", fg = "#1e1e2e" },
		}

		require("lualine").setup({

			options = {
				icons_enabled = true,
				-- theme = theme,
				theme = "catppuccin",
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
				lualine_b = { space },
				lualine_c = {

					space,
					filepath,
					filetype,
					space,
					branch,
					diff,
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
				-- lualine_c = { navic_component },
			},
			inactive_winbar = {},
		})
	end,
}
