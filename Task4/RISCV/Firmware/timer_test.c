/*****************************************************************
 Minimal SoC Timer IP Test Program
 Demonstrates:

 1. One-shot mode
 2. Periodic mode
 3. Polling TIMEOUT
 4. Clearing TIMEOUT (Write-1-to-clear)

 Author: Srihari Naidu
*****************************************************************/


#include <stdint.h>

#define TIMER_BASE 0x40000000

#define TIMER_CTRL   (*(volatile uint32_t*)(TIMER_BASE + 0x00))
#define TIMER_LOAD   (*(volatile uint32_t*)(TIMER_BASE + 0x04))
#define TIMER_VALUE  (*(volatile uint32_t*)(TIMER_BASE + 0x08))
#define TIMER_STATUS (*(volatile uint32_t*)(TIMER_BASE + 0x0C))

#define TIMER_EN        (1 << 0)
#define TIMER_MODE      (1 << 1)
#define TIMER_PRESC_EN  (1 << 2)

#define TIMER_TIMEOUT   (1 << 0)

void delay(volatile uint32_t count)
{

    while(count--);

}

void timer_oneshot_test()
{

    printf("\n--- One-Shot Mode Test ---\n");


    // Load value

    TIMER_LOAD = 50000000;


    // Enable timer (one-shot mode)

    TIMER_CTRL = TIMER_EN;



    // Poll timeout

    while(!(TIMER_STATUS & TIMER_TIMEOUT));


    printf("One-shot timeout occurred\n");



    // Clear timeout

    TIMER_STATUS = TIMER_TIMEOUT;



    printf("Timeout cleared\n");


}

void timer_periodic_test()
{

    printf("\n--- Periodic Mode Test ---\n");


    // Load value

    TIMER_LOAD = 20000000;


    // Enable periodic mode

    TIMER_CTRL = TIMER_EN | TIMER_MODE;



    for(int i = 0; i < 5; i++)
    {

        while(!(TIMER_STATUS & TIMER_TIMEOUT));


        printf("Periodic timeout %d\n", i+1);



        // Clear timeout

        TIMER_STATUS = TIMER_TIMEOUT;

    }


}

void timer_prescaler_test()
{

    printf("\n--- Prescaler Mode Test ---\n");


    TIMER_LOAD = 10000;


    // Prescaler divide by 10

    TIMER_CTRL =
        TIMER_EN |
        TIMER_PRESC_EN |
        (9 << 8);



    while(!(TIMER_STATUS & TIMER_TIMEOUT));


    printf("Prescaler timeout occurred\n");


    TIMER_STATUS = TIMER_TIMEOUT;


}

int main()
{


    printf("\nTimer IP Verification Program\n");


    timer_oneshot_test();


    delay(1000000);


    timer_periodic_test();


    delay(1000000);


    timer_prescaler_test();



    printf("\nAll Timer Tests Completed Successfully\n");



    while(1);


    return 0;

}
