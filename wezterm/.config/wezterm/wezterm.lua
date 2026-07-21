-- Pull in the wezterm API
local wezterm = require("wezterm")
local config = wezterm.config_builder()

local last_explorer_cwd = {}

package.loaded["keys"] = nil
config.keys = require("keys")

if not wezterm.target_triple:find("windows") then
  config.default_prog = { "fish", "-l" }
else
  config.default_prog = { "powershell.exe", "-NoLogo" }
end

config.color_scheme = "Catppuccin Frappe"
local color_scheme = wezterm.color.get_builtin_schemes()[config.color_scheme]
local accent = "#babbf1"

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
  elseif title:find("^agy") or title:find("^OpenCode") or title:find("^codex") then
    title = title:gsub("^agy", " "):gsub("^OpenCode", " "):gsub("^codex", " ")
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
  if pane:get_user_vars().WEZTERM_ROLE == "explorer" then
    local tab = window:active_tab()
    if tab then
      for _, p in ipairs(tab:panes()) do
        if p:get_user_vars().WEZTERM_ROLE ~= "explorer" then
          p:activate()
          break
        end
      end
    end
    return
  end

  local success, cwd_uri = pcall(function()
    return pane:get_current_working_dir()
  end)

  local hostname = "local"
  local cwd = ""

  if success and cwd_uri then
    hostname = cwd_uri.host or "local"
    cwd = smart_abbreviate(cwd_uri.file_path, 20)
  end

  local tab = window:active_tab()
  if tab then
    local explorer_pane = nil
    for _, p in ipairs(tab:panes()) do
      if p:get_user_vars().WEZTERM_ROLE == "explorer" then
        explorer_pane = p
        break
      end
    end

    if explorer_pane and pane:pane_id() ~= explorer_pane:pane_id() then
      local success_cwd, cwd_val = pcall(function()
        return pane:get_current_working_dir()
      end)
      if success_cwd and cwd_val then
        local current_cwd = cwd_val.file_path
        local exp_id = explorer_pane:pane_id()
        if last_explorer_cwd[exp_id] ~= current_cwd then
          last_explorer_cwd[exp_id] = current_cwd
          explorer_pane:send_text(current_cwd .. "\n")
        end
      end
    end
  end

  local cells = {
    { Background = { Color = color_scheme.tab_bar.background } },
    { Foreground = { Color = accent } },
    { Text = "" },
    { Background = { Color = accent } },
    { Foreground = { Color = color_scheme.tab_bar.background } },
    { Text = "  " .. cwd },
    { Attribute = { Italic = true } },
    { Text = "@" .. hostname .. " " },
  }
  window:set_right_status(wezterm.format(cells))
end)

config.ssh_domains = {
  {
    name = "hypervisor",
    remote_address = "hypervisor",
    username = "rui",
  },
  {
    name = "vm-app",
    remote_address = "vm-app",
    username = "rui",
  },
  {
    name = "vm-monitor",
    remote_address = "vm-monitor",
    username = "rui",
  },
  {
    name = "vm-network",
    remote_address = "vm-network",
    username = "rui",
  },
  {
    name = "vm-public",
    remote_address = "vm-public",
    username = "rui",
  },
  {
    name = "windows",
    remote_address = "windows",
    username = "rui",
  },
}

return config
