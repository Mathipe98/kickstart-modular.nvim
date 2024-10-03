local M = {}

M.setup = function()
	local mason = require("mason-registry")
	local debugger_path = mason.get_package("js-debug-adapter"):get_install_path()
	-- local debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter"
	-- require("dap-vscode-js").setup({
	--        debugger_path = debugger_path,
	--        debugger_cmd = { "js-debug-adapter" },
	-- 	adapters = {
	-- 		"pwa-node",
	-- 		"pwa-chrome",
	-- 		"node-terminal",
	-- 	},
	-- })

	local dap = require("dap")

	for _, adapter in ipairs({ "pwa-node", "pwa-chrome", "node-terminal" }) do
		dap.adapters[adapter] = {
			type = "server",
			host = "localhost",
			port = 8123,
			executable = {
				command = debugger_path .. "/js-debug-adapter",
				args = { 8123 },
			},
		}
	end

	local dap_utils = require("dap.utils")

	local configurations = {
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			cwd = "${workspaceFolder}",
		},
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach",
			processId = dap_utils.pick_process,
			cwd = "${workspaceFolder}",
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Debug Jest Tests",
			-- trace = true, -- include debugger info
			runtimeExecutable = "node",
			runtimeArgs = {
				"./node_modules/jest/bin/jest.js",
				"--runInBand",
			},
			rootPath = "${workspaceFolder}",
			cwd = "${workspaceFolder}",
			console = "integratedTerminal",
			internalConsoleOptions = "neverOpen",
		},
	}

	local projectConfigurations = require("custom.dap.languages.vscode-launch-configs").get_launch_configs()
	for _, config in ipairs(projectConfigurations) do
		table.insert(configurations, config)
	end

	for _, language in ipairs({ "typescript", "javascript" }) do
		dap.configurations[language] = configurations
	end
end

return M
