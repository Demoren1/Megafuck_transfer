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
INCLUDE in_input_num.asm
INCLUDE in_str.asm
INCLUDE in_unite.asm

sum_msg db "SUM$"
sub_msg db "SUB$"
mul_msg db "MUL$"
div_msg db "DIV$"

main:
mov bx, 0b800h              ;get shift for video
mov es, bx

mov ax, 10          ;x coordinate [0, 80]
mov bx, 10          ;y coordinate [0, 25]

call shift_x_y

push bx             ;absolute save bx

add bx, 26d
mov ax, offset sum_msg
call prtn_str

add bx, 26d
mov ax, offset sub_msg
call prtn_str

pop bx              ;pulling out absolute save
add bx, 160d

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

mov cx, 60                      ;width
mov dx, 6                      ;hight
sub bx, 160d * 2                ;up on 2 lines to contain words
call prnt_frame

mov ax, 4c00h
int 21h

end Start
