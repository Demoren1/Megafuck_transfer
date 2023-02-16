;-----------------------------------
;           base_2
;Entry    ax = num to transfer in base 2
;         bx = shift 
;Exit:    None
;Expects: es = 0b800h
;         locals @@
;Destroys: ax, bx, cx, dx
;-----------------------------------

base_2  proc

add bx, 30
mov cx, 16              ;counter

@@Next:     
            mov dx, 1h         ; update mask
            and dx, ax          ;find 0 or 1
            add dx, 2130h 
            mov es:[bx], dx     ;write to video
            
            sub bx, 2           ; shift for video
            shr ax, 1           ;shift num left
            loop @@Next

ret
endp