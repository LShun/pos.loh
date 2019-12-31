                                            .MODEL SMALL
.STACK 100
.DATA
	; EXTRA/USEFUL CONSTANTS
	STUB			DB "STUB$"
	TENDW           DW 10
	SIGN            DB "RM $"
	CENTS           DB ".00$" 
	CONFIRMATION    DB ?
	
	; MACROS
	push_all MACRO
       PUSH AX
       PUSH CX
       PUSH DX
       PUSH BX
       ;NOTE: Missing SP, cause bugs
       PUSH BP
       PUSH SI
       PUSH DI
    push_all ENDM
    
    pop_all MACRO
       POP DI
       POP SI
       POP BP
       ;NOTE: Missing SP, cause bugs
       POP BX
       POP DX
       POP CX
       POP AX
    pop_all ENDM
	

    ; MAIN SCREEN
	LOGO			DB " __         ______     __  __     ______   ______     ______", 13, 10
					DB "/\ \       /\  __ \   /\ \_\ \   /\  == \ /\  __ \   /\  ___\", 13, 10
					DB "\ \ \____  \ \ \/\ \  \ \  __ \  \ \  _-/ \ \ \/\ \  \ \___  \", 13, 10
					DB " \ \_____\  \ \_____\  \ \_\ \_\  \ \_\    \ \_____\  \/\_____\", 13, 10
					DB "  \/_____/   \/_____/   \/_/\/_/   \/_/     \/_____/   \/_____/", 13, 10, "$"

	STRSEPARATOR	DB "===============================================================", 13, 10, "$"
	STRWELCOME		DB "               WELCOME TO LOH PORK SALES SYSTEM", 13, 10, "$"
	STRMAINWARN		DB " AUTHORIZED USER ONLY. UNAUTHORIZED ACCESS IS AGAINST THE LAW", 13, 10, "$"
	USERMENUCHOICE  DB ?

	; LOGIN
	strRequestPw 	DB "Please enter password: $"
	strLoginSuccess DB "User authorized. Welcome!$"
	strLoginFail 	DB "Incorrect login details. Try again: $"
	strPw			DB 53,37,22,22,18,85,23,1,"$" ; PW Hash
	userPw			DB 20           ; Max char
	                DB ?            ; Num of char entered
	                DB 20 DUP(0DH)  ; BUffer for Char entered
	xorKey          DB "e"
	
	; MAIN MENU
	STRMAINMENU 	DB "===========================MAIN MENU===========================",13,10
	                DB "1.	PURCHASE",13,10
	                DB "2.	BILLING",13,10
	                DB "3.	SUMMARY",13,10
	                DB "4.	EXIT",13,10
					DB "ENTER YOUR CHOICE: (1-4): ",'$'

	; BILLING
    BILLSTUB			DB "BILLING STUB$"

	TITSTR DB "		      	  CALCULATE PRICE OF MEAT$"
	STR DB "		       ENTER WEIGHT OF MEAT(KG): $"
	PATTERN DB "			============================$" 
	STR1 DB "		       PRICE OF MEAT BOUGHT IS RM $"
	STR2 DB "		       DO YOU WISH TO MAKE PAYMENT? (Y-YES)$"
	STR3 DB "		       ENTER AMOUNT FOR PAYMENT: $"
	STR4 DB "		       THANK YOU! YOUR BALANCE IS RM $"

	STR5 DB "	   Please return to PURCHASE function for input to proceed...$"
	STR6 DB "		       ENTER TO CONTINUE...$"

	SIGN1 DB " * $"
	SIGN2 DB " = $"
	TAB DB "		       $"

	MTYPE DB ?
	WEIGHT1 DW ?
	MPRICE DW ?
	TPRICE DW ?
	AMOUNT DB ?
	QTY DB ?
	PRICE DW ?
    	COUNTS DB ?
	PRICEPKG DB 9,10,11,13,8	;ARRAY FOR MEAT PRICE

	INPUT_AMNT LABEL BYTE    
    	AMNT_MAXN DB 6
    	AMNT_ACTN DB ?
    	AMNT DB 7 DUP("$") 


	; PURCHASE
   
	 PURCSTUB			DB "PURCHASE STUB$"
    WEIGHT_TITLE DB "           		  CALCULATE WEIGHT OF MEAT$"
    DASH DB  "            +-----------------------------------------+-----------+$"
    MSG1 DB  "            |             TYPES OF PORK    	      | PRICE(RM) |$"


	MSG2 DB "	     ENTER A NUMBER (1 TO 6): $"
	ERRORM DB "	     INVALID! PLEASE ENTER AGAIN! $"
	MSG3 DB "             ENTER THE WEIGHT (1KG,3KG OR 5KG): $"
	MSG4 DB "             ENTER THE QUANTITY: $"
	MSG5 DB "             ~~DEAR CUSTOMER, THE TOTAL WEIGHT IS $"
	MSG6 DB ".00 KG$"
	MSG7 DB "             DO YOU WANT TO EDIT YOUR CHOICE? (Y-YES)? $"
	MSG8 DB "             1.  WEIGHT$"
	MSG9 DB "             2.  QUANTITY$"
	MSG10 DB "             PLEASE ENTER A NUMBER (1-2) : $"
	EDIT_NUM DB ?
	
	BELLY DB "            |     1.     PORK BELLY  		      |       9.00|$"
	LOIN DB "            |     2.     PORK LOIN       	      |      10.00|$"
	RIB DB "            |     3.     PORK RIB  		      |      11.00|$"
	SHOULDER DB "            |     4.     PORK SHOULDER   	      |      13.00|$"
	HAM DB "            |     5.     HAM            	      |       8.00|$"
	QUIT DB "            |     6.     QUIT            		  	  |$"

	
	TYPE_STR LABEL BYTE    
	TYPE_MAXN DB 2
	TYPE_ACTN DB ?
	CHOICE DB 3 DUP("$") 

	WEIGHT_STR LABEL BYTE    
	WEIGHT_MAXN DB 2
	WEIGHT_ACTN DB ?
	WEIGHT DB 3 DUP("$")

	QUANTITY_STR LABEL BYTE    
    QUANTITY_MAXN DB 4
    QUANTITY_ACTN DB ?
    QUANTITY DB 5 DUP("$")    

	WGT DW ?
	EDIT DW 8 DUP("$")

	; DISPWORD
	leadZeroFlag DB ?

	; SUMMARY
	SUMTITLE			DB "SUMMARY", 13, 10, "$"
	TATXT               DB "TOTAL ACTIONS: $"    ; UPDATE HERE AFTER EACH LOOP
	TFTXT			    DB "TOTAL FIGURES: $"    ; UPDATE HERE AFTER EACH TRANSACTIONS
	TOTALACTIONS        DW 120
	OPERAND             DW ?
	OPERATOR            DW ?

	QUANT DW ?
    
