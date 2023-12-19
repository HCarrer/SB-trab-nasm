; ----------------------------------------------------------------------------------------
; Writes "Hello, World" to the console using only system calls. Runs on 64-bit Linux only.
; To assemble and run:
;
;     nasm -felf64 hello.asm && ld hello.o && ./a.out
; ----------------------------------------------------------------------------------------

V1    EQU 1                         ;constante 1
V2    EQU 2                         ;constante 2
V3    EQU 3                         ;constante 3
V4    EQU 4                         ;constante 4

%macro SWITCH 1                     ;switch com 1 argumento
    mov rax, %1                     ;valor a ser comparado em rax
    %push switch                    ;contexto switch
    %assign next 1                  ;valor 1 (inicial) em next
    jmp %$caso %+ next              ;jump para label local caso1
%endmacro

%macro CASE 1                       ;case com 1 argumento
%ifctx switch                       ;se no contexto swich
    %$caso %+ next:                 ;label com caso atual
    %assign next next+1             ;next próximo case
    mov rbx, %1                     ;case a ser comparado
    cmp rax, rbx                    ;compara o valor (que foi armazenado em switch) com argumento do case
    jne %$caso %+ next               ;se não for igual, próximo case
%endif
%endmacro

%macro DEFAULT 0                    ;default sem argumento
%ifctx switch                       ;se no contexto switch
    %$caso %+ next:                 ;label final
%endif
%endmacro

%macro BREAK 0                      ;break sem argumento
    jmp %$endswitch                 ;pula para endswitch local
%endmacro

%macro ENDSWITCH 0                  ;endswitch sem argumentos
    %ifctx switch                   ;se no contexto switch
    %$endswitch:                    ;label local endswitch
    %pop                            ;finaliza contexto switch
    %endif
%endmacro

section   .data
valor:   db  2   ;valor_variable 
digit:  db 0,10

global    _start
section   .text
_start:
    mov rdx, 1                      ;valor inicial a ser somado

    SWITCH 200                        ;switch 3
    CASE V1                         ;case 1
        add rdx, V1                 ;soma V1 a 1
        BREAK                        
    CASE V2                         ;case 2
        add rdx, V2                 ;soma V2 a 1
        BREAK        
    CASE V3                         ;case 3
        add rdx, V3                 ;soma V3 a 1
        BREAK
    DEFAULT
        add rdx, V4                 ;soma V4 a 1
    ENDSWITCH

    mov rax, rdx                      
    add rax, 48
    mov [digit], al
    mov rax, 1
    mov rdi, 1
    mov rsi, digit
    mov rdx, 2
    syscall

    mov rax, 60                     ; syscall exit
    mov rdi, 0                      ; exit 0 
    syscall