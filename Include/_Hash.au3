$__iLineNumber=0
; #FUNCTION# ;===============================================================================
;
; Name...........: _MD5ForFile
; Description ...: Calculates MD5 value for the specific file.
; Syntax.........: _MD5ForFile ($sFile)
; Parameters ....: $sFile - Full path to the file to process.
; Return values .: Success - Returns MD5 value in form of hex string
;                          - Sets @error to 0
;                  Failure - Returns empty string and sets @error:
;                  |1 - CreateFile function or call to it failed.
;                  |2 - CreateFileMapping function or call to it failed.
;                  |3 - MapViewOfFile function or call to it failed.
;                  |4 - MD5Init function or call to it failed.
;                  |5 - MD5Update function or call to it failed.
;                  |6 - MD5Final function or call to it failed.
; Author ........: trancexx
;
;==========================================================================================
$__iLineNumber=19 & ' - Func _MD5ForFile($sFile)•./Include/_Hash.au3'
Func _MD5ForFile($sFile)

    $__iLineNumber=21 & ' - Local $a_hCall = DllCall("kernel32.dll", "hwnd", "CreateFile ...•./Include/_Hash.au3'
    Local $a_hCall = DllCall("kernel32.dll", "hwnd", "CreateFileW", _
            "wstr", $sFile, _
            "dword", 0x80000000, _ ; GENERIC_READ
            "dword", 3, _ ; FILE_SHARE_READ|FILE_SHARE_WRITE
            "ptr", 0, _
            "dword", 3, _ ; OPEN_EXISTING
            "dword", 0, _ ; SECURITY_ANONYMOUS
            "ptr", 0)

    $__iLineNumber=30 & ' - If @error Or $a_hCall[0] = -1 Then•./Include/_Hash.au3'
    If @error Or $a_hCall[0] = -1 Then
        $__iLineNumber=31 & ' - Return SetError(1, 0, "")•./Include/_Hash.au3'
        Return SetError(1, 0, "")
    EndIf

    $__iLineNumber=34 & ' - Local $hFile = $a_hCall[0]•./Include/_Hash.au3'
    Local $hFile = $a_hCall[0]

    $__iLineNumber=36 & ' - $a_hCall = DllCall("kernel32.dll", "ptr", "CreateFileMapping ...•./Include/_Hash.au3'
    $a_hCall = DllCall("kernel32.dll", "ptr", "CreateFileMappingW", _
            "hwnd", $hFile, _
            "dword", 0, _ ; default security descriptor
            "dword", 2, _ ; PAGE_READONLY
            "dword", 0, _
            "dword", 0, _
            "ptr", 0)

    $__iLineNumber=44 & ' - If @error Or Not $a_hCall[0] Then•./Include/_Hash.au3'
    If @error Or Not $a_hCall[0] Then
        $__iLineNumber=45 & ' - DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFile ...•./Include/_Hash.au3'
        DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFile)
        $__iLineNumber=46 & ' - Return SetError(2, 0, "")•./Include/_Hash.au3'
        Return SetError(2, 0, "")
    EndIf

    $__iLineNumber=49 & ' - DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFile ...•./Include/_Hash.au3'
    DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFile)

    $__iLineNumber=51 & ' - Local $hFileMappingObject = $a_hCall[0]•./Include/_Hash.au3'
    Local $hFileMappingObject = $a_hCall[0]

    $__iLineNumber=53 & ' - $a_hCall = DllCall("kernel32.dll", "ptr", "MapViewOfFile", _•./Include/_Hash.au3'
    $a_hCall = DllCall("kernel32.dll", "ptr", "MapViewOfFile", _
            "hwnd", $hFileMappingObject, _
            "dword", 4, _ ; FILE_MAP_READ
            "dword", 0, _
            "dword", 0, _
            "dword", 0)

    $__iLineNumber=60 & ' - If @error Or Not $a_hCall[0] Then•./Include/_Hash.au3'
    If @error Or Not $a_hCall[0] Then
        $__iLineNumber=61 & ' - DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFile ...•./Include/_Hash.au3'
        DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFileMappingObject)
        $__iLineNumber=62 & ' - Return SetError(3, 0, "")•./Include/_Hash.au3'
        Return SetError(3, 0, "")
    EndIf

    $__iLineNumber=65 & ' - Local $pFile = $a_hCall[0]•./Include/_Hash.au3'
    Local $pFile = $a_hCall[0]
    $__iLineNumber=66 & ' - Local $iBufferSize = FileGetSize($sFile)•./Include/_Hash.au3'
    Local $iBufferSize = FileGetSize($sFile)

    $__iLineNumber=68 & ' - Local $tMD5_CTX = DllStructCreate("dword i[2];" & _•./Include/_Hash.au3'
    Local $tMD5_CTX = DllStructCreate("dword i[2];" & _
            "dword buf[4];" & _
            "ubyte in[64];" & _
            "ubyte digest[16]")

    $__iLineNumber=73 & ' - DllCall("advapi32.dll", "none", "MD5Init", "ptr", DllStructG ...•./Include/_Hash.au3'
    DllCall("advapi32.dll", "none", "MD5Init", "ptr", DllStructGetPtr($tMD5_CTX))

    $__iLineNumber=75 & ' - If @error Then•./Include/_Hash.au3'
    If @error Then
        $__iLineNumber=76 & ' - DllCall("kernel32.dll", "int", "UnmapViewOfFile", "ptr", $pF ...•./Include/_Hash.au3'
        DllCall("kernel32.dll", "int", "UnmapViewOfFile", "ptr", $pFile)
        $__iLineNumber=77 & ' - DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFile ...•./Include/_Hash.au3'
        DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFileMappingObject)
        $__iLineNumber=78 & ' - Return SetError(4, 0, "")•./Include/_Hash.au3'
        Return SetError(4, 0, "")
    EndIf

    $__iLineNumber=81 & ' - DllCall("advapi32.dll", "none", "MD5Update", _•./Include/_Hash.au3'
    DllCall("advapi32.dll", "none", "MD5Update", _
            "ptr", DllStructGetPtr($tMD5_CTX), _
            "ptr", $pFile, _
            "dword", $iBufferSize)

    $__iLineNumber=86 & ' - If @error Then•./Include/_Hash.au3'
    If @error Then
        $__iLineNumber=87 & ' - DllCall("kernel32.dll", "int", "UnmapViewOfFile", "ptr", $pF ...•./Include/_Hash.au3'
        DllCall("kernel32.dll", "int", "UnmapViewOfFile", "ptr", $pFile)
        $__iLineNumber=88 & ' - DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFile ...•./Include/_Hash.au3'
        DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFileMappingObject)
        $__iLineNumber=89 & ' - Return SetError(5, 0, "")•./Include/_Hash.au3'
        Return SetError(5, 0, "")
    EndIf

    $__iLineNumber=92 & ' - DllCall("advapi32.dll", "none", "MD5Final", "ptr", DllStruct ...•./Include/_Hash.au3'
    DllCall("advapi32.dll", "none", "MD5Final", "ptr", DllStructGetPtr($tMD5_CTX))

    $__iLineNumber=94 & ' - If @error Then•./Include/_Hash.au3'
    If @error Then
        $__iLineNumber=95 & ' - DllCall("kernel32.dll", "int", "UnmapViewOfFile", "ptr", $pF ...•./Include/_Hash.au3'
        DllCall("kernel32.dll", "int", "UnmapViewOfFile", "ptr", $pFile)
        $__iLineNumber=96 & ' - DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFile ...•./Include/_Hash.au3'
        DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFileMappingObject)
        $__iLineNumber=97 & ' - Return SetError(6, 0, "")•./Include/_Hash.au3'
        Return SetError(6, 0, "")
    EndIf

    $__iLineNumber=100 & ' - DllCall("kernel32.dll", "int", "UnmapViewOfFile", "ptr", $pF ...•./Include/_Hash.au3'
    DllCall("kernel32.dll", "int", "UnmapViewOfFile", "ptr", $pFile)
    $__iLineNumber=101 & ' - DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFile ...•./Include/_Hash.au3'
    DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFileMappingObject)

    $__iLineNumber=103 & ' - Local $sMD5 = Hex(DllStructGetData($tMD5_CTX, "digest"))•./Include/_Hash.au3'
    Local $sMD5 = Hex(DllStructGetData($tMD5_CTX, "digest"))

    $__iLineNumber=105 & ' - Return SetError(0, 0, $sMD5)•./Include/_Hash.au3'
    Return SetError(0, 0, $sMD5)

