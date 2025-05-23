local M = {}

-- Define configs for alpha.lua's dahsboard theme
M.alpha_dashboard = require("alpha.themes.dashboard")

-- Set header --
M.alpha_dashboard.section.header.val = {

	"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠴⠶⠶⣄⡀⠀⠀⠀⠀⠀⠀",
	"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣀⣀⡀⠘⠻⣄⠀⠀⠀⠀⠀",
	"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢣⣄⠘⢳⡄⠀⠀⠀",
	"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⠴⠾⢛⠛⣛⡟⠀⣿⠀⠀⠀",
	"⠀⠀⠀⢀⡠⢤⡀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠞⢀⡦⠟⠛⠛⠛⢦⡃⢸⡇⠀⠀",
	"⠀⠀⠀⣾⠓⠸⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠛⠋⠀⠀⠀⠀⠀⢸⡇⢸⡇⠀⠀",
	"⠀⠀⠀⣿⢧⡄⠙⠛⢦⡀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⡼⢻⡄⠀⠸⣁⠹⡀⠀",
	"⠀⠀⠀⠛⣿⣿⠤⠜⠛⠛⠒⢢⣤⠤⠖⠚⠛⠀⣉⣈⣀⡼⠂⠀⠀⢫⡄⢳⡄",
	"⠀⠀⠀⠀⢹⡏⣜⣢⠀⠀⠀⠈⠉⢀⣤⣴⣶⣾⣿⣿⠟⠁⠀⠀⠀⢸⣇⢸⡇",
	"⠀⢀⣀⡾⣯⡅⠙⠋⢁⡠⣤⡤⠐⢺⣿⣿⣿⠯⠟⠁⠀⠀⠀⠀⣸⠯⡙⡾⠃",
	"⢠⢟⣩⡕⣏⣡⠄⠀⠾⣧⠿⠃⠀⠈⠉⠛⢯⡀⣀⡠⠤⢤⡤⣒⣏⣼⠝⠁⠀",
	"⠀⠈⠉⠙⠚⠑⢤⣄⣀⣀⠀⢀⣶⡀⣤⡀⠀⢹⣉⠁⠀⠀⠀⠉⠙⡇⠀⠀⠀",
	"⠀⠀⠀⠀⠀⠀⠀⠉⢹⡯⣐⠪⢩⡕⠛⠑⠒⣤⣿⠀⠀⠀⠀⠀⠀⢹⡆⠀⠀",
	"⠀⠀⠀⠀⠀⠀⠀⢀⣼⢱⠒⠋⠉⠀⠀⠀⠀⠀⣄⣤⣤⣄⠀⠀⠀⢸⣇⠀⠀",
	"⠀⠀⠀⠀⢀⣴⠒⠚⣅⣚⣿⣶⣠⠀⠀⠀⣶⡿⠿⣿⣿⣿⣷⣤⡄⠀⠘⣧⠀",
	"⠀⠀⠀⠠⡼⢳⣰⡾⠞⠋⠀⠈⣿⠀⢀⡴⠋⠀⠀⢸⣿⣿⠋⠀⢸⠁⠀⣿⠀",
	"⠀⠀⠀⠈⢻⣦⠏⠀⠀⠀⠀⢰⠉⠀⣶⠁⠀⠀⣠⣾⣿⡟⠁⢠⡟⠁⢰⠋⠀",
	"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⡆⢰⠋⠀⠀⠀⠉⠉⠉⠀⠀⠈⠑⢳⠋⠀⠀",
	"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢣⡤⠎⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
}
M.alpha_dashboard.section.buttons.val = {
	M.alpha_dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
	M.alpha_dashboard.button("f", "󰈞  Find Files", ":lua require('fzf-lua').files()<CR>"),
	M.alpha_dashboard.button("g", "󰊄  Grep Files", ":lua require('fzf-lua').live_grep()<CR>"),
	M.alpha_dashboard.button("d", "󰈬 Browse Docs", ":lua require('fzf-lua').help_tags()<CR>"),
	M.alpha_dashboard.button("q", "󰅚  Quit NVIM", ":qa<CR>"),
}

return M
