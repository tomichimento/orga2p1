#include <stdio.h>

#define NAME_LEN 50


typedef struct {

    char name[NAME_LEN + 1];
    int vida;
    double ataque;
    double defensa;

} monstruo_t;



void print_monstruos(monstruo_t monstruos[], int cantidad) {

    for (int i = 0; i < cantidad; i++) {

        printf("Nombre: %s\n", monstruos[i].name);
        printf("Vida: %d\n", monstruos[i].vida);
        printf("Ataque: %f\n", monstruos[i].ataque);
        printf("Defensa: %f\n", monstruos[i].defensa);
    }
}

monstruo_t evolution(monstruo_t m) {
    monstruo_t nuevo = m;
    nuevo.ataque += 10;
    nuevo.defensa += 10;
    return nuevo;
}

int main() {
    
    // monstruo_t monstruos[] = {
    //     [0] = {"juan", 54, 3.4, 3.5},
    //     [1] = {"maxi", 100, 1.01, 2.032},
    // };

    // print_monstruos(monstruos, 2);
    
    // monstruo_t viejo = {"Ricardo", 5000, 20, 30};
    // printf("Viejos atributos: (%f, %f)\n",
    //         viejo.ataque, viejo.defensa);

    // monstruo_t nuevo = evolution(viejo);

    // printf("Nuevos atributos: (%f, %f)\n",
    //         nuevo.ataque, nuevo.defensa);
    
    // monstruo_t viejo = {"Ricardo", 5000, 20, 30};

    int x = 42;
    int *p = &x;
    printf("Direccion de x: %p Valor: %d\n", (void*) &x, x);
    printf("Direccion de p: %p Valor: %p\n", (void*) &p, (void*) p);
    printf("Valor de lo que apunta p: %d\n", *p);

    return 0;
}