# FAC: TRABALHO 03
# Alunos: Joao Lucas Sousa Reis - 160009758
#	  Luciano dos Santos Silva - 160013321

# 	O Trabalho 3 constitue implementar um programa em assembly MIPS que atraves
# do treminal do MARS seja possivel ler um numero em ponto flutuante positivo
# e deve apresentar o resultado do arc-cot desse numero.

	.text
	
main:
	li $v0, 4
	la $a0, valor
	syscall
	
	li $v0, 7	# numero em double a ser digitado
	syscall	
      
# =================== IMPLEMENTE AQUI SUA SOLUCAO: INICIO

# O valor lido do teclado estah em $f0
# Declarações dos registradores

	l.d $f2, numD1 # $f2 = 1.0
	la $t1, limInteracoes # t1 = 1000000 
	l.d $f8, numD0
	l.d $f4, pi
	l.d $f18, numD2
	
	c.lt.d $f0, $f8 # verifica se o numero digitado eh menor que 0
	bc1t erroNegativo # se for vai para branch erroNegativo
	c.eq.d $f0, $f8 # verifica se o numero digitado eh igual a0
	bc1t calculaIgual0 # caso seja vai para a branch calculaIgual0
	c.le.d $f0, $f2 # condição caso $f0 for menor que 1 
	bc1t calculaMenor1 # se for verdadeiro, vai ser calculado com $f0<1
	bc1f calculaMaior1 # se for falso, o calculo sera de $f0>1
	j fim

erroNegativo:
	#funcao para verificar se o numero eh negativo, caso seja uma mensagem de erro deve retornar
	li $v0, 4
	la $a0, erro
	syscall
	
	li $v0, 55
	syscall 
	j main # vai pra main
	

calculaIgual0:
	#funcao para calcular o arc-cot de 0
	
	div.d $f4, $f4, $f18 # $f4=pi/2
	mov.d $f12, $f4 # $f12 = $f4
	j fim
	
calculaMenor1:
	#funcao para calcular o arc-cot do numero digitado menor que 1 utilizando a serie de Taylor
	
	l.d $f6, limiteExp # f6 = 10^(-12)
	li $t0, 0 # t0 = 0 # para contador iniciar em 0
	mov.d $f12, $f4 # move $f4 para $f12
	mov.d $f10, $f18 # move $f18 para $f10 
	div.d $f12, $f12, $f10 # $f12 = pi/2
	mul.d $f12, $f12, $f0 # $f12 = (pi/2)*numero
	li $a0, -2 #a0 = -2
	mov.d $f30, $f0 # $f30 = numero
	jal potencia #vai para o calculo da potencia
	
	sqrt.d $f10, $f28 # calcula a raiz quadrada de $f28 e guarda o resultado em $f10
	mul.d $f12, $f12, $f10 # multiplica $f12 pela raiz de $f28 ((pi/2)*numero)*(1/(numero^2)
	mov.d $f10, $f8 
	
loopMenor1:
	
	l.d $f30, numNegD1 # carrega o valor de -1.0 para $f30
	add $a0, $t0, $0 # carrega como potencia de -1
	jal potencia # vai para branch potencia para calcular (-1^j)
	
	mov.d $f14, $f28 #move o valor calculado para $f14
	li $a0, 2 # carrega como imediato o valor 2 
	mul $a0, $t0, $a0 # calcula 2*j sendo que j representa a parcela
	addi $a0, $a0, 1 # calcula (-2*j-1)
	mov.d $f30, $f0 # move o resultado para $f30 para calcula a potencia
	jal potencia # va para potencia
	
	mul.d $f14, $f14, $f28 # calcula ((-1)^j)*(numero^(2*j+1))
	li $t2, 2
	mul $t2, $t0, $t2 # calcula 2*j
	addi $t2, $t2, 1 # calcula t2+1
	mtc1.d $t2, $f16 # converte o resultado de $t2 em double
	cvt.d.w $f16, $f16 # converte de inteiro  para o double o resultado de $t2
	div.d $f14, $f14, $f16 # calcula (((-1)^j)*(numero^(2*j+1)))/(2*j+1)
	add.d $f10, $f10, $f14 # soma a parcela da soma geral
	addi $t0, $t0, 1 # contador j++
	jal verificaParcelaMenor1
	
verificaParcelaMenor1:
	# funcao para verificar se a parcela eh menor que 0
	
	c.lt.d $f14, $f8 
	bc1f parcelaPositivaMenor1
	l.d $f26, numNegD1 # f26 = -1.0
	mul.d $f14, $f14, $f26 # calcula parcela * (-1)
	
parcelaPositivaMenor1:
	# funcao para verificar parcela < limite, 
	
	c.lt.d $f6, $f14
	bc1f endLoopMenor1 # caso parcela < limite sai do loop
	slt $s4, $t0, $t1
	bnez $s4, loopMenor1

endLoopMenor1:
	# funcao que finaliza o calculo do arco cotangente caso seja menor que 1
	sub.d $f12, $f12, $f10
	j fim

