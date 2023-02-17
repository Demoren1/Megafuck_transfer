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
first_msg db "First msg$"
second_msg db "Second msg$"

main:
mov bx, 0b800h              ;get shift for video
mov es, bx

mov ax, 5           ;x coordinate [0, 80]
mov bx, 16          ;y coordinate [0, 25]

call shift_x_y
;push bx             ;absolute save of shift

;display first num
push bx                                     

sub bx, 160d * 4
add bx, 30d
push bx
mov ax, offset first_msg
call prtn_str
pop bx

push bx             ;saving absolute shift
call input_num      ;num for trans
pop bx

add bx, 160d
sub bx, 14d
push ax
call num_in_row
pop ax

pop bx
push ax            ;saving first num

;display second num
push bx            ;display second num

sub bx, 160d * 4
add bx, 64d
push bx
mov ax, offset second_msg
call prtn_str
pop bx

push bx             ;saving absolute shift
call input_num      ;num for trans
pop bx

add bx, 160d
sub bx, 12d
push ax
call num_in_row
pop ax

pop bx
push ax             ;saving second num

;true program below

push bx             ;absolute save bx

add bx, 26d

mov ax, offset sum_msg
call prtn_str

add bx, 30d
mov ax, offset sub_msg
call prtn_str

add bx, 30d
mov ax, offset mul_msg
call prtn_str

add bx, 30d
mov ax, offset div_msg
call prtn_str

pop bx              ;pulling out absolute save
add bx, 160d

pop dx              ;second num
pop cx              ;first num

add dx, cx
mov ax, dx

push bx             ;saving absolute shift
call input_num      ;num for trans
pop bx

push bx             ;absolute save bx
push ax

call num_in_row

add bx, 160d
add bx, 40d

pop ax
push ax
call num_in_row

add bx, 160d
add bx, 40d

pop ax
push ax
call num_in_row

add bx, 160d
add bx, 40d

pop ax
push ax
call num_in_row

pop ax
pop bx              ;pulling out absolute save

mov cx, 70                     ;width
mov dx, 12                      ;hight
sub bx, 160d * 6               ;up on 2 lines to contain words
call prnt_frame

mov ax, 4c00h
int 21h

end Start
