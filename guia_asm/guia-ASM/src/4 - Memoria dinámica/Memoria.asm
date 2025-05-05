extern malloc
extern free
extern fprintf

section .data

section .text

global strCmp
global strClone
global strDelete
global strPrint
global strLen

; ** String **

; Compara dos strings en orden lexicográfico. Ver https://es.wikipedia.org/wiki/Orden_lexicografico.
; Debe retornar:
; 0 si son iguales
; 1 si a < b
; 1 si a > b
; int32_t strCmp(char* a, char* b)
; *a --> RDI
; *b --> RSI
strCmp:

	xor RAX, RAX		; limpio el resultado
	xor RBX, RBX

	loop_strcmp:
	
		mov al, byte [RDI]  ; al = str1
		mov bl, byte [RSI]	; bl = str2

		cmp al, bl
		
		jl str1_menor
		jg str1_mayor

		; si llegaron hasta acá entonces al y bl son iguales

		cmp al, 0		; veo si al = 0, en cuyo caso al = 0 = bl y ambas strings terminaron
		je son_iguales
		
		inc rdi
		inc rsi				; avanzo a los próximos char
		jmp loop_strcmp

	son_iguales:
		xor eax, eax
		jmp fin

	str1_menor:
		mov eax, 1
		jmp fin
	
	str1_mayor:
		mov eax, -1

	fin:
		ret

; char* strClone(char* a)
; Genera una copia del string pasado por parámetro. El puntero pasado siempre es válido
; aunque podría corresponderse a la cadena vacía.
; char* --> RDI
strClone:
	push rbp
	mov rbp, rsp
	push r12
	sub rsp, 8		; pusheo un registro no volátil para poder usarlo para almacenar valores que no quiero que se modifiquen entre llamados a funciones, después alineo la pila a 16 bytes 
	
	mov r12, rdi	; r12 = puntero a mi string a clonar
	
	call strLen		; eax = longitud de mi string

	inc eax			; le sumo el espacio para el caracter nulo
	xor rdi, rdi
	mov edi, eax	; asigno a edi para pasarlo como parámetro 

	call malloc		; eax = puntero a la nueva memoria

	mov r8, rax		; copio en r8 puntero al inicio del string porque no voy a usar más funciones

	loop_strclone:
		
		cmp byte[r12], 0		; veo si llegué al final de mi string
		je fin_clone

		mov r9b, byte[r12]
		mov byte[rax], r9b

		inc r12
		inc rax		; avanzo a los próximos char

		jmp loop_strclone

	fin_clone:
		
		mov byte[rax], 0

		mov rax, r8	; rax ahora apunta nuevamente al principio del string para poder devolver correctamente el puntero

		add rsp, 8
		pop r12
		pop rbp
		ret

; void strDelete(char* a)
strDelete:
	push rbp
	mov rbp, rsp

	call free
	
	pop rbp
	ret

; void strPrint(char* a, FILE* pFile)
strPrint:
	push rbp
	mov rbp, rsp

	mov r15, rdi ;guardo mi palabra original
	mov rdi, rsi ;guardo el puntero al archivo
	mov rdx, r15 ;Escribo mi palabra original en el parametro a imprimir
	
	call fprintf
	pop rbp
	ret

; uint32_t strLen(char* a)
; char* --> RDI
strLen:
	xor r10, r10
	xor rax, rax		; limpio el contador
	
	loop_strlen:
		
		mov r10b, byte [rdi]		; copio el char en r10 
		
		cmp r10b, 0					; reviso si llegué al final del string
		je fin_str

		inc rdi						; avanzo al próximo char
		inc eax						; incremento el contador
		jmp loop_strlen

	fin_str:
		ret


