return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	opts = {
		lsp = {
			-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
			},
			--BUG: Signature Help disappears when as start typing.
			signature = {
				enabled = false,
				auto_open = {
					enabled = true,
					trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
					luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
					throttle = 50, -- Debounce lsp signature help request by 50ms
				},
				-- view = "custom_sighelp",
				---@type NoiceViewOptions
				opts = {
					border = {
						style = "rounded",
						padding = { top = 0, bottom = 0, left = 1, right = 1 },
					},
					use_existing = true,
					silent = true,
					close_events = {
						"CursorMoved",
						"BufHidden",
						"InsertLeave",
					},
				},
			},
		},
		views = {
			-- Define a custom view for signature help to override close events
			-- custom_sighelp = {
			-- 	backend = "popup",
			-- 	relative = "cursor",
			-- 	position = { row = 1, col = 0 },
			-- 	size = "auto",
			-- 	border = {
			-- 		style = "shadow",
			-- 		padding = { top = 0, bottom = 0, left = 1, right = 1 },
			-- 	},
			-- 	zindex = 200,
			-- 	focusable = false,
			-- 	enter = false,
			-- 	buf_options = {
			-- 		modifiable = true,
			-- 		readonly = true,
			-- 	},
			-- 	win_options = {
			-- 		winblend = 0,
			-- 		winhighlight = "Normal:BlinkCmpMenu,FloatBorder:FloatBorder",
			-- 	},
			-- },
		},
		-- you can enable a preset for easier configuration
		presets = {
			bottom_search = false, -- use a classic bottom cmdline for search
			command_palette = true, -- position the cmdline and popupmenu together
			long_message_to_split = true, -- long messages will be sent to a split
			inc_rename = false, -- enables an input dialog for inc-rename.nvim
			lsp_doc_border = true, -- add a border to hover docs and signature help
		},
	},
}
