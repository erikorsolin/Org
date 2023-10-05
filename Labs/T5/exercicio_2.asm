.data

	Matriz: .word               		# alocando espaço para 256 valores de 4 bytes cada
	

.text

	la $t4, Matriz				# $t4 tem o endereço base da matriz
	move $t9, $t4     			# $t9 também tem o endereço base da matriz
	
	li $t0, 0				# controle laço linha
	li $t1, 16				# controle laço linha
	li $t2, 0				# controle laço coluna
	li $t3, 16				# controle laço coluna
	
	li $t5, 0				# contador para colocar os elementos de 0 até 255 na matriz
	li $t8, 4
	
	loop_linha:
	beq $t0, $t1, fim_loop_linha
	
		li $t2, 0
		loop_coluna:
		beq $t2, $t3, fim_loop_coluna
				
			sw $t5, ($t4)		# Gravando o valor na posição A[j][i]
			addi, $t5, $t5, 1
			addi $t4, $t4, 64
		
		addi $t2, $t2, 1
		j loop_coluna
		fim_loop_coluna:
		
		  
		move $t4, $t9 			# reiniciando o $t4 com o endereço base
		add $t4, $t4, $t8		# avançando para a próxima coluna
		addi $t8, $t8, 4
	
	addi $t0, $t0, 1
	j loop_linha
	fim_loop_linha:
	
