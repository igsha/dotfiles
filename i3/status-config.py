from i3pystatus import Status
from i3pystatus.weather import weathercom
import netifaces

status = Status(standalone=True)

# documentation = http://docs.enkore.de/i3pystatus

status.register("clock", format="%a %b %-d %H:%M")
status.register("weather", colorize=True, interval=300,
        backend=weathercom.Weathercom(
            location_code='RSXX1504',
            units='metric'
        )
)
status.register("load", format="{avg1} {avg5} {avg15}")
status.register("cpu_usage", interval=5)
status.register("mem", format="{percent_used_mem:02.0f}%", round_size=0, interval=5);

ifaces = netifaces.interfaces()
gateways = netifaces.gateways()
values = list(gateways['default'].values())
try:
    iface = values[0][44]
except IndexError: # gateway is not available yet
    iface = ''

if iface not in ifaces:
    iface = ifaces[int(len(ifaces) / 2)]

status.register("network", interface=iface,
        format_down="DOWN: {interface}", graph_style="braille-fill", detached_down=False,
        format_up="{bytes_recv}↓{bytes_sent}↑ KBps {network_graph}: {interface}", interval=5)

status.register("disk", path="/", format="{percentage_avail}% ({avail} GiB)", critical_limit=10, interval=15)
status.register("pulseaudio")
status.register("shell", command="xkb-switch | tr [:lower:] [:upper:]", interval=3)
status.register("keyboard_locks", caps_off='', num_off='', scroll_off='')
status.register("runwatch", path='/tmp/message-recorder.pid', name='mic', format_down='', interval=3)

status.run()
