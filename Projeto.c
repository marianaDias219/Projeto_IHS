#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>

int main(int argc, char* argv[]){
    FILE *input;
    FILE *output;
    input = fopen(argv[1], "r");
    output = fopen(argv[2], "w");

    int numPaleta;
    int* vetCores;
    int cores;
    int cont = 0;
    int contmatriz = 0;

    int decimalValue;

    int i;
    int j;
    int tam;

    int quantImg;
    char elem;

    fscanf(input, "%d", &numPaleta);
    
    // leitura das cores da paleta
    while(cont < numPaleta){
        vetCores[cont] = fscanf(input, "%x", &cores);
        vetCores[cont] = cores;
        //fprintf(output, "%c", (vetCores[cont]));
        cont++;
    }
    
    //Leitura quantidade de imagens
    fscanf(input, "%d", &quantImg);

    cont = 0;
      

    while (cont < quantImg) {
        fprintf(output, "[%d]", cont);
        fscanf(input, "%d", &i);
        fscanf(input, "%d", &j);
        tam = i*j;
        
        while(contmatriz < tam*2 + j*i){
    
        

        
        fscanf(input, "%c", &elem);
        sscanf(&elem, "%x", &decimalValue);
        if (elem != (' ') && elem != '\n') fprintf(output, "%c", vetCores[decimalValue]);

        if (contmatriz % ((j*2)+j) == 0) fprintf(output, "%c", '\n');
        
                     
        
        contmatriz++; 
        }  
        cont++;      
    }
    fclose(input);
    fclose(output);

    return 0;
}
