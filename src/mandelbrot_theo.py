#%%
from functools import lru_cache
import numpy as np
import matplotlib.pyplot as plt

N = 100
iter = 100
order = 101

def mult(z, n):
    mult = 1
    for _ in range(n):
        mult *= z
    return mult

def mandelbrot(c):
    global iter, order
    z0 = 0
    f = lambda z: mult(z, order) + c
    for _ in range(iter):
        z0 = f(z0)
    return z0

pix_colors = np.zeros((N, N))

for k in range(N):
    print(f"{100 * k / N} %")
    for l in range(N):
        pix_colors[k, l] = 0
        z = (k + l*1j)/N - 0.5 * (1 + 1j)
        score = mandelbrot(-4j * z)
        a = np.linalg.norm(score)
        if a > 50 or str(a) == "nan":
            pix_colors[k, l] = 1
        


## racines (n-1)-iemes

plt.imshow(pix_colors, cmap='Greys_r')
plt.show()

# %%
