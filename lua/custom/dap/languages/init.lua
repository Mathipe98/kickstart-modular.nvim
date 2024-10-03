local M = {}

M.setup = function()
    local vscodeLaunchConfigs = require("custom.dap.languages.vscode-launch-configs")
    vscodeLaunchConfigs.get_launch_configs()
    vscodeLaunchConfigs.get_tasks()

    require("custom.dap.languages.csharp").setup()
    require("custom.dap.languages.typescript").setup()
end

return M
