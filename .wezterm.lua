local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.enable_wayland = false
config.front_end = "OpenGL"
config.hide_tab_bar_if_only_one_tab = true
config.force_reverse_video_cursor = true
--config.colors = require("kanagawa")
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.initial_rows = 39
config.initial_cols = 126
config.window_decorations = "TITLE|RESIZE|MACOS_FORCE_DISABLE_SHADOW"
--config.font = wezterm.font_with_fallback({
--{ family = "Iosevka Term", weight = "Medium" },
--{ family = "JetBrains Mono", weight = "Medium" },
--})
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.window_close_confirmation = "NeverPrompt"
config.window_background_opacity = 0.92
config.macos_window_background_blur = 15

config.keys = {
	{
		key = "Enter",
		mods = "ALT",
		action = wezterm.action.DisableDefaultAssignment,
	},
}

local hostname = wezterm.hostname()
if hostname == "archlinux" then
	config.font_size = 14.0
else
	config.font_size = 14.0
end

return config
