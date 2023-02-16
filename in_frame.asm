;-------------------------------------
;           prnt_frame
;Entry:                 bx = absolute shift
;                       cx = width
;                       dx = hight
;Exit:                  None
;Expects:               es = 0b800h
;                       .386
;                       locals @@
;Destroys:              ax, bx, cx, dx
;Additional comment:    up and down = 2feh
;                       right and left = 403h
;-----------------------------------

ret 
endp

;-----------------------------------------------
prnt_frame      proc

cmp cx, 0
je Error_cx
cmp dx, 0
je Error_dx

;call shift_x_y

push bx         ;fixing angle 
mov ax, dx      
mov bx, 160d
mul bl
pop bx
add bx, ax
xor ax, ax

push cx         ;go right
push dx
mov dx, 403h    ; heart in start
mov es:[bx], dx
add bx, 2
mov dx, 2feh
@@right:
    mov es:[bx], dx
    add bx, 2
    loop @@right
sub bx, 2
pop dx
pop cx

push cx         ;go down, exchange cx, dx
push dx
pop cx
pop dx

push cx
push dx
mov dx, 403h
@@down:
    mov es:[bx], dx
    sub bx, 160d
    loop @@down
pop dx
pop cx


push cx ;exchange for going left
push dx
pop cx
pop dx

push cx
push dx

mov dx, 403h        ;heart at start
mov es:[bx], dx
sub bx, 2

mov dx, 2feh

@@left:
    mov es:[bx], dx
    sub bx, 2
    loop @@left
add bx, 2
pop dx
pop cx

push cx ;exchange for going up
push dx
pop cx
pop dx

push cx
push dx
mov dx, 403h

@@up:
    mov es:[bx], dx
    add bx, 160d
    loop @@up
pop dx
pop cx

Error_cx:
Error_dx:

ret 
endp
