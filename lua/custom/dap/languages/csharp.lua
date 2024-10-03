local M = {}

M.configure_configurations = function()
	local dap = require("dap")
	local vscodeLaunchConfigs = require("custom.dap.languages.vscode-launch-configs")

	dap.adapters.coreclr = {
		type = "executable",
		command = "netcoredbg",
		args = { "--interpreter=vscode" },
	}

	dap.configurations.cs = {}
	local projectConfigurations = vscodeLaunchConfigs.get_launch_configs()
	for _, config in ipairs(projectConfigurations) do
		if config.preLaunchTask then
			local program = config.program
			local task = vscodeLaunchConfigs.get_task_for_label(config.preLaunchTask)
			if task ~= nil then
				local expandedTask = vscodeLaunchConfigs.expand_config_variables(task)
				config.program = function()
					vim.notify("Building project...")

					local command = expandedTask.command .. " " .. table.concat(expandedTask.args, " ")
					vim.fn.system(command)
					vim.notify("Project built!")
					-- config.preLaunchTask = command
					config.preLaunchTask = nil

					return program
				end
			end
		end
		table.insert(dap.configurations.cs, config)
	end
end

M.setup = function()
	M.configure_configurations()
end

return M
