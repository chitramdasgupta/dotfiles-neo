local wezterm = require("wezterm")
local mux = wezterm.mux

wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window({})
	window:gui_window():maximize()
end)

local config = wezterm.config_builder()
--
--

-- config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font = wezterm.font("BerkeleyMono")
config.default_prog = { "/usr/bin/zsh" }

config.color_scheme = "rose-pine"
-- config.color_scheme = "rose-pine-dawn" -- Light theme
--
--
return config
