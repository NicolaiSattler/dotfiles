local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "rose-pine"
config.font = wezterm.font("Hack Nerd Font Mono")
config.font_size = 13
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.8
config.macos_window_background_blur = 10

return config
