from libqtile.config import Key, KeyChord
from libqtile.lazy import lazy


def createKeyChords(mod):
    return [
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
