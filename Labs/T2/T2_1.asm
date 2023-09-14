.data
	.align 3
	A: .word 1 2 3 0 1 4 0 0 1
	.align 3
	B: .word 1 -2 5 0 1 -4 0 0 1
	.align 3
	C: .word 0 0 0 0 0 0 0 0 0

.text

	la $s0, A  # carregado o endereço base da matriz A
	la $s1, B  # carregado o endereço base da matriz B
	la $s2, C

	# troca de 1,2 para 2,1
	lw $t2, 4($s1) #  carregado no registrador t2 o valor 1,2 da matriz B
	lw $t3, 12($s1)
	sw $t3, 4($s1)
	sw $t2, 12($s1)

	# troca de 1,3 para 3,1
	lw $t2, 8($s1)
	lw $t3, 24($s1)
	sw $t3, 8($s1)
	sw $t2, 24($s1)

	# troca de 2,3 para 3,2
	lw $t2, 20($s1)
	lw $t3, 28($s1)
	sw $t3, 20($s1)
	sw $t2, 28($s1)

	#################################################
	# Multiplicações #
	# #
	#################################################

	#mult para o 1,1
	lw $t0, 0($s0)
	lw $t1, 0($s1)
	mult $t0, $t1
	mflo $t2
	sw $t2, 0($s3)

	#mult para o 1,2
	lw $t0, 4($s0)
	lw $t1, 4($s1)
	mult $t0, $t1
	mflo $t2
	sw $t2, 4($s3)

	#mult para o 1,3
	lw $t0, 8($s0)
	lw $t1, 8($s1)
	mult $t0, $t1
	mflo $t2
	sw $t2, 8($s3)

	#mult para o 2,1
	lw $t0, 12($s0)
	lw $t1, 12($s1)
	mult $t0, $t1
	mflo $t2
	sw $t2, 12($s3)

	#mult para o 2,2
	lw $t0, 16($s0)
	lw $t1, 16($s1)
	mult $t0, $t1
	mflo $t2
	sw $t2, 16($s3)

	#mult para o 2,3
	lw $t0, 20($s0)
	lw $t1, 20($s1)
	mult $t0, $t1
	mflo $t2
	sw $t2, 20($s3)

	#mult para o 3,1
	lw $t0, 24($s0)
	lw $t1, 24($s1)
	mult $t0, $t1
	mflo $t2
	sw $t2, 24($s3)

	#mult para o 3,2
	lw $t0, 28($s0)
	lw $t1, 28($s1)
	mult $t0, $t1
	mflo $t2
	sw $t2, 28($s3)

	#mult para o 3,3
	lw $t0, 32($s0)
	lw $t1, 32($s1)
	mult $t0, $t1
	mflo $t2
	sw $t2, 32($s3)


 	li $v0, 1
 	lw $a0, 0($s3)
 	syscall