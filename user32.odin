#+build windows
#+vet
package owin

import win32 "core:sys/windows"

// User32

// <https://learn.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-getdc>
GetDC :: win32.GetDC
// <https://learn.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-releasedc>
ReleaseDC :: win32.ReleaseDC
// <https://learn.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-beginpaint>
BeginPaint :: win32.BeginPaint
// <https://learn.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-endpaint>
EndPaint :: win32.EndPaint

// GDI

// <https://learn.microsoft.com/en-us/windows/win32/api/wingdi/nf-wingdi-createcompatibledc>
CreateCompatibleDC :: win32.CreateCompatibleDC
// <https://learn.microsoft.com/en-us/windows/win32/api/wingdi/nf-wingdi-deletedc>
DeleteDC :: win32.DeleteDC
