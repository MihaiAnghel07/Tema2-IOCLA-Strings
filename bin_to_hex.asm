%include "io.mac"

section .text
    global bin_to_hex
    extern printf

bin_to_hex:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; hexa_value
    mov     esi, [ebp + 12]     ; bin_sequence
    mov     ecx, [ebp + 16]     ; length
    ;; DO NOT MODIFY

    ;; TODO: Implement bin to hex

    xor eax, eax
    xor ebx, ebx
    mov edx, ecx
    mov edi, -1

prelucrare:             ;parcurg secventa de biti si formez nibbles
    dec ecx
    inc edi
    cmp edi, 4          ;daca se formeaza un nibble, merg sa ii calculez valoare in hexa
    je verif

continue:
    cmp edx, -10
    je continue2
    mov al, byte[esi + ecx]
    cmp al, '1'             ;daca bitul e 1, atunci trebuie sa fac o adunare
    je adunare
    cmp ecx, 0
    jg prelucrare

    jmp final

adunare:                ;in functie de pozitia bitului in nibble, adun 
    cmp edi, 0          ;valoarea corespunzatoare
    je adunare_1
    cmp edi, 1
    je adunare_2
    cmp edi, 2
    je adunare_4
    cmp edi, 3
    je adunare_8

adunare_1:
    inc ebx
    jmp prelucrare

adunare_2:
    add ebx, 2
    jmp prelucrare

adunare_4:
    add ebx, 4
    jmp prelucrare

adunare_8:
    add ebx, 8
    jmp prelucrare

verif:              ;in functie de valoarea nibble- ului, pun pe stiva caracterul 
    mov edi, 0      ;corespunzator
    cmp ebx, 0
    je case_0
    cmp ebx, 1
    je case_1
    cmp ebx, 2
    je case_2
    cmp ebx, 3
    je case_3
    cmp ebx, 4
    je case_4
    cmp ebx, 5
    je case_5
    cmp ebx, 6
    je case_6
    cmp ebx, 7
    je case_7
    cmp ebx, 8
    je case_8
    cmp ebx, 9
    je case_9
    cmp ebx, 10
    je case_10
    cmp ebx, 11
    je case_11
    cmp ebx, 12
    je case_12
    cmp ebx, 13
    je case_13
    cmp ebx, 14
    je case_14
    cmp ebx, 15
    je case_15

case_0:
    push '0'
    xor ebx, ebx
    jmp continue

case_1:
    push '1'
    xor ebx, ebx
    jmp continue

case_2:
    push '2'
    xor ebx, ebx
    jmp continue

case_3:
    push '3'
    xor ebx, ebx
    jmp continue

case_4:
    push '4'
    xor ebx, ebx
    jmp continue

case_5:
    push '5'
    xor ebx, ebx
    jmp continue

case_6:
    push '6'
    xor ebx, ebx
    jmp continue

case_7:
    push '7'
    xor ebx, ebx
    jmp continue

case_8:
    push '8'
    xor ebx, ebx
    jmp continue

case_9:
    push '9'
    xor ebx, ebx
    jmp continue

case_10:
    push 'A'
    xor ebx, ebx
    jmp continue

case_11:
    push 'B'
    xor ebx, ebx
    jmp continue

case_12:
    push 'C'
    xor ebx, ebx
    jmp continue

case_13:
    push 'D'
    xor ebx, ebx
    jmp continue

case_14:
    push 'E'
    xor ebx, ebx
    jmp continue

case_15:
    push 'F'
    xor ebx, ebx
    jmp continue

final:              ;verific daca exista un numar exact de nibbles
    mov eax, edx    ;daca nu, completez nibble -ul incomplet si ii pun 
    xor edx, edx    ;valoarea corespunzatoare pe stiva
    mov ecx, 4
    div ecx
    cmp edx, 0
    jg ultim_push
    jmp continue2

ultim_push:
    inc eax
    mov edx, -10    ;valoare random pentru a se opri parcurgerea dupa punerea
    jmp verif       ;pe stiva a ultimului nibble completat
   
continue2:
    mov ecx, eax
    xor edx, edx
    xor eax, eax
    xor ebx, ebx
    mov edx, [ebp + 8]

make_edx:           ;scot elementele din stiva si le pun in edx
    pop eax
    mov [edx], al
    inc edx  
    loop make_edx
    
    mov eax, `\n`
    mov [edx], eax
    
    

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY