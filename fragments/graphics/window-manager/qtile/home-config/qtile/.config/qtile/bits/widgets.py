import subprocess, re, pathlib

from libqtile.config import Key
from libqtile.lazy import lazy

from qtile_extras import widget
from qtile_extras.widget.decorations import PowerLineDecoration, RectDecoration

from .keys import keys


def poll_indicators():
    output = subprocess.check_output(['xset', 'q'])
    mapping = dict(Caps='C', Num='N', Scroll='S')
    color_map = dict(on='green', off='black')
    transform = lambda k: f'<span foreground="{color_map[k[1]]}">{mapping[k[0]]}</span>'
    states = map(transform, re.findall(r"(Caps|Num|Scroll)\s+Lock:\s*(\w+)", output.decode()))
    return ' '.join(states)


decor = dict(decorations=[RectDecoration()])

main_widgets = [
    widget.GroupBox(background="#444444", highlight_method='line', hide_unused=True, **decor),
    widget.CurrentLayoutIcon(background="#222222", **decor),

    widget.Prompt(background="#007f00", **decor),
    widget.Chord(background="#7f0000", foreground="#ffffff", markup=False, **decor),
    widget.WindowName(background="#222222", **decor),

    widget.GenPollText(background="#333333", func=poll_indicators, update_interval=0.5, **decor),
    widget.KeyboardKbdd(background="#444444", configured_keyboards=['us', 'ru'], **decor),

    widget.DF(partition='/', measure='G', warn_space=40, visible_on_warn=True, **decor),
    widget.CPU(background="#333333", format=' {load_percent: 3.0f}%', **decor),
    widget.Memory(background="#222222", measure_mem='G', measure_swap='G',
                  format=' {MemUsed:.1f}{mm}/{MemTotal:.1f}{mm}[{SwapUsed:.1f}{ms}]', **decor),
]

is_bluetooth, is_wlan = False, False
for f in pathlib.Path('/sys/class/rfkill').glob('rfkill*/type'):
    is_bluetooth |= open(f).read().startswith('bluetooth')
    is_wlan |= open(f).read().startswith('wlan')

if is_bluetooth:
    main_widgets += [
        widget.Bluetooth(background="#555555", **decor),
    ]

if is_wlan:
    main_widgets += [
        widget.Wlan(background="#333333", update_iterval=5, format='  {essid}[{percent:2.0%}]', **decor),
    ]

main_widgets += [
    widget.Net(background="#111111", use_bits=True,
               format='▼ {down: >6}▲ {up: >6}', **decor),
    widget.Volume(background="#555555", fmt='󱄠 {}', **decor),
]

if list(pathlib.Path('/sys/class/power_supply').glob('BAT*')) != []:
    main_widgets += [
        widget.Battery(background="#111111", notify_below=5, charge_char='󰂄', discharge_char='󰁹',
                       format='{char}{percent:2.0%}[{hour:02d}:{min:02d}]', **decor),
    ]

main_widgets += [
    widget.Wttr(background="#222222", location={'Moscow': 'M'}, format='☂ %t(%f)/%h/%P', **decor),

    # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
    #widget.StatusNotifier(**decor),
    widget.Systray(**decor),
    widget.Clock(background="#444444", format="%a, %Y-%m-%d %H:%M", **decor),
]

widget_defaults = dict(font="Roboto Mono", fontsize=14, padding=5)
extension_defaults = widget_defaults.copy()
