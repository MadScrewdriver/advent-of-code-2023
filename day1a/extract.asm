section .data use32
    save_first_number db 0
    save_second_number db 0


section .text use32

global	_extract

_extract:
	push ebp
    mov ebp, esp

    xor eax, eax
    xor ecx, ecx

    mov ecx, [ebp+8]
    mov eax, [ebp+12]

    xor edx, edx
    xor ebx, ebx

    mov [save_first_number], edx
    mov [save_second_number], edx


    extract_loop:
        xor edx, edx
        mov dl, [eax+ebx]

        cmp dl, '0'
        jl continue
        cmp dl, '9'
        jg continue
        jle pass

        continue:
            add ebx, 1
            loop extract_loop
            jmp return

        pass:
            mov dh, [save_first_number]
            cmp dh, 0
            je save_first
            jne save_second

            save_first:
                sub dl, '0'
                mov [save_first_number], dl
                jmp continue

            save_second:
                sub dl, '0'
                mov [save_second_number], dl
                jmp continue

return:
    xor edx, edx
    mov dl, [save_first_number]
    mov dh, [save_second_number]

    add dl, dl
    add dl, dl
    add dl, [save_first_number]
    add dl, dl

    cmp dh, 0
    je double_first
    jne combine_both

    double_first:
        add dl, [save_first_number]
        jmp exit
    combine_both:
        add dl, [save_second_number]
        jmp exit

exit:
    xor dh, dh
    mov eax, edx
    leave
    ret