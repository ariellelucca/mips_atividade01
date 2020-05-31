##########################
# Atividade 1            #
# Arielle Verri Lucca    #
# Rodrigo Jos� Fagundes  #
##########################

.data
vetor_A: 	   .word 0, 0, 0, 0, 0, 0, 0, 0				# Cada vetor deve ser declarado com 8 elementos inicializados em 0.Eles devem ser claramente identificados 
vetor_B: 	   .word 0, 0, 0, 0, 0, 0, 0, 0				# com nomes como vetor_A e vetor_B			
tamanhoVetor:      .asciiz "Digite o tamanho m�ximo dos vetores: "	# Para leitura, deve ser apresentada uma mensagem solicitando a entrada desse valor, indicando o seu limite m�ximo
elementoInvalido:  .asciiz "Valor invalido"				# No caso de entrada inv�lida, o programa deve imprimir uma mensagem de advert�ncia antes de solicitar
									# novamente a entrada
vetor_AChaves:     .asciiz "\n vetor_A["				# Usado para imprimir corretamente os valores dos vetores
vetor_BChaves:     .asciiz "\n vetor_B["
fechaChaves:       .asciiz "] = "
quantidadeVetor:   .asciiz "\n Quantidade de elementos do vetor: "
quantidadeIgual:     .asciiz "\n Quantidade de elementos iguais: "
###############################################

.text
li $s1,1 	# Define o tamanho m�nimo como 1
li $s2,8	# Define o tamanho m�ximo como 8

###############################################
li $s3,0 	# Sera o meu index / i = 0 / $s3 = 0
li $s7,0	# soma
###############################################

lacoInput:				# O programa deve solicitar ao usu�rio a entrada de cada elemento do vetor, um a um
	li $v0, 4     			# Defini��o de impress�o de string
	la $a0, tamanhoVetor  		# Solicita o tamanho do vetor e armazena em $a0
	syscall				# Mostra mensagem no terminal

	li $v0,5      			# Defini��o de leitura de inteiro
	syscall 			# Mostra mensagem no terminal
	
	add $t1, $zero, $v0 		# Armazena o valor no registrador $t1
	move $t2, $t1			# Move o tamanho do vetor para $t2
	
	blt $t1,1, valorEntradaInvalido # (branch if less than)    Se $t1 menor que 1 informa valor inv�lido
	bgt $t1,8, valorEntradaInvalido # (branch if greater than) Se $t1 maior que 8 informa valor inv�lico
	
	add $s2, $0, $t1        	# Salva o tamanho no registrador $s2
	j exitlacoInput             	# Fim do while
	
valorEntradaInvalido:
	li $v0,4  			# Defini��o de impress�o de string
	la $a0, elementoInvalido 	# Mostra mensagem de valor inv�lido no terminal
	syscall
	
	j lacoInput 			# Retorna lacoInput
exitlacoInput:				# T�rmino do lacoInput

	la $s4,vetor_A			# Armazena os valores de vetor_A em $s4
	la $s5,vetor_B			# Armazena os valores de vetor_B em $s5
	
	
# Fun��o que faz a leitura dos valores do vetor_A
whileVetorA: 
	beq $s3,$s2,exitWhileVetorA 	# (branch if not equal)	   Se $s3 < $s2 continua, sen�o pula para exitWhileVetorA
	add $t1,$s3,$s3 		# $t1 = 2*i
	add $t1,$t1,$t1 		# $t1 = 4*i
	add $t1,$t1,$s4 		# $t1 = vetor_A[i]

	# Faz as solicita��es de input para o usu�rio no console
	li $v0, 4       		# Informa que ir� imprimir uma string
	la $a0, vetor_AChaves   	# A string ser� 'vetor_A['	
	syscall				# Mostra a string no console
	
	li $v0, 1       		# Informa que ir� imprimir um inteiro
	add $a0, $s3,$0  		# Passa o $s3 como argumento de contagem a ser impresso no console
	syscall				# Mostra o inteiro no console
	
	li $v0, 4        		# Informa que ir� imprimir uma string
	la $a0, fechaChaves     	# Mostra " = ] " no console	
	syscall				# Mostra a string no console
	
	# Armazea os inputs digitados pelo usu�rio no console
	li $v0,5         		# Informa que ir� ler um inteiro
	syscall    			# Interage com o console

	sw $v0, 0($t1)   		# Armazena o inteiro digitado pelo usu�rio		
	add $s3,$s3,$s1  		# Incrementa o contador
	j whileVetorA			# Volta para o la�o while
