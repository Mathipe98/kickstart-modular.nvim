---@class Task
---@field label string
---@field command string
---@field args string[]

local M = {}

local configurations = {}
M.has_loaded_configs = false

M.get_launch_configs = function()
    if M.has_loaded_configs then
        return configurations
    end

	local vscodeLaunchConfigPath = vim.fn.getcwd() .. "/.vscode/launch.json"
    local status, launchFile = pcall(vim.fn.readfile, vscodeLaunchConfigPath)

    if not status then
        return {}
    end

    for i, line in ipairs(launchFile) do
        -- Look for lines that only include comments
        local commentIndex = string.find(line, "^%s+%/%/")
        if commentIndex ~= nil then
            launchFile[i] = ""
        end
    end

	local status, vscodeLaunchConfig = pcall(vim.fn.json_decode, launchFile)

    if not status then
        return {}
    end

	if vscodeLaunchConfig == nil then
		return {}
	end

	if vscodeLaunchConfig.configurations ~= nil then
		for _, config in ipairs(vscodeLaunchConfig.configurations) do
			table.insert(configurations, config)
		end
	end

    M.has_loaded_configs = true

	return configurations
end

---@type Task[] tasks
local tasks = {}
M.has_loaded_tasks = false


---@type fun(): Task[] tasks
function M.get_tasks()
    if M.has_loaded_tasks then
        return tasks
    end

	local vscodeTasksPath = vim.fn.getcwd() .. "/.vscode/tasks.json"
    local status, tasksFile = pcall(vim.fn.readfile, vscodeTasksPath)

    if not status then
        return {}
    end

    for i, line in ipairs(tasksFile) do
        -- Look for lines that only include comments
        local commentIndex = string.find(line, "^%s+%/%/")
        if commentIndex ~= nil then
            tasksFile[i] = ""
        end
    end

	local status, vscodeTasks = pcall(vim.fn.json_decode, tasksFile)

    if not status then
        return {}
    end

	if vscodeTasks == nil then
		return {}
	end


	if vscodeTasks.tasks ~= nil then
		for _, task in ipairs(vscodeTasks.tasks) do
			table.insert(tasks, task)
		end
	end

    M.has_loaded_tasks = true

	return tasks
end

--- Get task with the given label
--- @param label string
---@return Task | nil
function M.get_task_for_label(label)
    for _, task in ipairs(M.get_tasks()) do
        if task.label == label then
            return task
        end
    end

    return nil
end

local var_placeholders = {
  ['${file}'] = function(_)
    return vim.fn.expand("%:p")
  end,
  ['${fileBasename}'] = function(_)
    return vim.fn.expand("%:t")
  end,
  ['${fileBasenameNoExtension}'] = function(_)
    return vim.fn.fnamemodify(vim.fn.expand("%:t"), ":r")
  end,
  ['${fileDirname}'] = function(_)
    return vim.fn.expand("%:p:h")
  end,
  ['${fileExtname}'] = function(_)
    return vim.fn.expand("%:e")
  end,
  ['${relativeFile}'] = function(_)
    return vim.fn.expand("%:.")
  end,
  ['${relativeFileDirname}'] = function(_)
    return vim.fn.fnamemodify(vim.fn.expand("%:.:h"), ":r")
  end,
  ['${workspaceFolder}'] = function(_)
    return vim.fn.getcwd()
  end,
  ['${workspaceFolderBasename}'] = function(_)
    return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
  end,
  ['${env:([%w_]+)}'] = function(match)
    return os.getenv(match) or ''
  end,
}

function M.expand_config_variables(option)
  if type(option) == "table" then
    local mt = getmetatable(option)
    local result = {}
    for k, v in pairs(option) do
      result[M.expand_config_variables(k)] = M.expand_config_variables(v)
    end
    return setmetatable(result, mt)
  end
  if type(option) ~= "string" then
    return option
  end
  local ret = option
  for key, fn in pairs(var_placeholders) do
    ret = ret:gsub(key, fn)
  end
  return ret
end

return M
