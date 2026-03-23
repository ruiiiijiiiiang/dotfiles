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

local function smart_abbreviate(path, max_len)
  local home = os.getenv("HOME") or ""
  local result = path:gsub(home, "~")

  if #result <= max_len then
    return result
  end

  local parts = {}
  for segment in string.gmatch(result, "[^/]+") do
    table.insert(parts, segment)
  end

  if #parts > 1 then
    for i = 1, #parts - 1 do
      if parts[i] ~= "~" then
        parts[i] = string.sub(parts[i], 1, 1)
      end
    end
  end

  local prefix = result:sub(1, 1) == "/" and "/" or ""
  return prefix .. table.concat(parts, "/")
end

wezterm.on("update-right-status", function(window, pane)
  local success, cwd_uri = pcall(function()
    return pane:get_current_working_dir()
  end)

  local hostname = "local"
  local cwd = ""

  if success and cwd_uri then
    hostname = cwd_uri.host
    cwd = smart_abbreviate(cwd_uri.file_path, 20)
  end

  local cells = {
    { Background = { Color = color_scheme.tab_bar.background } },
    { Foreground = { Color = accent } },
    { Text = "" },
    { Background = { Color = accent } },
    { Foreground = { Color = color_scheme.tab_bar.background } },
    { Text = "  " .. cwd .. "@" .. hostname .. " " },
  }
  window:set_right_status(wezterm.format(cells))
end)

config.ssh_domains = {
  {
    name = "vm-app",
    remote_address = "vm-app",
  },
  {
    name = "vm-monitor",
    remote_address = "vm-monitor",
  },
  {
    name = "vm-network",
    remote_address = "vm-network",
  },
}

return config
