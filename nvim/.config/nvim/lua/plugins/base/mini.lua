return {
  {
    "nvim-mini/mini.ai",
    config = function()
      require("mini.ai").setup({})
    end,
  },
  {
    "nvim-mini/mini.cursorword",
    config = function()
      require("mini.cursorword").setup({})
    end,
  },
  {
    "nvim-mini/mini.splitjoin",
    config = function()
      require("mini.splitjoin").setup({})
    end,
  },
  {
    "nvim-mini/mini.bracketed",
    config = function()
      require("mini.bracketed").setup({})
    end,
  },
  {
    "nvim-mini/mini.move",
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
