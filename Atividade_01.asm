##########################
# Atividade 1            #
# Arielle Verri Lucca    #
# Rodrigo José Fagundes  #
##########################

.data
vetor_A: 	   .word 0, 0, 0, 0, 0, 0, 0, 0				# Cada vetor deve ser declarado com 8 elementos inicializados em 0.Eles devem ser claramente identificados 
vetor_B: 	   .word 0, 0, 0, 0, 0, 0, 0, 0				# com nomes como vetor_A e vetor_B			
tamanhoVetor:      .asciiz "Digite o tamanho máximo dos vetores: "	# Para leitura, deve ser apresentada uma mensagem solicitando a entrada desse valor, indicando o seu limite máximo
elementoInvalido:  .asciiz "Valor invalido"				# No caso de entrada inválida, o programa deve imprimir uma mensagem de advertência antes de solicitar
									# novamente a entrada
vetor_AChaves:     .asciiz "\n vetor_A["				# Usado para imprimir corretamente os valores dos vetores
vetor_BChaves:     .asciiz "\n vetor_B["
fechaChaves:       .asciiz "] = "
quantidadeVetor:   .asciiz "\n Quantidade de elementos do vetor: "
quantidadeIgual:     .asciiz "\n Quantidade de elementos iguais: "
###############################################

.text
li $s1,1 	# Define o tamanho mínimo como 1
li $s2,8	# Define o tamanho máximo como 8

###############################################
li $s3,0 	# Sera o meu index / i = 0 / $s3 = 0
li $s7,0	# soma
###############################################

lacoInput:				# O programa deve solicitar ao usuário a entrada de cada elemento do vetor, um a um
	li $v0, 4     			# Definição de impressão de string
	la $a0, tamanhoVetor  		# Solicita o tamanho do vetor e armazena em $a0
	syscall				# Mostra mensagem no terminal

	li $v0,5      			# Definição de leitura de inteiro
	syscall 			# Mostra mensagem no terminal
	
	add $t1, $zero, $v0 		# Armazena o valor no registrador $t1
	move $t2, $t1			# Move o tamanho do vetor para $t2
	
	blt $t1,1, valorEntradaInvalido # (branch if less than)    Se $t1 menor que 1 informa valor inválido
	bgt $t1,8, valorEntradaInvalido # (branch if greater than) Se $t1 maior que 8 informa valor inválico
	
	add $s2, $0, $t1        	# Salva o tamanho no registrador $s2
	j exitlacoInput             	# Fim do while
	
valorEntradaInvalido:
	li $v0,4  			# Definição de impressão de string
	la $a0, elementoInvalido 	# Mostra mensagem de valor inválido no terminal
	syscall
	
	j lacoInput 			# Retorna lacoInput
exitlacoInput:				# Término do lacoInput

	la $s4,vetor_A			# Armazena os valores de vetor_A em $s4
	la $s5,vetor_B			# Armazena os valores de vetor_B em $s5
	
	
# Função que faz a leitura dos valores do vetor_A
whileVetorA: 
	beq $s3,$s2,exitWhileVetorA 	# (branch if not equal)	   Se $s3 < $s2 continua, senão pula para exitWhileVetorA
	add $t1,$s3,$s3 		# $t1 = 2*i
	add $t1,$t1,$t1 		# $t1 = 4*i
	add $t1,$t1,$s4 		# $t1 = vetor_A[i]

	# Faz as solicitações de input para o usuário no console
	li $v0, 4       		# Informa que irá imprimir uma string
	la $a0, vetor_AChaves   	# A string será 'vetor_A['	
	syscall				# Mostra a string no console
	
	li $v0, 1       		# Informa que irá imprimir um inteiro
	add $a0, $s3,$0  		# Passa o $s3 como argumento de contagem a ser impresso no console
	syscall				# Mostra o inteiro no console
	
	li $v0, 4        		# Informa que irá imprimir uma string
	la $a0, fechaChaves     	# Mostra " = ] " no console	
	syscall				# Mostra a string no console
	
	# Armazea os inputs digitados pelo usuário no console
	li $v0,5         		# Informa que irá ler um inteiro
	syscall    			# Interage com o console

	sw $v0, 0($t1)   		# Armazena o inteiro digitado pelo usuário		
	add $s3,$s3,$s1  		# Incrementa o contador
	j whileVetorA			# Volta para o laço while
