(define (script-fu-julia img layer dest start i iters itere cx cy colorvar Width Height)
(plug-in-fractalexplorer 1 img layer 1 -2.0 2.0 -1.5 1.5 (+ iters (* (/ i (- itere iters)) (- itere iters) )) cx cy 1 0 0 0 0 0 0 0 0 0 colorvar)
(file-jpeg-save RUN-NONINTERACTIVE img layer (string-append (string-append dest "/julia-") (string-append (number->string (+ start i)) ".jpeg"))
 (string-append (string-append dest "/julia-") (string-append (number->string (+ start i)) ".jpeg"))
 1 0 1 0 "" 2 1 0 0)
(gimp-drawable-fill layer 2)
)


(define (script-fu-julia-iter img layer dest start iters itere cx cy colorvar Width Height)
(do ((i 0 (+ 1 i)))
    ((> i (- itere iters)))
    (script-fu-julia img layer dest start i iters itere cx cy colorvar Width Height)
)
)



(
script-fu-register
"script-fu-julia-iter"
"<Image>/MesScripts/Julia Iterator"
"-------------"
"Générateur d'Images à itérations variables de l'ensemble de Julia"
"Christopher Mazzerbo"
"2022"
"-----------"
SF-IMAGE "Image" 0
SF-DRAWABLE "Drawable" 0
SF-DIRNAME "Destination" "C:/destination"
SF-VALUE "NumStart" "0"
SF-VALUE "Iterations Start" "2"
SF-VALUE "Iterations End" "100"
SF-VALUE "CX" "-0.4"
SF-VALUE "CY" "0.65"
SF-VALUE "Color Variety" "256"
SF-VALUE "Width" "3000"
SF-VALUE "Height" "2000"
)