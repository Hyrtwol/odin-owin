#+build windows
#+vet
package owin

import "base:intrinsics"
import win32 "core:sys/windows"
import "core:time"

Window_Option :: enum u32 {
	Center = 0,
	Raw_Input = 1,
}
Window_Options :: bit_set[Window_Option;u32]

Window_Settings :: struct {
	title:       string,
	window_size: int2,
	options:     Window_Options,
	dwStyle:     WS_STYLES,
	dwExStyle:   WS_EX_STYLES,
	wndproc:     win32.WNDPROC,
	sleep:       time.Duration,
	param:       LPVOID,
}

DEFAULT_Window_Settings :: Window_Settings {
	options     = {.Center},
	dwStyle     = DEFAULT_WS_STYLE,
	dwExStyle   = DEFAULT_WS_EX_STYLE,
	sleep       = DEFAULT_SLEEP,
}

set_settings :: #force_inline proc "contextless" (hwnd: HWND, settings: ^Window_Settings) {
	win32.SetWindowLongPtrW(hwnd, win32.GWLP_USERDATA, LONG_PTR(uintptr(settings)))
}

get_settings :: #force_inline proc "contextless" (hwnd: HWND, $T: typeid) -> ^T where intrinsics.type_is_subtype_of(T, Window_Settings) {
	return (^T)(uintptr(win32.GetWindowLongPtrW(hwnd, win32.GWLP_USERDATA)))
}

get_settings_from_createstruct :: #force_inline proc "contextless" (pcs: ^CREATESTRUCTW, $T: typeid) -> ^T where intrinsics.type_is_subtype_of(T, Window_Settings) {
	return (^T)(pcs.lpCreateParams) if pcs != nil else nil
}

get_settings_from_lparam :: #force_inline proc "contextless" (lparam: LPARAM, $T: typeid) -> ^T where intrinsics.type_is_subtype_of(T, Window_Settings) {
	pcs := decode_lparam_as_createstruct(lparam)
	return get_settings_from_createstruct(pcs, T)
}

@(private = "file")
create_Window_Settings_win32 :: proc "contextless" (size: int2, title: string, wndproc: win32.WNDPROC) -> Window_Settings {
	settings := DEFAULT_Window_Settings
	settings.window_size = size
	settings.wndproc = wndproc
	//settings.run = run
	settings.title = title
	return settings
}

@(private = "file")
create_Window_Settings_lean :: #force_inline proc "contextless" (size: int2, title: string, wndproc: WNDPROC) -> Window_Settings {
	return create_Window_Settings_win32(size, title, win32.WNDPROC(wndproc))
}

create_Window_Settings :: proc {
	create_Window_Settings_win32,
	create_Window_Settings_lean,
}
