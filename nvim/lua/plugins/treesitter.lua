return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		init = function()
			local ensure_installed = {
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"elixir",
				"heex",
				"javascript",
				"html",
				"python",
				"go",
				"sql",
			}
			local installed = require("nvim-treesitter.config").get_installed()
			local to_install = vim.iter(ensure_installed)
				:filter(function(p)
					return not vim.tbl_contains(installed, p)
				end)
				:totable()
			if #to_install > 0 then
				require("nvim-treesitter").install(to_install)
			end

			-- Auto-install missing parsers on FileType, then enable treesitter
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					local buf = args.buf
					local ft = args.match
					local lang = vim.treesitter.language.get_lang(ft) or ft
					local TS = require("nvim-treesitter")

					local function start()
						pcall(vim.treesitter.start, buf, lang)
						if vim.treesitter.query.get(lang, "indents") then
							vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
						end
					end

					if vim.tbl_contains(TS.get_installed(), lang) then
						start()
					elseif vim.tbl_contains(TS.get_available(), lang) then
						TS.install({ lang }):await(function()
							if vim.api.nvim_buf_is_valid(buf) then
								vim.schedule(start)
							end
						end)
					end
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		lazy = false,
		init = function()
			-- Disable built-in ftplugin mappings (esp. Python's `]m`, `[m`, `]M`, `[M`)
			-- so they don't shadow our treesitter-based movement keymaps.
			-- See: https://github.com/nvim-treesitter/nvim-treesitter-textobjects#installation
			vim.g.no_plugin_maps = true
		end,
		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = {
					lookahead = true,
					selection_modes = {
						["@parameter.outer"] = "v",
						["@function.outer"] = "V",
						["@class.outer"] = "<c-v>",
					},
					include_surrounding_whitespace = true,
				},
				move = {
					set_jumps = true,
				},
			})
			local select = require("nvim-treesitter-textobjects.select")
			local move = require("nvim-treesitter-textobjects.move")
			local swap = require("nvim-treesitter-textobjects.swap")
			local rep = require("nvim-treesitter-textobjects.repeatable_move")
			-- select
			local function s(key, query, desc)
				vim.keymap.set({ "x", "o" }, key, function()
					select.select_textobject(query, "textobjects")
				end, { desc = desc })
			end
			s("af", "@function.outer", "outer function")
			s("if", "@function.inner", "inner function")
			s("ac", "@class.outer", "outer class")
			s("ic", "@class.inner", "inner class")
			s("ap", "@parameter.outer", "outer parameter")
			s("ip", "@parameter.inner", "inner parameter")
			vim.keymap.set({ "x", "o" }, "as", function()
				select.select_textobject("@scope", "locals")
			end, { desc = "language scope" })
			-- move (next start)
			vim.keymap.set({ "n", "x", "o" }, "]m", function()
				move.goto_next_start("@function.outer", "textobjects")
			end, { desc = "Next function start" })
			vim.keymap.set({ "n", "x", "o" }, "]]", function()
				move.goto_next_start("@class.outer", "textobjects")
			end, { desc = "Next class start" })
			vim.keymap.set({ "n", "x", "o" }, "]o", function()
				move.goto_next_start({ "@loop.inner", "@loop.outer" }, "textobjects")
			end, { desc = "Next loop" })
			vim.keymap.set({ "n", "x", "o" }, "]z", function()
				move.goto_next_start("@fold", "folds")
			end, { desc = "Next fold" })
			-- move (next end)
			vim.keymap.set({ "n", "x", "o" }, "]M", function()
				move.goto_next_end("@function.outer", "textobjects")
			end, { desc = "Next function end" })
			vim.keymap.set({ "n", "x", "o" }, "][", function()
				move.goto_next_end("@class.outer", "textobjects")
			end, { desc = "Next class end" })
			-- move (previous start)
			vim.keymap.set({ "n", "x", "o" }, "[m", function()
				move.goto_previous_start("@function.outer", "textobjects")
			end, { desc = "Prev function start" })
			vim.keymap.set({ "n", "x", "o" }, "[[", function()
				move.goto_previous_start("@class.outer", "textobjects")
			end, { desc = "Prev class start" })
			-- move (previous end)
			vim.keymap.set({ "n", "x", "o" }, "[M", function()
				move.goto_previous_end("@function.outer", "textobjects")
			end, { desc = "Prev function end" })
			vim.keymap.set({ "n", "x", "o" }, "[]", function()
				move.goto_previous_end("@class.outer", "textobjects")
			end, { desc = "Prev class end" })
			-- swap
			vim.keymap.set("n", "<leader>sn", function()
				swap.swap_next("@parameter.inner")
			end, { desc = "Swap parameter with next" })
			vim.keymap.set("n", "<leader>sp", function()
				swap.swap_previous("@parameter.inner")
			end, { desc = "Swap parameter with previous" })
			-- repeat (textobject moves + builtin f/F/t/T)
			vim.keymap.set({ "n", "x", "o" }, ";", rep.repeat_last_move_next)
			vim.keymap.set({ "n", "x", "o" }, ",", rep.repeat_last_move_previous)
			vim.keymap.set({ "n", "x", "o" }, "f", rep.builtin_f_expr, { expr = true })
			vim.keymap.set({ "n", "x", "o" }, "F", rep.builtin_F_expr, { expr = true })
			vim.keymap.set({ "n", "x", "o" }, "t", rep.builtin_t_expr, { expr = true })
			vim.keymap.set({ "n", "x", "o" }, "T", rep.builtin_T_expr, { expr = true })
		end,
	},
}
