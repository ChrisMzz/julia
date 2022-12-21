#%%
from functools import lru_cache
import numpy as np
import matplotlib.pyplot as plt
import json




def mult(z, n):
    mult = 1
    for _ in range(n):
        mult *= z
    return mult

def julia(z, f, iter=100):
    z0 = z
    for _ in range(iter):
        z0 = f(z0)
    return z0

def julia_keep_iter(z,f, limit=None):
    z0 = z
    print(z0)
    cast = []
    iter = 0
    if limit == None:
        while complex(z0) == z0 and iter <= 100:
            z0 = f(z0)
            cast.append(z0)
            iter += 1
    else:
        while np.linalg.norm(z0) < limit and complex(z0) == z0 and iter <= 100:
            z0 = f(z0)
            cast.append(z0)
            iter += 1
    return cast




# %%
