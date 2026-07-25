#+build windows
#+vet
package owin

import "base:intrinsics"
import win32 "core:sys/windows"
import "core:time"

int2 :: [2]i32
int3 :: [3]i32
float3 :: [3]f32
byte4 :: [4]u8

Millisecond :: time.Millisecond
Duration :: time.Duration
L :: intrinsics.constant_utf16_cstring
wstring :: win32.wstring
utf8_to_wstring :: win32.utf8_to_wstring
wstring_to_utf8 :: win32.wstring_to_utf8
utf8_to_utf16 :: win32.utf8_to_utf16
utf16_to_utf8 :: win32.utf16_to_utf8

DWORD :: win32.DWORD // u32
BYTE :: win32.BYTE // u8
BOOL :: win32.BOOL // b32
WORD :: win32.WORD // u16
LONG :: win32.LONG // i32
INT :: win32.INT // i32
UINT :: win32.UINT // u32
WCHAR :: win32.WCHAR // c.wchar_t
// DWORD_PTR :: win32.DWORD_PTR
UINT_PTR :: win32.UINT_PTR // uintptr
LONG_PTR :: win32.LONG_PTR // int
LARGE_INTEGER :: win32.LARGE_INTEGER // i64

LPVOID :: win32.LPVOID // rawptr
// LPCVOID :: win32.LPCVOID
// LPUINT :: win32.LPUINT
// LPSTR :: win32.LPSTR
// LPCSTR :: win32.LPCSTR
// LPWSTR :: win32.LPWSTR
LPCWSTR :: win32.LPCWSTR // cstring16
LPRECT :: win32.LPRECT

ATOM :: win32.ATOM // u16
HANDLE :: win32.HANDLE // rawptr
HMODULE :: win32.HMODULE // rawptr
HINSTANCE :: win32.HINSTANCE // rawptr
HMENU :: win32.HMENU // rawptr
HWND :: win32.HWND // rawptr
HDC :: win32.HDC // rawptr
HRGN :: win32.HRGN // rawptr
HGDIOBJ :: win32.HGDIOBJ // rawptr
HBITMAP :: win32.HBITMAP // rawptr
HPEN :: win32.HPEN // rawptr
HBRUSH :: win32.HBRUSH // rawptr
HICON :: win32.HICON // rawptr
HCURSOR :: win32.HCURSOR // rawptr

LPARAM :: win32.LPARAM // int
WPARAM :: win32.WPARAM // uintptr
LRESULT :: win32.LRESULT // int

POINT :: win32.POINT
RECT :: win32.RECT

HRESULT :: win32.HRESULT // i32
HRESULT_DETAILS :: win32.HRESULT_DETAILS
FACILITY :: win32.FACILITY
SEVERITY :: win32.SEVERITY
ERROR_SUCCESS :: win32.ERROR_SUCCESS

SUCCEEDED :: win32.SUCCEEDED
FAILED :: win32.FAILED
IS_ERROR :: win32.IS_ERROR
HRESULT_CODE :: win32.HRESULT_CODE
HRESULT_SEVERITY :: win32.HRESULT_SEVERITY
HRESULT_FACILITY :: win32.HRESULT_FACILITY
MAKE_HRESULT :: win32.MAKE_HRESULT
DECODE_HRESULT :: win32.DECODE_HRESULT

RAWINPUT_CODE :: win32.RAWINPUT_CODE

// Window Class Styles
// <https://learn.microsoft.com/en-us/windows/win32/winmsg/window-class-styles>
CS_STYLES :: distinct UINT // u32

// Window Styles
// <https://learn.microsoft.com/en-us/windows/win32/winmsg/window-styles>
WS_STYLES :: distinct win32.WS_STYLES // u32

// Extended Window Styles
// <https://learn.microsoft.com/en-us/windows/win32/winmsg/extended-window-styles>
WS_EX_STYLES :: distinct win32.WS_EX_STYLES // u32

PAINTSTRUCT :: win32.PAINTSTRUCT

RAWINPUTHEADER :: win32.RAWINPUTHEADER
RAWINPUT :: win32.RAWINPUT
HRAWINPUT :: win32.HRAWINPUT

RID_INPUT :: win32.RID_INPUT

RIM_TYPEMOUSE :: win32.RIM_TYPEMOUSE
RIM_TYPEKEYBOARD :: win32.RIM_TYPEKEYBOARD
RIM_TYPEHID :: win32.RIM_TYPEHID

