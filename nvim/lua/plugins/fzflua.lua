return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	opts = {},
	keys = {
		{
			"<leader>F",
			function()
				require("fzf-lua").builtin()
			end,
			desc = "[F]ind Builtin (fzf-lua)",
		},
		{
			"<leader>ff",
			function()
				require("fzf-lua").files()
			end,
			desc = "[f]ind [f]iles (fzf-lua)",
		},
		{
			"<leader>fn",
			function()
				require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
			end,
			desc = "[f]ind [n]eovim config (fzf-lua)",
		},
		{
			"<leader>fg",
			function()
				require("fzf-lua").live_grep()
			end,
			desc = "[f]ind [g]rep (fzf-lua)",
		},
		{
			"<leader>fh",
			function()
				require("fzf-lua").helptags()
			end,
			desc = "[f]ind [h]elp (fzf-lua)",
		},
		{
			"<leader>fk",
			function()
				require("fzf-lua").keymaps()
			end,
			desc = "[f]ind [k]eymaps (fzf-lua)",
		},
		{
			"<leader>fw",
			function()
				require("fzf-lua").grep_cword()
			end,
			desc = "[f]ind current [w]ord (fzf-lua)",
		},
		{
			"<leader>fW",
			function()
				require("fzf-lua").grep_cWORD()
			end,
			desc = "[f]ind current [W]ord (fzf-lua)",
		},
		{
			"<leader>fd",
			function()
				require("fzf-lua").diagnostics_document()
			end,
			desc = "[f]ind [d]iagnostics document (fzf-lua)",
		},
		{
			"<leader>fr",
			function()
				require("fzf-lua").resume()
			end,
			desc = "[f]ind [r]esume (fzf-lua)",
		},
		{
			"<leader>fo",
			function()
				require("fzf-lua").oldfiles()
			end,
			desc = "[f]ind [o]ld files (fzf-lua)",
		},
		{
			"<leader><leader>",
			function()
				require("fzf-lua").buffers()
			end,
			desc = "Find current buffers (fzf-lua)",
		},
		{
			"<leader>/",
			function()
				require("fzf-lua").lgrep_curbuf()
			end,
			desc = "[/] Live grep the current buffer (fzf-lua)",
		},
	},
}
