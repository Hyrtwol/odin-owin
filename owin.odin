// +build windows
// +vet
package owin

import "base:intrinsics"
import "core:fmt"
import win32 "core:sys/windows"

show_message_box :: #force_inline proc(caption: string, text: string, type: UINT = win32.MB_ICONSTOP | win32.MB_OK) {
	win32.MessageBoxW(nil, utf8_to_wstring(text), utf8_to_wstring(caption), type)
}

show_message_boxf :: #force_inline proc(caption: string, format: string, args: ..any) {
	show_message_box(caption, fmt.tprintf(format, ..args))
}

show_error :: #force_inline proc(msg: string, loc := #caller_location) {
	show_message_boxf("Panic", "%s\nLast error: %x\n%v\n", msg, win32.GetLastError(), loc)
}

show_error_and_panic :: proc(msg: string, loc := #caller_location) {
	show_error(msg, loc = loc)
	fmt.panicf("%s (Last error: %x)", msg, win32.GetLastError(), loc = loc)
}

show_error_and_panicf :: proc(format: string, args: ..any, loc := #caller_location) {
	show_error_and_panic(fmt.tprintf(format, ..args), loc = loc)
}

show_last_error :: proc(caption: string, loc := #caller_location) {
	fmt.eprintln(caption)
	last_error := win32.GetLastError()
	error_text: [512]win32.WCHAR
	error_wstring := wstring(&error_text)
	cch := win32.FormatMessageW(win32.FORMAT_MESSAGE_FROM_SYSTEM | win32.FORMAT_MESSAGE_IGNORE_INSERTS, nil, last_error, LANGID_NEUTRAL_DEFAULT, error_wstring, len(error_text) - 1, nil)
	if (cch != 0) {return}
	error_string, err := wstring_to_utf8(&error_wstring[0], int(cch))
	if err == .None {
		fmt.eprintln(error_string)
	} else {
		fmt.eprintfln("Last error code: %d (0x%8X)", last_error)
	}
}

show_last_errorf :: #force_inline proc(format: string, args: ..any, loc := #caller_location) {
	show_last_error(fmt.tprintf(format, ..args), loc = loc)
}


decode_lparam_as_int2 :: #force_inline proc "contextless" (lparam: LPARAM) -> int2 {
	return {win32.GET_X_LPARAM(lparam), win32.GET_Y_LPARAM(lparam)}
}

decode_wparam_as_mouse_key_state :: #force_inline proc "contextless" (wparam: win32.WPARAM) -> MOUSE_KEY_STATE {
	return transmute(MOUSE_KEY_STATE)win32.DWORD(wparam)
}

get_rect_size :: #force_inline proc "contextless" (rect: ^RECT) -> int2 {
	return {(rect.right - rect.left), (rect.bottom - rect.top)}
}

get_client_size :: proc "contextless" (hwnd: HWND) -> int2 {
	rect: RECT
	win32.GetClientRect(hwnd, &rect)
	return get_rect_size(&rect)
}

adjust_window_size :: proc "contextless" (size: int2, dwStyle, dwExStyle: u32) -> int2 {
	rect := RECT{0, 0, size.x, size.y}
	if win32.AdjustWindowRectEx(&rect, dwStyle, false, dwExStyle) {
		return get_rect_size(&rect)
	}
	return size
}

adjust_size_for_style :: proc(size: ^int2, dwStyle: win32.DWORD) {
	rect := win32.RECT{0, 0, size.x, size.y}
	if win32.AdjustWindowRect(&rect, dwStyle, false) {
		size^ = get_rect_size(&rect)
	}
}

get_window_position :: proc(size: int2, center: bool) -> int2 {
	if center {
		if deviceMode: win32.DEVMODEW; win32.EnumDisplaySettingsW(nil, win32.ENUM_CURRENT_SETTINGS, &deviceMode) {
			dmsize: int2 = {i32(deviceMode.dmPelsWidth), i32(deviceMode.dmPelsHeight)} // is there an easier way to describe this?
			return (dmsize - size) / 2
		}
	}
	return {win32.CW_USEDEFAULT, win32.CW_USEDEFAULT}
}
