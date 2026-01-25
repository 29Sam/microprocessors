//-- DO NOT CHANGE ANYTHING UNTIL THE **** LINE--//
ORG 0H
LJMP MAIN

ORG 100H
MAIN:
    MOV P1, #01H        ; Set P1.0 = 1
    CALL DELAY_1s       ; Wait 1 second
    MOV P1, #00H        ; Set P1.0 = 0
HERE:
    SJMP HERE

ORG 130H
	
DELAY_1s:
    MOV R1, #100
D1:
    ACALL delay_10ms
    DJNZ R1, D1
    RET

delay_10ms:
    push 00h
    mov r0, #40
h2: acall delay_250us
    djnz r0, h2
    pop 00h
    ret

delay_250us:
    push 00h
    mov r0, #244
h1: djnz r0, h1
    pop 00h
    ret

END
