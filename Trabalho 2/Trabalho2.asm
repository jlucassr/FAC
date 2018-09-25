# Trabalho 2 da Disciplina de Fundamentos de Arquitetura de Computadores da UnB-FGA

# Alunos:Luciano dos Santos Silva - 160013321 
#	 João Lucas Sousa Reis    - 160009758
# O trabalho 2 constitue em Implementar um programa em assembly MIPS que através do terminal do MARS 
# seja possível ler dois números inteiros positivos e maiores que 1 e deve apresentar distintos resultados de MDC E MMC.

.data
	valor1: .asciiz "Digite o primeiro valor: "
	valor2: .asciiz "DIgite o segundo valor: "
	pulaLinha: .asciiz "========================="
	resultadoMMC: .asciiz "\nMMC: "
	resultadoMDC: .asciiz "\nMDC: "
	msg: .asciiz "\nInvalido"

.text


main:


	
	
	
	li   $v0, 4
	la   $a0, valor1
	syscall
	
	li   $v0, 5
	syscall
	
	#atribui o primeiro valor digitado pelo usuário ao registrador $t1
	move $s1, $v0
	
	li   $v0, 4
	la   $a0, valor2
	syscall
	
	li   $v0, 5
	syscall
	
	#atribui o primeiro valor digitado pelo usuário ao registrador $t2
	move $s2, $v0
	
	#compara o primeiro valor digitado pelo usuário a 1 e armazena o resultado no registrador $t3
	slti $t1, $s1, 1	
	#compara o segundo valor digitado pelo usuário a 1 e armazena o resultado no registrador $t4
	slti $t2, $s2, 1
	or $t3, $t1, $t2

	#verifica se for falso
	beq  $t3, $zero,Else
	
	#imprime msg
	li   $v0, 4
	la   $a0, msg
	syscall
	li   $v0, 4
	syscall
	
	
	Else:
		move $s3, $s1 #a
		move $s4, $s2 #b
		Loop: beq $s4, $zero,Exit
		      move $t2, $s3 #temp = a
		      move $s3, $s4 #a=b
		      div  $t2, $s4 #temp % b
		      mfhi $t6 #temporario para o modulo
		      move $s4, $t6 # b = temp % b 
		      j Loop

	Exit:
			      
		      
       move $s4, $s3
       div  $t1, $s2, $s3
       mult $s1, $t1
       mflo $t2
       move $s5, $t2
       
       
       
       li $v0, 4
       la $a0, resultadoMMC
       syscall
       li $v0, 1
       la $a0, ($s5)
       syscall
       
       li $v0, 4
       la $a0, resultadoMDC
       syscall
       li $v0, 1
       la $a0, ($s4)
       syscall
       
  

	
	
	
	
	
	
	