.CODE

MAIN PROC
    
    MOV AX,@DATA
    MOV DS,AX

	CALL CLEAR_SCREEN
	
    CALL PRINT_LOGO
	
	CALL LOGIN
	
	MENU:
			
		CALL NEXT_LINE
		CALL DISPLAY_MENU
		
		; CHECK PURCHASE
		CHKPURC:
			CMP USERMENUCHOICE, '1'
			JZ PURC
			JNZ CHKBILL
			
			PURC:
				CALL CLEAR_SCREEN
				CALL PURCHASE
		; CHECK BILL
		CHKBILL:
			CMP USERMENUCHOICE, '2'
			JZ BILL
			JNZ CHKSUM
			
			BILL:
				CALL CLEAR_SCREEN
				CALL BILLING
		; CHECK SUM
		CHKSUM:
			CMP USERMENUCHOICE, '3'
			JZ SUM
			JNZ CHKEXIT
			SUM:
				CALL SUMMARY
			
		; END PROGRAM
		CHKEXIT:
			CMP USERMENUCHOICE, '4'
			JZ EXIT
			JNZ CONTINUE
			EXIT:
				MOV AX,4C00H
				INT 21H
		CONTINUE:
		    CALL PRINT_LOGO
			LOOP 	MENU
    
MAIN ENDP

