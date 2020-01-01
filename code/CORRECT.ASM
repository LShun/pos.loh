.MODEL SMALL
.STACK 100
.DATA
	; EXTRA/USEFUL CONSTANTS
	STUB			DB "STUB$"
	TENDW           DW 10
	SIGN            DB "RM $"
	CENTS           DB ".00$" 
	CONFIRMATION    DB ?
	

    ; MAIN SCREEN
	LOGO			DB "          __         ______     __  __     ______   ______     ______          ", 13, 10
					DB "         /\ \       /\  __ \   /\ \_\ \   /\  == \ /\  __ \   /\  ___\         ", 13, 10
					DB "         \ \ \____  \ \ \/\ \    \ \  _\  \ \  _-/ \ \ \/\ \  \ \___  \        ", 13, 10
					DB "           \/_____/   \/_____/   \/_/\/_/   \/_/     \/_____/   \/_____\       ", 13, 10, "$"
    
	STRSEPARATOR	DB "================================================================================", 13, 10, "$"
	STRWELCOME		DB "                        WELCOME TO LOH PORK SALES SYSTEM", 13, 10, "$"
	STRMAINWARN		DB "          AUTHORIZED USER ONLY. UNAUTHORIZED ACCESS IS AGAINST THE LAW", 13, 10, "$"
	USERMENUCHOICE  DB ?

	; LOGIN
	    
	strRequestPw 	DB "   Please enter password: $"
	strLoginSuccess DB "               User authorized. Welcome!$"
	strLoginFail 	DB "Incorrect login details. Try again: $"
	strPw			DB 53,37,22,22,18,85,23,1,"$" ; PW Hash
	userPw			DB 20           ; Max char
	                DB ?            ; Num of char entered
	                DB 20 DUP(0DH)  ; BUffer for Char entered
	xorKey          DB "e"
	
	; MAIN MENU
	STRMAINMENU 	DB "                                            __                                 ",13,10
                    DB "                        |\/| /\ ||\ |  |\/||_ |\ |/  \                         ",13,10
                    DB "                        |  |/--\|| \|  |  ||__| \|\__/                         ",13,10
	                DB "                    +--------------------------------------+                   ",13,10
	                DB "                    |             1.  PURCHASE             |                   ",13,10
	                DB "                    |             2.  BILLING              |                   ",13,10
	                DB "                    |             3.  SUMMARY              |                   ",13,10
	                DB "                    |             4.  EXIT                 |                   ",13,10
					DB "                    +--------------------------------------+                   ",13,10
					DB "                     ENTER YOUR CHOICE (1-4) : $"
	

	; BILLING
    BILLSTUB			DB "BILLING STUB$"

	TITSTR DB 10,13,"            __  __   __ __   __        __          ___ __  __ ",10,13
		   DB "           |__)|__)|/  |_   /   /\ |  /  /  \|   /\ | /  \|__)",10,13
		   DB "           |   | \ |\__|__  \__/--\|__\__\__/|__/--\| \__/| \$"  

	STR1 DB 13,10,"                     PRICE OF MEAT BOUGHT IS RM $"
	STR2 DB "             DO YOU WISH TO MAKE PAYMENT (Y-YES)? $"
	STR3 DB "                   ENTER AMOUNT FOR PAYMENT : $"
	STR4 DB "                   THANK YOU! YOUR BALANCE IS RM $"
	STR5 DB "         Please return to PURCHASE function for input to proceed...$"

	CURRENCYMENU DB "                   +---------------------------------+",13,10
		         DB "                   |           CURRENCY              |",13,10
		         DB "                   +---------------------------------+",13,10
		         DB "                   |    1. RINGGIT MALAYSIA (MYR)    |",13,10
		         DB "                   |    2. US DOLLAR        (USD)    |",13,10
		         DB "                   +---------------------------------+$",13,10
		     
	CURMSG       DB 13,10,"                   ENTER CHOICE FOR CURRENCY(1-2) : $"

	SIGN1 DB " * $"
	SIGN2 DB " = $"
	TAB DB "		       $"

	PRICEPKG DB 9,10,11,13,8	;ARRAY FOR MEAT PRICE
	MTYPE DB ?
	WEIGHT1 DW ?
	MPRICE DW ?
	TPRICE DW ?
	AMOUNT DB ?
	QTY DB ?
	PRICE DW ?
    COUNTS DB ?
	CURRENCY DB ?
	

	INPUT_AMNT LABEL BYTE    
    	AMNT_MAXN DB 6
    	AMNT_ACTN DB ?
    	AMNT DB 7 DUP("$") 


	; PURCHASE
   
	PURCSTUB			DB "PURCHASE STUB$"

	MSG1          DB "             ENTER A NUMBER (6 TO QUIT) : $"
	ERRORM        DB "             INVALID! PLEASE ENTER AGAIN! $"
	MSG2          DB "             ENTER THE WEIGHT (1KG,3KG OR 5KG) : $"
	MSG3          DB "             ENTER THE QUANTITY (MAX 3 DIGIT) : $"
	MSG4          DB "             DEAR CUSTOMER, THE TOTAL WEIGHT IS $"
	MSG5          DB ".00 KG$"
	MSG6          DB "             DO YOU WANT TO EDIT YOUR CHOICE (Y-YES)? $"
	MSG7          DB "                        ****************",13,10
	              DB "                        * 1.  WEIGHT   *",13,10
	              DB "                        * 2.  QUANTITY *",13,10
		          DB "                        ****************$"
	MSG8          DB "             ENTER A NUMBER (1-2) : $"
	MSG9          DB "             ENTER NEW WEIGHT (1KG,3KG OR 5KG) : $"
	MSG10         DB "             ENTER NEW QUANTITY (MAX 3 DIGIT) : $"
	EDIT_NUM      DB ?
	WGT           DW ?
	MEAT_MENU     DB "            +-----------------------------------+------------+",10,13
				  DB "            |           TYPES OF PORK           | PRICE (RM) |",10,13
			      DB "            +-----------------------------------+------------+",10,13
			      DB "            |     1.     PORK BELLY             |        9.00|",10,13
	              DB "            |     2.     PORK LOIN              |       10.00|",10,13
	              DB "            |     3.     PORK RIB               |       11.00|",10,13
	              DB "            |     4.     PORK SHOULDER          |       13.00|",10,13
	              DB "            |     5.     HAM                    |        8.00|",10,13
	              DB "            +-----------------------------------+-----------+$",10,13
	WEIGHT_TITLE  DB 13,10,"               __  __     ___   __        __          ___ __  __ ",13,10
				  DB "          |  ||_ |/ _ |__| |   /   /\ |  /  /  \|   /\ | /  \|__)",13,10 
				  DB "          |/\||__|\__)|  | |   \__/--\|__\__\__/|__/--\| \__/| \$",13,10
 
	PREVIO_WEIGHT DB "             PREVIOUS WEIGHT ENTERED: $"			  
	PREVIO_QUAN   DB "             PREVIOUS QUANTITY ENTERED: $"
	
	TYPE_STR      LABEL BYTE    
	TYPE_MAXN     DB 2
	TYPE_ACTN     DB ?
	CHOICE        DB 3 DUP("$") 

	WEIGHT_STR    LABEL BYTE    
	WEIGHT_MAXN   DB 2
	WEIGHT_ACTN   DB ?
	WEIGHT        DB 3 DUP("$")

	QUANTITY_STR  LABEL BYTE    
    QUANTITY_MAXN DB 4
    QUANTITY_ACTN DB ?
    QUANTITY      DB 5 DUP("$")    

	

	; DISPWORD
	leadZeroFlag DB ?

	; SUMMARY
	SUMTITLE			DB "                           __                 __                               ",13,10
                        DB "                          (_ /  \|\/||\/| /\ |__)\_/                           ",13,10
                        DB "                          __)\__/|  ||  |/--\| \  |                            $"
	TATXT			    DB "                    +--------------------------------------+                   ",13,10
	                    DB "                               TRANSACTIONS: $"    ; UPDATE HERE AFTER EACH TRANSACTIONS
	TRANSACTS        	DW 0
	OPERAND             DW ?
	OPERATOR            DW ?
	THANKYOU            DB "                                  Thank you!                                   $"
	PRESSKEYCONT        DB "                         <<Press any key to continue>>                         $"   
    STRVERTBAR          DB "                    +--------------------------------------+                   $"
	QUANT DW ?
    COUNT_PURCHARSE DB 0
