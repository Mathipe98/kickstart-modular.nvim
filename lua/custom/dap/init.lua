local dap = require("dap")

require("custom.dap.languages").setup()

local dapui = require("dapui")
dapui.setup()

local dapUiConfigEvent = "dapui_config"
dap.listeners.after.event_initialized[dapUiConfigEvent] = function()
	dapui.open()
end

dap.listeners.after.event_terminated[dapUiConfigEvent] = function()
	dapui.close()
end

dap.listeners.after.event_exited[dapUiConfigEvent] = function()
	dapui.close()
end

local opts = {}
vim.keymap.set("n", "<F5>", dap.continue, opts)
vim.keymap.set("n", "<F10>", dap.step_over, opts)
vim.keymap.set("n", "<F11>", dap.step_into, opts)
vim.keymap.set("n", "<F12>", dap.step_out, opts)
vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, opts)
