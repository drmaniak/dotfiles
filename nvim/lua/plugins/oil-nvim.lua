return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {},
	-- Optional dependencies
	dependencies = {
		{ "echasnovski/mini.icons", opts = {} },
	},

	config = function()
		require("oil").setup({
			columns = {
				"icon",
				{ "size", highlight = "Special" },
				{ "mtime", highlight = "DiagnosticWarn", format = "%d%b%y %H:%M" },
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
		})
	end,
}
