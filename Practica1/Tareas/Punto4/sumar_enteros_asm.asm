section .text
global sumarenteros
sumarenteros:
	push rbp
	mov rbp, rsp

	; edi: entero1 = x
	; esi: entero2 = y
	add edi, esi

	mov eax, edi

	pop rbp
	ret
