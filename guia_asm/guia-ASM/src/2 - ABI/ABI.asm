extern sumar_c
extern restar_c
;########### SECCION DE DATOS
section .data

;########### SECCION DE TEXTO (PROGRAMA)
section .text

;########### LISTA DE FUNCIONES EXPORTADAS

global alternate_sum_4
global alternate_sum_4_using_c
global alternate_sum_4_using_c_alternative
global alternate_sum_8
global product_2_f
global product_9_f

;########### DEFINICION DE FUNCIONES
; uint32_t alternate_sum_4(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4);
; parametros: 
; x1 --> EDI
; x2 --> ESI
; x3 --> EDX
; x4 --> ECX
alternate_sum_4:
  sub EDI, ESI
  add EDI, EDX
  sub EDI, ECX

  mov EAX, EDI
  ret

; uint32_t alternate_sum_4_using_c(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4);
; parametros: 
; x1 --> EDI
; x2 --> ESI
; x3 --> EDX
; x4 --> ECX
alternate_sum_4_using_c:
  ;prologo
  push RBP ;pila alineada
  mov RBP, RSP ;strack frame armado
  push R12
  push R13	; preservo no volatiles, al ser 2 la pila queda alineada

  mov R12D, EDX ; guardo los parámetros x3 y x4 ya que están en registros volátiles
  mov R13D, ECX ; y tienen que sobrevivir al llamado a función

  call restar_c 
  ;recibe los parámetros por EDI y ESI, de acuerdo a la convención, y resulta que ya tenemos los valores en esos registros
  
  mov EDI, EAX ;tomamos el resultado del llamado anterior y lo pasamos como primer parámetro
  mov ESI, R12D
  call sumar_c

  mov EDI, EAX
  mov ESI, R13D
  call restar_c

  ;el resultado final ya está en EAX, así que no hay que hacer más nada

  ;epilogo
  pop R13 ;restauramos los registros no volátiles
  pop R12
  pop RBP ;pila desalineada, RBP restaurado, RSP apuntando a la dirección de retorno
  ret


alternate_sum_4_using_c_alternative:
  ;prologo
  push RBP ;pila alineada
  mov RBP, RSP ;strack frame armado
  sub RSP, 16 ; muevo el tope de la pila 8 bytes para guardar x4, y 8 bytes para que quede alineada

  mov [RBP-8], RCX ; guardo x4 en la pila

  push RDX  ;preservo x3 en la pila, desalineandola
  sub RSP, 8 ;alineo
  call restar_c 
  add RSP, 8 ;restauro tope
  pop RDX ;recupero x3
  
  mov EDI, EAX
  mov ESI, EDX
  call sumar_c

  mov EDI, EAX
  mov ESI, [RBP - 8] ;leo x4 de la pila
  call restar_c

  ;el resultado final ya está en EAX, así que no hay que hacer más nada

  ;epilogo
  add RSP, 16 ;restauro tope de pila
  pop RBP ;pila desalineada, RBP restaurado, RSP apuntando a la dirección de retorno
  ret


; uint32_t alternate_sum_8(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4, uint32_t x5, uint32_t x6, uint32_t x7, uint32_t x8);
; registros y pila: x1[?], x2[?], x3[?], x4[?], x5[?], x6[?], x7[?], x8[?]
; x1 --> EDI
; x2 --> ESI
; x3 --> EDX
; x4 --> ECX
; x5 --> R8D
; x6 --> R9D
; x7 --> RBP + 16
; x8 --> RBP + 24
alternate_sum_8:
	;prologo
  push rbp
  mov rbp, rsp
  push R12
  push R13

  mov r12d, [rbp + 16]
  mov r13d, [rbp + 24]
	
  ; COMPLETAR
  ; x1 - x2 + x3 - x4 + x5 - x6 + x7 - x8

  sub edi, ESI
  add edi, edx
  sub edi, ECX
  add edi, R8D
  sub edi, R9D
  add edi, r12d
  sub edi, r13d

  mov eax, edi

	;epilogo
  pop r13
  pop r12
  pop rbp
	ret


