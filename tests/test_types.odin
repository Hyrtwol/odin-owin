package test_owin

import owin ".."
import win32 "core:sys/windows"
import "core:testing"
import "shared:ounit"

expect_value :: testing.expect_value
expect_size :: ounit.expect_size
expect_flags :: ounit.expect_flags

@(test)
verify_sizes :: proc(t: ^testing.T) {
	expect_size(t, owin.BYTE, 1)
	expect_size(t, owin.BOOL, 4)
	expect_size(t, owin.WORD, 2)
	expect_size(t, owin.LONG, 4)
	expect_size(t, owin.DWORD, 4)
	expect_size(t, owin.INT, 4)
	expect_size(t, owin.UINT, 4)
	expect_size(t, owin.WCHAR, 2)
	expect_size(t, owin.HANDLE, 8)
	expect_size(t, owin.HMODULE, 8)
	expect_size(t, owin.HINSTANCE, 8)
	expect_size(t, owin.HWND, 8)
	expect_size(t, owin.HDC, 8)
	expect_size(t, owin.HRGN, 8)
	expect_size(t, owin.HGDIOBJ, 8)
	expect_size(t, owin.HBITMAP, 8)
	expect_size(t, owin.HPEN, 8)
	expect_size(t, owin.HBRUSH, 8)

	expect_size(t, owin.LPARAM, 8)
	expect_size(t, owin.WPARAM, 8)
	expect_size(t, owin.LRESULT, 8)

	expect_size(t, owin.POINT, 8)
	expect_size(t, owin.RECT, 16)
	expect_size(t, owin.CREATESTRUCTW, 80)
	expect_size(t, owin.WM_SIZE_WPARAM, 8)
	expect_size(t, owin.WM_SIZING_WPARAM, 8)
	expect_size(t, owin.WM_MSG, 4)
	expect_size(t, owin.MOUSE_KEY_STATE, 4)
}

@(test)
verify_consts :: proc(t: ^testing.T) {
	expect_value(t, owin.HPEN_NULL, owin.HPEN(uintptr(5)))
	expect_value(t, owin.HBRUSH_NULL, owin.HBRUSH(uintptr(1)))
	expect_value(t, owin.LANGID_NEUTRAL_DEFAULT, 0x400)
	expect_value(t, owin.LANGID_NEUTRAL_DEFAULT, win32.MAKELANGID(win32.LANG_NEUTRAL, win32.SUBLANG_DEFAULT))
}

@(test)
make_lresult_from_false :: proc(t: ^testing.T) {
	exp: owin.LRESULT = 0
	result := owin.MAKELRESULT(false)
	expect_value(t, result, exp)
}

@(test)
make_lresult_from_true :: proc(t: ^testing.T) {
	exp: owin.LRESULT = 1
	result := owin.MAKELRESULT(true)
	expect_value(t, result, exp)
}

@(test)
check_mouse_key_state_flags :: proc(t: ^testing.T) {
	expect_state :: proc(t: ^testing.T, val: owin.MOUSE_KEY_STATE, exp: u32) {
		expect_value(t, transmute(u32)val, exp)
	}
	expect_size(t, owin.MOUSE_KEY_STATE, 4)
	expect_state(t, {.MK_LBUTTON}, win32.MK_LBUTTON)
	expect_state(t, {.MK_RBUTTON}, win32.MK_RBUTTON)
	expect_state(t, {.MK_SHIFT}, win32.MK_SHIFT)
	expect_state(t, {.MK_CONTROL}, win32.MK_CONTROL)
	expect_state(t, {.MK_MBUTTON}, win32.MK_MBUTTON)
	expect_state(t, {.MK_XBUTTON1}, win32.MK_XBUTTON1)
	expect_state(t, {.MK_XBUTTON2}, win32.MK_XBUTTON2)
}

@(test)
verify_rawinput_code :: proc(t: ^testing.T) {
	expect_value(t, owin.GET_RAWINPUT_CODE_WPARAM(0), owin.RAWINPUT_CODE.RIM_INPUT)
	expect_value(t, owin.GET_RAWINPUT_CODE_WPARAM(1), owin.RAWINPUT_CODE.RIM_INPUTSINK)
	expect_value(t, owin.GET_RAWINPUT_CODE_WPARAM(0x100), owin.RAWINPUT_CODE.RIM_INPUT)
	expect_value(t, owin.GET_RAWINPUT_CODE_WPARAM(0x101), owin.RAWINPUT_CODE.RIM_INPUTSINK)
}

