SECTION .data
    inputBuf db 0x83,0x6A,0x88,0xDE,0x9A,0xC3,0x54,0x9A
    inputLen equ $ - inputBuf

SECTION .bss
    outputBuf resb 80

SECTION .text
    global _start

_start:
    mov esi, inputBuf      ; source pointer
    mov edi, outputBuf     ; destination pointer
    mov ecx, inputLen      ; loop counter

.main_loop:
    ; load byte into eax (al holds byte)
    movzx eax, byte [esi]  

    ; Higher bit 
    mov bl, al
    ; mask out low bit, keep high bit
    and bl, 0xF0           
    shr bl, 4              

    cmp bl, 9
    jg .high_is_letter
    add bl, 0x30          
    jmp .store_high

.high_is_letter:
    add bl, 0x37 ;0x41 - 10 = 0x37

.store_high:
    mov [edi], bl
    inc edi

    ; Lower bit 
    ; mask out higher , keep lower
    and al, 0x0F           

    cmp al, 9
    jg .low_is_letter
    add al, 0x30           
    jmp .store_low
.low_is_letter:
    add al, 0x37
.store_low:
    mov [edi], al
    inc edi

    ;Add space if not last byte
    dec ecx
    inc esi
    cmp ecx, 0
    je .done
    mov byte [edi], ' '
    inc edi
    jmp .main_loop

.done:
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
