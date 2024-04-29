package test_owin

import ow ".."
import win32 "core:sys/windows"
import "core:testing"
import "shared:ounit"

T :: testing.T
expect_value :: testing.expect_value
expect_size :: ounit.expect_size

@(test)
verify_sizes :: proc(t: ^testing.T) {
	expect_size(t, ow.DWORD, 4)
	expect_size(t, ow.BYTE, 1)
	expect_size(t, ow.BOOL, 4)
	expect_size(t, ow.WORD, 2)
	expect_size(t, ow.LONG, 4)
	expect_size(t, ow.INT, 4)
	expect_size(t, ow.UINT, 4)
	expect_size(t, ow.WCHAR, 2)

	expect_size(t, ow.HANDLE, 8)
	expect_size(t, ow.HMODULE, 8)
	expect_size(t, ow.HINSTANCE, 8)
	expect_size(t, ow.HWND, 8)
	expect_size(t, ow.HDC, 8)
	expect_size(t, ow.HRGN, 8)
	expect_size(t, ow.HGDIOBJ, 8)
	expect_size(t, ow.HBITMAP, 8)
	expect_size(t, ow.HPEN, 8)
	expect_size(t, ow.HBRUSH, 8)

	expect_size(t, ow.LPARAM, 8)
	expect_size(t, ow.WPARAM, 8)
	expect_size(t, ow.LRESULT, 8)

	expect_size(t, ow.POINT, 8)
	expect_size(t, ow.RECT, 16)
	expect_size(t, ow.CREATESTRUCTW, 80)
	expect_size(t, ow.WM_SIZE_WPARAM, 8)
	expect_size(t, ow.WM_MSG, 4)
	expect_size(t, ow.MOUSE_KEY_STATE, 4)
}

@(test)
verify_consts :: proc(t: ^testing.T) {
	expect_value(t, ow.HPEN_NULL, ow.HPEN(uintptr(5)))
	expect_value(t, ow.HBRUSH_NULL, ow.HBRUSH(uintptr(1)))
	expect_value(t, ow.HGDIOBJ_PS_NULL, ow.HGDIOBJ(uintptr(5)))
	expect_value(t, ow.HGDIOBJ_BS_NULL, ow.HGDIOBJ(uintptr(1)))
	expect_value(t, ow.LANGID_NEUTRAL_DEFAULT, 0x400)
	expect_value(t, ow.LANGID_NEUTRAL_DEFAULT, win32.MAKELANGID(win32.LANG_NEUTRAL, win32.SUBLANG_DEFAULT))
}

@(test)
check_mouse_key_state_flags :: proc(t: ^testing.T) {
	expect_state :: proc(t: ^testing.T, val: ow.MOUSE_KEY_STATE, exp: u32) {
		expect_value(t, transmute(u32)val, exp)
	}
	expect_state(t, {.MK_LBUTTON}, win32.MK_LBUTTON)
	expect_state(t, {.MK_RBUTTON}, win32.MK_RBUTTON)
	expect_state(t, {.MK_SHIFT}, win32.MK_SHIFT)
	expect_state(t, {.MK_CONTROL}, win32.MK_CONTROL)
	expect_state(t, {.MK_MBUTTON}, win32.MK_MBUTTON)
	expect_state(t, {.MK_XBUTTON1}, win32.MK_XBUTTON1)
	expect_state(t, {.MK_XBUTTON2}, win32.MK_XBUTTON2)
}
