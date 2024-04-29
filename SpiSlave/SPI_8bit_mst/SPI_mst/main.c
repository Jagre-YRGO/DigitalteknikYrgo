
//typedef unsigned char uint8_t;
//static volatile uint8_t* const spcr = (volatile uint8_t*)(0x4C);
//#define SPCR *spcr

# define F_CPU 16000000UL


#include  <avr/io.h>
#include <util/delay.h>

uint8_t spi_write(uint8_t d){
	SPDR = d;				//write data
	
	/* Wait for transmission complete */
	while(!(SPSR & (1<<SPIF)));
	
	
	return SPDR; //return received value
}



int main(void)
{
	
	/* Set MOSI, SCK and SS output, all others input */
	DDRB |= (1<< 5) | (1 << 3) | (1 << 2) | (1 << 0); //SCK as output and MOSI as output and SS as outpu - orginal
	/* Enable SPI, Master, set clock rate fck/16 */
	SPCR = (1<<SPE)|(1<<MSTR)|(1<<SPR0);
	
	uint8_t cnt = 0;
	
    while (1) 
    {
		PORTB &= ~_BV(PORTB2);	//set ss low
		(void)spi_write(cnt); 
		PORTB |= _BV(PORTB2);	//set ss High

		cnt++;
		
		_delay_ms(100);
		
    }
}

