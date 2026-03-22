local frappe = require("catppuccin.palettes").get_palette("frappe")

return {
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
      preset = "helix",
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
        transparent_background = true,
        float = {
          solid = false,
          transparent = true,
        },
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
          enabled = false,
        },
        integrations = {
          colorful_winsep = {
            enabled = true,
            color = "lavender",
          },
          overseer = true,
          snacks = {
            enabled = true,
            indent_scope_color = "subtext0",
          },
          which_key = true,
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
    init = function()
      local bufline = require("catppuccin.special.bufferline")
      function bufline.get()
        return bufline.get_theme()
      end
    end,
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
    "rachartier/tiny-glimmer.nvim",
    event = "TextYankPost",
    config = function()
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
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        sh = { { "shfmt", extra_args = { "-i", "2", "-ci" } } },
        bash = { { "shfmt", extra_args = { "-i", "2", "-ci" } } },
        zsh = { { "shfmt", extra_args = { "-i", "2", "-ci" } } },
        lua = { { "stylua", extra_args = { "--indent-type", "Spaces", "--indent-width", "2" } } },
      },
    },
  },
  {
    "chrisgrieser/nvim-rip-substitute",
    cmd = "RipSubstitute",
    opts = {},
    keys = {
      {
        "<leader>fs",
        function()
          require("rip-substitute").sub()
        end,
        mode = { "n", "x" },
        desc = "Substitute",
      },
    },
  },
  {
    "nvim-zh/colorful-winsep.nvim",
    config = true,
    event = { "WinLeave" },
  },
  {
    "stevearc/quicker.nvim",
    ft = "qf",
    opts = {},
  },
}
