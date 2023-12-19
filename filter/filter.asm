section .data
  file db "text.txt", 0 ; filename ends with '\0' byte

section .bss
  descriptor_read resb 4 ; memory for storing descriptor for reading
  descriptor_write resb 4 ; memory for storing descriptor for writing
  buffer resb 1024
  len equ 1024

section .text

global _start

_start:
  ; Open file for reading
  mov eax, 5 ; sys_open
  mov ebx, file ; filename
  mov ecx, 0 ; O_RDONLY
  int 0x80 ; open filename for read only

  mov [descriptor_read], eax ; storing the read descriptor

  ; Read from the file
  mov eax, 3 ; sys_read
  mov ebx, [descriptor_read] ; file descriptor for reading
  mov ecx, buffer ; read to buffer
  mov edx, len ; read len bytes
  int 0x80 ; read len bytes to buffer from file

  mov edx, eax ; storing count of read bytes to edx

  ; Convert characters to uppercase in the buffer
  xor ecx, ecx ; Clear ECX for the loop counter
convert_loop:
  cmp byte [buffer + ecx], 0 ; Check for end of string (null terminator)
  je end_convert_loop

  mov al, byte [buffer + ecx] ; Load a character into AL
  cmp al, 'a' ; Compare with lowercase 'a'
  jl skip_convert ; If less than 'a', skip conversion
  cmp al, 'z' ; Compare with lowercase 'z'
  jg skip_convert ; If greater than 'z', skip conversion

  sub byte [buffer + ecx], 32 ; Convert lowercase to uppercase by subtracting 32 (ASCII difference)

skip_convert:
  inc ecx ; Move to the next character
  jmp convert_loop ; Repeat the loop

end_convert_loop:

  ; Close the file after reading
  mov eax, 6 ; sys_close
  mov ebx, [descriptor_read] ; file descriptor for reading
  int 0x80 ; close the file after reading

  ; Reopen the file for writing
  mov eax, 5 ; sys_open
  mov ebx, file ; filename
  mov ecx, 1 ; O_WRONLY
  int 0x80 ; open filename for write only

  mov [descriptor_write], eax ; storing the write descriptor

  ; Write the modified content back to the file
  mov eax, 4 ; sys_write
  mov ebx, [descriptor_write] ; file descriptor for writing
  mov ecx, buffer ; from buffer
  int 0x80 ; write to the file with modified content

  ; Close the file after writing
  mov eax, 6 ; sys_close
  mov ebx, [descriptor_write] ; file descriptor for writing
  int 0x80 ; close the file after writing

  ; Exit the program
  mov eax, 1 ; sys_exit
  xor ebx, ebx ; exit status
  int 0x80 ; exit the program
