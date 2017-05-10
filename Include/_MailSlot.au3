$__iLineNumber=0

; MailSlot.au3
;.......script written by trancexx (trancexx at yahoo dot com)

#cs
	$__iLineNumber=6 & ' - Available functions:•./Include/_MailSlot.au3'
	Available functions:
	$__iLineNumber=7 & ' - _MailSlotCheckForNextMessage•./Include/_MailSlot.au3'
	_MailSlotCheckForNextMessage
	$__iLineNumber=8 & ' - _MailSlotClose•./Include/_MailSlot.au3'
	_MailSlotClose
	$__iLineNumber=9 & ' - _MailSlotCreate•./Include/_MailSlot.au3'
	_MailSlotCreate
	$__iLineNumber=10 & ' - _MailSlotGetMessageCount•./Include/_MailSlot.au3'
	_MailSlotGetMessageCount
	$__iLineNumber=11 & ' - _MailSlotGetTimeout•./Include/_MailSlot.au3'
	_MailSlotGetTimeout
	$__iLineNumber=12 & ' - _MailSlotSetTimeout•./Include/_MailSlot.au3'
	_MailSlotSetTimeout
	$__iLineNumber=13 & ' - _MailSlotRead•./Include/_MailSlot.au3'
	_MailSlotRead
	$__iLineNumber=14 & ' - _MailSlotWrite•./Include/_MailSlot.au3'
	_MailSlotWrite
#ce

; #FUNCTION# ;===============================================================================
;
; Name...........: _MailSlotCheckForNextMessage
; Description ...: Checks for presence of a new message.
; Syntax.........: _MailSlotCheckForNextMessage ($hMailSlot)
; Parameters ....: $hMailSlot - Mailslot handle
; Return values .: Success - Returns 0 if there is no message or the size of a new message in bytes if there is one
;                          - Sets @error to 0
;                  Failure - Returns 0 and sets @error:
;                  |1 - GetMailslotInfo function or call to it failed.
; Author ........: trancexx
; Modified.......:
; Link ..........; http://msdn.microsoft.com/en-us/library/aa365435(VS.85).aspx
;
;==========================================================================================
$__iLineNumber=32 & ' - Func _MailSlotCheckForNextMessage($hMailSlot)•./Include/_MailSlot.au3'
Func _MailSlotCheckForNextMessage($hMailSlot)

	$__iLineNumber=34 & ' - Local $aCall = DllCall("kernel32.dll", "int", "GetMailslotIn ...•./Include/_MailSlot.au3'
	Local $aCall = DllCall("kernel32.dll", "int", "GetMailslotInfo", _
			"ptr", $hMailSlot, _
			"dword*", 0, _
			"dword*", 0, _
			"dword*", 0, _
			"dword*", 0)

	$__iLineNumber=41 & ' - If @error Or Not $aCall[0] Then•./Include/_MailSlot.au3'
	If @error Or Not $aCall[0] Then
		$__iLineNumber=42 & ' - Return SetError(1, 0, 0)•./Include/_MailSlot.au3'
		Return SetError(1, 0, 0)
	EndIf

	$__iLineNumber=45 & ' - If $aCall[3] = -1 Or Not $aCall[4] Then•./Include/_MailSlot.au3'
	If $aCall[3] = -1 Or Not $aCall[4] Then
		$__iLineNumber=46 & ' - Return 0•./Include/_MailSlot.au3'
		Return 0
	Else
		$__iLineNumber=48 & ' - Return $aCall[3]•./Include/_MailSlot.au3'
		Return $aCall[3]
	EndIf

EndFunc   ;==>_MailSlotCheckForNextMessage


