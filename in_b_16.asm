;-----------------------------------
;               base_16
;Entry    ax = num to transfer in base 16
;         bx = absolute shift
;Exit:    None
;Expects: es = 0b800h
;         locals @@
;Destroys: ax, bx, cx, dx
;-----------------------------------

base_16  proc

add bx, 8
mov cx, 4              ;counter

@@Next:     
            nop
            nop

            mov dx, 0fh             ; update mask
            and dx, ax              ;find shift for hex
            
            push bx                 ; save bx to get sym for hex num
            xor bx, bx
            add bx, offset hex_str
            add bx, dx
            mov dx, [bx]
            pop bx
            
            mov dh, 3h
            mov es:[bx], dx         ;write to video
            
            sub bx, 2           ; shift for video
            shr ax, 4           ;shift num left
            loop @@Next

ret
endp

hex_str db '0123456789ABCDEF'