from libqtile.config import Key
from libqtile.lazy import lazy

from qtile_extras import widget
from qtile_extras.widget.decorations import PowerLineDecoration, RectDecoration

from .keys import keys


decor = dict(decorations=[RectDecoration()])

main_widgets = [
    widget.GroupBox(background="#444444", highlight_method='line', hide_unused=True, **decor),
    widget.CurrentLayoutIcon(background="#222222", **decor),

    widget.Prompt(background="#007f00", **decor),
    widget.Chord(background="#7f0000", foreground="#ffffff", markup=False, **decor),
    widget.WindowName(background="#222222", **decor),

    widget.CapsNumLockIndicator(background="#333333", **decor),
    widget.KeyboardKbdd(background="#444444", configured_keyboards=['us', 'ru'], **decor),

    widget.DF(partition='/', measure='G', warn_space=20, visible_on_warn=True, **decor),
    widget.CPU(background="#333333", format=' {load_percent}%', **decor),
    widget.Memory(background="#222222", measure_mem='G',
                  format=' {MemUsed:.1f}{mm}/{MemTotal:.1f}{mm}[{SwapUsed:.1f}{mm}]', **decor),
    widget.Net(background="#111111", use_bits=True,
               format='▼ {down: >6}▲ {up: >6}', **decor),
    widget.Volume(background="#555555", fmt='󱄠 {}', **decor),
    widget.Battery(background="#111111", notify_below=5, charge_char='󰂄', discharge_char='󰁹',
                   format='{char}{percent:2.0%}[{hour:02d}:{min:02d}]', **decor),

    widget.Wttr(background="#222222", location={'Moscow': 'M'}, format='☂ %t(%f)/%h/%P', **decor),
    widget.Wlan(background="#333333", update_iterval=5, format='  {essid}[{percent:2.0%}]', **decor),

    # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
    #widget.StatusNotifier(**decor),
    widget.Systray(**decor),
    widget.Clock(background="#444444", format="%a, %Y-%m-%d %H:%M", **decor),
]

widget_defaults = dict(font="Roboto Mono", fontsize=14, padding=1)
extension_defaults = widget_defaults.copy()
