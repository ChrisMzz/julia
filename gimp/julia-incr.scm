(define (script-fu-julia img layer dest n start i iter cxs cys cxe cye Width Height)
(plug-in-fractalexplorer 1 img layer 1 -2.0 2.0 -1.5 1.5 iter (+ (* (/ i n) (- cxe cxs) ) cxs) (+ (* (/ i n) (- cye cys) ) cys) 1 0 0 0 0 0 0 0 0 0 256)
(file-jpeg-save RUN-NONINTERACTIVE img layer (string-append (string-append dest "/julia-") (string-append (number->string (+ start i)) ".jpeg"))
 (string-append (string-append dest "/julia-") (string-append (number->string (+ start i)) ".jpeg"))
 1 0 1 0 "" 2 1 0 0)
(gimp-drawable-fill layer 2)
)


(define (script-fu-julia-gen img layer dest n start iter cxs cys cxe cye Width Height)
(do ((i 0 (+ 1 i)))
    ((> i n))
    (script-fu-julia img layer dest n start i iter cxs cys cxe cye Width Height)
)
)



(
script-fu-register
"script-fu-julia-gen"
"<Image>/MesScripts/Julia Generator"
"-------------"
"Générateur d'Images de l'ensemble de Julia"
"Christopher Mazzerbo"
"2022"
"-----------"
SF-IMAGE "Image" 0
SF-DRAWABLE "Drawable" 0
SF-DIRNAME "Destination" "C:/destination"
SF-VALUE "n" "10"
SF-VALUE "NumStart" "0"
SF-VALUE "Iterations" "50"
SF-VALUE "CX Start" "0.299"
SF-VALUE "CY Start" "-0.027"
SF-VALUE "CX End" "0.283"
SF-VALUE "CY End" "0.018"
SF-VALUE "Width" "3000"
SF-VALUE "Height" "2000"
)