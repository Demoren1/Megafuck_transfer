;----------------------------------
;               input_num
;Entry:         cx = len of num < 8
;Exit:          ax = num
;Expects:       locals @@
;               .386
;Destroys:      ax, bx, cx, dx
;----------------------------------
input_num   proc
    mov dx, offset input_msg      ;learn the num
    mov ah, 09h
    int 21h

    call __input_num__

ret
endp

__input_num__   proc

    xor ax, ax
    xor bx, bx



@@read_num:
        mov ah, 01h         ;code for input
        int 21h

        cmp al, 0dh
        je  @@end_reading

        sub ax, 48d         ;true num
        xor ah, ah          ;get rid of func index
        push ax
        mov ax, bx
        mov bx, 10
        mul bx
        mov bx, ax
        pop ax
        add bx, ax
        xor al, al          ;get rid from trash
        jmp @@read_num

@@end_reading:

mov ax, bx
ret
endp
            
input_msg db "Input your num:", 10, '$'
