.MODEL SMALL
.STACK 100
.DATA
	; Extra/Useful Constants
	stub			DB "Stub$"
	TENDW           DW 10
	SIGN            DB "RM $"
	CENTS           DB ".00$"                      
	

    ; Main screen
	logo			DB " __         ______     __  __     ______   ______     ______", 13, 10
					DB "/\ \       /\  __ \   /\ \_\ \   /\  == \ /\  __ \   /\  ___\", 13, 10
					DB "\ \ \____  \ \ \/\ \  \ \  __ \  \ \  _-/ \ \ \/\ \  \ \___  \", 13, 10
					DB " \ \_____\  \ \_____\  \ \_\ \_\  \ \_\    \ \_____\  \/\_____\", 13, 10
					DB "  \/_____/   \/_____/   \/_/\/_/   \/_/     \/_____/   \/_____/", 13, 10, "$"

	strSeparator	DB "===============================================================", 13, 10, "$"
	strWelcome		DB "               Welcome to LOH Pork Sales System", 13, 10, "$"
	strMainWarn		DB " AUTHORIZED USER ONLY. UNAUTHORIZED ACCESS IS AGAINST THE LAW", 13, 10, "$"
	userMenuChoice  DB ?

	; Login
	strRequestPw 	DB "Please enter password: $"
	strLoginSuccess DB "User authorized. Welcome!$"
	strLoginFail 	DB "Incorrect login details. Please try again$"
	strPw			DB "Password$"
	userPw			DB 20           ; Max char
	                DB ?            ; Num of char entered
	                DB 20 DUP(0DH)  ; BUffer for Char entered
	
	; Main menu
	strMainMenu 	DB "===========================Main Menu===========================",13,10
	                DB "1.     Purchase",13,10
	                DB "2.     Billing",13,10
	                DB "3.     Summary",13,10
	                DB "4. 	   Exit",13,10
					DB "Enter your choice: (1-4): ",'$'

	; Login
	loginStub			DB "Login Stub$"


	; Billing
    billStub			DB "Billing Stub$"


	; Purchase
    purcStub			DB "Purchase Stub$"


	; Summary
	sumTitle			DB "Summary", 13, 10, "$"
	taTxt               DB "Total actions: $"    ; UPDATE HERE AFTER EACH LOOP
	tfTxt			    DB "Total figures: $"    ; UPDATE HERE AFTER EACH TRANSACTIONS
	totalActions        DW 0
	totalFigure         DW 0
	operand             DW ?
	operator            DW ?

	;JR
	MSG1 DB "TYPES OF PORK$"
	ASTERISK DB "*************$"
	MSG2 DB "Enter a number (1 to 5): $"
	ERRORM DB "Invalid! Please enter again: $"
	MSG3 DB "Enter the weight (1kg,3kg or 5kg): $"
	MSG4 DB "Enter the quantity: $"
	MSG5 DB "The total weight of $"
	KG DB ".00 kg$"
	NL DB 0AH,0DH,"$"

	BELLY DB "1. PORK BELLY$"
	LOIN DB "2. PORK LOIN$"
	RIB DB "3. PORK RIB$"
	SHOULDER DB "4. PORK SHOULDER$"
	HAM DB "5. HAM$"
	QUIT DB "6. QUIT$"
	
	WEIGHT DB ?
	CHOICE DB ?

	TYPE1M DB "Pork Belly is $"
	TYPE2M DB "Pork Loin is $"
	TYPE3M DB "Pork Rib is $"
	TYPE4M DB "Pork Shoulder is $"
	TYPE5M DB "Ham is $"

	INPUT DB 30 DUP ('$')
	N      DW ?
	COUNT  DW ?
	OUTPUT DB 30 DUP ('$')

	;Shannen
	TITSTR DB "   CALCULATE PRICE OF MEAT$"
	STR DB "Enter weight of meat(KG): $"
	PATTERN DB 30 DUP("="),"$"
	STR1 DB "Enter quantity: $" 
	STR2 DB "Price of meat bought is RM$"
	STR3 DB "Do you wish to continue? (Y=yes,N=no)$"

	TEN DB 10
	HUNDRED DB 100
	WEIGHT1 DB ?
	MPRICE DW ?
	WEIGHTQTY DW ?
	;INPUT DB ?
	QTY DB ?

	PRICEPKG DB 20,18,18,15,21	;ARRAY
	INPUT1 DB 30 DUP ('$')
	N1      DW ?
	COUNT1 DW ?
	OUTPUT1 DB 30 DUP ('$')

    
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    MOV AH, 09H
	LEA DX, logo
	INT 21H
	
	LEA DX, strSeparator
	INT 21H
	
    LEA DX, strWelcome
    INT 21H
    
    LEA DX, strSeparator
	INT 21H
    
    CALL next_line
	
	MOV AH, 09H
    LEA DX, strMainWarn
    INT 21H
    
    CALL next_line	
	
	CALL LOGIN
	
	MENU:
	
	CALL next_line
		CALL display_menu
		
		; check Purchase
		chkPurc:
			CMP userMenuChoice, '1'
			JZ purc
			JNZ chkBill
			
			purc:
				CALL PURCHASE
		; check Bill
		chkBill:
			CMP userMenuChoice, '2'
			JZ bill
			JNZ chkSum
			
			bill:
				CALL BILLING
		; check Sum
		chkSum:
			CMP userMenuChoice, '3'
			JZ sum
			JNZ chkExit
			sum:
				CALL SUMMARY
			
		; end program
		chkExit:
			CMP userMenuChoice, '4'
			JZ exit
			JNZ continue
			exit:
				MOV AX,4C00H
				INT 21H
		continue:
			LOOP 	MENU
    
