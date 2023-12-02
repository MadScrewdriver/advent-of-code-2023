section .data use32
    save_first_number db 0
    save_second_number db 0

section .text use32

global _extract

_extract:
    push ebp
    mov ebp, esp

    ; Initialize registers
    xor eax, eax
    xor ecx, ecx

    ; Load arguments into registers
    mov ecx, [ebp+8]   ; Length of the array
    mov eax, [ebp+12]  ; Pointer to the array

    ; Initialize ebx for indexing and edx for temporary storage
    xor edx, edx
    xor ebx, ebx

    ; Reset saved numbers to 0
    mov [save_first_number], edx
    mov [save_second_number], edx

    extract_loop:
        ; Load the current character into dl
        xor edx, edx
        mov dl, [eax+ebx]

        ; Check if character is a digit
        cmp dl, '0'
        jl continue
        cmp dl, '9'
        jg continue

        ; If a digit is found, decide whether to save it as first or second number
        jle pass

        continue:
            ; Increment the index and continue the loop
            add ebx, 1
            loop extract_loop
            jmp return

        pass:
            ; Check if the first number is already saved
            mov dh, [save_first_number]
            cmp dh, 0
            je save_first
            jne save_second

            save_first:
                ; Save the digit as the first number
                sub dl, '0'
                mov [save_first_number], dl
                jmp continue

            save_second:
                ; Save the digit as the second number
                sub dl, '0'
                mov [save_second_number], dl
                jmp continue

    return:
        ; Prepare the result in edx
        xor edx, edx
        mov dl, [save_first_number]
        mov dh, [save_second_number]

        ; Multiply the first number by 10
        add dl, dl
        add dl, dl
        add dl, [save_first_number]
        add dl, dl

        ; Check if the second number exists and choose the next operation
        cmp dh, 0
        je double_first
        jne combine_both

        double_first:
            ; Double the first number if the second number doesn't exist
            add dl, [save_first_number]
            jmp exit

        combine_both:
            ; Add the second number to the doubled first number
            add dl, [save_second_number]
            jmp exit

    exit:
        ; Set the result in eax (return register) and clean up
        xor dh, dh
        mov eax, edx
        leave
        ret
