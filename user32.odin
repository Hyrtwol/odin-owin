#+build windows
#+vet
package owin

import win32 "core:sys/windows"

// get_dc
GetDC :: win32.GetDC
// release_dc
ReleaseDC :: win32.ReleaseDC

BeginPaint :: win32.BeginPaint
EndPaint :: win32.EndPaint

// GDI

CreateCompatibleDC :: win32.CreateCompatibleDC
DeleteDC :: win32.DeleteDC
