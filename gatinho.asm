	bits 16			; modo 16-bit
	org 0x7c00		; Our load address (alternative way)

    jmp main
    cat1: db "  _._     _,-'''`-._", 0xd,0xa,0x0
    cat2: db " (,-.`._,'(       |\`- /|", 0xd,0xa,0x0
    cat3: db "    `-.-'  \ )-`  (, o o)", 0xd,0xa,0x0
    cat4: db "            `-     \``*'-", 0xd,0xa, 0x0
    start: db "Escolha o tanto de gatos que voce quer ter", 0xd,0xa,0x0 
    new_line: db 0xd, 0xa, 0x0
    cabou: db "pronto", 0xd, 0xa, 0x0

main:
    mov bx, start
    call stringOutput    ;Bota string no output

    call intInput        ;Le um int
    call newLine

    mov dx, bx           ;Poe o int lido no DX
    mov cx, 1             ;Bota 1 no cx

;Bota o numero de gatos desejados
while:
    cmp dx, 0x0
    je end

    sub dx, cx	

    jmp printCat  

    jmp while   

;==========================
intInput:
    push ax
    push cx
    mov bx, 0

charToInt:
    mov ah, 0x0
    int 0x16    ;Le um char

    cmp al, 13  ; Checa se é '\n'
    je endConversion

    mov ah, 0xe
    int 0x10

    movzx dx, al; Guarda o cha rno dx
    sub dx, '0' ; Transforma em int

    imul bx, 0xA

    add bx, dx  ; Soma o int

    jmp charToInt

endConversion:
    pop cx
    pop ax
    ret
;=========================

;=========================
stringOutput:
    push bx
    push cx
    jmp clearStringOutput

clearStringOutput:
    mov cl, [bx]
    cmp cl, 0x0
    je endStringOutput

    call charOutput
    add bx, 0x1
    jmp clearStringOutput    

charOutput:
    push ax

    ; Sets arguments for BIOS interrupt
    mov ah, 0x0e
    mov al, cl
    int 0x10

    pop ax
    ret

endStringOutput:
    pop cx
    pop bx
    ret    

newLine:
    ; Bota \r\n
    push bx
    mov bx, new_line
    call stringOutput
    pop bx
    ret

printCat:
    mov bx, cat1
    call stringOutput

    mov bx, cat2
    call stringOutput

    mov bx, cat3
    call stringOutput

    mov bx, cat4
    call stringOutput

    jmp while

;=========================
end:

    mov bx, cabou
    call stringOutput

    times 510 - ($-$$) db 0	; Pad with zeros
    dw 0xaa55		; Boot signature