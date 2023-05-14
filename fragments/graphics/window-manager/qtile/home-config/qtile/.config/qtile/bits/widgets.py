from libqtile.config import Key
from libqtile.lazy import lazy

from qtile_extras import widget
from qtile_extras.widget.decorations import PowerLineDecoration

from .keys import keys


powerline = dict(decorations=[PowerLineDecoration()])

main_widgets = [
    widget.GroupBox(background="#444444", highlight_method='line', hide_unused=True, **powerline),
    widget.CurrentLayoutIcon(background="#222222", **powerline),

    widget.Prompt(background="#007f00", **powerline),
    widget.Chord(background="#7f0000", foreground="#ffffff", markup=False, **powerline),
    widget.WindowName(background="#222222", **powerline),

    widget.CapsNumLockIndicator(background="#333333", **powerline),
    widget.KeyboardKbdd(background="#444444", configured_keyboards=['us', 'ru'], **powerline),

    widget.DF(partition='/', measure='G', warn_space=20, visible_on_warn=True, **powerline),
    widget.CPU(background="#333333", format="CPU: {load_percent}%", **powerline),
    widget.Memory(background="#222222", measure_mem='G', format='Mem: {MemUsed:.1f}{mm}/{MemTotal:.1f}{mm}[{SwapUsed:.1f}{mm}]', **powerline),
    widget.Net(background="#111111", use_bits=True, **powerline),
    widget.Volume(background="#555555", fmt='Vol: {}', **powerline),
    widget.Battery(background="#111111", notify_below=5, charge_char='+', discharge_char='',
                   format='Bat: {char}{percent:2.0%}[{hour:02d}:{min:02d}]', **powerline),

    widget.Wttr(background="#222222", location={'Moscow': 'M'}, format="%t(%f)/%h/%P", **powerline),
    widget.WiFiIcon(background="#333333", **powerline),

    # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
    #widget.StatusNotifier(**powerline),
    widget.Systray(**powerline),
    widget.Clock(background="#444444", format="%a, %Y-%m-%d %H:%M"),
]

widget_defaults = dict(font="sans", fontsize=14, padding=1)
extension_defaults = widget_defaults.copy()
