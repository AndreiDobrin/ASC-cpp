.data
v: .fill 8192, 4, 0
formatPrintf: .asciz "%d\n"
formatScanf: .asciz "%d"
printare_interval: .asciz "%d: (%d, %d)\n"
nr_adduri: .space 4
id: .space 4
dim: .space 4
ok: .space 4
spatiu_liber: .space 4
i2: .space 4
i1: .space 4
pozitie_si_id_print: .asciz "v[%d]: %d\n"

.text
.global main


aflare_dimensiune_reala:
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

    push $nr_adduri
    push $formatScanf
    call scanf
    add $8, %esp

    loop_add:
        cmpl $0, nr_adduri
        jle exit
        
        subl $1, nr_adduri

        push $id # id_descriptor
        push $formatScanf
        call scanf
        add $8, %esp

        push $dim # dimensiune
        push $formatScanf
        call scanf
        add $8, %esp



        movl $0, %edx
        movl dim, %eax
        movl $8, %ecx
        divl %ecx
        call aflare_dimensiune_reala # dimensiune efectiva
        

        movl %eax, dim

        movl $0, ok
        movl $0, spatiu_liber
        movl $0, i1
        movl $0, i2
        movl $0, %ecx


        continuare:
/*
            cmpl $1, ok
            je inserare_reusita

            cmpl $1024, i2
            jge inserare_nereusita
*/

            mov $0, %eax
            mov $0, %ecx
            leal (%edi, %ecx, 4), %eax
            mov (%eax), %eax

            loop_gasire_zero:

                cmpl $0, %eax
                je exit_gasire_zero

                cmpl $1024, i2
                jge inserare_nereusita

                addl $1, i2 # incrementare
                movl i2, %ecx

                leal (%edi, %ecx, 4), %eax
                mov (%eax), %eax

                jmp loop_gasire_zero

                exit_gasire_zero:
                    movl %ecx, i1
                    movl dim, %edx
                

            loop_gasire_spatiu_liber:
                cmpl spatiu_liber, %edx
                jle am_gasit_spatiu_liber_uhuhuhuhu

                cmpl $1024, i2
                jge inserare_nereusita # !!!!!!!!!!

                cmp $0, %eax
                jne inserare_nereusita

                addl $1, i2
                movl i2, %ecx

                leal (%edi, %ecx, 4), %eax
                mov (%eax), %eax

                addl $1, spatiu_liber

                jmp loop_gasire_spatiu_liber

                am_gasit_spatiu_liber_uhuhuhuhu:
                    movl i1, %edx
                    movl $1, ok
                    inserare_hahahahahahahahah:
                        cmpl %edx, i2
                        jle inserare_reusita

                        movl id, %eax
                        movl %eax, (%edi, %edx, 4)

                        inc %edx

                        jmp inserare_hahahahahahahahah
                        
    inserare_reusita:
        subl $1, i2

        push i2
        push i1
        push id
        push $printare_interval
        call printf
        add $16, %esp

        jmp loop_add

    inserare_nereusita:
        push $0
        push $0
        push id
        push $printare_interval
        call printf
        add $16, %esp

        jmp loop_add 



exit:
/*
    pre_afisare:
        mov $0, %ecx

        jmp afisare

            afisare:
                cmp $1024, %ecx # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                jge exit1

                leal (%edi, %ecx, 4), %eax
                mov (%eax), %eax
                push %eax
                push %ecx
                push $pozitie_si_id_print
                call printf
                add $4, %esp
                pop %ecx
                pop %eax

                inc %ecx
                jmp afisare
*/

    
    mov $1, %eax
    xor %ebx, %ebx
    int $0x80

exit1:
    mov $1, %eax
    xor %ebx, %ebx
    int $0x80


.section .note.GNU-stack,"",@progbits



