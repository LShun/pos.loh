.MODEL SMALL
.STACK 100
.DATA
	; EXTRA/USEFUL CONSTANTS
	TENDW           DW 10
	STUB			DB "STUB$"
	SIGN            DB "RM $"
	CENTS           DB ".00$" 
	LINEWIDTH       DB 79

	CONFIRMATION    DB ?
	
    ; MAIN SCREEN
	LOGO			DB "          __         ______     __  __     ______   ______     ______          ", 13, 10
					DB "         /\ \       /\  __ \   /\ \_\ \   /\  == \ /\  __ \   /\  ___\         ", 13, 10
					DB "         \ \ \____  \ \ \/\ \    \ \  _\  \ \  _-/ \ \ \/\ \  \ \___  \        ", 13, 10
					DB "           \/_____/   \/_____/   \/_/\/_/   \/_/     \/_____/   \/_____\       ", 13, 10, '$'
    
	STRSEPARATOR	DB "================================================================================", 13, 10, "$"

	STRWELCOME		DB "                        WELCOME TO LOH PORK SALES SYSTEM", 13, 10, "$"
	STRWELCOMELEN   DW 56
	STRWELCOMECOLOR DB 0BH
	
	STRMAINWARN		 DB "          AUTHORIZED USER ONLY. UNAUTHORIZED ACCESS IS AGAINST THE LAW",13,10, '$'
	STRMAINWARNLEN   DW 70
	STRMAINWARNCOLOR DB 0CH

	USERMENUCHOICE  DB ?

	authorized		DB 0 ; Check if user is authorized. 0 = not, 1 = yes.

	; LOGIN
	    
	strRequestPw 	  DB "   Please enter password: $"
	strRequestPwLEN   DW 26
	strRequestPwCOLOR DB 0EH
	
	strLoginSuccess DB "               User authorized. Welcome!$"
	
	strLoginFail 		DB "   Incorrect login details. $"
	strLoginFailLEN		DW 27
	strLoginFailCOLOR 	DB 0CH

	strPw			DB 22,"$" ;53,37,22,22,18,85,23,1,"$" ; PW Hash
	userPw			DB 20           ; Max char
	                DB ?            ; Num of char entered
	                DB 20 DUP(0DH)  ; BUffer for Char entered
	xorKey          DB "e"
	
	ATTEMPTS			DB 3 ; Must be between 1 and 255
	usrAttempts			DB ?

	authRetry			DB "   Try again: $"
	authRetryLEN		DW 13
	authRetryCOLOR 		DB 0EH

	authFail			DB "   Too many invalid password attempts. Program will now exit.$"
	authFailLEN			DW 61
	authFailCOLOR 		DB 0DH

	; MAIN MENU
	STRMAINMENU 	DB "                                            __                                 ",13,10
                    DB "                        |\/| /\ ||\ |  |\/||_ |\ |/  \                         ",13,10
                    DB "                        |  |/--\|| \|  |  ||__| \|\__/                         ",13,10
	                DB "                    +--------------------------------------+                   ",13,10
	                DB "                    |             0.  EXIT                 |                   ",13,10
	                DB "                    |             1.  PURCHASE             |                   ",13,10
	                DB "                    |             2.  BILLING              |                   ",13,10
	                DB "                    |             3.  SUMMARY              |                   ",13,10
					DB "                    +--------------------------------------+                   ",13,10,'$'
	MMENUCHTXT	    DB "                     ENTER YOUR CHOICE (0-3) : ",'$'
	MMENUCHTXTLEN   DW 45
	MMENUCOLOR      DB 0EH

	; BILLING
    BILLSTUB			DB "BILLING STUB$"

	TITSTR DB 10,13,"                 __  __   __ __   __        __          ___ __  __ ",10,13
		     DB "                |__)|__)|/  |_   /   /\ |  /  /  \|   /\ | /  \|__)",10,13
		     DB "                |   | \ |\__|__  \__/--\|__\__\__/|__/--\| \__/| \$"  

	MYRSTR DB 13,10,"             	    	PRICE OF MEAT BOUGHT IS RM $"
	USDSTR DB 13,10,"                    PRICE OF MEAT BOUGHT IS USD $"
	SGDSTR DB 13,10,"                    PRICE OF MEAT BOUGHT IS SGD $"
	STR2 DB "                    ENTER AMOUNT FOR PAYMENT : $"
	MYRBAL DB "                    THANK YOU! YOUR BALANCE IS RM $"
	USDBAL DB "                    THANK YOU! YOUR BALANCE IS USD $"
	SGDBAL DB "                    THANK YOU! YOUR BALANCE IS SGD $"
	STR3 DB "            Please return to PURCHASE function for input to proceed...$"

	CURRENCYMENU DB "			+---------------------------------+",13,10
		         DB "			|           CURRENCY              |",13,10
		         DB "			+---------------------------------+",13,10
		         DB "			|    1. RINGGIT MALAYSIA (MYR)    |",13,10
		         DB "			|    2. US DOLLAR        (USD)    |",13,10
				 DB "			|    3. SINGAPORE DOLLAR (SGD)    |",13,10
		         DB "			+---------------------------------+$",13,10
		     
	CURMSG DB 13,10,"                    ENTER CHOICE FOR CURRENCY(1-3) : $"

	SIGN1 DB " * $"
	SIGN2 DB " = $"
	TAB DB "             	    	$"
	;TAB1 DB 33 DUP (' '),"$"
	TAB2 DB 2 DUP (' '),"$"
	FOUR DW 4
	THREE DW 3

	PRICEPKG DB 9,10,11,13,8	;ARRAY FOR MEAT PRICE
	MTYPE DB ?
	WEIGHT1 DW ?
	MPRICE DW ?
	TPRICE DW ?
	AMOUNT DW ?
	QTY DB ?
	PRICE DW ?
    	COUNTS DB ?
	CURRENCY DB ?
	USPRICE DW ?
	USREM DW ?
	SGPRICE DW ?
	SGREM DW ?

	INPUT_AMNT LABEL BYTE    
    	AMNT_MAXN DB 6
    	AMNT_ACTN DB ?
    	AMNT DB 7 DUP("$") 


	; PURCHASE
   
	PURCSTUB			DB "PURCHASE STUB$"

	MSG1          DB "                  ENTER A NUMBER (0 TO QUIT) : $"
	ERRORM        DB "                  INVALID! PLEASE ENTER AGAIN! $"
	MSG2          DB "                  ENTER THE WEIGHT (1KG,3KG OR 5KG) : $"
	MSG3          DB "                  ENTER THE QUANTITY (MAX 3 DIGIT) : $"
	MSG4          DB "                  DEAR CUSTOMER, THE TOTAL WEIGHT IS $"
	MSG5          DB ".00 KG$"
	MSG6          DB "                  DO YOU WANT TO EDIT YOUR CHOICE (Y-YES)? $"
	MSG7          DB "                            +--------------+",13,10
				  DB "                            |    CHOICE    |",13,10
				  DB "                            +--------------+",13,10
	              DB "                            | 1.  WEIGHT   |",13,10
	              DB "                            | 2.  QUANTITY |",13,10
		          DB "                            +--------------+$"
	MSG8          DB "                         ENTER A NUMBER (1-2) : $"
	MSG9          DB "                  ENTER NEW WEIGHT (1KG,3KG OR 5KG) : $"
	MSG10         DB "                  ENTER NEW QUANTITY (MAX 3 DIGIT) : $"
	EDIT_NUM      DB ?
	WGT           DW ?
	MEAT_MENU     DB "		+-----------------------------------+------------+",10,13
		          DB "		|           TYPES OF PORK           | PRICE (RM) |",10,13
		          DB "		+-----------------------------------+------------+",10,13
		         DB "		|     1.     PORK BELLY             |        9.00|",10,13
	              DB "		|     2.     PORK LOIN              |       10.00|",10,13
	              DB "		|     3.     PORK RIB               |       11.00|",10,13
	              DB "		|     4.     PORK SHOULDER          |       13.00|",10,13
	              DB "		|     5.     HAM                    |        8.00|",10,13
	              DB "		+-----------------------------------+------------+$",10,13
	WEIGHT_TITLE  	DB 13,10,"                   __  __     ___   __        __          ___ __  __ ",13,10
			DB "              |  ||_ |/ _ |__| |   /   /\ |  /  /  \|   /\ | /  \|__)",13,10 
			DB "              |/\||__|\__)|  | |   \__/--\|__\__\__/|__/--\| \__/| \$",13,10
 
	PREVIO_WEIGHT DB "                  PREVIOUS WEIGHT ENTERED: $"			  
	PREVIO_QUAN   DB "                  PREVIOUS QUANTITY ENTERED: $"
	
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
	TATXT			    DB "                           TRANSACTIONS: $"    ; UPDATE HERE AFTER EACH TRANSACTIONS
	TATXTLEN			DW 41
	TATXTCLR			DB 0AH
	TRANSACTS        	DW 0
	OPERAND             DW ?
	OPERATOR            DW ?
	THANKYOU            DB "                                  Thank you!                                   $"
	PRESSKEYCONT        DB "                         <<Press any key to continue>>                         $"   
    STRVERTBAR          DB "                    +--------------------------------------+                   $"
	QUANT DW ?
    COUNT_PURCHARSE DB 0
.CODE

; Usage: Main Program, Control
; Purpose: Controls program execution
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

	; Initialization
	MOV AL, 0
	MOV authorized, AL
	
	; Print logo
	CALL CLEAR_SCREEN
    CALL PRINT_LOGO
	
	; Ask for login
	CALL LOGIN

	; Check if properly authorized, if not, quit the program
	MOV AL, authorized
	CMP AL, 1
	JNE ENDPROG
	

	; Main menu	
	MENU:
		; Setup
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
				
	; CHECK SUM
	CHKSUM:
		CMP USERMENUCHOICE, '3'
		JZ SUM
		JNZ CHKEXIT
	
	SUM:
		CALL SUMMARY
			
	; END PROGRAM
	CHKEXIT:
		CMP USERMENUCHOICE, '0'
		JZ EXIT
		JNZ CONTINUE
		
	EXIT:
		CALL SUMMARY
		JMP ENDPROG
	
	; Invalid input
	CONTINUE:
		CALL PRINT_LOGO
		LOOP 	MENU
    
	; End the program
	ENDPROG:
		MOV AX,4C00H
		INT 21H

MAIN ENDP

; Usage: Control, Helper
; Purpose: Display main menu & ask user to select function
DISPLAY_MENU PROC
	; DISPLAY MENU
	MOV	DX, OFFSET STRMAINMENU
	MOV	AH, 9
	INT	21H

	; ASK FOR CHOICE
	; Change color
	MOV AH, 09H
	MOV BH, 0
	MOV BL, MMENUCOLOR
	MOV CX, MMENUCHTXTLEN
	INT 10H
	
	; Display message
	MOV AH, 09H
	LEA DX, MMENUCHTXT
	INT 21h
	
	MOV	AH, 01H ; ASK FOR INPUT
	INT	21H     ; STORE IN AL
	MOV USERMENUCHOICE, AL
	RET
DISPLAY_MENU ENDP

; Usage: Login, Control
; Purpose: Authenticates the user before allowing entry
LOGIN PROC
	; Setup
	MOV usrAttempts, 0

	; Change color
	MOV AH, 09H
	MOV BH, 0
	MOV BL, strRequestPwCOLOR
	MOV CX, strRequestPwLEN
	INT 10H

	; Show login prompt
	;CALL next_line
	MOV	AH, 09H
	LEA DX, strRequestPw
	INT 21H

	CALL LOGIN_CMP_SETUP
	
	checkPw:
	    ; XOR user PW char in BH
	    XOR BH, xorKey
	    
		; Compare each letter
		CMP BH, BL
		
		; if no match, ask user to try again 
		JNE loginFail
		
		; If match, load the next char
		INC DI
		INC SI
		
		MOV BL, [DI]
	    MOV BH, [SI]
		
		; once reach end, perform final check
		CMP BL, '$'
		JNE checkPw
		CMP BH, 0DH
		JNE loginFail
		
		; If all match, welcome user
		CALL next_line
		
		MOV AH, 09H
        LEA DX, strLoginSuccess
        INT 21H
        
		; set authorized flag to 1
        MOV BL, 1
		MOV authorized, BL
        JMP ENDLOGIN

    ; Ask user to try again
    loginFail:
		; Change color
		MOV AH, 09H
		MOV BH, 0
		MOV BL, strLoginFailCOLOR
		MOV CX, strLoginFailLEN
		INT 10H

		; Display failure message
        MOV AH, 09H
        LEA DX, strLoginFail
        INT 21H

		INC usrAttempts
		
		; If exceed allowed tries, end process
		MOV BL, usrAttempts
		CMP BL, ATTEMPTS
		JGE ENDLOGIN

		; Otherwise, allow user to retry
		CALL NEXT_LINE
		; Change color
		MOV AH, 09H
		MOV BH, 0
		MOV BL, authRetryCOLOR
		MOV CX, authRetryLEN
		INT 10H

		; Display retry message
        MOV AH, 09H
        LEA DX, authRetry
        INT 21H
        
		CALL LOGIN_CMP_SETUP
        JMP checkPw

	ENDLOGIN:
		CALL NEXT_LINE
		; Change color
		MOV AH, 09H
		MOV BH, 0
		MOV BL, authFailCOLOR ; color
		MOV CX, authFailLEN
		INT 10H

		; Display auth failed message
		MOV AH, 09H
		LEA DX, authFail
		INT 21H
		RET
		
