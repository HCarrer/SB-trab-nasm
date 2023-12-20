section .data
  arquivo db "text.txt", 0                              ; arquivo termina com o byte '\0'

section .bss
  descitor_leitura resb 4                               ; memória pra guardar descritor de leitura (reserva 4 bytes na memoria pra descritor_escrita)
  descritor_escrita resb 4                              ; memória pra guardar descritor de escrita
  buffer resb 1024                                      ; reserva 1024 bytes de memória para o buffer (reb = reserve bytes)
  len equ 1024                                          ; define len como 1024 (equ = equates)

section .text

global _start

_start:
                                                        ; Abrindo arquivo pra leitura
  mov eax, 5                                            ; sys_open (eax = 5 representa sys_open em x86 linux 32bits)
  mov ebx, arquivo                                      ; ebx eh movido para o comeco do arquivo
  mov ecx, 0                                            ; O_RDONLY
  int 0x80                                              ; abre o arquivo com permissão de 'read only' (0 da linha acima)

  mov [descitor_leitura], eax                           ; salvando o descritor de leitura

                                                        ; Leitura do arquivo
  mov eax, 3                                            ; sys_read (eax = 3 representa sys_read em x86 linux 32bits)
  mov ebx, [descitor_leitura]                           ; descritor de leitura do arquivo
  mov ecx, buffer                                       ; leitura no buffer
  mov edx, len                                          ; lê 'len' bytes
  int 0x80                                              ; lê 'len' bytes para o buffer do arquivo

  mov edx, eax                                          ; salvando a contagem de bytes de leitura em edx

                                                        ; Conversão dos caracteres para maiúscula no buffer
  xor ecx, ecx                                          ; limpa ECX para o contador do loop

loop_conversao:
  cmp byte [buffer + ecx], 0                            ; verifica se chegou no fim da string com o terminador nulo (byte 0)
  je finalizar_loop_conversao                           ; pula pra finalizar_loop_conversao se for igual a zero a comparação acima

  mov al, byte [buffer + ecx]                           ; carrega o char no registrador AL
  cmp al, 'a'                                           ; compara com o char 'a'
  jl ignorar_conversao                                  ; se for menor que 'a' (97), não realiza conversão
  cmp al, 'z'                                           ; compara com o char 'z'
  jg ignorar_conversao                                  ; se for maior que 'z' (122), não realiza conversão

  sub byte [buffer + ecx], 32                           ; subtrai 32 do valor ascii do caracter (mesma coisa que transformar pra uppercase)

ignorar_conversao:
  inc ecx                                               ; move pro próximo caracter
  jmp loop_conversao                                    ; repete o loop

finalizar_loop_conversao:
                                                        ; Fechamento do arquivo depois de ler tudo
  mov eax, 6                                            ; define eax como a chamada 'sys_close' do sistema
  mov ebx, [descitor_leitura]                           ; descritor de escrita do arquivo
  int 0x80                                              ; Fechamento do arquivo depois de ler tudo

                                                        ; Reabre o arquivo para leitura
  mov eax, 5                                            ; define eax como a chamada 'sys_open' do sistema
  mov ebx, arquivo                                      ; nome do arquivo
  mov ecx, 1                                            ; O_WRONLY
  int 0x80                                              ; abre o arquivo com permissão de 'write only' (1 da linha acima)

  mov [descritor_escrita], eax                          ; salvando o descritor de escrita

                                                        ; Sobrescreve o arquivo com o novo conteúdo pós aplicação do filtro
  mov eax, 4                                            ; sys_write
  mov ebx, [descritor_escrita]                          ; descritor de escrita do arquivo
  mov ecx, buffer                                       ; leitura no buffer
  int 0x80                                              ; escreve no arquivo o conteúdo modificado

                                                        ; Fechamento do arquivo após escrita
  mov eax, 6                                            ; define eax como a chamada 'sys_close' do sistema
  mov ebx, [descritor_escrita]                          ; descritor de escrita do arquivo
  int 0x80                                              ; fechamento do arquivo após escrita

                                                        ; Saída do programa
  mov eax, 1                                            ; define eax como a chamada 'sys_exit' do sistema
  xor ebx, ebx                                          ; status de saída (exit status)
  int 0x80                                              ; realiza a chamada no sistema (sys_exit)
