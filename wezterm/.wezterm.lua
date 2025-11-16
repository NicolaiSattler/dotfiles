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

	config.keys = {
		{ key = "Insert", mods = "SHIFT", action = wezterm.action.PasteFrom("Clipboard") },
	}
end

config.color_scheme = "Tokyo Night"
config.font = wezterm.font({ family = "JetBrains Mono" })

if wezterm.target_triple == "x86_64-apple-darwin" or wezterm.target_triple == "aarch64-apple-darwin" then
	config.font_size = 12
else
	-- Linux / Windows
	config.font_size = 10
end

config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

return config
