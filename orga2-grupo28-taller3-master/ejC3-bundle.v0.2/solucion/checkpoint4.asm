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


; int32_t strCmp(char* a, char* b)
strCmp:
push rbp
mov rbp, rsp

xor rax, rax            ; seteamos valor 0

loopCmp:
mov rbx, [rdi]          ; guardamos en rbx el char actual de a
add rdi, 1              ; incrementamos rdi
mov rcx, [rsi]          ; guardamos en rcx el char actual de b
add rsi, 1              ; incrementamos rsi
cmp rbx, rcx            ; comparamos los chars
je iguales              ; si son iguales, vamos a iguales
cmp rbx, 0              ; verificamos si termino el string a
je menor                ; si es 0, a es menor
cmp rcx, 0              ; si no, verificamos si termino el string bytes
je mayor                ; si es 0, a es mayor
cmp rbx, rcx            ; comparamos los char nuevamente
ja mayor                ; si rbx es mayor, saltamos a mayor, sino vamos a menor

menor:
mov rax, 1
jmp endCmp

mayor:
mov rax, -1
jmp endCmp

iguales:
cmp rbx, 0              ; comparamos con 0 para verificar si llegamos al final
jne loopCmp             ; si no son 0, hay que seguir comparando

endCmp:
pop rbp
ret



; char* strClone(char* a)
strClone:
push rbp
mov rbp, rsp

mov rbx, rdi            ; guardamos en rbx el puntero al original
call strLen             ; para saber la cantidad de memoria que vamos a usar
mov rdi, rax            ; edi es el parametro que recibe malloc
add rdi, 1              ; agregamos un lugar para '\0'
call malloc             ; reservamos la memoria, rax apunta a esta
mov rcx, rax            ; guardamos en rcx el puntero al clon

loopClone:
mov r8, [rbx]           ; guardamos en r8 el char actual
mov [rcx], r8           ; copiamos el char al clon
cmp r8, 0               ; comparamos el char con 0
je endClone             ; si era el ultimo char del string, terminamos
add rbx, 1
add rcx, 1
jmp loopClone           ; si no era el ultimo, seguimos copiando

endClone:
pop rbp
ret



; void strDelete(char* a)
strDelete:
push rbp
mov rbp, rsp

loopDelete:
mov rdx, [rdi]          ; guardamos el char actual en edx
cmp rdx, 0              ; comparamos el char catual con 0
je endLen               ; si edx es 0 terminamos
call free               ; liberamos la memoria apuntada por rdi
add rdi, 1              ; incrementamos la dir actual size(char) bytes
jmp loopLen             ; volvemos a loop

endDelete
call free               ; liberamos la memoria del '\0'
pop rbp
ret



; void strPrint(char* a, FILE* pFile)
strPrint:
push rbp
mov rbp, rsp

mov rcx, rdi
loopPrint:
mov rdi, [rcx]          ; guardamos en rdi el contenido de la dir actual
cmp rdi, 0              ; comparamos el char actual con 0
je endPrint             ; si era 0, terminamos
xor rax, rax            ; no vamos a imprimir argumentos de punto flotante
call fprintf            ; escribimos, fprintf(rdi, rsi)
add rcx, 1              ; pasamos a la siguiente dir
jmp loopPrint           ; volvemos a loopPrint

endPrint:
pop rbp
ret



; uint32_t strLen(char* a)
strLen:
push rbp
mov rbp, rsp

xor rax, rax            ; seteamos el contador en 0
loopLen:
mov rdx, [rdi]          ; guardamos el char actual en edx
cmp rdx, 0              ; comparamos el char catual con 0
je endLen               ; si edx es 0 terminamos
add rax, 1              ; incrementamos el contador en 1
add rdi, 1              ; incrementamos la dir actual size(char) bytes
jmp loopLen             ; si no, volvemos a loop

endLen:
pop rbp
ret                     ; el resultado se retorna en eax


