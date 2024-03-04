.data
# int a[5] = {1, 2, 3, 4, 5};
# int b[5] = {6, 7, 8, 9, 10};
a: .word 1, 2, 3, 4, 5
b: .word 6, 7, 8, 9, 10
print_text: .asciiz "The dot product is: "

# int main() {
#     int i, sop = 0;
    
#     for (i = 0; i < 5; i++) {
#         sop += a[i] * b[i];
#     }
    
#     printf("The dot product is: %d\n", sop);
#     return 0;
# }

.text
main:
    add t0 zero zero # i = 0
    add s0 zero zero # sop = 0

loop:
    addi t2 zero 5
    bge t0 t2 print # if i >= 5 then exit loop
    slli t1 t0 2 # t1 = i*4
    
    la t3 a # &a[i]
    add t3 t3 t1 # get a[i] address
    lw t4 0(t3) # a[i]
    
    la t3 b # &b[i]
    add t3 t3 t1 # get b[i] address
    lw t5 0(t3) # b[i]
    
    mul t6 t4 t5 # a[i] * b[i]
    add s0 s0 t6 # sop += a[i] * b[i]
    addi t0 t0 1 # i++
    j loop 

print:
    # print text
    addi a0 zero 4
    la a1 print_text
    ecall

    # print sop
    addi a0 zero 1
    mv a1 s0
    ecall
    
    addi a0 zero 10
    ecall
    
