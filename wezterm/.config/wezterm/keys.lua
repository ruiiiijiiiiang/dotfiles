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
	return {
		key = key,
		mods = resize_or_move == "resize" and "META" or "CTRL",
		action = wezterm.action_callback(function(win, pane)
			if is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = key, mods = resize_or_move == "resize" and "META" or "CTRL" },
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

local keys = {
	{
		key = "r",
		mods = "CMD|SHIFT",
		action = act.ReloadConfiguration,
	},
	{
		key = "c",
		mods = "CMD|SHIFT",
		action = act.ActivateCopyMode,
	},
	{
		key = "LeftArrow",
		mods = "CMD|SHIFT",
		action = act.ActivateTabRelative(-1),
	},
	{
		key = "RightArrow",
		mods = "CMD|SHIFT",
		action = act.ActivateTabRelative(1),
	},
	{
		key = "\\",
		mods = "CMD|SHIFT",
		action = act.SplitHorizontal,
	},
	{
		key = "-",
		mods = "CMD|SHIFT",
		action = act.SplitVertical,
	},
	{
		key = "u",
		mods = "CTRL|SHIFT",
		action = act.ScrollByPage(-0.5),
	},
	{
		key = "d",
		mods = "CTRL|SHIFT",
		action = act.ScrollByPage(0.5),
	},
	{
		key = "b",
		mods = "CTRL|SHIFT",
		action = act.ScrollByPage(-1),
	},
	{
		key = "f",
		mods = "CTRL|SHIFT",
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

return keys
