local M = {}

function M.on_attach(client, bufnr)
	local function opts(description)
		return { buffer = bufnr, remap = true, desc = "LSP " .. description }
	end

	local telescope = require("telescope.builtin")

	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
	vim.keymap.set("n", "gi", telescope.lsp_implementations, opts("List implementations"))
	vim.keymap.set("n", "gr", telescope.lsp_references, opts("List references"))

	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("Hover"))
	vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts("View workspace symbols"))
	vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts("View diagnostics"))
	vim.keymap.set("n", "ød", vim.diagnostic.goto_next, opts("Go to next diagnostic"))
	vim.keymap.set("n", "æd", vim.diagnostic.goto_prev, opts("Go to previous diagnostic"))
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts("Code action"))
	vim.keymap.set("v", "<leader>ca", "<cmd>'<,'>lua vim.lsp.buf.code_action()<CR>", opts("Code action"))
	vim.keymap.set("i", "<C-f>", vim.lsp.buf.code_action, opts("Code action"))
	vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts("Rename symbol"))
	vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts("Signature help"))

	local language_specific_keymaps = require("custom.lsp.keymaps")
	local language_keymaps = language_specific_keymaps[client.name]

	if language_keymaps == nil then
		return
	end

	for _, keymap in ipairs(language_keymaps) do
		vim.keymap.set("n", keymap.keymap, keymap.action, opts(keymap.desc))
	end
end

return M
