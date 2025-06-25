.intel_syntax noprefix

.section .data

low_bytes:
    .2byte

high_bytes:
    .2byte


.section .text

.global main

main:
    # prologo
    push rbp
    mov rbp, rsp
    sub rsp, 80

    # parâmetros de entrada
    mov     DWORD PTR [rbp-20], edi
    mov     QWORD PTR [rbp-32], rsi
    mov     rax, 0
    mov     [rbp-80], rax

    # argv -> rax
    mov     rax, QWORD PTR [rbp-32]
    add     rax, 8
    mov     rax, QWORD PTR [rax]

    # "r" - leitura de arquivo
    mov     rdi, rax
    lea     rsi, [rip+ler_arquivo]
    call    fopen@plt
    mov     QWORD PTR [rbp-8], rax

    # argv -> rax
    mov     rax, QWORD PTR [rbp-32]
    add     rax, 16
    mov     rax, QWORD PTR [rax]

    # "w" - escrever arquivo
    mov     rdi, rax
    lea     rsi, [rip+escrever_arquivo]
    call    fopen@plt
    mov     r13, rax   
    
    # tamanho do vetor de cores (16)
    mov     rdi, [rbp - 8]
    lea     rsi, [rip + ler_num]
    lea     rdx, [rbp - 24]
    xor     eax, eax
    call    fscanf@plt
        
    mov     [rbp-48], rsi
    mov     eax, DWORD PTR [rbp-48]

    # malloc p/ armazenar vetor
    mov     eax, [rbp - 24]
    mov     r8, 2
    mul     r8
    mov     rdi, rax
    add     rdi, 1
    call    malloc@plt
    mov     [rip + armazenar_vetor], rax

    mov     eax, [rbp - 16]
    mov     edi, [rbp - 24]
    mov     esi, [rbp - 48]
    mov     esi, 0

ler_vetor:
    # tam vetor <= 0(i++)
    cmp     edi, esi
    je      ler_quant_imagens

    mov     [rbp - 24], edi
    mov     [rbp - 48], esi

    mov     rdi, [rbp - 8]
    lea     rsi, [rip + ler_hex]
    lea     rdx, [rbp - 60]
    lea     rcx, [rbp - 56]
    call    fscanf@plt

    mov rax, 0
    mov rax, [rbp-60]
    mov rcx, [rbp-48]
	mov rdx, [rip + armazenar_vetor]
    mov [rdx + rcx * 2], rax
    
    # mov esi, [rdx + rcx * 2]
    # lea rdi, [rip + ler_caract]
    # call    printf@plt

    # reestabelendo contadores    
    mov     edi, [rbp - 24]
    mov     esi, [rbp - 48]

    # i++
    add     esi, 1

    # continuar lendo o vetor
    jmp     ler_vetor

ler_quant_imagens:

    mov     rdi, [rbp - 8]
    lea     rsi, [rip + ler_num]
    lea     rdx, [rbp - 16]
    call    fscanf@plt

    mov     r12, [rbp-16]
    mov     rbx, 0
    mov     [rbp - 24], rbx

    lea rsi, [rip + print_num_img]
    call fprintf@plt

    # call    printf@plt

    # jmp prologo

ler_tam_matriz:

    mov     rbx, [rbp - 24]
    mov     r12, [rbp - 16]

    cmp     r12, rbx
    je      prologo

    mov     [rbp - 24], rbx
    mov     [rbp - 16], r12

    mov     rdi, [rbp - 8]
    lea     rsi, [rip + ler_num]
    lea     rdx, [rbp - 32]
    xor     eax, eax
    call    fscanf@plt 

    mov     [rbp-48], rsi
    mov     eax, DWORD PTR [rbp-48]

    mov     rdi, [rbp - 8]
    lea     rsi, [rip + ler_num]
    lea     rdx, [rbp - 64]
    xor     eax, eax
    call    fscanf@plt 

    mov     [rbp-48], rsi
    mov     eax, DWORD PTR [rbp-48]

    mov     r13, [rbp - 64]
    mov     r14, 0
    mov     r14, [rbp - 56]
    

    mov     edi, [rbp - 32]
    mov     esi, [rbp - 48]
    mov     esi, 0
    mov     [rbp - 40], esi

ler_linha:

    mov     edi, [rbp - 32]
    mov     esi, [rbp - 40]

    cmp     edi, esi
    je      prologo

    mov     [rbp - 32], edi
    mov     [rbp - 40], esi

    # lea rdi, [rip+ler_hex]
    # mov rsi, [rbp - 40]
    # call printf@plt 

    lea rdi, [rip + print_n]
    call printf

    mov     edi, [rbp - 32]
    mov     esi, [rbp - 40]

    add     esi, 1
    mov     [rbp - 40], esi

    mov     esi, 0
    mov     [rbp - 56], esi

ler_coluna:

    mov     edi, [rbp - 64]
    mov     esi, [rbp - 56]

    cmp     edi, esi
    je      ler_linha

    mov     [rbp - 64], edi
    mov     [rbp - 56], esi

    mov     rdi, [rbp - 8]
    lea     rsi, [rip + ler_hex]
    lea     rdx, [rbp - 72]
    call    fscanf@plt

    mov     r9, [rbp - 72]
    and     r9, 0xF0
    shr     r9, 4

    mov     r11, r9
 
    lea rdi, [rip+ler_num]
    mov rsi, r11

    mov rdx, [rip + armazenar_vetor]
    lea rdi, [rip + ler_caract]
    mov rsi, [rdx + 2 * r11]
    call printf

    mov     r9, [rbp - 72]
    and     r9, 0x0F
    shr     r9, 4

    mov     r11, r9
 
    lea rdi, [rip+ler_num]
    mov rsi, r11

    mov rdx, [rip + armazenar_vetor]
    lea rdi, [rip + ler_caract]
    mov rsi, [rdx + 2 * r11]
    call printf



    mov     edi, [rbp - 64]
    mov     esi, [rbp - 56]

    add     esi, 1
    mov     [rbp - 56], esi

    # jmp     prologo

    jmp     ler_coluna


prologo:
    mov rdi, 0
    mov rdi, [rbp-8]
    call fclose@plt
    mov rsp,rbp
    pop rbp
    ret




ler_arquivo: 
    .string "r"
escrever_arquivo:
    .string "w"
ler_num:
    .string "%d"
ler_hex:
    .string "%x "
ler_caract:
    .string "%c"
print_n:
    .string "\n"
print_num_img:
    .string "[%d]"

.section .bss
armazenar_vetor:
    .8byte
