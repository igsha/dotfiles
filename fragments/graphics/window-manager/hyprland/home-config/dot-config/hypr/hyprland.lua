-- https://wiki.hypr.land/Configuring/Start/

local directions = {"left", "right", "up", "down"}
local terminal = "alacritty"
local menu = "rofi -show drun"
local screenshot = "flameshot gui"
local calc = "popup-wcalc"
local translate = "popup-translate"
local shutdown = "rofi -show power -modes power:rofi-power-menu.sh"
local mainMod = "SUPER" -- Sets "Windows" key as main modifier

hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = "auto"
})

hl.on("hyprland.start", function ()
    hl.exec_cmd("uwsm app -- hyprland-per-window-layout")
end)

hl.config({
    general = {
        gaps_in = 0,
        gaps_out = 0,
        border_size = 2,
        col = {
            active_border = 0xff444444,
            inactive_border = 0xff000000,
        },
        -- Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = true,
        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,
        layout = dwindle,
    },
    decoration = {
        rounding = 0,
        -- Change transparency of focused and unfocused windows
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },
    animations = {
        enabled = true,
    },
    dwindle = {
        preserve_split = true, -- # You probably want this
    },
    master = {
        new_status = "master",
    },
    misc = {
        force_default_wallpaper = 2, -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo = false, -- If true disables the random hyprland logo / anime girl background. :(
        disable_autoreload = true,
    },
    cursor = {
        hide_on_key_press = true,
    },
    group = {
        col = {
            border_active = 0xff444444,
            border_inactive = 0xff000000,
        },
        groupbar = {
            enabled = true,
            render_titles = false,
            height = 1,
        },
    },
    input = {
        kb_layout = "us,ru",
        kb_variant = "",
        kb_model = "",
        kb_options = "grp:sclk_toggle,grp:shift_caps_toggle,grp_led:scroll,keypad:pointerkeys",
        kb_rules = "",
        numlock_by_default = true,
        repeat_rate = 40,
        repeat_delay = 250,
        follow_mouse = 0,
        sensitivity = 0, -- [-1.0, 1.0], 0 means no modification
        touchpad = {
            natural_scroll = false,
        },
    },
    gestures = {
        workspace_swipe_touch = false,
    },
})

-- https://wiki.hypr.land/Configuring/Basics/Binds/
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.window.close())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen_state({ internal = 2, client = 0, action = "toggle" }))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo()) -- dwindle
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- dwindle
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd(screenshot))
hl.bind(mainMod .. " + CONTROL + C", hl.dsp.exec_cmd(calc))
hl.bind(mainMod .. " + CONTROL + T", hl.dsp.exec_cmd(translate))
hl.bind(mainMod .. " + F12", hl.dsp.exec_cmd(shutdown))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.submap("resize"))

for _, dir in ipairs(directions) do
    -- Move focus with mainMod + arrow keys
    hl.bind(mainMod .. " + " .. dir,  hl.dsp.focus({ direction = dir }))
    -- Move windows
    hl.bind(mainMod .. " + SHIFT + " .. dir,  hl.dsp.window.move({ direction = dir }))
    -- Move window groups
    hl.bind(mainMod .. " + ALT + " .. dir, hl.dsp.window.move({ into_or_create_group = dir }))
    hl.bind(mainMod .. " + CONTROL + " .. left, hl.dsp.window.move({ out_of_group = dir }))
end

-- Window groups
hl.bind(mainMod .. " + T", hl.dsp.group.toggle())
hl.bind(mainMod .. " + Tab", hl.dsp.group.next())
hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.group.next())

-- Resize window
hl.define_submap("resize", function()
    -- Set repeating binds for resizing the active window.
    hl.bind("right", hl.dsp.window.resize({ x = 10, y = 0, relative = true}), { repeating = true })
    hl.bind("left", hl.dsp.window.resize({ x = -10, y = 0, relative = true}), { repeating = true })
    hl.bind("up", hl.dsp.window.resize({ x = 0, y = 10, relative = true}), { repeating = true })
    hl.bind("down", hl.dsp.window.resize({ x = 0, y = -10, relative = true}), { repeating = true })

    -- Use `reset` to go back to the global submap
    hl.bind("escape", hl.dsp.submap("reset"))
    hl.bind("return", hl.dsp.submap("reset"))
end)

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
hl.bind("XF86Tools", hl.dsp.exec_cmd("next-audio-sink.sh"), { locked = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})
hl.window_rule({
    name  = "float-popup",
    match = { class = "popup" },
    float = true,
})
