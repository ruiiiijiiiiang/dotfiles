-- Pull in the wezterm API
local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.keys = require("keys")

config.default_prog = { "fish", "-l" }

config.color_scheme = "Catppuccin Frappe"
config.window_background_opacity = 0.95
local color_scheme = wezterm.color.get_builtin_schemes()[config.color_scheme]
local accent = "#babbf1" -- lavender

config.font = wezterm.font("Maple Mono")
config.font_size = 14

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
  if not title:find(" ") then
    title = " " .. title
  elseif title:find(".+@.+:%s.+") then
    title = "󰣀 " .. title
  elseif title:find("^sudo ") then
    title = "󰦝 " .. title
  elseif title:find("^ Gemini") then
    title = title:gsub("^ Gemini", " ")
  elseif title:find("^nv ") or title:find("^nvim ") then
    title = title:gsub("^nv ", " "):gsub("^nvim ", " ")
  elseif title:find("^vim ") then
    title = title:gsub("^vim ", " ")
  elseif title:find("^cargo ") then
    title = title:gsub("^cargo ", " ")
  elseif title:find("^yay ") or title:find("^pacman ") or title:find("^paru ") then
    title = title:gsub("^yay ", " "):gsub("^pacman ", " "):gsub("^paru ", " ")
  elseif title:find("^nix") or title:find("^nh ") then
    title = title:gsub("^nix", "󱄅 "):gsub("^nh", "󱄅 ")
  elseif title:find("^Yazi:") then
    title = title:gsub("^Yazi:", " ")
  elseif title:find("^deno ") then
    title = title:gsub("^deno ", "🦖 ")
  elseif title:find("^node ") then
    title = title:gsub("^node ", " ")
  elseif title:find("^bundle ") or title:find("^irb ") then
    title = title:gsub("^bundle ", " "):gsub("^irb ", " ")
  end
  return title
end

wezterm.on("format-tab-title", function(tab, _, _, _, hover, max_width)
  local edge_background = color_scheme.tab_bar.background
  local edge_foreground = color_scheme.tab_bar.new_tab.bg_color
  local text_background = color_scheme.tab_bar.new_tab.bg_color
  local text_foreground = color_scheme.tab_bar.new_tab_hover.fg_color
  local left_edge = ""
  local right_edge = ""
  local italic = false

  if tab.is_active then
    edge_foreground = accent
    text_background = accent
    text_foreground = color_scheme.tab_bar.active_tab.fg_color
    italic = true
  elseif hover then
    edge_foreground = color_scheme.tab_bar.new_tab_hover.bg_color
    text_background = color_scheme.tab_bar.new_tab_hover.bg_color
  end

  local title = tab_title(tab)
  title = tab.tab_index + 1 .. " " .. wezterm.truncate_right(title, max_width - 6)

  return {
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = left_edge },
    { Background = { Color = text_background } },
    { Foreground = { Color = text_foreground } },
    { Attribute = { Italic = italic } },
    { Text = title },
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = right_edge },
  }
end)

wezterm.on("update-right-status", function(window, pane)
  local cwd = pane:get_current_working_dir().file_path
  local cells = {
    { Background = { Color = color_scheme.tab_bar.background } },
    { Foreground = { Color = accent } },
    { Text = "" },
    { Background = { Color = accent } },
    { Foreground = { Color = color_scheme.tab_bar.background } },
    { Text = "  " .. cwd .. " " },
  }
  window:set_right_status(wezterm.format(cells))
end)

return config
