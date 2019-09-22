#include <stdio.h> 
#include <conio.h> 
 
void CalculoMedia() 
{ 
    float NotaDaP1, NotaDaP2; 
    float Media; 
     
    clrscr(); // Limpa a tela  
    NotaDaP1 = 6.6;  // Atribuição do Valores das médias 
    NotaDaP2 = 8.2; 
     
    Media = (NotaDaP1 + NotaDaP2) / 2.0; 
     
    printf("Média Final : %6.3f", Media); 
    /* No momento da execução sinal %6.3f vai ser substituído 
    pelo valor da variável Media 
    Média Final:  7.400 */ 
    getch(); // Espera que o usuário pressione uma tecla 
} 
 
int VerificaNumero() 
{ 
    int num; 
    string s; 
     
    printf ("Digite um número: "); 
    scanf ("%d",&num); 
     
    if (num>10) 
    { 
        printf ("\n\n O número é maior que 10"); 
        s = "errou"; 
    } 
    if (num==10) 
    { 
        printf ("\n\n Você acertou!\n"); 
        printf ("O numero é igual a 10."); 
        s = "acertou"; 
    } 
    if (num<10) 
    { 
        printf ("\n\n O número é menor que 10"); 
        s = "errou"; 
    }     
    if(num == 10 && s == "acertou") 
    { 
        return 1; 
    } 
    return 0; 
} 
void AlterarVetor(int * vetor, int elementos) 
{ 
    int i; 
         
    if(vetor != NULL) 
    { 
        for(i = 0; i < elementos; i++) 
        { 
            *(vetor) = *(vetor) * 2; //Ex: V[i] = V[i] * 2 
            vetor++; //Desloca o ponteiro para o próximo elemento 
        } 
    } 
} 
 
int main() 
{ 
    int v[] = {5, 10, 15, 3, 10, 76, 5, 13, 33, 45}; 
    int * pt; 
    int i; 
      
    pt = v; //Atribui o endereço do vetor 
      
    AlterarVetor(v, 10); 
      
    for(int i = 0; i < 10; i++) 
    { 
        printf("V[%i] = %i\r\n", i, *(pt + i)); 
    } 
     
    CalculoMedia(); 
    VerificaNumero(); 
     
    return 0; 
}

