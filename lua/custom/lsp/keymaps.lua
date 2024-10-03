local utils = require("custom.lsp.utils")

local M = {}

M.vtsls = {
	{
		keymap = "<leader>co",
		action = utils.action["source.organizeImports"],
		desc = "Organize Imports",
	},
	{
		keymap = "<leader>cM",
		action = utils.action["source.addMissingImports.ts"],
		desc = "Add missing imports",
	},
	{
		keymap = "<leader>cu",
		action = utils.action["source.removeUnusedImports"],
		desc = "Remove unused imports",
	},
	{
        keymap = "<leader>cD",
		action = utils.action["source.fixAll.ts"],
		desc = "Fix all diagnostics",
	},
	{
		keymap = "<leader>cV",
		action = function()
			utils.execute({ command = "typescript.selectTypeScriptVersion" })
		end,
		desc = "Select TS workspace version",
	},
}

return M
