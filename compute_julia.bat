@echo off
title Compute Julia
color 0b
::chcp 65001

echo Ce fichier va générer une image représentant un ensemble de Julia entre -1 et 1 sur l'axe x et entre -i et i sur l'axe y.
echo Les paramètres seront :
echo    Pour l'affichage : 
set /p N=[93mN[0m [36mest le nombre de pixels en longueur / largeur : [0m
set /p layers=[93mlayers[0m [36mest le nombre de couches de couleur dans le dégradé utilisé pour le colorier : [0m
set /p layering_factor=[93mlayering_factor[0m [36mest l'argument d'exponentiation utilisé pour séparer les couches : [0m
:choosecmap
set /p cmap=[93mcmap[0m [36mest le dégradé de couleurs utilisé (tapez[0m [92mhelp[0m [36mpour des exemples, ou[0m [92mdefault[0m [36mpour la valeur par défaut) : [0m
if %cmap% == help ( 
    start chrome https://matplotlib.org/stable/tutorials/colors/colormaps.html
    set cmap=
    goto choosecmap
) else if %cmap% == default ( 
    set cmap=gnuplot_r
)

:continue
echo    Pour l'ensemble même : 
set /p iter=[95miter[0m [36mest le nombre d'iterations de z_n : [0m
set /p thresh=[95mthresh[0m [36mest la borne qui détermine si z_(max_iteration) diverge ou pas : [0m
set /p order=[95morder[0m [36mest une variable qui peut être utilisée pour rapidement modifier l'ordre de f (inutile selon la configuration) : [0m
set /p c=[95mc[0m [36mla constante : [0m

cls

(
echo {
echo    "settings":
echo    {
echo        "display_settings" : {"N":%N%, "layers":%layers%, "layering_factor":%layering_factor%, "cmap":"%cmap%"},
echo        "julia_settings" : {"iter":%iter%, "thresh":%thresh%, "order":%order%, "c":"%c%"}
echo    }
echo }
) > src/settings.json

cd src
python julia_th.py
robocopy dump ../images /mov

