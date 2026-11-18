local frappe = require("catppuccin.palettes").get_palette("frappe")

return {
  { "nvzone/showkeys", cmd = "ShowkeysToggle" },
  { "OXY2DEV/patterns.nvim" },
  { "lewis6991/gitsigns.nvim", enabled = true },
  {
    "catppuccin/nvim",
    opts = function(_, opts)
      opts.integrations = opts.integrations or {}
      opts.integrations.native_lsp = {
        enabled = true,
        underlines = {
          errors = { "undercurl" },
          hints = { "underdotted" },
          warnings = { "underdashed" },
        },
      }
      opts.integrations.dropbar = {
        enabled = true,
        color_mode = true,
      }
      opts.integrations.illuminate = {
        lsp = true,
      }
    end,
  },
  {
    "Bekaboo/dropbar.nvim",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
  },
  {
    "petertriho/nvim-scrollbar",
    dependencies = { "lewis6991/gitsigns.nvim" },
    config = function()
      require("gitsigns").setup()
      require("scrollbar").setup({
        providers = { gitsigns = true },
        scrollbar = {
          thumb = {
            highlight = { bg = frappe.lavender },
          },
        },
        marks = {
          Cursor = {
            highlight = { fg = frappe.base },
          },
        },
      })
    end,
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      { "igorlfs/nvim-dap-view", opts = {} },
    },
  },
}
