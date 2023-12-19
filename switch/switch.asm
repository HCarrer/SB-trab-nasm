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
    sunday db "Sunday", 0xA, 0   ; Define the string "Sunday" with a newline and null terminator
    monday db "Monday", 0xA, 0   ; Define the string "Sunday" with a newline and null terminator
    tuesday db "Tuesday", 0xA, 0   ; Define the string "Sunday" with a newline and null terminator
    wednesday db "Wednesday", 0xA, 0   ; Define the string "Sunday" with a newline and null terminator
    thursday db "Thursday", 0xA, 0   ; Define the string "Sunday" with a newline and null terminator
    friday db "Friday", 0xA, 0   ; Define the string "Sunday" with a newline and null terminator
    saturday db "Saturday", 0xA, 0   ; Define the string "Sunday" with a newline and null terminator
    newline db 0xA, 0   ; Newline character

global    _start
section   .text
_start:

    SWITCH 1                        ;switch 3
    CASE 1                         ;case 1
        mov eax, 4       ; sys_write system call
        mov ebx, 1       ; file descriptor 1 (stdout)
        mov ecx, sunday  ; address of the string to print
        mov edx, 7       ; length of the string without newline and null terminator
        BREAK                        
    CASE 2                         ;case 2
        mov eax, 4       ; sys_write system call
        mov ebx, 1       ; file descriptor 1 (stdout)
        mov ecx, monday  ; address of the string to print
        mov edx, 7       ; length of the string without newline and null terminator
        BREAK        
    CASE 3                         ;case 3
        mov eax, 4       ; sys_write system call
        mov ebx, 1       ; file descriptor 1 (stdout)
        mov ecx, tuesday  ; address of the string to print
        mov edx, 8       ; length of the string without newline and null terminator
        BREAK
    CASE 4                         ;case 3
        mov eax, 4       ; sys_write system call
        mov ebx, 1       ; file descriptor 1 (stdout)
        mov ecx, wednesday  ; address of the string to print
        mov edx, 10       ; length of the string without newline and null terminator
        BREAK
    CASE 5                         ;case 3
        mov eax, 4       ; sys_write system call
        mov ebx, 1       ; file descriptor 1 (stdout)
        mov ecx, thursday  ; address of the string to print
        mov edx, 9       ; length of the string without newline and null terminator
        BREAK
    CASE 6                         ;case 3
        mov eax, 4       ; sys_write system call
        mov ebx, 1       ; file descriptor 1 (stdout)
        mov ecx, friday  ; address of the string to print
        mov edx, 7       ; length of the string without newline and null terminator
        BREAK
    CASE 7                         ;case 3
        mov eax, 4       ; sys_write system call
        mov ebx, 1       ; file descriptor 1 (stdout)
        mov ecx, saturday  ; address of the string to print
        mov edx, 9       ; length of the string without newline and null terminator
        BREAK
    DEFAULT
        mov eax, 4       ; sys_write system call
        mov ebx, 1       ; file descriptor 1 (stdout)
        mov ecx, sunday  ; address of the string to print
        mov edx, 7       ; length of the string without newline and null terminator
    ENDSWITCH

    int 0x80         ; perform the system call





    mov eax, 1       ; sys_exit
    xor ebx, ebx     ; exit code 0
    int 0x80         ; perform the system call

