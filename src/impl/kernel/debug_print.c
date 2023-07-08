#include "debug_print.h" 
#include <stdint.h>
#include <stddef.h>

uint16_t* video_mem = (uint16_t*)(0xB8000);
uint16_t terminal_row = 0;
uint16_t terminal_col = 0;

void debugPrint_setChar(int x, int y, char c, char color){
    video_mem[(DEBUGPRINT_TERMINAL_WIDTH * y) + x] = (color << 8) | c;
}

void debugPrint_clearScreen(){
    for(int y = 0; y < DEBUGPRINT_TERMINAL_HEIGHT; y++){
        for(int x = 0; x < DEBUGPRINT_TERMINAL_WIDTH; x++){
            debugPrint_setChar(x, y, ' ', 0);
        }
    }
}

void debugPrint_printchar(char c, char color){
    if (c == '\n')
    {
        terminal_row += 1;
        terminal_col = 0;
        return;
    }
    debugPrint_setChar(terminal_col, terminal_row, c, color);
    terminal_col += 1;
    if(terminal_col > DEBUGPRINT_TERMINAL_WIDTH){
        terminal_col = 0;
        terminal_row++;
    }
}

void debugPrint_print(char text[], char color){
    size_t i = 0;
    while(text[i])
    {
        debugPrint_printchar(text[i], color);
        i++;
    }
}

void debugPrint_println(char text[], char color){
    if(terminal_col != 0){
        terminal_row++;
        terminal_col = 0;
    }
    debugPrint_print(text, color);
    terminal_row++;
    terminal_col = 0;
}

char debugPrint_colorBuilder(int color, int bgColor){
    return color + bgColor * 16;
}