MAIN ENDP

; display main-menu function
display_menu PROC
	; Display menu
	MOV	DX, OFFSET strMainMenu
	MOV	AH, 9
	INT	21H
	; Ask for choice
	MOV	AH, 01H ; Ask for input
	INT	21H     ; Store in AL
	MOV userMenuChoice, AL
	RET
display_menu ENDP

; display next-line function
next_line PROC
	MOV 	AH, 02H
	MOV		DL, 0DH		; CR
	INT		21H
	MOV		DL, 0AH		; LF
	INT 	21H
	RET
next_line ENDP

; divides and displays content in AX register in 5-digits.
dispax PROC
	MOV DX, 0
	MOV CX, 5
	MOV operand, 10000
	MOV DX, 0
	DIVDISP:
		; divide
		
		DIV operand
		MOV operator, DX
		
		MOV DX, AX
		MOV AH, 02h
		ADD DL, "0"
		INT 21h
		
		MOV AX, operand
		MOV DX, 0
		DIV TENDW
		MOV operand, AX
		MOV AX, operator  

		LOOP DIVDISP
		RET
dispax ENDP

display_meat_menu PROC	

;-----DISPLAY MEAT MENU
	CALL next_line
	
	MOV AH,09H
	LEA DX,MSG1
	INT 21H

	CALL next_line

	MOV AH,09H
	LEA DX,ASTERISK
	INT 21H

	CALL next_line
	
	MOV AH,09H
	LEA DX,BELLY
	INT 21H

	CALL next_line

	MOV AH,09H
	LEA DX,LOIN
	INT 21H

	CALL next_line

	MOV AH,09H
	LEA DX,RIB
	INT 21H

	CALL next_line

	MOV AH,09H
	LEA DX,SHOULDER
	INT 21H

	CALL next_line

	MOV AH,09H
	LEA DX,HAM
	INT 21H

	CALL next_line
	CALL next_line

display_meat_menu ENDP

; Login function
LOGIN PROC
	;; Show login prompt
;	CALL next_line
;	MOV	AH, 09H
;	LEA DX, strRequestPw
;	INT 21H
;
;	CALL LOGIN_CMP_SETUP
;	
;	checkPw:
;		; Compare each letter
;		CMP BH, BL
;		JNE loginFail
;		
;		; if no match, ask user to try 
;		
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
;        CALL next_line
;        
;        CALL LOGIN_CMP_SETUP
;        JMP checkPw
         
LOGIN ENDP

LOGIN_CMP_SETUP PROC
    ; Overwrite buffer
    
    
    ; Get password
	MOV AH, 0AH
	LEA DX, userPw
	INT 21H

	; Compare the string with actual PW, char by char
	LEA DI, strPw
	MOV SI, OFFSET userPw + 2
	CALL next_line
	
	MOV BL, [DI]
	MOV BH, [SI]
	
	RET
LOGIN_CMP_SETUP ENDP  



display_msg PROC