; Usage: General purpose
; Purpose: Display 5 digit integers (up to 65,535)
; Requirements: Digit store in BX 
DISPWORD PROC
    push_all
	MOV DX, 0
	MOV CX, 5 ; 5 digits, change along with operand
	MOV operand, 10000
	MOV AL, 1
	MOV leadZeroFlag, AL
	
	DWDIVDISP:
		; divide
		MOV AX, BX
		DIV operand
		MOV operator, DX
        
        ; Check if leading zero
	    CMP leadZeroFlag, 0
	    JE  DWPRINTNUM
	    ; Check if zero
		CMP AX, 0
		JZ  DWCONTDISPWORD
		; set not leading zero
		MOV BL, 0
	    MOV leadZeroFlag, BL
		
		; print number
		DWPRINTNUM:
		    MOV DX, AX
		    MOV AH, 02h
		    ADD DL, "0"
		    INT 21h
		
		; ready for next print
		DWCONTDISPWORD:
    		MOV AX, operand
    		MOV DX, 0
    		DIV TENDW
    		MOV OPERAND, AX
    		MOV AX, OPERATOR
    		MOV BX, AX  

		LOOP DWDIVDISP
		
	pop_all
	RET
DISPWORD ENDP

; Usage: Control
; Purpose: Display main menu & ask user to select function
; Requirements: None
DISPLAY_MENU PROC
	; Display menu
	MOV	DX, OFFSET STRMAINMENU
	MOV	AH, 9
	INT	21H

	; Ask for choice
	MOV	AH, 01H
	INT	21H
	MOV USERMENUCHOICE, AL
	RET
DISPLAY_MENU ENDP

; Usage: General-purpose
; Purpose: Print a new line
; Requirements: None
NEXT_LINE PROC
    ; main program
	MOV 	AH, 02H
	MOV		DL, 0DH		; CR
	INT		21H
	MOV		DL, 0AH		; LF
	INT 	21H
	RET
	
NEXT_LINE ENDP

; Usage: In Billing & Purchase
; Purpose: Display meat menu
; Requirements: None
DISPLAY_MEAT_MENU PROC	

;-----DISPLAY MEAT MENU
	CALL NEXT_LINE
	
	MOV AH,09H
	LEA DX,DASH
	INT 21H
	
	CALL NEXT_LINE
	
	MOV AH,09H
	LEA DX,MSG1
	INT 21H

	CALL NEXT_LINE

	MOV AH,09H
	LEA DX,DASH
	INT 21H

	CALL NEXT_LINE
	
	MOV AH,09H
	LEA DX,BELLY
	INT 21H

	CALL NEXT_LINE

	MOV AH,09H
	LEA DX,LOIN
	INT 21H

	CALL NEXT_LINE

	MOV AH,09H
	LEA DX,RIB
	INT 21H

	CALL NEXT_LINE

	MOV AH,09H
	LEA DX,SHOULDER
	INT 21H

	CALL NEXT_LINE

	MOV AH,09H
	LEA DX,HAM
	INT 21H 
	
	CALL NEXT_LINE

	MOV AH,09H
	LEA DX,DASH
	INT 21H
	
	CALL NEXT_LINE

	MOV AH,09H
	LEA DX,QUIT
	INT 21H
		
	CALL NEXT_LINE

	MOV AH,09H
	LEA DX,DASH
	INT 21H

	CALL NEXT_LINE
	CALL NEXT_LINE

	RET

	RET
DISPLAY_MEAT_MENU ENDP


; Usage: Main Program
; Purpose: Login function main function
; Requirements: None
LOGIN PROC
	;; SHOW LOGIN PROMPT
