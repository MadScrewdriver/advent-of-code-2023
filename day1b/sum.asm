section .text use32

global _sum

_sum:
    push ebp           ; Save the base pointer
    mov ebp, esp       ; Set base pointer for the current stack frame

    xor eax, eax       ; Clear eax register
    xor ecx, ecx       ; Clear ecx register

    mov ecx, [ebp+8]   ; Move the length of the array into ecx
    mov eax, [ebp+12]  ; Move the pointer to the array into eax

    xor edx, edx       ; Clear edx register, which will store the sum
    xor ebx, ebx       ; Clear ebx register, which will be used as an index

    sum_loop:
        add edx, [eax+ebx] ; Add the value at the current index of the array to edx
        add ebx, 4         ; Increment the index by 4 (since it's an array of integers)
        loop sum_loop      ; Decrement ecx and repeat the loop if ecx is not zero

    jmp exit              ; Jump to the exit label

exit:
    xor eax, eax          ; Clear eax register
    mov eax, edx          ; Move the sum (stored in edx) into eax
    leave                 ; Restore the old base pointer
    ret                   ; Return, with the sum in eax
