#+build windows
#+vet
package owin

import win32 "core:sys/windows"

MSG :: win32.MSG

decode_lparam_as_int2 :: #force_inline proc "contextless" (lparam: LPARAM) -> int2 {
	return {win32.GET_X_LPARAM(lparam), win32.GET_Y_LPARAM(lparam)}
}

decode_lparam_as_rect :: #force_inline proc "contextless" (lparam: LPARAM) -> ^RECT {
	return (^RECT)(uintptr(lparam))
}

decode_wparam_as_mouse_key_state :: #force_inline proc "contextless" (wparam: WPARAM) -> MOUSE_KEY_STATE {
	return transmute(MOUSE_KEY_STATE)DWORD(wparam)
}

decode_wm_size_params :: #force_inline proc "contextless" (wparam: WPARAM, lparam: LPARAM) -> (type: WM_SIZE_WPARAM, size: int2) {
	return WM_SIZE_WPARAM(wparam), decode_lparam_as_int2(lparam)
}

decode_wm_key_input :: #force_inline proc "contextless" (wparam: WPARAM, lparam: LPARAM) -> (vk_code, key_flags, repeat_count: WORD) {
	vk_code = win32.LOWORD(wparam) // virtual-key code
	key_flags = win32.HIWORD(lparam)
	repeat_count = win32.LOWORD(lparam) // repeat count, > 0 if several keydown messages was combined into one message
	return
}

// is_key_released :: #force_inline proc "contextless" (key_flags: WORD) -> bool {
// 	return (key_flags & win32.KF_UP) == win32.KF_UP // transition-state flag, 1 on keyup
// }

decode_key_flags :: #force_inline proc "contextless" (key_flags: WORD) -> (scan_code: WORD, is_extended_key: bool, was_key_down: bool, is_key_released: bool) {

	scan_code = win32.WORD(win32.LOBYTE(key_flags)) // scan code
	is_extended_key = (key_flags & win32.KF_EXTENDED) == win32.KF_EXTENDED // extended-key flag, 1 if scancode has 0xE0 prefix
	if is_extended_key {scan_code = win32.MAKEWORD(scan_code, 0xE0)}
	was_key_down = (key_flags & win32.KF_REPEAT) == win32.KF_REPEAT // previous key-state flag, 1 on autorepeat
	is_key_released = (key_flags & win32.KF_UP) == win32.KF_UP // transition-state flag, 1 on keyup
	// is_key_released = is_key_released(key_flags)
	return
}

WMInput :: struct {
	vk_code, key_flags, repeat_count: WORD,
	scan_code:                        WORD,
	is_extended_key:                  bool,
	was_key_down:                     bool,
	is_key_released:                  bool,
}

decode_wm_input :: #force_inline proc "contextless" (wparam: WPARAM, lparam: LPARAM) -> (res: WMInput) {

	res.vk_code, res.key_flags, res.repeat_count = decode_wm_key_input(wparam, lparam)
	res.scan_code, res.is_extended_key, res.was_key_down, res.is_key_released = decode_key_flags(res.key_flags)

	switch res.vk_code {
	case win32.VK_SHIFT: // converts to VK_LSHIFT or VK_RSHIFT
		fallthrough
	case win32.VK_CONTROL: // converts to VK_LCONTROL or VK_RCONTROL
		fallthrough
	case win32.VK_MENU:
		// converts to VK_LMENU or VK_RMENU
		res.vk_code = win32.LOWORD(win32.MapVirtualKeyW(win32.DWORD(res.scan_code), win32.MAPVK_VSC_TO_VK_EX))
		break
	}

	return
}

decode_lparam_as_createstruct :: #force_inline proc "contextless" (lparam: LPARAM) -> ^CREATESTRUCTW {
	return (^CREATESTRUCTW)(rawptr(uintptr(lparam)))
}

MAKELRESULT_FROM_LOHI :: #force_inline proc "contextless" (#any_int l, h: int) -> LRESULT {
	return LRESULT(win32.MAKELONG(l, h))
}

MAKELRESULT_FROM_BOOL :: #force_inline proc "contextless" (result: BOOL) -> LRESULT {
	return LRESULT(transmute(i32)result)
}

