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
