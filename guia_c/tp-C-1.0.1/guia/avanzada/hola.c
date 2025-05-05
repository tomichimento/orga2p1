#include <stdio.h>

#define NAME_LEN 50


typedef struct {

    char name[NAME_LEN + 1];
    int vida;
    double ataque;
    double defensa;

} monstruo_t;



void print_monstruos(monstruo_t[] monstruos, int cantidad) {

    for (int i = 0; i < cantidad; i++) {

        printf("Nombre: %s\n", monstruos[i].name);
        printf("Vida: %d\n", monstruos[i].vida);
        printf("Ataque: %f\n", monstruos[i].ataque);
        printf("Defensa: %f\n", monstruos[i].defensa);
    }
}
    
int main() {
    
    monstruo_t monstruos[] = {
        [0] = {"juan", 54, 3.4, 3.5},
        [1] = {"maxi", 100, 1.01, 2.032},
    };

    print_monstruos(monstruos, 2);
    
    return 0;
}