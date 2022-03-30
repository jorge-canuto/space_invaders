#lang racket

(require 2htdp/image)
(require 2htdp/universe)

(provide (all-defined-out))


;; space invaders

;; =================
;; Constantes:

(define ALTURA-CENARIO 150)
(define LARGURA-CENARIO 200)
(define CENARIO (empty-scene LARGURA-CENARIO ALTURA-CENARIO))
(define IMG-NAVE (scale 0.3(bitmap "nave.png")))
(define IMG-NAVE-INIMIGA (scale 0.5 (bitmap "nave_inimiga.png")))
(define IMG-FUNDO-CENARIO (scale 1.9 (bitmap "fundo_cenario.png")))

(define LARGURA-NAVE (image-width IMG-NAVE))
(define ALTURA-NAVE (image-height IMG-NAVE))
(define LARGURA-NAVE-INIMIGA (image-width IMG-NAVE-INIMIGA))
(define ALTURA-NAVE-INIMIGA (image-height IMG-NAVE-INIMIGA))


;;(define TC-VIRA " ")
;;(define TC-REINICIO "\r")