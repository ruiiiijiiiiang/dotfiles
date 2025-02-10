return {
  {
    "folke/snacks.nvim",
    lazy = false,
    opts = {
      dashboard = {
        enabled = true,
        preset = {
          header = [[
                                                                   
      ████ ██████           █████      ██                    
     ███████████             █████                            
     █████████ ███████████████████ ███   ███████████  
    █████████  ███    █████████████ █████ ██████████████  
   █████████ ██████████ █████████ █████ █████ ████ █████  
 ███████████ ███    ███ █████████ █████ █████ ████ █████ 
██████  █████████████████████ ████ █████ █████ ████ ██████
]],
          keys = {
            {
              icon = " ",
              key = "e",
              desc = "Explore Directory",
              action = ":lua Snacks.explorer({ hidden = true })",
            },
            {
              icon = " ",
              key = "f",
              desc = "Find File",
              action = ":lua Snacks.dashboard.pick('files')",
            },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            {
              icon = " ",
              key = "g",
              desc = "Find Text",
              action = ":lua Snacks.dashboard.pick('live_grep')",
            },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            {
              icon = "󰐱 ",
              key = "l",
              desc = "Lazy",
              action = ":Lazy",
              enabled = package.loaded.lazy ~= nil,
            },
            {
              icon = "󱓖 ",
              key = "x",
              desc = "Lazy Extras",
              action = ":LazyExtras",
              enabled = package.loaded.lazy ~= nil,
            },
            { icon = " ", key = "m", desc = "LSP", action = ":Mason" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
        sections = {
          { pane = 1, section = "header" },
          {
            pane = 1,
            icon = " ",
            title = "Shortcuts",
            section = "keys",
            indent = 2,
            padding = 1,
          },
          {
            pane = 2,
            icon = " ",
            title = "Recent Files",
            section = "recent_files",
            indent = 2,
            padding = 1,
            limit = 15,
          },
          {
            pane = 2,
            icon = " ",
            title = "Projects",
            section = "projects",
            indent = 2,
            padding = 1,
            limit = 5,
          },
          { pane = 2, section = "startup" },
        },
        width = 69,
      },
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      indent = {
        chunk = {
          enabled = true,
          char = {
            arrow = "─",
            corner_top = "╭",
            corner_bottom = "╰",
          },
        },
      },
      explorer = {
        hidden = true,
      },
    },
    keys = {
      {
        "<leader>e",
        function()
          Snacks.explorer({ cwd = LazyVim.root(), hidden = true })
        end,
        desc = "File Explorer (root dir)",
      },
      {
        "<leader>E",
        function()
          Snacks.explorer({ hidden = true })
        end,
        desc = "File Explorer (cwd)",
      },
    },
  },
}
