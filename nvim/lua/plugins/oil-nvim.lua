return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {
		columns = {
			"icon",
			{ "size", highlight = "DiagnosticWarn" },
			{ "mtime", highlight = "String", format = "%d%b%y" },
			{ "mtime", highlight = "Special", format = "%R" },
		},

		view_options = {
			case_insensitive = false,
			sort = {
				-- sort order can be "asc" or "desc"
				-- see :help oil-columns to see which columns are sortable
				{ "mtime", "desc" },
				{ "type", "asc" },
				{ "name", "asc" },
			},
		},

		skip_confirm_for_simple_edits = true,
	},
	-- Optional dependencies
	dependencies = {
		{ "echasnovski/mini.icons", opts = {} },
	},

	-- Using opts instead of config (recommended by Folke)
	-- config = function()
	-- 	require("oil").setup({
	-- 	})
	-- end,
}
