return {
  { "kchmck/vim-coffee-script" },
  { "alaviss/nim.nvim" },
  { "nvzone/showkeys", cmd = "ShowkeysToggle" },
  { "mrjones2014/smart-splits.nvim", lazy = false },
  {
    "rasulomaroff/reactive.nvim",
    config = function()
      require("reactive").setup({
        load = { "catppuccin-frappe-cursor", "catppuccin-frappe-cursorline" },
      })
    end,
  },
  {
    "folke/which-key.nvim",
    lazy = false,
    opts = {
      preset = "modern",
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
    "s1n7ax/nvim-window-picker",
    name = "window-picker",
    event = "VeryLazy",
    version = "2.*",
    opts = {
      filter_rules = {
        bo = {
          filetype = {
            "edgy",
            "neo-tree",
            "noice",
            "notify",
            "smear-cursor",
            "snacks_dashboard",
            "snacks_notif",
            "snacks_terminal",
            "trouble",
            "tutor",
            "noice",
          },
        },
      },
      hint = "floating-big-letter",
    },
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
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
      options = {
        indicator = {
          style = "underline",
        },
        separator_style = "slant",
      },
    },
  },
  {
    "saghen/blink.cmp",
    enabled = false,
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options = {
        section_separators = { left = "▓▒░", right = "░▒▓" },
        component_separators = { left = "", right = "" },
      }
      opts.sections.lualine_a = {
        {
          opts.sections.lualine_a[1],
          separator = { left = "", right = "▓▒░" },
        },
      }
      opts.sections.lualine_z = {
        {
          opts.sections.lualine_z[1],
          separator = { left = "░▒▓", right = "" },
        },
      }
    end,
  },
  {
    "alanfortlink/animatedbg.nvim",
    config = function()
      require("animatedbg-nvim").setup({})
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "<c-k>", false, mode = { "i" } }
    end,
  },
  {
    "Bekaboo/dropbar.nvim",
    -- optional, but required for fuzzy finder support
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
  {
    "rachartier/tiny-glimmer.nvim",
    event = "TextYankPost",
    config = function()
      local frappe = require("catppuccin.palettes").get_palette("frappe")
      require("tiny-glimmer").setup({
        default_animation = "fade",
        animations = {
          fade = {
            from_color = frappe.lavender,
            to_color = frappe.mauve,
          },
        },
      })
    end,
  },
  { "SmiteshP/nvim-navic", opts = {
    highlight = true,
  } },
  { "nvzone/typr", cmd = "TyprStats", dependencies = "nvzone/volt", opts = {} },
}
