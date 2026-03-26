return {
  { "kchmck/vim-coffee-script" },
  { "alaviss/nim.nvim" },
  { "hat0uma/csvview.nvim", opts = {} },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              inlayHints = {
                bindingModeHints = { enable = true },
                lifetimeElisionHints = { enable = true },
                closureCaptureHints = { enable = true },
                closureReturnTypeHints = { enable = true },
                expressionAdjustmentHints = { enable = true },
                parameterHints = { enable = true },
                discriminateHints = { enable = true },
                typeHints = { enable = true },
                reborrowHints = { enable = true },
              },
            },
          },
        },
      },
    },
  },
}
