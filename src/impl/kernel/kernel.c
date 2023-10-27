#include "kernel.h"
#include "debug_print.h"
#include "idt.h"
#include "io.h"
#include "kheap.h"

void kernel_main(){
    debugPrint_clearScreen();
    debugPrint_println("Starting Kernel...", DEBUGPRINT_PRESET_SUCCESS);

    debugPrint_println("Loading IDT...", DEBUGPRINT_PRESET_LOG);
    idt_init();
    enable_interrupts();

    debugPrint_println("Loading Kernel Heap...", DEBUGPRINT_PRESET_LOG);
    kheap_init();

    debugPrint_println("Loaded Kernel successfully!", DEBUGPRINT_PRESET_SUCCESS);
}