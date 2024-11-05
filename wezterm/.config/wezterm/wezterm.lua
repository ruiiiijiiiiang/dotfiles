-- Pull in the wezterm API
local wezterm = require("wezterm")
local keys = require("keys")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.keys = keys

config.default_prog = { "fish", "-l" }

config.color_scheme = "Catppuccin Frappe"
config.font = wezterm.font("Hasklug Nerd Font")
config.font_size = 16

config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

config.enable_wayland = false

-- and finally, return the configuration to wezterm
return config
