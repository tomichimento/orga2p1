

;########### ESTOS SON LOS OFFSETS Y TAMAÑO DE LOS STRUCTS
; Completar las definiciones (serán revisadas por ABI enforcer):
NODO_OFFSET_NEXT EQU 0
NODO_OFFSET_CATEGORIA EQU 8
NODO_OFFSET_ARREGLO EQU 16
NODO_OFFSET_LONGITUD EQU 24
NODO_SIZE EQU 32
PACKED_NODO_OFFSET_NEXT EQU 0
PACKED_NODO_OFFSET_CATEGORIA EQU 8
PACKED_NODO_OFFSET_ARREGLO EQU 9
PACKED_NODO_OFFSET_LONGITUD EQU 17
PACKED_NODO_SIZE EQU 21
LISTA_OFFSET_HEAD EQU 0
LISTA_SIZE EQU 8
PACKED_LISTA_OFFSET_HEAD EQU 0
PACKED_LISTA_SIZE EQU 8

;########### SECCION DE DATOS
section .data

;########### SECCION DE TEXTO (PROGRAMA)
section .text

;########### LISTA DE FUNCIONES EXPORTADAS
global cantidad_total_de_elementos
global cantidad_total_de_elementos_packed

;########### DEFINICION DE FUNCIONES
;extern uint32_t cantidad_total_de_elementos(lista_t* lista);
;registros: lista[?]
; *lista --> RDI
cantidad_total_de_elementos:
	
	xor rax, rax	; inicializo el contador de elementos
	mov r10, [rdi]	; r10 = head

	loop:
		cmp r10, 0	; cuando sea nulo termino
		je fin

		
		add eax, [r10 + NODO_OFFSET_LONGITUD]	; sumo la longitud de cada nodo
		mov r10, [r10 + NODO_OFFSET_NEXT]		; apunto al próximo nodo

		jmp loop
		
	fin:
		ret

;extern uint32_t cantidad_total_de_elementos_packed(packed_lista_t* lista);
;registros: lista[?]
; *lista --> RDI
cantidad_total_de_elementos_packed:
	
	xor rax, rax	; inicializo el contador de elementos
	mov r10, [rdi]	; r10 = head

	loop2:
		cmp r10, 0	; cuando sea nulo termino
		je fin2

		
		add eax, [r10 + PACKED_NODO_OFFSET_LONGITUD]	; sumo la longitud de cada nodo
		mov r10, [r10 + PACKED_NODO_OFFSET_NEXT]		; apunto al próximo nodo

		jmp loop2
		
	fin2:
		ret

