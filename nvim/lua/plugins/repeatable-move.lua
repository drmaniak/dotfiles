return {
	"kiyoon/repeatable-move.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
	-- Load early enough that the quickfix/loclist keymaps below exist from
	-- the start of a session. These moves only need Vim builtins, so there's
	-- no real lazy-loading win in deferring them.
	event = "VeryLazy",
	config = function()
		local repeat_move = require("repeatable_move")

		-- Helper: wrap a forward/backward pair and bind them to ]x / [x.
		-- `forward` MUST be passed first (plugin requirement).
		local function pair(next_key, prev_key, forward_fn, backward_fn, opts)
			opts = opts or {}
			local nf, pf = repeat_move.make_repeatable_move_pair(forward_fn, backward_fn)
			local modes = opts.modes or { "n", "x", "o" }
			vim.keymap.set(modes, next_key, nf, {
				buffer = opts.buffer,
				desc = opts.next_desc,
			})
			vim.keymap.set(modes, prev_key, pf, {
				buffer = opts.buffer,
				desc = opts.prev_desc,
			})
		end

		-- ── Quickfix list: ]q / [q ──────────────────────────────────
		pair("]q", "[q", function()
			pcall(vim.cmd, "cnext " .. vim.v.count1)
		end, function()
			pcall(vim.cmd, "cprev " .. vim.v.count1)
		end, {
			modes = { "n" },
			next_desc = "Next quickfix item",
			prev_desc = "Prev quickfix item",
		})

		-- ── Quickfix file-level jumps: ]Q / [Q ──────────────────────
		pair("]Q", "[Q", function()
			pcall(vim.cmd, "cnfile")
		end, function()
			pcall(vim.cmd, "cpfile")
		end, {
			modes = { "n" },
			next_desc = "Next quickfix file",
			prev_desc = "Prev quickfix file",
		})

		-- ── Location list: ]l / [l ──────────────────────────────────
		pair("]l", "[l", function()
			pcall(vim.cmd, "lnext " .. vim.v.count1)
		end, function()
			pcall(vim.cmd, "lprev " .. vim.v.count1)
		end, {
			modes = { "n" },
			next_desc = "Next location item",
			prev_desc = "Prev location item",
		})

		-- ── Gitsigns hunks: ]h / [h ─────────────────────────────────
		-- pcall so this is harmless if gitsigns isn't installed/loaded yet;
		-- the require resolves lazily on first keypress.
		pair("]h", "[h", function()
			local ok, gs = pcall(require, "gitsigns")
			if ok then
				gs.nav_hunk("next")
			end
		end, function()
			local ok, gs = pcall(require, "gitsigns")
			if ok then
				gs.nav_hunk("prev")
			end
		end, {
			next_desc = "Next git hunk",
			prev_desc = "Prev git hunk",
		})

		-- ── Diagnostics: buffer-local, set on LspAttach ─────────────
		-- ]d / [d : any diagnostic
		-- ]e / [e : errors only
		-- ]w / [w : warnings only
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("repeatable_move_diagnostics", { clear = true }),
			callback = function(args)
				local S = vim.diagnostic.severity

				local function jumper(count, severity)
					return function()
						vim.diagnostic.jump({
							count = count,
							severity = severity,
							float = true,
						})
					end
				end

				pair("]d", "[d", jumper(1, nil), jumper(-1, nil), {
					buffer = args.buf,
					next_desc = "Next diagnostic",
					prev_desc = "Prev diagnostic",
				})
				pair("]e", "[e", jumper(1, S.ERROR), jumper(-1, S.ERROR), {
					buffer = args.buf,
					next_desc = "Next error",
					prev_desc = "Prev error",
				})
				pair("]w", "[w", jumper(1, S.WARN), jumper(-1, S.WARN), {
					buffer = args.buf,
					next_desc = "Next warning",
					prev_desc = "Prev warning",
				})
			end,
		})
	end,
}
