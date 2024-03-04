.text
main:
    addi a0 x0 110
    addi a1 x0 50
    jal mult
    
    mv a1 a0
    addi a0 x0 1
    ecall
    
    j exit

mult:
    # a0 = a, a1 = b
    addi sp sp -12 # Move stack pointer down by 12 bytes to store a, b, ra
    sw a0 8(sp) # Store a
    sw a1 4(sp) # Store b
    sw ra 0(sp) # Store ra
    addi t0 x0 1 # t0 = temporary 1
    bne a1 t0 return # if b != then jump to return
    addi sp sp 12
    jr ra # return a

return:
    # a + mult(a, b-1)
    addi a1 a1 -1 # b = b-1
    jal mult # call mult(a, b-1)
    lw t1 8(sp) # load a into t1
    lw ra 0(sp) # Load ra
    addi sp sp 12
    add a0 a0 t1 # a + mult(a, b-1)
    jr ra
    
exit:
    addi a0 x0 10
    ecall
    
