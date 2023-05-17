;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; File:
;;    xdecode.asm
;;
;; Version:
;;    0.6
;;
;; Description:
;;    XSystem Huffman Decoder.
;;
;; Author:
;;    Sadovnikov Vladimir
;;
;; Copyright(s):
;;    (C) SadKo (Sadovnikov And Company)
;;    (C) XSystem Kernel Team
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

org 100h

BLOCK_SIZE      =	8192              ; ������ �������
input_buffer    =	buffer+BLOCK_SIZE ; ����� ������ �����

use16                                 ; 16-������ ���

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ����� �����: ������ ���������� ���������� ���������
start:
; ������������� ���������� ��������
    mov    ax, cs
    mov    ds, ax
    mov    es, ax
    mov    ss, ax
    mov    sp, 0fffeh

; ��������� ���� ��� ������ (data.huf)
	mov	   ax, 3d02h
	xor	   cx, cx
	mov	   dx, in_name
	int	   21h
	jc	   not_open
	mov	   word [file_in], ax
    
; ������ � ��������� ���� ��� ������ (data.txt)
	mov	   ax, 3c00h
	xor	   cx, cx
	mov	   dx, out_name
	int	   21h
	jc	   not_created
	mov	   word [file_out], ax	

; ���������� ����
	call   decode_file
	
; ��������� ��������� ����
	mov	   ah, 3eh
	mov	   bx, word [file_out]
	int	   21h
	jmp    ok_exit

; ������� ��������� �� ������
not_created:
    mov	   ah, 09h
	mov	   dx, Message_out
	int    21h

; ��������� �������� ��� ������ ����
ok_exit:
	mov	   ah, 3eh
	mov	   bx, word [file_in]
	int	   21h
	ret

; ������: ���� �� ��� ������
not_open:
    mov	   ah, 09h
	mov	   dx, Message_in
	int	   21h
	ret
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; �������: ������������ ����
decode_file:
	pusha

decode_loop:
	cmp    dword [coded_file_size],0 ; ���������, ��� �� ����� ������������
	je	   end_decode_loop
	dec	   dword [coded_file_size]   ; ������� ������ - 1

	call   decode_byte_func          ; � ���������� ����

	jmp	   decode_loop               ; ���������, ���� ������� �� 0

; ���� ��������, ����� ���� ��������� �����������
end_decode_loop:
    ; ���������, �� ���� �� �������� �����
	mov	   cx, word [out_buf_bytes]
	test   cx, cx
	jz	   exit_decode_file
    ; ���� � ������ ���� ������, �� �� ���� �������� � ����
	call   put_to_file

exit_decode_file:
	popa
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; �������: �������� �� ������, �������� ���� � ��������� ��� �
;          �������� �����
decode_byte_func:
	pusha

    ; �������� � bx ����� ����� ������
	mov    bx, opcode00000000_0000

    ; � ���������� �� ������
decode_byte_looping:
    ; ���� �� �������� ����� ����� - �������
	cmp    word [bx+2], 0ffffh
	je     loop_out

    ; ��������� ���
	call   input_bit           ; ax = ��������� ���
	; � ������������ �� ��������������� �����
	shl    ax, 1
	add	   bx, ax
	mov	   bx, word [bx]
	
	; ������ ������
	jmp	   decode_byte_looping

loop_out:
    ; �� ����� ������ - �� �� ������ [bx]
	mov	   al, byte [bx]
	; �������� ������ � �����
	mov	   bx, word [out_buf_bytes]
	mov	   byte [buffer+bx],al
	inc    bx
	mov	   word [out_buf_bytes], bx
	; ���� �� �� �������� ����� ������, ������������ �������
	cmp	   bx, BLOCK_SIZE
	jb	   exit_decode_byte

    ; ��������� ����� � ����
	call   put_to_file
	mov	   word [out_buf_bytes], 0

exit_decode_byte:
	popa
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; �������: ������� ��� �� ����� � ������� ��� � �������� ax
input_bit:
	push   dx
	push   cx
	push   bx
	
	; �������, ��� �� ���� ����� ���� �������
	cmp    byte [in_count], 0
	jne	   input_get_bit
	
	; ���� ���� ����, �� ���� ������� ����� 
	call   read_byte

; �������� ��� �� �����
input_get_bit:
	xor    ax, ax
	mov    dl, byte [in_byte]
	mov    al, dl
	shr    dl, 1
	and    al, 1
	mov	   byte [in_byte], dl
	dec	   byte [in_count]

; ��������������� ���������� �������� � �������
	pop	   bx
	pop	   cx	
	pop	   dx
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; �������: ������� ���� �� ������ ����� � �������� ����� 
read_byte:
	pusha

    ; ������ ����� � ������ �����
	mov    bx, word [in_index]
	cmp	   bx, BLOCK_SIZE
	jb	   no_block_load

    ; ���� ����� ����� ������� �� ������� ������
    ; ������ ���� �������� BLOCK_SIZE �� �����
	mov	   bx, word [file_in]
	mov	   cx, BLOCK_SIZE
	mov	   dx, input_buffer
	mov	   ah, 3fh
	int	   21h
	; � �������� ������� ������ � ������
	xor	   bx, bx

no_block_load:
    ; ��������� ���� �� ������
	mov	   al, byte [input_buffer+bx]
	; ����������� ������� �� �������
	inc	   bx
	; � ��������� ������ � �����
	mov	   byte [in_byte], al
	mov	   byte [in_count], 8
	mov	   word [in_index], bx

	popa
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
; �������: ������ ����� � ���� 
put_to_file:
    pusha
    
    mov    ah, 40h
    mov    bx, word [file_out]
    mov    cx, word [out_buf_bytes]
    mov    dx, buffer
    int    21h
    
    popa
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ���������� ������, ���� ������� �������������
include "map.asm"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ��������������� ������
Message_in:
	db	"Can't open file data.huf$"
Message_out:
	db	"Can't create file data.txt$"
in_name:
	db	"data.huf",0
out_name:
	db	"data.txt",0
file_in:
	dw	0
file_out:
	dw	0

; ��������� ������ �� �����
in_byte:
	db	0
in_count:
	db	0
out_buf_bytes:
	dw	0
in_index:
    dw  0ffffh

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ������ ������
align 10h
; ��������� ������:
; - ����� ������
; - ����� �����
buffer:
