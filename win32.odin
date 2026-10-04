#+build windows
#+vet
package owin

import win32 "core:sys/windows"

// User32

// <https://learn.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-getdc>
GetDC :: win32.GetDC

// <https://learn.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-releasedc>
ReleaseDC :: win32.ReleaseDC

//@(private = "file")
release_dc_and_reset :: proc(hWnd: HWND, hDC: ^HDC) -> (err: Owin_Error) {
	if hWnd == nil {return .Missing_HWND}
	if hDC == nil {return .Missing_Argument}
	if hDC^ != nil {
		if ReleaseDC(hWnd, hDC^) != 0 {
			hDC^ = nil
		} else {
			err = .Unable_To_ReleaseDC
		}
	}
	return
}

release_dc :: proc {
	win32.ReleaseDC,
	release_dc_and_reset,
}

// <https://learn.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-beginpaint>
BeginPaint :: win32.BeginPaint
// <https://learn.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-endpaint>
EndPaint :: win32.EndPaint

// GDI

// <https://learn.microsoft.com/en-us/windows/win32/api/wingdi/nf-wingdi-createcompatibledc>
CreateCompatibleDC :: win32.CreateCompatibleDC
// <https://learn.microsoft.com/en-us/windows/win32/api/wingdi/nf-wingdi-deletedc>
DeleteDC :: win32.DeleteDC
