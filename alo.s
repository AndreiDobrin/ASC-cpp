.data
    v: .fill 400, 4, 0
    formatScanf: .asciz "%d\n"
    formatPrintf: .asciz "%d\n"
    id: .space 4
    dim: .space 4
    spatiu_liber: .space 4
    cacaPrintf: .asciz "hehe %d\n"
    ok: .long 0

.text
.globl main

jaybe_jaybe_not:
    cmpl $0, %edx
    jne ig_not
    
    jmp yessir

    ig_not:
        inc %eax
        ret
    yessir:
        ret

main:

    mov $v, %edi
    mov $0, %ecx



inserare_de_la_tastatura:

    cmpl $10, %ecx
    jge pre_afisare


    leal (%edi, %ecx, 4), %eax
    push %ecx
    push %eax
    push $formatScanf
    call scanf
    add $8, %esp
    pop %ecx

    inc %ecx
    jmp inserare_de_la_tastatura


    pre_afisare:
        mov $0, %ecx

        jmp afisare

            afisare:
                cmp $15, %ecx
                jge citire_ID_si_DIM

                leal (%edi, %ecx, 4), %eax
                mov (%eax), %eax
                push %ecx
                push %eax
                push $formatPrintf
                call printf
                add $4, %esp
                pop %eax
                pop %ecx

                inc %ecx
                jmp afisare


citire_ID_si_DIM:
    cmpl $0, ok
    jne exit


     # functional
    push $id
    push $formatScanf
    call scanf
    add $8, %esp

    

    # functional
    push $dim
    push $formatScanf
    call scanf
    add $8, %esp

    push %eax
    push %ecx
    push %ebp
    mov $0, %edx
    mov dim, %eax
    movl $8, %ebp
    divl %ebp
    pop %ebp

    call jaybe_jaybe_not
    movl %eax, dim
    
    pop %ecx
    pop %eax

    
    mov $0, %ecx
    leal (%edi, %ecx, 4), %eax
    mov (%eax), %eax

trecem_la_0:

    cmp $0, %eax
    je am_ajuns_la_0
    
    cmp $100, %ecx
    jge exit

    inc %ecx

    leal (%edi, %ecx, 4), %eax
    mov (%eax), %eax

    jmp trecem_la_0


    am_ajuns_la_0: # verificare spatiu liber

        push %eax
        push %ecx
        push $cacaPrintf
        call printf
        add $4, %esp
        pop %ecx
        pop %eax

        movl $0, %ebx #spatiu_liber
        movl %ecx, %edx # inceputul intervalului de 0-uri
        jmp oare_este_spatiu_liber

        oare_este_spatiu_liber:
            cmpl dim, %ebx
            jge este_spatiu_liber_woooo

            cmp $0, %eax
            jne nu_este_spatiu_liber

            cmp $100, %ecx
            jge nu_este_spatiu_liber


            inc %ebx

            inc %ecx

            leal (%edi, %ecx, 4), %eax
            mov (%eax), %eax

            jmp oare_este_spatiu_liber

            nu_este_spatiu_liber:

                movl $0, %ecx
                jmp exit

            este_spatiu_liber_woooo:
                cmpl $0, dim
                    je inserare_finalizata
                
                leal (%edi, %edx, 4), %eax
                movl id, %ebx
                movl %ebx, (%eax)
                subl $1, dim
                inc %edx

                jmp este_spatiu_liber_woooo

                inserare_finalizata:
                    movl $1, ok
                    jmp pre_afisare




/*
inserare_de_la_tastatura:

    cmpl $10, %ecx
    jge pre_afisare


    leal (%edi, %ecx, 4), %eax
    push %ecx
    push %eax
    push $formatScanf
    call scanf
    add $8, %esp
    pop %ecx

    inc %ecx
    jmp inserare_de_la_tastatura


    pre_afisare:
        mov $0, %ecx

        jmp afisare

            afisare:
                cmp $10, %ecx
                jge pre_inserare

                leal (%edi, %ecx, 4), %eax
                mov (%eax), %eax
                push %ecx
                push %eax
                push $formatPrintf
                call printf
                pop %edx
                pop %eax
                pop %ecx

                inc %ecx
                jmp afisare

                pre_inserare:
                    mov $0, %ecx
                    
                    jmp inserare

                    inserare:
                        cmp $10, %ecx
                        jge exit

                        movl $0, (%edi, %ecx, 4)
                        leal (%edi, %ecx, 4), %eax
                        push %ecx
                        mov (%eax), %eax
                        push %ecx
                        push %eax
                        push $formatPrintf
                        call printf
                        pop %edx
                        pop %eax
                        pop %ecx

                        inc %ecx
                        jmp inserare

*/






exit:

    mov $1, %eax
    xor %ebx, %ebx
    int $0x80


.section .note.GNU-stack,"",@progbits
