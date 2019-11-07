.MODEL SMALL
.STACK 100
.DATA
	; Extra
	stub			DB "Stub$"

    ; Main screen
	strWelcome		DB "Welcome to LOH Pork Sales System$"
	strMainWarn		DB "AUTHORIZED USER ONLY. UNAUTHORIZED ACCESS IS AGAINST THE LAW$"
	userMenuChoice  DB ?

	; Login
	strRequestPw 	DB "Please enter password: $"
	strLoginSuccess DB "User authorized. Welcome!$"
	strLoginFail 	DB "Incorrect login details. Please try again$"
	strLoginDenied  DB "Wrong login too many times, check with support.$"
	strPw			DB "123$"
	userPw			DB ?
	
	; Main menu
	strMainMenu 	DB "====Main Menu====",13,10
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
	sumStub				DB "Summary Stub$"
	totalActions    DB 0
	totalFigure     DW 0
    
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    ; Put the rest of your code here
    MOV AH, 09H
    LEA DX, strWelcome
    INT 21H
    
    CALL next_line
	
	MOV AH, 09H
    LEA DX, strMainWarn
    INT 21H
    
    CALL next_line	
	
	CALL LOGIN
	
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
		LOOP 	MAIN
    
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

; Login function
LOGIN PROC
	CALL next_line
	MOV	AH, 09H
	LEA DX, strRequestPw
	INT 21H
    	
	CALL next_line
	RET
LOGIN ENDP

; Purchase function
PURCHASE PROC
	CALL next_line
		
	MOV	AH, 09H
    LEA DX, purcStub
    INT 21H

	CALL next_line
    RET
PURCHASE ENDP

; Billing function
BILLING PROC 
	CALL next_line
		
	MOV	AH, 09H
    LEA DX, billStub
    INT 21H

	CALL next_line
    RET
BILLING ENDP

; Summary function
SUMMARY PROC
	CALL next_line
		
	MOV	AH, 09H
    LEA DX, sumStub
    INT 21H

	CALL next_line
    RET
SUMMARY ENDP

END MAIN