;	CALL NEXT_LINE
;	MOV	AH, 09H
;	LEA DX, STRREQUESTPW
;	INT 21H
;
;	CALL LOGIN_CMP_SETUP
;	
;	CHECKPW:
;		; COMPARE EACH LETTER
;		CMP BH, BL
;		JNE LOGINFAIL
;		
;		; IF NO MATCH, ASK USER TO TRY 
;		
;		INC DI
;		INC SI
;		
;		MOV BL, [DI]
;	    MOV BH, [SI]
;		
;		; ONCE REACH END, PERFORM FINAL CHECK
;		CMP BL, '$'
;		JNE CHECKPW
;		CMP BH, 0DH
;		JNE LOGINFAIL
;		
;		; IF ALL MATCH, WELCOME USER
;		CALL NEXT_LINE
;		
;		MOV AH, 09H
;        LEA DX, STRLOGINSUCCESS
;        INT 21H
;        
;        CALL NEXT_LINE
        RET
;        
;
;    ; ASK USER TO TRY AGAIN
;    LOGINFAIL:
;        CALL NEXT_LINE
;        MOV AH, 09H
;        LEA DX, STRLOGINFAIL
;        INT 21H
;        CALL NEXT_LINE
;        
;        CALL LOGIN_CMP_SETUP
;        JMP CHECKPW
         
LOGIN ENDP


; Usage: In Login
; Purpose: Helper function, setup Login
; Requirements: None
LOGIN_CMP_SETUP PROC
    ; OVERWRITE BUFFER
    
    
    ; GET PASSWORD
	MOV AH, 0AH
	LEA DX, USERPW
	INT 21H

	; COMPARE THE STRING WITH ACTUAL PW, CHAR BY CHAR
	LEA DI, STRPW
	MOV SI, OFFSET USERPW + 2
	CALL NEXT_LINE
	
	MOV BL, [DI]
	MOV BH, [SI]
	
	RET
LOGIN_CMP_SETUP ENDP  