MAKELRESULT :: proc {
	MAKELRESULT_FROM_LOHI,
	MAKELRESULT_FROM_BOOL,
}

GET_RAWINPUT_CODE_WPARAM :: win32.GET_RAWINPUT_CODE_WPARAM

CREATESTRUCTW :: win32.CREATESTRUCTW

CREATESTRUCT :: struct {
	lpCreateParams: LPVOID,
	hInstance:      HINSTANCE,
	hMenu:          HMENU,
	hwndParent:     HWND,
	cy:             i32,
	cx:             i32,
	y:              i32,
	x:              i32,
	style:          WS_STYLES,
	lpszName:       LPCWSTR,
	lpszClass:      LPCWSTR,
	dwExStyle:      WS_EX_STYLES,
}

WM_SIZE_WPARAM :: enum WPARAM {
	RESTORED  = win32.SIZE_RESTORED,
	MINIMIZED = win32.SIZE_MINIMIZED,
	MAXIMIZED = win32.SIZE_MAXIMIZED,
	MAXSHOW   = win32.SIZE_MAXSHOW,
	MAXHIDE   = win32.SIZE_MAXHIDE,
}

WM_SIZING_WPARAM :: enum WPARAM {
	WMSZ_LEFT        = win32.WMSZ_LEFT,
	WMSZ_RIGHT       = win32.WMSZ_RIGHT,
	WMSZ_TOP         = win32.WMSZ_TOP,
	WMSZ_TOPLEFT     = win32.WMSZ_TOPLEFT,
	WMSZ_TOPRIGHT    = win32.WMSZ_TOPRIGHT,
	WMSZ_BOTTOM      = win32.WMSZ_BOTTOM,
	WMSZ_BOTTOMLEFT  = win32.WMSZ_BOTTOMLEFT,
	WMSZ_BOTTOMRIGHT = win32.WMSZ_BOTTOMRIGHT,
}

WM_ACTIVATE_WPARAM :: enum WPARAM {
	WA_INACTIVE    = win32.WA_INACTIVE,
	WA_ACTIVE      = win32.WA_ACTIVE,
	WA_CLICKACTIVE = win32.WA_CLICKACTIVE,
}

WM_MSG :: enum UINT {
	WM_CREATE      = win32.WM_CREATE,
	WM_DESTROY     = win32.WM_DESTROY,
	WM_ERASEBKGND  = win32.WM_ERASEBKGND,
	WM_SIZE        = win32.WM_SIZE,
	WM_ACTIVATE    = win32.WM_ACTIVATE,
	WM_SETFOCUS    = win32.WM_SETFOCUS,
	WM_KILLFOCUS   = win32.WM_KILLFOCUS,
	WM_SIZING      = win32.WM_SIZING,
	WM_PAINT       = win32.WM_PAINT,
	WM_CHAR        = win32.WM_CHAR,
	WM_TIMER       = win32.WM_TIMER,
	WM_MOUSEMOVE   = win32.WM_MOUSEMOVE,
	WM_LBUTTONDOWN = win32.WM_LBUTTONDOWN,
	WM_RBUTTONDOWN = win32.WM_RBUTTONDOWN,
	WM_ACTIVATEAPP = win32.WM_ACTIVATEAPP,
	WM_KEYDOWN     = win32.WM_KEYDOWN,
	WM_KEYUP       = win32.WM_KEYUP,
	WM_INPUT       = win32.WM_INPUT,
}

// see win32.WNDPROC
WNDPROC :: #type proc "system" (hwnd: HWND, msg: WM_MSG, wparam: WPARAM, lparam: LPARAM) -> LRESULT

// Key State Masks for Mouse Messages

MOUSE_KEY_STATE_FLAG :: enum DWORD {
	MK_LBUTTON,
	MK_RBUTTON,
	MK_SHIFT,
	MK_CONTROL,
	MK_MBUTTON,
	MK_XBUTTON1,
	MK_XBUTTON2,
}

MOUSE_KEY_STATE :: bit_set[MOUSE_KEY_STATE_FLAG;DWORD]