verify_macros :: proc(t: ^testing.T) {
	// minwindef.h
	// expect_value(t, owin.MAKEWORD(1, 2), 0x00000201)
	// expect_value(t, owin.MAKEWORD(0x1111, 0x2222), 0x00002211)
	// expect_value(t, owin.MAKELONG(1, 2), 0x00020001)
	// expect_value(t, owin.MAKELONG(0x1111, 0x2222), 0x22221111)
	// expect_value(t, owin.LOWORD(0x12345678), 0x00005678)
	// expect_value(t, owin.HIWORD(0x12345678), 0x00001234)
	// expect_value(t, u32(owin.LOBYTE(0x1234)), 0x00000034)
	// expect_value(t, u32(owin.HIBYTE(0x1234)), 0x00000012)

	// winuser.h
	// expect_value(t, owin.MAKEWPARAM(1, 2), 0x00020001)
	// expect_value(t, owin.MAKEWPARAM(0x1111, 0x2222), 0x22221111)
	// expect_value(t, owin.MAKELPARAM(1, 2), 0x00020001)
	// expect_value(t, owin.MAKELPARAM(0x1111, 0x2222), 0x22221111)
	expect_value(t, owin.MAKELRESULT(1, 2), 0x00020001)
	expect_value(t, owin.MAKELRESULT(0x1111, 0x2222), 0x22221111)

	// winnt.h
	// expect_value(t, owin.MAKELCID(1, 2), 0x00020001)
	// expect_value(t, owin.MAKELCID(0x1111, 0x2222), 0x22221111)
	// expect_value(t, owin.MAKELANGID(1, 2), 0x00000801)
	// expect_value(t, owin.MAKELANGID(0x111, 0x222), 0x00088911)
	// expect_value(t, owin.LANGIDFROMLCID(0x12345678), 0x00005678)
}

verify_ws_ex_style :: proc(t: ^testing.T) {
	expect_flags(t, owin.WS_EX_STYLES{.WS_EX_DLGMODALFRAME}, 0x00000001)
	expect_flags(t, owin.WS_EX_STYLES{.WS_EX_NOPARENTNOTIFY}, 0x00000004)
	expect_flags(t, owin.WS_EX_STYLES{.WS_EX_TOPMOST}, 0x00000008)
	expect_flags(t, owin.WS_EX_STYLES{.WS_EX_ACCEPTFILES}, 0x00000010)
	expect_flags(t, owin.WS_EX_STYLES{.WS_EX_TRANSPARENT}, 0x00000020)
	expect_flags(t, owin.WS_EX_STYLES{.WS_EX_MDICHILD}, 0x00000040)
	expect_flags(t, owin.WS_EX_STYLES{.WS_EX_TOOLWINDOW}, 0x00000080)
	expect_flags(t, owin.WS_EX_STYLES{.WS_EX_WINDOWEDGE}, 0x00000100)
	expect_flags(t, owin.WS_EX_STYLES{.WS_EX_CLIENTEDGE}, 0x00000200)
	expect_flags(t, owin.WS_EX_STYLES{.WS_EX_CONTEXTHELP}, 0x00000400)
	expect_flags(t, owin.WS_EX_STYLES{.WS_EX_RIGHT}, 0x00001000)
	expect_flags(t, owin.WS_EX_STYLES{.WS_EX_RTLREADING}, 0x00002000)
	expect_flags(t, owin.WS_EX_STYLES{.WS_EX_LEFTSCROLLBAR}, 0x00004000)
	expect_flags(t, owin.WS_EX_STYLES{.WS_EX_CONTROLPARENT}, 0x00010000)
	expect_flags(t, owin.WS_EX_STYLES{.WS_EX_STATICEDGE}, 0x00020000)
	expect_flags(t, owin.WS_EX_STYLES{.WS_EX_APPWINDOW}, 0x00040000)
	expect_flags(t, owin.WS_EX_STYLES{.WS_EX_LAYERED}, 0x00080000)
	expect_flags(t, owin.WS_EX_STYLES{.WS_EX_NOINHERITLAYOUT}, 0x00100000)
	expect_flags(t, owin.WS_EX_STYLES{.WS_EX_NOREDIRECTIONBITMAP}, 0x00200000)
	expect_flags(t, owin.WS_EX_STYLES{.WS_EX_LAYOUTRTL}, 0x00400000)
	expect_flags(t, owin.WS_EX_STYLES{.WS_EX_COMPOSITED}, 0x02000000)
	expect_flags(t, owin.WS_EX_STYLES{.WS_EX_NOACTIVATE}, 0x08000000)
}
