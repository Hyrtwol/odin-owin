#+build windows
#+vet
package owin

import "base:runtime"
import "core:io"
import "core:os"
import win32 "core:sys/windows"



// odinfmt: disable

Windows_Error :: enum win32.UINT {
	ERROR_SUCCESS                = win32.ERROR_SUCCESS                ,
	ERROR_INVALID_FUNCTION       = win32.ERROR_INVALID_FUNCTION       ,
	ERROR_FILE_NOT_FOUND         = win32.ERROR_FILE_NOT_FOUND         ,
	ERROR_PATH_NOT_FOUND         = win32.ERROR_PATH_NOT_FOUND         ,
	ERROR_ACCESS_DENIED          = win32.ERROR_ACCESS_DENIED          ,
	ERROR_INVALID_HANDLE         = win32.ERROR_INVALID_HANDLE         ,
	ERROR_NOT_ENOUGH_MEMORY      = win32.ERROR_NOT_ENOUGH_MEMORY      ,
	ERROR_INVALID_BLOCK          = win32.ERROR_INVALID_BLOCK          ,
	ERROR_BAD_ENVIRONMENT        = win32.ERROR_BAD_ENVIRONMENT        ,
	ERROR_BAD_FORMAT             = win32.ERROR_BAD_FORMAT             ,
	ERROR_INVALID_ACCESS         = win32.ERROR_INVALID_ACCESS         ,
	ERROR_INVALID_DATA           = win32.ERROR_INVALID_DATA           ,
	ERROR_OUTOFMEMORY            = win32.ERROR_OUTOFMEMORY            ,
	ERROR_INVALID_DRIVE          = win32.ERROR_INVALID_DRIVE          ,
	ERROR_CURRENT_DIRECTORY      = win32.ERROR_CURRENT_DIRECTORY      ,
	ERROR_NO_MORE_FILES          = win32.ERROR_NO_MORE_FILES          ,
	ERROR_SHARING_VIOLATION      = win32.ERROR_SHARING_VIOLATION      ,
	ERROR_LOCK_VIOLATION         = win32.ERROR_LOCK_VIOLATION         ,
	ERROR_HANDLE_EOF             = win32.ERROR_HANDLE_EOF             ,
	ERROR_NOT_SUPPORTED          = win32.ERROR_NOT_SUPPORTED          ,
	ERROR_FILE_EXISTS            = win32.ERROR_FILE_EXISTS            ,
	ERROR_INVALID_PARAMETER      = win32.ERROR_INVALID_PARAMETER      ,
	ERROR_BROKEN_PIPE            = win32.ERROR_BROKEN_PIPE            ,
	ERROR_CALL_NOT_IMPLEMENTED   = win32.ERROR_CALL_NOT_IMPLEMENTED   ,
	ERROR_INSUFFICIENT_BUFFER    = win32.ERROR_INSUFFICIENT_BUFFER    ,
	ERROR_INVALID_NAME           = win32.ERROR_INVALID_NAME           ,
	ERROR_NEGATIVE_SEEK          = win32.ERROR_NEGATIVE_SEEK          ,
	ERROR_BAD_ARGUMENTS          = win32.ERROR_BAD_ARGUMENTS          ,
	ERROR_LOCK_FAILED            = win32.ERROR_LOCK_FAILED            ,
	ERROR_ALREADY_EXISTS         = win32.ERROR_ALREADY_EXISTS         ,
	ERROR_NO_DATA                = win32.ERROR_NO_DATA                ,
	ERROR_ENVVAR_NOT_FOUND       = win32.ERROR_ENVVAR_NOT_FOUND       ,
	ERROR_MR_MID_NOT_FOUND       = win32.ERROR_MR_MID_NOT_FOUND       ,
	ERROR_OPERATION_ABORTED      = win32.ERROR_OPERATION_ABORTED      ,
	ERROR_IO_PENDING             = win32.ERROR_IO_PENDING             ,
	ERROR_NO_UNICODE_TRANSLATION = win32.ERROR_NO_UNICODE_TRANSLATION ,
	ERROR_NOT_FOUND              = win32.ERROR_NOT_FOUND              ,
	ERROR_TIMEOUT                = win32.ERROR_TIMEOUT                ,
	ERROR_DATATYPE_MISMATCH      = win32.ERROR_DATATYPE_MISMATCH      ,
	ERROR_UNSUPPORTED_TYPE       = win32.ERROR_UNSUPPORTED_TYPE       ,
	ERROR_NOT_SAME_OBJECT        = win32.ERROR_NOT_SAME_OBJECT        ,
	ERROR_PIPE_CONNECTED         = win32.ERROR_PIPE_CONNECTED         ,
	ERROR_PIPE_BUSY              = win32.ERROR_PIPE_BUSY              ,
}

// odinfmt: enable


Owin_Error :: enum u32 {
	OK = 0,
	Missing_Argument,
	Missing_HWND,
	Unable_To_ReleaseDC,
}

Error :: union #shared_nil {
	Owin_Error,
	Windows_Error,
	io.Error,
	runtime.Allocator_Error,
	os.Error,
	// os.Platform_Error,
	//Exit_Code,
}
//#assert(size_of(Error) == size_of(u64))
#assert(size_of(Error) == 12)