; #FUNCTION# ;===============================================================================
;
; Name...........: _MailSlotClose
; Description ...: Closes mailslot.
; Syntax.........: _MailSlotClose ($hMailSlot)
; Parameters ....: $hMailSlot - Mailslot handle
; Return values .: Success - Returns 1
;                          - Sets @error to 0
;                  Failure - Returns 0 and sets @error:
;                  |1 - CloseHandle function or call to it failed.
; Author ........: trancexx
; Modified.......:
; Link ..........; http://msdn.microsoft.com/en-us/library/ms724211(VS.85).aspx
;
;==========================================================================================
$__iLineNumber=69 & ' - Func _MailSlotClose($hMailSlot)•./Include/_MailSlot.au3'
Func _MailSlotClose($hMailSlot)

	$__iLineNumber=71 & ' - Local $aCall = DllCall("kernel32.dll", "int", "CloseHandle", ...•./Include/_MailSlot.au3'
	Local $aCall = DllCall("kernel32.dll", "int", "CloseHandle", "ptr", $hMailSlot)

	$__iLineNumber=73 & ' - If @error Or Not $aCall[0] Then•./Include/_MailSlot.au3'
	If @error Or Not $aCall[0] Then
		$__iLineNumber=74 & ' - Return SetError(1, 0, 0)•./Include/_MailSlot.au3'
		Return SetError(1, 0, 0)
	EndIf

	$__iLineNumber=77 & ' - Return 1•./Include/_MailSlot.au3'
	Return 1

EndFunc   ;==>_MailSlotClose


