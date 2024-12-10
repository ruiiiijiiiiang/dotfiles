return {
  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.tailwind" },
  { import = "lazyvim.plugins.extras.formatting.prettier" },
  { import = "lazyvim.plugins.extras.linting.eslint" },
  { import = "lazyvim.plugins.extras.ai.codeium" },
  { "kchmck/vim-coffee-script" },
  { "alaviss/nim.nvim" },
  { "mrjones2014/smart-splits.nvim", lazy = false },
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup({
        shell = "fish -l",
        hidden = true,
      })
    end,
  },
  {
    "echasnovski/mini.ai",
    config = function()
      require("mini.ai").setup({})
    end,
  },
  {
    "echasnovski/mini.animate",
    config = function()
      require("mini.animate").setup({
        scroll = {
          timing = require("mini.animate").gen_timing.linear({ duration = 3 }),
        },
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
    "echasnovski/mini.move",
    config = function()
      require("mini.move").setup({})
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
      has_breadcrumbs = true,
      has_line_number = true,
      watermark = "",
      bg_theme = "sea",
      bg_x_padding = 32,
      bg_y_padding = 24,
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "frappe",
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          loops = { "italic" },
          operators = { "italic" },
          functions = { "bold" },
          keywords = { "bold" },
          types = { "bold" },
        },
        dim_inactive = {
          enabled = true,
          shade = "light",
          percentage = 0.6,
        },
        integrations = {
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { "undercurl" },
              hints = { "underdotted" },
              warnings = { "underdashed" },
            },
          },
        },
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    dependencies = { "catppuccin" },
    opts = {
      colorscheme = "catppuccin",
    },
    lazy = false,
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
  -- {
  --   "Exafunction/codeium.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "hrsh7th/nvim-cmp",
  --   },
  --   config = function()
  --     require("codeium").setup({})
  --   end,
  -- },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      table.insert(opts.sources, { name = "codeium" })
    end,
  },
}
