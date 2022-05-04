#lang racket

(require rackunit)
(require 2htdp/image)

(require "constantes.rkt")
(require "tiro.rkt")


; move-tiro
(check-equal? (move-tiro (make-tiro (/ LARGURA-CENARIO 2) (/ ALTURA-CENARIO 2) DX-PADRAO-TIROS)) 
                         (make-tiro (+ (/ LARGURA-CENARIO 2) DX-PADRAO-TIROS) (/ ALTURA-CENARIO 2) DX-PADRAO-TIROS))


; move-tiro-inimigo
(check-equal? (move-tiro-inimigo (make-tiro (/ LARGURA-CENARIO 2) (/ ALTURA-CENARIO 2) DX-PADRAO-TIROS)) 
                         (make-tiro (- (/ LARGURA-CENARIO 2) DX-PADRAO-TIROS) (/ ALTURA-CENARIO 2) DX-PADRAO-TIROS))

