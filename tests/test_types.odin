package test_owin

import "base:intrinsics"
import owin ".."
import win32 "core:sys/windows"
import "core:testing"
import "shared:ounit"

expect_value :: testing.expect_value
expect_size :: ounit.expect_size
expect_flags :: ounit.expect_flags
expect_enum :: ounit.expect_enum

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
	expect_size(t, owin.CREATESTRUCT, 80)
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
make_lresult :: proc(t: ^testing.T) {
	expect_value(t, owin.MAKELRESULT(false), 0)
	expect_value(t, owin.MAKELRESULT(true), 1)

	expect_value(t, owin.MAKELRESULT(1, 2), 0x00020001)
	expect_value(t, owin.MAKELRESULT(0x1111, 0x2222), 0x22221111)
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

@(test)
verify_cs_style :: proc(t: ^testing.T) {
	// Window Class Styles
	expect_size(t, owin.CS_STYLES, 4)
	expect_value(t, owin.CS_VREDRAW, 0x00000001)
	expect_value(t, owin.CS_HREDRAW, 0x00000002)
	expect_value(t, owin.CS_DBLCLKS, 0x00000008)
	expect_value(t, owin.CS_OWNDC, 0x00000020)
	expect_value(t, owin.CS_CLASSDC, 0x00000040)
	expect_value(t, owin.CS_PARENTDC, 0x00000080)
	expect_value(t, owin.CS_NOCLOSE, 0x00000200)
	expect_value(t, owin.CS_SAVEBITS, 0x00000800)
	expect_value(t, owin.CS_BYTEALIGNCLIENT, 0x00001000)
	expect_value(t, owin.CS_BYTEALIGNWINDOW, 0x00002000)
	expect_value(t, owin.CS_GLOBALCLASS, 0x00004000)
	// expect_value(t, owin.CS_IME, 0x00010000)
	expect_value(t, owin.CS_DROPSHADOW, 0x00020000)
}

@(test)
verify_ws_style :: proc(t: ^testing.T) {
	expect_size(t, owin.WS_STYLES, 4)
    expect_value(t, owin.WS_OVERLAPPED, 0x00000000)
	expect_value(t, owin.WS_POPUP, 0x80000000)
	expect_value(t, owin.WS_CHILD, 0x40000000)
	expect_value(t, owin.WS_MINIMIZE, 0x20000000)
	expect_value(t, owin.WS_VISIBLE, 0x10000000)
	expect_value(t, owin.WS_DISABLED, 0x08000000)
	expect_value(t, owin.WS_CLIPSIBLINGS, 0x04000000)
	expect_value(t, owin.WS_CLIPCHILDREN, 0x02000000)
	expect_value(t, owin.WS_MAXIMIZE, 0x01000000)
	expect_value(t, owin.WS_CAPTION, 0x00C00000)
	expect_value(t, owin.WS_BORDER, 0x00800000)
	expect_value(t, owin.WS_DLGFRAME, 0x00400000)
	expect_value(t, owin.WS_VSCROLL, 0x00200000)
	expect_value(t, owin.WS_HSCROLL, 0x00100000)
	expect_value(t, owin.WS_SYSMENU, 0x00080000)
	expect_value(t, owin.WS_THICKFRAME, 0x00040000)
	expect_value(t, owin.WS_GROUP, 0x00020000)
	expect_value(t, owin.WS_TABSTOP, 0x00010000)
	expect_value(t, owin.WS_MINIMIZEBOX, 0x00020000)
	expect_value(t, owin.WS_MAXIMIZEBOX, 0x00010000)
	expect_value(t, owin.WS_TILED, 0x00000000)
	expect_value(t, owin.WS_ICONIC, 0x20000000)
	expect_value(t, owin.WS_SIZEBOX, 0x00040000)
	expect_value(t, owin.WS_TILEDWINDOW, 0x00CF0000)
	expect_value(t, owin.WS_OVERLAPPEDWINDOW, 0x00CF0000)
	expect_value(t, owin.WS_POPUPWINDOW, 0x80880000)
	expect_value(t, owin.WS_CHILDWINDOW, 0x40000000)
}

@(test)
verify_ws_ex_style :: proc(t: ^testing.T) {
	// when intrinsics.type_is_bit_set(owin.WS_EX_STYLES) {
	// expect_flags(t, owin.WS_EX_STYLES{.WS_EX_DLGMODALFRAME}, 0x00000001)
	// expect_flags(t, owin.WS_EX_STYLES{.WS_EX_NOPARENTNOTIFY}, 0x00000004)
	// expect_flags(t, owin.WS_EX_STYLES{.WS_EX_TOPMOST}, 0x00000008)
	// expect_flags(t, owin.WS_EX_STYLES{.WS_EX_ACCEPTFILES}, 0x00000010)
	// expect_flags(t, owin.WS_EX_STYLES{.WS_EX_TRANSPARENT}, 0x00000020)
	// expect_flags(t, owin.WS_EX_STYLES{.WS_EX_MDICHILD}, 0x00000040)
	// expect_flags(t, owin.WS_EX_STYLES{.WS_EX_TOOLWINDOW}, 0x00000080)
	// expect_flags(t, owin.WS_EX_STYLES{.WS_EX_WINDOWEDGE}, 0x00000100)
	// expect_flags(t, owin.WS_EX_STYLES{.WS_EX_CLIENTEDGE}, 0x00000200)
	// expect_flags(t, owin.WS_EX_STYLES{.WS_EX_CONTEXTHELP}, 0x00000400)
	// expect_flags(t, owin.WS_EX_STYLES{.WS_EX_RIGHT}, 0x00001000)
	// expect_flags(t, owin.WS_EX_STYLES{.WS_EX_RTLREADING}, 0x00002000)
	// expect_flags(t, owin.WS_EX_STYLES{.WS_EX_LEFTSCROLLBAR}, 0x00004000)
	// expect_flags(t, owin.WS_EX_STYLES{.WS_EX_CONTROLPARENT}, 0x00010000)
	// expect_flags(t, owin.WS_EX_STYLES{.WS_EX_STATICEDGE}, 0x00020000)
	// expect_flags(t, owin.WS_EX_STYLES{.WS_EX_APPWINDOW}, 0x00040000)
	// expect_flags(t, owin.WS_EX_STYLES{.WS_EX_LAYERED}, 0x00080000)
	// expect_flags(t, owin.WS_EX_STYLES{.WS_EX_NOINHERITLAYOUT}, 0x00100000)
	// expect_flags(t, owin.WS_EX_STYLES{.WS_EX_NOREDIRECTIONBITMAP}, 0x00200000)
	// expect_flags(t, owin.WS_EX_STYLES{.WS_EX_LAYOUTRTL}, 0x00400000)
	// expect_flags(t, owin.WS_EX_STYLES{.WS_EX_COMPOSITED}, 0x02000000)
	// expect_flags(t, owin.WS_EX_STYLES{.WS_EX_NOACTIVATE}, 0x08000000)
	// }
    expect_size(t, owin.WS_EX_STYLES, 4)
	expect_value(t, owin.WS_EX_DLGMODALFRAME, 0x00000001)
	expect_value(t, owin.WS_EX_NOPARENTNOTIFY, 0x00000004)
	expect_value(t, owin.WS_EX_TOPMOST, 0x00000008)
	expect_value(t, owin.WS_EX_ACCEPTFILES, 0x00000010)
	expect_value(t, owin.WS_EX_TRANSPARENT, 0x00000020)
	expect_value(t, owin.WS_EX_MDICHILD, 0x00000040)
	expect_value(t, owin.WS_EX_TOOLWINDOW, 0x00000080)
	expect_value(t, owin.WS_EX_WINDOWEDGE, 0x00000100)
	expect_value(t, owin.WS_EX_CLIENTEDGE, 0x00000200)
	expect_value(t, owin.WS_EX_CONTEXTHELP, 0x00000400)
	expect_value(t, owin.WS_EX_RIGHT, 0x00001000)
	expect_value(t, owin.WS_EX_RTLREADING, 0x00002000)
	expect_value(t, owin.WS_EX_LEFTSCROLLBAR, 0x00004000)
	expect_value(t, owin.WS_EX_CONTROLPARENT, 0x00010000)
	expect_value(t, owin.WS_EX_STATICEDGE, 0x00020000)
	expect_value(t, owin.WS_EX_APPWINDOW, 0x00040000)
	expect_value(t, owin.WS_EX_LAYERED, 0x00080000)
	expect_value(t, owin.WS_EX_NOINHERITLAYOUT, 0x00100000)
	expect_value(t, owin.WS_EX_NOREDIRECTIONBITMAP, 0x00200000)
	expect_value(t, owin.WS_EX_LAYOUTRTL, 0x00400000)
	expect_value(t, owin.WS_EX_COMPOSITED, 0x02000000)
	expect_value(t, owin.WS_EX_NOACTIVATE, 0x08000000)
}

@(test)
verify_rop :: proc(t: ^testing.T) {
	// Ternary raster operations
	expect_value(t, win32.SRCCOPY, 0x00CC0020)
	expect_value(t, win32.SRCPAINT, 0x00EE0086)
	expect_value(t, win32.SRCAND, 0x008800C6)
	expect_value(t, win32.SRCINVERT, 0x00660046)
	expect_value(t, win32.SRCERASE, 0x00440328)
	expect_value(t, win32.NOTSRCCOPY, 0x00330008)
	expect_value(t, win32.NOTSRCERASE, 0x001100A6)
	expect_value(t, win32.MERGECOPY, 0x00C000CA)
	expect_value(t, win32.MERGEPAINT, 0x00BB0226)
	expect_value(t, win32.PATCOPY, 0x00F00021)
	expect_value(t, win32.PATPAINT, 0x00FB0A09)
	expect_value(t, win32.PATINVERT, 0x005A0049)
	expect_value(t, win32.DSTINVERT, 0x00550009)
	expect_value(t, win32.BLACKNESS, 0x00000042)
	expect_value(t, win32.WHITENESS, 0x00FF0062)
	expect_value(t, win32.NOMIRRORBITMAP, 0x80000000)
	expect_value(t, win32.CAPTUREBLT, 0x40000000)

	expect_size(t, owin.ROP, 4)
	expect_enum(t, owin.ROP.SRCCOPY       , 0x00CC0020)
	expect_enum(t, owin.ROP.SRCPAINT      , 0x00EE0086)
	expect_enum(t, owin.ROP.SRCAND        , 0x008800C6)
	expect_enum(t, owin.ROP.SRCINVERT     , 0x00660046)
	expect_enum(t, owin.ROP.SRCERASE      , 0x00440328)
	expect_enum(t, owin.ROP.NOTSRCCOPY    , 0x00330008)
	expect_enum(t, owin.ROP.NOTSRCERASE   , 0x001100A6)
	expect_enum(t, owin.ROP.MERGECOPY     , 0x00C000CA)
	expect_enum(t, owin.ROP.MERGEPAINT    , 0x00BB0226)
	expect_enum(t, owin.ROP.PATCOPY       , 0x00F00021)
	expect_enum(t, owin.ROP.PATPAINT      , 0x00FB0A09)
	expect_enum(t, owin.ROP.PATINVERT     , 0x005A0049)
	expect_enum(t, owin.ROP.DSTINVERT     , 0x00550009)
	expect_enum(t, owin.ROP.BLACKNESS     , 0x00000042)
	expect_enum(t, owin.ROP.WHITENESS     , 0x00FF0062)
	expect_enum(t, owin.ROP.NOMIRRORBITMAP, 0x80000000)
	expect_enum(t, owin.ROP.CAPTUREBLT    , 0x40000000)
}

@(test)
decode_hresult_detaild :: proc(t: ^testing.T) {
	details := owin.decode_hresult_details(win32.E_INVALIDARG)
	expect_value(t, details.IsError, true)
	expect_value(t, details.Facility, win32.FACILITY.WIN32)
	expect_value(t, details.Code, u16(win32.System_Error.INVALID_PARAMETER))
}
