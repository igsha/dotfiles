from libqtile import hook
import subprocess

from bits.keys import mod, keys
from bits.layouts import layouts
from bits.widgets import widget_defaults, extension_defaults
from bits.groups import groups, dgroups_key_binder, dgroups_app_rules, focus_on_window_activation
from bits.mouse import mouse, follow_mouse_focus, bring_front_click, cursor_warp
from bits.screens import screens, auto_fullscreen, reconfigure_screens


auto_minimize = False
wl_input_rules = None
wmname = "LG3D"

@hook.subscribe.startup_complete
def postautostart():
    subprocess.call('systemctl --user start graphical-session.target'.split())
    subprocess.call(['numlockx'])
