#lang racket

(require 2htdp/image)
(require "constantes.rkt")

(provide (all-defined-out))

;;============================================================================================================
;; Definições de dados:

(define-struct tiro (x y dx)#:transparent)
;; Tiro é (make-personagem Natural Natural Inteiro)
;; interp. representa o tiro do personagem nos eixos x e y, em pixels.
;; dx reprensenta a velocidade de deslocamento do tiro.


;; Exemplos TIRO:
(define TIRO-INICIO (make-tiro (/ LARGURA-TIRO 2) (/ ALTURA-CENARIO 2) 3))
(define TIRO-MEIO (make-tiro (/ LARGURA-CENARIO 2) (/ ALTURA-CENARIO 2) 3))
(define TIRO-FINAL-CENARIO (make-tiro (- LARGURA-CENARIO (/ LARGURA-TIRO 2)) (/ ALTURA-CENARIO 2) 3))

#;
(define (fn-para-tiro t)
  (... (tiro-x t)
       (tiro-y t)
       (tiro-dx t))
  )

;; List<Tiro> é (cons Tiro List<Tiro>)
;; interp. lista de tiros
; Exemplo
(define LISTA-TIROS-VAZIA empty)
(define LISTA-TIROS (list TIRO-INICIO TIRO-MEIO TIRO-FINAL-CENARIO))

#;
(define (fn-para-ldt ldt)
  (cond [(empty? ldt) (...)]                   ;CASO BASE (CONDIÇÃO DE PARADA)
        [else (... (first ldt)                 ;String
                   (fn-for-ldp (rest ldt)))])) ;RECURSÃO EM CAUDA


;;============================================================================================================



;; ------------------------------------------ INICIO DAS FUNCOES DO TIRO -------------------------------------

;; Tiro -> Tiro
;; move o Tiro de acordo com seu valor dx

;stub
;(define (move-tiro t) t)

(define (move-tiro t)
  (let* (
      [novo-x (+ (tiro-x t) (tiro-dx t))]
      )
  (make-tiro
   ;x:
   novo-x
   ;y:
   (tiro-y t)
   ;dx
   (tiro-dx t)
    )))


;; move-tiros: List<Tiros> -> List<Tiros>
;; Move todos os Tiros de uma lista

;stub
;(define (move-tiros ldt) ldt)

(define (move-tiros ldt)
  (map move-tiro ldt))


;; desenha-tiro: Tiro Image Image -> Image
;; Desenha um tiro na tela

;stub
;(define (desenha-tiro t img fundo) img)

(define (desenha-tiro t img fundo)
 (place-image img
               (tiro-x t)
               (tiro-y t)
               fundo
               ))

;; desenha-tiros: List<Tiro> Image Image -> Image
;; desenha varios tiros
(define (desenha-tiros  ldt img fundo)
  (cond [(empty? ldt) fundo]                   ;CASO BASE (CONDIÇÃO DE PARADA)
        [else (desenha-tiro (first ldt) img                
                   (desenha-tiros (rest ldt) img fundo))]))



;;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!;;
;;                             Falta os testes Unitários                         ;;
;;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!;;
