#pragma config FOSC = HS        // Oscillator Selection bits (HS oscillator)
#pragma config WDTE = OFF       // Watchdog Timer Enable bit (WDT disabled)
#pragma config PWRTE = OFF      // Power-up Timer Enable bit (PWRT disabled)
#pragma config BOREN = ON       // Brown-out Reset Enable bit (BOR enabled)
#pragma config LVP = OFF        // Low-Voltage (Single-Supply) In-Circuit Serial Programming Enable bit (RB3 is digital I/O, HV on MCLR must be used for programming)
#pragma config CPD = OFF        // Data EEPROM Memory Code Protection bit (Data EEPROM code protection off)
#pragma config WRT = OFF        // Flash Program Memory Write Enable bits (Write protection off; all program memory may be written to by EECON control)
#pragma config CP = OFF         // Flash Program Memory Code Protection bit (Code protection off)


#include <xc.h> // includes device-specific header files

#define _XTAL_FREQ 8000000 // Specify the XTAL crystall FREQ
void main() // The main function
{
TRISB=0X00; // Instruct the MCU that the PORTB pins are used as Output.
PORTB=0X00; // Make all output of RB3 LOW;
while(1) // Get into the Infinie While loop
{
 RB7=1; // LED ON
 __delay_ms(2000); // Wait
 RB7=0; // LED OFF
 __delay_ms(2000); // Wait
}
}// PIC16F887 Configuration Bit Settings