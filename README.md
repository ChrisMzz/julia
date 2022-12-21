# Ensembles de Julia - Collection de fichiers

Une collection des fichiers créés pour le rapport de recherche que nous avons écrit sur les ensembles de Julia.

## Python

En utilisant le module `matplotlib.pyplot`, on peut afficher un array de pixels colorés selon la fonction `julia()` définie dans le fichier `julia.py`.
Le module `tqdm` est importé pour avoir une barre de progression lors de l'exportation d'une image.

Les paramètres disponibles à l'utilisateur sont modifiables dans le fichier `settings.json` (car c'est très pratique de stocker et modifier des données dans un fichier `json`).

---
### Explication des paramètres

L'image est en résolution de $N \times N$, donc l'utilisateur peut bien sûr modifier le paramètre `N`.

Une colormap est utilisée pour colorier les pixels. On peut choisir entre la création d'une cmap personalisée à l'aide de la classe `ListedColormap` de `matplotlib`, ou utiliser une cmap prédéfinie. 
Dans les deux cas, celle-ci est segmentée en `layers` couches, qui seront espacées selon une échelle logarithmique en base `layering_factor`.
Le paramètre `cmap` dans le fichier JSON ne permet pas de créer une cmap personalisée, mais celle-ci *peut être redéfinie dans le fichier Python directement*.

Les paramètres qui affectent l'ensemble de Julia directement :
 - `iter` : le nombre d'itérations $n$ à faire.
 - `thresh` : le seuil à partir duquel on considère que la valeur approche $+\infty$.
   - Pour une norme de $\lvert z_n \rvert < 0.1$, on considèrera que $z_n$ est bornée. Pour $0.1 < \lvert z_n \rvert < $ `thresh`, on coloriera selon la `cmap`, et pour $\lvert z_n \rvert > $ `thresh` on coloriera en couleur unie.

Les paramètres `order` et `c` sont deux paramètres conçus pour les fonctions de la forme $f(z) = z^n + c$, mais l'utilisateur est libre de les utiliser comme bon lui semble.

--- 

Par défaut, le fichier affiche des ensembles de Julia pour des fonctions de la forme $f(z) = z^n + c$, mais comme indiqué en commentaire, l'utilisateur peut entrer des fonctions différentes, même à l'aide d'autres modules comme `cmath` dans l'exemple fourni.

![](https://github.com/ChrisMzz/julia/blob/main/python/dump/c=(0.285+0.01j)_N=4096_it=40_thr=500_l=10_lf=2_o=2.png)


## GeoGebra

Des versions en ligne peuvent être trouvées ici : 
 - [Ensemble de Julia dessiné étape par étape](https://www.geogebra.org/m/qkedp8wj)
 - [Ensemble de Julia dessiné colonne par colonne](https://www.geogebra.org/m/y2u5juqx)


## GIMP

Le plugin *Filtres/Rendu/Fractaliser/Explorateur de fractales* permet de générer des ensembles fractals, notamment un ensemble de Julia pour $f(z) = z^2+c$.
Grâce au script-fu, c'était possible d'écrire un script en Scheme qui peut exporter des images en masse. Un programme Python peut utiliser la librairie `PIL` pour compiler ces images dans un GIF. 

La librairie `PIL` peut être installée avec pip : 

```bat
python3 -m pip install --upgrade pip
python3 -m pip install --upgrade Pillow
```

### Ajouter un script sur GIMP

Les images et scripts ont été écrits pour GIMP 2.10.20. 


Si vous avez installé GIMP 2.0 et choisi le répertoire d'installation par défaut, rendez-vous dans `C:\Program Files\GIMP 2\share\gimp\2.0\scripts`.
Si vous avez installé GIMP 2.0 dans un autre répertoire, rendez-vous dans ce répertoire puis \share\gimp\2.0\scripts`.

Copiez les fichiers `julia-incr.scm`, `julia-zoom.scm`, `julia-iter.scm`, et tout autre script que vous voulez rajouter dedans.

### Les scripts Julia

#### `julia-incr.scm`

`Julia Generator`, qui correspond au fichier `julia-incr.scm`, permet d'exporter des images d'ensembles de Julia pour un nombre d'itérations fixé, et un paramètre $c$ variable, paramétrisé sur un segment dans $\mathcal{C}$.

Les paramètres disponibles sont : 
 - `n` : le nombre d'images
 - `NumStart` : le nombre par lequel les numérotations des images exportées doivent commncer.
 - `Iterations` : le nombre d'itérations.
 - `CX Start` : la partie réelle du $c$ de départ.
 - `CY Start` : l'opposée de la partie imaginaire du $c$ de départ.
 - `CX End` : : la partie réelle du $c$ de fin.
 - `CY End` : l'opposée de la partie imaginaire du $c$ de fin.
   - Attention, choisir (-0.75,-0.25) pour (`CX`, `CY`) correspond donc à $c = -0.75 + 0.25i$. 
 - `Width` : la largeur de l'image.
 - `Height` : la hauteur de l'image.
   - un ratio de `12:9` est recommandé, malgré la proposition de `3:2` proposée par défaut.

![](https://github.com/ChrisMzz/julia/blob/main/gimp/julia-small-asymloop.gif)


#### `julia-iter.scm`

`Julia Iterator`, qui correspond au fichier `julia-iter.scm`, permet d'exporter des images d'ensembles de Julia pour une constante $c$ fixée, et un nombre d'itérations croissant.

Les paramètres disponibles sont : 
 - `NumStart` : le nombre par lequel les numérotations des images exportées doivent commncer.
 - `Iterations Start` : le nombre d'itérations par lequel l'animation doit commencer.
 - `Iterations End` : le nombre d'itérations final de l'animation.
 - `CX` : la partie réelle du $c$.
 - `CY` : l'opposée de la partie imaginaire du $c$.
 - `Color Variety` : le nombre de couches créées lors de la segmentation du dégradé de couleurs actif qui sera appliqué à l'image.
 - `Width` : la largeur de l'image.
 - `Height` : la hauteur de l'image.

![](https://github.com/ChrisMzz/julia/blob/main/gimp/julia-iter05.gif)


#### `julia-zoom.scm`

`Julia Zoom`, qui correspond au fichier `julia-zoom.scm`, permet d'exporter des images d'ensembles de Julia pour une constante $c$ fixée, mais qui zoome sur une partie de l'image en augmentant progressivement le nombre d'itérations.
L'image est centrée en un point $a-ib$ lors du zoom.

Les paramètres disponibles sont : 
 - `NumStart` : le nombre par lequel les numérotations des images exportées doivent commncer.
 - `n` : le nombre d'images à exporter.
 - `Max Iterations` : le nombre d'itérations maximal à afficher.
 - `Re: a` : $Re(a+ib) = a$
 - `Im: b` : $Im(a+ib) = b$
   - Attention ! Le plugin inverse le signe des parties imaginaires, donc il s'agit de l'opposée de la partie imaginaire du nombre sur lequel l'image est centrée.
 - `CX` : la partie réelle du $c$.
 - `CY` : l'opposée de la partie imaginaire du $c$.
 - `Color Variety` : le nombre de couches créées lors de la segmentation du dégradé de couleurs actif qui sera appliqué à l'image.
 - `Width` : la largeur de l'image.
 - `Height` : la hauteur de l'image.

![](https://github.com/ChrisMzz/julia/blob/main/gimp/julia-zoom01.gif)







