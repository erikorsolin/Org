.data


.text
main:

    # Lê o número do teclado	
    li   $v0, 5
    syscall
    move $a0, $v0      			

    # Chama a função fatorial						
    jal  fatorial

    # Move o resultado para $a0
    move $a0, $v0
    li   $v0, 1
    syscall

    # Encerra o programa
    li   $v0, 10
    syscall

fatorial:
    # Input: $a0 = n
    # Output: $v0 = n!

    # Se n <= 1, retorna 1
    blez $a0, return_one

    # Salva o valor de $ra e $a0 na pilha
    addi $sp, $sp, -8   # Reserva espaço na pilha
    sw   $ra, 4($sp)   # Salva $ra
    sw   $a0, 0($sp)   # Salva $a0

    # Chama fatorial(n-1)
    sub  $a0, $a0, 1
    jal  fatorial
    move $t0, $v0      # Guarda o resultado em $t0

    # Restaura o valor de $a0 da pilha
    lw   $a0, 0($sp)

    # Calcula n * fatorial(n-1)
    mul  $v0, $a0, $t0

    # Restaura $ra da pilha e retorna
    lw   $ra, 4($sp)
    addi $sp, $sp, 8   # Libera espaço na pilha
    jr   $ra

return_one:
    li   $v0, 1
    jr   $ra
