return {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "hrsh7th/cmp-cmdline" },
		{ "hrsh7th/cmp-nvim-lsp-signature-help" },
		{ "zbirenbaum/copilot-cmp" },
		{
			"L3MON4D3/LuaSnip",
			version = "2.*",
			build = "make install_jsregexp",
			dependencies = { "rafamadriz/friendly-snippets", "saadparwaiz1/cmp_luasnip" },
		},
		{
			"windwp/nvim-autopairs",
			event = "InsertEnter",
			opts = {},
		},
	},
    opts = function(_, opts)
        opts.sources = opts.sources or {}
        table.insert(opts.sources, {
            name = "lazydev",
            group_index = 0
        })
    end,
	config = function()
        require("custom.autocomplete")
	end,
}
