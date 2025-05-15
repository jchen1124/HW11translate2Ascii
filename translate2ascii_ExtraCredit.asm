SECTION .data
    inputBuf db 0x83,0x6A,0x88,0xDE,0x9A,0xC3,0x54,0x9A
    inputLen equ $ - inputBuf 

SECTION .bss
  
    outputBuf resb 80

SECTION .text
    global _start


hex_to_ascii_char:
    cmp al, 9
    jg .is_letter
    add al, 0x30
    ret

.is_letter:
    add al, 0x37
    ret

_start:
    mov esi, inputBuf      ; source pointer
    mov edi, outputBuf     ; destination pointer
    mov ecx, inputLen      ; loop counter

.main_loop:
    movzx eax, byte [esi]

    ; ah is the higher 8 bits of ax
    mov ah, al

    ; Process Higher nibble (left bit)
    shr al, 4
    ; Call subroutine to convert the left bit in AL to ASCII 
    call hex_to_ascii_char
    ; put the result in the output buffer
    mov [edi], al
    inc edi

    ; Process Lower nibble (right bit)
    ; Restore the original byte (with both nibbles) from AH into AL
    mov al, ah
    and al, 0x0F
    ; Call subroutine to convert the right bit in AL to ASCII 
    call hex_to_ascii_char
    mov [edi], al
    inc edi

    inc esi
    dec ecx
    cmp ecx, 0
    je .done

    ; Add a space character to the output buffer
    mov byte [edi], ' '
    inc edi
    jmp .main_loop

.done:
    ; Add a newline character to the end of the output string
    mov byte [edi], 0xA
    inc edi

    mov edx, edi
    sub edx, outputBuf
    mov ecx, outputBuf
    mov ebx, 1
    mov eax, 4
    int 0x80

   
    mov eax, 1
    xor ebx, ebx
    int 0x80