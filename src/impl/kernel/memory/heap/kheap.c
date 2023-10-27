#include "kheap.h"
#include "heap.h"
#include "config.h"
#include "debug_print.h"

struct heap kernel_heap;
struct heap_table kernel_heap_table;

void kheap_init(){
    int total_table_entries = STARFLEETOS_HEAP_SIZE_BYTES / STARFLEETOS_HEAP_BLOCK_SIZE;
    kernel_heap_table.entries = (HEAP_BLOCK_TABLE_ENTRY*)(STARFLEETOS_HEAP_TABLE_ADDRESS);
    kernel_heap_table.total = total_table_entries;

    void* end = (void*)(STARFLEETOS_HEAP_ADDRESS + STARFLEETOS_HEAP_SIZE_BYTES);
    int res = heap_create(&kernel_heap, (void*)(STARFLEETOS_HEAP_ADDRESS), end, &kernel_heap_table);
    if(res != 0){
        debugPrint_println("Failed to create kernel heap", DEBUGPRINT_PRESET_ERROR);
    }
}

void* kmalloc(size_t size)
{
    return heap_malloc(&kernel_heap, size);
}

void kfree(void* ptr)
{
    heap_free(&kernel_heap, ptr);
}