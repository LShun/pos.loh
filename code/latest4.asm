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

	TYPE1M DB "Pork Belly is $"
	TYPE2M DB "Pork Loin is $"
	TYPE3M DB "Pork Rib is $"
	TYPE4M DB "Pork Shoulder is $"
	TYPE5M DB "Ham is $"

	INPUT DB 30 DUP ('$')
	N      DW ?
	COUNT  DW ?
	OUTPUT DB 30 DUP ('$')

	TYPE_STR LABEL BYTE    
    	TYPE_MAXN DB 2
    	TYPE_ACTN DB ?
    	CHOICE DB 3 DUP("$") 
    
    	WEIGHT_STR LABEL BYTE    
    	WEIGHT_MAXN DB 2
    	WEIGHT_ACTN DB ?
    	WEIGHT DB 3 DUP("$")

	QUANTITY_STR LABEL BYTE    
    	QUANTITY_MAXN DB 5
    	QUANTITY_ACTN DB ?
    	QUANTITY DB 6 DUP("$")    


	WGT DW ?
    	TEN DB 10  
   	HUNDRED DB 100
    	THOUSAND DW 1000
    	HUND_THOUSAND DW 10000 
    	TEMP DW ?
    	TOTAL DW ? 
	
	ONE_BYTE_ARR DW 1,10,100,1000,10000
	;TWO_BYTE_ARR DW  
	
	ERROR2 DB "The result is too big!"   
	CHECK DW ?    
	
	QUOTIENT DW ?
	REMAINDER DW ? 
	QUANT DW ?

	;Shannen
	TITSTR DB "   CALCULATE PRICE OF MEAT$"
	STR DB "Enter weight of meat(KG): $"
	PATTERN DB 30 DUP("="),"$"
	STR1 DB "Enter quantity: $" 
	STR2 DB "Price of meat bought is RM$"
	STR3 DB "Do you wish to continue? (Y=yes,N=no)$"

	;TEN DB 10
	;HUNDRED DB 100
	WEIGHT1 DW ?
	MPRICE DW ?
	WEIGHTQTY DW ?
	;INPUT DB ?
	QTY DB ?
	PRICE DW ?
    	COUNTS DB ?
	PRICEPKG DB 20,18,18,15,21	;ARRAY
	INPUT1 DB 30 DUP ('$')
	N1      DW ?
	COUNT1 DW ?
	OUTPUT1 DB 30 DUP ('$')
	MTYPE DB ?

    
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

DISPWORD PROC
	MOV DX, 0
	MOV CX, 5
	MOV operand, 10000
	DIVDISPDW:
		; divide
		MOV AX, BX
		DIV operand
		MOV operator, DX

		CMP AX, 0
		JZ CONTDISPWORD
		
		MOV DX, AX
		MOV AH, 02h
		ADD DL, "0"
		INT 21h
		
		CONTDISPWORD:
    		MOV AX, operand
    		MOV DX, 0
    		DIV TENDW
    		MOV operand, AX
    		MOV AX, operator
    		MOV BX, AX  

		LOOP DIVDISPDW
		
		RET
DISPWORD ENDP

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

	;-----DISPLAY THE INPUT MESSAGE
	MOV AH,09H	
	LEA DX,MSG2
	INT 21H
		
	;-----ALLOW USER TO SELECT THE TYPE OF MEAT
    MEAT_TYPE_INPUT:
        MOV AH,0AH     ;INPUT STRING
        LEA DX,TYPE_STR
        INT 21H
        
        MOV DI,0
    
        CMP CHOICE[DI],"1"
        JL ERROR

        CMP CHOICE[DI],"6"
	JGE ERROR

        
        JMP WEIGHT_INPUT

	    	ERROR:
		    	MOV AH,09H
	        	LEA DX,NL
	        	INT 21H
		    
		    	MOV AH,09H
		    	LEA DX,ERRORM
		    	INT 21H
    
        JMP MEAT_TYPE_INPUT

	WEIGHT_INPUT:
		MOV BH,CHOICE[DI]
		MOV MTYPE,BH
		SUB MTYPE,30H
		DEC MTYPE


	;-----ALLOW USER TO ENTER THE WEIGHT OF MEAT
				
		MOV AH,09H
	    	LEA DX,NL
	    	INT 21H
		
		MOV AH,09H
		LEA DX,MSG3		        ;ENTER THE WEIGHT (1,3,5KG) :
		INT 21H
	
		
	INPUT_WEIGHT_AGAIN:
		MOV AH,0AH              ;INPUT STRING
        	LEA DX,WEIGHT_STR
        	INT 21H
        
        	MOV DI,0
        	MOV BL,WEIGHT[DI] 
        	SUB BL,30H  
        	MOV WGT,BX

		CMP WEIGHT[DI],"1"		;COMPARE THE INPUT WITH NUMBER 1
		JE QUANTITY_INPUT
		
		CMP WEIGHT[DI],"3"		;COMPARE THE INPUT WITH NUMBER 3
		JE QUANTITY_INPUT

		CMP WEIGHT[DI],"5"		;COMPARE THE INPUT WITH NUMBER 5
		JE QUANTITY_INPUT

		MOV AH,09H
	    	LEA DX,NL
	    	INT 21H
		
		MOV AH,09H
		LEA DX,ERRORM
		INT 21H

	JMP INPUT_WEIGHT_AGAIN
	
	
	QUANTITY_INPUT:	
	    
	    MOV AH,09H
	    LEA DX,NL
	    INT 21H
	    
	    MOV AH,09H
		LEA DX,MSG4
		INT 21H
		
		;QTY_INPUT1:
		MOV AH,0AH              ;INPUT STRING
        LEA DX,QUANTITY_STR
        INT 21H
	
	; LOAD CHAR COUNT INTO VAR 
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
			    ADD AL,BL
                MUL TEN
			    INC SI
		
		    LOOP LP1 
	    
	    
	   CALQ:
	          MOV BL,QUANTITY[SI]
		      SUB BL,30H 
		      ;MOV AH,0 ;NEW
	          ADD AL,BL
		    
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
	;MOV WEIGHT1,AX
	
	
	MOV BX,AX
	
	CALL next_line	

	;MOV BH,0
	;MOV BL,QUANT
	
	CALL DISPWORD

	;MOV AH,02H
	;MOV DL,QUANT
	;ADD DL,30H
	;INT 21H	
	

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
	
	CALL next_line

	MOV DH,0
	MOV DL,MTYPE
	MOV SI,DX
	MOV AX,WEIGHT1
	MUL PRICEPKG[SI]

	;MUL PRICEPKG[SI]
	;MOV MPRICE,AX
	;DIV PRICEPKG[SI]

	MOV BX,AX
	
	
	CALL DISPWORD	
	
	RET
	
	;CALL display_menu

	CALL next_line
   
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
