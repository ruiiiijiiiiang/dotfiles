local frappe = require("catppuccin.palettes").get_palette("frappe")
return {
  { "kchmck/vim-coffee-script" },
  { "alaviss/nim.nvim" },
  { "nvzone/showkeys", cmd = "ShowkeysToggle" },
  { "OXY2DEV/patterns.nvim" },
  { "lewis6991/gitsigns.nvim", enabled = true },
  { "mrjones2014/smart-splits.nvim", lazy = false },
  { "AndrewRadev/switch.vim" },
  { "hat0uma/csvview.nvim", opts = {} },
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
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { "undercurl" },
              hints = { "underdotted" },
              warnings = { "underdashed" },
            },
          },
          colorful_winsep = {
            enabled = true,
            color = "lavender",
          },
          dropbar = {
            enabled = true,
            color_mode = true,
          },
          illuminate = {
            lsp = true,
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
    "neovim/nvim-lspconfig",
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local ft = vim.bo[bufnr].filetype
          if ft == "markdown" then
            vim.diagnostic.enable(false)
          end
        end,
      })
    end,
  },
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = function()
  --     local keys = require("lazyvim.plugins.lsp.keymaps").get()
  --     keys[#keys + 1] = { "<c-k>", false, mode = { "i" } }
  --   end,
  -- },
  {
    "Bekaboo/dropbar.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
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
    "mfussenegger/nvim-dap",
    dependencies = {
      { "igorlfs/nvim-dap-view", opts = {} },
    },
  },
  {
    "petertriho/nvim-scrollbar",
    dependencies = { "lewis6991/gitsigns.nvim" },
    config = function()
      require("gitsigns").setup()
      require("scrollbar.handlers.gitsigns").setup()
      require("scrollbar").setup({
        handle = {
          color = frappe.lavender,
        },
        marks = {
          Cursor = {
            color = frappe.base,
          },
        },
      })
    end,
  },
  {
    "m4xshen/hardtime.nvim",
    lazy = false,
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      restriction_mode = "hint",
      disabled_keys = {
        ["<Up>"] = false,
        ["<Down>"] = false,
        ["<Left>"] = false,
        ["<Right>"] = false,
      },
    },
  },
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
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        sh = { { "shfmt", extra_args = { "-i", "2", "-ci" } } },
        bash = { { "shfmt", extra_args = { "-i", "2", "-ci" } } },
        zsh = { { "shfmt", extra_args = { "-i", "2", "-ci" } } },
        -- lua = { { "stylua", extra_args = { "--indent-type", "Spaces", "--indent-width", "2" } } },
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
  {
    "XXiaoA/atone.nvim",
    cmd = "Atone",
    opts = {},
  },
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    ft = "markdown",
    opts = {
      workspaces = {
        {
          name = "rui-vault",
          path = "~/Sync/obsidian/rui-vault",
        },
      },
    },
  },
  {
    "stevearc/quicker.nvim",
    ft = "qf",
    opts = {},
  },
  -- {
  --   "alanfortlink/animatedbg.nvim",
  --   config = function()
  --     require("animatedbg-nvim").setup({})
  --   end,
  -- },
  -- {
  --   "nvzone/typr",
  --   dependencies = "nvzone/volt",
  --   opts = {},
  --   cmd = { "Typr", "TyprStats" },
  -- },
}
