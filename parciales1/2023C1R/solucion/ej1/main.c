#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "ej1.h"

int main(void)
{
    // Test de acumuladoPorCliente
    uint8_t cantidadDePagos = 5;
    pago_t pagos[5] = {
        {100, "comercio1", 1, 1},
        {200, "comercio2", 2, 1},
        {150, "comercio3", 1, 0},
        {200, "comercio4", 9, 1},
        {50, "comercio5", 2, 0}};

    uint32_t *resultado = acumuladoPorCliente_asm(cantidadDePagos, pagos);

    for (int i = 0; i < 10; i++)
    {
        printf("Cliente %d: %d\n", i + 1, resultado[i]);
    }

    free(resultado);

    // Test de son_iguales
    char str1[] = "hello";
    char str2[] = "hello";
    uint8_t resultado_str = son_iguales((uint8_t *)str1, (uint8_t *)str2, strlen(str1));
    printf("Resultado strings: %d\n", resultado_str); // Debe ser 1 (verdadero)

    // Test de en_blacklist
    char* lista_comercios[3] = {"comercio3", "comercio0", "comercio0"};
    char* comercio_a_buscar = "comercio2";
    uint8_t resultado_blacklist = en_blacklist_asm(comercio_a_buscar, lista_comercios, 3);
    if (resultado_blacklist) {
        printf("%s está en la blacklist\n", comercio_a_buscar);
    } else {
        printf("%s no está en la blacklist\n", comercio_a_buscar);
    }

    char* lista_comercios2[3] = {"a", "b", "c"};
    char* comercio_a_buscar2 = "b";
    uint8_t resultado_blacklist2 = en_blacklist_asm(comercio_a_buscar2, lista_comercios2, 3);
    if (resultado_blacklist2) {
        printf("%s está en la blacklist\n", comercio_a_buscar2);
    } else {
        printf("%s no está en la blacklist\n", comercio_a_buscar2);
    }

    return 0;
}