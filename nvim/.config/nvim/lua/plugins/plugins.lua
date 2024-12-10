return {
  { "kchmck/vim-coffee-script" },
  { "alaviss/nim.nvim" },
  { "mrjones2014/smart-splits.nvim", lazy = false },
  {
    "folke/snacks.nvim",
    lazy = false,
    opts = {
      dashboard = {
        enabled = true,
        preset = {
          header = [[
██████   █████                   █████   █████  ███                 
░██████ ░░███                   ░░███   ░░███  ░░░                  
░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████  
░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███ 
░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███ 
░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███ 
█████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████
░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░]],
          keys = {
            { icon = " ", key = "e", desc = "Explore Directory", action = ":Neotree" },
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
        sections = {
          { section = "header" },
          {
            pane = 1,
            section = "keys",
            indent = 2,
            gap = 1,
          },
          {
            pane = 2,
            icon = " ",
            title = "Recent Files",
            section = "recent_files",
            limit = 20,
            indent = 2,
            padding = 1,
          },
          { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          { section = "startup" },
        },
        width = 68,
      },
    },
  },
  {
    "folke/which-key.nvim",
    lazy = false,
    opts = {
      spec = {
        {
          "<leader>C",
          group = "CodeSnap",
          mode = "x",
        },
        {
          "<leader>gS",
          icon = {
            icon = "",
            color = "blue",
          },
          mode = "n",
          desc = "Toggle Split/Join",
        },
      },
    },
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
    "echasnovski/mini.splitjoin",
    config = function()
      require("mini.splitjoin").setup({})
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
    "monkoose/neocodeium",
    event = "VeryLazy",
    config = function()
      local neocodeium = require("neocodeium")
      neocodeium.setup()
      vim.keymap.set("i", "<A-f>", neocodeium.accept)
    end,
  },
  -- {
  --   "hrsh7th/nvim-cmp",
  --   opts = function(_, opts)
  --     table.insert(opts.sources, { name = "codeium" })
  --   end,
  -- },
}
