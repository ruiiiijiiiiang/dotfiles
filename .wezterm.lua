-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Tokyo Night Moon'

config.keys = {
  {
    key = 'r',
    mods = 'CMD|SHIFT',
    action = act.ReloadConfiguration,
  },
  {
    key = 'c',
    mods = 'CMD|SHIFT',
    action = act.ActivateCopyMode,
  },
  {
    key = 'LeftArrow',
    mods = 'CMD|SHIFT',
    action = act.ActivateTabRelative(-1),
  },
  {
    key = 'RightArrow',
    mods = 'CMD|SHIFT',
    action = act.ActivateTabRelative(1),
  },
  {
    key = '\\',
    mods = 'CMD|SHIFT',
    action = act.SplitHorizontal,
  },
  {
    key = '-',
    mods = 'CMD|SHIFT',
    action = act.SplitVertical,
  },
  {
    key = 'h',
    mods = 'CMD|SHIFT',
    action = act.ActivatePaneDirection 'Left',
  },
  {
    key = 'l',
    mods = 'CMD|SHIFT',
    action = act.ActivatePaneDirection 'Right',
  },
  {
    key = 'k',
    mods = 'CMD|SHIFT',
    action = act.ActivatePaneDirection 'Up',
  },
  {
    key = 'j',
    mods = 'CMD|SHIFT',
    action = act.ActivatePaneDirection 'Down',
  },
  {
    key = 'u',
    mods = 'CTRL|SHIFT',
    action = act.ScrollByPage(-0.5),
  },
  {
    key = 'd',
    mods = 'CTRL|SHIFT',
    action = act.ScrollByPage(0.5),
  },
  {
    key = 'b',
    mods = 'CTRL|SHIFT',
    action = act.ScrollByPage(-1),
  },
  {
    key = 'f',
    mods = 'CTRL|SHIFT',
    action = act.ScrollByPage(1),
  },
}

-- and finally, return the configuration to wezterm
return config
