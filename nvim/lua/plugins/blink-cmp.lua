local trigger_text = ";"

return {
	{
		"saghen/blink.compat",
		-- use the latest release, via version = '*', if you also use the latest release for blink.cmp
		version = "*",
		-- lazy.nvim will automatically load the plugin when it's required by blink.cmp
		lazy = true,
		-- make sure to set opts so that lazy.nvim calls blink.compat's setup
		opts = {},
	},
	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = {
			"rafamadriz/friendly-snippets",
			"moyiz/blink-emoji.nvim",
			"ray-x/cmp-sql",
		},

		-- use a release tag to download pre-built binaries
		version = "1.*",
		-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- If you use nix, you can build from source using latest nightly rust with:
		-- build = 'nix run .#build-plugin',

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {

			-- define the filetypes that you don't want completions for
			enabled = function()
				local bufnr = vim.api.nvim_get_current_buf()
				local buftype = vim.bo[bufnr].buftype
				local filetype = vim.bo[bufnr].filetype
				local bufname = vim.api.nvim_buf_get_name(bufnr)

				-- Only log for Avante buffers to avoid cluttering
				-- if bufname:match("[Aa]vante") or filetype:lower():match("avante") then
				-- 	print("Avante buffer detected:")
				-- 	print("  Buffer number: " .. bufnr)
				-- 	print("  Buffer type: " .. buftype)
				-- 	print("  Filetype: " .. filetype)
				-- 	print("  Buffer name: " .. bufname)
				-- 	print("  Buffer variables: " .. vim.inspect(vim.b[bufnr]))
				-- 	return false
				-- end

				-- Your existing checks
				if filetype == "AvanteInput" or filetype == "oil" or buftype == "nofile" then
					return false
				end

				return true
			end,

			-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
			-- 'super-tab' for mappings similar to vscode (tab to accept)
			-- 'enter' for enter to accept
			-- 'none' for no mappings
			--
			-- All presets have the following mappings:
			-- C-space: Open menu or open docs if already open
			-- C-n/C-p or Up/Down: Select next/previous item
			-- C-e: Hide menu
			-- C-k: Toggle signature help (if signature.enabled = true)
			--
			-- See :h blink-cmp-config-keymap for defining your own keymap

			keymap = {
				preset = "default",
				["<CR>"] = { "accept", "fallback" },
			},

			appearance = {
				-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
				-- max_kind_width = 16,
			},

			signature = {
				-- Boolean value to enable/disabel signature help from Blink-cmp
				enabled = true,

				trigger = {
					enabled = true,
					show_on_trigger_character = true,
					show_on_keyword = false,
					show_on_insert = false,
					-- show_on_insert_trigger_character = true,
				},
				window = {
					border = "rounded",
					winblend = 0,
					max_width = 100,
					max_height = 20,
					scrollbar = false,
					winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
				},
			},

			cmdline = {
				enabled = true,
			},

			-- (Default) Only show the documentation popup when manually triggered
			completion = {
				menu = {
					-- max_width = 20, -- wrap long items
					-- max_items = 30, -- number of suggestions shown
					enabled = true,
					winblend = 0,
					border = "rounded",
					scrolloff = 5,
					scrollbar = false,
					winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:BlinkCmpKindConstant,Search:None",
				},
				documentation = {
					auto_show = true,
					window = {
						border = "rounded",
						winblend = 0,
						min_width = 70,
						max_width = 100,
						max_height = 50,
						scrollbar = false,
					},
					-- border = "rounded", -- other options: "single", "none", etc.
				},
			},

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { "lazydev", "lsp", "path", "snippets", "buffer", "emoji", "sql" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
					lsp = {
						name = "lsp",
						enabled = true,
						module = "blink.cmp.sources.lsp",
						-- kind = "LSP",
						min_keyword_length = 2,
						score_offset = 90,
					},

					path = {
						name = "Path",
						module = "blink.cmp.sources.path",
						score_offset = 25,
						-- When typing a path, I would get snippets and text in the
						-- suggestions, I want those to show only if there are no path
						-- suggestions
						fallbacks = { "snippets", "buffer" },
						-- min_keyword_length = 2,
						opts = {
							trailing_slash = false,
							label_trailing_slash = true,
							get_cwd = function(context)
								return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
							end,
							show_hidden_files_by_default = true,
						},
					},
					buffer = {
						name = "Buffer",
						enabled = true,
						max_items = 3,
						module = "blink.cmp.sources.buffer",
						min_keyword_length = 2,
						score_offset = 15, -- the higher the number, the higher the priority
					},

					snippets = {
						name = "snippets",
						enabled = true,
						max_items = 15,
						min_keyword_length = 2,
						module = "blink.cmp.sources.snippets",
						score_offset = 85, -- the higher the number, the higher the priority
						-- Only show snippets if I type the trigger_text characters, so
						-- to expand the "bash" snippet, if the trigger_text is ";" I have to
						should_show_items = function()
							local col = vim.api.nvim_win_get_cursor(0)[2]
							local before_cursor = vim.api.nvim_get_current_line():sub(1, col)
							-- NOTE: remember that `trigger_text` is modified at the top of the file
							return before_cursor:match(trigger_text .. "%w*$") ~= nil
						end,
						-- After accepting the completion, delete the trigger_text characters
						-- from the final inserted text
						-- Modified transform_items function based on suggestion by `synic` so
						-- that the luasnip source is not reloaded after each transformation
						-- https://github.com/linkarzu/dotfiles-latest/discussions/7#discussion-7849902
						-- NOTE: I also tried to add the ";" prefix to all of the snippets loaded from
						-- friendly-snippets in the luasnip.lua file, but I was unable to do
						-- so, so I still have to use the transform_items here
						-- This removes the ";" only for the friendly-snippets snippets
						transform_items = function(_, items)
							local line = vim.api.nvim_get_current_line()
							local col = vim.api.nvim_win_get_cursor(0)[2]
							local before_cursor = line:sub(1, col)
							local start_pos, end_pos = before_cursor:find(trigger_text .. "[^" .. trigger_text .. "]*$")
							if start_pos then
								for _, item in ipairs(items) do
									if not item.trigger_text_modified then
										---@diagnostic disable-next-line: inject-field
										item.trigger_text_modified = true
										item.textEdit = {
											newText = item.insertText or item.label,
											range = {
												start = { line = vim.fn.line(".") - 1, character = start_pos - 1 },
												["end"] = { line = vim.fn.line(".") - 1, character = end_pos },
											},
										}
									end
								end
							end
							return items
						end,
					},

					emoji = {
						module = "blink-emoji",
						name = "Emoji",
						score_offset = 20, -- Tune by preference
						opts = { insert = true }, -- Insert emoji (default) or complete its name
						should_show_items = function()
							return vim.tbl_contains(
								-- Enable emoji completion only for git commits and markdown.
								-- By default, enabled for all file-types.
								{ "gitcommit", "markdown" },
								vim.o.filetype
							)
						end,
					},
					sql = {
						-- IMPORTANT: use the same name as you would for nvim-cmp
						name = "sql",
						module = "blink.compat.source",

						-- all blink.cmp source config options work as normal:
						score_offset = -3,

						-- this table is passed directly to the proxied completion source
						-- as the `option` field in nvim-cmp's source config
						--
						-- this is NOT the same as the opts in a plugin's lazy.nvim spec
						opts = {},
						should_show_items = function()
							return vim.tbl_contains(
								-- Enable emoji completion only for git commits and markdown.
								-- By default, enabled for all file-types.
								{ "sql" },
								vim.o.filetype
							)
						end,
					},
				},
			},

			-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
			-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
			-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
			--
			-- See the fuzzy documentation for more information
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
}