;DISPLAY MESSAGE.
	    CALL next_line

		MOV AH,09H
		LEA DX,MSG5
		INT 21H  
		
		CMP CHOICE,"1"
		JE TYPE1

		CMP CHOICE,"2"
		JE TYPE2

		CMP CHOICE,"3"
		JE TYPE3

		CMP CHOICE,"4"
		JE TYPE4

		CMP CHOICE,"5"
		JE TYPE5

		TYPE1:
			MOV AH,09H
			LEA DX,TYPE1M
			INT 21H
			
			JMP EXIT1
			
		TYPE2:
			MOV AH,09H
			LEA DX,TYPE2M
			INT 21H
			
			JMP EXIT1
			
		TYPE3:
			MOV AH,09H
			LEA DX,TYPE3M
			INT 21H
	
			JMP EXIT1
			
		TYPE4:
			MOV AH,09H
			LEA DX,TYPE4M
			INT 21H
	
			JMP EXIT1
			
		TYPE5:
			MOV AH,09H
			LEA DX,TYPE5M
			INT 21H
		
			JMP EXIT1
				
	EXIT1:
		
		
		;DISPLAY NUMBER CONVERTED TO STRING.
		MOV DX , OFFSET OUTPUT
		MOV AH, 09H
		INT 21H 

		MOV AH,09H
		LEA DX,KG
		INT 21H 
		
		JMP MENU
		
display_msg ENDP



; Purchase function
PURCHASE PROC
	CALL next_line
	
	CALL display_meat_menu

	;CALL input_meat_type
		
	
	;-----DISPLAY THE INPUT MESSAGE
	MOV AH,09H	
	LEA DX,MSG2
	INT 21H
		
	;-----ALLOW USER TO SELECT THE TYPE OF MEAT
	SELECTION:
		MOV AH,01H
		INT 21H
		SUB AL,49
		MOV CHOICE,AL
		MOV BH,0
		MOV BL,CHOICE
		MOV SI,BX
		ADD CHOICE,49
		
		CALL next_line	
		
		CMP CHOICE,"1"
		JNGE ERROR

		CMP CHOICE,"5"
		JNLE ERROR

		JMP VALID

		ERROR:
			MOV AH,09H
			LEA DX,ERRORM
			INT 21H
	

	JMP SELECTION

	;-----ALLOW USER TO ENTER THE WEIGHT OF MEAT
	VALID:
			
			MOV AH,09H
			LEA DX,MSG3		;ENTER THE WEIGHT (1,3,5KG) :
			INT 21H
	

	CONTINUE1:
		MOV AH,01H
		INT 21H
		SUB AL,30H
		MOV WEIGHT,AL

		CALL next_line	

		CMP WEIGHT,1		;COMPARE THE INPUT WITH NUMBER 1
		JE CORRECT
		
		CMP WEIGHT,3		;COMPARE THE INPUT WITH NUMBER 3
		JE CORRECT

		CMP WEIGHT,5		;COMPARE THE INPUT WITH NUMBER 5
		JE CORRECT

		MOV AH,09H
		LEA DX,ERRORM
		INT 21H

	JMP CONTINUE1

	CORRECT:
		MOV AH,09H
		LEA DX,MSG4 ;input quantity
		INT 21H	 

	MOV BX , OFFSET INPUT
    	MOV COUNT , 0

	;CAPTURE NUMBER CHAR BY CHAR. NOTICE CHR(13) WILL BE
	;STORED IN STRING AND COUNTED.

	L1:
		MOV AH , 1    
		INT 21H               ;CAPTURE ONE CHAR FROM KEYBOARD.
		MOV [BX] , AL         ;STORE CHAR IN STRING.
		INC BX 
		INC COUNT
		CMP AL , 0DH
		JNE L1                ;IF CHAR IS NOT "ENTER", REPEAT.           

		DEC COUNT             ;NECESSARY BECAUSE CHR(13) WAS COUNTED.


	;CONVERT STRING TO NUMBER. 
		MOV BX , OFFSET INPUT ;BX POINTS TO THE FIRST CHAR.
		ADD BX,  COUNT        ;NOW BX POINTS ONE CHAR AFTER THE LAST ONE.
		MOV BP, 0             ;BP WILL BE THE NUMBER CONVERTED FROM STRING.
		MOV CX, 0             ;PROCESS STARTS WITH 10^0.
	
	L2:      
	;GET CURRENT POWER OF 10.
		CMP CX, 0
		JE  FIRST_TIME        ;FIRST TIME IS 1, BECAUSE 10^0 = 1.
		MOV AX, 10
		MUL CX                ;CX * 10. NEXT TIME=100, NEXT TIME=1000...
		MOV CX, AX            ;CX == 10^CX.
		JMP L22               ;SKIP THE "FIRST TIME" BLOCK.

	FIRST_TIME:    
		MOV CX, 1             ;FIRST TIME 10^0 = 1.

	L22:    
	;CONVERT CURRENT CHAR TO NUMBER.   
		DEC BX                ;BX POINTS TO CURRENT CHAR.
		MOV AL , [BX]         ;AL = CURRENT CHAR.
		SUB AL , 30H
		;MOV QTY,AL 
		MUL WEIGHT

    
				 ;CONVERT CHAR TO NUMBER.
	;MULTIPLY CURRENT NUMBER BY CURRENT POWER OF 10.
		MOV AH, 0             ;CLEAR AH TO USE AX.
		MUL CX                ;AX * CX = DX:AX. LET'S IGNORE DX.
		ADD BP , AX           ;STORE RESULT IN BP.    
	
	
	;CHECK IF THERE ARE MORE CHARS.    
		DEC COUNT
		CMP COUNT , 0
		JNE L2


	;EXTRACT DIGITS FROM NUMBER ONE BY ONE BY DIVIDING THEM BY 10 AND
	;STORING THE REMAINDERS INTO STACK. WE USE THE STACK BECAUSE THE
	;STACK STORES DATA IN REVERSE ORDER.
		MOV COUNT, 0
		MOV AX, BP            ;AX = NUMBER TO PROCESS.


	L3:
		MOV DX, 0             ;CLEAR DX. NECESSARY FOR DIV.
		MOV CX, 10            ;WILL DIVIDE BY 10.    
		DIV CX                ;DX:AX / 10. RESULT: AX=QUOTIENT, DX=REMAINDER.    
		ADD DL,30H             ;CONVERT DIGIT TO CHAR.
		PUSH DX               ;STORE DIGIT IN STACK.
		INC COUNT
		CMP AX, 0             
		JNE L3                ;IF QUOTIENT != 0, REPEAT.


	;EXTRACT CHARS FROM STACK IN REVERSE ORDER TO BUILD THE NUMBER IN STRING.
		MOV BX, OFFSET OUTPUT
		
	L4:
		POP DX                ;RETRIEVE ONE CHAR.
		MOV [BX], DL          ;STORE CHAR IN STRING.
		INC BX                ;POSITION FOR NEXT CHAR.
		DEC COUNT
		JNZ L4                ;IF ( COUNT != 0 ) REPEAT.     


			
	CALL display_msg

	CALL next_line

	
    RET
