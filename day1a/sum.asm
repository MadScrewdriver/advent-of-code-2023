
section .text use32

global	_sum

_sum:
	push ebp
    mov ebp, esp

    xor eax, eax
    xor ecx, ecx

    mov ecx, [ebp+8]
    mov eax, [ebp+12]

    xor edx, edx
    xor ebx, ebx


    sum_loop:
        add edx, [eax+ebx]
        add ebx, 4
        loop sum_loop

    jmp exit

exit:
    xor eax, eax
    mov eax, edx
    leave
    ret