%macro SWITCH 1                     ; switch com 1 argumento
    mov eax, %1                     ; move o valor a ser comparado para eax
    %push switch                    ; contexto switch
    %assign next 1                  ; setta o valor incial 1 em next
    jmp %$caso %+ next              ; salta para label local caso seja 1
%endmacro

%macro CASE 1                       ; case com 1 argumento
%ifctx switch                       ; se estiver dentro do contexto switch
    %$caso %+ next:                 ; label com caso atual
    %assign next next+1             ; setta next como o próximo case do switch
    mov ebx, %1                     ; move o valor a ser comparado para eax
    cmp eax, ebx                    ; compara o valor armazenado em switch ao argumento do case do switch
    jne %$caso %+ next              ; se for diferente pula para o próximo case
%endif
%endmacro

%macro DEFAULT 0                    ; default sem argumento
%ifctx switch                       ; se estiver dentro do contexto switch
    %$caso %+ next:                 ; setta como label final
%endif
%endmacro

%macro BREAK 0                      ; break sem argumento
    jmp %$endswitch                 ; pula para o endswitch local
%endmacro

%macro ENDSWITCH 0                  ; endswitch sem argumentos
    %ifctx switch                   ; se estiver dentro do contexto switch
    %$endswitch:                    ; label local endswitch
    %pop                            ; finaliza contexto switch
    %endif
%endmacro

section   .data
    domingo db "Domingo", 0xA, 0    ; define a string "Domingo" com uma linha e um terminador nulo (byte 0)
    segunda db "Segunda", 0xA, 0    ; define a string "Segunda" com uma linha e um terminador nulo (byte 0)
    terca db "Terca", 0xA, 0        ; define a string "Terca" com uma linha e um terminador nulo (byte 0)
    quarta db "Quarta", 0xA, 0      ; define a string "Quarta" com uma linha e um terminador nulo (byte 0)
    quinta db "Quinta", 0xA, 0      ; define a string "Quinta" com uma linha e um terminador nulo (byte 0)
    sexta db "Sexta", 0xA, 0        ; define a string "Sexta" com uma linha e um terminador nulo (byte 0)
    sabado db "Sabado", 0xA, 0      ; define a string "Sabado" com uma linha e um terminador nulo (byte 0)
    tamanho_semana dw 7             ; define "tamanho_semana" como uma word de valor 7


section   .text

global    _start

_start:
    mov eax, 32                      ; move o valor do numero de dias para eax
    mov ebx, [tamanho_semana]                      ; move o tamanho de uma semana para ebx

    div ebx                         ; divide ebx por eax, sendo que o eax recebe quociente e edx recebe o resto 

    SWITCH edx                      ; switch passando o valor do resto da divisao em edx
    CASE 1                          ; case 1
        mov eax, 4                  ; define eax como a chamada 'sys_write' do sistema
        mov ebx, 1                  ; descritor de arquivo 1 (stdout)
        mov ecx, domingo            ; move para ecx o endereco da string a ser printada
        mov edx, 8                  ; tamanho da string a ser printada sem newline e sem terminador nulo
        BREAK                        
    CASE 2                          ; case 2
        mov eax, 4                  ; define eax como a chamada 'sys_write' do sistema
        mov ebx, 1                  ; descritor de arquivo 1 (stdout)
        mov ecx, segunda            ; move para ecx o endereco da string a ser printada
        mov edx, 8                  ; tamanho da string a ser printada sem newline e sem terminador nulo
        BREAK        
    CASE 3                          ; case 3
        mov eax, 4                  ; define eax como a chamada 'sys_write' do sistema
        mov ebx, 1                  ; descritor de arquivo 1 (stdout)
        mov ecx, terca              ; move para ecx o endereco da string a ser printada
        mov edx, 6                  ; tamanho da string a ser printada sem newline e sem terminador nulo
        BREAK
    CASE 4                          ; case 4
        mov eax, 4                  ; define eax como a chamada 'sys_write' do sistema
        mov ebx, 1                  ; descritor de arquivo 1 (stdout)
        mov ecx, quarta             ; move para ecx o endereco da string a ser printada
        mov edx, 7                  ; tamanho da string a ser printada sem newline e sem terminador nulo
        BREAK
    CASE 5                          ; case 5
        mov eax, 4                  ; define eax como a chamada 'sys_write' do sistema
        mov ebx, 1                  ; descritor de arquivo 1 (stdout)
        mov ecx, quinta             ; move para ecx o endereco da string a ser printada
        mov edx, 7                  ; tamanho da string a ser printada sem newline e sem terminador nulo
        BREAK
    CASE 6                          ; case 6
        mov eax, 4                  ; define eax como a chamada 'sys_write' do sistema
        mov ebx, 1                  ; descritor de arquivo 1 (stdout)
        mov ecx, sexta              ; move para ecx o endereco da string a ser printada
        mov edx, 6                  ; tamanho da string a ser printada sem newline e sem terminador nulo
        BREAK
    CASE 7                          ; case 7
        mov eax, 4                  ; define eax como a chamada 'sys_write' do sistema
        mov ebx, 1                  ; descritor de arquivo 1 (stdout)
        mov ecx, sabado             ; move para ecx o endereco da string a ser printada
        mov edx, 7                  ; tamanho da string a ser printada sem newline e sem terminador nulo
        BREAK
    DEFAULT
        mov eax, 4                  ; define eax como a chamada 'sys_write' do sistema
        mov ebx, 1                  ; descritor de arquivo 1 (stdout)
        mov ecx, sabado             ; move para ecx o endereco da string a ser printada
        mov edx, 7                  ; tamanho da string a ser printada sem newline e sem terminador nulo
    ENDSWITCH

    int 0x80                        ; realiza a chamada no sistema (sys_write)

    mov eax, 1                      ; define eax como a chamada 'sys_exit' do sistema
    xor ebx, ebx                    ; status de saída (exit status)
    int 0x80                        ; realiza a chamada no sistema (sys_exit)



