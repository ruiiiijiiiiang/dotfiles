local frappe = require("catppuccin.palettes").get_palette("frappe")

return {
  { "folke/tokyonight.nvim", enabled = false },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
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
    },
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
    "nvim-zh/colorful-winsep.nvim",
    config = true,
    event = { "WinLeave" },
  },
}
