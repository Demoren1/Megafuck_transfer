;-----------------------------------
;           base_10
;Entry    ax = num to transfer in base 10
;         bx = absolute shift
;Exit:    None
;Expects: es = 0b800h
;         locals @@
;Destroys: ax, bx, cx, dx
;-----------------------------------

base_10  proc

mov cx, 5              ;counter
add bx, 16

@@Next:     
            push bx             ;save bx

            xor dx, dx          
            mov bx, 10d      
            div bx              ;get num from last pos of num
            add dx, '0'         ;shift for video

            pop bx

            mov dh, 3h          ; get color
            mov es:[bx], dx

            sub bx, 2           ;new place for sym
            loop @@Next
            
ret
endp