; Usage: Main Program
; Purpose: Purchase function
; Requirements: None
PURCHASE PROC	
	CALL DISPLAY_MEAT_MENU
	
	MOV AH,09H		;PRINT PATTERN
	LEA DX,PATTERN
	INT 21H

	CALL NEXT_LINE
	
	MOV AH,09H		;PRINT TITLE
	LEA DX,WEIGHT_TITLE
	INT 21H

	CALL NEXT_LINE
	
	MOV AH,09H		;PRINT PATTERN
	LEA DX,PATTERN
	INT 21H

	CALL NEXT_LINE
    
    
    MEAT_TYPE_INPUT:
	;-----DISPLAY THE INPUT MESSAGE
	CALL NEXT_LINE
	MOV AH,09H	
	LEA DX,MSG2		;ENTER THE MEAT TYPE
	INT 21H
		
	;-----ALLOW USER TO SELECT THE TYPE OF MEAT
    
        MOV AH,0AH     ;INPUT STRING
        LEA DX,TYPE_STR
        INT 21H
        
        MOV DI,0
    
        CMP CHOICE[DI],"1"
        JL INVALID

        CMP CHOICE[DI],"6"
	    JG INVALID

        
        JMP WEIGHT_INPUT

	    	INVALID:
		    	CALL ERROR_LIM
    
        JMP MEAT_TYPE_INPUT

	WEIGHT_INPUT: 
		MOV BH,CHOICE[DI]
		MOV MTYPE,BH
		;MOV EDIT[DI],BX
		SUB MTYPE,30H
		;DEC MTYPE
		
		MOV AH,0
		MOV AL,MTYPE
		MOV EDIT[DI],AX
		;DEC MTYPE


	;-----ALLOW USER TO ENTER THE WEIGHT OF MEAT
	INPUT_WEIGHT_AGAIN:			
		CALL NEXT_LINE
		CALL NEXT_LINE
		
		MOV AH,09H
		LEA DX,MSG3		        ;ENTER THE WEIGHT (1,3,5KG) :
		INT 21H
	
		MOV AH,0AH              ;INPUT STRING
        LEA DX,WEIGHT_STR
        INT 21H
        
        MOV DI,0
        MOV BL,WEIGHT[DI] 
        SUB BL,30H
		MOV BH,0  
        MOV WGT,BX

		CMP WEIGHT[DI],"1"		;COMPARE THE INPUT WITH NUMBER 1
		JE QUANTITY_INPUT
		
		CMP WEIGHT[DI],"3"		;COMPARE THE INPUT WITH NUMBER 3
		JE QUANTITY_INPUT

		CMP WEIGHT[DI],"5"		;COMPARE THE INPUT WITH NUMBER 5
		JE QUANTITY_INPUT

		CALL NEXT_LINE
		
		MOV AH,09H
		LEA DX,ERRORM
		INT 21H

	JMP INPUT_WEIGHT_AGAIN
	
	
	QUANTITY_INPUT:	
	    
	    CALL NEXT_LINE
		CALL NEXT_LINE
	    
	    CALL ENTER_QUANTITY
		
	
	CALL NEXT_LINE	
	CALL NEXT_LINE
	;MOV BH,0
	;MOV BL,QUANT
	
	MOV AH,09H
	LEA DX,MSG5
	INT 21H
	
	CALL DISPWORD

	
	;MOV AH,02H
	;MOV DL,QUANT
	;ADD DL,30H
	;INT 21H

	MOV AH, 09H
    LEA DX, MSG6		;DISPLAY UNIT (KG)
    INT 21H	
	
	;MOV SI,0
	;MOV EDIT[SI],CHOICE
	
	CALL NEXT_LINE
	CALL NEXT_LINE

	MOV AH,09H
	LEA DX,MSG7		;DO YOU WANNA CONTINUE?
	INT 21H
	
	MOV AH,01H
	INT 21H
	MOV CONFIRMATION,AL
	
	CALL NEXT_LINE
	
	CMP CONFIRMATION,"Y"
	JE YES
	CALL MAIN
	
	YES:
		CALL EDITING
		
	CALL NEXT_LINE
	
    RET
PURCHASE ENDP

; Usage: Main Program
; Purpose: Billing function
; Requirements: None
BILLING PROC 
	CALL NEXT_LINE

	CALL DISPLAY_MEAT_MENU
	
	MOV AH,09H		;PRINT PATTERN
	LEA DX,PATTERN
	INT 21H

	CALL NEXT_LINE
	
	MOV AH,09H		;PRINT TITLE
	LEA DX,TITSTR
	INT 21H

	CALL NEXT_LINE
	
	MOV AH,09H		;PRINT PATTERN
	LEA DX,PATTERN
	INT 21H

	CALL NEXT_LINE

	;CALL INPUT_MEAT_TYPE
	
	CALL NEXT_LINE

	CMP WEIGHT1,0
	JE DISPM
	
	JMP PROCEED

	DISPM:
		MOV AH,09H
		LEA DX,STR5
		INT 21H

		;CALL next_line
		
		MOV AH,01H
		INT 21H

		CALL CLEAR_SCREEN
		
		RET