exitWhileVetorA:			# Término da execução do while

li $s3,0        			# Reseta o valor do index

# Ler o vetor_B ate terminarem os espacos indicados pelo usuario (tamanho seja preenchido)
whileVetorB: 
	beq $s3,$s2,exitWhileVetorB 	# (branch if not equal)	   Se $s3 < $s2 continua, senão pula para exitWhileVetorB
	add $t1,$s3,$s3 		# $t1 = 2*i
	add $t1,$t1,$t1 		# $t1 = 4*i
	add $t1,$t1,$s5 		# $t1 = vetor_B[i]
	
# Faz as solicitações de input para o usuário no console
	li $v0, 4       		# Informa que irá imprimir uma string
	la $a0, vetor_BChaves    	# A string será 'vetor_B['	
	syscall 			# Mostra a string no console
	
	li $v0, 1       		# Informa que irá imprimir um inteiro
	add $a0, $s3,$0  		# Passa o $s3 como argumento de contagem a ser impresso no console
	syscall				# Mostra o inteiro no console
	
	li $v0, 4       		# Informa que irá imprimir uma string
	la $a0, fechaChaves     	# Mostra " ] " no console	
	syscall				# Mostra a string no console

	# Armazea os inputs digitados pelo usuário no console
	li $v0,5         		# Informa que irá ler um inteiro
	syscall   			# Interage com o console
	
	sw $v0, 0($t1)   		# Armazena o inteiro digitado pelo usuário
	add $s3,$s3,$s1  		# Incrementa o contador
	j whileVetorB			# Volta para o laço while
exitWhileVetorB:			# Término da execução do while

li $s3,0        			# Reseta o valor do index
li $t3, 0 			# inicia o contador de igualdade em zero
somaIguais:
	beq $s3,$s2,exitSomaIguais 	# (branch if equal)	   Se $s3 < $t2 continua, senão pula para exitSomaIguais
	add $t1,$s3,$s3 		# $t1 = 2*i
	add $t1,$t1,$t1 		# $t1 = 4*i
	
	add $t6,$t1,$s4 		# $t6 = &A[i]
	add $t7,$t1,$s5 		# $t7 = &B[I]
	
	lw  $t4, 0($t6) 		# $t4 = Valor_A[i]
	lw  $t5, 0($t7) 		# $t5 = Valor_B[i]
		
	add $s3,$s3,$s1  		# Incrementa o contador
	bne $t4,$t5,somaIguais    	# (branch if not equal)	 Se $t4 for diferente de $t5, volta o loop, senão acrescenta um numero
	add $t3, $t3, $s1		# Incrementa o contador de iguais

	j somaIguais			# Volta o loop
exitSomaIguais:

ImprimeQuantidadeIgual:
	li $v0, 4       		# Informa que irá imprimir uma string
	la $a0, quantidadeVetor    	# Mostra "Quantidade de elementos do vetor: " no console
	syscall				# Mostra a string no console
	
	li $v0, 1			# Informa que irá imprimir um inteiro
	move $a0, $t2			# Move o tamanho do vetor para $a0
	syscall				# Mostra o inteiro no console
	
	li $v0, 4       		# Informa que irá imprimir uma string
	la $a0, quantidadeIgual    	# Mostra "Quantidade de elementos iguais: " no console
	syscall				# Mostra a string no console
	
	li $v0, 1			# Informa que irá imprimir um inteiro
	move $a0, $t3			# Move a quantidade de elementos iguais para $a0
	syscall				# Mostra o inteiro no console

exitImprimeQuantidadeIgual:
