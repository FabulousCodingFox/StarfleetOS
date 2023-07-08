#include "kernel.h"
#include "debug_print.h"

void kernel_main(){
    debugPrint_clearScreen();
    int successColor = debugPrint_colorBuilder(DEBUGPRINT_COLOR_GREEN, DEBUGPRINT_COLOR_BLACK);
    //int errorColor = debugPrint_colorBuilder(DEBUGPRINT_COLOR_WHITE, DEBUGPRINT_COLOR_DARK_RED);
    //int logColor = debugPrint_colorBuilder(DEBUGPRINT_COLOR_DARK_WHITE, DEBUGPRINT_COLOR_BLACK);

    debugPrint_println("Starting Kernel...", successColor);
}