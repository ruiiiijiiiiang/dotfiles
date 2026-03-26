return {
  {
    "folke/snacks.nvim",
    dependencies = {
      {
        "s1n7ax/nvim-window-picker",
        name = "window-picker",
        event = "VeryLazy",
        opts = {
          hint = "floating-big-letter",
          show_prompt = false,
          filter_rules = {
            include_current_win = false,
            include_unfocusable_windows = false,
            bo = {
              filetype = {
                "edgy",
                "snacks_picker_input",
                "snacks_picker_list",
                "snacks_dashboard",
                "snacks_notif",
                "snacks_terminal",
                "NvimTree",
                "neo-tree",
                "notify",
                "smear-cursor",
              },
              buftype = { "terminal", "nofile", "quickfix", "help", "prompt", "notify", "float" },
            },
          },
        },
      },
    },
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
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.g.dotfiles_nvim_base_root or vim.fn.stdpath('config')})",
            },
            {
              icon = "󰐱 ",
              key = "l",
              desc = "Lazy",
              action = ":Lazy",
              enabled = package.loaded.lazy ~= nil,
            },
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
      image = { enabled = true },
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
      picker = {
        hidden = true,
        win = {
          input = {
            keys = {
              ["<a-.>"] = { "toggle_hidden", mode = { "i", "n" } },
            },
          },
          list = {
            keys = {
              ["<a-.>"] = { "toggle_hidden", mode = { "i", "n" } },
            },
          },
        },
        sources = {
          files = {
            hidden = true,
          },
          explorer = {
            actions = {
              window_picker = function(_, item)
                if item.dir then
                  return
                end
                local window_id = require("window-picker").pick_window()
                if not window_id then
                  return
                end
                vim.api.nvim_set_current_win(window_id)
                vim.cmd("edit " .. item._path)
                Snacks.explorer()
              end,
            },
            win = {
              list = {
                keys = {
                  ["w"] = "window_picker",
                },
              },
            },
          },
        },
        layout = "ivy",
      },
    },
  },
}
