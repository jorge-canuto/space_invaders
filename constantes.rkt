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
(define IMG-NAVE (scale 0.3(bitmap "C:/Users/Jorge/Downloads/UFPR/6° periodo/Oficina de Computação/desenvolvimento do jogo/space_invaders/images/nave.png")))
(define IMG-NAVE-INIMIGA (scale 0.5 (bitmap "C:/Users/Jorge/Downloads/UFPR/6° periodo/Oficina de Computação/desenvolvimento do jogo/space_invaders/images/nave_inimiga.png")))
(define IMG-FUNDO-CENARIO (scale 1.9 (bitmap "C:/Users/Jorge/Downloads/UFPR/6° periodo/Oficina de Computação/desenvolvimento do jogo/space_invaders/images/fundo_cenario.png")))
(define LARGURA-NAVE (image-width IMG-NAVE))
(define ALTURA-NAVE (image-height IMG-NAVE))
(define LARGURA-NAVE-INIMIGA (image-width IMG-NAVE-INIMIGA))
(define ALTURA-NAVE-INIMIGA (image-height IMG-NAVE-INIMIGA))


;;(define TC-VIRA " ")
;;(define TC-REINICIO "\r")