.CODE
MAIN PROC FAR
    MOV AX,@DATA
    MOV DS,AX
	
    CALL PRINT_LOGO
	
	CALL LOGIN
		
	MENU:
		CALL CLEAR_SCREEN	
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
				INC TRANSACTS ; MOVE THIS TO INSIDE BILLING LATER FOR SUCCESSFUL ONLY

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
			    CALL SUMMARY
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
    ;Setup
    ; Main process
	MOV DX, 0
	MOV CX, 5 ; 5 digits, change along with operand
	MOV operand, 10000
	MOV AL, 1
	MOV leadZeroFlag, AL
	
	; Check if AX is 0 to begin with
    CMP BX, 0
    JNZ DWDIVDISP
    ; If so, print 0
	MOV AH, 02h
	MOV DL, "0"
	INT 21h
	JMP ENDDISPWORD
	
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
    ; Cleanup
    ENDDISPWORD:
        RET
DISPWORD ENDP

; Usage: Control
; Purpose: Display main menu & ask user to select function
; Requirements: None
DISPLAY_MENU PROC
	; DISPLAY MENU
	MOV	DX, OFFSET STRMAINMENU
	MOV	AH, 9
	INT	21H
	; ASK FOR CHOICE
	MOV	AH, 01H ; ASK FOR INPUT
	INT	21H     ; STORE IN AL
	MOV USERMENUCHOICE, AL
	RET
