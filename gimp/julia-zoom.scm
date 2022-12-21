(define (script-fu-julia img layer dest start i n itere a b cx cy colorvar Width Height)
(plug-in-fractalexplorer 1 img layer 1 (- (* a (/ i n)) (* (/ 2 n) (- n i) ) ) (+ (* a (/ i n)) (* (/ 2 n) (- n i) ) ) (- (* b (/ i n)) (* (/ 1.5 n) (- n i) ) ) (+ (* b (/ i n)) (* (/ 1.5 n) (- n i) ) )
 (+ 2 (round (/ (* i itere) n))) cx cy 1 0 0 0 0 0 0 0 0 0 colorvar)
(file-jpeg-save RUN-NONINTERACTIVE img layer (string-append (string-append dest "/julia-") (string-append (number->string (+ start i)) ".jpeg"))
 (string-append (string-append dest "/julia-") (string-append (number->string (+ start i)) ".jpeg"))
 1 0 1 0 "" 2 1 0 0)
(gimp-drawable-fill layer 2)
)


(define (script-fu-julia-zoom img layer dest start n itere a b cx cy colorvar Width Height)
(do ((i 0 (+ 1 i)))
    ((> i n))
    (script-fu-julia img layer dest start i n itere a b cx cy colorvar Width Height)
)
)


;(- (* a (/ i (- itere iters))) (* (/ 2 (- itere iters)) (- (- itere iters) i) ) )
;(+ (* a (/ i (- itere iters))) (* (/ 2 (- itere iters)) (- (- itere iters) i) ) )
;(- (* b (/ i (- itere iters))) (* (/ 1.5 (- itere iters)) (- (- itere iters) i) ) )
;(+ (* b (/ i (- itere iters))) (* (/ 1.5 (- itere iters)) (- (- itere iters) i) ) )




(
script-fu-register
"script-fu-julia-zoom"
"<Image>/MesScripts/Julia Zoom"
"-------------"
"Générateur d'Images avec zoom de l'ensemble de Julia pour une constante fixée"
"Christopher Mazzerbo"
"2022"
"-----------"
SF-IMAGE "Image" 0
SF-DRAWABLE "Drawable" 0
SF-DIRNAME "Destination" "C:/destination"
SF-VALUE "NumStart" "0"
SF-VALUE "n" "100"
SF-VALUE "Max Iterations" "102"
SF-VALUE "Re: a" "0"
SF-VALUE "Im: b" "0"
SF-VALUE "CX" "-0.4"
SF-VALUE "CY" "0.65"
SF-VALUE "Color Variety" "256"
SF-VALUE "Width" "3000"
SF-VALUE "Height" "2000"
)