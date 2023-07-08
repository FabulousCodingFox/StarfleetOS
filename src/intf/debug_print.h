#pragma once

#define DEBUGPRINT_TERMINAL_WIDTH 80
#define DEBUGPRINT_TERMINAL_HEIGHT 20

#define DEBUGPRINT_COLOR_BLACK 0
#define DEBUGPRINT_COLOR_DARK_BLUE 1
#define DEBUGPRINT_COLOR_DARK_GREEN 2
#define DEBUGPRINT_COLOR_DARK_AQUA 3
#define DEBUGPRINT_COLOR_DARK_RED 4
#define DEBUGPRINT_COLOR_DARK_PURPLE 5
#define DEBUGPRINT_COLOR_DARK_ORANGE 6
#define DEBUGPRINT_COLOR_DARK_WHITE 7
#define DEBUGPRINT_COLOR_GRAY 8
#define DEBUGPRINT_COLOR_BLUE 9
#define DEBUGPRINT_COLOR_GREEN 10
#define DEBUGPRINT_COLOR_AQUA 11
#define DEBUGPRINT_COLOR_RED 12
#define DEBUGPRINT_COLOR_PURPLE 13
#define DEBUGPRINT_COLOR_ORANGE 14
#define DEBUGPRINT_COLOR_WHITE 15

#define DEBUGPRINT_PRESET_SUCCESS 10
#define DEBUGPRINT_PRESET_LOG 7
#define DEBUGPRINT_PRESET_ERROR 207

char debugPrint_colorBuilder(int color, int bgColor);

void debugPrint_setChar(int x, int y, char c, char color);

void debugPrint_clearScreen();

void debugPrint_println(const char* text, char color);

void debugPrint_print(const char* text, char color);

void debugPrint_printchar(char c, char color);