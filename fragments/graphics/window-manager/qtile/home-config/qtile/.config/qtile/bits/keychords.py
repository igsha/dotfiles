from libqtile.config import Key, KeyChord
from libqtile.lazy import lazy


def createKeyChords(mod):
    return [
        KeyChord([mod], "F12",
                 [
                     Key([], "s", lazy.spawn("systemctl suspend")),
                     Key([], "l", lazy.spawn("loginctl lock-session")),
                     Key([], "h", lazy.spawn("systemctl hibernate")),
                     Key(["shift"], "e", lazy.shutdown()),
                     Key(["shift"], "s", lazy.spawn("systemctl poweroff")),
                     Key(["shift"], "r", lazy.spawn("systemctl reboot"))
                 ],
                 mode=False,
                 name="System (l) lock, (s) suspend, (h) hibernate, (Shift+e) logout, (Shift+r) reboot, (Shift+s) shutdown"
        ),
        KeyChord([mod], "F11",
                 [
                     Key([], "Up", lazy.spawn("ponymix increase 5")),
                     Key([], "Down", lazy.spawn("ponymix decrease 5")),
                     Key([], "m", lazy.spawn("ponymix toggle")),
                 ],
                 mode=True,
                 name="Sound (Up) increase, (Down) decrease, (m) mute"
        ),
    ]
