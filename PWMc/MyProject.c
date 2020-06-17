void main()
 {
  char D=0;
  int z;
  TRISC.RC2=0;
  PWM1_Init(5000);
  PWM1_Set_Duty(0);
  PWM1_Start();

  ADCON0=1;
  ADCON1=14;
  ADCON2=0b10010101;
   while(1)
          {
           Go_Done_bit=1;
           while(Go_Done_bit);
           z=ADRESL+(ADRESH<<8);
           PWM1_Set_Duty(z/4);
          }
 }