DISPLAY_MENU ENDP

; DISPLAY NEXT-LINE FUNCTION
NEXT_LINE PROC
	MOV 	AH, 02H
	MOV		DL, 0DH		; CR
	INT		21H
	MOV		DL, 0AH		; LF
	INT 	21H
	RET
NEXT_LINE ENDP

DISPLAY_MEAT_MENU PROC	

;-----DISPLAY MEAT MENU
	CALL NEXT_LINE
	CALL NEXT_LINE
	
	MOV AH,09H
	LEA DX,MEAT_MENU
	INT 21H
	
	CALL NEXT_LINE
	RET

DISPLAY_MEAT_MENU ENDP

; LOGIN FUNCTION
LOGIN PROC
;	; Show login prompt
;	;CALL next_line
;	MOV	AH, 09H
;	LEA DX, strRequestPw
;	INT 21H
;
;	CALL LOGIN_CMP_SETUP
;	
;	checkPw:
;	    ; XOR user PW char in BH
;	    XOR BH, xorKey
;	    
;		; Compare each letter
;		CMP BH, BL
;		
;		; if no match, ask user to try again 
;		JNE loginFail
;		
;		; If match, load the next char
;		INC DI
;		INC SI
;		
;		MOV BL, [DI]
;	    MOV BH, [SI]
;		
;		; once reach end, perform final check
;		CMP BL, '$'
;		JNE checkPw
;		CMP BH, 0DH
;		JNE loginFail
;		
;		; If all match, welcome user
;		CALL next_line
;		
;		MOV AH, 09H
;        LEA DX, strLoginSuccess
;        INT 21H
;        
;        CALL next_line
        RET
;        
;
;    ; Ask user to try again
;    loginFail:
;        CALL next_line
;        MOV AH, 09H
;        LEA DX, strLoginFail
;        INT 21H
;        
;        CALL LOGIN_CMP_SETUP
;        JMP checkPw
;         
LOGIN ENDP

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

