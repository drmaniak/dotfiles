return {
	"mfussenegger/nvim-dap",
	recommended = true,
	desc = "Debugging support. Requires language specific adapters to be configured",
	dependencies = {

		"rcarriga/nvim-dap-ui", -- Debugger UI
		"nvim-neotest/nvim-nio", -- required for nvim-dap-ui
		"theHamsta/nvim-dap-virtual-text", -- inline virutal text for debug assistance

		-- Lang specific debuggers
		"mfussenegger/nvim-dap-python", -- Debugger for Python
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		local dap_python = require("dap-python")
		local dap_virtual_text = require("nvim-dap-virtual-text")

		dapui.setup({

			controls = {
				element = "repl",
				enabled = true,
				icons = {
					disconnect = "",
					pause = "",
					play = "",
					run_last = "",
					step_back = "",
					step_into = "",
					step_out = "",
					step_over = "",
					terminate = "",
				},
			},
			element_mappings = {},
			expand_lines = true,
			floating = {
				border = "single",
				mappings = {
					close = { "q", "<Esc>" },
				},
			},
			force_buffers = true,
			icons = {
				collapsed = "",
				current_frame = "",
				expanded = "",
			},
			layouts = {
				{
					elements = {
						{
							id = "scopes",
							size = 0.25,
						},
						{
							id = "breakpoints",
							size = 0.25,
						},
						{
							id = "stacks",
							size = 0.25,
						},
						{
							id = "watches",
							size = 0.25,
						},
					},
					position = "left",
					size = 40,
				},
				{
					elements = {
						{
							id = "repl",
							size = 0.5,
						},
						{
							id = "console",
							size = 0.5,
						},
					},
					position = "bottom",
					size = 10,
				},
			},
			mappings = {
				edit = "e",
				expand = { "<CR>", "<2-LeftMouse>" },
				open = "o",
				remove = "d",
				repl = "r",
				toggle = "t",
			},
			render = {
				indent = 1,
				max_value_lines = 100,
			},
		})

		dap_virtual_text.setup({
			commented = true,
		})
		dap_python.setup("python3")

		vim.fn.sign_define("DapBreakpoint", {
			text = "",
			texthl = "DiagnosticSignError",
			linehl = "",
			numhl = "",
		})

		vim.fn.sign_define("DapBreakpointRejected", {
			text = "", -- or "❌"
			texthl = "DiagnosticSignError",
			linehl = "",
			numhl = "",
		})

		vim.fn.sign_define("DapStopped", {
			text = "", -- or "→"
			texthl = "DiagnosticSignWarn",
			linehl = "Visual",
			numhl = "DiagnosticSignWarn",
		})

		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
	end,
	keys = {
		{
			"<leader>db",
			function()
				require("dap").toggle_breakpoint()
			end,
			mode = { "n" },
			desc = "DAP: Toggle Breakpoint",
		},
		{
			"<leader>dc",
			function()
				require("dap").continue()
			end,
			mode = { "n" },
			desc = "DAP: Debug start/continue",
		},
		{
			"<leader>do",
			function()
				require("dap").step_over()
			end,
			mode = { "n" },
			desc = "DAP: Step Over",
		},
		{
			"<leader>di",
			function()
				require("dap").step_into()
			end,
			mode = { "n" },
			desc = "DAP: Step Into",
		},
		{
			"<leader>dO",
			function()
				require("dap").step_out()
			end,
			mode = { "n" },
			desc = "DAP: Step Out",
		},
		{
			"<leader>dq",
			function()
				require("dap").terminate()
			end,
			mode = { "n" },
			desc = "DAP: Terminate Debugging",
		},
		{
			"<leader>du",
			function()
				require("dapui").toggle()
			end,
			mode = { "n" },
			desc = "DAP: Terminate Debugging",
		},
		{
			"<leader>fb",
			function()
				require("fzf-lua").dap_breakpoints()
			end,
		},
	},
}
