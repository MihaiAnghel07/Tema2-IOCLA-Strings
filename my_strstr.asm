%include "io.mac"

section .text
    global my_strstr
    extern printf

my_strstr:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edi, [ebp + 8]      ; substr_index
    mov     esi, [ebp + 12]     ; haystack          ;textul
    mov     ebx, [ebp + 16]     ; needle            ;cuvantul
    mov     ecx, [ebp + 20]     ; haystack_len
    mov     edx, [ebp + 24]     ; needle_len
    ;; DO NOT MODIFY

    ;; TO DO: Implement my_strstr


    xor eax, eax
    mov edi, -1
    push ecx
    jmp repeat

start:                  ;Incepe parcurgerea de la 0(a cuvantului cautat) 
    inc esi
    mov edi, -1
    dec ecx

repeat:                 ;Se parcurge textul pana cand se termina sau pana cand gasesc  
    inc edi             ;cuvantul in text. De fiecare data, parcurgerea textului reincepe 
    cmp edi, edx        ;de la esi + i (i este pasul la care s-a ajuns)
    je found
    cmp edi, ecx
    je final
    mov al, byte[esi + edi]
    cmp al, byte[ebx + edi]
    je repeat
    jmp start

found:                  ;Se ajunge aici daca s-a gasit cuvantul in text si returnez
    pop eax             ;indexul la care a fost gasit
    sub eax, ecx
    mov edi, [ebp + 8]
    mov [edi], eax
    jmp finish      

final:                  ;Daca nu a fost gasit cuvantul, parcurgerea se va face pana la 
    pop ecx             ;final, voi prelua lungimea initiala a textului si returnez
    inc ecx             ;lungime + 1
    mov edi, [ebp + 8]
    mov [edi], ecx

finish:                 ;se termina programul

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