RI_MOUSE_BUTTON_1_DOWN :: win32.RI_MOUSE_BUTTON_1_DOWN
RI_MOUSE_BUTTON_1_UP :: win32.RI_MOUSE_BUTTON_1_UP
RI_MOUSE_BUTTON_2_DOWN :: win32.RI_MOUSE_BUTTON_2_DOWN
RI_MOUSE_BUTTON_2_UP :: win32.RI_MOUSE_BUTTON_2_UP
RI_MOUSE_BUTTON_3_DOWN :: win32.RI_MOUSE_BUTTON_3_DOWN
RI_MOUSE_BUTTON_3_UP:: win32.RI_MOUSE_BUTTON_3_UP
RI_MOUSE_BUTTON_4_DOWN:: win32.RI_MOUSE_BUTTON_4_DOWN
RI_MOUSE_BUTTON_4_UP:: win32.RI_MOUSE_BUTTON_4_UP
RI_MOUSE_BUTTON_5_DOWN:: win32.RI_MOUSE_BUTTON_5_DOWN
RI_MOUSE_BUTTON_5_UP:: win32.RI_MOUSE_BUTTON_5_UP
RI_MOUSE_WHEEL:: win32.RI_MOUSE_WHEEL
RI_MOUSE_HWHEEL:: win32.RI_MOUSE_HWHEEL

RI_MOUSE_LEFT_BUTTON_DOWN :: RI_MOUSE_BUTTON_1_DOWN
RI_MOUSE_LEFT_BUTTON_UP :: RI_MOUSE_BUTTON_1_UP
RI_MOUSE_RIGHT_BUTTON_DOWN :: RI_MOUSE_BUTTON_2_DOWN
RI_MOUSE_RIGHT_BUTTON_UP :: RI_MOUSE_BUTTON_2_UP
RI_MOUSE_MIDDLE_BUTTON_DOWN :: RI_MOUSE_BUTTON_3_DOWN
RI_MOUSE_MIDDLE_BUTTON_UP :: RI_MOUSE_BUTTON_3_UP

// GDI

BITMAPV5HEADER :: win32.BITMAPV5HEADER
BITMAPINFO :: win32.BITMAPINFO
BITMAPINFOHEADER :: win32.BITMAPINFOHEADER

MAKEINTRESOURCE :: win32.MAKEINTRESOURCEW

// Standard Icon IDs

// MAKEINTRESOURCE(32512)
IDI_APPLICATION  := LPCWSTR(win32._IDI_APPLICATION)
IDI_HAND         := wstring(win32._IDI_HAND)
IDI_QUESTION     := wstring(win32._IDI_QUESTION)
IDI_EXCLAMATION  := wstring(win32._IDI_EXCLAMATION)
IDI_ASTERISK     := wstring(win32._IDI_ASTERISK)
IDI_WINLOGO      := wstring(win32._IDI_WINLOGO)
IDI_SHIELD       := wstring(win32._IDI_SHIELD)
IDI_WARNING      := IDI_EXCLAMATION
IDI_ERROR        := IDI_HAND
IDI_INFORMATION  := IDI_ASTERISK

// Standard Cursor IDs

// MAKEINTRESOURCE(32512)
IDC_ARROW         := wstring(win32._IDC_ARROW)

ROP :: win32.ROP

/*
// Ternary raster operations
ROP_alt :: enum DWORD {
	SRCCOPY        = win32.SRCCOPY       , // dest = source
	SRCPAINT       = win32.SRCPAINT      , // dest = source OR dest
	SRCAND         = win32.SRCAND        , // dest = source AND dest
	SRCINVERT      = win32.SRCINVERT     , // dest = source XOR dest
	SRCERASE       = win32.SRCERASE      , // dest = source AND (NOT dest)
	NOTSRCCOPY     = win32.NOTSRCCOPY    , // dest = (NOT source)
	NOTSRCERASE    = win32.NOTSRCERASE   , // dest = (NOT src) AND (NOT dest)
	MERGECOPY      = win32.MERGECOPY     , // dest = (source AND pattern
	MERGEPAINT     = win32.MERGEPAINT    , // dest = (NOT source) OR dest
	PATCOPY        = win32.PATCOPY       , // dest = pattern
	PATPAINT       = win32.PATPAINT      , // dest = DPSnoo
	PATINVERT      = win32.PATINVERT     , // dest = pattern XOR dest
	DSTINVERT      = win32.DSTINVERT     , // dest = (NOT dest)
	BLACKNESS      = win32.BLACKNESS     , // dest = BLACK
	WHITENESS      = win32.WHITENESS     , // dest = WHITE
	NOMIRRORBITMAP = win32.NOMIRRORBITMAP, // Do not Mirror the bitmap in this call
	CAPTUREBLT     = win32.CAPTUREBLT    , // Include layered windows
}
*/
