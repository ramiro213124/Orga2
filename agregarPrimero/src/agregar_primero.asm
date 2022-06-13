section.text:
	global agregarPrimero
	extern malloc

	agregarPrimero:
		push rbp
		mov rbp, rsp ; pila alineada
		push rbx		 ; pila alineada 8
		push r12		 ; pila alineada 16
		;void agregarPrimero(lista_t* unaLista, int unInt);
		; rdi = *unaLista
		; esi = unInt


		;void agregarPrimero(lista_t* unaLista, int unInt){
		;	nodo_t* aux = malloc(sizeof(nodo_t));
		;	aux->dato = unInt;
		;	aux->prox = unaLista->primero;
		;	unaLista->primero= aux;
		;}
		

		mov rbx, rdi ; rbx = unaLista	64 bits
		mov r12d, esi ; r12d = unInt	32 bits

		;1. Crear el nodo usando malloc

		mov rdi, 16	 ; 16 = tamaño de la estructura nodo
		call malloc  ; rax = el puntero a nuevo nodo

		mov [rax], r12d ; C: aux->dato = unInt

		;2. Conectar el nuevo nodo a su siguiente en la lista

		mov rdi, [rbx] ; vuelvo a poner en rdi su valor original: unaLista
		mov [rax + 8], rdi ; C: aux->prox = unaLista->primero;

		
		;3. Conectar el puntero anterior en la lista al nuevo nodo

		mov [rbx], rax  ; C: unaLista->primero= aux


		pop r12
		pop rbx
		pop rbp
		ret
























