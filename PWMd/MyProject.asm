
_main:

;MyProject.c,1 :: 		void main()
;MyProject.c,4 :: 		unsigned int duty_cycle = 0;
	CLRF        main_duty_cycle_L0+0 
	CLRF        main_duty_cycle_L0+1 
;MyProject.c,5 :: 		ADCON1 = 14;
	MOVLW       14
	MOVWF       ADCON1+0 
;MyProject.c,6 :: 		ADCON2 = 0b10010101;
	MOVLW       149
	MOVWF       ADCON2+0 
;MyProject.c,9 :: 		PWM1_Init(5000);
	BSF         T2CON+0, 0, 0
	BCF         T2CON+0, 1, 0
	MOVLW       249
	MOVWF       PR2+0, 0
	CALL        _PWM1_Init+0, 0
;MyProject.c,10 :: 		PWM1_Set_Duty(duty_cycle);
	MOVF        main_duty_cycle_L0+0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;MyProject.c,11 :: 		PWM1_Start();
	CALL        _PWM1_Start+0, 0
;MyProject.c,13 :: 		PWM2_Init(5000);
	BSF         T2CON+0, 0, 0
	BCF         T2CON+0, 1, 0
	MOVLW       249
	MOVWF       PR2+0, 0
	CALL        _PWM2_Init+0, 0
;MyProject.c,14 :: 		PWM2_Set_Duty(duty_cycle);
	MOVF        main_duty_cycle_L0+0, 0 
	MOVWF       FARG_PWM2_Set_Duty_new_duty+0 
	CALL        _PWM2_Set_Duty+0, 0
;MyProject.c,15 :: 		PWM2_Start();
	CALL        _PWM2_Start+0, 0
;MyProject.c,17 :: 		while(1)
L_main0:
;MyProject.c,19 :: 		ADCON0 = 0b0000000001;
	MOVLW       1
	MOVWF       ADCON0+0 
;MyProject.c,20 :: 		Go_Done_bit = 1;
	BSF         GO_DONE_bit+0, BitPos(GO_DONE_bit+0) 
;MyProject.c,21 :: 		while(Go_Done_bit);
L_main2:
	BTFSS       GO_DONE_bit+0, BitPos(GO_DONE_bit+0) 
	GOTO        L_main3
	GOTO        L_main2
L_main3:
;MyProject.c,22 :: 		z = ADRESH*256 + ADRESL;
	MOVF        ADRESH+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        ADRESL+0, 0 
	ADDWF       R0, 0 
	MOVWF       FLOC__main+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FLOC__main+1 
	MOVF        FLOC__main+0, 0 
	MOVWF       main_z_L0+0 
	MOVF        FLOC__main+1, 0 
	MOVWF       main_z_L0+1 
;MyProject.c,23 :: 		duty_cycle = (255.0 / 1023) * z;
	MOVF        FLOC__main+0, 0 
	MOVWF       R0 
	MOVF        FLOC__main+1, 0 
	MOVWF       R1 
	CALL        _word2double+0, 0
	MOVLW       208
	MOVWF       R4 
	MOVLW       63
	MOVWF       R5 
	MOVLW       127
	MOVWF       R6 
	MOVLW       124
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	CALL        _double2word+0, 0
	MOVF        R0, 0 
	MOVWF       main_duty_cycle_L0+0 
	MOVF        R1, 0 
	MOVWF       main_duty_cycle_L0+1 
;MyProject.c,24 :: 		if(z == 1023 / 2)
	MOVF        FLOC__main+1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__main9
	MOVLW       255
	XORWF       FLOC__main+0, 0 
L__main9:
	BTFSS       STATUS+0, 2 
	GOTO        L_main4
;MyProject.c,26 :: 		PWM1_Set_Duty(0);
	CLRF        FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;MyProject.c,27 :: 		PWM2_Set_Duty(0);
	CLRF        FARG_PWM2_Set_Duty_new_duty+0 
	CALL        _PWM2_Set_Duty+0, 0
;MyProject.c,28 :: 		}
	GOTO        L_main5
L_main4:
;MyProject.c,29 :: 		else if(z > 1023 / 2)
	MOVF        main_z_L0+1, 0 
	SUBLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__main10
	MOVF        main_z_L0+0, 0 
	SUBLW       255
L__main10:
	BTFSC       STATUS+0, 0 
	GOTO        L_main6
;MyProject.c,31 :: 		PWM1_Set_Duty(2 * (duty_cycle - 128) - 5); // -5 for overflow
	MOVLW       128
	SUBWF       main_duty_cycle_L0+0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	RLCF        FARG_PWM1_Set_Duty_new_duty+0, 1 
	BCF         FARG_PWM1_Set_Duty_new_duty+0, 0 
	MOVLW       5
	SUBWF       FARG_PWM1_Set_Duty_new_duty+0, 1 
	CALL        _PWM1_Set_Duty+0, 0
;MyProject.c,32 :: 		PWM2_Set_Duty(0);
	CLRF        FARG_PWM2_Set_Duty_new_duty+0 
	CALL        _PWM2_Set_Duty+0, 0
;MyProject.c,33 :: 		}
	GOTO        L_main7
L_main6:
;MyProject.c,36 :: 		PWM1_Set_Duty(0);
	CLRF        FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;MyProject.c,37 :: 		PWM2_Set_Duty(2 * (128 - duty_cycle) - 5);
	MOVF        main_duty_cycle_L0+0, 0 
	SUBLW       128
	MOVWF       FARG_PWM2_Set_Duty_new_duty+0 
	RLCF        FARG_PWM2_Set_Duty_new_duty+0, 1 
	BCF         FARG_PWM2_Set_Duty_new_duty+0, 0 
	MOVLW       5
	SUBWF       FARG_PWM2_Set_Duty_new_duty+0, 1 
	CALL        _PWM2_Set_Duty+0, 0
;MyProject.c,38 :: 		}
L_main7:
L_main5:
;MyProject.c,39 :: 		}
	GOTO        L_main0
;MyProject.c,40 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