LOGIN ENDP

; Usage: Login, Helper
; Purpose: Accepts user password as setup for authentication process
LOGIN_CMP_SETUP PROC

	; Hide password by changing input color
	; Change color
	MOV AH, 09H
	MOV BH, 0
	MOV BL, 00H ; color
	MOV CH, 0
	MOV CL, userPw[0] ; length
	INT 10H

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

; Usage: Purchase, Billing
; Purpose: Display meat menu
DISPLAY_MEAT_MENU PROC	

	; DISPLAY MEAT MENU
	CALL NEXT_LINE
	CALL NEXT_LINE
	
	MOV AH,09H
	LEA DX,MEAT_MENU
	INT 21H
	
	CALL NEXT_LINE
	RET

DISPLAY_MEAT_MENU ENDP

; PURCHASE FUNCTION
PURCHASE PROC	
	MOV AX,0600H	
	MOV BH,10001001B		;BLINKING
	MOV CX,0100H			;STARTING POINT
	MOV DX,0379H			;ENDING POINT
	INT 10H

	MOV AH,09H				;PRINT "WEIGHT CALCULATOR" TITLE
	LEA DX,WEIGHT_TITLE
	INT 21H

	CALL DISPLAY_MEAT_MENU	
	CALL NEXT_LINE
    
    MEAT_TYPE_INPUT:
		MOV AH,09H	
		LEA DX,MSG1		;PROMPT USER TO ENTER THE MEAT TYPE
		INT 21H
		   
        MOV AH,0AH     	;INPUT THE MEAT TYPE AS STRING
        LEA DX,TYPE_STR
        INT 21H
        
        MOV DI,0
    
        CMP CHOICE[DI],"0"	;COMPARE THE INPUT MEAT TYPE WITH 0
        JL INVALID

        CMP CHOICE[DI],"5"	;COMPARE THE INPUT MEAT TYPE WITH 5
	    JG INVALID			;IF THE INPUT DATA IS NOT WITHIN THE RANGE OF 0 AND 5, IT WILL JUMP TO INVALID
		
		CMP CHOICE[DI],"0"	;COMPARE THE INPUT DATA WITH 0	
		JNE CONTPURCH		;IF NOT ZERO, THE USER WILL BE PROMPTED TO ENTER THE WEIGHT
		
		CALL NEXT_LINE
		CALL PRESS_KEY_CON	;IF IT IS ZERO, THE USER WILL QUIT THE PURCHASE FUNCTION
		RET
		
	CONTPURCH:
		JMP GET_MTYPE

	INVALID:
		CALL NEXT_LINE
		CALL DISP_ERROR		;ERROR MESSAGE WILL BE DISPLAYED
		CALL NEXT_LINE
				
        JMP MEAT_TYPE_INPUT	;THE USER IS REQUIRED TO RE-ENTER VALID MEAT TYPE

	GET_MTYPE: 
		MOV BH,CHOICE[DI]
		MOV MTYPE,BH
		SUB MTYPE,30H

	;-----ALLOW USER TO ENTER THE WEIGHT OF MEAT
	INPUT_WEIGHT:			
		CALL NEXT_LINE
		CALL NEXT_LINE
		
		MOV AH,09H
		LEA DX,MSG2		        ;ENTER THE WEIGHT (1,3,5KG) :
		INT 21H
	
		MOV AH,0AH              ;INPUT WEIGHT AS STRING
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

	JMP INPUT_WEIGHT
	

	QUANTITY_INPUT:	  
		CALL NEXT_LINE
	    CALL NEXT_LINE
		
	    MOV AH,09H				;ENTER QUANTITY
		LEA DX,MSG3
		INT 21H
		
		MOV AH,0AH              ;INPUT QUANTITY AS STRING
        LEA DX,QUANTITY_STR
        INT 21H
	
	    MOV CH,0
	    MOV CL,QUANTITY_ACTN
	    MOV SI,0
	    
	CHECK_DIGIT:
		CMP QUANTITY[SI],48
		JL INVALID2

		CMP QUANTITY[SI],57
		JG INVALID2
	
		INC SI
	
	LOOP CHECK_DIGIT		;LOOP THE ARRAY AND CHECK WHETHER THE INPUT DATA IS DIGIT OR NOT
	    
	JMP RESUME
	    
	INVALID2:
		CALL NEXT_LINE
		CALL DISP_ERROR
		JMP QUANTITY_INPUT
	        	
	; LOAD CHAR COUNT INTO VAR 
	RESUME:
	    MOV BH,QUANTITY_ACTN
	    CMP BH,1	; CHECK IF ONLY 1 NUMBER LEFT
	    MOV AX,0
	    MOV SI,0     
	    JE CALQ  
	         
		MOV CH,0 
		MOV CL,QUANTITY_ACTN 
		DEC CL
	         
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
		MOV BH,0
		ADD AX,BX
		    
		MOV QUANT,AX

		MUL WGT
		MOV WEIGHT1,AX
		MOV BX,AX
	
		CALL NEXT_LINE	
		CALL NEXT_LINE

		MOV AH,09H
		LEA DX,MSG4			;DISPLAY "DEAR CUSTOMER, THE TOTAL WEIGHT IS "
		INT 21H
	
		CALL DISPWORD		;DISPLAY THE TOTAL WEIGHT 

		MOV AH, 09H
		LEA DX, MSG5		;DISPLAY UNIT (KG)
		INT 21H	
		
		CALL NEXT_LINE
		CALL NEXT_LINE

		MOV AH,09H
		LEA DX,MSG6			;DO YOU WANNA CONTINUE?
		INT 21H
	
		MOV AH,01H
		INT 21H				;GET USER INPUT ON EDITING THE CHOICE
		MOV CONFIRMATION,AL
		
		CALL NEXT_LINE
		
		CMP CONFIRMATION,"Y"
		JE YES
		
		CMP CONFIRMATION,"y"
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
	MOV BH,10000011B
	MOV CX,0100H			;BLINKING
	MOV DX,0379H
	INT 10H
	
	MOV AH,09H			;PRINT TITLE
	LEA DX,TITSTR
	INT 21H
	
	CALL DISPLAY_MEAT_MENU

	CALL NEXT_LINE

	CMP WEIGHT1,0
	JE DISPM
	
	JMP PROCEED

	DISPM:
		MOV AH,09H
		LEA DX,STR3
		INT 21H

		;CALL next_line
		
		MOV AH,01H
		INT 21H

		CALL CLEAR_SCREEN
		
		RET

	PROCEED:	
		MOV DH,0
		MOV DL,MTYPE		
		
		;TO SECURE DATA	
		MOV SI,DX
		
		;TO OBTAIN DATA FROM ARRAY
		DEC SI
		MOV AX,WEIGHT1
		MOV BH,0
		MOV BL,PRICEPKG[SI]
		MUL BX
		MOV TPRICE,AX		;TOTAL PRICE

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
										   
		MOV BX,TPRICE		;DISPLAY PRICE
		CALL DISPWORD

		MOV AH,09H
		LEA DX,CENTS		;.00
		INT 21H

		CALL NEXT_LINE
	
		MOV AH,09H
		LEA DX,MYRSTR
		INT 21H

		MOV BX,TPRICE
		CALL DISPWORD

		MOV AH,09H
		LEA DX,CENTS
		INT 21H

		CALL NEXT_LINE
		CALL NEXT_LINE
		;CALL NEXT_LINE

		MOV AH,09H
		LEA DX,CURRENCYMENU
		INC COUNT_PURCHARSE
		INT 21H

	AGAIN:	
		MOV AH,09H
		LEA DX,CURMSG
		INT 21H

		MOV AH,01H			;INPUT CHOICE OF CURRENCY
		INT 21H
		MOV CURRENCY,AL

		CMP CURRENCY,"1"		;CHECK TYPE OF CURRENCY
       		JL FALSE2
		JE AMOUNT_INPUT

		CMP CURRENCY,"3"
	    	JG FALSE2
		JE SGD

		CMP CURRENCY,"2"
		
	USD:
		CALL CHANGE_USD
		JMP AMOUNT_INPUT

	SGD:
		CALL CHANGE_SGD
		JMP AMOUNT_INPUT

	FALSE2:
		CALL NEXT_LINE
		
		MOV AH,09H
		LEA DX,TAB2
		INT 21H
		
		CALL DISP_ERROR
		JMP AGAIN

	AMOUNT_INPUT:
		;CALL NEXT_LINE
		CALL NEXT_LINE

		MOV AH,09H
		LEA DX,STR2			;PROMPT USER TO INPUT AMOUNT
		INT 21H

		MOV AH,0AH			;INPUT AMOUNT
		LEA DX,INPUT_AMNT		
		INT 21H

		MOV CH,0
		MOV CL,AMNT_ACTN
		MOV SI,0
	
		CALL NEXT_LINE

	CHECK_INPUT:
		
		CMP AMNT[SI],48		;VALIDATION
		JB FALSE

		CMP AMNT[SI],57
		JA FALSE
	
		INC SI
	LOOP CHECK_INPUT
	JMP CONT
	    
	FALSE:
		CALL NEXT_LINE

		MOV AH,09H
		LEA DX,TAB2
		INT 21H
		
		CALL DISP_ERROR
		JNE AMOUNT_INPUT

		;CALL NEXT_LINE
	
	CONT:
		MOV BH,AMNT_ACTN

		;CHECK IF ONLY 1 NUMBER LEFT
	    	CMP BH,1		
	    	MOV AX,0
	    	MOV SI,0     
	    	JE CALP  
	       
		;LOOP  
		MOV CH,0 
		MOV CL,AMNT_ACTN 
		DEC CL
		MOV AL,0
	
	LP2:
		MOV BL,AMNT[SI]
		SUB BL,30H
		MOV BH,0
		ADD AX,BX
		MUL TENDW
		INC SI
		
	LOOP LP2 
	    
	CALP:
		;ADD CALC DIGIT INTO BL
	    	MOV BL,AMNT[SI]		
	    	SUB BL,30H
	   	MOV BH,0
	    	ADD AX,BX
		 
   		;STORE AMOUNT
		MOV AMOUNT,AX

		CMP AX,TPRICE
		JAE CALCHG

		MOV AH,09H
		LEA DX,TAB2
		INT 21H
		
		CALL DISP_ERROR
		JMP AMOUNT_INPUT

	CALCHG:
		SUB AX,TPRICE		;CALC CHANGE
		MOV BX,AX

		CMP CURRENCY,"2"
		JE PUSMSG

		CMP CURRENCY,"3"
		JE PSGMSG
		
		MOV AH,09H
		LEA DX,MYRBAL
		INT 21H		
	
		JMP PRINTPRICE

	PUSMSG:
		MOV AH,09H
		LEA DX,USDBAL
		INT 21H
		JMP PRINTPRICE

	PSGMSG:
		MOV AH,09H
		LEA DX,SGDBAL
		INT 21H		

	PRINTPRICE:
		CALL DISPWORD

		MOV AH,09H
		LEA DX,CENTS
		INT 21H

		; Increase transactions made
		INC TRANSACTS ; MOVE THIS TO INSIDE BILLING LATER FOR SUCCESSFUL ONLY
		
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
    
	; Print bar (decoration)
	MOV AH, 09H
    LEA DX, STRVERTBAR
    INT 21H

    ; Change color
	MOV AH, 09H
	MOV BH, 0
	MOV BL, TATXTCLR
	MOV CX, TATXTLEN
	INT 10H

	; Print total actions
    MOV	AH, 09H
    LEA DX, taTxt
    INT 21H

    ; display al (quotient)
    MOV BX, TRANSACTS
    CALL DISPWORD
    
    CALL next_line
    CALL next_line

    ; Print bar (decoration)
	MOV AH, 09H
    LEA DX, STRVERTBAR
    INT 21H
    
    CALL next_line
    
	; display thank you note
    MOV AH, 09H
    LEA DX, THANKYOU
    INT 21H
    
    ; Press any key to continue
    CALL PRESS_KEY_CON
    
    RET