; PURCHASE FUNCTION
PURCHASE PROC	
	MOV AX,0600H
	MOV BH,00001110B
	MOV CX,0100H			;BLINKING
	MOV DX,0379H
	INT 10H

	MOV AH,09H		;PRINT TITLE
	LEA DX,WEIGHT_TITLE
	INT 21H

	CALL DISPLAY_MEAT_MENU
	
	CALL NEXT_LINE
    
    MEAT_TYPE_INPUT:
	;-----DISPLAY THE INPUT MESSAGE
	MOV AH,09H	
	LEA DX,MSG1		;ENTER THE MEAT TYPE
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
		
		CMP CHOICE[DI],"6"
		JNE CONTPURCH
		RET
		
		CONTPURCH:
			JMP WEIGHT_INPUT

	    	INVALID:
		    	CALL DISP_ERROR
    
        JMP MEAT_TYPE_INPUT

	WEIGHT_INPUT: 
		MOV BH,CHOICE[DI]
		MOV MTYPE,BH
		SUB MTYPE,30H

	;-----ALLOW USER TO ENTER THE WEIGHT OF MEAT
	INPUT_WEIGHT_AGAIN:			
		CALL NEXT_LINE
		CALL NEXT_LINE
		
		MOV AH,09H
		LEA DX,MSG2		        ;ENTER THE WEIGHT (1,3,5KG) :
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
	    
	    MOV AH,09H
		LEA DX,MSG3
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
			   CALL DISP_ERROR
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
	
	CALL NEXT_LINE	
	CALL NEXT_LINE
	;MOV BH,0
	;MOV BL,QUANT
	
	MOV AH,09H
	LEA DX,MSG4
	INT 21H
	
	CALL DISPWORD

	
	;MOV AH,02H
	;MOV DL,QUANT
	;ADD DL,30H
	;INT 21H

	MOV AH, 09H
    LEA DX, MSG5		;DISPLAY UNIT (KG)
    INT 21H	
	
	CALL NEXT_LINE
	CALL NEXT_LINE

	MOV AH,09H
	LEA DX,MSG6		;DO YOU WANNA CONTINUE?
	INT 21H
	
	MOV AH,01H
	INT 21H
	MOV CONFIRMATION,AL
	
	CALL NEXT_LINE
	
	CMP CONFIRMATION,"Y"
	JE YES
	CALL PRESS_KEY_CON
	RET
	
	YES:
		CALL EDITING
		
	CALL NEXT_LINE
	
    RET
PURCHASE ENDP

; BILLING FUNCTION
BILLING PROC 
	MOV AX,0600H
	MOV BH,00001010B
	MOV CX,0100H			;BLINKING
	MOV DX,0379H
	INT 10H
	
	MOV AH,09H		;PRINT TITLE
	LEA DX,TITSTR
	INT 21H
	
	CALL DISPLAY_MEAT_MENU

	CALL NEXT_LINE
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
	LEA DX,MSG5		;KG
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
	CALL NEXT_LINE

	MOV AH,09H
	LEA DX,CURRENCYMENU
	INC COUNT_PURCHARSE
	INT 21H

	AGAIN:	MOV AH,09H
		LEA DX,CURMSG
		INT 21H

		MOV AH,01H
		INT 21H
		MOV CURRENCY,AL

		CMP CURRENCY,"1"
       		JL FALSE2

        	CMP CURRENCY,"2"
	    	JG FALSE2

		CALL NEXT_LINE        

        	JMP AMOUNT_INPUT

	    	FALSE2:
		    	CALL DISP_ERROR
		JMP AGAIN
		
		CALL NEXT_LINE

AMOUNT_INPUT:
		
		MOV AH,09H
		LEA DX,STR3		;PROMPT USER TO INPUT AMOUNT
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

		CALL DISP_ERROR
	           JNE AMOUNT_INPUT

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

		CALL DISP_ERROR
		JMP AMOUNT_INPUT

	
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

		CALL PRESS_KEY_CON
	
	CMP COUNT_PURCHARSE,0
	JE ACTION 
	
	MOV WEIGHT1,0

	ACTION:
		RET
   
BILLING ENDP

; Summary function
SUMMARY PROC
	; Print title
	CALL next_line	
	MOV	AH, 09H
    LEA DX, sumTitle
    INT 21H
    
    CALL next_line
    
    ; Print total actions
    MOV	AH, 09H
    LEA DX, taTxt
    INT 21H

    ; display al (quotient)
    MOV BX, TRANSACTS
    CALL DISPWORD
    
    CALL next_line
    CALL next_line
    
    ; display thank you note
   
    MOV AH, 09H
    LEA DX, STRVERTBAR
    INT 21H
    
    CALL next_line
    
    MOV AH, 09H
    LEA DX, THANKYOU
    INT 21H
    
    ; Press any key to continue
    CALL PRESS_KEY_CON
    
    RET
SUMMARY ENDP 


DISP_ERROR PROC
    CALL NEXT_LINE

	MOV AH,09H
	LEA DX,ERRORM
	INT 21H
	
	CALL NEXT_LINE 
	
    RET
    
DISP_ERROR ENDP

