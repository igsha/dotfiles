from scipy import interpolate
from scipy.signal import argrelextrema, argrelmax, argrelmin

def __shinc1(x, N):
    return sin(pi*x)/sin(pi*x/N) if abs(remainder(x, N)) > 2 * finfo(x).resolution else float(N)

shinc = vectorize(__shinc1)

def __expshinc1(x, N):
    return exp(1j*pi*(N-1)/N*x) * __shinc1(x, N)

expshinc = vectorize(__expshinc1)

def abf(x):
    return abs(fft.fft(x))

def slplot(x, fn, limits, *args):
    p = sum(limits) / 2
    lines, = plot(x, fn(p), *args)
    grid()

    param = Slider(axes([0.05, 0.03, 0.9, 0.02]), 'Param', limits[0], limits[1], valinit=p)
    param.on_changed(lambda _: lines.set_ydata(fn(param.val)))
