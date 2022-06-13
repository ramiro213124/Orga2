
;########### SECCION DE DATOS
section .data

;########### SECCION DE TEXTO (PROGRAMA)
section .text

;########### LISTA DE FUNCIONES EXPORTADAS
global complex_sum_z
global packed_complex_sum_z
global product_9_f

;########### DEFINICION DE FUNCIONES
;extern uint32_t complex_sum_z(complex_item *arr, uint32_t arr_length);
;registros: arr[rdi], arr_length[rsi]
; arr -> rdi
; arr_length -> esi
complex_sum_z:
	;prologo
	push rbp
	mov rbp, rsp

	mov ecx, esi	; contador
	mov rdx, rdi	; direccion actual
	mov eax, 0		; acumulador

.cycle:				; etiqueta a donde retorna el ciclo que itera sobre arr
	add eax, [rdx + 0x18]	; suma al acumulador lo que hay en z
	add rdx, 0x20	; suma a la direccion actual lo que ocupa una estructura
	loop .cycle		; decrementa ecx y si es distinto de 0 salta a .cycle

	;epilogo
	pop rbp
	ret
	
;extern uint32_t packed_complex_sum_z(packed_complex_item *arr, uint32_t arr_length);
;registros: arr[rdi], arr_length[rsi]
packed_complex_sum_z:
	;prologo
	push rbp
	mov rbp, rsp

	mov ecx, esi	; contador
	mov rdx, rdi	; direccion actual
	mov eax, 0		; acumulador

.cycle:				; etiqueta a donde retorna el ciclo que itera sobre arr
	add eax, [rdx + 0x14]	; suma al acumulador lo que hay en z
	add rdx, 0x18	; suma a la direccion actual lo que ocupa una estructura
	loop .cycle		; decrementa ecx y si es distinto de 0 salta a .cycle

	;epilogo
	pop rbp
	ret


;extern void product_9_f(uint32_t * destination
;, uint32_t x1, float f1, uint32_t x2, float f2, uint32_t x3, float f3, uint32_t x4, float f4
;, uint32_t x5, float f5, uint32_t x6, float f6, uint32_t x7, float f7, uint32_t x8, float f8
;, uint32_t x9, float f9);
;registros y pila: destination[rdi], x1[rsi], f1[xmm0], x2[rdx], f2[xmm1], x3[rcx], f3[xmm2], x4[r8], f4[xmm3]
;	, x5[r9], f5[xmm4], x6[rbp+0x10], f6[xmm5], x7[rbp+0x18], f7[xmm6], x8[rbp+0x20], f8[xmm7],
;	, x9[rbp+0x28], f9[xmm8]


; destination -> rdi
; x1 -> esi
; f1 -> xmm0
; x2 -> edx
; f2 -> xmm1
; x3 -> ecx
; f3 -> xmm2
; x4 -> r8d
; f4 -> xmm3
; x5 -> r9d
; f5 -> xmm4
; x6 -> PILA
; f6 -> xmm5
; x7 -> PILA
; f7 -> xmm6
; x8 -> PILA
; f8 -> xmm7
; x9 -> PILA
; f9 -> PILA

; *** PILA *** 
; rbp
; rip  
; x6   rbp + 16
; x7   rbp + 24
; x8   rbp + 32
; x9   rbp + 40
; f9   rbp + 48

product_9_f:

	;prologo 
	push rbp
	mov rbp, rsp
	
	; COMPLETAR: convertimos los flotantes de cada registro xmm en doubles
	; cvtss2sd convierte scalar single float a scalar double float
	
	cvtss2sd xmm0, xmm0
	cvtss2sd xmm1, xmm1
	cvtss2sd xmm2, xmm2
	cvtss2sd xmm3, xmm3
	cvtss2sd xmm4, xmm4
	cvtss2sd xmm5, xmm5
	cvtss2sd xmm6, xmm6
	cvtss2sd xmm7, xmm7
	cvtss2sd xmm8, xmm8
	
	; COMPLETAR: multiplicamos los doubles en xmm0 <- xmm0 * xmm1, xmm0 * xmm2 , ...
	; mulsd multiplica scalar double pricision floats
	mulsd xmm0, xmm1
	mulsd xmm0, xmm2
	mulsd xmm0, xmm3
	mulsd xmm0, xmm4
	mulsd xmm0, xmm5
	mulsd xmm0, xmm6
	mulsd xmm0, xmm7
	mulsd xmm0, xmm8

	; COMPLETAR: convertimos los enteros en doubles
	; cvtsi2sd convierte scalar doubleword integer a scalar double float
	cvtsi2sd xmm1, rsi
	cvtsi2sd xmm2, rdx
	cvtsi2sd xmm3, rcx
	cvtsi2sd xmm4, r8
	cvtsi2sd xmm5, r9
	cvtsi2sd xmm6, [rbp+ 16]
	cvtsi2sd xmm7, [rbp+ 24]
	cvtsi2sd xmm8, [rbp+ 32]
	cvtsi2sd xmm9, [rbp+ 48]
	;cvtsi2sd xmm6, [rbp+0x10]
	;cvtsi2sd xmm7, [rbp+0x18]
	;cvtsi2sd xmm8, [rbp+0x20]
	;cvtsi2sd xmm9, [rbp+0x28]

	; multiplicamos los enteros convertidos por xmm0
	mulsd xmm0, xmm1
	mulsd xmm0, xmm2
	mulsd xmm0, xmm3
	mulsd xmm0, xmm4
	mulsd xmm0, xmm5
	mulsd xmm0, xmm6
	mulsd xmm0, xmm7
	mulsd xmm0, xmm8

	; guardamos el resultado en el lugar apuntado por destination
	cvtsd2ss xmm0, xmm0
	;mov [rdi], xmm0

	; epilogo 
	pop rbp
	ret
