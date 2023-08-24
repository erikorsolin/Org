.data # área para dados na memória principal
	
	MSG: .asciiz "Hello, world!" # mensagem a ser exibida para o usuário
	
.text # área para instruções do programa
	
	li $v0, 4    # instrução para impressão de string
	la $a0, MSG    # indicar o endereço em que está a mensagem
	syscall # faça