SUMMARY ENDP 


DISP_ERROR PROC
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

; Usage: Display, Decoration, Main Program
; Purpose: Works as splash screen. Displays "LOH Sales System" logo, as well as general important information.
PRINT_LOGO PROC
	MOV AH, 09H
	LEA DX, LOGO
	INT 21H
	
	LEA DX, STRSEPARATOR
	INT 21H
	
	; Change color
	MOV AH, 09H
	MOV BH, 0
	MOV BL, STRWELCOMECOLOR
	MOV CX, STRWELCOMELEN
	INT 10H

    LEA DX, STRWELCOME
    INT 21H
    
    LEA DX, STRSEPARATOR
	INT 21H
	
	CALL NEXT_LINE
	
	; Change color
	MOV AH, 09H
	MOV BH, 0
	MOV BL, STRMAINWARNCOLOR
	MOV CX, STRMAINWARNLEN
	INT 10H

	MOV AH, 09H
    LEA DX, STRMAINWARN
    INT 21H
    
    CALL NEXT_LINE
	
	RET

PRINT_LOGO ENDP

EDITING PROC	
	CALL NEXT_LINE
	
	MOV AH,09H
	LEA DX,MSG7		;DISPLAY TABLE FOR SELECTION
	INT 21H
	
	CALL NEXT_LINE
	
	MOV AH,09H
	LEA DX,MSG8		;ENTER A NUMBER (1-2):
	INT 21H
		
	MOV AH,01H
	INT 21H			;GET USER INPUT
	MOV EDIT_NUM,AL ;PROTECT DATA
	
	CALL NEXT_LINE
	
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
    LEA DX,PREVIO_QUAN		;PREVIOUS QUANTITY ENTERED IS (MESSAGE)
    INT 21H 
   
    MOV AH,09H
    LEA DX,QUANTITY			;DISPLAY THE PREVIOUS QUANTITY ENTERED (IN NUMBER)	
    INT 21H 
   
    CALL NEXT_LINE
		   
	MOV AH,09H
	LEA DX,MSG10			;ENTER NEW QUANTITY
	INT 21H
	
	MOV AH,0AH              ;INPUT NEW QUANTITY AS STRING
	LEA DX,QUANTITY_STR
	INT 21H
	
	CALL NEXT_LINE
	CALL CHECK_QUANTITY_DIGIT
	
	CALL NEXT_LINE
	
	CALL PRESS_KEY_CON

	JMP RETURN_EDIT
	
	
	;PROCESS FOR EDITING WEIGHT 
	CHANGE_WEIGHT:		
		CALL INPUT_NEW_WEIGHT		
		CALL DISP_TOT_WGT
		JMP RETURN_EDIT	
					
	ERROR2:
		CALL DISP_ERROR
		CALL NEXT_LINE
		CALL EDITING

	RETURN_EDIT:
		RET
		
