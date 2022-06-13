extern sumar_c
extern restar_c
;########### SECCION DE DATOS
section .data

;########### SECCION DE TEXTO (PROGRAMA)
section .text

;########### LISTA DE FUNCIONES EXPORTADAS

global alternate_sum_4
global alternate_sum_4_simplified
global alternate_sum_8
global product_2_f
global alternate_sum_4_using_c

;########### DEFINICION DE FUNCIONES
; uint32_t alternate_sum_4(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4);
; registros: x1[rdi], x2[rsi], x3[rdx], x4[rcx]
alternate_sum_4:
	;prologo
	push	rbp
	mov rbp, rsp
	

	; COMPLETAR
	sub edi, esi
	add edi, edx
	sub edi, ecx
	mov eax, edi
	;recordar que si la pila estaba alineada a 16 al hacer la llamada
	;con el push de RIP como efecto del CALL queda alineada a 8

	;epilogo
	pop rbp
	ret

; uint32_t alternate_sum_4_using_c(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4);
; registros: x1[rdi], x2[rsi], x3[rdx], x4[rcx]
alternate_sum_4_using_c: 

	;prologo
    push rbp ; alineado a 16
    mov rbp,rsp
	call restar_c
	mov edi, eax
	mov esi, edx
	call sumar_c
	mov edi, eax
	mov esi, ecx
	call restar_c
	;epilogo
	pop rbp
    ret 



; uint32_t alternate_sum_4_simplified(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4);
; registros: x1[?], x2[?], x3[?], x4[?]

alternate_sum_4_simplified:

	sub edi, esi
	add edi, edx
	sub edi, ecx
	mov eax, edi

	ret


; uint32_t alternate_sum_8(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4, uint32_t x5, uint32_t x6, uint32_t x7, uint32_t x8);	
; registros y pila: x1[rdi], x2[rsi], x3[rdx], x4[rcx], x5[r8], x6[r9], x7[rbp+16], x8[rbp+24]
alternate_sum_8:
	;prologo
	push rbp
	mov rbp, rsp

	mov eax, edi
	sub eax, esi
	add eax, edx
	sub	eax, ecx
	add eax, r8d
	sub eax, r9d
	add eax, [rbp + 16]
	sub eax, [rbp + 24] 

	;epilogo
	pop rbp
	ret
	

; SUGERENCIA: investigar uso de instrucciones para convertir enteros a floats y viceversa
;void product_2_f(uint32_t * destination, uint32_t x1, float f1);
;registros: destination[rdi], x1[rsi], f1[xmm0]
product_2_f:
	; prologo
	push rbp
	mov rbp, rsp

	; mov xmm1, rsi
	; cvtdq2ps xmm1,xmm1
	; cvttps2pi mm0,xmm0
	; mov rdi, [mm0]

	cvtsi2ss xmm1, rsi	; convierte doubleword integer to scalar single float
	mulps xmm1, xmm0	; multiplicacion
	cvtss2si rsi, xmm1	; convierte scalar single float a doubleword integer
	mov [rdi], rsi		; guardamos el resultado donde apunta destination
	
	; epilogo
	pop rbp
	ret

