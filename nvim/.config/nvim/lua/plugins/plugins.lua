return {
  { "kchmck/vim-coffee-script" },
  { "alaviss/nim.nvim" },
  { "nvzone/showkeys", cmd = "ShowkeysToggle" },
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
            "smear-cursor",
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
  },
  {
    "rachartier/tiny-glimmer.nvim",
    event = "TextYankPost",
    config = function()
      local frappe = require("catppuccin.palettes").get_palette("frappe")
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
  { "SmiteshP/nvim-navic", opts = {
    highlight = true,
  } },
  {
    "nvzone/typr",
    dependencies = "nvzone/volt",
    opts = {},
    cmd = { "Typr", "TyprStats" },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
        },
      },
    },
  },
  {
    "David-Kunz/gen.nvim",
    opts = {
      model = "deepseek-r1:7b", -- The default model to use.
      quit_map = "q", -- set keymap to close the response window
      retry_map = "<c-r>", -- set keymap to re-send the current prompt
      accept_map = "<c-cr>", -- set keymap to replace the previous selection with the last result
      host = "localhost", -- The host running the Ollama service.
      port = "11434", -- The port on which the Ollama service is listening.
      display_mode = "float", -- The display mode. Can be "float" or "split" or "horizontal-split".
      show_prompt = false, -- Shows the prompt submitted to Ollama. Can be true (3 lines) or "full".
      show_model = false, -- Displays which model you are using at the beginning of your chat session.
      no_auto_close = false, -- Never closes the window automatically.
      file = false, -- Write the payload to a temporary file to keep the command short.
      hidden = false, -- Hide the generation window (if true, will implicitly set `prompt.replace = true`), requires Neovim >= 0.10
      init = function(options)
        pcall(io.popen, "ollama serve > /dev/null 2>&1 &")
      end,
      -- Function to initialize Ollama
      command = function(options)
        local body = { model = options.model, stream = true }
        return "curl --silent --no-buffer -X POST http://"
          .. options.host
          .. ":"
          .. options.port
          .. "/api/chat -d $body"
      end,
      -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
      -- This can also be a command string.
      -- The executed command must return a JSON object with { response, context }
      -- (context property is optional).
      -- list_models = '<omitted lua function>', -- Retrieves a list of model names
      result_filetype = "markdown", -- Configure filetype of the result buffer
      debug = false, -- Prints errors and the command which is run.
    },
  },
  -- {
  --   "OXY2DEV/markview.nvim",
  --   lazy = false,
  -- },
  -- {
  --   "alanfortlink/animatedbg.nvim",
  --   config = function()
  --     require("animatedbg-nvim").setup({})
  --   end,
  -- },
}
