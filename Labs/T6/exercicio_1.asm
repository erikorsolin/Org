.data



.text
			 		
	li $v0, 5 		        # código syscall para ler inteiro
	syscall
	move $t0, $v0   		# valor de entrada está em $t0 				
	move $t1, $t0			# $t1 também contém o valor de entrada
	li $t2, 2       		# inicializando $t2 para controle do loop		        
    				
    	loop_fat:
        	ble $t0, $t2, fim_loop  # se for menor ou igual a 2, sai do loop
        	subi $t0, $t0, 1        # decrementa $t0 em 1 para a próxima multiplicação
        	mul $t1, $t1, $t0	# $t1 usado para o multiplicatório
        j loop_fat			
	
	fim_loop:
		li $v0, 1		# código syscall para imprimir inteiro
		move $a0, $t1
		syscall
