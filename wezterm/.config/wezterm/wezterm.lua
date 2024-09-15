local wezterm = require("wezterm")
local mux = wezterm.mux

wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window({})
	window:gui_window():maximize()
end)

local config = wezterm.config_builder()
--
--

config.font = wezterm.font("JetBrainsMono Nerd Font")
config.default_prog = { "/usr/bin/zsh" }
--
--
return config
