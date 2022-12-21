from PIL import Image

gif = []
files = []
n = 200

for i in range(n+1):
    files.append(f"julia-{i}.jpeg")

for f in files:
    gif.append(Image.open(f"julia-images/{f}"))
    print(f)
gif[0].save('julia-lnzoom.gif', save_all=True, optimize=False, append_images=gif[1:], loop=0)





