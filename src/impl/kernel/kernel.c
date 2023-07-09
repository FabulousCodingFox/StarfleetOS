#include "kernel.h"
#include "debug_print.h"
#include "idt/idt.h"
#include "io/io.h"

void kernel_main(){
    debugPrint_clearScreen();
    debugPrint_println("Starting Kernel...", DEBUGPRINT_PRESET_SUCCESS);

    debugPrint_println("Loading IDT...", DEBUGPRINT_PRESET_LOG);
    idt_init();


    debugPrint_println("Loaded Kernel successfully!", DEBUGPRINT_PRESET_SUCCESS);
}