return {
	"mfussenegger/nvim-lint",
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = function()
		local lint = require("lint")

		-- Specify the linters by file type
		lint.linters_by_ft = {
			-- python = { "mypy" },
			markdown = { "markdownlint" },
			html = { "htmlhint" },
			yaml = { "actionlint" },
			terraform = { "tflint" },
			-- sql = { "sqlfluff" },
		}

		lint.linters.markdownlint.args = {
			"--fix",
			"--disable",
			"--MD013",
			"--",
		}

		-- Autocommands for linting
		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		-- Keybinding for triggering linting
		vim.keymap.set("n", "<leader>ll", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file (nvim-lint)" })
	end,
}
