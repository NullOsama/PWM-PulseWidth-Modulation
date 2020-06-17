
_main:

;MyProject.c,1 :: 		void main()
;MyProject.c,5 :: 		PWM1_Init(5000);
	BSF         T2CON+0, 0, 0
	BCF         T2CON+0, 1, 0
	MOVLW       249
	MOVWF       PR2+0, 0
	CALL        _PWM1_Init+0, 0
;MyProject.c,6 :: 		PWM1_Set_Duty(0);
	CLRF        FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;MyProject.c,8 :: 		PWM1_Start();
	CALL        _PWM1_Start+0, 0
;MyProject.c,12 :: 		for(duty_cycle = 0; duty_cycle < 256; duty_cycle += 0.1 * 255)
	CLRF        main_duty_cycle_L0+0 
L_main0:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORLW       1
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main5
	MOVLW       0
	SUBWF       main_duty_cycle_L0+0, 0 
L__main5:
	BTFSC       STATUS+0, 0 
	GOTO        L_main1
;MyProject.c,14 :: 		PWM1_Set_Duty(duty_cycle);
	MOVF        main_duty_cycle_L0+0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;MyProject.c,15 :: 		delay_ms(500);
	MOVLW       13
	MOVWF       R11, 0
	MOVLW       175
	MOVWF       R12, 0
	MOVLW       182
	MOVWF       R13, 0
L_main3:
	DECFSZ      R13, 1, 1
	BRA         L_main3
	DECFSZ      R12, 1, 1
	BRA         L_main3
	DECFSZ      R11, 1, 1
	BRA         L_main3
	NOP
;MyProject.c,12 :: 		for(duty_cycle = 0; duty_cycle < 256; duty_cycle += 0.1 * 255)
	MOVF        main_duty_cycle_L0+0, 0 
	MOVWF       R0 
	CALL        _byte2double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       76
	MOVWF       R6 
	MOVLW       131
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	CALL        _double2byte+0, 0
	MOVF        R0, 0 
	MOVWF       main_duty_cycle_L0+0 
;MyProject.c,16 :: 		}
	GOTO        L_main0
L_main1:
;MyProject.c,18 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
