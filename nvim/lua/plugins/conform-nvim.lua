return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		-- Specify the formatters by file type
		formatters_by_ft = {
			-- python = { "isort", "black", "ruff_format" },
			python = { "ruff_format", "ruff_organize_imports" },
			lua = { "stylua" },
			markdown = { "prettier" },
			bash = { "beautysh" },
			zsh = { "beautysh" },
			html = { "prettier" },
			sql = { "sqlfluff", "sql_formatter" },
			yaml = { "prettier" },
			json = { "prettier" },
			terraform = { "terraform" },
		},

		-- Specify format on save
		format_on_save = {
			timeout_ms = 5000,
			lsp_fallback = true,
		},
	},

	keys = {
		{
			"<leader>gf",
			function()
				require("conform").format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 5000,
				})
			end,
			mode = { "n", "v" },
			desc = "Format whole file or selection (in visual mode)",
		},
		{
			"<leader>gF",
			function()
				local ft = vim.bo.filetype
				local aggressive_formatters = {
					python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
				}
				require("conform").format({
					formatters = aggressive_formatters[ft],
					lsp_fallback = true,
					async = false,
					timeout_ms = 5000,
				})
			end,
			mode = { "n", "v" },
			desc = "Aggressively format whole file or selection (in visual mode)",
		},
	},
}
