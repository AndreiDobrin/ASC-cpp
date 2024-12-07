.data
    v: .fill 1024, 4, 0
    formatPrintf: .asciz "%d\n"
    formatScanf: .asciz "%d"
    instructiuni_numar: .space 4
    nr2: .space 4
    nr_instr: .space 4
    i: .long 0 # v[i]
    debug: .asciz "debug:%d\n"

    nr_adduri: .space 4
    descriptor: .space 4
    dimensiune: .space 4
    ok: .long 0
    cacaPrintf: .asciz "%d: %d\n"
    i1: .space 4
    i2: .space 4
    spatiu_liber: .space 4
.text
.globl main

main:
    mov $v, %edi # adresa vectorului

    push $instructiuni_numar
    push $formatScanf
    call scanf
    pop %eax
    pop %eax

    /*push instructiuni_numar
    push $formatPrintf
    call printf
    pop %eax
    pop %eax*/


    call party

    /*
    push $2
    push $formatPrintf
    call printf
    pop %eax
    pop %eax
    */


    

    jmp exit

party:
    cmpl $0, instructiuni_numar
    je party_over

    /*
    push instructiuni_numar
    push $formatPrintf
    call printf
    pop %eax
    pop %eax
    */

    push $nr_instr
    push $formatScanf
    call scanf
    pop %eax
    pop %eax

    /*
    push nr_instr
    push $formatPrintf
    call printf
    pop %eax
    pop %eax
    */

    cmpl $1, nr_instr
    je add_instruction_prequel

    cmpl $10, nr_instr
    je pre_afisare


decrease: # --nr_instr
    subl $1, instructiuni_numar # instructiuni_numar--
    jmp party 

party_over:
    ret

add_instruction_prequel:
    push $nr_adduri
    push $formatScanf
    call scanf
    pop %eax
    pop %eax

    /*
    push nr_adduri
    push $formatPrintf
    call printf
    pop %eax
    pop %eax
    */

    jmp read_add_instruction

read_add_instruction:

    push $descriptor
    push $formatScanf
    call scanf
    pop %eax
    pop %eax

    push $dimensiune
    push $formatScanf
    call scanf
    pop %eax
    pop %eax

    mov $0, %edx 
    mov dimensiune, %eax # dimensiune efectiva
    mov $8, %ebp
    div %ebp

    /*
    push %eax
    push %edx
    push $formatPrintf
    call printf
    pop %ebp
    pop %ebp
    pop %eax
    */

    call dimensiune_efectiva

    jmp add_instruction

dimensiune_efectiva:
    

    cmp $0, %edx
    jg dimensiune_mai_mare
    je dimensiune_normala

dimensiune_normala:
    ret
dimensiune_mai_mare:
    inc %eax
    ret


add_instruction:
    cmpl $0, nr_adduri
    je decrease

    # %eax = dimensiune
    movl $0, ok
    movl $0, spatiu_liber
    mov $0, %ecx
    movl $0, i1
    movl $0, i2

    call ok_0

    /*
    push descriptor
    push $formatPrintf
    call printf
    pop %eax
    pop %eax

    push dimensiune
    push $formatPrintf
    call printf
    pop %eax
    pop %eax
    */
    push %ecx
    push %eax
    push $formatPrintf
    call printf
    pop %ebp
    pop %eax
    pop %ecx



    # catul in %eax, restul in %edx


    

    subl $1, nr_adduri
    jmp read_add_instruction

ok_0:
    cmpl $1, ok
    je return
    cmpl $1024, %ecx
    jge return

    call trecem_la_0


    mov %ecx, i2
    call vedem_daca_e_spatiu_liber

    push %ecx
    call oare_este_spatiu_liber
    pop %ecx


    ret

return:
    ret

trecem_la_0:

    
    movl (%edi,%ecx, 4), %ebx

    /*
    push %eax
    push %ecx
    push i2
    push $formatPrintf
    call printf
    pop %ebp
    pop %ebp
    pop %ecx
    pop %eax
    */

    cmpl $0, %ebx
    je return

    cmpl $1024, %ecx # aici s-ar putea sa dea seg fault!!!!!!!!!#################################################
    jge return

    /*
    push %eax
    push %ecx
    push %ebx
    push $formatPrintf
    call printf
    pop %ebp
    pop %ebx
    pop %ecx
    pop %eax
    */

    inc %ecx

    jmp trecem_la_0

pre_afisare:
    mov $0, %ecx
    push %eax
    push %ebx
    push %ecx
    push %edx
    jmp afisare

afisare:
    cmp $20, %ecx
    jge end_afisare

    push %ecx
    push (%edi, %ecx, 4)
    push $formatPrintf
    call formatPrintf
    pop %ebp
    pop (%edi, %ecx, 4)
    pop %ecx

    inc %ecx
    
    jmp afisare



end_afisare:
    pop %eax
    pop %ebx
    pop %ecx
    pop %edx
    jmp decrease

exit:
    mov $1, %eax
    xor %ebx, %ebx
    int $0x80


.section .note.GNU-stack,"",@progbits

