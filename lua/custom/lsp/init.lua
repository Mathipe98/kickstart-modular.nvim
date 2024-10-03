local servers = require("custom.lsp.servers")

-- vim.api.nvim_create_autocmd("LspAttach", {
-- 	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
-- 	callback = function(ev)
--               local lsp_functions = require("plugins.lsp.lspconfig.functions")
--               lsp_functions.on_attach({}, ev.buf)
-- 	end,
-- })

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local common_setup_args = {
	capabilities = capabilities,
	-- on_attach = require("plugins.lsp.lspconfig.functions").on_attach
}

local lspconfig = require("lspconfig")
for name, opts in pairs(servers.server_configs) do
	lspconfig[name].setup(vim.tbl_extend("force", common_setup_args, opts))
end
