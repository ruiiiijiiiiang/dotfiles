-- Pull in the wezterm API
local wezterm = require("wezterm")
local keys = require("keys")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.color_scheme = "Catppuccin Frappe"
config.window_background_opacity = 0.9

config.keys = keys

config.default_prog = { "/usr/bin/fish", "-l" }
if wezterm.target_triple == "aarch64-apple-darwin" then
	config.default_prog = { "/opt/homebrew/bin/fish", "-l" }
end

config.font = wezterm.font("Hasklug Nerd Font")
config.font_size = 12
config.hide_tab_bar_if_only_one_tab = true

-- and finally, return the configuration to wezterm
return config
