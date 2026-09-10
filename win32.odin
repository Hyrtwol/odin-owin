#+build windows
#+vet
package owin

import win32 "core:sys/windows"
import "core:fmt"

// User32

// <https://learn.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-getdc>
GetDC :: win32.GetDC

// <https://learn.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-releasedc>
ReleaseDC :: win32.ReleaseDC

//@(private = "file")
release_dc_and_reset :: proc(hWnd: HWND, hDC: ^HDC) -> (ok: bool) {
	assert(hWnd != nil)
	assert(hDC != nil)
	if hDC^ != nil {
		// If the DC was not released, the return value is zero.
		ok = ReleaseDC(hWnd, hDC^) != 0
		if ok {
			fmt.println("Released DC", hDC^)
			hDC^ = nil
		} else {
			fmt.eprintln("Unable to release DC", hDC^)
		}
	} else {
			fmt.eprintln("DC already released")
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
