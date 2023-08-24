 .data
 	CARACTERE: .byte "E"
 	
 .text
 	li $v0, 4 # instrução para imprimir caracteres 
 	la $a0, CARACTERE # indica o endereço de CARACTERE
 	syscall
 	