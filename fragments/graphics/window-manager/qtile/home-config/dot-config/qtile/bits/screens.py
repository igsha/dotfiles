from os.path import expanduser

from libqtile import bar
from libqtile.config import Screen

from .widgets import main_widgets


screens = [
    Screen(
        top=bar.Bar(main_widgets, 28),
        wallpaper=expanduser('~/.wallpaper'),
        wallpaper_mode='fill'
    )
]

auto_fullscreen = True
reconfigure_screens = True