exitWhileVetorA:			# T�rmino da execu��o do while

li $s3,0        			# Reseta o valor do index

# Ler o vetor_B ate terminarem os espacos indicados pelo usuario (tamanho seja preenchido)
whileVetorB: 
	beq $s3,$s2,exitWhileVetorB 	# (branch if not equal)	   Se $s3 < $s2 continua, sen�o pula para exitWhileVetorB
	add $t1,$s3,$s3 		# $t1 = 2*i
	add $t1,$t1,$t1 		# $t1 = 4*i
	add $t1,$t1,$s5 		# $t1 = vetor_B[i]
	
# Faz as solicita��es de input para o usu�rio no console
	li $v0, 4       		# Informa que ir� imprimir uma string
	la $a0, vetor_BChaves    	# A string ser� 'vetor_B['	
	syscall 			# Mostra a string no console
	
	li $v0, 1       		# Informa que ir� imprimir um inteiro
	add $a0, $s3,$0  		# Passa o $s3 como argumento de contagem a ser impresso no console
	syscall				# Mostra o inteiro no console
	
	li $v0, 4       		# Informa que ir� imprimir uma string
	la $a0, fechaChaves     	# Mostra " ] " no console	
	syscall				# Mostra a string no console

	# Armazea os inputs digitados pelo usu�rio no console
	li $v0,5         		# Informa que ir� ler um inteiro
	syscall   			# Interage com o console
	
	sw $v0, 0($t1)   		# Armazena o inteiro digitado pelo usu�rio
	add $s3,$s3,$s1  		# Incrementa o contador
	j whileVetorB			# Volta para o la�o while
exitWhileVetorB:			# T�rmino da execu��o do while

li $s3,0        			# Reseta o valor do index
li $t3, 0 			# inicia o contador de igualdade em zero
somaIguais:
	beq $s3,$s2,exitSomaIguais 	# (branch if equal)	   Se $s3 < $t2 continua, sen�o pula para exitSomaIguais
	add $t1,$s3,$s3 		# $t1 = 2*i
	add $t1,$t1,$t1 		# $t1 = 4*i
	
	add $t6,$t1,$s4 		# $t6 = &A[i]
	add $t7,$t1,$s5 		# $t7 = &B[I]
	
	lw  $t4, 0($t6) 		# $t4 = Valor_A[i]
	lw  $t5, 0($t7) 		# $t5 = Valor_B[i]
		
	add $s3,$s3,$s1  		# Incrementa o contador
	bne $t4,$t5,somaIguais    	# (branch if not equal)	 Se $t4 for diferente de $t5, volta o loop, sen�o acrescenta um numero
	add $t3, $t3, $s1		# Incrementa o contador de iguais

	j somaIguais			# Volta o loop
exitSomaIguais:

ImprimeQuantidadeIgual:
	li $v0, 4       		# Informa que ir� imprimir uma string
	la $a0, quantidadeVetor    	# Mostra "Quantidade de elementos do vetor: " no console
	syscall				# Mostra a string no console
	
	li $v0, 1			# Informa que ir� imprimir um inteiro
	move $a0, $t2			# Move o tamanho do vetor para $a0
	syscall				# Mostra o inteiro no console
	
	li $v0, 4       		# Informa que ir� imprimir uma string
	la $a0, quantidadeIgual    	# Mostra "Quantidade de elementos iguais: " no console
	syscall				# Mostra a string no console
	
	li $v0, 1			# Informa que ir� imprimir um inteiro
	move $a0, $t3			# Move a quantidade de elementos iguais para $a0
	syscall				# Mostra o inteiro no console

exitImprimeQuantidadeIgual:
