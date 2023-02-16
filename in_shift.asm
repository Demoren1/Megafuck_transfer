;---------------------------------
;               shift_x_y
;Entry:     ax = x coordinate [0; 80]
;           bx = y coordinate [0; 25]
;Exit:      bx = absolute value for es = 0b800h
;Expects:   None
;Destroy:   ax
;----------------------------------
shift_x_y   proc

push ax         ;get right shift
mov ax, bx
mov bx, 160d
mul bl          ;ax * 160
mov bx, ax      ;bx = ax
pop ax      
push bx
mov bx, 2
mul bl
pop bx
add bx, ax
xor ax, ax

ret 
endp