import scipy.io.wavfile as wavefile
import numpy as np
import numpy.fft as npft
from julia import julia, julia_keep_iter, mult

e = np.math.exp(1)
pi = np.math.pi




c = 0.277+0.01j
gamma = lambda i : 0.5*np.math.sin(4*pi*i) + np.math.sin(2*pi*i)*1j

f = lambda z0 : mult(z0, 2) + c

arg = lambda i : julia(gamma(i),f,8)

iters = [julia_keep_iter(gamma(i), f, 1000)[-2] for i in np.arange(0,1,1/16384)]
xlist = [np.math.cos(el.real % 2*pi) for el in iters]
ylist = [np.math.sin(el.imag % 2*pi) for el in iters]
testlist = [np.math.sin(64*pi*i) for i in np.arange(0,1,1/16384)]
x = np.array(xlist)
y = np.array(ylist)
test = np.array(testlist)
#fs, y = wavefile.read('y.wav')


wavefile.write(f'x{c}.wav', 44100, x)
wavefile.write(f'y{c}.wav', 44100, y)
wavefile.write('test-g.wav', 44100, test)
