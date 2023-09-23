.data 
	
	X: .double 111                      # Parâmetro inicial em precisão dupla
	Resultado: .double                  # Resultado da raiz quadrada aproximada
	Estimativa: .double 1               # Estimativa inical em precisão dupla 
	Dois: .double 2                     # Declarando zero com precisão dupla para futura divisão por dois
	
			
	
.text 

	.main:
		l.d $f2, X                   # Parâmetro inicial armazenado no registrador $f2
		l.d $f4, Estimativa          # Estimativa armazenada no registrador $f4
		l.d $f10, Dois		     # Carregando $f10 com 2 para ser usado em futura divisão
				
		jal PROC_SQRT                # Chama a função
		s.d $f4, Resultado           # Grava o valor aproximado na memória
		li $v0, 10                   # Informa que o programa main acabou
		syscall
	
	
	
	
	PROC_SQRT:
		li $v0, 7                    # Carregando no registrador $v0 o código para ler double
		syscall 		     # Após a chamada de sistema, o valor lido, por padrão, estará armazenado em $f0, logo n está em $f0
		cvt.w.d $f0, $f0	     # Convertedo de double para inteiro o valor armazenado em $f0 (n) 	
		mfc1 $t1, $f0		     # Movendo n para o registrador $t1
		move $t0, $zero		     # Inicializando $t0 com zero	
		
		
		loop_calculo:
		beq $t0, $t1, fim_calculo
		
		 
			div.d $f6, $f2, $f4  # $f6 =  X / Estimativa
			add.d $f8, $f6, $f4  # $f8 = (X / Estimativa) + Estimativa
			div.d $f4, $f8, $f10 # $f4 = (X / Estimativa + Estimativa) / 2
			
			sqrt.d $f12, $f2     # Para comparação
			
		
		addi $t0, $t0, 1             # Incrementando 1 no acumulador do loop
		j loop_calculo		    
		fim_calculo:
			jr $ra               # volta para onde a função foi chamada
		
		