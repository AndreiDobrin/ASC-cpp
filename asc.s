.data
    filename: .asciz "cplm.txt"
    buffer:   .space 1024
    newline:  .asciz "\n"
    formatScanf: .asciz "%d\n"
    endl: .asciz "\n"
    addPrintf: .asciz "%d\n"
    delPrintf: .asciz "%d\n"
    showPrintf: .asciz "v[%d][%d]\n"
    v: .fill 1024, 4, 0
    x: .space 4
    instructiune: .space 1

    addNumar_instructiuni: .space 1
    ID_descriptor: .space 1
    DIM_descriptor: .space 2

.text
.globl main

main:
    mov $0, %ecx # coloane
    mov $0, %ebx # linii
    mov $v, %edi # adresa vectorului in memorie

    push instructiune
    push $formatScanf
    call scanf
    pop %eax
    pop %eax

    mov $0, %ecx

    cmpl $1, instructiune
    je add_instruction

    jmp et_loop

/* row_change:
    inc %ebx
    cmp $1024, %ebx
    je exit

    mov $0, %ecx

    push %ecx
    push %ebx
    push $endl
    call printf
    add $4, %esp
    pop %ebx
    pop %ecx
    
    jmp et_loop
*/

et_loop:
    cmp $1024, %ecx
    jge exit
    # jge row_change
    

    movl (%edi, %ecx, 4), %eax
    mov %eax, x # valoarea v[i][j]
    # push %ecx
    # push %ebx
    # push $showPrintf
    # call printf
    # add $4, %esp
    # pop %ebx
    # pop %ecx

    inc %ecx

    jmp et_loop

add_instruction:
    push addNumar_instructiuni
    push $formatScanf
    call scanf
    pop %eax
    pop %eax

    jmp add_loop

add_loop:
    cmpl $0, addNumar_instructiuni
    jle main

    push ID_descriptor # citeste ID_descr
    push $formatScanf
    call scanf
    pop %eax
    pop %eax

    push DIM_descriptor # citeste DIM_descr
    push $formatScanf
    call scanf
    pop %eax
    pop %eax

    mov $0, %ebx # k = 0
    mov DIM_descriptor, %eax
    divl 8
    cmp $0, %edx # if(dim%8==0);
    je yessir

    subl $1,addNumar_instructiuni # nr_instr --

    jmp insert_loop # enter while1
yessir:
    mov $1, %ebx # k = 1
    jmp insert_loop # enter while1

insert_loop:
    cmp %ebx, %eax # while(%ebx <= dim/8)
    jle add_loop # la sf go inapoi la add_loop
    
    movl ID_descriptor, %cs
    mov %cs, (%edi, %ecx, 4)
    

exit:
    # Exit program
    movl $1, %eax          # System call number for exit
    xorl %ebx, %ebx        # Exit status 0
    int $0x80

.section .note.GNU-stack,"",@progbits

/*
vedem_daca_e_spatiu_liber:
    cmpl $0, (%edi,%ecx,4)
    jne return

    cmpl spatiu_liber, %eax
    jl return

    cmpl $1024, %ecx
    jge return

    inc %ecx
    addl $1, spatiu_liber

    
    push %eax
    push %ebx
    push %ecx
    push %edx
    push spatiu_liber
    push formatPrintf
    call printf
    pop %ebp
    pop spatiu_liber
    pop %edx
    pop %ecx
    pop %ebx
    pop %eax
    
    jmp vedem_daca_e_spatiu_liber

oare_este_spatiu_liber:
    cmp spatiu_liber, %eax
    jl este_spatiu_liber
    jge return

este_spatiu_liber:
    cmp i2, %ecx
    jle return

    push %eax
    movl descriptor, %eax

    movl %eax, (%edi, %ecx, 4)
    pop %eax
    dec %ecx

    jmp este_spatiu_liber
*/