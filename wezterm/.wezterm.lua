local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.disable_default_key_bindings = true
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

function get_os_type()
	local handle = io.popen("uname -s")
	if handle then
		local result = handle:read("*l")
		handle:close()
		return result
	end
	return nil
end

local os_type = get_os_type()

if os_type == "Linux" then
	config.default_domain = "WSL:Ubuntu"
	config.font_size = 10
else
	config.font_size = 11
end

return config
