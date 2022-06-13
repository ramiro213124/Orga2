#include<stdio.h>
#include<stdint.h>


void imprimeParametros (int a, double f, char* s);
void sumaEImprime (uint8_t a, uint8_t b);
void main(){
    sumaEImprime(255,7);


}


 


void sumaEImprime (uint8_t a, uint8_t b){
    uint8_t res =a+b;
    printf("El resultado de la suma de 8 bits es: %u\n", a+b);
}

/*
void imprimeParametros (uint32_t a, double f, char* s){
    printf("a: %i, f: %f, s: %s\n", a,f,s);
}
*/
/*
 /*
    // MAIN:
    // Suma elementos de un vector de 16 bits
    short v[4]={1,2,3,4};
    short res= suma(v,4);
    printf("La suma del vector es %d\n",res);
    

short suma(short* v, short n){
    short res=0;
    for(int i=0; i<n; i++){
        res+= v[i];
    }
    return res;
}
*/