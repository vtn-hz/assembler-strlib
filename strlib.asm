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
        
        XOR EAX, EAX

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

        MOV EAX, [BP + 12]

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

;   SPLIT
;   usage:
;       PUSH < str >
;       PUSH <char >
;       PUSH <p_arr>
;       CALL SPLIT @retrieve EAX : <p_arr>
;       ADD SP, 12
;  
SPLIT:  PUSH BP 
        MOV BP, SP

        PUSH ECX
        PUSH EFX

        MOV EAX, [BP +  8]
        MOV ECX, [BP + 12]
        MOV EFX, [BP + 16]

        SPLIT_WORD:     CMP b[EFX], 0
                        JZ SPLIT_FIN

                        MOV EBX, [EAX]
                        
                        SPLIT_LOOP:     CMP b[EFX], ECX
                                        JZ SPLIT_NEXT
                                        CMP b[EFX], 0
                                        JZ SPLIT_NEXT

                                        MOV b[EBX], b[EFX]
                                        ADD EBX, 1
                                        ADD EFX, 1
                        JMP SPLIT_LOOP

                        SPLIT_NEXT: XOR b[EBX], b[EBX]
                        ADD EAX, 4
        JMP SPLIT_WORD

        SPLIT_FIN: MOV [EAX], -1
        MOV EAX, [BP + 8]
        
        POP EFX
        POP ECX

        MOV SP, BP
        POP BP
RET


;   STRIM
;   usage:
;       PUSH < str >
;       CALL STRIM @retrieve EAX : < str >
;       ADD SP, 4
;  
STRIM:  PUSH BP
        MOV BP, SP
        
        PUSH EBX
        PUSH ECX
        PUSH EDX

        MOV EAX, [BP + 8]
        MOV EBX, EAX ; first char
        MOV ECX, EAX
        MOV EDX, EAX ; last char

        STRIM_FIRSTL:   CMP b[EBX], 0
                        JZ STRIM_LASTL    
                        CMP b[EBX], ' '
                        JNZ STRIM_LASTL

                        ADD EBX, 1
                        ADD ECX, 1
        JMP STRIM_FIRSTL

        STRIM_LASTL:    CMP b[ECX], 0
                        JZ STRIM_BUILD   
                        
                        CMP b[ECX], ' '
                        JZ STRIM_SKIPCHAR
                        
                        MOV EDX, ECX
                        ADD EDX, 1

                        STRIM_SKIPCHAR: ADD ECX, 1                        
        JMP STRIM_LASTL

        STRIM_BUILD:    CMP EBX, EDX
                        JNN STRIM_FIN

                        MOV b[EAX], b[EBX]
                        ADD EAX, 1
                        ADD EBX, 1
        JMP STRIM_BUILD

        STRIM_FIN: MOV b[EAX], 0
        MOV EAX, [BP + 8]

        POP EDX
        POP ECX
        POP EBX

        MOV SP, BP
        POP BP
RET
