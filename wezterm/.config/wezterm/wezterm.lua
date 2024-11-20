-- Pull in the wezterm API
local wezterm = require("wezterm")
local keys = require("keys")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.keys = keys

config.default_prog = { "/usr/bin/fish", "-l" }
if wezterm.target_triple == "aarch64-apple-darwin" then
  config.default_prog = { "/opt/homebrew/bin/fish", "-l" }
end

config.color_scheme = "Catppuccin Frappe"
config.font = wezterm.font("Hasklug Nerd Font")
config.font_size = 16

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.tab_max_width = 48

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
local function tab_title(tab_info)
  local title = tab_info.tab_title
  if not title or #title == 0 then
    title = tab_info.active_pane.title
  end
  if title:find("^nv ") or title:find("^nvim ") then
    title = title:sub("^nv ", " "):sub("^nvim ", " ")
  elseif title:find("^vim ") then
    title = title:sub("^vim ", " ")
  elseif title:find("^yay ") or title:find("^pacman ") then
    title = title:sub("^yay ", " "):sub("^pacman ", " ")
  elseif title:find("^ssh ") then
    title = title:sub("^ssh ", "󰣀 ")
  elseif title:find("^yazi ") then
    title = title:sub("^yazi ", " ")
  elseif title:find("^deno ") then
    title = title:sub("^deno ", "🦖 ")
  elseif title:find("^node ") then
    title = title:sub("^node ", " ")
  elseif title:find("^bundle ") or title:find("^ruby ") then
    title = title:sub("^bundle ", " "):sub("^ruby ", " ")
  end
  return title
end

local color_scheme = wezterm.color.get_builtin_schemes()[config.color_scheme]
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local edge_background = color_scheme.tab_bar.background
  local edge_foreground = color_scheme.tab_bar.inactive_tab.fg_color
  local text_background = color_scheme.tab_bar.inactive_tab.fg_color
  local text_foreground = color_scheme.tab_bar.inactive_tab.bg_color
  local left_edge = " "
  local right_edge = " "

  if tab.is_active then
    left_edge = " "
    right_edge = " "
    edge_foreground = color_scheme.tab_bar.active_tab.bg_color
    text_background = color_scheme.tab_bar.active_tab.bg_color
    text_foreground = color_scheme.tab_bar.active_tab.fg_color
  elseif hover then
    edge_foreground = color_scheme.tab_bar.inactive_tab_hover.bg_color
    text_background = color_scheme.tab_bar.inactive_tab_hover.bg_color
    text_foreground = color_scheme.tab_bar.inactive_tab_hover.fg_color
  end

  local title = tab_title(tab)
  title = tab.tab_index + 1 .. " " .. wezterm.truncate_right(title, max_width - 6)

  return {
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = left_edge },
    { Background = { Color = text_background } },
    { Foreground = { Color = text_foreground } },
    { Text = title },
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = right_edge },
  }
end)

config.enable_wayland = false

-- and finally, return the configuration to wezterm
return config
