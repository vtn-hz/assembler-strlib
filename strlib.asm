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
                
    
;   SCMP
;   usage:
;       PUSH origen
;       PUSH compated
;       CALL SCMP @retrieve EAX : diference
;       ADD SP, 8
;  
SCMP:   PUSH BP 
        MOV BP, SP

        PUSH EBX
        PUSH ECX

        MOV EBX, [BP + 12]
        MOV ECX, [BP + 8 ]

        SCMP_LOOP:      MOV EAX, b[EBX]
                        SUB EAX, b[ECX]

                        CMP b[EBX], 0
                        JZ SCMP_FIN
                        CMP b[ECX], 0
                        JZ SCMP_FIN 

                        ADD EBX, 1 
                        ADD ECX, 1
        JMP SCMP_LOOP

        SCMP_FIN:       POP ECX 
                        POP EBX

                        MOV SP, BP
                        POP BP
RET

;   SCAT
;   usage:
;       PUSH origen
;       PUSH concated
;       CALL SCMP @retrieve EAX : origen
;       ADD SP, 8
;  
SCAT:   PUSH BP 
        MOV BP, SP

        PUSH EBX
        PUSH ECX

        MOV EBX, [BP + 12]
        MOV ECX, [BP + 8 ]

        SCAT_FIND0:     CMP b[EBX], 0
                        JZ SCAT_FIND0
                        ADD EBX, 1
        JMP SCAT_FIND0

        SCAT_STARTCAT:  MOV b[EBX], b[ECX]

                        CMP b[ECX], 0
                        JZ SCAT_FIN

                        ADD ECX, 1
        JMP SCAT_STARTCAT

        SCAT_FIN:       POP ECX
                        POP EBX
                        
                        MOV SP, BP
                        POP BP 
RET