PROCEED:	
	MOV DH,0
	MOV DL,MTYPE		;ORIGINAL
		
	;MOV DX,EDIT[0]
	
	MOV SI,DX
	DEC SI
	MOV AX,WEIGHT1
	MOV BH,0
	MOV BL,PRICEPKG[SI]
	MUL BX
	MOV TPRICE,AX	;TOTAL PRICE

	MOV AH,09H
	LEA DX,TAB		;TAB
	INT 21H

	MOV BX,WEIGHT1		;WEIGHT
	CALL DISPWORD

	MOV AH,09H
	LEA DX,MSG6		;KG
	INT 21H

	MOV AH,09H
	LEA DX,SIGN1		;*
	INT 21H

	MOV AH,09H
	LEA DX,SIGN		;RM
	INT 21H	

	MOV BH,0
	MOV BL,PRICEPKG[SI]	;PRICE
	CALL DISPWORD

	MOV AH,09H
	LEA DX,CENTS		;.00
	INT 21H

	MOV AH,09H
	LEA DX,SIGN2		;=
	INT 21H

	MOV AH,09H
	LEA DX,SIGN		;RM
	INT 21H	
                                       
	MOV BX,TPRICE
	CALL DISPWORD

	MOV AH,09H
	LEA DX,CENTS		;.00
	INT 21H

	CALL NEXT_LINE
	
	MOV AH,09H
	LEA DX,STR1
	INT 21H

	MOV BX,TPRICE
	CALL DISPWORD

	MOV AH,09H
	LEA DX,CENTS
	INT 21H

	CALL NEXT_LINE

	MOV AH,09H		;CONTINUE FOR PAYMENT?
	LEA DX,STR2
	INT 21H	

	MOV AH,01H
	INT 21H		;INPUT CHOICE
	MOV CONFIRMATION,AL
	
	CALL NEXT_LINE
	
	CMP CONFIRMATION,"Y"
	JE NEXT

	CALL NEXT_LINE

	CALL ENTER_TO_CON
	RET	

	NEXT: 
	
AGAIN:
		CALL NEXT_LINE

		MOV AH,09H
		LEA DX,STR3
		INT 21H

	
		MOV AH,0AH
		LEA DX,INPUT_AMNT		
		INT 21H

		MOV CH,0
		MOV CL,AMNT_ACTN
		MOV SI,0
	
		CALL NEXT_LINE

		CHECK_INPUT:
		    
		    CMP AMNT[SI],47
		    JL FALSE

		    CMP AMNT[SI],58
		    JG FALSE
		
		    INC SI
	    	LOOP CHECK_INPUT
	    JMP CONT
	    
	    FALSE:

		CALL ERROR_LIM
	           JNE AGAIN

		CALL NEXT_LINE
	CONT:

		MOV BH,AMNT_ACTN
	        
	; CHECK IF ONLY 1 NUMBER LEFT   
	    CMP BH,1
	    MOV AX,0
	    MOV SI,0     
	    JE CALP  
	         
		MOV CH,0 
		MOV CL,AMNT_ACTN 
		DEC CL
		MOV AL,0
		LP2:
	  
		        MOV BL,AMNT[SI]
		        SUB BL,30H
				;ADD AL,BL
				MOV BH,0
				ADD AX,BX
                	MUL TENDW
		INC SI
		
		LOOP LP2 
	    
	    
	   CALP:
	          MOV BL,AMNT[SI]
		  SUB BL,30H 
	          ;ADD AL,BL
		  MOV BH,0
		  ADD AX,BX
		    
		MOV AMOUNT,AL

		CMP AX,TPRICE
		JGE CALCHG

		CALL ERROR_LIM
		JMP AGAIN

	
	CALCHG:
		SUB AX,TPRICE
		MOV BX,AX

		MOV AH,09H
		LEA DX,STR4
		INT 21H		

		CALL DISPWORD

		MOV AH,09H
		LEA DX,CENTS
		INT 21H
		
		CALL NEXT_LINE

		MOV AH,09H
		LEA DX,STR6
		INT 21H

		MOV AH,01H
		INT 21H
		
	CALL CLEAR_SCREEN
	
	;CALL PRINT_LOGO
	
	RET
   
BILLING ENDP

; Usage: Main Program
; Purpose: Summary function
; Requirements: None
SUMMARY PROC
	CALL next_line
	
	; Print title	
	MOV	AH, 09H
    LEA DX, sumTitle
    INT 21H
    
    CALL next_line
    
    ; Print total actions
    MOV	AH, 09H
    LEA DX, taTxt
    INT 21H

    ; display al (quotient)
    MOV BX, totalActions
    CALL DISPWORD
    
    CALL next_line                                                       
    CALL next_line
    RET
SUMMARY ENDP 

