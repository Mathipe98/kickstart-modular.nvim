local borders = require("custom.ascii-borders")

return function()
    return require("telescope.themes").get_dropdown({
        borderchars = {
            {
                borders.horizontal,
                borders.vertical,
                borders.horizontal,
                borders.vertical,
                borders.upper_left,
                borders.upper_right,
                borders.lower_right,
                borders.lower_left,
            },
            prompt = {
                borders.horizontal,
                borders.vertical,
                " ",
                borders.vertical,
                borders.upper_left,
                borders.upper_right,
                borders.vertical,
                borders.vertical,
            },
            results = {
                borders.horizontal,
                borders.vertical,
                borders.horizontal,
                borders.vertical,
                borders.split_left,
                borders.split_right,
                borders.lower_right,
                borders.lower_left,
            },
            preview = {
                borders.horizontal,
                borders.vertical,
                borders.horizontal,
                borders.vertical,
                borders.upper_left,
                borders.upper_right,
                borders.lower_right,
                borders.lower_left,
            },
        },
        layout_config = {
            width = 0.8,
        },
        previewer = false,
        prompt_title = false,
    })
end