EndFunc   ;==>_MD5ForFile

; #FUNCTION# ;===============================================================================
;
; Name...........: _CRC32ForFile
; Description ...: Calculates CRC32 value for the specific file.
; Syntax.........: _CRC32ForFile ($sFile)
; Parameters ....: $sFile - Full path to the file to process.
; Return values .: Success - Returns CRC32 value in form of hex string
;                          - Sets @error to 0
;                  Failure - Returns empty string and sets @error:
;                  |1 - CreateFile function or call to it failed.
;                  |2 - CreateFileMapping function or call to it failed.
;                  |3 - MapViewOfFile function or call to it failed.
;                  |4 - RtlComputeCrc32 function or call to it failed.
; Author ........: trancexx
;
;==========================================================================================
$__iLineNumber=125 & ' - Func _CRC32ForFile($sFile)•./Include/_Hash.au3'
Func _CRC32ForFile($sFile)

    $__iLineNumber=127 & ' - Local $a_hCall = DllCall("kernel32.dll", "hwnd", "CreateFile ...•./Include/_Hash.au3'
    Local $a_hCall = DllCall("kernel32.dll", "hwnd", "CreateFileW", _
            "wstr", $sFile, _
            "dword", 0x80000000, _ ; GENERIC_READ
            "dword", 3, _ ; FILE_SHARE_READ|FILE_SHARE_WRITE
            "ptr", 0, _
            "dword", 3, _ ; OPEN_EXISTING
            "dword", 0, _ ; SECURITY_ANONYMOUS
            "ptr", 0)

    $__iLineNumber=136 & ' - If @error Or $a_hCall[0] = -1 Then•./Include/_Hash.au3'
    If @error Or $a_hCall[0] = -1 Then
        $__iLineNumber=137 & ' - Return SetError(1, 0, "")•./Include/_Hash.au3'
        Return SetError(1, 0, "")
    EndIf

    $__iLineNumber=140 & ' - Local $hFile = $a_hCall[0]•./Include/_Hash.au3'
    Local $hFile = $a_hCall[0]

    $__iLineNumber=142 & ' - $a_hCall = DllCall("kernel32.dll", "ptr", "CreateFileMapping ...•./Include/_Hash.au3'
    $a_hCall = DllCall("kernel32.dll", "ptr", "CreateFileMappingW", _
            "hwnd", $hFile, _
            "dword", 0, _ ; default security descriptor
            "dword", 2, _ ; PAGE_READONLY
            "dword", 0, _
            "dword", 0, _
            "ptr", 0)

    $__iLineNumber=150 & ' - If @error Or Not $a_hCall[0] Then•./Include/_Hash.au3'
    If @error Or Not $a_hCall[0] Then
        $__iLineNumber=151 & ' - DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFile ...•./Include/_Hash.au3'
        DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFile)
        $__iLineNumber=152 & ' - Return SetError(2, 0, "")•./Include/_Hash.au3'
        Return SetError(2, 0, "")
    EndIf

    $__iLineNumber=155 & ' - DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFile ...•./Include/_Hash.au3'
    DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFile)

    $__iLineNumber=157 & ' - Local $hFileMappingObject = $a_hCall[0]•./Include/_Hash.au3'
    Local $hFileMappingObject = $a_hCall[0]

    $__iLineNumber=159 & ' - $a_hCall = DllCall("kernel32.dll", "ptr", "MapViewOfFile", _•./Include/_Hash.au3'
    $a_hCall = DllCall("kernel32.dll", "ptr", "MapViewOfFile", _
            "hwnd", $hFileMappingObject, _
            "dword", 4, _ ; FILE_MAP_READ
            "dword", 0, _
            "dword", 0, _
            "dword", 0)

    $__iLineNumber=166 & ' - If @error Or Not $a_hCall[0] Then•./Include/_Hash.au3'
    If @error Or Not $a_hCall[0] Then
        $__iLineNumber=167 & ' - DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFile ...•./Include/_Hash.au3'
        DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFileMappingObject)
        $__iLineNumber=168 & ' - Return SetError(3, 0, "")•./Include/_Hash.au3'
        Return SetError(3, 0, "")
    EndIf

    $__iLineNumber=171 & ' - Local $pFile = $a_hCall[0]•./Include/_Hash.au3'
    Local $pFile = $a_hCall[0]
    $__iLineNumber=172 & ' - Local $iBufferSize = FileGetSize($sFile)•./Include/_Hash.au3'
    Local $iBufferSize = FileGetSize($sFile)

    $__iLineNumber=174 & ' - Local $a_iCall = DllCall("ntdll.dll", "dword", "RtlComputeCr ...•./Include/_Hash.au3'
    Local $a_iCall = DllCall("ntdll.dll", "dword", "RtlComputeCrc32", _
            "dword", 0, _
            "ptr", $pFile, _
            "int", $iBufferSize)

    $__iLineNumber=179 & ' - If @error Or Not $a_iCall[0] Then•./Include/_Hash.au3'
    If @error Or Not $a_iCall[0] Then
        $__iLineNumber=180 & ' - DllCall("kernel32.dll", "int", "UnmapViewOfFile", "ptr", $pF ...•./Include/_Hash.au3'
        DllCall("kernel32.dll", "int", "UnmapViewOfFile", "ptr", $pFile)
        $__iLineNumber=181 & ' - DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFile ...•./Include/_Hash.au3'
        DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFileMappingObject)
        $__iLineNumber=182 & ' - Return SetError(4, 0, "")•./Include/_Hash.au3'
        Return SetError(4, 0, "")
    EndIf

    $__iLineNumber=185 & ' - DllCall("kernel32.dll", "int", "UnmapViewOfFile", "ptr", $pF ...•./Include/_Hash.au3'
    DllCall("kernel32.dll", "int", "UnmapViewOfFile", "ptr", $pFile)
    $__iLineNumber=186 & ' - DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFile ...•./Include/_Hash.au3'
    DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFileMappingObject)

    $__iLineNumber=188 & ' - Local $iCRC32 = $a_iCall[0]•./Include/_Hash.au3'
    Local $iCRC32 = $a_iCall[0]

    $__iLineNumber=190 & ' - Return SetError(0, 0, Hex($iCRC32))•./Include/_Hash.au3'
    Return SetError(0, 0, Hex($iCRC32))

