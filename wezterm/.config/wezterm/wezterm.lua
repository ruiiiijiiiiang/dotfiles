-- Pull in the wezterm API
local wezterm = require("wezterm")
local keys = require("keys")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.color_scheme = "Catppuccin Frappe"

config.keys = keys
config.default_prog = { "/opt/homebrew/bin/fish", "-l" }

config.font = wezterm.font("Hasklug Nerd Font")
config.font_size = 14

-- and finally, return the configuration to wezterm
return config