CLEAR_SCREEN PROC
    
    MOV AH,00H    ;06 TO SCROLL & 00 FOR FULLJ SCREEN
    MOV AL,03H
    MOV BH,07    ;ATTRIBUTE 7 FOR BACKGROUND AND 1 FOR FOREGROUND
    MOV CX,0000H    ;STARTING COORDINATES
    MOV DX,184FH    ;ENDING COORDINATES
    INT 10H        ;FOR VIDEO DISPLAY
  
    
    RET  
    
    
CLEAR_SCREEN ENDP    

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

EDITING PROC	
	CALL NEXT_LINE
	
	MOV AH,09H
	LEA DX,MSG7		;EDIT WEIGHT
	INT 21H
	
	CALL NEXT_LINE
	
	MOV AH,09H
	LEA DX,MSG8	;PROMPT MESSAGE
	INT 21H
		
	MOV AH,01H
	INT 21H			;GET USER INPUT
	MOV EDIT_NUM,AL ;PROTECT DATA
	
	CMP EDIT_NUM,"1"
	JB ERROR2
	
	CMP EDIT_NUM,"2"
	JA ERROR2		;COMPARE IF THE INPUT IS 1 OR 2
		
	CMP EDIT_NUM,"1"
	JE CHANGE_WEIGHT
	
	CALL CLEAR_SCREEN
	CALL DISPLAY_MEAT_MENU
	CALL NEXT_LINE
	
	MOV AH,09H
    LEA DX,PREVIO_QUAN
    INT 21H 
   
    MOV AH,09H
    LEA DX,QUANTITY				;YOU WEN TI
    INT 21H 
   
    CALL NEXT_LINE
		   
	MOV AH,09H
	LEA DX,MSG10				;ENTER NEW QUANTITY
	INT 21H
	
	;QTY_INPUT1:
	MOV AH,0AH              ;INPUT STRING
	LEA DX,QUANTITY_STR
	INT 21H
	
	CALL NEXT_LINE
	CALL CHECK_QUANTITY_DIGIT
	
	;CALL NEXT_LINE
	CALL NEXT_LINE
	
	CALL PRESS_KEY_CON

	JMP TEST1
	
	
	;PROCESS FOR EDITING WEIGHT 
	CHANGE_WEIGHT:		
		CALL INPUT_NEW_WEIGHT		
		CMP WEIGHT[DI],"1"		;COMPARE THE INPUT WITH NUMBER 1
		JE OUTPUT
		
		CMP WEIGHT[DI],"3"		;COMPARE THE INPUT WITH NUMBER 3
		JE OUTPUT

		CMP WEIGHT[DI],"5"		;COMPARE THE INPUT WITH NUMBER 5
		JE OUTPUT	

		CALL NEXT_LINE	

		CALL DISP_ERROR
		JMP CHANGE_WEIGHT
		
		OUTPUT:
			CALL DISP_TOT_WGT
			JMP TEST1	
					
	ERROR2:
		CALL DISP_ERROR
		CALL NEXT_LINE
		CALL EDITING

	TEST1:
		RET
EDITING ENDP


DISP_TOT_WGT PROC 
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
	
	CALL NEXT_LINE
	MOV AH,09H
	LEA DX,MSG4		;OUTPUT
	INT 21H
	
	CALL DISPWORD
	;CALL NEXT_LINE
	MOV AH,09H
	LEA DX,MSG5
	INT 21H
	
	CALL NEXT_LINE
	
	CALL PRESS_KEY_CON
	
	CALL NEXT_LINE
	;CALL HI
	
	RET
DISP_TOT_WGT ENDP


;SHANNEN CAN USE THIS(OPTIONAL)
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
	MOV AH,09H
	LEA DX,MSG5
	INT 21H
	
	CALL PRESS_KEY_CON
	
	CALL NEXT_LINE
	;CALL HI
	RET
HI ENDP

