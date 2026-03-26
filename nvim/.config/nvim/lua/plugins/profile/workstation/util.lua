return {
  {
    "kawre/leetcode.nvim",
    dependencies = {
      "ibhagwan/fzf-lua",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      lang = "python3",
      picker = { provider = nil },
    },
  },
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      local keys = opts.dashboard and opts.dashboard.preset and opts.dashboard.preset.keys
      if not keys then
        return
      end
      table.insert(keys, #keys, { icon = " ", key = "m", desc = "LSP", action = ":Mason" })
    end,
  },
  {
    "2kabhishek/nerdy.nvim",
    dependencies = {
      "folke/snacks.nvim",
    },
    cmd = "Nerdy",
    opts = {
      max_recents = 30,
      add_default_keybindings = true,
      copy_to_clipboard = false,
    },
  },
}
