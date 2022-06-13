#include "lista.h"

extern void agregarPrimero(lista_t* unaLista, int unInt);


int main(int argc, char* argv){
	
	lista_t lista;
	lista.primero = NULL;

	agregarPrimero(&lista, 3);
	agregarPrimero(&lista, 2);
	agregarPrimero(&lista, 1);

	printList(&lista);

	vaciarLista(&lista);
	return 0;

}
/*
void agregarPrimero(lista_t* unaLista, int unInt){
	nodo_t* aux = malloc(sizeof(nodo_t));
	aux->dato = unInt;
	aux->prox = unaLista->primero;
	unaLista->primero= aux;
}
*/

