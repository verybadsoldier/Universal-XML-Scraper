$__iLineNumber=0
#include-once

; #INDEX# ============================================================================================================
; Title .........: _StringSize
; AutoIt Version : v3.2.12.1 or higher
; Language ......: English
; Description ...: Returns size of rectangle required to display string - maximum width can be chosen
; Remarks .......:
; Note ..........:
; Author(s) .....:  Melba23 - thanks to trancexx for the default DC code
; ====================================================================================================================

;#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

; #CURRENT# ==========================================================================================================
; _StringSize: Returns size of rectangle required to display string - maximum width can be chosen
; ====================================================================================================================

; #INTERNAL_USE_ONLY#=================================================================================================
; _StringSize_Error_Close: Releases DC and deletes font object after error
; _StringSize_DefaultFontName: Determines Windows default font
; ====================================================================================================================

; #FUNCTION# =========================================================================================================
; Name...........: _StringSize
; Description ...: Returns size of rectangle required to display string - maximum permitted width can be chosen
; Syntax ........: _StringSize($sText[, $iSize[, $iWeight[, $iAttrib[, $sName[, $iWidth[, $hWnd]]]]]])
; Parameters ....: $sText   - String to display
;                  $iSize   - [optional] Font size in points - (default = 8.5)
;                  $iWeight - [optional] Font weight - (default = 400 = normal)
;                  $iAttrib - [optional] Font attribute (0-Normal (default), 2-Italic, 4-Underline, 8 Strike)
;                             + 1 if tabs are to be expanded before sizing
;                  $sName   - [optional] Font name - (default = Tahoma)
;                  $iWidth  - [optional] Max width for rectangle - (default = 0 => width of original string)
;                  $hWnd    - [optional] GUI in which string will be displayed - (default 0 => normally not required)
; Requirement(s) : v3.2.12.1 or higher
; Return values .: Success - Returns 4-element array: ($iWidth set // $iWidth not set)
;                  |$array[0] = String reformatted with additonal @CRLF // Original string
;                  |$array[1] = Height of single line in selected font // idem
;                  |$array[2] = Width of rectangle required for reformatted // original string
;                  |$array[3] = Height of rectangle required for reformatted // original string
;                  Failure - Returns 0 and sets @error:
;                  |1 - Incorrect parameter type (@extended = parameter index)
;                  |2 - DLL call error - extended set as follows:
;                       |1 - GetDC failure
;                       |2 - SendMessage failure
;                       |3 - GetDeviceCaps failure
;                       |4 - CreateFont failure
;                       |5 - SelectObject failure
;                       |6 - GetTextExtentPoint32 failure
;                  |3 - Font too large for chosen max width - a word will not fit
; Author ........: Melba23 - thanks to trancexx for the default DC code
; Modified ......:
; Remarks .......: The use of the $hWnd parameter is not normally necessary - it is only required if the UDF does not
;                   return correct dimensions without it.
; Related .......:
; Link ..........:
; Example .......: Yes
;=====================================================================================================================
$__iLineNumber=60 & ' - Func _StringSize($sText, $iSize = 8.5, $iWeight = 400, $iAtt ...•StringSize.au3'
Func _StringSize($sText, $iSize = 8.5, $iWeight = 400, $iAttrib = 0, $sName = "", $iMaxWidth = 0, $hWnd = 0)

	; Set parameters passed as Default
	$__iLineNumber=63 & ' - If $iSize = Default Then $iSize = 8.5•StringSize.au3'
	If $iSize = Default Then $iSize = 8.5
	$__iLineNumber=64 & ' - If $iWeight = Default Then $iWeight = 400•StringSize.au3'
	If $iWeight = Default Then $iWeight = 400
	$__iLineNumber=65 & ' - If $iAttrib = Default Then $iAttrib = 0•StringSize.au3'
	If $iAttrib = Default Then $iAttrib = 0
	$__iLineNumber=66 & ' - If $sName = "" Or $sName = Default Then	$sName = _StringSize ...•StringSize.au3'
	If $sName = "" Or $sName = Default Then	$sName = _StringSize_DefaultFontName()

	; Check parameters are correct type
	$__iLineNumber=69 & ' - If Not IsString($sText) Then Return SetError(1, 1, 0)•StringSize.au3'
	If Not IsString($sText) Then Return SetError(1, 1, 0)
	$__iLineNumber=70 & ' - If Not IsNumber($iSize) Then Return SetError(1, 2, 0)•StringSize.au3'
	If Not IsNumber($iSize) Then Return SetError(1, 2, 0)
	$__iLineNumber=71 & ' - If Not IsInt($iWeight) Then Return SetError(1, 3, 0)•StringSize.au3'
	If Not IsInt($iWeight) Then Return SetError(1, 3, 0)
	$__iLineNumber=72 & ' - If Not IsInt($iAttrib) Then Return SetError(1, 4, 0)•StringSize.au3'
	If Not IsInt($iAttrib) Then Return SetError(1, 4, 0)
	$__iLineNumber=73 & ' - If Not IsString($sName) Then Return SetError(1, 5, 0)•StringSize.au3'
	If Not IsString($sName) Then Return SetError(1, 5, 0)
	$__iLineNumber=74 & ' - If Not IsNumber($iMaxWidth) Then Return SetError(1, 6, 0)•StringSize.au3'
	If Not IsNumber($iMaxWidth) Then Return SetError(1, 6, 0)
	$__iLineNumber=75 & ' - If Not IsHwnd($hWnd) And $hWnd <> 0 Then Return SetError(1,  ...•StringSize.au3'
	If Not IsHwnd($hWnd) And $hWnd <> 0 Then Return SetError(1, 7, 0)

	$__iLineNumber=77 & ' - Local $aRet, $hDC, $hFont, $hLabel = 0, $hLabel_Handle•StringSize.au3'
	Local $aRet, $hDC, $hFont, $hLabel = 0, $hLabel_Handle

	; Check for tab expansion flag
	$__iLineNumber=80 & ' - Local $iExpTab = BitAnd($iAttrib, 1)•StringSize.au3'
	Local $iExpTab = BitAnd($iAttrib, 1)
	; Remove possible tab expansion flag from font attribute value
	$__iLineNumber=82 & ' - $iAttrib = BitAnd($iAttrib, BitNot(1))•StringSize.au3'
	$iAttrib = BitAnd($iAttrib, BitNot(1))

	; If GUI handle was passed
	$__iLineNumber=85 & ' - If IsHWnd($hWnd) Then•StringSize.au3'
	If IsHWnd($hWnd) Then
		; Create label outside GUI borders
		$__iLineNumber=87 & ' - $hLabel = GUICtrlCreateLabel("", -10, -10, 10, 10)•StringSize.au3'
		$hLabel = GUICtrlCreateLabel("", -10, -10, 10, 10)
		$__iLineNumber=88 & ' - $hLabel_Handle = GUICtrlGetHandle(-1)•StringSize.au3'
		$hLabel_Handle = GUICtrlGetHandle(-1)
		$__iLineNumber=89 & ' - GUICtrlSetFont(-1, $iSize, $iWeight, $iAttrib, $sName)•StringSize.au3'
		GUICtrlSetFont(-1, $iSize, $iWeight, $iAttrib, $sName)
		; Create DC
		$__iLineNumber=91 & ' - $aRet = DllCall("user32.dll", "handle", "GetDC", "hwnd", $hL ...•StringSize.au3'
		$aRet = DllCall("user32.dll", "handle", "GetDC", "hwnd", $hLabel_Handle)
		$__iLineNumber=92 & ' - If @error Or $aRet[0] = 0 Then•StringSize.au3'
		If @error Or $aRet[0] = 0 Then
			$__iLineNumber=93 & ' - GUICtrlDelete($hLabel)•StringSize.au3'
			GUICtrlDelete($hLabel)
			$__iLineNumber=94 & ' - Return SetError(2, 1, 0)•StringSize.au3'
			Return SetError(2, 1, 0)
		EndIf
		$__iLineNumber=96 & ' - $hDC = $aRet[0]•StringSize.au3'
		$hDC = $aRet[0]
		$__iLineNumber=97 & ' - $aRet = DllCall("user32.dll", "lparam", "SendMessage", "hwnd ...•StringSize.au3'
		$aRet = DllCall("user32.dll", "lparam", "SendMessage", "hwnd", $hLabel_Handle, "int", 0x0031, "wparam", 0, "lparam", 0) ; $WM_GetFont
		$__iLineNumber=98 & ' - If @error Or $aRet[0] = 0 Then•StringSize.au3'
		If @error Or $aRet[0] = 0 Then
			$__iLineNumber=99 & ' - GUICtrlDelete($hLabel)•StringSize.au3'
			GUICtrlDelete($hLabel)
			$__iLineNumber=100 & ' - Return SetError(2, _StringSize_Error_Close(2, $hDC), 0)•StringSize.au3'
			Return SetError(2, _StringSize_Error_Close(2, $hDC), 0)
		EndIf
		$__iLineNumber=102 & ' - $hFont = $aRet[0]•StringSize.au3'
		$hFont = $aRet[0]
	Else
		; Get default DC
		$__iLineNumber=105 & ' - $aRet = DllCall("user32.dll", "handle", "GetDC", "hwnd", $hW ...•StringSize.au3'
		$aRet = DllCall("user32.dll", "handle", "GetDC", "hwnd", $hWnd)
		$__iLineNumber=106 & ' - If @error Or $aRet[0] = 0 Then Return SetError(2, 1, 0)•StringSize.au3'
		If @error Or $aRet[0] = 0 Then Return SetError(2, 1, 0)
		$__iLineNumber=107 & ' - $hDC = $aRet[0]•StringSize.au3'
		$hDC = $aRet[0]
		; Create required font
		$__iLineNumber=109 & ' - $aRet = DllCall("gdi32.dll", "int", "GetDeviceCaps", "handle ...•StringSize.au3'
		$aRet = DllCall("gdi32.dll", "int", "GetDeviceCaps", "handle", $hDC, "int", 90) ; $LOGPIXELSY
		$__iLineNumber=110 & ' - If @error Or $aRet[0] = 0 Then Return SetError(2, _StringSiz ...•StringSize.au3'
		If @error Or $aRet[0] = 0 Then Return SetError(2, _StringSize_Error_Close(3, $hDC), 0)
		$__iLineNumber=111 & ' - Local $iInfo = $aRet[0]•StringSize.au3'
		Local $iInfo = $aRet[0]
		$__iLineNumber=112 & ' - $aRet = DllCall("gdi32.dll", "handle", "CreateFontW", "int", ...•StringSize.au3'
		$aRet = DllCall("gdi32.dll", "handle", "CreateFontW", "int", -$iInfo * $iSize / 72, "int", 0, "int", 0, "int", 0, _
			"int", $iWeight, "dword", BitAND($iAttrib, 2), "dword", BitAND($iAttrib, 4), "dword", BitAND($iAttrib, 8), "dword", 0, "dword", 0, _
			"dword", 0, "dword", 5, "dword", 0, "wstr", $sName)
		$__iLineNumber=115 & ' - If @error Or $aRet[0] = 0 Then Return SetError(2, _StringSiz ...•StringSize.au3'
		If @error Or $aRet[0] = 0 Then Return SetError(2, _StringSize_Error_Close(4, $hDC), 0)
		$__iLineNumber=116 & ' - $hFont = $aRet[0]•StringSize.au3'
		$hFont = $aRet[0]
	EndIf

	; Select font and store previous font
	$__iLineNumber=120 & ' - $aRet = DllCall("gdi32.dll", "handle", "SelectObject", "hand ...•StringSize.au3'
	$aRet = DllCall("gdi32.dll", "handle", "SelectObject", "handle", $hDC, "handle", $hFont)
	$__iLineNumber=121 & ' - If @error Or $aRet[0] = 0 Then Return SetError(2, _StringSiz ...•StringSize.au3'
	If @error Or $aRet[0] = 0 Then Return SetError(2, _StringSize_Error_Close(5, $hDC, $hFont, $hLabel), 0)
	$__iLineNumber=122 & ' - Local $hPrevFont = $aRet[0]•StringSize.au3'
	Local $hPrevFont = $aRet[0]

	; Declare variables
    $__iLineNumber=125 & ' - Local $avSize_Info[4], $iLine_Length, $iLine_Height = 0, $iL ...•StringSize.au3'
    Local $avSize_Info[4], $iLine_Length, $iLine_Height = 0, $iLine_Count = 0, $iLine_Width = 0, $iWrap_Count, $iLast_Word, $sTest_Line
	; Declare and fill Size structure
	$__iLineNumber=127 & ' - Local $tSize = DllStructCreate("int X;int Y")•StringSize.au3'
	Local $tSize = DllStructCreate("int X;int Y")
	$__iLineNumber=128 & ' - DllStructSetData($tSize, "X", 0)•StringSize.au3'
	DllStructSetData($tSize, "X", 0)
	$__iLineNumber=129 & ' - DllStructSetData($tSize, "Y", 0)•StringSize.au3'
	DllStructSetData($tSize, "Y", 0)

	; Ensure EoL is @CRLF and break text into lines
	$__iLineNumber=132 & ' - $sText = StringRegExpReplace($sText, "((?<!\x0d)\x0a|\x0d(?! ...•StringSize.au3'
	$sText = StringRegExpReplace($sText, "((?<!\x0d)\x0a|\x0d(?!\x0a))", @CRLF)
	$__iLineNumber=133 & ' - Local $asLines = StringSplit($sText, @CRLF, 1)•StringSize.au3'
	Local $asLines = StringSplit($sText, @CRLF, 1)

	; For each line
	$__iLineNumber=136 & ' - For $i = 1 To $asLines[0]•StringSize.au3'
	For $i = 1 To $asLines[0]
		; Expand tabs if required
		$__iLineNumber=138 & ' - If $iExpTab Then•StringSize.au3'
		If $iExpTab Then
			$__iLineNumber=139 & ' - $asLines[$i] = StringReplace($asLines[$i], @TAB, " XXXXXXXX" ...•StringSize.au3'
			$asLines[$i] = StringReplace($asLines[$i], @TAB, " XXXXXXXX")
		EndIf
		; Size line
		$__iLineNumber=142 & ' - $iLine_Length = StringLen($asLines[$i])•StringSize.au3'
		$iLine_Length = StringLen($asLines[$i])
		$__iLineNumber=143 & ' - DllCall("gdi32.dll", "bool", "GetTextExtentPoint32W", "handl ...•StringSize.au3'
		DllCall("gdi32.dll", "bool", "GetTextExtentPoint32W", "handle", $hDC, "wstr", $asLines[$i], "int", $iLine_Length, "ptr", DllStructGetPtr($tSize))
		$__iLineNumber=144 & ' - If @error Then Return SetError(2, _StringSize_Error_Close(6, ...•StringSize.au3'
		If @error Then Return SetError(2, _StringSize_Error_Close(6, $hDC, $hFont, $hLabel), 0)
		$__iLineNumber=145 & ' - If DllStructGetData($tSize, "X") > $iLine_Width Then $iLine_ ...•StringSize.au3'
		If DllStructGetData($tSize, "X") > $iLine_Width Then $iLine_Width = DllStructGetData($tSize, "X")
		$__iLineNumber=146 & ' - If DllStructGetData($tSize, "Y") > $iLine_Height Then $iLine ...•StringSize.au3'
		If DllStructGetData($tSize, "Y") > $iLine_Height Then $iLine_Height = DllStructGetData($tSize, "Y")
	Next

	; Check if $iMaxWidth has been both set and exceeded
	$__iLineNumber=150 & ' - If $iMaxWidth <> 0 And $iLine_Width > $iMaxWidth Then ; Wrap ...•StringSize.au3'
	If $iMaxWidth <> 0 And $iLine_Width > $iMaxWidth Then ; Wrapping required
		; For each Line
		$__iLineNumber=152 & ' - For $j = 1 To $asLines[0]•StringSize.au3'
		For $j = 1 To $asLines[0]
			; Size line unwrapped
			$__iLineNumber=154 & ' - $iLine_Length = StringLen($asLines[$j])•StringSize.au3'
			$iLine_Length = StringLen($asLines[$j])
			$__iLineNumber=155 & ' - DllCall("gdi32.dll", "bool", "GetTextExtentPoint32W", "handl ...•StringSize.au3'
			DllCall("gdi32.dll", "bool", "GetTextExtentPoint32W", "handle", $hDC, "wstr", $asLines[$j], "int", $iLine_Length, "ptr", DllStructGetPtr($tSize))
			$__iLineNumber=156 & ' - If @error Then Return SetError(2, _StringSize_Error_Close(6, ...•StringSize.au3'
			If @error Then Return SetError(2, _StringSize_Error_Close(6, $hDC, $hFont, $hLabel), 0)
			; Check wrap status
			$__iLineNumber=158 & ' - If DllStructGetData($tSize, "X") < $iMaxWidth - 4 Then•StringSize.au3'
			If DllStructGetData($tSize, "X") < $iMaxWidth - 4 Then
				; No wrap needed so count line and store
				$__iLineNumber=160 & ' - $iLine_Count += 1•StringSize.au3'
				$iLine_Count += 1
				$__iLineNumber=161 & ' - $avSize_Info[0] &= $asLines[$j] & @CRLF•StringSize.au3'
				$avSize_Info[0] &= $asLines[$j] & @CRLF
			Else
				; Wrap needed so zero counter for wrapped lines
				$__iLineNumber=164 & ' - $iWrap_Count = 0•StringSize.au3'
				$iWrap_Count = 0
				; Build line to max width
				$__iLineNumber=166 & ' - While 1•StringSize.au3'
				While 1
					; Zero line width
					$__iLineNumber=168 & ' - $iLine_Width = 0•StringSize.au3'
					$iLine_Width = 0
					; Initialise pointer for end of word
					$__iLineNumber=170 & ' - $iLast_Word = 0•StringSize.au3'
					$iLast_Word = 0
					; Add characters until EOL or maximum width reached
					$__iLineNumber=172 & ' - For $i = 1 To StringLen($asLines[$j])•StringSize.au3'
					For $i = 1 To StringLen($asLines[$j])
						; Is this just past a word ending?
						$__iLineNumber=174 & ' - If StringMid($asLines[$j], $i, 1) = " " Then $iLast_Word = $ ...•StringSize.au3'
						If StringMid($asLines[$j], $i, 1) = " " Then $iLast_Word = $i - 1
						; Increase line by one character
						$__iLineNumber=176 & ' - $sTest_Line = StringMid($asLines[$j], 1, $i)•StringSize.au3'
						$sTest_Line = StringMid($asLines[$j], 1, $i)
						; Get line length
						$__iLineNumber=178 & ' - $iLine_Length = StringLen($sTest_Line)•StringSize.au3'
						$iLine_Length = StringLen($sTest_Line)
						$__iLineNumber=179 & ' - DllCall("gdi32.dll", "bool", "GetTextExtentPoint32W", "handl ...•StringSize.au3'
						DllCall("gdi32.dll", "bool", "GetTextExtentPoint32W", "handle", $hDC, "wstr", $sTest_Line, "int", $iLine_Length, "ptr", DllStructGetPtr($tSize))
						$__iLineNumber=180 & ' - If @error Then Return SetError(2, _StringSize_Error_Close(6, ...•StringSize.au3'
						If @error Then Return SetError(2, _StringSize_Error_Close(6, $hDC, $hFont, $hLabel), 0)
						$__iLineNumber=181 & ' - $iLine_Width = DllStructGetData($tSize, "X")•StringSize.au3'
						$iLine_Width = DllStructGetData($tSize, "X")
						; If too long exit the loop
						$__iLineNumber=183 & ' - If $iLine_Width >= $iMaxWidth - 4 Then ExitLoop•StringSize.au3'
						If $iLine_Width >= $iMaxWidth - 4 Then ExitLoop
					Next
					; End of the line of text?
					$__iLineNumber=186 & ' - If $i > StringLen($asLines[$j]) Then•StringSize.au3'
					If $i > StringLen($asLines[$j]) Then
						; Yes, so add final line to count
						$__iLineNumber=188 & ' - $iWrap_Count += 1•StringSize.au3'
						$iWrap_Count += 1
						; Store line
						$__iLineNumber=190 & ' - $avSize_Info[0] &= $sTest_Line & @CRLF•StringSize.au3'
						$avSize_Info[0] &= $sTest_Line & @CRLF
						ExitLoop
					Else
						; No, but add line just completed to count
						$__iLineNumber=194 & ' - $iWrap_Count += 1•StringSize.au3'
						$iWrap_Count += 1
						; Check at least 1 word completed or return error
						$__iLineNumber=196 & ' - If $iLast_Word = 0 Then Return SetError(3, _StringSize_Error ...•StringSize.au3'
						If $iLast_Word = 0 Then Return SetError(3, _StringSize_Error_Close(0, $hDC, $hFont, $hLabel), 0)
						; Store line up to end of last word
						$__iLineNumber=198 & ' - $avSize_Info[0] &= StringLeft($sTest_Line, $iLast_Word) & @C ...•StringSize.au3'
						$avSize_Info[0] &= StringLeft($sTest_Line, $iLast_Word) & @CRLF
						; Strip string to point reached
						$__iLineNumber=200 & ' - $asLines[$j] = StringTrimLeft($asLines[$j], $iLast_Word)•StringSize.au3'
						$asLines[$j] = StringTrimLeft($asLines[$j], $iLast_Word)
						; Trim leading whitespace
						$__iLineNumber=202 & ' - $asLines[$j] = StringStripWS($asLines[$j], 1)•StringSize.au3'
						$asLines[$j] = StringStripWS($asLines[$j], 1)
						; Repeat with remaining characters in line
					EndIf
				WEnd
				; Add the number of wrapped lines to the count
				$__iLineNumber=207 & ' - $iLine_Count += $iWrap_Count•StringSize.au3'
				$iLine_Count += $iWrap_Count
			EndIf
		Next
		; Reset any tab expansions
		$__iLineNumber=211 & ' - If $iExpTab Then•StringSize.au3'
		If $iExpTab Then
			$__iLineNumber=212 & ' - $avSize_Info[0] = StringRegExpReplace($avSize_Info[0], "\x20 ...•StringSize.au3'
			$avSize_Info[0] = StringRegExpReplace($avSize_Info[0], "\x20?XXXXXXXX", @TAB)
		EndIf
		; Complete return array
		$__iLineNumber=215 & ' - $avSize_Info[1] = $iLine_Height•StringSize.au3'
		$avSize_Info[1] = $iLine_Height
		$__iLineNumber=216 & ' - $avSize_Info[2] = $iMaxWidth•StringSize.au3'
		$avSize_Info[2] = $iMaxWidth
		; Convert lines to pixels and add drop margin
		$__iLineNumber=218 & ' - $avSize_Info[3] = ($iLine_Count * $iLine_Height) + 4•StringSize.au3'
		$avSize_Info[3] = ($iLine_Count * $iLine_Height) + 4
	Else ; No wrapping required
		; Create return array (add drop margin to height)
		$__iLineNumber=221 & ' - Local $avSize_Info[4] = [$sText, $iLine_Height, $iLine_Width ...•StringSize.au3'
		Local $avSize_Info[4] = [$sText, $iLine_Height, $iLine_Width, ($asLines[0] * $iLine_Height) + 4]
	EndIf

	; Clear up
    $__iLineNumber=225 & ' - DllCall("gdi32.dll", "handle", "SelectObject", "handle", $hD ...•StringSize.au3'
    DllCall("gdi32.dll", "handle", "SelectObject", "handle", $hDC, "handle", $hPrevFont)
	$__iLineNumber=226 & ' - DllCall("gdi32.dll", "bool", "DeleteObject", "handle", $hFon ...•StringSize.au3'
	DllCall("gdi32.dll", "bool", "DeleteObject", "handle", $hFont)
	$__iLineNumber=227 & ' - DllCall("user32.dll", "int", "ReleaseDC", "hwnd", 0, "handle ...•StringSize.au3'
	DllCall("user32.dll", "int", "ReleaseDC", "hwnd", 0, "handle", $hDC)
	$__iLineNumber=228 & ' - If $hLabel Then GUICtrlDelete($hLabel)•StringSize.au3'
	If $hLabel Then GUICtrlDelete($hLabel)

	$__iLineNumber=230 & ' - Return $avSize_Info•StringSize.au3'
	Return $avSize_Info

EndFunc ;==>_StringSize

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: _StringSize_Error_Close
; Description ...: Releases DC and deleted font object if required after error
; Syntax ........: _StringSize_Error_Close ($iExtCode, $hDC, $hGUI)
; Parameters ....: $iExtCode   - code to return
;                  $hDC, $hGUI - handles as set in _StringSize function
; Return value ..: $iExtCode as passed
; Author ........: Melba23
; Modified.......:
; Remarks .......: This function is used internally by _StringSize
; ===============================================================================================================================
$__iLineNumber=245 & ' - Func _StringSize_Error_Close($iExtCode, $hDC = 0, $hFont = 0 ...•StringSize.au3'
Func _StringSize_Error_Close($iExtCode, $hDC = 0, $hFont = 0, $hLabel = 0)

	$__iLineNumber=247 & ' - If $hFont <> 0 Then DllCall("gdi32.dll", "bool", "DeleteObje ...•StringSize.au3'
	If $hFont <> 0 Then DllCall("gdi32.dll", "bool", "DeleteObject", "handle", $hFont)
	$__iLineNumber=248 & ' - If $hDC <> 0 Then DllCall("user32.dll", "int", "ReleaseDC",  ...•StringSize.au3'
	If $hDC <> 0 Then DllCall("user32.dll", "int", "ReleaseDC", "hwnd", 0, "handle", $hDC)
	$__iLineNumber=249 & ' - If $hLabel Then GUICtrlDelete($hLabel)•StringSize.au3'
	If $hLabel Then GUICtrlDelete($hLabel)

	$__iLineNumber=251 & ' - Return $iExtCode•StringSize.au3'
	Return $iExtCode

EndFunc ;=>_StringSize_Error_Close

; #INTERNAL_USE_ONLY#============================================================================================================
; Name...........: _StringSize_DefaultFontName
; Description ...: Determines Windows default font
; Syntax ........: _StringSize_DefaultFontName()
; Parameters ....: None
; Return values .: Success - Returns name of system default font
;                  Failure - Returns "Tahoma"
; Author ........: Melba23, based on some original code by Larrydalooza
; Modified.......:
; Remarks .......: This function is used internally by _StringSize
; ===============================================================================================================================
$__iLineNumber=266 & ' - Func _StringSize_DefaultFontName()•StringSize.au3'
Func _StringSize_DefaultFontName()

	; Get default system font data
	$__iLineNumber=269 & ' - Local $tNONCLIENTMETRICS = DllStructCreate("uint;int;int;int ...•StringSize.au3'
	Local $tNONCLIENTMETRICS = DllStructCreate("uint;int;int;int;int;int;byte[60];int;int;byte[60];int;int;byte[60];byte[60];byte[60]")
	$__iLineNumber=270 & ' - DLLStructSetData($tNONCLIENTMETRICS, 1, DllStructGetSize($tN ...•StringSize.au3'
	DLLStructSetData($tNONCLIENTMETRICS, 1, DllStructGetSize($tNONCLIENTMETRICS))
	$__iLineNumber=271 & ' - DLLCall("user32.dll", "int", "SystemParametersInfo", "int",  ...•StringSize.au3'
	DLLCall("user32.dll", "int", "SystemParametersInfo", "int", 41, "int", DllStructGetSize($tNONCLIENTMETRICS), "ptr", DllStructGetPtr($tNONCLIENTMETRICS), "int", 0)
	$__iLineNumber=272 & ' - Local $tLOGFONT = DllStructCreate("long;long;long;long;long; ...•StringSize.au3'
	Local $tLOGFONT = DllStructCreate("long;long;long;long;long;byte;byte;byte;byte;byte;byte;byte;byte;char[32]", DLLStructGetPtr($tNONCLIENTMETRICS, 13))
	$__iLineNumber=273 & ' - If IsString(DllStructGetData($tLOGFONT, 14)) Then•StringSize.au3'
	If IsString(DllStructGetData($tLOGFONT, 14)) Then
		$__iLineNumber=274 & ' - Return DllStructGetData($tLOGFONT, 14)•StringSize.au3'
		Return DllStructGetData($tLOGFONT, 14)
	Else
		$__iLineNumber=276 & ' - Return "Tahoma"•StringSize.au3'
		Return "Tahoma"
	EndIf

EndFunc ;=>_StringSize_DefaultFontName
