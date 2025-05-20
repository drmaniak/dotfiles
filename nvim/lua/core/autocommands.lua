-- Highlight when yanking
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	desc = "Set local working directory to Neovim's start directory",
	group = vim.api.nvim_create_augroup("set-local-cwd", { clear = true }),
	callback = function()
		-- Get the current file's directory and change the local working directory
		local start_dir = vim.loop.cwd()
		vim.cmd("lcd" .. start_dir)
	end,
})

-- Create autogroup for cursorline behaviour --
local cursorline_augroup = vim.api.nvim_create_augroup("cursorline-control", { clear = true })

-- Enable cursorline only in active window
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
	group = cursorline_augroup,
	pattern = "*",
	callback = function()
		vim.opt_local.cursorline = true
	end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
	group = cursorline_augroup,
	pattern = "*",
	callback = function()
		vim.opt_local.cursorline = false
	end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	group = cursorline_augroup,
	pattern = "TelescopePrompt*",
	callback = function()
		vim.opt_local.cursorline = false
	end,
})