EDITING ENDP


DISP_TOT_WGT PROC 
	MOV DH,0
	MOV DL,MTYPE
	
	MOV SI,DX
	DEC SI
	MOV AX,WGT
	MOV DX,0 
	MOV BX,QUANT
	MUL BX
	
	MOV WEIGHT1,AX	;TOTAL WEIGHT
								   
	MOV BX,AX
	
	CALL NEXT_LINE
	MOV AH,09H
	LEA DX,MSG4		;DEAR CUSTOMER, THE TOTAL WEIGHT IS
	INT 21H
	
	CALL DISPWORD
	MOV AH,09H
	LEA DX,MSG5		;UNIT(.00KG)
	INT 21H
	
	CALL NEXT_LINE
	
	CALL PRESS_KEY_CON
	
	CALL NEXT_LINE
	
	RET
DISP_TOT_WGT ENDP

INPUT_NEW_WEIGHT PROC
	CALL CLEAR_SCREEN
	CALL DISPLAY_MEAT_MENU
	CALL NEXT_LINE
	
	MOV AH,09H
	LEA DX,PREVIO_WEIGHT	;PREVIOUS WEIGHT ENTERED (MESSAGE)
	INT 21H
	
	MOV AH,02H
	MOV DX,WGT			;DISPLAY THE PREVIOUS WEIGHT ENTERED (IN NUMBER)
	ADD DX,30H
	INT 21H
	
	MOV AH,09H
	LEA DX,MSG5	;UNIT (.00 KG)
	INT 21H
	
	CALL NEXT_LINE
	
	REENTER_WEIGHT:
		MOV AH,09H	
		LEA DX,MSG9		;PROMPT MESSAGE FOR NEW WEIGHT
		INT 21H		

		MOV AH,0AH     	;OVERWRITE THE PREVIOUS WEIGHT (STRING)
		LEA DX,WEIGHT_STR
		INT 21H
		
		CMP WEIGHT[0],"1"		;COMPARE THE INPUT WITH NUMBER 1
		JE OUTPUT2
		
		CMP WEIGHT[0],"3"		;COMPARE THE INPUT WITH NUMBER 1
		JE OUTPUT2
		
		CMP WEIGHT[0],"5"		;COMPARE THE INPUT WITH NUMBER 1
		JE OUTPUT2
		
		CALL NEXT_LINE
		CALL DISP_ERROR
		CALL NEXT_LINE
		JMP REENTER_WEIGHT
	
	OUTPUT2:
		MOV DI,0
		MOV BL,WEIGHT[DI]
		SUB BL,30H
		MOV BH,0  
		MOV WGT,BX		;STORE NEW WEIGHT
	
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
	CHECK_QUAN_DI:
		MOV CH,0
		MOV CL,QUANTITY_ACTN
		MOV SI,0
	
	CHECK_DIGIT2:
		CMP QUANTITY[SI],47
		JL INVALID3

		CMP QUANTITY[SI],58
		JG INVALID3
	
		INC SI
	LOOP CHECK_DIGIT2
	
	JMP RESUME2
	
	INVALID3:
		CALL DISP_ERROR
		CALL NEXT_LINE
		   
		MOV AH,09H
		LEA DX,MSG10			;ENTER NEW QUANTITY
		INT 21H

		MOV AH,0AH              
		LEA DX,QUANTITY_STR		;INPUT NEW QUANTITY AS STRING
		INT 21H
		 
		CALL NEXT_LINE
		JMP CHECK_QUAN_DI

	; LOAD CHAR COUNT INTO VAR 
	RESUME2:
		MOV BH,QUANTITY_ACTN
	
		CMP BH,1
		MOV AX,0
		MOV SI,0     
		JE CALQ2 
		 
		MOV CH,0 
		MOV CL,QUANTITY_ACTN 
		DEC CL

	LP3:
		MOV BL,QUANTITY[SI]
		SUB BL,30H
		MOV BH,0
		ADD AX,BX
		MUL TENDW
		INC SI

	LOOP LP3 
	
   CALQ2:
		MOV BL,QUANTITY[SI]
		SUB BL,30H 
		MOV BH,0
		ADD AX,BX
		
		MOV QUANT,AX		;TOTAL QUANTITY
		
		MOV DH,0
		MOV DL,MTYPE
		
		MOV SI,DX
		DEC SI
		MOV AX,WGT
		MOV DX,0 

		MOV BX,QUANT
		MUL BX
	
		MOV WEIGHT1,AX	;TOTAL WEIGHT
									   
		MOV BX,AX
		
		CALL NEXT_LINE
		MOV AH,09H
		LEA DX,MSG4		;OUTPUT
		INT 21H
		
		CALL DISPWORD
	
		MOV AH,09H
		LEA DX,MSG5
		INT 21H
		
		RET

