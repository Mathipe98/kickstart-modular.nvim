local dotnet = require("dotnet.dotnet")

vim.api.nvim_create_user_command("Dotnet", function (opts)
    local command = table.remove(opts.fargs)

    vim.notify("Running 'dotnet " .. command .. "'")

    local cmd = dotnet[command]

    if cmd == nil then
        vim.notify("Invalid command: " .. command)
        return
    end

    cmd(opts.fargs)

end, {
    nargs = "*",
    complete = function(ArgLead, CmdLine, CursorPos)
        return { "build", "restore", "sln" }
    end
})
