import subprocess, re, pathlib

from libqtile import qtile
from libqtile.lazy import lazy

from qtile_extras import widget
from qtile_extras.widget.decorations import PowerLineDecoration, RectDecoration
from qtile_extras.widget.mixins import TooltipMixin

from .keys import keys


def poll_indicators():
    output = subprocess.check_output(['xset', 'q'])
    mapping = dict(Caps='C', Num='N', Scroll='S')
    color_map = dict(on='green', off='black')
    transform = lambda k: f'<span foreground="{color_map[k[1]]}">{mapping[k[0]]}</span>'
    states = map(transform, re.findall(r"(Caps|Num|Scroll)\s+Lock:\s*(\w+)", output.decode()))
    return ' '.join(states)


def poll_net():
    def isup(p):
        return p.parent.name != "lo" and open(p).read().strip() == "1"

    nets = filter(isup, pathlib.Path("/sys/class/net/").glob("*/carrier"))
    return "🖧" + ",".join(map(lambda p: p.parent.name, nets))


class MyWttr(widget.Wttr, TooltipMixin):
    def __init__(self, *args, **kwargs):
        widget.Wttr.__init__(self, format="%c:%t:%h:%P", *args, **kwargs)
        TooltipMixin.__init__(self, **kwargs)
        self.add_defaults(TooltipMixin.defaults)
        self.tooltip_text = ""

    def parse(self, response):
        response = super().parse(response)
        arr = response.split(":")
        if len(arr) < 4:
            return response
        else:
            self.tooltip_text = f"Temperature: {arr[1]}\nHumidity: {arr[2]}\nPressure: {arr[3]}"
            return ''.join(map(str.strip, arr[:2]))


decor = dict(decorations=[RectDecoration()])

main_widgets = [
    widget.GroupBox(background="#444444", highlight_method='line', hide_unused=True, **decor),
    widget.CurrentLayoutIcon(background="#222222", **decor),

    widget.Prompt(background="#007f00", **decor),
    widget.Chord(background="#7f0000", foreground="#ffffff", markup=False, **decor),
    widget.WindowName(background="#222222", **decor),
]

if qtile.core.name == "wayland":
    main_widgets.append(widget.KeyboardKbdd(background="#444444", configured_keyboards=['us', 'ru'], **decor))
else:
    main_widgets += [
        widget.GenPollText(background="#333333", func=poll_indicators, update_interval=0.5, **decor),
        widget.KeyboardKbdd(background="#444444", configured_keyboards=['us', 'ru'], **decor),
    ]

main_widgets += [
    widget.DF(partition='/', measure='G', warn_space=40, visible_on_warn=True, **decor),
    widget.CPU(background="#333333", format=' {load_percent:3.0f}%', **decor),
    widget.Memory(background="#222222", measure_mem='G', format=' {MemPercent:2.0f}%', **decor),
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
        widget.Wlan(background="#333333", update_iterval=5, format='  {essid}[{percent:2.0%}]',
                    disconnected_message='󰖪', **decor),
    ]

main_widgets += [
    widget.GenPollText(background="#333333", func=poll_net, update_interval=3, **decor),
    widget.Net(background="#111111", use_bits=True,
               format='▼{down:5.0f}{down_suffix:<2}▲{up:5.0f}{up_suffix:<2}', **decor),
    widget.PulseVolume(background="#555555", fmt='󱄠 {}',
                       mouse_callbacks={'Button3': lazy.spawn("pavucontrol"),
                                        'Button1': lazy.spawn("ponymix toggle")}, **decor),
]

if list(pathlib.Path('/sys/class/power_supply').glob('BAT*')) != []:
    main_widgets += [
        widget.Battery(background="#111111", notify_below=5, charge_char='󰂄', discharge_char='󰁹',
                       format='{char}{percent:2.0%}[{hour:02d}:{min:02d}]', **decor),
    ]

main_widgets += [
    MyWttr(background="#222222", location={'Moscow': 'M'}, **decor),
]

if qtile.core.name == "wayland":
    main_widgets.append(widget.StatusNotifier(**decor))
else:
    main_widgets.append(widget.Systray(**decor))

main_widgets += [
    widget.Clock(background="#444444", format="%a, %Y-%m-%d %H:%M", **decor),
]

widget_defaults = dict(font="Roboto Mono", fontsize=14, padding=5)
extension_defaults = widget_defaults.copy()
