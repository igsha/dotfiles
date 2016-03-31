from i3pystatus import Status
import netifaces

status = Status(standalone=True)

# documentation = http://docs.enkore.de/i3pystatus

status.register("clock", format="%a %b %-d %H:%M")
status.register("weather", location_code="RSXX1504", colorize=True, interval=300)
status.register("load", format="{avg1} {avg5} {avg15}")
status.register("cpu_usage", interval=5)
status.register("mem", format="{percent_used_mem:02.0f}%", round_size=0, interval=5);
#status.register("temp", format="{temp:.0f}°C", interval=5)

ifaces = netifaces.interfaces()
ignore_ifaces = ['lo', 'vboxnet0']
for iface in ifaces:
    if iface in ignore_ifaces:
        continue
    status.register("network", interface=iface, ignore_interfaces=ignore_ifaces,
            format_up="{interface}: {bytes_recv}↓{bytes_sent}↑ KBps", interval=5)

status.register("disk", path="/", format="{percentage_avail}% ({avail} GiB)", critical_limit=10, interval=15)
status.register("pulseaudio")
status.register("shell", command="xkb-switch | tr [:lower:] [:upper:]", interval=3)
status.register("keyboard_locks", caps_off='', num_off='', scroll_off='')

status.run()

