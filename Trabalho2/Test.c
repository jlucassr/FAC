#include <stdio.h>
#include <stdlib.h>

int main(){

    int n1, n2, a, b, temp, mdc, mmc;

    printf("Digite o Primeiro Numero: ");
    scanf("%d", &n1);

    printf("Digite o Segundo Numero: ");
    scanf("%d", &n2);

	if (n1 <= 1 || n2 <= 1){
		printf("Invalido");
		return 0;
	}
	else{

    a = n1;
    b = n2;

    while(b != 0){

        temp = a;
        a = b;
        b = temp%b;
    }

    mdc = a;
    mmc = n1 * n2/a;

    printf("\nMDC: %d\n", mdc);
    printf("\nMMC: %d\n", mmc);
    
	}
	
    return 0;
	}
