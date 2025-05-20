return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {},

	config = function()
		local conform = require("conform")

		conform.setup({

			-- Specify the formatters by file type
			formatters_by_ft = {

				-- python = function(bufnr)
				-- 	if require("conform").get_formatter_info("ruff_format", bufnr).available then
				-- 		return { "ruff_format", "black" }
				-- 	else
				-- 		return { "isort", "black" }
				-- 	end
				-- end,

				python = { "isort", "black", "ruff_format" },
				lua = { "stylua" },
				markdown = { "prettier" },
				bash = { "beautysh" },
				html = { "prettier" },
				sql = { "sqlfluff", "sql_formatter" },
				yaml = { "prettier" },
				json = { "prettier" },
			},

			-- Specify format on save
			format_on_save = {
				timeout_ms = 5000,
				lsp_fallback = true,
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>gf", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 5000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
