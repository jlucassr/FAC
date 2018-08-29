# Trabalho 1 da Disciplina de Fundamentos de Arquitetura de Computadores da UnB-FGA

# Alunos: João Lucas Sousa Reis    - 160009758
#	  Luciano dos Santos Silva - 160013321

# O trabalho 1 constitue em Implementar um programa em assembly MIPS que através do terminal do MARS 
# seja possível ler dois números inteiros e deve apresentar distintos resultados de soma e subtração e de Portas lógicas. 

.data

	Valor1: .asciiz "Digite o Primeiro Valor: "
	Valor2: .asciiz "Digite o Segundo Valor: "
	PulaLinha: .asciiz "============="
	ResultadoADD: .asciiz "\nADD: "
	ResultadoSUB: .asciiz "\nSUB: "
	ResultadoAND: .asciiz "\nAND: "
	ResultadoOR: .asciiz "\nOR: "
	ResultadoXOR: .asciiz "\nXOR: "
	
.text

main:
	# Imprime o primeiro número a ser digitado pelo usuário
	
	li $v0, 4 
	la $a0, Valor1
	syscall
	
	li $v0, 5
	syscall
	
	move $t1, $v0  # Move o número digitado do usuário para o registrador $t1
	
	# Imprime o Segundo número a ser digitado pelo usuário
	
	li $v0, 4
	la $a0, Valor2
	syscall
	
	li $v0, 5
	syscall
	
	move $t2, $v0 # Move o número digitado do usuário para o registardor $t2
	
	# Execução dos cálculos de soma e subtração e de Portas lógicas

	add $t3, $t1, $t2 # Soma $t1 e $t2 e armazena o resultado no registrador $t3
	
	sub $t4, $t1, $t2 # Subtrai $t1 e $t2 e armazenda o resultado no registrador $t4
	
	and $t5, $t1, $t2 # Faz a lógica binária da porta lógica AND de $t1 e $t2 e armazena o resultado no registrador $t5
	
	or $t6, $t1, $t2 # Faz a lógica binária da porta lógica OR de $t1 e $t2 e armazena o resultado no registrador $t6
	
	xor $t7, $t1, $t2 # Faz a lógica binária da porta lógica XOR (ou exclusivo) de $t1 e $t2 e armazena o resultado no registrador $t7

	# Chamada da quebra de linha

	li $v0, 4
	la $a0, PulaLinha
	syscall
	
	# Chamada do resultado da SOMA
	
	li $v0, 4
	la $a0, ResultadoADD
	syscall
	
	li $v0, 1
	la $a0, ($t3)
	syscall
	
	# Chamada do resultado da SUBTRAÇÃO
	
	li $v0, 4
	la $a0, ResultadoSUB
	syscall
	
	li $v0, 1
	la $a0, ($t4)
	syscall
	
	# Chamada do resultado da Porta Lógica AND
	
	li $v0, 4
	la $a0, ResultadoAND
	syscall
	
	li $v0, 1
	la $a0, ($t5)
	syscall
	
	# Chamada do resultado da Porta Lógica OR
	
	li $v0, 4
	la $a0, ResultadoOR
	syscall
	
	li $v0, 1
	la $a0, ($t6)
	syscall
	
	# Chamada do resultado da Porta Lógica XOR
	
	li $v0, 4
	la $a0, ResultadoXOR
	syscall
	
	li $v0, 1
	la $a0, ($t7)
	syscall
	
	# Finaliza o Programa
	
	li $v0, 10
	syscall
