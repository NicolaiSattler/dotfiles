local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "rose-pine"
config.font = wezterm.font("Hack Nerd Font", { weight = 'Bold' })
config.font_size = 10
config.enable_tab_bar = false
config.window_decorations = "RESIZE"

config.default_domain = 'WSL:Ubuntu'

return config
