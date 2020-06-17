void main() 
{

 char duty_cycle;
 PWM1_Init(5000);
 PWM1_Set_Duty(0);

 PWM1_Start();
 
 for(duty_cycle = 0; duty_cycle < 256; duty_cycle++)
 {
  PWM1_Set_Duty(duty_cycle);
  delay_ms(100);
 }
}