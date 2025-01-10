return {
  { "kchmck/vim-coffee-script" },
  { "alaviss/nim.nvim" },
  { "rasulomaroff/reactive.nvim" },
  {
    "nullromo/go-up.nvim",
    config = function(_, opts)
      local goUp = require("go-up")
      goUp.setup(opts)
    end,
  },
  { "mrjones2014/smart-splits.nvim", lazy = false },
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
      require("animatedbg-nvim").setup({
        fps = 60, -- default
      })
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
    config = function()
      local dropbar_api = require("dropbar.api")
      vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
      vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
      vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
    end,
  },
}
