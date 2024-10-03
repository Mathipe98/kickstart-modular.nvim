local function dotnet(command)
    local output = ""
    local err = ""
    vim.fn.jobstart("dotnet " .. command, {
        on_stdout = function(_, data, _)
            output = output .. "\n" .. data
        end,
        on_stderr = function(_, data, _)
            err = err .. "\n" .. data
        end,
        on_exit = function(_, code, _)
            if code == 0 then
                vim.notify(command .. " successful!\n" .. output)
            else
                vim.notify(command .. " failed!\n" .. err)
            end
        end,
    })
end

--- @class RestoreOpts
--- @field noCache boolean Don't use cache

--- @class Dotnet
local M = {}

--- Runs dotnet restore
--- @param opts RestoreOpts
function M.restore(opts)
    dotnet("restore")
end

function M.build(opts)
    dotnet("build")
end

return M

