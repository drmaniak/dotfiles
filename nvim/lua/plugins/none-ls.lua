return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {

				-- General Code Actions
				-- null_ls.builtins.code_actions.refactoring,

				-- Lua linter + formatter --
				-- null_ls.builtins.formatting.stylua,
				-- null_ls.builtins.diagnostics.selene.with({
				--   diagnostic_config = { underline = true, virtual_text = false, signs = true },
				-- }),

				-- Python linter + formatter --
				-- null_ls.builtins.formatting.black,
				-- null_ls.builtins.formatting.isort,

				-- null_ls.builtins.diagnostics.mypy.with({
				-- 	extra_args = { "--show-column-numbers", "--ignore-missing-imports" },
				-- 	diagnostic_config = { underline = true, virtual_text = true, signs = true },
				-- }),

				-- null_ls.builtins.diagnostics.pylint.with({
				--   diagnostic_config = { underline = true, virtual_text = true, signs = true },
				-- }),

				-- Markdown Linter
				-- null_ls.builtins.diagnostics.markdownlint.with({
				--   diagnostic_config = { underline = true, virtual_text = true, signs = true },
				-- }),
				-- null_ls.builtins.formatting.prettier,
				--    null_ls.builtins.diagnostics.vale.with({
				-- diagnostic_config = { underline = true, virtual_text = true, signs = true },
				--    }),
			},
		})

		-- vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "Autoformat buffer through null_ls" })
	end,
}
