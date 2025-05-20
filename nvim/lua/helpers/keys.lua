local M = {}

M.map = function(mode, lhs, rhs, desc, opts)
	-- default options --
	local options = { silent = true, desc = desc }

	-- append custom opts --
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end

	-- Set keymap with options --
	vim.keymap.set(mode, lhs, rhs, options)
end

M.set_leader = function(key)
	vim.g.mapleader = key
	vim.g.maplocalleader = key
	M.map({ "n", "v" }, key, "<nop>")
end

return M
