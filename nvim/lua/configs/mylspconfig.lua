local M = {}
local map = vim.keymap.set
-- local conf = require("myconfig").ui.lsp

-- export on_attach & capabilities --
M.on_attach = function(client, bufnr)
	local function opts(desc)
		return { buffer = bufnr, desc = "LSP: " .. desc }
	end

	-- Attach nvim-navic to buffer
	local navic = require("nvim-navic")
	if client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
	end

	-- Assign keymaps when LSP attaches to a buffer --
	map("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
	map("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
	map("n", "gL", vim.lsp.buf.implementation, opts("Go to implementation"))
	map("n", "<leader>sh", vim.lsp.buf.signature_help, opts("Show signature help"))
	map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts("Add workspace folder"))
	map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts("Remove workspace folder"))
	map("n", "K", vim.lsp.buf.hover, opts("Show hover hint"))
	map("n", "<leader>rn", vim.lsp.buf.rename, opts("LSP Rename variable"))
	map(
		"n",
		"<leader>d",
		vim.diagnostic.open_float,
		{ noremap = true, silent = true, desc = "Show diagnostic info in a floating window." }
	)

	map("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, opts("List workspace folders"))

	map("n", "<leader>D", vim.lsp.buf.type_definition, opts("Go to type definition"))

	map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("Code action"))
	map("n", "gr", vim.lsp.buf.references, opts("Show references"))
end

-- disable semanticTokens
M.on_init = function(client, _)
	if client.supports_method("textDocument/semanticTokens") then
		client.server_capabilities.semanticTokensProvider = nil
	end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
	documentationFormat = { "markdown", "plaintext" },
	snippetSupport = true,
	preselectSupport = true,
	insertReplaceSupport = true,
	labelDetailsSupport = true,
	deprecatedSupport = true,
	commitCharactersSupport = true,
	tagSupport = { valueSet = { 1 } },
	resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	},
}
M.capabilities = vim.tbl_extend("force", M.capabilities, require("cmp_nvim_lsp").default_capabilities())
-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
--
-- M.capabilities = capabilities

return M
