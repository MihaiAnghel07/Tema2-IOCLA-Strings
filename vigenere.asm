%include "io.mac"

section .text
    global vigenere
    extern printf 

vigenere:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     ecx, [ebp + 16]     ; plaintext_len
    mov     edi, [ebp + 20]     ; key
    mov     ebx, [ebp + 24]     ; key_len
    ;; DO NOT MODIFY

    ;; TODO: Implement the Vigenere cipher
  
    xor eax, eax
start:              ;se face o prelungire 'artificiala' a cheii, in sensul ca 
    xor edx, edx    ;se reia parcurgerea de cate ori se termina cheia
    jmp while_cond

while_body:
    push ebx
    mov bl, byte[esi + eax]
    push eax
    mov al, byte[edi + edx]
    push ecx
    mov ecx, -1
    inc al

aflare_lungime_deplasare:       ;Se afla lungimea deplasarii pentru fiecare caracter
    inc ecx                     ;din text
    dec al
    cmp al, 'A'
    jne aflare_lungime_deplasare
    
incrementare:               ;se incrementeaza caracterele textului doar daca acestea
    cmp ecx, 0              ;sunt litere, altfel se pun direct in ciphertext fara
    je not_letter           ;a fi prelucrate
    cmp bl, 'a'
    jb A_case
    cmp bl, 'z'
    ja not_letter

    jmp regular_case

A_case:                     
    cmp bl, 'A'
    jb not_letter

Z_case:
    cmp bl, 'Z'
    ja not_letter

regular_case:           ;se face trecerea de la 'z' la 'a'
    cmp bl, 'Z'         ;si de la 'Z' la 'A'    
    je move_to_A
    cmp bl, 'z'
    je move_to_a
    dec ecx
    inc bl
    jmp incrementare

move_to_A:
    mov bl, 'A'
    dec ecx
    jmp incrementare

move_to_a:
    mov bl, 'a'
    dec ecx
    jmp incrementare

not_letter:         ;daca nu e litera, caracterul respectiv e pus direct in ciphertext
    pop ecx         ;fara a fi rotit
    pop eax
    mov byte[esi + eax], bl
    inc eax
    cmp bl, 'a'
    jb A_case2
    cmp bl, 'z'
    ja not_inc      ;daca apare un alt caracter decat litera, cheia nu se incrementeaza
    jmp inc_key     ;se sare la incrementarea cheii

A_case2:
    cmp bl, 'A'
    jb not_inc

Z_case2:
    cmp bl, 'Z'
    ja not_inc

inc_key:
    inc edx

not_inc:        ;in cazul in care se ajunge la sfarsitul cheii, se incepe de la 0   
    pop ebx     ;parcurgerea cheii, (prelungirea artificiala)
    cmp edx, ebx
    je start

while_cond:
    cmp eax, ecx
    jl while_body

    mov edx, [ebp + 8]
    xor eax, eax

make_edx:           ;se face transcrierea ciphertext in registrul cerut
    mov al,[esi]
    mov [edx], al
    inc esi
    inc edx
    loop make_edx


    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY