return {
	{ "tpope/vim-fugitive" },
	{ "sindrets/diffview.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			local gitsigns = require("gitsigns")
			gitsigns.setup()
			vim.keymap.set("n", "<leader>gb", gitsigns.toggle_current_line_blame)
		end,
	},
	{
		"kdheepak/lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- setting the keybinding for LazyGit with 'keys' is recommended in
		-- order to load the plugin when the command is run for the first time
		keys = {
			{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},
}
