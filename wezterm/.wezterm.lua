local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- config.term = "xterm-256color"
config.disable_default_key_bindings = true
config.keys = {}
config.key_tables = {}

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

config.color_scheme = "tokyonight_moon"

if wezterm.target_triple == "x86_64-apple-darwin" or wezterm.target_triple == "aarch64-apple-darwin" then
	config.font_size = 12
	config.font = wezterm.font({ family = "JetBrains Mono", weight = 700 })
	config.color_scheme_dirs = { "$HOME/.config/wezterm/colors" }
else
	-- Linux / Windows
	config.font_size = 11
	config.font_rules = {
		{
			intensity = "Half",
			italic = true,
			font = wezterm.font({ family = "JetBrains Mono", weight = 600 }),
		},
	}
	config.color_scheme_dirs = { "C:/Users/NicolaiS/colors" }
end

config.adjust_window_size_when_changing_font_size = false
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.initial_cols = 30
config.initial_rows = 120
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

return config
