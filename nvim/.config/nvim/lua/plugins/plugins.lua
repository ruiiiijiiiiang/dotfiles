return {
	{ import = "lazyvim.plugins.extras.lang.typescript" },
	{ import = "lazyvim.plugins.extras.lang.json" },
	{ import = "lazyvim.plugins.extras.lang.tailwind" },
	{ import = "lazyvim.plugins.extras.formatting.prettier" },
	{ import = "lazyvim.plugins.extras.linting.eslint" },
	{ "kchmck/vim-coffee-script" },
	{ "mrjones2014/smart-splits.nvim", lazy = false },
	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("toggleterm").setup({
				shell = "/opt/homebrew/bin/fish -l",
				hidden = true,
			})
		end,
	},
	{
		"echasnovski/mini.cursorword",
		config = function()
			require("mini.cursorword").setup({})
		end,
	},
	{
		"echasnovski/mini.indentscope",
		config = function()
			require("mini.indentscope").setup({
				draw = {
					delay = 0,
					animation = require("mini.indentscope").gen_animation.none(),
				},
			})
		end,
	},
	{
		"echasnovski/mini.animate",
		config = function()
			require("mini.cursorword").setup({
				scroll = {
					timing = require("mini.animate").gen_timing.linear({ duration = 3 }),
				},
			})
		end,
	},
	{
		"s1n7ax/nvim-window-picker",
		name = "window-picker",
		event = "VeryLazy",
		config = function()
			require("window-picker").setup({
				hint = "floating-big-letter",
			})
		end,
	},
	{
		"mistricky/codesnap.nvim",
		build = "make",
		opts = {
			save_path = "~/Pictures",
			has_line_number = true,
			has_breadcrumbs = true,
			watermark = "",
			bg_theme = "sea",
			bg_x_padding = 32,
			bg_y_padding = 24,
		},
	},
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "catppuccin-mocha",
		},
	},
	{
		"folke/which-key.nvim",
		opts = {
			spec = {
				{
					"<leader>C",
					group = "CodeSnap",
					mode = "x",
				},
			},
		},
	},
	{
		"Exafunction/codeium.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("codeium").setup({})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		opts = function(_, opts)
			table.insert(opts.sources, { name = "codeium" })
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
		},
		config = function()
			local mason = require("mason")
			local lspconfig = require("lspconfig")
			mason.setup()
			lspconfig.ts_ls.setup({
				on_attach = on_attach,
				root_dir = lspconfig.util.root_pattern("package.json"),
				single_file_support = false,
			})
			lspconfig.eslint.setup({})
			lspconfig.denols.setup({
				on_attach = on_attach,
				root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
			})
			lspconfig.coffeesense.setup({})
			lspconfig.fish_lsp.setup({})
			lspconfig.svelte.setup({})
			lspconfig.graphql.setup({})
			lspconfig.ruby_lsp.setup({})
			lspconfig.lua_ls.setup({})
		end,
	},
}