; Usage: Billing & Purchase
; Purpose: Summary function
; Requirements: None
ERROR_LIM PROC
    CALL NEXT_LINE

	MOV AH,09H
	LEA DX,ERRORM
	INT 21H
	
	CALL NEXT_LINE 
	
    RET
    
ERROR_LIM ENDP


; Usage: General purpose
; Purpose: Clear the screen
; Requirements: None
CLEAR_SCREEN PROC
    
    MOV AH,00H    ;06 TO SCROLL & 00 FOR FULLJ SCREEN
    MOV AL,03H
    MOV BH,07    ;ATTRIBUTE 7 FOR BACKGROUND AND 1 FOR FOREGROUND
    MOV CX,0000H    ;STARTING COORDINATES
    MOV DX,184FH    ;ENDING COORDINATES
    INT 10H        ;FOR VIDEO DISPLAY
  
    
    RET  
       
CLEAR_SCREEN ENDP    

; Usage: General purpose
; Purpose: Print POS.LOH main logo
; Requirements: None
PRINT_LOGO PROC
	MOV AH, 09H
	LEA DX, LOGO
	INT 21H
	
	LEA DX, STRSEPARATOR
	INT 21H
	
    LEA DX, STRWELCOME
    INT 21H
    
    LEA DX, STRSEPARATOR
	INT 21H
	
	CALL NEXT_LINE
	
	MOV AH, 09H
    LEA DX, STRMAINWARN
    INT 21H
    
    CALL NEXT_LINE
	
	RET

PRINT_LOGO ENDP

; Usage: Helper for Purchase function
; Purpose: Allows editing of purchase details
; Requirements: None
EDITING PROC
	MOV AH,09H
	LEA DX,MSG8		;EDIT WEIGHT
	INT 21H
		
	CALL NEXT_LINE

	MOV AH,09H
	LEA DX,MSG9	;EDIT QUANTITY
	INT 21H

	CALL NEXT_LINE
	
	MOV AH,09H
	LEA DX,MSG10	;PROMPT MESSAGE
	INT 21H
	
	MOV AH,01H
	INT 21H			;GET USER INPUT
	MOV EDIT_NUM,AL ;PROTECT DATA
	
	CMP EDIT_NUM,"1"
	JL ERROR2
	
	CMP EDIT_NUM,"2"
	JG ERROR2		;COMPARE IF THE INPUT IS 1 OR 2
	
	;CALL DISPLAY_MEAT_MENU
				
	CMP EDIT_NUM,"1"
	JE CHANGE_WEIGHT
	
	CMP EDIT_NUM,"2"
	JE CHANGE_QUANTITY		; CAN BE REMOVED

	;PROCESS FOR EDITING WEIGHT 
	CHANGE_WEIGHT:
		CALL TEMP		
		CMP WEIGHT[DI],"1"		;COMPARE THE INPUT WITH NUMBER 1
		JE OUTPUT
		
		CMP WEIGHT[DI],"3"		;COMPARE THE INPUT WITH NUMBER 3
		JE OUTPUT

		CMP WEIGHT[DI],"5"		;COMPARE THE INPUT WITH NUMBER 5
		JE OUTPUT	

		CALL NEXT_LINE	

		CALL ERROR_LIM
		JMP CHANGE_WEIGHT
		
		OUTPUT:
			MOV DH,0
			MOV DL,MTYPE
			
			MOV SI,DX
			DEC SI
			MOV AX,WGT
			MOV DX,0 
			;MOV BH,0
			MOV BX,QUANT
			MUL BX
			
			MOV WEIGHT1,AX	;TOTAL WEIGHT
										   
			MOV BX,AX
			
			MOV AH,09H
			LEA DX,MSG5
			INT 21H
			
			CALL DISPWORD
			
			MOV AH,09H
			LEA DX,MSG6
			INT 21H
			
			CALL NEXT_LINE
			
			CALL ENTER_TO_CON
			
			CALL NEXT_LINE
			CALL HI
			JMP TEST1	
			
	CHANGE_QUANTITY:			; CAN BE REMOVED
	
		CALL ENTER_QUANTITY	
		JMP TEST1
			
	ERROR2:
		CALL ERROR_LIM
		CALL NEXT_LINE
		CALL EDITING		

				

	TEST1:
		RET
