
.data
	prompt1: .asciiz "Digite o tamanho dos vetores (N): "
	prompt2: .asciiz "Digite os elementos do vetor A: "
	prompt3: .asciiz "Digite os elementos do vetor B: "
	prompt4: .asciiz "Média de A: "
	prompt5: .asciiz "Média de B: "
	newline: .asciiz "\n"
	Const:   .word 0

.text

	main:
		
		li $v0, 4			# Imprime o prompt1
    		la $a0, prompt1
    		syscall
    		
    		li $v0, 5			# Lê o tamanho do vetor digitado pelo usuário em float
    		syscall
    		move $t0, $v0      		# $t0 contém a quantidade de elementos dos vetores
    		mtc1 $t0, $f10
    		cvt.s.w $f10, $f10   		# $f10 contém a quantidade de elementos dos vetores em precisão simples
    				    		
    	
    		jal Vetor_A			# Lê o vetor A
    		jal Vetor_B			# Lê o vetor B
    		jal Media
	
		li $v0, 10                   	# Informa que o programa main acabou
		syscall
    		
    			
    	Vetor_A:
    		
    		move $t8, $ra
    		li $v0, 4			# Imprime o prompt2
    		la $a0, prompt2
    		syscall
    		li $t1, 0
    		l.s $f2, Const                  # Inicializando o somador A com 0
		
    	
    	
    		loop_A:
    		beq $t1, $t0, fim_loop_A	# Loop receber o vetor A
    			
    			li $v0, 4		# Quebrando linha
    			la $a0, newline
    			syscall
    	
    			li $v0, 6		# Ler o float
    			syscall
    			
    			mov.s $f1, $f0         # Float digitado está em $f1
    			jal SomaA
    			#add.s $f2, $f2, $f1    # Somando os elementos do vetor A       
    			
    			
    			add $t1, $t1, 1         # Incrementndo em 1 o contador
    			j loop_A
 
    		fim_loop_A:
    			jr $t8
    		
    		
    		
    		
    	Vetor_B:
    		move $t9, $ra
    		li $v0, 4			# Imprime o prompt3
    		la $a0, prompt3
    		syscall
    		li $t1, 0                       # Inicializa $t1 com 0
    		l.s $f4, Const	
    		
 		loop_B:
 		beq $t1, $t0, fim_loop_B        # loop para receber o vetor B
 		
 			li $v0, 4		# Quebrando linha
    			la $a0, newline
    			syscall
 			
 			li $v0, 6		# Ler o float
    			syscall
 			
 			mov.s $f3, $f0         # Float lido está em $f3
 			
 			jal SomaB
 			#add.s $f4, $f4, $f3    # Somando os elementos do vtor B
					
    			add $t1, $t1, 1         # Incrementndo em 4 o contador
    			
 			j loop_B
 			
 		fim_loop_B:
 			jr $t9
			
  	
  	
  	SomaA:
  	add.s $f2, $f2, $f1    # Somando os elementos do vetor A
  
  	jr $ra
  	
  	
  	SomaB:
  	add.s $f4, $f4, $f3    # Somando os elementos do vtor B
  	
  	jr $ra
  	
  	
    	Media:	
    	
    		div.s $f5, $f2, $f10    # Media A
    		div.s $f6, $f4, $f10    # Media B
    		
    		
    		
    		li $v0, 4		# Quebrando linha
    		la $a0, newline
    		syscall
    		
    		li $v0, 4
    		la $a0, prompt4
    		syscall
    					# Imprimindo A
    		li $v0, 2
    		mov.s $f12, $f5
    		syscall
    		
    	
    		li $v0, 4		# Quebrando linha
    		la $a0, newline
    		syscall
    		
    		li $v0, 4
    		la $a0, prompt5
    		syscall
    					# Imprimindo B
    		li $v0, 2
    		mov.s $f12, $f6
    		syscall
    	
    	
    		jr $ra