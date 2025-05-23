----------------------------------
-- Indentation and Whitespace   --
----------------------------------
-- Controls how tabs, spaces and indentation work
vim.opt.expandtab = true      -- Use spaces instead of tabs
vim.opt.shiftwidth = 2        -- Size of an indent
vim.opt.tabstop = 2           -- Number of spaces tabs count for
vim.opt.softtabstop = 2       -- Number of spaces for a tab in editing operations
vim.opt.smarttab = true       -- Insert tabs according to shiftwidth
vim.opt.smartindent = true    -- Insert indents automatically
vim.opt.autoindent = true     -- Copy indent from current line when starting a new line
vim.opt.breakindent = true    -- Wrapped lines preserve indentation

----------------------------------
-- Visual Indicators            --
----------------------------------
-- Settings that affect how code and UI elements are displayed
vim.opt.cursorline = true     -- Highlight the line under the cursor
vim.opt.list = true           -- Show invisible characters
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" } -- How to display invisible chars
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.number = true         -- Show current line number
vim.opt.showmode = false      -- Don't show mode in command line (shown by statusline)
vim.opt.signcolumn = "yes"    -- Always show the sign column

----------------------------------
-- Editor Behavior             --
----------------------------------
-- Settings that change how the editor works
vim.opt.mouse = "a"           -- Enable mouse in all modes
vim.opt.clipboard = "unnamedplus" -- Use system clipboard
vim.opt.undofile = true       -- Save undo history to file
vim.opt.ignorecase = true     -- Ignore case in search patterns
vim.opt.smartcase = true      -- Override ignorecase when pattern has uppercase
vim.opt.inccommand = "split"  -- Show effects of substitute command in split

----------------------------------
-- Window Management           --
----------------------------------
-- Controls how windows and splits behave
vim.opt.splitright = true     -- Open new vertical splits to the right
vim.opt.splitbelow = true     -- Open new horizontal splits below
vim.opt.scrolloff = 7         -- Minimum lines to keep above and below cursor
vim.opt.sidescrolloff = 7     -- Minimum columns to keep left and right of cursor