; #FUNCTION# ;===============================================================================
;
; Name...........: _MailSlotCreate
; Description ...: Creates a mailslot with the specified name.
; Syntax.........: _MailSlotCreate ($sMailSlotName [,$iSize [, $iTimeOut [, $pSecurityAttributes])
; Parameters ....: $sMailSlotName - The name of the mailslot
;                  $iSize - The maximum size of a single message that can be written to the mailslot, in bytes. 0 means any size.
;                  $iTimeOut - The time a read operation can wait for a message to be written to the mailslot before a time-out occurs, in milliseconds.
;                              Can be 0 - returns immediately if no message is present
;                                     -1 (minus one) - waits forever for a message
;                  $pSecurityAttributes - A pointer to a SECURITY_ATTRIBUTES structure. 0 means the handle cannot be inherited.
; Return values .: Success - Returns a handle that a mailslot server can use to perform operations on the mailslot
;                          - Sets @error to 0
;                  Failure - Returns -1 and sets @error:
;                  |1 - CreateMailslotW function or call to it failed.
; Author ........: trancexx
; Modified.......:
; Remarks .......: Mailslot name must have the following form and must be unique: \\.\mailslot\[path]name
;                  The name may include multiple levels of pseudo directories separated by backslashes.
;                  For example \\.\mailslot\abc\def\ghi is valid name too.
; Link ..........; http://msdn.microsoft.com/en-us/library/aa365147(VS.85).aspx
;
;==========================================================================================
$__iLineNumber=105 & ' - Func _MailSlotCreate($sMailSlotName, $iSize = 0, $iTimeOut = ...•./Include/_MailSlot.au3'
Func _MailSlotCreate($sMailSlotName, $iSize = 0, $iTimeOut = 0, $pSecurityAttributes = 0)

	$__iLineNumber=107 & ' - Local $aCall = DllCall("kernel32.dll", "ptr", "CreateMailslo ...•./Include/_MailSlot.au3'
	Local $aCall = DllCall("kernel32.dll", "ptr", "CreateMailslotW", _
			"wstr", $sMailSlotName, _
			"dword", $iSize, _
			"dword", $iTimeOut, _
			"ptr", $pSecurityAttributes)

	$__iLineNumber=113 & ' - If @error Or $aCall[0] = -1 Then•./Include/_MailSlot.au3'
	If @error Or $aCall[0] = -1 Then
		$__iLineNumber=114 & ' - Return SetError(1, 0, -1)•./Include/_MailSlot.au3'
		Return SetError(1, 0, -1)
	EndIf

	$__iLineNumber=117 & ' - Return $aCall[0]•./Include/_MailSlot.au3'
	Return $aCall[0]

EndFunc   ;==>_MailSlotCreate


; #FUNCTION# ;===============================================================================
;
; Name...........: _MailSlotGetMessageCount
; Description ...: Retrieves the number of messages in the mailslot.
; Syntax.........: _MailSlotGetMessageCount ($hMailSlot)
; Parameters ....: $hMailSlot - Mailslot handle
; Return values .: Success - Returns the number of the messages in the mailslot waiting to be read.
;                          - Sets @error to 0
;                  Failure - Returns 0 and sets @error:
;                  |1 - GetMailslotInfo function or call to it failed.
; Author ........: trancexx
; Modified.......:
; Link ..........; http://msdn.microsoft.com/en-us/library/aa365435(VS.85).aspx
;
;==========================================================================================
$__iLineNumber=137 & ' - Func _MailSlotGetMessageCount($hMailSlot)•./Include/_MailSlot.au3'
Func _MailSlotGetMessageCount($hMailSlot)

	$__iLineNumber=139 & ' - Local $aCall = DllCall("kernel32.dll", "int", "GetMailslotIn ...•./Include/_MailSlot.au3'
	Local $aCall = DllCall("kernel32.dll", "int", "GetMailslotInfo", _
			"ptr", $hMailSlot, _
			"dword*", 0, _
			"dword*", 0, _
			"dword*", 0, _
			"dword*", 0)

	$__iLineNumber=146 & ' - If @error Or Not $aCall[0] Then•./Include/_MailSlot.au3'
	If @error Or Not $aCall[0] Then
		$__iLineNumber=147 & ' - Return SetError(1, 0, 0)•./Include/_MailSlot.au3'
		Return SetError(1, 0, 0)
	EndIf

	$__iLineNumber=150 & ' - If $aCall[3] = -1 Then•./Include/_MailSlot.au3'
	If $aCall[3] = -1 Then
		$__iLineNumber=151 & ' - Return 0•./Include/_MailSlot.au3'
		Return 0
	Else
		$__iLineNumber=153 & ' - Return $aCall[4]•./Include/_MailSlot.au3'
		Return $aCall[4]
	EndIf

EndFunc   ;==>_MailSlotGetMessageCount


; #FUNCTION# ;===============================================================================
;
; Name...........: _MailSlotGetTimeout
; Description ...: Gets the time-out value used by the specified mailslot for a read operation.
; Syntax.........: _MailSlotGetTimeout ($hMailSlot)
; Parameters ....: $hMailSlot - Mailslot handle
; Return values .: Success - Returns integer value representing the time a read operation can wait for a message to be written to the mailslot before a time-out occurs, in milliseconds.
;                          - Sets @error to 0
;                  Failure - Returns 0 and sets @error:
;                  |1 - GetMailslotInfo function or call to it failed.
; Author ........: trancexx
; Modified.......:
; Link ..........; http://msdn.microsoft.com/en-us/library/aa365435(VS.85).aspx
;
;==========================================================================================
$__iLineNumber=174 & ' - Func _MailSlotGetTimeout($hMailSlot)•./Include/_MailSlot.au3'
Func _MailSlotGetTimeout($hMailSlot)

	$__iLineNumber=176 & ' - Local $aCall = DllCall("kernel32.dll", "int", "GetMailslotIn ...•./Include/_MailSlot.au3'
	Local $aCall = DllCall("kernel32.dll", "int", "GetMailslotInfo", _
			"ptr", $hMailSlot, _
			"dword*", 0, _
			"dword*", 0, _
			"dword*", 0, _
			"int*", 0)

	$__iLineNumber=183 & ' - If @error Or Not $aCall[0] Then•./Include/_MailSlot.au3'
	If @error Or Not $aCall[0] Then
		$__iLineNumber=184 & ' - Return SetError(1, 0, 0)•./Include/_MailSlot.au3'
		Return SetError(1, 0, 0)
	EndIf

	$__iLineNumber=187 & ' - Return $aCall[5]•./Include/_MailSlot.au3'
	Return $aCall[5]

EndFunc   ;==>_MailSlotGetTimeout



; #FUNCTION# ;===============================================================================
;
; Name...........: _MailSlotSetTimeout
; Description ...: Sets the time-out value used by the specified mailslot for a read operation.
; Syntax.........: _MailSlotSetTimeout ($hMailSlot, $iTimeout)
; Parameters ....: $hMailSlot - Mailslot handle
;                  $iTimeout - The time a read operation can wait for a message to be written to the mailslot before a time-out occurs, in milliseconds.
;                              -1 (minus one) means for function to wait forever for a message.
;                              0 (zero) mans to return immediately if no message is present
; Return values .: Success - Returns 1.
;                          - Sets @error to 0
;                  Failure - Returns 0 and sets @error:
;                  |1 - SetMailslotInfo function or call to it failed.
; Author ........: trancexx
; Modified.......:
; Link ..........; http://msdn.microsoft.com/en-us/library/aa365786(VS.85).aspx
;
;==========================================================================================
$__iLineNumber=211 & ' - Func _MailSlotSetTimeout($hMailSlot, $iTimeOut)•./Include/_MailSlot.au3'
Func _MailSlotSetTimeout($hMailSlot, $iTimeOut)

	$__iLineNumber=213 & ' - Local $aCall = DllCall("kernel32.dll", "int", "SetMailslotIn ...•./Include/_MailSlot.au3'
	Local $aCall = DllCall("kernel32.dll", "int", "SetMailslotInfo", _
			"ptr", $hMailSlot, _
			"dword", $iTimeOut)

	$__iLineNumber=217 & ' - If @error Or Not $aCall[0] Then•./Include/_MailSlot.au3'
	If @error Or Not $aCall[0] Then
		$__iLineNumber=218 & ' - Return SetError(1, 0, 0)•./Include/_MailSlot.au3'
		Return SetError(1, 0, 0)
	EndIf

	$__iLineNumber=221 & ' - Return 1•./Include/_MailSlot.au3'
	Return 1

EndFunc   ;==>_MailSlotSetTimeout


; #FUNCTION# ;===============================================================================
;
; Name...........: _MailSlotRead
; Description ...: Reads messages from the specified mailslot.
; Syntax.........: _MailSlotRead ($hMailSlot , $iSize [, $iMode])
; Parameters ....: $hMailSlot - Mailslot handle
;                  $iSize - The number of bytes to read.
;                  $iMode - Reading mode.
;                             Can be: 0 - read binary
;                                     1 - read ANSI
;                                     2 - read UTF8
; Return values .: Success - Returns read data
;                          - Sets @extended to number of read bytes
;                          - Sets @error to 0
;                  Special: Sets @error to -1 if specified buffer to read to is too small.
;                  Failure - Returns empty string and sets @error:
;                  |1 - DllCall() to ReadFile failed.
;                  |2 - GetLastError function or call to it failed.
;                  |3 - ReadFile function failed. @extended will be set to the return value of the GetLastError function.
; Author ........: trancexx
; Modified.......:
; Link ..........; http://msdn.microsoft.com/en-us/library/aa365467(VS.85).aspx
;                  http://msdn.microsoft.com/en-us/library/ms679360(VS.85).aspx
;
;==========================================================================================
$__iLineNumber=251 & ' - Func _MailSlotRead($hMailSlot, $iSize, $iMode = 0)•./Include/_MailSlot.au3'
Func _MailSlotRead($hMailSlot, $iSize, $iMode = 0)

	$__iLineNumber=253 & ' - Local $tDataBuffer = DllStructCreate("byte[" & $iSize & "]")•./Include/_MailSlot.au3'
	Local $tDataBuffer = DllStructCreate("byte[" & $iSize & "]")

	$__iLineNumber=255 & ' - Local $aCall = DllCall("kernel32.dll", "int", "ReadFile", _•./Include/_MailSlot.au3'
	Local $aCall = DllCall("kernel32.dll", "int", "ReadFile", _
			"ptr", $hMailSlot, _
			"ptr", DllStructGetPtr($tDataBuffer), _
			"dword", $iSize, _
			"dword*", 0, _
			"ptr", 0)

	$__iLineNumber=262 & ' - If @error Then•./Include/_MailSlot.au3'
	If @error Then
		$__iLineNumber=263 & ' - Return SetError(1, 0, "")•./Include/_MailSlot.au3'
		Return SetError(1, 0, "")
	EndIf

	$__iLineNumber=266 & ' - If Not $aCall[0] Then•./Include/_MailSlot.au3'
	If Not $aCall[0] Then
		$__iLineNumber=267 & ' - Local $aLastErrorCall = DllCall("kernel32.dll", "int", "GetL ...•./Include/_MailSlot.au3'
		Local $aLastErrorCall = DllCall("kernel32.dll", "int", "GetLastError")
		$__iLineNumber=268 & ' - If @error Then•./Include/_MailSlot.au3'
		If @error Then
			$__iLineNumber=269 & ' - Return SetError(2, 0, "")•./Include/_MailSlot.au3'
			Return SetError(2, 0, "")
		EndIf
		$__iLineNumber=271 & ' - If $aLastErrorCall[0] = 122 Then ; ERROR_INSUFFICIENT_BUFFER•./Include/_MailSlot.au3'
		If $aLastErrorCall[0] = 122 Then ; ERROR_INSUFFICIENT_BUFFER
			$__iLineNumber=272 & ' - Return SetError(-1, 0, "")•./Include/_MailSlot.au3'
			Return SetError(-1, 0, "")
		Else
			$__iLineNumber=274 & ' - Return SetError(3, $aLastErrorCall[0], "")•./Include/_MailSlot.au3'
			Return SetError(3, $aLastErrorCall[0], "")
		EndIf
	EndIf

	$__iLineNumber=278 & ' - Local $vOut•./Include/_MailSlot.au3'
	Local $vOut

	$__iLineNumber=280 & ' - Switch $iMode•./Include/_MailSlot.au3'
	$__iLineNumber=281 & ' - Case 1•./Include/_MailSlot.au3'
	Switch $iMode
		Case 1
			$__iLineNumber=282 & ' - $vOut = BinaryToString(DllStructGetData($tDataBuffer, 1))•./Include/_MailSlot.au3'
			$vOut = BinaryToString(DllStructGetData($tDataBuffer, 1))
		$__iLineNumber=283 & ' - Case 2•./Include/_MailSlot.au3'
		Case 2
			$__iLineNumber=284 & ' - $vOut = BinaryToString(DllStructGetData($tDataBuffer, 1), 4)•./Include/_MailSlot.au3'
			$vOut = BinaryToString(DllStructGetData($tDataBuffer, 1), 4)
		Case Else
			$__iLineNumber=286 & ' - $vOut = DllStructGetData($tDataBuffer, 1)•./Include/_MailSlot.au3'
			$vOut = DllStructGetData($tDataBuffer, 1)
	EndSwitch

	$__iLineNumber=289 & ' - Return SetError(0, $aCall[4], $vOut)•./Include/_MailSlot.au3'
	Return SetError(0, $aCall[4], $vOut)

EndFunc   ;==>_MailSlotRead


; #FUNCTION# ;===============================================================================
;
; Name...........: _MailSlotWrite
; Description ...: Writes message to the specified mailslot.
; Syntax.........: _MailSlotWrite ($sMailSlotName , $vData [, $iMode])
; Parameters ....: $hMailSlot - Mailslot name
;                  $vData - Data to write.
;                  $iMode - Writing mode.
;                             Can be: 0 - write binary
;                                     1 - write ANSI
;                                     2 - write UTF8
; Return values .: Success - Returns the number of written bytes
;                          - Sets @error to 0
;                  Failure - Returns empty string and sets @error:
;                  |1 - CreateFileW function or call to it failed.
;                  |2 - WriteFile function or call to it failed.
;                  |3 - Opened mail slot handle could not be closed.
;                  |4 - WriteFile function or call to it failed and additionally opened mail slot handle could not be closed.
; Author ........: trancexx
; Modified.......:
; Link ..........; http://msdn.microsoft.com/en-us/library/aa363858(VS.85).aspx
;                  http://msdn.microsoft.com/en-us/library/aa365747(VS.85).aspx
;                  http://msdn.microsoft.com/en-us/library/ms724211(VS.85).aspx
;
;==========================================================================================
$__iLineNumber=319 & ' - Func _MailSlotWrite($sMailSlotName, $vData, $iMode = 0)•./Include/_MailSlot.au3'
Func _MailSlotWrite($sMailSlotName, $vData, $iMode = 0)

	$__iLineNumber=321 & ' - Local $aCall = DllCall("kernel32.dll", "ptr", "CreateFileW", ...•./Include/_MailSlot.au3'
	Local $aCall = DllCall("kernel32.dll", "ptr", "CreateFileW", _
			"wstr", $sMailSlotName, _
			"dword", 0x40000000, _ ; GENERIC_WRITE
			"dword", 1, _ ; FILE_SHARE_READ
			"ptr", 0, _
			"dword", 3, _ ; OPEN_EXISTING
			"dword", 0, _ ; SECURITY_ANONYMOUS
			"ptr", 0)

	$__iLineNumber=330 & ' - If @error Or $aCall[0] = -1 Then•./Include/_MailSlot.au3'
	If @error Or $aCall[0] = -1 Then
		$__iLineNumber=331 & ' - Return SetError(1, 0, 0)•./Include/_MailSlot.au3'
		Return SetError(1, 0, 0)
	EndIf

	$__iLineNumber=334 & ' - Local $hMailSlotHandle = $aCall[0]•./Include/_MailSlot.au3'
	Local $hMailSlotHandle = $aCall[0]

	$__iLineNumber=336 & ' - Local $bData•./Include/_MailSlot.au3'
	Local $bData

	$__iLineNumber=338 & ' - Switch $iMode•./Include/_MailSlot.au3'
	$__iLineNumber=339 & ' - Case 1•./Include/_MailSlot.au3'
	Switch $iMode
		Case 1
			$__iLineNumber=340 & ' - $bData = StringToBinary($vData, 1)•./Include/_MailSlot.au3'
			$bData = StringToBinary($vData, 1)
		$__iLineNumber=341 & ' - Case 2•./Include/_MailSlot.au3'
		Case 2
			$__iLineNumber=342 & ' - $bData = StringToBinary($vData, 4)•./Include/_MailSlot.au3'
			$bData = StringToBinary($vData, 4)
		Case Else
			$__iLineNumber=344 & ' - $bData = $vData•./Include/_MailSlot.au3'
			$bData = $vData
	EndSwitch

	$__iLineNumber=347 & ' - Local $iBufferSize = BinaryLen($bData)•./Include/_MailSlot.au3'
	Local $iBufferSize = BinaryLen($bData)

	$__iLineNumber=349 & ' - Local $tDataBuffer = DllStructCreate("byte[" & $iBufferSize  ...•./Include/_MailSlot.au3'
	Local $tDataBuffer = DllStructCreate("byte[" & $iBufferSize & "]")
	$__iLineNumber=350 & ' - DllStructSetData($tDataBuffer, 1, $bData)•./Include/_MailSlot.au3'
	DllStructSetData($tDataBuffer, 1, $bData)

	$__iLineNumber=352 & ' - $aCall = DllCall("kernel32.dll", "int", "WriteFile", _•./Include/_MailSlot.au3'
	$aCall = DllCall("kernel32.dll", "int", "WriteFile", _
			"ptr", $hMailSlotHandle, _
			"ptr", DllStructGetPtr($tDataBuffer), _
			"dword", $iBufferSize, _
			"dword*", 0, _
			"ptr", 0)

	$__iLineNumber=359 & ' - If @error Or Not $aCall[0] Then•./Include/_MailSlot.au3'
	If @error Or Not $aCall[0] Then
		$__iLineNumber=360 & ' - $aCall = DllCall("kernel32.dll", "int", "CloseHandle", "ptr" ...•./Include/_MailSlot.au3'
		$aCall = DllCall("kernel32.dll", "int", "CloseHandle", "ptr", $hMailSlotHandle)
		$__iLineNumber=361 & ' - If @error Or Not $aCall[0] Then•./Include/_MailSlot.au3'
		If @error Or Not $aCall[0] Then
			$__iLineNumber=362 & ' - Return SetError(4, 0, 0)•./Include/_MailSlot.au3'
			Return SetError(4, 0, 0)
		EndIf
		$__iLineNumber=364 & ' - Return SetError(2, 0, 0)•./Include/_MailSlot.au3'
		Return SetError(2, 0, 0)
	EndIf

	$__iLineNumber=367 & ' - Local $iOut = $aCall[4]•./Include/_MailSlot.au3'
	Local $iOut = $aCall[4]

	$__iLineNumber=369 & ' - $aCall = DllCall("kernel32.dll", "int", "CloseHandle", "ptr" ...•./Include/_MailSlot.au3'
	$aCall = DllCall("kernel32.dll", "int", "CloseHandle", "ptr", $hMailSlotHandle)
	$__iLineNumber=370 & ' - If @error Or Not $aCall[0] Then•./Include/_MailSlot.au3'
	If @error Or Not $aCall[0] Then
		$__iLineNumber=371 & ' - Return SetError(3, 0, $iOut)•./Include/_MailSlot.au3'
		Return SetError(3, 0, $iOut)
	EndIf

	$__iLineNumber=374 & ' - Return $iOut•./Include/_MailSlot.au3'
	Return $iOut

EndFunc   ;==>_MailSlotWrite