PURCHASE ENDP

; Billing function
BILLING PROC 
	CALL next_line

	CALL display_meat_menu
	
	MOV AH,09H		;PRINT PATTERN
	LEA DX,PATTERN
	INT 21H

	CALL next_line
	
	MOV AH,09H		;PRINT TITLE
	LEA DX,TITSTR
	INT 21H

	CALL next_line
	
	MOV AH,09H		;PRINT PATTERN
	LEA DX,PATTERN
	INT 21H

	CALL next_line

	;CALL input_meat_type

	;-----DISPLAY THE INPUT MESSAGE
	MOV AH,09H	
	LEA DX,MSG2
	INT 21H
		
	;-----ALLOW USER TO SELECT THE TYPE OF MEAT
	SELECTION1:
		MOV AH,01H
		INT 21H
		SUB AL,49
		MOV CHOICE,AL
		MOV BH,0
		MOV BL,CHOICE
		MOV SI,BX
		ADD CHOICE,49
		
		CALL next_line	
		
		CMP CHOICE,"1"
		JNGE ERROR1

		CMP CHOICE,"5"
		JNLE ERROR1

		JMP VALID1

		ERROR1:
			MOV AH,09H
			LEA DX,ERRORM
			INT 21H
	

	JMP SELECTION1
	
		VALID1:
			
			MOV AH,09H
			LEA DX,MSG3		;ENTER THE WEIGHT (1,3,5KG) :
			INT 21H
		

	CONTINUE2:
		MOV AH,01H
		INT 21H
		SUB AL,30H
		MOV WEIGHT1,AL

		CMP WEIGHT1,1		;COMPARE THE INPUT WITH NUMBER 1
		JE CORRECT1
		
		CMP WEIGHT1,3		;COMPARE THE INPUT WITH NUMBER 3
		JE CORRECT1

		CMP WEIGHT1,5		;COMPARE THE INPUT WITH NUMBER 5
		JE CORRECT1

		MOV AH,09H
		LEA DX,ERRORM
		INT 21H

	JMP CONTINUE2

	CORRECT1:
		CALL next_line
	
		MOV AH,09H
		LEA DX,MSG4 ;input quantity
		INT 21H	 


	MOV BX , OFFSET INPUT1
	MOV COUNT1 , 0

	L11:
		MOV AH , 1    
		INT 21H               ;CAPTURE ONE CHAR FROM KEYBOARD.
		MOV [BX] , AL         ;STORE CHAR IN STRING.
		INC BX 
		INC COUNT1
		CMP AL , 0DH
		JNE L11                ;IF CHAR IS NOT "ENTER", REPEAT.           

		DEC COUNT1             ;NECESSARY BECAUSE CHR(13) WAS COUNTED.


	;CONVERT STRING TO NUMBER. 
		MOV BX , OFFSET INPUT1 ;BX POINTS TO THE FIRST CHAR.
		ADD BX,  COUNT1        ;NOW BX POINTS ONE CHAR AFTER THE LAST ONE.
		MOV BP, 0             ;BP WILL BE THE NUMBER CONVERTED FROM STRING.
		MOV CX, 0             ;PROCESS STARTS WITH 10^0.
	
	L21:      
	;GET CURRENT POWER OF 10.
		CMP CX, 0
		JE  ST_TIME        ;FIRST TIME IS 1, BECAUSE 10^0 = 1.
		MOV AX, 10
		MUL CX                ;CX * 10. NEXT TIME=100, NEXT TIME=1000...
		MOV CX, AX            ;CX == 10^CX.
		JMP L23               ;SKIP THE "FIRST TIME" BLOCK.

	ST_TIME:    
		MOV CX, 1             ;FIRST TIME 10^0 = 1.

	L23:    
	;CONVERT CURRENT CHAR TO NUMBER.   
		DEC BX                ;BX POINTS TO CURRENT CHAR.
		MOV AL , [BX]         ;AL = CURRENT CHAR.
		SUB AL , 30H
		MUL WEIGHT1
		MUL PRICEPKG[SI]

    
				 ;CONVERT CHAR TO NUMBER.
	;MULTIPLY CURRENT NUMBER BY CURRENT POWER OF 10.
		MOV AH, 0             ;CLEAR AH TO USE AX.
		MUL CX                ;AX * CX = DX:AX. LET'S IGNORE DX.
		ADD BP , AX           ;STORE RESULT IN BP.    
	
	
	;CHECK IF THERE ARE MORE CHARS.    
		DEC COUNT1
		CMP COUNT1 , 0
		JNE L21


	;EXTRACT DIGITS FROM NUMBER ONE BY ONE BY DIVIDING THEM BY 10 AND
	;STORING THE REMAINDERS INTO STACK. WE USE THE STACK BECAUSE THE
	;STACK STORES DATA IN REVERSE ORDER.
		MOV COUNT1, 0
		MOV AX, BP            ;AX = NUMBER TO PROCESS.


	L33:
		MOV DX, 0             ;CLEAR DX. NECESSARY FOR DIV.
		MOV CX, 10            ;WILL DIVIDE BY 10.    
		DIV CX                ;DX:AX / 10. RESULT: AX=QUOTIENT, DX=REMAINDER.    
		ADD DL,30H             ;CONVERT DIGIT TO CHAR.
		PUSH DX               ;STORE DIGIT IN STACK.
		INC COUNT1
		CMP AX, 0             
		JNE L33               ;IF QUOTIENT != 0, REPEAT.


	;EXTRACT CHARS FROM STACK IN REVERSE ORDER TO BUILD THE NUMBER IN STRING.
		MOV BX, OFFSET OUTPUT1
		
	L44:
		POP DX                ;RETRIEVE ONE CHAR.
		MOV [BX], DL          ;STORE CHAR IN STRING.
		INC BX                ;POSITION FOR NEXT CHAR.
		DEC COUNT1
		JNZ L44                ;IF ( COUNT != 0 ) REPEAT.    

	
		CALL next_line	

		MOV AH,09H		;PRINT TOTAL PRICE
		LEA DX,STR2
		INT 21H

		MOV DX , OFFSET OUTPUT1
		MOV AH, 09H
		INT 21H 

		CALL next_line

		MOV AH,09H		;CONTINUE?
		LEA DX,STR3
		INT 21H

		MOV AH,01H		;INPUT CHOICE
		INT 21H
		MOV CHOICE,AL

		MOV AH,09H		;NEW LINE
		LEA DX,NL
		INT 21H
	
	RET
	
	;CALL display_menu

	MOV AX,4C00H
	INT 21H

	CALL next_line
    ;RET
BILLING ENDP

; Summary function
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
    MOV AX, totalActions
    
    CALL dispax
    
    CALL next_line
    
    ; Print total figures
    MOV AH, 09H
    LEA DX, tfTxt
    INT 21H
    
    ;  display "money sign"
    MOV AH, 09H
    LEA DX, SIGN
    INT 21H
    
    ; display al (quotient)
    MOV AX, totalFigure
    
    CALL dispax
    
    ;  display ".00"
    MOV AH, 09H
    LEA DX, CENTS
    INT 21H 
    
    CALL next_line
    CALL next_line
    RET
SUMMARY ENDP

END MAIN
