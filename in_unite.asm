;-----------------------------------
;               write num in 3 system in row
;Entry:         ax = num to trans
;               bx = shift
;Expect:        es = 0b800h
;Exit:          None
;Destroys:      ax, bx, cx, dx
;-----------------------------------
num_in_row proc

push ax
push bx
push ax
push bx

call base_2

pop bx
pop ax

add bx, 174d        ;to shift on next string
call base_10

pop bx
pop ax

add bx, (160 + 11) * 2        ;to shift on next string
call base_16

pop bx
sub bx, 160d
sub bx, 4d

ret 
endp