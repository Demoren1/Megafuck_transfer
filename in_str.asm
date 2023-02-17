;-------------------------------------------------
;           prtn_str
;Entry:     ax = adress of message, that ends on $
;           bx = absolute shift
;Exit:      None
;Expects:   es = 0b800h
;           locals @@
;Destroys   ax, bx, cx
;-------------------------------------------------


prtn_str:
    @@printing:
        push ax             ;save address
        push bx             ;save bx for normal indexing
        mov bx, ax
        mov ax, ds:[bx]
        pop bx

        cmp al, '$'        ;checking in exit
        je prnt_end
        
        mov ah, 3
        mov es:[bx], ax     ;printg litra in video

        
        
        add bx, 2           ;shift in both regs
        pop ax
        inc ax
        jmp @@printing


    prnt_end:
    add sp, 2

    ret 
    endp