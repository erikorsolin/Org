.data	
	.align 3
	X:         .double  5	                # Parâmetro que será calculado o seno
	
	.align 3
	Resultado: .double  	 	        # Resultado na memória de dados
	
	.align 3
	Const:     .double 1


	.align 3
	Termos:     .double 20
	
	.align 3
	Zero:    .double 0
	
	.align 3
	Const2:    .double 2
	
	.align 3
	Negativo:  .double -1
	


.text

	.main:
		l.d $f2, Const                # Inicializando $f2 globalmente com a constante 1 
		jal Calcula_Seno                # Chamando a função que calcula o seno
		li $v0, 10		        # Informa que o programa main acabou
		syscall
		
		
		
	Fatorial:				# Quando o proc for chamado, o valor de K deverá estar em $f4 e o resultado K! sairá em $f6
					
    		ldc1 $f6, Const		        # Inicializa $f6 com 1.0 (precisão dupla)
    		mov.d $f8, $f4			# Agora o valor 2n+1 está armazenado em $f8 (isso foi feito para não alterar o conteúdo de $f4, que será usado em outro procedimento

    		loop_fat:
        		c.le.d $f8, $f2         # Verifica se $f8 <= 1
        		bc1t end_loop           # Se verdadeiro, sair do loop
        		
        		mul.d $f6, $f6, $f8     # Multiplica $f6 pelo valor de $f8
        		sub.d $f8, $f8, $f2     # Decrementa $f8 por 1
        	j loop_fat			# O resultado K! vai sair no registrador $f6

    		end_loop:
        	jr $ra
		
		
		
		
		
	Potencia:
		l.d $f0, X            		 # Carregando o valor de parâmetro no registrador $f0
		mov.d $f10, $f4                  # Agora o valor 2n+1 está armazenado em $f8 (isso foi feito para não alterar o conteúdo de $f4, que será usado em outro procedimento
			
		loop_potencia:
			c.le.d $f10, $f2         # Faz o loop 2n+1 vezes para calcular a potencia
			bc1t  end_loopp		 # Se verdadeiro, sair do loop
				
			mul.d $f0, $f0, $f0      # faz x = x*x
			
			sub.d $f10, $f10, $f2    # Decrementa $f10 por 1
		j loop_potencia			 # Resultdo está em $f0
			
		end_loopp:
		jr $ra
			
				
		
		
		
		Sinal:
		l.d $f16, Const2    # $f16 tem 2
		l.d $f24, Zero      # contém zero
		l.d $f26, Negativo  # por default, o sinal é negativo
		
		div.d $f18, $f14, $f16    # n / 2
		mul.d $f20, $f18, $f16    # multiplicando o resultado da divisão por 2
		sub.d $f22, $f20, $f14    # subtraindo o resultado da multiplicação de n (se for igual a zero, é par)
		
		c.eq.d $f22, $f24
		bc1t positivo
		positivo:
		mul.d $f26, $f26, $f26    # -1*-1 = 1 Resultado armazenado em $f26
		jr $ra
		
		
		
		
		
		
	# Código para calcular  ( (-1)**n / (2n+1)! ) *  X**2n + 1	
	Calcula_Seno:
		l.d $f12, Termos	       	# $f12 contém a quantidade de termos a serem calculados
		l.d  $f14, Zero               			# $f14 será usado para controle do loop
			move $t9, $ra
	              loop_calculo:
	              	   	c.eq.d $f14, $f12  		# faz o loop $f12 vezes (quantidade de termos), n está armazenado em $f14
	              	   	bc1t end_looppp   		# Se verdadeiro, sair do loop
	              	   	
	        		add.d $f28, $f14, $f14       	# $f28 contém 2n
	        		add.d $f28, $f28, $f2       	# agora $f28 contém 2n+1
	        		
	        		mov.d $f4, $f28             	# movendo 2n+1 para $f4 para ser usado nas funções 
	        		
	        		jal Fatorial               	# (2n+1)! está em $f6     	   	
	              	   	
	              	   	jal Potencia               	# X**(2n+1) está em $f0
	              	   	 
	              	   	jal Sinal			# (-1)**n está em $f26
	              	   	
	              	   	div.d $f28, $f26, $f6   	# (-1)**n / (2n+1)! está em $f28
	              	   	
	              	   	mul.d $f28, $f28, $f0   	# ( (-1)**n / (2n+1)! ) *  X**2n+1    está em $f28
	     
	          		add.d $f30, $f30, $f28          # Somatório dos termos está em $f30
	          	   		   	
	              	   	add.d $f14, $f14, $f2 		# Incrementa $f14 em 1
	         	j loop_calculo
	         	
	         	end_looppp:
	         	    jr $t9
	         		
	     