from libqtile.config import Group, Key, Match
from libqtile.lazy import lazy

from .keys import keys, mod


groups = [
    Group("1", matches=[Match(wm_class=["Alacritty"])]),
    Group("2", matches=[Match(wm_class=["qutebrowser"])]),
    Group("3", matches=[Match(wm_class=["Thunderbird", "Evolution", "Mail", "betterbird"])]),
    Group("4", matches=[Match(wm_class=["telegram-desktop"])]),
    Group("5", matches=[Match(wm_class=["Steam", "steam", "rocket.chat", "Rocket.Chat", "Skype"])]),
]

groups += list(map(Group, "67890"))

for i in groups:
    n = i.name
    keys += [
        Key([mod], n, lazy.group[n].toscreen(toggle=True), desc=f"Switch to group {n}"),
        Key([mod, "shift"], n, lazy.window.togroup(n, switch_group=False), desc=f"Move focused window to group {n}"),
    ]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
focus_on_window_activation = "smart"
