local wezterm = require("wezterm")
local act = wezterm.action

local direction_keys = {
  h = "Left",
  j = "Down",
  k = "Up",
  l = "Right",
}

local function is_vim(pane)
  return pane:get_user_vars().IS_NVIM == "true"
end

local function split_nav(resize_or_move, key)
  local moveMod = "CTRL"
  local resizeMod = "CTRL|ALT"
  return {
    key = key,
    mods = resize_or_move == "resize" and resizeMod or moveMod,
    action = wezterm.action_callback(function(win, pane)
      if is_vim(pane) then
        -- pass the keys through to vim/nvim
        win:perform_action({
          SendKey = { key = key, mods = resize_or_move == "resize" and resizeMod or moveMod },
        }, pane)
      else
        if resize_or_move == "resize" then
          win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
        else
          win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
        end
      end
    end),
  }
end

local function activateTab(n)
  return {
    key = tostring(n),
    mods = "ALT",
    action = act.ActivateTab(n - 1),
  }
end

local keys = {
  {
    key = "t",
    mods = "ALT",
    action = act.SpawnTab("CurrentPaneDomain"),
  },
  {
    key = "Space",
    mods = "ALT",
    action = act.QuickSelect,
  },
  {
    key = "c",
    mods = "ALT",
    action = act.ActivateCopyMode,
  },
  {
    key = "/",
    mods = "ALT",
    action = act.Search({ CaseInSensitiveString = "" }),
  },
  {
    key = "\\",
    mods = "ALT",
    action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "-",
    mods = "ALT",
    action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "h",
    mods = "ALT",
    action = act.ActivateTabRelative(-1),
  },
  {
    key = "l",
    mods = "ALT",
    action = act.ActivateTabRelative(1),
  },
  {
    key = "k",
    mods = "ALT",
    action = act.ScrollByLine(-1),
  },
  {
    key = "j",
    mods = "ALT",
    action = act.ScrollByLine(1),
  },
  {
    key = "u",
    mods = "CTRL|ALT",
    action = act.ScrollByPage(-0.5),
  },
  {
    key = "d",
    mods = "CTRL|ALT",
    action = act.ScrollByPage(0.5),
  },
  {
    key = "b",
    mods = "CTRL|ALT",
    action = act.ScrollByPage(-1),
  },
  {
    key = "f",
    mods = "CTRL|ALT",
    action = act.ScrollByPage(1),
  },
  -- move between split panes
  split_nav("move", "h"),
  split_nav("move", "j"),
  split_nav("move", "k"),
  split_nav("move", "l"),
  -- resize panes
  split_nav("resize", "h"),
  split_nav("resize", "j"),
  split_nav("resize", "k"),
  split_nav("resize", "l"),
}

for i = 1, 9 do
  table.insert(keys, activateTab(i))
end

return keys