INPUT_NEW_WEIGHT PROC
	CALL CLEAR_SCREEN
	CALL DISPLAY_MEAT_MENU
	CALL NEXT_LINE
	
	MOV AH,09H
	LEA DX,PREVIO_WEIGHT
	INT 21H
	
	MOV AH,02H
	MOV DX,WGT
	ADD DX,30H
	INT 21H
	
	MOV AH,09H
	LEA DX,MSG5	;UNIT (KG)
	INT 21H
	
	CALL NEXT_LINE
	
	REENTER_WEIGHT:
		MOV AH,09H	
		LEA DX,MSG9		;PROMPT MESSAGE FOR NEW WEIGHT
		INT 21H		

		MOV AH,0AH     ;INPUT STRING
		LEA DX,WEIGHT_STR
		INT 21H
		
		CMP WEIGHT[0],"1"		;COMPARE THE INPUT WITH NUMBER 1
		JE OUTPUT2;#########################################################
		
		CMP WEIGHT[0],"3"		;COMPARE THE INPUT WITH NUMBER 1
		JE OUTPUT2
		
		CMP WEIGHT[0],"5"		;COMPARE THE INPUT WITH NUMBER 1
		JE OUTPUT2
		
		CALL DISP_ERROR
		CALL NEXT_LINE
		JMP REENTER_WEIGHT
	
	OUTPUT2:
		MOV DI,0
		MOV BL,WEIGHT[DI]
		SUB BL,30H
		MOV BH,0  
		MOV WGT,BX
	
		RET

INPUT_NEW_WEIGHT ENDP

PRESS_KEY_CON PROC
	CALL NEXT_LINE
	
	MOV AH,09H
	LEA DX,PRESSKEYCONT
	INT 21H

	MOV AH,01H
	INT 21H
	
	CALL CLEAR_SCREEN
	
	RET


PRESS_KEY_CON ENDP

CHECK_QUANTITY_DIGIT PROC
	MOV CH,0
	MOV CL,QUANTITY_ACTN
	MOV SI,0
	
	CHECK_DIGIT_HAIZZ:
		
		CMP QUANTITY[SI],47
		JL INVALID2_HAIZZ

		CMP QUANTITY[SI],58
		JG INVALID2_HAIZZ
	
		INC SI
	   

	LOOP CHECK_DIGIT_HAIZZ
	
	JMP RESUME_HAIZZ
	
	INVALID2_HAIZZ:

		   CALL DISP_ERROR
		   CALL NEXT_LINE
		   CALL NEXT_LINE
			
		   MOV AH,09H
		   LEA DX,PREVIO_QUAN
		   INT 21H 
		   
		   MOV AH,09H
		   LEA DX,QUANTITY				;YOU WEN TI
		   INT 21H 
		   
		   CALL NEXT_LINE
		   
		   MOV AH,09H
		   LEA DX,MSG10
		   INT 21H
			
		   ;QTY_INPUT1:
		   MOV AH,0AH              ;INPUT STRING
		   LEA DX,QUANTITY_STR
		   INT 21H
		   
		   CALL CHECK_QUANTITY_DIGIT

	; LOAD CHAR COUNT INTO VAR 
	RESUME_HAIZZ:
	MOV BH,QUANTITY_ACTN
	
	CMP BH,1
	MOV AX,0
	MOV SI,0     
	JE CALQ_HAIZZ  
		 
		 MOV CH,0 
		 MOV CL,QUANTITY_ACTN 
		 DEC CL
		 ;MOV AL,0
		 LP1_HAIZZ:
  
			MOV BL,QUANTITY[SI]
			SUB BL,30H
		MOV BH,0
		ADD AX,BX
				MUL TENDW
		INC SI
	
		LOOP LP1_HAIZZ 
	
	
   CALQ_HAIZZ:
		  MOV BL,QUANTITY[SI]
		  SUB BL,30H 
		  ;MOV AH,0 ;NEW
			  ;ADD AL,BL
		  MOV BH,0
		  ADD AX,BX
		
	MOV QUANT,AX		;TOTAL QUANTITY
	
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
	LEA DX,MSG4		;OUTPUT
	INT 21H
	
	CALL DISPWORD
	
	MOV AH,09H
	LEA DX,MSG5
	INT 21H
	RET


CHECK_QUANTITY_DIGIT ENDP

push_all PROC
   PUSH AX
   PUSH CX
   PUSH DX
   PUSH BX
   ;NOTE: Missing SP
   RET
push_all ENDP

pop_all PROC
   ;NOTE: Missing SP
   POP BX
   POP DX
   POP CX
   POP AX
   RET
pop_all ENDP

END MAIN