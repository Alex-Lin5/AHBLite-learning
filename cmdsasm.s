;------------------------------------------------------------------------------------------------------
; Module4: A Simple SoC Application
; Toggle LEDs at a given frequency. 
;------------------------------------------------------------------------------------------------------



; Vector Table Mapped to Address 0 at Reset

                PRESERVE8
                THUMB

                AREA    RESET, DATA, READONLY
                EXPORT  __Vectors

__Vectors       DCD     0x0000FFFC                ; 32K Internal Memory
                DCD     Reset_Handler             ; Reset Handler
                DCD     0
                DCD     0
                DCD     0
                DCD     0
                DCD     0
                DCD     0
                DCD     0
                DCD     0
                DCD     0
                DCD     0
                DCD     0
                DCD     0
                DCD     0
                DCD     0

                ; External Interrupts
                DCD     0
                DCD     0
                DCD     0
                DCD     0
                DCD     0
                DCD     0
                DCD     0
                DCD     0
                DCD     0
                DCD     0
                DCD     0
                DCD     0
                DCD     0
                DCD     0
                DCD     0
                DCD     0

                AREA    |.text|, CODE, READONLY

; Reset Handler

Reset_Handler   PROC
                GLOBAL  Reset_Handler
                ENTRY
                
AGAIN           LDR     R0, =0x57000000           ; old. Write to LED with value 0xff
                LDR     R1, =0xff
                STR     R1, [R0]
				
				LDR     R0, =0x57000004           ; MASK, 0 prevents modification
                LDR     R2, =0x0f
                STR     R2, [R0]



;                LDR     R0, =0x2            	 ; Delay;
;Loop            SUBS    R0,R0,#1
;                BNE     Loop

                LDR     R0, =0x57000000           ; load old value
                LDR		R1, [R0]
                LDR     R0, =0x57000004				; load mask value
				LDR		R2, [R0]
				
;                LDR     R10, =0x2            	 ; Delay;
;Loop            SUBS    R10,R10,#1
;                BNE     Loop
				
;				STR		R2, [R0]
				
				LDR     R3, =0xaa				 ; new. Write to LED with value 0xAA
				;STR		R3, [R0]
;				ORR 	R7, R2, R1; R1: old value OR mask value = Old 1
;				EOR 	R4, R7, R2; R2: mask XOR R1 = old 0
;				AND 	R5, R2, R3; R3: mask value AND new value = 0 new
;				ORR 	R6, R5, R4; R4: R2 OR R3
                LDR     R0, =0x57000000                           
				STR     R3, [R0]

                LDR     R0, =0x2	             ; Delay
Loop1           SUBS    R0,R0,#1
                BNE     Loop1

                B AGAIN
                ENDP

                ALIGN

                END

