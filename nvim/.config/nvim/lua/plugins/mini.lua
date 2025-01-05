return {
  {
    "echasnovski/mini.ai",
    config = function()
      require("mini.ai").setup({})
    end,
  },
  {
    "echasnovski/mini.cursorword",
    config = function()
      require("mini.cursorword").setup({})
    end,
  },
  {
    "echasnovski/mini.splitjoin",
    config = function()
      require("mini.splitjoin").setup({})
    end,
  },
  {
    "echasnovski/mini.move",
    config = function()
      require("mini.move").setup({
        mappings = {
          left = "<C-S-h>",
          right = "<C-S-l>",
          down = "<C-S-j>",
          up = "<C-S-k>",
          line_left = "<C-S-h>",
          line_right = "<C-S-l>",
          line_down = "<C-S-j>",
          line_up = "<C-S-k>",
        },
      })
    end,
  },
}
