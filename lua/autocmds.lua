vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		local lsp_functions = require("custom.lsp.functions")
		lsp_functions.on_attach(client, args.buf)
	end,
})
