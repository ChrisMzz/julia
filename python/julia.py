#%%
from functools import lru_cache
import numpy as np
import matplotlib.pyplot as plt
import json
import cmath

from tqdm import tqdm



f = open("settings.json")
settings = json.load(f)["settings"]

# Display Settings
N = settings["display_settings"]["N"]
layers = settings["display_settings"]["layers"]
layering_factor = settings["display_settings"]["layering_factor"]
cmap = settings["display_settings"]["cmap"]

# Julia Settings
iter = settings["julia_settings"]["iter"]
thresh =settings["julia_settings"]["thresh"]
order = settings["julia_settings"]["order"]

c = complex(settings["julia_settings"]["c"])




def mult(z, n):
    mult = 1
    for _ in range(n):
        mult *= z
    return mult

def julia(z):
    global c, iter, order
    z0 = z
    f = lambda z: mult(z, order) + c
    #f = lambda z: cmath.sin(z)
    for _ in range(iter):
        if np.linalg.norm(z0) > 500:
            return z0
        else:
            z0 = f(z0)
    return z0

pix_colors = np.zeros((N, N))

for k in tqdm(range(N), ncols=100):
    for l in range(N):
        pix_colors[k, l] = 0
        z = (k + l*1j)/N - 0.5 * (1 + 1j)
        score = julia(-4j * z)
        a = np.linalg.norm(score)
        if a > thresh or str(a) == "nan":
            pix_colors[k, l] = 1
        elif a > 0.01:
            segmentation = [eps for eps in np.arange(0,1, 1/layers)]
            pix_colors[k, l] = segmentation[int((np.math.log(a)/np.math.log(layering_factor)) % layers)]
        



plt.imshow(pix_colors, cmap=cmap)
plt.xticks([N*i/4 for i in range(5)], [((N)*k-2*N)/N for k in range(5)])
plt.yticks([N*i/4 for i in range(5)], [(2*N-(N)*k)/N for k in range(5)])



#plt.show()
filename = f"dump/c={c}_N={N}_it={iter}_thr={thresh}_l={layers}_lf={layering_factor}_o={order}.png"
#filename = f"dump/c={c}_sin(z).png"
plt.title(f"Ensemble de Julia quadratique d'ordre {order} pour c={c}\n{iter} itérations ({N}x{N}).")
#plt.title(f"Ensemble de Julia pour f(z) = sin(z)\n {iter} itérations ({N}x{N}).")
plt.savefig(filename, dpi=600, format="png")




# %%
