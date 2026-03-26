return {
  {
    "rasulomaroff/reactive.nvim",
    config = function()
      require("reactive").setup({
        load = { "catppuccin-frappe-cursor", "catppuccin-frappe-cursorline" },
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
    "stevearc/quicker.nvim",
    ft = "qf",
    opts = {},
  },
  { "mrjones2014/smart-splits.nvim", lazy = false },
  {
    "folke/which-key.nvim",
    lazy = false,
    opts = {
      preset = "helix",
    },
  },
}
