#include <stdio.h>
#include <stdint.h>

// 1
// int main() {
//     printf("Hola Orga!\n");

//     return 0;
// }

// 3
// int main() {
//     char c = 100;
//     short s = -8712;
//     int i = 123456;
//     long l = 1234567890;

//     printf("char(%lu): %d \n", sizeof(c), c);
//     printf("short(%lu): %d \n", sizeof(s), s);
//     printf("int(%lu): %d \n", sizeof(i), i);
//     printf("long(%lu): %ld \n", sizeof(l), l);

//     return 0;
// }

// 4
// int main() {
//     int8_t c = 100;
//     int16_t s = -8712;
//     int32_t i = 123456;
//     int64_t l = 1234567890;

//     printf("int8_t(%lu): %d \n", sizeof(c), c);
//     printf("int16_t(%lu): %d \n", sizeof(s), s);
//     printf("int32_t(%lu): %d \n", sizeof(i), i);
//     printf("int64_t(%lu): %ld \n", sizeof(l), l);

//     return 0;
// }

// 5
// int main() {
//     float f = 10.0F; // float
//     double d = 10.0; //double

//     printf("%f \n", f);
//     printf("%f \n", d);

//     int float_int = (int) f;
//     int double_int = (int) d;

//     return 0;
// }

// 6
// int main() {

//     int mensaje_secreto[] = {116, 104, 101, 32, 103, 105, 102, 116, 32, 111,
//     102, 32, 119, 111, 114, 100, 115, 32, 105, 115, 32, 116, 104, 101, 32,
//     103, 105, 102, 116, 32, 111, 102, 32, 100, 101, 99, 101, 112, 116, 105,
//     111, 110, 32, 97, 110, 100, 32, 105, 108, 108, 117, 115, 105, 111, 110};

//     size_t length = sizeof(mensaje_secreto) / sizeof(int);
//     char decoded[length];

//     for (int i = 0; i < length; i++) {
//         decoded[i] = (char) (mensaje_secreto[i]); // casting de int a char
//     }

//     for (int i = 0; i < length; i++) {
//         printf("%c", decoded[i]);
//     }
// }

// 9
//  int main() {
//      uint32_t a = 0xF0000000;
//      uint32_t b = 0x0000000F;

//     uint32_t b_2 = b << 29;
//     uint32_t mask = 0xE0000000;

//     uint32_t igualdad = (a & mask) & (b_2);

//     if (igualdad == 0xE0000000) {
//         printf("IGUALES");
//     } else {
//         printf("DISTINTOS");
//     }

//     return 0;
// }

// # define FELIZ 0
// # define TRISTE 1

// void ser_feliz(int estado);
// void print_estado(int estado);

// int main(){
//     int estado = TRISTE; // automatic duration. Block scope
//     ser_feliz(estado);
//     print_estado(estado); // qu´e imprime?
// }
// void ser_feliz(int estado){
//     estado = FELIZ;
// }
// void print_estado(int estado){
//     printf("Estoy %s\n", estado == FELIZ ? "feliz" : "triste");
// }

// # define FELIZ 0
// # define TRISTE 1

// int estado = TRISTE; // static duration. File scope
// void ser_feliz();
// void print_estado();

// int main(){
//     print_estado();
//     ser_feliz();
//     print_estado(); // qu´e imprime?
// }
// void ser_feliz(){
//     estado = FELIZ;
// }
// void print_estado(){
//     printf("Estoy %s\n", estado == FELIZ ? "feliz" : "triste");
// }

// int g = 10;

// void functionA() {
//     int a = 20;
//     static int b = 30;
//     printf("Dentro de functionA:\n");
//     printf(" g = %d\n", g);
//     printf(" a = %d\n", a);
//     printf(" b = %d\n", b);
//     // Modificaci´on de las variables
//     g += 5;
//     a += 10;
//     b += 5;
// }

// void functionB() {
//     int a = 40;
//     static int c = 50;
//     printf("\nDentro de functionB:\n");
//     printf(" g = %d\n", g);
//     printf(" a = %d\n", a);
//     printf(" c = %d\n", c);
//     // Modificaci´on de las variables
//     g += 5;
//     a += 10;
//     c += 5;
// }

// int main() {
//     printf("Dentro de main:\n");
//     printf(" g = %d\n", g);
//     functionA();
//     functionB();
//     functionA();
//     functionB();
//     printf("\nFinal en main:\n");
//     printf(" g = %d\n", g);
//     return 0;
// }

int main() {
    int n = 0;
    int i = 4;
    while(i){
        i>>=1;
        n += i;
    }
    printf("%d", n);
}