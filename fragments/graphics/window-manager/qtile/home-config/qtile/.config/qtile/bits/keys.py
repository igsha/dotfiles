from libqtile.config import Key, KeyChord
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

from .keychords import createKeyChords

mod = "mod4"

default_directions = {'left': (-10, 0),
                      'up': (0, -10),
                      'right': (10, 0),
                      'down': (0, 10)}

@lazy.function
def window_move(qtile, direction):
    shuffles = lambda x: {'left': x.cmd_shuffle_left,
                          'up': x.cmd_shuffle_up,
                          'right': x.cmd_shuffle_right,
                          'down': x.cmd_shuffle_down}

    if qtile.current_window.floating:
        qtile.current_window.cmd_move_floating(*default_directions[direction])
    else:
        shuffles(qtile.current_layout)[direction]()

@lazy.function
def window_resize(qtile, direction):
    grows = lambda x: {'left': x.cmd_grow_left,
                       'up': x.cmd_grow_up,
                       'right': x.cmd_grow_right,
                       'down': x.cmd_grow_down}

    if qtile.current_window.floating:
        qtile.current_window.cmd_resize_floating(*default_directions[direction])
    else:
        State.grows(qtile.current_layout)[direction]()

keys = [
    # Switch between windows
    Key([mod], "Left", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "Right", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "Down", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "Up", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "Tab", lazy.group.next_window(), desc="Move window focus to other window"),
    Key([mod, "shift"], "Tab", lazy.group.prev_window(), desc="Move window focus to other window"),
    Key(["mod1"], "Tab", lazy.spawn("rofi -show window"), desc="Choose window"),
    # Move windows between left/right columns or move up/down in current stack.
    Key([mod, "shift"], "Left", window_move('left'), desc="Move window to the left"),
    Key([mod, "shift"], "Right", window_move('right'), desc="Move window to the right"),
    Key([mod, "shift"], "Down", window_move('down'), desc="Move window down"),
    Key([mod, "shift"], "Up", window_move('up'), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "Left", window_resize('left'), desc="Grow window to the left"),
    Key([mod, "control"], "Right", window_resize('right'), desc="Grow window to the right"),
    Key([mod, "control"], "Down", window_resize('down'), desc="Grow window down"),
    Key([mod, "control"], "Up", window_resize('up'), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggles
    Key([mod], "space", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Fullscreen"),
    Key([mod], "s", lazy.window.toggle_floating(), desc="Toggle floating"),
    # Commands
    Key([mod, "shift"], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown qtile"),
    Key([mod], "Return", lazy.spawn(guess_terminal()), desc="Launch terminal"),
    Key([mod], "r", lazy.spawn("rofi -show run"), desc="Spawn a command using a prompt widget"),
    Key([mod], "Print", lazy.spawn("flameshot gui"), desc="Take a screenshot"),
    # Sound
    Key([], "XF86AudioRaiseVolume", lazy.spawn("ponymix increase 5"), desc="Increase volume"),
    Key([], "XF86AudioLowerVolume", lazy.spawn("ponymix decrease 5"), desc="Decrease volume"),
    Key([], "XF86AudioMute", lazy.spawn("ponymix toggle"), desc="Mute/unmute volume"),
    # Misc
    Key([mod, "control"], "c", lazy.spawn("popup-wcalc")),
    Key([mod, "control"], "t", lazy.spawn("popup-translate")),
    Key([mod], "F12", lazy.spawn("rofi -show power -modes power:rofi-power-menu.sh")),
    Key([mod], "F1", lazy.spawn("dunstctl close")),
] + createKeyChords(mod)
