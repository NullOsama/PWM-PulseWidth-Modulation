
_main:

;MyProject.c,1 :: 		void main()
;MyProject.c,3 :: 		char D=0;
;MyProject.c,5 :: 		TRISC.RC2=0;
	BCF         TRISC+0, 2 
;MyProject.c,6 :: 		PWM1_Init(5000);
	BSF         T2CON+0, 0, 0
	BCF         T2CON+0, 1, 0
	MOVLW       249
	MOVWF       PR2+0, 0
	CALL        _PWM1_Init+0, 0
;MyProject.c,7 :: 		PWM1_Set_Duty(0);
	CLRF        FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;MyProject.c,8 :: 		PWM1_Start();
	CALL        _PWM1_Start+0, 0
;MyProject.c,10 :: 		ADCON0=1;
	MOVLW       1
	MOVWF       ADCON0+0 
;MyProject.c,11 :: 		ADCON1=14;
	MOVLW       14
	MOVWF       ADCON1+0 
;MyProject.c,12 :: 		ADCON2=0b10010101;
	MOVLW       149
	MOVWF       ADCON2+0 
;MyProject.c,13 :: 		while(1)
L_main0:
;MyProject.c,15 :: 		Go_Done_bit=1;
	BSF         GO_DONE_bit+0, BitPos(GO_DONE_bit+0) 
;MyProject.c,16 :: 		while(Go_Done_bit);
L_main2:
	BTFSS       GO_DONE_bit+0, BitPos(GO_DONE_bit+0) 
	GOTO        L_main3
	GOTO        L_main2
L_main3:
;MyProject.c,17 :: 		z=ADRESL+(ADRESH<<8);
	MOVF        ADRESH+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        ADRESL+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
;MyProject.c,18 :: 		PWM1_Set_Duty(z/4);
	MOVLW       4
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;MyProject.c,19 :: 		}
	GOTO        L_main0
;MyProject.c,20 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