CHECK_QUANTITY_DIGIT ENDP

; Usage: General purpose
; Purpose: Display 5 digit integers (up to 65,535)
; WARNING: Save all contents of registers to proper variables before calling function
DISPWORD PROC
    ; Main process
	MOV DX, 0
	MOV CX, 5 ; 5 digits, change along with operand
	MOV operand, 10000
	
	; Setup
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
		
		; set no longer leading zero
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

; Usage: General, Display
; Purpose: Display a newline
NEXT_LINE PROC
	MOV 	AH, 02H
	MOV		DL, 0DH		; CR
	INT		21H
	MOV		DL, 0AH		; LF
	INT 	21H
	RET
NEXT_LINE ENDP

CHANGE_USD PROC

	MOV AX,TPRICE

	;FOR 2BYTE DIVISION
	MOV DX,1
	MUL DX
	DIV FOUR
			
	MOV USPRICE,AX
	MOV USREM,DX

	CMP USREM,2
	JGE ROUNDUP1
	JMP USNEXT
	
	ROUNDUP1:
		INC USPRICE
			
	USNEXT:		
		MOV AH,09H
		LEA DX,USDSTR
		INT 21H				
	
		MOV BX,USPRICE
		CALL DISPWORD

		MOV AH,09H
		LEA DX,CENTS		;.00
		INT 21H

		MOV BX,USPRICE
		MOV TPRICE,BX

		CALL NEXT_LINE
		RET		
		
CHANGE_USD ENDP

CHANGE_SGD PROC
	MOV AX,TPRICE
	MOV DX,1
	MUL DX
	DIV THREE
			
	MOV SGPRICE,AX
	MOV SGREM,DX

	CMP SGREM,2
	JGE ROUNDUP2
	JMP SGNEXT
	
	ROUNDUP2:
		INC SGPRICE


	SGNEXT:
		MOV AH,09H
		LEA DX,SGDSTR
		INT 21H
				
		MOV BX,SGPRICE
		CALL DISPWORD

		MOV AH,09H
		LEA DX,CENTS	
		INT 21H

		MOV BX,SGPRICE
		MOV TPRICE,BX

		CALL NEXT_LINE
		RET

CHANGE_SGD ENDP

END MAIN