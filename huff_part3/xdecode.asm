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

BLOCK_SIZE      =	8192              ; Размер буферов
input_buffer    =	buffer+BLOCK_SIZE ; Адрес буфера ввода

use16                                 ; 16-битный код

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Точка входа: отсюда начинается выполнение программы
start:
; Устанавливаем сегментные регистры
    mov    ax, cs
    mov    ds, ax
    mov    es, ax
    mov    ss, ax
    mov    sp, 0fffeh

; Открываем файл для чтения (data.huf)
	mov	   ax, 3d02h
	xor	   cx, cx
	mov	   dx, in_name
	int	   21h
	jc	   not_open
	mov	   word [file_in], ax
    
; Создаём и открываем файл для записи (data.txt)
	mov	   ax, 3c00h
	xor	   cx, cx
	mov	   dx, out_name
	int	   21h
	jc	   not_created
	mov	   word [file_out], ax	

; Декодируем файл
	call   decode_file
	
; Закрываем созданный файл
	mov	   ah, 3eh
	mov	   bx, word [file_out]
	int	   21h
	jmp    ok_exit

; Выводим сообщение об ошибке
not_created:
    mov	   ah, 09h
	mov	   dx, Message_out
	int    21h

; Закрываем открытый для чтения файл
ok_exit:
	mov	   ah, 3eh
	mov	   bx, word [file_in]
	int	   21h
	ret

; Ошибка: файл не был открыт
not_open:
    mov	   ah, 09h
	mov	   dx, Message_in
	int	   21h
	ret
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Функция: декодировать файл
decode_file:
	pusha

decode_loop:
	cmp    dword [coded_file_size],0 ; Проверяем, все ли байты декодированы
	je	   end_decode_loop
	dec	   dword [coded_file_size]   ; Счётчик байтов - 1

	call   decode_byte_func          ; И декодируем байт

	jmp	   decode_loop               ; Повторяем, пока счётчик не 0

; сюда приходим, когда файл полностью декодирован
end_decode_loop:
    ; проверяем, не пуст ли выходной буфер
	mov	   cx, word [out_buf_bytes]
	test   cx, cx
	jz	   exit_decode_file
    ; Если в буфере есть данные, то их надо записать в файл
	call   put_to_file

exit_decode_file:
	popa
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Функция: пройтись по дереву, получить байт и поместить его в
;          выходной буфер
decode_byte_func:
	pusha

    ; Помещаем в bx адрес корня дерева
	mov    bx, opcode00000000_0000

    ; И спускаемся по дереву
decode_byte_looping:
    ; Если мы достигли конца ветки - выходим
	cmp    word [bx+2], 0ffffh
	je     loop_out

    ; Считываем бит
	call   input_bit           ; ax = считанный бит
	; И направляемся по соответствующей ветке
	shl    ax, 1
	add	   bx, ax
	mov	   bx, word [bx]
	
	; Шагаем дальше
	jmp	   decode_byte_looping

loop_out:
    ; Мы нашли символ - он по адресу [bx]
	mov	   al, byte [bx]
	; Помещаем символ в буфер
	mov	   bx, word [out_buf_bytes]
	mov	   byte [buffer+bx],al
	inc    bx
	mov	   word [out_buf_bytes], bx
	; Если мы не достигли конца буфера, осуществляем переход
	cmp	   bx, BLOCK_SIZE
	jb	   exit_decode_byte

    ; Скидываем буфер в файл
	call   put_to_file
	mov	   word [out_buf_bytes], 0

exit_decode_byte:
	popa
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Функция: считать бит из файла и вернуть его в регистре ax
input_bit:
	push   dx
	push   cx
	push   bx
	
	; смотрим, все ли биты байта были считаны
	cmp    byte [in_count], 0
	jne	   input_get_bit
	
	; если байт пуст, то надо считать новый 
	call   read_byte

; Получаем бит из байта
input_get_bit:
	xor    ax, ax
	mov    dl, byte [in_byte]
	mov    al, dl
	shr    dl, 1
	and    al, 1
	mov	   byte [in_byte], dl
	dec	   byte [in_count]

; Восстанавливаем сохранённые регистры и выходим
	pop	   bx
	pop	   cx	
	pop	   dx
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Функция: считать байт из буфера ввода в байтовый буфер 
read_byte:
	pusha

    ; Индекс байта в буфере ввода
	mov    bx, word [in_index]
	cmp	   bx, BLOCK_SIZE
	jb	   no_block_load

    ; Если номер байта выходит за границы буфера
    ; Читаем блок размером BLOCK_SIZE из файла
	mov	   bx, word [file_in]
	mov	   cx, BLOCK_SIZE
	mov	   dx, input_buffer
	mov	   ah, 3fh
	int	   21h
	; И обнуляем счётчик байтов в буфере
	xor	   bx, bx

no_block_load:
    ; Извлекаем байт из буфера
	mov	   al, byte [input_buffer+bx]
	; Увеличиваем счётчик на единицу
	inc	   bx
	; И заполняем данные о байте
	mov	   byte [in_byte], al
	mov	   byte [in_count], 8
	mov	   word [in_index], bx

	popa
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
; Функция: запись блока в файл 
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
; Собственно говоря, сама таблица декодирования
include "map.asm"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Соответствующие данные
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

; Состояние чтения из файла
in_byte:
	db	0
in_count:
	db	0
out_buf_bytes:
	dw	0
in_index:
    dw  0ffffh

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Буферы данных
align 10h
; Структура памяти:
; - Буфер вывода
; - Буфер ввода
buffer:
