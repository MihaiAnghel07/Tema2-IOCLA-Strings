%include "io.mac"

section .text
    global caesar
    extern printf
   

caesar:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY

    ;; TODO: Implement the caesar cipher


prelucrare:                     ;Se parcurge textul
    mov ebx, edi
    mov al, byte[esi + ecx - 1]
    cmp al, 'a'                ;Verific daca elementul este litera
    jb A_case
    cmp al, 'z'
    ja regular_case
    jmp while_cond
                    
A_case:
    cmp al, 'A'
    jb regular_case

Z_case:
    cmp al, 'Z'             ;Daca a mai mare decat 'Z', si mai mic decat 'a' inseamna
    ja regular_case         ;ca nu este o litera

while_body:                 ;Se roteste caracterul corespunzator
    cmp al, 'Z'
    je move_to_A            ;Daca ultima litera e 'Z', se face rotirea la 'A'
    cmp al, 'z'
    je move_to_a            ;Daca ultima litera e 'z', se face rotirea la 'a'
    inc al
    dec ebx

while_cond:
    cmp ebx, 0
    jg while_body

regular_case:
    mov byte[edx + ecx - 1], al     ;Se adauga caracterul, fara a-l prelucra
    loop prelucrare;
    
    jmp finish              ;Daca se termina prelucrarea, se termina programul

move_to_A:                       
    dec ebx
    mov al, 'A'
    jmp while_cond

move_to_a:
    dec ebx
    mov al, 'a'
    jmp while_cond

finish:

    popa
    leave
    ret
    ;; DO NOT MODIFY