EndFunc   ;==>_CRC32ForFile

; #FUNCTION# ;===============================================================================
;
; Name...........: _SHA1ForFile
; Description ...: Calculates SHA1 value for the specific file.
; Syntax.........: _SHA1ForFile ($sFile)
; Parameters ....: $sFile - Full path to the file to process.
; Return values .: Success - Returns SHA1 value in form of hex string
;                          - Sets @error to 0
;                  Failure - Returns empty string and sets @error:
;                  |1 - CreateFile function or call to it failed.
;                  |2 - CreateFileMapping function or call to it failed.
;                  |3 - MapViewOfFile function or call to it failed.
;                  |4 - CryptAcquireContext function or call to it failed.
;                  |5 - CryptCreateHash function or call to it failed.
;                  |6 - CryptHashData function or call to it failed.
;                  |7 - CryptGetHashParam function or call to it failed.
; Author ........: trancexx
;
;==========================================================================================
$__iLineNumber=213 & ' - Func _SHA1ForFile($sFile)•./Include/_Hash.au3'
Func _SHA1ForFile($sFile)

    $__iLineNumber=215 & ' - Local $a_hCall = DllCall("kernel32.dll", "hwnd", "CreateFile ...•./Include/_Hash.au3'
    Local $a_hCall = DllCall("kernel32.dll", "hwnd", "CreateFileW", _
            "wstr", $sFile, _
            "dword", 0x80000000, _ ; GENERIC_READ
            "dword", 3, _ ; FILE_SHARE_READ|FILE_SHARE_WRITE
            "ptr", 0, _
            "dword", 3, _ ; OPEN_EXISTING
            "dword", 0, _ ; SECURITY_ANONYMOUS
            "ptr", 0)

    $__iLineNumber=224 & ' - If @error Or $a_hCall[0] = -1 Then•./Include/_Hash.au3'
    If @error Or $a_hCall[0] = -1 Then
        $__iLineNumber=225 & ' - Return SetError(1, 0, "")•./Include/_Hash.au3'
        Return SetError(1, 0, "")
    EndIf

    $__iLineNumber=228 & ' - Local $hFile = $a_hCall[0]•./Include/_Hash.au3'
    Local $hFile = $a_hCall[0]

    $__iLineNumber=230 & ' - $a_hCall = DllCall("kernel32.dll", "ptr", "CreateFileMapping ...•./Include/_Hash.au3'
    $a_hCall = DllCall("kernel32.dll", "ptr", "CreateFileMappingW", _
            "hwnd", $hFile, _
            "dword", 0, _ ; default security descriptor
            "dword", 2, _ ; PAGE_READONLY
            "dword", 0, _
            "dword", 0, _
            "ptr", 0)

    $__iLineNumber=238 & ' - If @error Or Not $a_hCall[0] Then•./Include/_Hash.au3'
    If @error Or Not $a_hCall[0] Then
        $__iLineNumber=239 & ' - DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFile ...•./Include/_Hash.au3'
        DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFile)
        $__iLineNumber=240 & ' - Return SetError(2, 0, "")•./Include/_Hash.au3'
        Return SetError(2, 0, "")
    EndIf

    $__iLineNumber=243 & ' - DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFile ...•./Include/_Hash.au3'
    DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFile)

    $__iLineNumber=245 & ' - Local $hFileMappingObject = $a_hCall[0]•./Include/_Hash.au3'
    Local $hFileMappingObject = $a_hCall[0]

    $__iLineNumber=247 & ' - $a_hCall = DllCall("kernel32.dll", "ptr", "MapViewOfFile", _•./Include/_Hash.au3'
    $a_hCall = DllCall("kernel32.dll", "ptr", "MapViewOfFile", _
            "hwnd", $hFileMappingObject, _
            "dword", 4, _ ; FILE_MAP_READ
            "dword", 0, _
            "dword", 0, _
            "dword", 0)

    $__iLineNumber=254 & ' - If @error Or Not $a_hCall[0] Then•./Include/_Hash.au3'
    If @error Or Not $a_hCall[0] Then
        $__iLineNumber=255 & ' - DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFile ...•./Include/_Hash.au3'
        DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFileMappingObject)
        $__iLineNumber=256 & ' - Return SetError(3, 0, "")•./Include/_Hash.au3'
        Return SetError(3, 0, "")
    EndIf

    $__iLineNumber=259 & ' - Local $pFile = $a_hCall[0]•./Include/_Hash.au3'
    Local $pFile = $a_hCall[0]
    $__iLineNumber=260 & ' - Local $iBufferSize = FileGetSize($sFile)•./Include/_Hash.au3'
    Local $iBufferSize = FileGetSize($sFile)

    $__iLineNumber=262 & ' - Local $a_iCall = DllCall("advapi32.dll", "int", "CryptAcquir ...•./Include/_Hash.au3'
    Local $a_iCall = DllCall("advapi32.dll", "int", "CryptAcquireContext", _
            "ptr*", 0, _
            "ptr", 0, _
            "ptr", 0, _
            "dword", 1, _ ; PROV_RSA_FULL
            "dword", 0xF0000000) ; CRYPT_VERIFYCONTEXT

    $__iLineNumber=269 & ' - If @error Or Not $a_iCall[0] Then•./Include/_Hash.au3'
    If @error Or Not $a_iCall[0] Then
        $__iLineNumber=270 & ' - DllCall("kernel32.dll", "int", "UnmapViewOfFile", "ptr", $pF ...•./Include/_Hash.au3'
        DllCall("kernel32.dll", "int", "UnmapViewOfFile", "ptr", $pFile)
        $__iLineNumber=271 & ' - DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFile ...•./Include/_Hash.au3'
        DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFileMappingObject)
        $__iLineNumber=272 & ' - Return SetError(4, 0, "")•./Include/_Hash.au3'
        Return SetError(4, 0, "")
    EndIf

    $__iLineNumber=275 & ' - Local $hContext = $a_iCall[1]•./Include/_Hash.au3'
    Local $hContext = $a_iCall[1]

    $__iLineNumber=277 & ' - $a_iCall = DllCall("advapi32.dll", "int", "CryptCreateHash", ...•./Include/_Hash.au3'
    $a_iCall = DllCall("advapi32.dll", "int", "CryptCreateHash", _
            "ptr", $hContext, _
            "dword", 0x00008004, _ ; CALG_SHA1
            "ptr", 0, _ ; nonkeyed
            "dword", 0, _
            "ptr*", 0)

    $__iLineNumber=284 & ' - If @error Or Not $a_iCall[0] Then•./Include/_Hash.au3'
    If @error Or Not $a_iCall[0] Then
        $__iLineNumber=285 & ' - DllCall("kernel32.dll", "int", "UnmapViewOfFile", "ptr", $pF ...•./Include/_Hash.au3'
        DllCall("kernel32.dll", "int", "UnmapViewOfFile", "ptr", $pFile)
        $__iLineNumber=286 & ' - DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFile ...•./Include/_Hash.au3'
        DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFileMappingObject)
        $__iLineNumber=287 & ' - DllCall("advapi32.dll", "int", "CryptReleaseContext", "ptr", ...•./Include/_Hash.au3'
        DllCall("advapi32.dll", "int", "CryptReleaseContext", "ptr", $hContext, "dword", 0)
        $__iLineNumber=288 & ' - Return SetError(5, 0, "")•./Include/_Hash.au3'
        Return SetError(5, 0, "")
    EndIf

    $__iLineNumber=291 & ' - Local $hHashSHA1 = $a_iCall[5]•./Include/_Hash.au3'
    Local $hHashSHA1 = $a_iCall[5]

    $__iLineNumber=293 & ' - $a_iCall = DllCall("advapi32.dll", "int", "CryptHashData", _•./Include/_Hash.au3'
    $a_iCall = DllCall("advapi32.dll", "int", "CryptHashData", _
            "ptr", $hHashSHA1, _
            "ptr", $pFile, _
            "dword", $iBufferSize, _
            "dword", 0)

    $__iLineNumber=299 & ' - If @error Or Not $a_iCall[0] Then•./Include/_Hash.au3'
    If @error Or Not $a_iCall[0] Then
        $__iLineNumber=300 & ' - DllCall("kernel32.dll", "int", "UnmapViewOfFile", "ptr", $pF ...•./Include/_Hash.au3'
        DllCall("kernel32.dll", "int", "UnmapViewOfFile", "ptr", $pFile)
        $__iLineNumber=301 & ' - DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFile ...•./Include/_Hash.au3'
        DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFileMappingObject)
        $__iLineNumber=302 & ' - DllCall("advapi32.dll", "int", "CryptDestroyHash", "ptr", $h ...•./Include/_Hash.au3'
        DllCall("advapi32.dll", "int", "CryptDestroyHash", "ptr", $hHashSHA1)
        $__iLineNumber=303 & ' - DllCall("advapi32.dll", "int", "CryptReleaseContext", "ptr", ...•./Include/_Hash.au3'
        DllCall("advapi32.dll", "int", "CryptReleaseContext", "ptr", $hContext, "dword", 0)
        $__iLineNumber=304 & ' - Return SetError(6, 0, "")•./Include/_Hash.au3'
        Return SetError(6, 0, "")
    EndIf

    $__iLineNumber=307 & ' - Local $tOutSHA1 = DllStructCreate("byte[20]")•./Include/_Hash.au3'
    Local $tOutSHA1 = DllStructCreate("byte[20]")

    $__iLineNumber=309 & ' - $a_iCall = DllCall("advapi32.dll", "int", "CryptGetHashParam ...•./Include/_Hash.au3'
    $a_iCall = DllCall("advapi32.dll", "int", "CryptGetHashParam", _
            "ptr", $hHashSHA1, _
            "dword", 2, _ ; HP_HASHVAL
            "ptr", DllStructGetPtr($tOutSHA1), _
            "dword*", 20, _
            "dword", 0)

    $__iLineNumber=316 & ' - If @error Or Not $a_iCall[0] Then•./Include/_Hash.au3'
    If @error Or Not $a_iCall[0] Then
        $__iLineNumber=317 & ' - DllCall("kernel32.dll", "int", "UnmapViewOfFile", "ptr", $pF ...•./Include/_Hash.au3'
        DllCall("kernel32.dll", "int", "UnmapViewOfFile", "ptr", $pFile)
        $__iLineNumber=318 & ' - DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFile ...•./Include/_Hash.au3'
        DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFileMappingObject)
        $__iLineNumber=319 & ' - DllCall("advapi32.dll", "int", "CryptDestroyHash", "ptr", $h ...•./Include/_Hash.au3'
        DllCall("advapi32.dll", "int", "CryptDestroyHash", "ptr", $hHashSHA1)
        $__iLineNumber=320 & ' - DllCall("advapi32.dll", "int", "CryptReleaseContext", "ptr", ...•./Include/_Hash.au3'
        DllCall("advapi32.dll", "int", "CryptReleaseContext", "ptr", $hContext, "dword", 0)
        $__iLineNumber=321 & ' - Return SetError(7, 0, "")•./Include/_Hash.au3'
        Return SetError(7, 0, "")
    EndIf

    $__iLineNumber=324 & ' - DllCall("kernel32.dll", "int", "UnmapViewOfFile", "ptr", $pF ...•./Include/_Hash.au3'
    DllCall("kernel32.dll", "int", "UnmapViewOfFile", "ptr", $pFile)
    $__iLineNumber=325 & ' - DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFile ...•./Include/_Hash.au3'
    DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFileMappingObject)

    $__iLineNumber=327 & ' - DllCall("advapi32.dll", "int", "CryptDestroyHash", "ptr", $h ...•./Include/_Hash.au3'
    DllCall("advapi32.dll", "int", "CryptDestroyHash", "ptr", $hHashSHA1)

    $__iLineNumber=329 & ' - Local $sSHA1 = Hex(DllStructGetData($tOutSHA1, 1))•./Include/_Hash.au3'
    Local $sSHA1 = Hex(DllStructGetData($tOutSHA1, 1))

    $__iLineNumber=331 & ' - DllCall("advapi32.dll", "int", "CryptReleaseContext", "ptr", ...•./Include/_Hash.au3'
    DllCall("advapi32.dll", "int", "CryptReleaseContext", "ptr", $hContext, "dword", 0)

    $__iLineNumber=333 & ' - Return SetError(0, 0, $sSHA1)•./Include/_Hash.au3'
    Return SetError(0, 0, $sSHA1)

EndFunc   ;==>_SHA1ForFile
