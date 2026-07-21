return {
	"christoomey/vim-tmux-navigator",
	lazy = false,
	init = function()
		vim.g.tmux_navigator_no_mappings = 1
	end,
	config = function()
		-- Robust against plugin-update hash changes; avoids hardcoding the dir hash
		local matches = vim.fn.glob(
			vim.fn.expand("~/.config/herdr/plugins/github/vim-herdr-navigation-*/editor/nvim.lua"),
			true,
			true
		)
		if matches[1] then
			dofile(matches[1])
		else
			vim.notify("vim-herdr-navigation editor script not found", vim.log.levels.WARN)
		end
	end,
}
