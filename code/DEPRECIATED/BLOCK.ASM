.MODEL SMALL
.STACK 100
.DATA
	
	MSG1 DB "TYPES OF PORK$"
	ASTERISK DB "*************$"
	MSG2 DB "Enter a number (1 to 6): $"
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

.CODE
MAIN PROC

	MOV AX,@DATA
	MOV DS,AX

	;-----DISPLAY THE MENU
	MOV AH,09H
	LEA DX,MSG1
	INT 21H

	MOV AH,09H
	LEA DX,NL
	INT 21H

	MOV AH,09H
	LEA DX,ASTERISK
	INT 21H

	MOV AH,09H
	LEA DX,NL
	INT 21H
	
	MOV AH,09H
	LEA DX,BELLY
	INT 21H

	MOV AH,09H
	LEA DX,NL
	INT 21H

	MOV AH,09H
	LEA DX,LOIN
	INT 21H

	MOV AH,09H
	LEA DX,NL
	INT 21H

	MOV AH,09H
	LEA DX,RIB
	INT 21H

	MOV AH,09H
	LEA DX,NL
	INT 21H

	MOV AH,09H
	LEA DX,SHOULDER
	INT 21H

	MOV AH,09H
	LEA DX,NL
	INT 21H

	MOV AH,09H
	LEA DX,HAM
	INT 21H

	MOV AH,09H
	LEA DX,NL
	INT 21H

	MOV AH,09H
	LEA DX,QUIT
	INT 21H

	MOV AH,09H
	LEA DX,NL
	INT 21H

	MOV AH,09H
	LEA DX,NL
	INT 21H

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
        JNGE ERROR

        CMP CHOICE[DI],"6"
	    JNLE ERROR

        
        JMP WEIGHT_INPUT

	    ERROR:
		    MOV AH,09H
	        LEA DX,NL
	        INT 21H
		    
		    MOV AH,09H
		    LEA DX,ERRORM
		    INT 21H
    
        JMP MEAT_TYPE_INPUT




	;-----ALLOW USER TO ENTER THE WEIGHT OF MEAT
	WEIGHT_INPUT:			
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

        
        MOV SI,0        
        MOV CH,0
	    MOV CL,QUANTITY_STR[SI+1]
	     
	    
	    CMP QUANTITY_STR[SI+1],1
	    JE ONE_DIGIT  
	
	    ;MOV DI,2
	    CMP QUANTITY_STR[SI+1],2
	    JE TWO_DIGIT
	    
	    
	    CMP QUANTITY_STR[SI+1],2
	    JE THREE_DIGIT
	      
	    
	    CMP QUANTITY_STR[SI+1],2
	    JE FOUR_DIGIT
	    
	    
	    
	    ;JB ONE_DIGIT
		;MOV DI,4
		;JMP MULTID
	
	
	ONE_DIGIT:
		MOV DI,0 
		JMP MUL_ONE_BYTE
	
	TWO_DIGIT:
		MOV DI,2
		JMP MUL_ONE_BYTE
		
	THREE_DIGIT:
	    MOV DI,4
	    JMP MUL_ONE_BYTE
	    
	FOUR_DIGIT:
	    MOV DI,6 
	    JMP MUL_ONE_BYTE 
	    
	FIVE_DIGIT:
	    MOV DI,8 
	    JMP MUL_ONE_BYTE      	
		
		
	MUL_ONE_BYTE:
		MOV AH,0H
		MOV AL,QUANTITY[SI]
		SUB AL,30H
		MUL ONE_BYTE_ARR[DI]
		
		;MOV AH,0H
		ADD TOTAL,AX
		MOV DX,0
		MOV AX,TOTAL
		MOV TEMP,AX
		INC SI
		SUB DI,2 
		
	LOOP MUL_ONE_BYTE
		
	    ;MOV BX,TOTAL
	    
	    
        
        MOV AH,09H
	    LEA DX,NL
	    INT 21H
    PROCESS_TOTAL: 
        MUL WGT ;RESULT STOED IN AX

        
        CMP AX,9
        JG  DIVIDE_TEN 
        
        CALL DISPLAY_TOTAL1
        JMP FINISH_PROG 
    
        
        DIVIDE_TEN:  
            CMP AX,99  
            JG DIVIDE_HUNDRED
            MOV AH,0
            DIV TEN 
            
            CALL DISPLAY_TOTAL2
             
            JMP FINISH_PROG
            
            
        DIVIDE_HUNDRED:
                   
            CMP AX,999
                        JG DIVIDE_THOUSAND 
            MOV AH,0 
         
            DIV HUNDRED
            
            CALL DISPLAY_TOTAL3 
            CALL DISPLAY_TOTAL2
         
           
             
            ;JMP FINISH_PROG    
           
    
        DIVIDE_THOUSAND: 
            CMP AX,9999
            JG DIVIDE_TEN_THOUSAND           
            
            MOV AH,09H
	        LEA DX,NL
	        INT 21H
            CALL DISPLAY_TOTAL4
            JMP FINISH_PROG
            
            ;JMP EXIT2
            
        DIVIDE_TEN_THOUSAND:
            
            
        
        ;DISPLAY_TOTAL:
                   
            ;MOV BX,AX
                
            ;MOV AH,09H
		    ;LEA DX,NL
	        ;INT 21H
                
            ;MOV AH,02H
	        ;MOV DL,BL
	        ;ADD DL,30H
	        ;INT 21H 
	            
	        ;MOV AH,02H
	        ;MOV DL,BH
	        ;ADD DL,30H
	        ;INT 21H 
	        
	        ;JMP FINISH_PROG
	        
	    EXIT2:        
            ;MOV BX,AX
                
            MOV AH,09H
		    LEA DX,NL
	        INT 21H
                
            MOV AH,02H
	        MOV DX,AX
	        ADD DX,30H
	        INT 21H 
	            
	        MOV AH,02H
	        ADD DX,30H
	        INT 21H    
     
     	
	FINISH_PROG:	
	        MOV AX,4C00H
	        INT 21H
	
	
MAIN ENDP 
DISPLAY_TOTAL1 PROC
    
    MOV BX,AX
                
    MOV AH,09H
	LEA DX,NL
	INT 21H
                
    MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H 
	                
    
     
    RET
DISPLAY_TOTAL1 ENDP      

DISPLAY_TOTAL2 PROC
    
    MOV BX,AX
                
    MOV AH,09H
	LEA DX,NL
	INT 21H
                
    MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H 
	            
	MOV AH,02H
	MOV DL,BH
	ADD DL,30H
	INT 21H        
    
     
    RET
DISPLAY_TOTAL2 ENDP
DISPLAY_TOTAL3 PROC
    
    MOV BX,AX
                
    
                
    MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H 
	            
	MOV AH,02H
	MOV DL,BH
	ADD DL,30H
	INT 21H        
    
     
    RET
DISPLAY_TOTAL3 ENDP
 
DISPLAY_TOTAL4 PROC
                   
    MOV AH,09H
	LEA DX,NL
	INT 21H
                
    MOV REMAINDER,DX
    MOV QUOTIENT,AX
    
    MOV AH,02H
	MOV DL,AL
	ADD DL,30H
	INT 21H 
	            
	     
    
     
    RET
DISPLAY_TOTAL4 ENDP 


END MAIN

		

	