.MODEL SMALL
.STACK 100
.DATA
	; Extra/Useful Constants
	stub			DB "Stub$"
	TENDW           DW 10
	SIGN            DB "RM $"                      
	

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
	strLoginFail 	DB "Incorrect login details. Try again: $"
	strPw			DB 53,37,22,22,18,85,23,1,"$" ; PW Hash
	userPw			DB 20           ; Max char
	                DB ?            ; Num of char entered
	                DB 20 DUP(0DH)  ; BUffer for Char entered
	xorKey          DB "e"           
	
	; Main menu
	strMainMenu 	DB "===========================Main Menu===========================",13,10
	                DB "1.     Purchase",13,10
	                DB "2.     Billing",13,10
	                DB "3.     Summary",13,10
	                DB "4. 	   Exit",13,10
					DB "Enter your choice: (1-4): ",'$'


	; Billing
    billStub			DB "Billing Stub$"


	; Purchase
    purcStub			DB "Purchase Stub$"


	; Summary
	sumTitle			DB "Summary", 13, 10, "$"
	taTxt               DB "Total actions: $"    ; UPDATE HERE AFTER EACH LOOP
	tfTxt			    DB "Total figures: $"    ; UPDATE HERE AFTER EACH TRANSACTIONS
	totalActions        DW 2
	totalCash           DW 2243
	totalCoins          DB 53
	operand             DW ?
	operator            DW ?
    
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
;
; divides and displays content in a DW/?X register, max is 4 digits.
DISPWORD PROC
	MOV DX, 0
	MOV CX, 4
	MOV operand, 1000
	MOV BX, totalActions
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

; divides and displays content in a DB/?H/L register, max is 2 digits.
DISPBYTE PROC
	MOV DX, 0
	MOV CX, 2
	MOV operand, 10
	MOV BL, totalCoins
	DIVDISPDB:
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

		LOOP DIVDISPDB
		
		RET
DISPBYTE ENDP

; Login function
LOGIN PROC
	; Show login prompt
	CALL next_line
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
        
        CALL next_line
        RET
        

    ; Ask user to try again
    loginFail:
        CALL next_line
        MOV AH, 09H
        LEA DX, strLoginFail
        INT 21H
        
        CALL LOGIN_CMP_SETUP
        JMP checkPw
         
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
    
    CALL DISPWORD
    
    CALL next_line
    
;    ; Print total figures
;    MOV AH, 09H
;    LEA DX, tfTxt
;    INT 21H
;    
;    ;  display "money sign"
;    MOV AH, 09H
;    LEA DX, SIGN
;    INT 21H
;    
;    ; display al (quotient)
;    MOV AX, totalCash
;    
;    CALL DISPWORD
;    
;    MOV AH, 02H
;    MOV DL, '.'
;    INT 21H
;    
;    MOV  AL, totalCoins
;    
;    CALL DISPBYTE
    
    CALL next_line
    CALL next_line
    RET
SUMMARY ENDP

END MAIN