EDITING ENDP

HI PROC
	MOV DH,0
	MOV DL,MTYPE		
		
	MOV SI,DX
	DEC SI
	MOV AX,WEIGHT1
	MOV BH,0
	MOV BL,PRICEPKG[SI]
	MUL BX
	MOV TPRICE,AX	
									   
	MOV BX,AX

	CALL DISPWORD
	RET
HI ENDP

TEMP PROC
	CALL CLEAR_SCREEN
	CALL DISPLAY_MEAT_MENU
	CALL NEXT_LINE
	
	MOV AH,09H	
	LEA DX,MSG3		;PROMPT MESSAGE FOR WEIGHT
	INT 21H		

	MOV AH,0AH     ;INPUT STRING
	LEA DX,WEIGHT_STR
	INT 21H
	
	MOV DI,0
	MOV BL,WEIGHT[DI]
	SUB BL,30H
	MOV BH,0  
	MOV WGT,BX
	
	RET

TEMP ENDP

ENTER_TO_CON PROC
	MOV AH,09H
	LEA DX,STR6
	INT 21H

	MOV AH,01H
	INT 21H
	
	CALL CLEAR_SCREEN
	
	RET

ENTER_TO_CON ENDP

ENTER_QUANTITY PROC
	MOV AH,09H
		LEA DX,MSG4		;PROMPT MESSAGE FOR QUANTITY
		INT 21H
		
		;QTY_INPUT1:
		MOV AH,0AH              ;INPUT STRING
        LEA DX,QUANTITY_STR
        INT 21H
	
	    MOV CH,0
	    MOV CL,QUANTITY_ACTN
	    MOV SI,0
	    
	    CHECK_DIGIT:
		    
		    CMP QUANTITY[SI],47
		    JL INVALID2

		    CMP QUANTITY[SI],58
		    JG INVALID2
		
		    INC SI
		   

	    LOOP CHECK_DIGIT
	    JMP RESUME
	    
	    INVALID2:

			   CALL ERROR_LIM
	           JNE QUANTITY_INPUT
	        
	    
	    ;CALL ERROR
	
	; LOAD CHAR COUNT INTO VAR 
	   RESUME:
	    MOV BH,QUANTITY_ACTN
	        
	; CHECK IF ONLY 1 NUMBER LEFT   
	    CMP BH,1
	    MOV AX,0
	    MOV SI,0     
	    JE CALQ  
	         
	         MOV CH,0 
	         MOV CL,QUANTITY_ACTN 
	         DEC CL
	         ;MOV AL,0
	         LP1:
	  
		        MOV BL,QUANTITY[SI]
		        SUB BL,30H
			MOV BH,0
			ADD AX,BX
                	MUL TENDW
			INC SI
		
		    LOOP LP1 
	    
	    
	   CALQ:
	          MOV BL,QUANTITY[SI]
		      SUB BL,30H 
		      ;MOV AH,0 ;NEW
	              ;ADD AL,BL
		      MOV BH,0
		      ADD AX,BX
		    
		MOV QUANT,AX
	     
	    
	    ; IF NO, LOOP CALCULATION TILL ONLY LEFT 1 NUMBER 
	    
	    
	        ; ADD NUMBER TO AX
	        ; MULT BX BY 10
	        ; CONTINUE
	    ; ELSE, LOAD LAST NUMBER INTO BX
	
	; STORE INTO QUANT
	
	;MOV QUANT,AX     
	
	
	MUL WGT
	;MOV DH,0
	;MOV DL,MTYPE
	;MOV SI,DX
	MOV WEIGHT1,AX


	
	MOV BX,AX
	
	RET

ENTER_QUANTITY ENDP
END MAIN

