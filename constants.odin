#+build windows
#+vet
package owin

import win32 "core:sys/windows"
import "core:time"

IDT_TIMER1: UINT_PTR : 10001
IDT_TIMER2: UINT_PTR : 10002

IDI_ICON1 :: 101

DEFAULT_WINDOW_POSITION: int2 : {win32.CW_USEDEFAULT, win32.CW_USEDEFAULT}
DEFAULT_WS_STYLE :: win32.WS_OVERLAPPED | win32.WS_CAPTION | win32.WS_SYSMENU
DEFAULT_WS_EX_STYLE :: win32.WS_EX_OVERLAPPEDWINDOW
DEFAULT_SLEEP :: time.Millisecond * 10

HPEN_NULL :: win32.HPEN(uintptr(win32.PS_NULL))
HBRUSH_NULL :: win32.HBRUSH(uintptr(win32.BS_NULL))

LANGID_NEUTRAL_DEFAULT :: DWORD(win32.SUBLANG_DEFAULT) << 10 | DWORD(win32.LANG_NEUTRAL) & 0x3FF

// SRCCOPY :: win32.SRCCOPY
BI_RGB :: win32.BI_RGB

// key codes

VK_BACK :: win32.VK_BACK
VK_TAB :: win32.VK_TAB
VK_SHIFT :: win32.VK_SHIFT
VK_CONTROL :: win32.VK_CONTROL
VK_ESCAPE :: win32.VK_ESCAPE

VK_F1 :: win32.VK_F1
VK_F2 :: win32.VK_F2
VK_F3 :: win32.VK_F3
VK_F4 :: win32.VK_F4
VK_F5 :: win32.VK_F5
VK_F6 :: win32.VK_F6
VK_F7 :: win32.VK_F7
VK_F8 :: win32.VK_F8
VK_F9 :: win32.VK_F9
VK_F10 :: win32.VK_F10
VK_F11 :: win32.VK_F11
VK_F12 :: win32.VK_F12
VK_F13 :: win32.VK_F13
VK_F14 :: win32.VK_F14
VK_F15 :: win32.VK_F15
VK_F16 :: win32.VK_F16
VK_F17 :: win32.VK_F17
VK_F18 :: win32.VK_F18
VK_F19 :: win32.VK_F19
VK_F20 :: win32.VK_F20
VK_F21 :: win32.VK_F21
VK_F22 :: win32.VK_F22
VK_F23 :: win32.VK_F23
VK_F24 :: win32.VK_F24

VK_0 :: win32.VK_0
VK_1 :: win32.VK_1
VK_2 :: win32.VK_2
VK_3 :: win32.VK_3
VK_4 :: win32.VK_4
VK_5 :: win32.VK_5
VK_6 :: win32.VK_6
VK_7 :: win32.VK_7
VK_8 :: win32.VK_8
VK_9 :: win32.VK_9

VK_A :: win32.VK_A
VK_B :: win32.VK_B
VK_C :: win32.VK_C
VK_D :: win32.VK_D
VK_E :: win32.VK_E
VK_F :: win32.VK_F
VK_G :: win32.VK_G
VK_H :: win32.VK_H
VK_I :: win32.VK_I
VK_J :: win32.VK_J
VK_K :: win32.VK_K
VK_L :: win32.VK_L
VK_M :: win32.VK_M
VK_N :: win32.VK_N
VK_O :: win32.VK_O
VK_P :: win32.VK_P
VK_Q :: win32.VK_Q
VK_R :: win32.VK_R
VK_S :: win32.VK_S
VK_T :: win32.VK_T
VK_U :: win32.VK_U
VK_V :: win32.VK_V
VK_W :: win32.VK_W
VK_X :: win32.VK_X
VK_Y :: win32.VK_Y
VK_Z :: win32.VK_Z
