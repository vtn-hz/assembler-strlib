;   SLEN
;   usage:
;       PUSH location
;       CALL SLEN @retrieve EAX : string length
;       ADD SP, 4
;   
SLEN:   PUSH BP 
        MOV BP, SP

        PUSH EBX
        MOV EBX, [BP+8]
        
        XOR EAX 

        SLEN_LOOP:  CMP b[EBX], 0
                    JZ SLEN_FIN:

                    ADD EBX, 1
                    ADD EAX, 1
        JMP LOOP

        SLEN_FIN:   POP EBX
                    MOV SP, BP
                    POP BP
RET

;   SCPY
;   usage:
;       PUSH destino
;       PUSH origen
;       CALL SCPY @retrieve EAX : destino
;       ADD SP, 8
;   
SCPY:   PUSH BP 
        MOV BP, SP

        PUSH EBX
    
        MOV EAX, [BP + 12] ; destino
        MOV EBX, [BP + 8]  ; origen

        SCPY_LOOP:  CMP b[EBX], 0
                    JZ SCPY_FIN

                    MOV b[EAX], b[EBX]
                    
                    ADD EAX, 1
                    ADD EBX, 1
        JMP SCPY_LOOP

        SCPY_FIN:   MOV b[EAX], 0
                    MOV EAX, [BP + 12]

                    POP EBX
                    MOV SP, BP
                    POP BP
RET
                
    