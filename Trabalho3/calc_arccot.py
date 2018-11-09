from decimal import Decimal as D
from decimal import localcontext


def main():

    pi = 3.141592654
    num = float(input("Digite um numero : "))
    parcela = 0

    if(num >= 0 and num < 1):
        x = 1 #contador
        potencia = pow(10,-12)
        #print(potencia)
        numero = 1/potencia #medida de erro do professor
        #primeiro termo da série
        parcela = num
        print("Parcela: ",parcela)
        while parcela > numero:
            parcela = parcela - pow(num, x)/x
            while(parcela > numero):
                parcela = parcela + pow(num, x)/x
                x = x+4
            x = x+2
        final = (pi/2)-parcela
        print(final)

    if (num >= 1):
        #aumentar a precisão pra não dar erro de overflow
        with localcontext() as ctx:
            ctx.prec = 1000  # 100 digits precision
            x = 1
            potencia = pow(10,12)
            print("potencia: ", potencia)
            numero = 1/potencia
            print("numero: ", numero)
            #primeiro termo
            parcela = D(1/num) #D é de decimal
            print("parcela: ", parcela)
            while parcela > numero:
                x += 2
                parcela -= D(1/(x*pow(num, x)))
                #while parcela > numero:
                x += 2
                parcela += D(1/(x*pow(num, x)))
                print(parcela)


#    if(num < 0):
 #       x = 1
  #      potencia = pow(10,12)
   #     print("potencia: ", potencia)
    #    numero = 1/potencia
     #   print("numero: ", numero)
        #primeiro termo
      #  parcela = pi+(1/num)
       # print("parcela: ", parcela)
        #while parcela > numero:
         #   x += 2
          #  parcela -= 1/(x*pow(num, x))
           # #while parcela > numero:
            #x += 2
            #parcela += 1/(x*pow(num, x))
            #print(parcela)


main()

def pow(numero, potencia):

    if(potencia==0):
        return 1
    while(potencia>1):
        numero*=numero
        potencia -= potencia

    return potencia
