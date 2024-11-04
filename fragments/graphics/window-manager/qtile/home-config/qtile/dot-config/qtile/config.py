from libqtile import hook, qtile
from libqtile.backend.wayland import InputConfig
import subprocess

from bits.keys import mod, keys
from bits.layouts import layouts, floating_layout
from bits.widgets import widget_defaults, extension_defaults
from bits.groups import groups, dgroups_key_binder, dgroups_app_rules, focus_on_window_activation
from bits.mouse import mouse, follow_mouse_focus, bring_front_click, cursor_warp
from bits.screens import screens, auto_fullscreen, reconfigure_screens


auto_minimize = False
wmname = "LG3D"

# qtile cmd-obj -o core -f get_inputs
wl_input_rules = {
    "type:keyboard": InputConfig(kb_layout="us,ru",
                                 kb_repeat_rate=40,
                                 kb_repeat_delay=250,
                                 kb_options="grp:sclk_toggle,grp:shift_caps_toggle,grp_led:scroll,keypad:pointerkeys"),
    "type:touch": InputConfig(natural_scroll=True)
}

@hook.subscribe.startup_once
def autostart():
    if qtile.core.name == "x11":
        keyboard = wl_input_rules["type:keyboard"]
        subprocess.call(["kbdd"])
        subprocess.call(["setxkbmap", "-layout", keyboard.kb_layout, "-option", keyboard.kb_options])
        subprocess.call(["xset", "r", "rate", str(keyboard.kb_repeat_delay), str(keyboard.kb_repeat_rate)])
        subprocess.call(["numlockx"])

@hook.subscribe.startup_complete
def postautostart():
    variables = ["DBUS_SESSION_BUS_ADDRESS",
                 "PATH",
                 "NIX_PATH",
                 "XDG_SESSION_ID",
                 "XDG_SESSION_TYPE",
                 "XDG_DATA_DIRS",
                 "XDG_CONFIG_DIRS",
                 "XDG_RUNTIME_DIR",
                 "XDG_CURRENT_DESKTOP",
                 "XDG_DESTOP_PORTAL_DIR"]

    if qtile.core.name == "wayland":
        variables.append("WAYLAND_DISPLAY")
    else:
        variables += ["DISPLAY", "XAUTHORITY"]

    subprocess.call(["systemctl", "--user", "import-environment", *variables])
    subprocess.call(["systemctl", "--user", "start", "graphical-session.target"])
    subprocess.call(["systemctl", "--user", "start", "xdg-autostart-if-no-desktop-manager.target"])
    if qtile.core.name == "wayland":
        subprocess.call(["systemctl", "--user", "start", "hypridle.service"])
