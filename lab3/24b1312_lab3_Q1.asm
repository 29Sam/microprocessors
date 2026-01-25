;E CHAR I:70h = 24,36,12,3,2,6
;E CHAR I:70h = -33,-28,1,0,-1,-15
;E CHAR I:70h = -1,-1,-1,-1,-1,-1

ORG 0H
LJMP MAIN
ORG 100H
MAIN:
CALL MAC_THRESH
HERE: SJMP HERE
ORG 130H
MAC_THRESH:
; Perform MAC operation
; Store 18-bit result at 50H,51H,52H
; Compare result with T1 and T2 (use XRL if required)
; Set/clear P3.0 and P3.1 accordingly
MOV 76H , #01H  ;M1
MOV 77H , #00H  ;middle1
MOV 78H , #00H  ;L1
MOV 79H , #00H  ;M2
MOV 7AH , #80H  ;middle2
MOV 7BH , #00H  ;L2
;MOV 70H , a1  ;no need!!
; B  does not function as acumulator , all accumulator functions to be performed in A itself !!
; Check byte by byte whenever comparing to a threshold value, eg if MSBs of result and T1 are equal, check middle byte and so on!!
CLR A 
MOV 50H , A  ;Mf
MOV 51H , A  ;middlef
MOV 52H , A  ;Lf

MOV A, 70H
MOV B, 73H
MUL AB     ; A lower8 & B upper 8

MOV 52H , A 
MOV 51H , B 

MOV A, 71H
MOV B, 74H
MUL AB    ; A lower8 & B upper 8

ADD A, 52H
MOV 52H, A 
MOV A , B
ADDC A, 51H 
MOV 51H, A

MOV A, 50H
ADDC A, #00H
MOV 50H, A

MOV A, 72H
MOV B, 75H
MUL AB   ; A lower8 & B upper 8

ADD A, 52H
MOV 52H, A
MOV A , B
ADDC A, 51H
MOV 51H, A

MOV A, 50H
ADDC A, #00H
MOV 50H, A

MOV A, 50H
CLR C
SUBB A, 76H
JC NOT_GREATER
JNZ GREATER

MOV A, 51H
SUBB A, 77H
JC NOT_GREATER
JNZ GREATER

MOV A, 52H
SUBB A, 78H
JC NOT_GREATER


GREATER:
SETB P3.0
SETB P3.1
SJMP DONE

NOT_GREATER:
CLR P3.0
CLR P3.1

DONE:
RET

END


;E CHAR I:70h = 24,36,12,3,2,6
;E CHAR I:70h = -33,-28,1,0,-1,-15
;E CHAR I:70h = -1,-1,-1,-1,-1,-1



