void main()
{
 unsigned int z;
 unsigned int duty_cycle = 0;
 ADCON1 = 14;
 ADCON2 = 0b10010101;


 PWM1_Init(5000);
 PWM1_Set_Duty(duty_cycle);
 PWM1_Start();
 
 PWM2_Init(5000);
 PWM2_Set_Duty(duty_cycle);
 PWM2_Start();
 
 while(1)
 {
   ADCON0 = 0b0000000001;
   Go_Done_bit = 1;
   while(Go_Done_bit);
   z = ADRESH*256 + ADRESL;
   duty_cycle = (255.0 / 1023) * z;
   if(z == 1023 / 2)
   {
    PWM1_Set_Duty(0);
    PWM2_Set_Duty(0);
   }
   else if(z > 1023 / 2)
   {
    PWM1_Set_Duty(2 * (duty_cycle - 128) - 5); // -5 for overflow
    PWM2_Set_Duty(0);
   }
   else
   {
    PWM1_Set_Duty(0);
    PWM2_Set_Duty(2 * (128 - duty_cycle) - 5);
   }
 }
}