local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "rose-pine"
config.font = wezterm.font("Hack Nerd Font", { weight = 'Bold' })
config.font_size = 10
config.enable_tab_bar = false
config.window_decorations = "RESIZE"

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
    config.default_domain = 'WSL:Ubuntu'
end


return config

