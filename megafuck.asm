.model tiny
.code 
.386
locals @@
org 100h

Start:
            jmp main

INCLUDE in_shift.asm    
INCLUDE in_b_2.asm
INCLUDE in_b_10.asm
INCLUDE in_b_16.asm
INCLUDE in_frame.asm
INCLUDE in_input.asm


main:
mov bx, 0b800h              ;get shift for video
mov es, bx

mov ax, 30          ;x coordinate [0, 80]
mov bx, 10          ;y coordinate [0, 25]

call shift_x_y

push bx             ;saving absolute shift
call input_num      ;num for trans
pop bx

mov cx, 3            ;saving num(ax) and shift(bx)
@@fill_stck:  
                push ax
                push bx
                loop @@fill_stck

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

mov cx, 18                      ;width
mov dx, 4                      ;hight
call prnt_frame

mov ax, 4c00h
int 21h

end Start