; SUGERENCIA: investigar uso de instrucciones para convertir enteros a floats y viceversa
; Hace la multiplicación x1 * f1 y el resultado se almacena en destination. Los dígitos decimales del resultado se eliminan mediante truncado
;void product_2_f(uint32_t * destination, uint32_t x1, float f1);
;registros: destination[?], x1[?], f1[?]
; x1 --> RDI
; x2 --> ESI
; x3 --> XMM0
product_2_f:

  CVTSI2SD xmm1, esi  ; transformo el entero en double
  CVTSS2SD xmm0, xmm0 ; transformo el float en double
  MULSD xmm1, xmm0    ; multiplico ambos floats
  CVTTSD2SI eax, xmm1 ; convierto f1 * x1 a un entero truncado
  mov dword[rdi], eax ; almaceno el resultado en la dirección del puntero rdi

	ret ; si bien pasan todos los tests, no cumple lo que dice la consigna ya que paso a double y no a float

;// Convierte todos los parámetros a double, realiza la multiplicación de todos ellos y
;// aloja el resultado en destination.
;// Nota de implementación: Ir multiplicando todos los floats en primer lugar, luego,
;// ir multiplicando ese resultado con cada entero, uno a uno.

;extern void product_9_f(double * destination
;, uint32_t x1, float f1, uint32_t x2, float f2, uint32_t x3, float f3, uint32_t x4, float f4
;, uint32_t x5, float f5, uint32_t x6, float f6, uint32_t x7, float f7, uint32_t x8, float f8
;, uint32_t x9, float f9);
;registros y pila: destination[rdi], x1[?], f1[?], x2[?], f2[?], x3[?], f3[?], x4[?], f4[?]
;	, x5[?], f5[?], x6[?], f6[?], x7[?], f7[?], x8[?], f8[?],
;	, x9[?], f9[?]

; *destination --> EDI
; x1 --> ESI
; x2 --> EDX
; x3 --> ECX
; x4 --> R8D
; x5 --> R9D

; F1 --> XMM0
; F2 --> XMM1
; F3 --> XMM2
; F4 --> XMM3
; F5 --> XMM4
; F6 --> XMM5
; F7 --> XMM6
; F8 --> XMM7

; x6 --> RBP + 16
; x7 --> RBP + 24
; x8 --> RBP + 32
; x9 --> RBP + 40
; f9 --> RBP + 48


product_9_f:
	;prologo
	push rbp
	mov rbp, rsp
  
	;convertimos los flotantes de cada registro xmm en doubles
	; COMPLETAR
  CVTSS2SD xmm0, xmm0
  CVTSS2SD xmm1, xmm1
  CVTSS2SD xmm2, xmm2
  CVTSS2SD xmm3, xmm3
  CVTSS2SD xmm4, xmm4
  CVTSS2SD xmm5, xmm5
  CVTSS2SD xmm6, xmm6
  CVTSS2SD xmm7, xmm7
  CVTSS2SD xmm12, dword [rbp+48] ; primero convierto todos los float a double

  ;multiplicamos los doubles en xmm0 <- xmm0 * xmm1, xmmo * xmm2 , ...
	; COMPLETAR

  MULSD xmm0, xmm1
  MULSD xmm0, xmm2
  MULSD xmm0, xmm3
  MULSD xmm0, xmm4
  MULSD xmm0, xmm5
  MULSD xmm0, xmm6
  MULSD xmm0, xmm7
  MULSD xmm0, xmm12   ; xmm0 = producto de todos los floats

 
  ; convertimos los enteros en doubles y los multiplicamos por xmm0.
	; COMPLETAR
  CVTSI2SD xmm1, esi
  CVTSI2SD xmm2, edx
  CVTSI2SD xmm3, ecx
  CVTSI2SD xmm4, R8D
  CVTSI2SD xmm5, R9D
  CVTSI2SD xmm6, dword [RBP + 16]
  CVTSI2SD xmm7, dword [RBP + 24]
  CVTSI2SD xmm8, dword [RBP + 32]
  CVTSI2SD xmm9, dword [RBP + 40]

  MULSD xmm0, xmm1
  MULSD xmm0, XMM2
  MULSD xmm0, XMM3
  MULSD xmm0, XMM4
  MULSD xmm0, XMM5    
  MULSD xmm0, XMM6
  MULSD xmm0, xmm7
  MULSD xmm0, xmm8
  MULSD xmm0, XMM9    ; xmm0 = producto de todos los parámetros

  MOVSD [RDI], xmm0   ; EDI ahora apunta al resultado (double)


	; epilogo
	pop rbp
	ret

