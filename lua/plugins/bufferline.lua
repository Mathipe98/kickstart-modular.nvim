return {
    'akinsho/bufferline.nvim',
    dependencies = {
        {
            'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
            config = function() require("nvim-web-devicons").setup({
                override = {},
                default = true
            }) end
        }
    },
    version = "*",
    config = function()
        require("bufferline").setup({
            options = {
                diagnostics = "nvim_lsp",
            }
        })
    end
}
