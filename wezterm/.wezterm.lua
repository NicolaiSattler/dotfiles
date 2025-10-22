local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	config.wsl_domains = {
		{
			name = "WSL:Ubuntu",
			distribution = "Ubuntu",
			default_cwd = "~",
			username = "nieksa",
		},
	}
	config.default_domain = "WSL:Ubuntu"
end

config.color_scheme = "Tokyo Night"
config.font = wezterm.font({ family = "JetBrains Mono" })
config.font_size = 10
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

return config