calculaMaior1:
	# 	funcao para calcular o arc-cot do numero digitado maior que 1 
	# utilizando a serie de Taylor
	
	l.d $f10, limiteExp # f10 = 10^(-12)
	l.d $f12, numD0 #f12 = 0.0
	li $t0, 0 # t0 = 0
	
loopMaior1:
	
	l.d $f30, numNegD1 # carrega o valor -1
	li $a0, 0 # carrega o contador 
	jal potencia # calcula a potencia (-1^j)
	
	mov.d $f14, $f28 #move o valor calculado para $f14
	li $a0, -2  # carrega como imediato o valor de -2 
	mul $a0, $a0, $t0 # calcula -2*j sendo que j eh parcela
	li $t6, 1
	sub $a0, $a0, $t6 # calcula (-2*j-1)
	mov.d $f30, $f0 # move o resultado para $f30 para calcula a potencia
	jal potencia # calcula o potencia
	
	mul.d $f14, $f14, $f28 # multiplica ((-1)^j) por (numero^(-2*j-1))
	li $t2, 2 # t2 = 2
	mul $t2, $t0, $t2 #2*j
	addi $t2, $t2, 1 #calcula t2+1
	mtc1.d $t2, $f16 # converte o resultado de $t2 em double
	cvt.d.w $f16, $f16 # converte de inteiro  para o double o resultado de $t2
	div.d $f14, $f14, $f16 # calcula ((numero^(2*j+1))*((-1)^j))/(2*j+1)
	add.d $f12, $f12, $f14 
	addi $t0, $t0, 1
	jal verificaParcelaMaior1
	
verificaParcelaMaior1:
	# funcao para verificar se a parcela eh maior  que 0
	
	c.lt.d $f14, $f8
	bc1f parcelaPositivaMaior1
	l.d $f26, numNegD1
	mul.d $f14, $f14, $f26

parcelaPositivaMaior1:
	 # funcao para verificar parcela < limite, 
	c.lt.d $f10, $f14
	bc1f fim
	slt $s4, $t0, $t1
	bnez $s4, loopMaior1
	
potencia:
	#funcao para calcular a potencia 
	
	mov.d $f28, $f30 # copia o numero para $f28 para calculos referentes a potenciacao
	li $s1, 1 #s1 = 1 para contador iniciar em 1
	seq $s2, $a0, 0 # verifica se a base eh igual a 0
	beqz $s2, loopPotencia # se for falso  vai para potenciaMaior0
	l.d $f28, numD1 #se for verdadeiro continua o calculo
	jr $ra
	
loopPotencia:
	# funcao loop para calculos das potencias
	
	slt $s2, $a0, $0 # verifica se a base eh negativa
	beqz $s2, loopPotenciaPositiva # se for positivo vai para a branch 
	li $s3, -1 # s3 = 1, se for negativa continua
	mul $a0, $a0, $s3 # multiplica por -1 o numero para ser negativo

loopPotenciaPositiva:
	
	slt $s3, $s1, $a0 # verifica se o contador eh menor do que a base
	beqz $s3, fimLoopPotencia # se for maior que a base finaliza o loop
	mul.d $f28, $f28, $f30 # se for menor calcula o potencia
	addi $s1, $s1, 1 # i++
	j loopPotenciaPositiva

fimLoopPotencia:
	
	beq $s2, $0, return # se o numero for negativo vai pro return
	div.d $f24, $f2, $f28 #$f24 = f26/f28 
	mov.d $f28, $f24 # move o resultado para $f28

return:
	jr $ra
		
# O valor do resultado do arccot devera ser escrito em $f12
	
# =================== IMPLEMENTE AQUI SUA SOLUCAO: FIM      
fim:
      jal  print            # call print routine. 
      li   $v0, 10          # system call for exit
      syscall               # we are out of here.
      
#########  routine to print messages
      .data

limInteracoes:	.word 	 1000000 # limite de interacoes da convergencia do arco cotagente
numD1:		.double  1.0
numNegD1:	.double -1.0
numD2:		.double  2.0
numD0:		.double  0.0
limiteExp:	.double  0.00000000001 # limite da exponencial 10^(-12)
pi:		.double  3.14159265358
space:		.asciiz  " "          # space
new_line:	.asciiz  "\n"         # newline
string_ARCCOT:	.asciiz  "arc-cot = "
valor:		.asciiz  "\nDigite o valor: "
erro:		.asciiz  "Erro, digite um numero maior ou igual a 0"

      .text
print:	la   $a0, string_ARCCOT  
      	li   $v0, 4		# specify Print String service
      	syscall               	# print heading
      	move   $a0, $t0      	# 
	li   $v0, 3           	# specify Print Double service
      	syscall               	# print $t0

# Repetindo essa parte apenas para o Spim compilar o programa sem problemas
	li   $v0, 10          # system call for exit
      	syscall               # we are out of here.
      
