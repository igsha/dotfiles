def __pure_shinc1(x, N):
    return sin(pi*x)/sin(pi*x/N)/float(N) if abs(remainder(x, N)) > 2 * finfo(x).resolution else 1.0

shinc = vectorize(__pure_shinc1)

def __expshinc1(x, N):
    return exp(-1j*pi*(N-1)/float(N)*x)*(sin(pi*x)/sin(pi*x/N) if abs(remainder(x, N)) > 2 * finfo(x).resolution else float(N))

expshinc = vectorize(__expshinc1)

def __shincc(x, N):
    return sin(pi*x)**2 + sin(2*pi*x)/(2*tan(pi*x/N)) if abs(remainder(x, N)) > 2 * finfo(x).resolution else float(N)

shincc = vectorize(__shincc)

def __shincs(x, N):
    return sin(2*pi*x)/2.0 - sin(pi*x)**2/tan(pi*x/N) if abs(remainder(x, N)) > 2 * finfo(x).resolution else 0.0

shincs = vectorize(__shincs)
