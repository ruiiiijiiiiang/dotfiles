local icons = {
  Text = " ",
  Method = " ",
  Function = "󰊕 ",
  Constructor = "󰈏 ",
  Field = " ",
  Variable = " ",
  Class = " ",
  Interface = " ",
  Module = " ",
  Property = " ",
  Unit = " ",
  Value = " ",
  Enum = " ",
  Keyword = "  ",
  Snippet = "  ",
  Color = " ",
  File = " ",
  Reference = " ",
  Folder = " ",
  EnumMember = " ",
  Constant = " ",
  Struct = " ",
  Event = " ",
  Operator = " ",
  TypeParameter = " ",
  Codeium = "󰘦 ",
  Copilot = " ",
}

return {
  "hrsh7th/nvim-cmp",
  event = "VimEnter",
  dependencies = {
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "onsails/lspkind.nvim",
  },

  config = function()
    local cmp = require("cmp")
    local lspkind = require("lspkind")
    cmp.setup({
      formatting = {
        format = lspkind.cmp_format({
          maxwidth = function()
            return math.floor(0.40 * vim.o.columns)
          end,
          ellipsis_char = "...",
          before = function(_, vim_item)
            vim_item.abbr = icons[vim_item.kind] .. " " .. vim_item.abbr
            vim_item.kind = " " .. vim_item.kind
            return vim_item
          end,
        }),
      },

      mapping = cmp.mapping.preset.insert({
        ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({
          select = true,
        }),
      }),

      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },

      sorting = {
        priority_weight = 2,
        comparators = {
          cmp.config.compare.exact,
          cmp.config.compare.offset,
          cmp.config.compare.score,
          cmp.config.compare.recently_used,
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      },

      experimental = {
        ghost_text = false,
      },

      sources = cmp.config.sources({
        { name = "codeium", priority = 1500 },
        -- { name = "copilot", priority = 1250 },
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip", priority = 750 },
        { name = "buffer", priority = 500 },
        { name = "path", priority = 250 },
      }),

      window = {
        completion = cmp.config.window.bordered({ border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" } }),

        documentation = cmp.config.window.bordered({
          border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
        }),
      },
    })
    cmp.setup.filetype("gitcommit", {
      sources = cmp.config.sources({ {
        name = "cmp_git",
      } }, { {
        name = "buffer",
      } }),
    })

    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = { {
        name = "buffer",
      } },
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({ {
        name = "path",
      } }, { {
        name = "cmdline",
      } }),
    })

    local lspconfig = require("lspconfig")
    local servers = require("mason-lspconfig").get_installed_servers()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    for _, server in pairs(servers) do
      lspconfig[server].setup({
        capabilities = capabilities,
      })
    end
    vim.o.completeopt = "menu,menuone,noselect"
  end,
}
