$__iLineNumber=0

; For those who would fear the license - don't. I tried to license it as liberal as possible.
; It really means you can do what ever you want with this.
; Donations are wellcome And will be accepted via PayPal address: trancexx at yahoo dot com
; Thank you for the shiny stuff :kiss:

#comments-start
	$__iLineNumber=8 & ' - Copyright 2013 Dragana R. <trancexx at yahoo dot com>•_WinHttp.au3'
	Copyright 2013 Dragana R. <trancexx at yahoo dot com>

	$__iLineNumber=10 & ' - Licensed under the Apache License, Version 2.0 (the "License ...•_WinHttp.au3'
	Licensed under the Apache License, Version 2.0 (the "License");
	$__iLineNumber=11 & ' - you may not use this file except in compliance with the Lice ...•_WinHttp.au3'
	you may not use this file except in compliance with the License.
	$__iLineNumber=12 & ' - You may obtain a copy of the License at•_WinHttp.au3'
	You may obtain a copy of the License at

	$__iLineNumber=14 & ' - http://www.apache.org/licenses/LICENSE-2.0•_WinHttp.au3'
	http://www.apache.org/licenses/LICENSE-2.0

	$__iLineNumber=16 & ' - Unless required by applicable law or agreed to in writing, s ...•_WinHttp.au3'
	Unless required by applicable law or agreed to in writing, software
	$__iLineNumber=17 & ' - distributed under the License is distributed on an "AS IS" B ...•_WinHttp.au3'
	distributed under the License is distributed on an "AS IS" BASIS,
	$__iLineNumber=18 & ' - WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express ...•_WinHttp.au3'
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	$__iLineNumber=19 & ' - See the License for the specific language governing permissi ...•_WinHttp.au3'
	See the License for the specific language governing permissions and
	$__iLineNumber=20 & ' - limitations under the License.•_WinHttp.au3'
	limitations under the License.
#comments-end

#include-once
#include "_WinHttpConstants.au3"

; #INDEX# ===================================================================================
; Title ...............: WinHttp
; File Name............: WinHttp.au3
; File Version.........: 1.6.4.0
; Min. AutoIt Version..: v3.3.7.20
; Description .........: AutoIt wrapper for WinHTTP functions
; Author... ...........: trancexx, ProgAndy
; Dll .................: winhttp.dll, kernel32.dll
; ===========================================================================================

; #CONSTANTS# ===============================================================================
$__iLineNumber=37 & ' - Global Const $hWINHTTPDLL__WINHTTP = DllOpen("winhttp.dll")•_WinHttp.au3'
Global Const $hWINHTTPDLL__WINHTTP = DllOpen("winhttp.dll")
$__iLineNumber=38 & ' - DllOpen("winhttp.dll") ; making sure reference count never r ...•_WinHttp.au3'
DllOpen("winhttp.dll") ; making sure reference count never reaches 0
;============================================================================================

; #CURRENT# =================================================================================
;_WinHttpAddRequestHeaders
;_WinHttpCheckPlatform
;_WinHttpCloseHandle
;_WinHttpConnect
;_WinHttpCrackUrl
;_WinHttpCreateUrl
;_WinHttpDetectAutoProxyConfigUrl
;_WinHttpGetDefaultProxyConfiguration
;_WinHttpGetIEProxyConfigForCurrentUser
;_WinHttpOpen
;_WinHttpOpenRequest
;_WinHttpQueryAuthSchemes
;_WinHttpQueryDataAvailable
;_WinHttpQueryHeaders
;_WinHttpQueryOption
;_WinHttpReadData
;_WinHttpReceiveResponse
;_WinHttpSendRequest
;_WinHttpSetCredentials
;_WinHttpSetDefaultProxyConfiguration
;_WinHttpSetOption
;_WinHttpSetStatusCallback
;_WinHttpSetTimeouts
;_WinHttpSimpleBinaryConcat
;_WinHttpSimpleFormFill
;_WinHttpSimpleFormFill_SetUploadCallback
;_WinHttpSimpleReadData
;_WinHttpSimpleReadDataAsync
;_WinHttpSimpleRequest
;_WinHttpSimpleSendRequest
;_WinHttpSimpleSendSSLRequest
;_WinHttpSimpleSSLRequest
;_WinHttpTimeFromSystemTime
;_WinHttpTimeToSystemTime
;_WinHttpWriteData
; ===========================================================================================

; #FUNCTION# ;===============================================================================
; Name...........: _WinHttpAddRequestHeaders
; Description ...: Adds one or more HTTP request headers to the HTTP request handle.
; Syntax.........: _WinHttpAddRequestHeaders ($hRequest, $sHeaders [, $iModifiers = Default ])
; Parameters ....: $hRequest - Handle returned by _WinHttpOpenRequest function.
;                  $sHeader - [optional] Header(s) to append to the request.
;                  $iModifier - [optional] Contains the flags used to modify the semantics of this function. Default is $WINHTTP_ADDREQ_FLAG_ADD_IF_NEW.
; Return values .: Success - Returns 1
;                  Failure - Returns 0 and sets @error:
;                  |1 - DllCall failed
; Author ........: trancexx
; Remarks .......: In case of multiple additions at once use [[@CRLF]] to separate each [[$hRequest]] and responded [[$sHeaders]] and [[$iModifiers]].
; Related .......: _WinHttpOpenRequest, _WinHttpQueryHeaders
; Link ..........: http://msdn.microsoft.com/en-us/library/aa384087.aspx
;============================================================================================
$__iLineNumber=94 & ' - Func _WinHttpAddRequestHeaders($hRequest, $sHeader, $iModifi ...•_WinHttp.au3'
Func _WinHttpAddRequestHeaders($hRequest, $sHeader, $iModifier = Default)
	$__iLineNumber=95 & ' - __WinHttpDefault($iModifier, $WINHTTP_ADDREQ_FLAG_ADD_IF_NEW ...•_WinHttp.au3'
	__WinHttpDefault($iModifier, $WINHTTP_ADDREQ_FLAG_ADD_IF_NEW)
	$__iLineNumber=96 & ' - Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHt ...•_WinHttp.au3'
	Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHttpAddRequestHeaders", _
			"handle", $hRequest, _
			"wstr", $sHeader, _
			"dword", -1, _
			"dword", $iModifier)
	$__iLineNumber=101 & ' - If @error Or Not $aCall[0] Then Return SetError(1, 0, 0)•_WinHttp.au3'
	If @error Or Not $aCall[0] Then Return SetError(1, 0, 0)
	$__iLineNumber=102 & ' - Return 1•_WinHttp.au3'
	Return 1
EndFunc

; #FUNCTION# ;===============================================================================
; Name...........: _WinHttpCheckPlatform
; Description ...: Determines whether the current platform is supported by this version of Microsoft Windows HTTP Services (WinHTTP).
; Syntax.........: _WinHttpCheckPlatform()
; Parameters ....: None
; Return values .: Success - Returns 1 if current platform is supported
;                          - Returns 0 if current platform is not supported
;                  Failure - Returns 0 and sets @error:
;                  |1 - DllCall failed
; Author ........: trancexx
; Link ..........: http://msdn.microsoft.com/en-us/library/aa384089.aspx
;============================================================================================
$__iLineNumber=117 & ' - Func _WinHttpCheckPlatform()•_WinHttp.au3'
Func _WinHttpCheckPlatform()
	$__iLineNumber=118 & ' - Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHt ...•_WinHttp.au3'
	Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHttpCheckPlatform")
	$__iLineNumber=119 & ' - If @error Then Return SetError(1, 0, 0)•_WinHttp.au3'
	If @error Then Return SetError(1, 0, 0)
	$__iLineNumber=120 & ' - Return $aCall[0]•_WinHttp.au3'
	Return $aCall[0]
EndFunc

; #FUNCTION# ;===============================================================================
; Name...........: _WinHttpCloseHandle
; Description ...: Closes a single handle.
; Syntax.........: _WinHttpCloseHandle($hInternet)
; Parameters ....: $hInternet - Valid handle to be closed.
; Return values .: Success - Returns 1
;                  Failure - Returns 0 and sets @error:
;                  |1 - DllCall failed
; Author ........: trancexx
; Related .......: _WinHttpConnect, _WinHttpOpen, _WinHttpOpenRequest
; Link ..........: http://msdn.microsoft.com/en-us/library/aa384090.aspx
;============================================================================================
$__iLineNumber=135 & ' - Func _WinHttpCloseHandle($hInternet)•_WinHttp.au3'
Func _WinHttpCloseHandle($hInternet)
	$__iLineNumber=136 & ' - Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHt ...•_WinHttp.au3'
	Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHttpCloseHandle", "handle", $hInternet)
	$__iLineNumber=137 & ' - If @error Or Not $aCall[0] Then Return SetError(1, 0, 0)•_WinHttp.au3'
	If @error Or Not $aCall[0] Then Return SetError(1, 0, 0)
	$__iLineNumber=138 & ' - Return 1•_WinHttp.au3'
	Return 1
EndFunc

; #FUNCTION# ;===============================================================================
; Name...........: _WinHttpConnect
; Description ...: Specifies the initial target server of an HTTP request and returns connection handle to an HTTP session for that initial target.
; Syntax.........: _WinHttpConnect($hSession, $sServerName [, $iServerPort = Default ])
; Parameters ....: $hSession - Valid WinHttp session handle returned by a previous call to _WinHttpOpen().
;                  $sServerName - Host name of an HTTP server. In case URI scheme (http://, https://, ...) is specified $iServerPort is ignored.
;                  $iServerPort - [optional] TCP/IP port on the server to which a connection is made (default is $INTERNET_DEFAULT_PORT)
; Return values .: Success - Returns a valid connection handle to the HTTP session
;                  Failure - Returns 0 and sets @error:
;                  |1 - DllCall failed
; Author ........: trancexx
; Remarks .......: [[$iServerPort]] can be defined via global constants [[$INTERNET_DEFAULT_PORT]], [[$INTERNET_DEFAULT_HTTP_PORT]] or [[$INTERNET_DEFAULT_HTTPS_PORT]]
; Related .......: _WinHttpOpen
; Link ..........: http://msdn.microsoft.com/en-us/library/aa384091.aspx
;============================================================================================
$__iLineNumber=156 & ' - Func _WinHttpConnect($hSession, $sServerName, $iServerPort = ...•_WinHttp.au3'
Func _WinHttpConnect($hSession, $sServerName, $iServerPort = Default)
	$__iLineNumber=157 & ' - Local $aURL = _WinHttpCrackUrl($sServerName), $iScheme = 0•_WinHttp.au3'
	Local $aURL = _WinHttpCrackUrl($sServerName), $iScheme = 0
	$__iLineNumber=158 & ' - If @error Then•_WinHttp.au3'
	If @error Then
		$__iLineNumber=159 & ' - __WinHttpDefault($iServerPort, $INTERNET_DEFAULT_PORT)•_WinHttp.au3'
		__WinHttpDefault($iServerPort, $INTERNET_DEFAULT_PORT)
	Else
		$__iLineNumber=161 & ' - $sServerName = $aURL[2]•_WinHttp.au3'
		$sServerName = $aURL[2]
		$__iLineNumber=162 & ' - $iServerPort = $aURL[3]•_WinHttp.au3'
		$iServerPort = $aURL[3]
		$__iLineNumber=163 & ' - $iScheme = $aURL[1]•_WinHttp.au3'
		$iScheme = $aURL[1]
	EndIf
	$__iLineNumber=165 & ' - Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "handle", "Win ...•_WinHttp.au3'
	Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "handle", "WinHttpConnect", _
			"handle", $hSession, _
			"wstr", $sServerName, _
			"dword", $iServerPort, _
			"dword", 0)
	$__iLineNumber=170 & ' - If @error Or Not $aCall[0] Then Return SetError(1, 0, 0)•_WinHttp.au3'
	If @error Or Not $aCall[0] Then Return SetError(1, 0, 0)
	$__iLineNumber=171 & ' - _WinHttpSetOption($aCall[0], $WINHTTP_OPTION_CONTEXT_VALUE,  ...•_WinHttp.au3'
	_WinHttpSetOption($aCall[0], $WINHTTP_OPTION_CONTEXT_VALUE, $iScheme)
	$__iLineNumber=172 & ' - Return $aCall[0]•_WinHttp.au3'
	Return $aCall[0]
EndFunc

; #FUNCTION# ;===============================================================================
; Name...........: _WinHttpCrackUrl
; Description ...: Separates a URL into its component parts such as host name and path.
; Syntax.........: _WinHttpCrackUrl($sURL [, $iFlag = Default ])
; Parameters ....: $sURL - String. Canonical URL to separate.
;                  $iFlag - [optional] Flag that control the operation. Default is $ICU_ESCAPE
; Return values .: Success - Returns array with 8 elements:
;                  |$array[0] - scheme name
;                  |$array[1] - internet protocol scheme
;                  |$array[2] - host name
;                  |$array[3] - port number
;                  |$array[4] - user name
;                  |$array[5] - password
;                  |$array[6] - URL path
;                  |$array[7] - extra information
;                  Failure - Returns 0 and sets @error:
;                  |1 - DllCall failed
; Author ........: ProgAndy
; Modified.......: trancexx
; Remarks .......: [[$iFlag]] is defined in WinHttpConstants.au3 and can be:
;                  |[[$ICU_DECODE]] - Converts characters that are "escape encoded" (%xx) to their non-escaped form.
;                  |[[$ICU_ESCAPE]] - Escapes certain characters to their escape sequences (%xx).
; Related .......: _WinHttpCreateUrl
; Link ..........: http://msdn.microsoft.com/en-us/library/aa384092.aspx
;============================================================================================
$__iLineNumber=200 & ' - Func _WinHttpCrackUrl($sURL, $iFlag = Default)•_WinHttp.au3'
Func _WinHttpCrackUrl($sURL, $iFlag = Default)
	$__iLineNumber=201 & ' - __WinHttpDefault($iFlag, $ICU_ESCAPE)•_WinHttp.au3'
	__WinHttpDefault($iFlag, $ICU_ESCAPE)
	$__iLineNumber=202 & ' - Local $tURL_COMPONENTS = DllStructCreate("dword StructSize;" ...•_WinHttp.au3'
	Local $tURL_COMPONENTS = DllStructCreate("dword StructSize;" & _
			"ptr SchemeName;" & _
			"dword SchemeNameLength;" & _
			"int Scheme;" & _
			"ptr HostName;" & _
			"dword HostNameLength;" & _
			"word Port;" & _
			"ptr UserName;" & _
			"dword UserNameLength;" & _
			"ptr Password;" & _
			"dword PasswordLength;" & _
			"ptr UrlPath;" & _
			"dword UrlPathLength;" & _
			"ptr ExtraInfo;" & _
			"dword ExtraInfoLength")
	$__iLineNumber=217 & ' - DllStructSetData($tURL_COMPONENTS, 1, DllStructGetSize($tURL ...•_WinHttp.au3'
	DllStructSetData($tURL_COMPONENTS, 1, DllStructGetSize($tURL_COMPONENTS))
	$__iLineNumber=218 & ' - Local $tBuffers[6]•_WinHttp.au3'
	Local $tBuffers[6]
	$__iLineNumber=219 & ' - Local $iURLLen = StringLen($sURL)•_WinHttp.au3'
	Local $iURLLen = StringLen($sURL)
	$__iLineNumber=220 & ' - For $i = 0 To 5•_WinHttp.au3'
	For $i = 0 To 5
		$__iLineNumber=221 & ' - $tBuffers[$i] = DllStructCreate("wchar[" & $iURLLen + 1 & "] ...•_WinHttp.au3'
		$tBuffers[$i] = DllStructCreate("wchar[" & $iURLLen + 1 & "]")
	Next
	$__iLineNumber=223 & ' - DllStructSetData($tURL_COMPONENTS, "SchemeNameLength", $iURL ...•_WinHttp.au3'
	DllStructSetData($tURL_COMPONENTS, "SchemeNameLength", $iURLLen)
	$__iLineNumber=224 & ' - DllStructSetData($tURL_COMPONENTS, "SchemeName", DllStructGe ...•_WinHttp.au3'
	DllStructSetData($tURL_COMPONENTS, "SchemeName", DllStructGetPtr($tBuffers[0]))
	$__iLineNumber=225 & ' - DllStructSetData($tURL_COMPONENTS, "HostNameLength", $iURLLe ...•_WinHttp.au3'
	DllStructSetData($tURL_COMPONENTS, "HostNameLength", $iURLLen)
	$__iLineNumber=226 & ' - DllStructSetData($tURL_COMPONENTS, "HostName", DllStructGetP ...•_WinHttp.au3'
	DllStructSetData($tURL_COMPONENTS, "HostName", DllStructGetPtr($tBuffers[1]))
	$__iLineNumber=227 & ' - DllStructSetData($tURL_COMPONENTS, "UserNameLength", $iURLLe ...•_WinHttp.au3'
	DllStructSetData($tURL_COMPONENTS, "UserNameLength", $iURLLen)
	$__iLineNumber=228 & ' - DllStructSetData($tURL_COMPONENTS, "UserName", DllStructGetP ...•_WinHttp.au3'
	DllStructSetData($tURL_COMPONENTS, "UserName", DllStructGetPtr($tBuffers[2]))
	$__iLineNumber=229 & ' - DllStructSetData($tURL_COMPONENTS, "PasswordLength", $iURLLe ...•_WinHttp.au3'
	DllStructSetData($tURL_COMPONENTS, "PasswordLength", $iURLLen)
	$__iLineNumber=230 & ' - DllStructSetData($tURL_COMPONENTS, "Password", DllStructGetP ...•_WinHttp.au3'
	DllStructSetData($tURL_COMPONENTS, "Password", DllStructGetPtr($tBuffers[3]))
	$__iLineNumber=231 & ' - DllStructSetData($tURL_COMPONENTS, "UrlPathLength", $iURLLen ...•_WinHttp.au3'
	DllStructSetData($tURL_COMPONENTS, "UrlPathLength", $iURLLen)
	$__iLineNumber=232 & ' - DllStructSetData($tURL_COMPONENTS, "UrlPath", DllStructGetPt ...•_WinHttp.au3'
	DllStructSetData($tURL_COMPONENTS, "UrlPath", DllStructGetPtr($tBuffers[4]))
	$__iLineNumber=233 & ' - DllStructSetData($tURL_COMPONENTS, "ExtraInfoLength", $iURLL ...•_WinHttp.au3'
	DllStructSetData($tURL_COMPONENTS, "ExtraInfoLength", $iURLLen)
	$__iLineNumber=234 & ' - DllStructSetData($tURL_COMPONENTS, "ExtraInfo", DllStructGet ...•_WinHttp.au3'
	DllStructSetData($tURL_COMPONENTS, "ExtraInfo", DllStructGetPtr($tBuffers[5]))
	$__iLineNumber=235 & ' - Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHt ...•_WinHttp.au3'
	Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHttpCrackUrl", _
			"wstr", $sURL, _
			"dword", $iURLLen, _
			"dword", $iFlag, _
			"struct*", $tURL_COMPONENTS)
	$__iLineNumber=240 & ' - If @error Or Not $aCall[0] Then Return SetError(1, 0, 0)•_WinHttp.au3'
	If @error Or Not $aCall[0] Then Return SetError(1, 0, 0)
	$__iLineNumber=241 & ' - Local $aRet[8] = [DllStructGetData($tBuffers[0], 1), _•_WinHttp.au3'
	Local $aRet[8] = [DllStructGetData($tBuffers[0], 1), _
			DllStructGetData($tURL_COMPONENTS, "Scheme"), _
			DllStructGetData($tBuffers[1], 1), _
			DllStructGetData($tURL_COMPONENTS, "Port"), _
			DllStructGetData($tBuffers[2], 1), _
			DllStructGetData($tBuffers[3], 1), _
			DllStructGetData($tBuffers[4], 1), _
			DllStructGetData($tBuffers[5], 1)]
	$__iLineNumber=249 & ' - Return $aRet•_WinHttp.au3'
	Return $aRet
EndFunc

; #FUNCTION# ;===============================================================================
; Name...........: _WinHttpCreateUrl
; Description ...: Creates a URL from array of components such as the host name and path.
; Syntax.........: _WinHttpCreateUrl($aURLArray)
; Parameters ....: $aURLArray - Array of URL data.
; Return values .: Success - Returns created URL
;                  Failure - Returns empty string and sets @error:
;                  |1 - Invalid input.
;                  |2 - Initial DllCall failed
;                  |3 - Main DllCall failed
; Author ........: ProgAndy
; Modified.......: trancexx
; Remarks .......: Input is one dimensional 8 elements in size array:
;                  |- first element [0] scheme name
;                  |- second element [1] internet protocol scheme
;                  |- third element [2] host name
;                  |- fourth element [3] port number
;                  |- fifth element [4] user name
;                  |- sixth element [5] password
;                  |- seventh element [6] URL path
;                  |- eighth element [7] extra information
; Related .......: _WinHttpCrackUrl
; Link ..........: http://msdn.microsoft.com/en-us/library/aa384093.aspx
;============================================================================================
$__iLineNumber=276 & ' - Func _WinHttpCreateUrl($aURLArray)•_WinHttp.au3'
Func _WinHttpCreateUrl($aURLArray)
	$__iLineNumber=277 & ' - If UBound($aURLArray) - 8 Then Return SetError(1, 0, "")•_WinHttp.au3'
	If UBound($aURLArray) - 8 Then Return SetError(1, 0, "")
	$__iLineNumber=278 & ' - Local $tURL_COMPONENTS = DllStructCreate("dword StructSize;" ...•_WinHttp.au3'
	Local $tURL_COMPONENTS = DllStructCreate("dword StructSize;" & _
			"ptr SchemeName;" & _
			"dword SchemeNameLength;" & _
			"int Scheme;" & _
			"ptr HostName;" & _
			"dword HostNameLength;" & _
			"word Port;" & _
			"ptr UserName;" & _
			"dword UserNameLength;" & _
			"ptr Password;" & _
			"dword PasswordLength;" & _
			"ptr UrlPath;" & _
			"dword UrlPathLength;" & _
			"ptr ExtraInfo;" & _
			"dword ExtraInfoLength;")
	$__iLineNumber=293 & ' - DllStructSetData($tURL_COMPONENTS, 1, DllStructGetSize($tURL ...•_WinHttp.au3'
	DllStructSetData($tURL_COMPONENTS, 1, DllStructGetSize($tURL_COMPONENTS))
	$__iLineNumber=294 & ' - Local $tBuffers[6][2]•_WinHttp.au3'
	Local $tBuffers[6][2]
	$__iLineNumber=295 & ' - $tBuffers[0][1] = StringLen($aURLArray[0])•_WinHttp.au3'
	$tBuffers[0][1] = StringLen($aURLArray[0])
	$__iLineNumber=296 & ' - If $tBuffers[0][1] Then•_WinHttp.au3'
	If $tBuffers[0][1] Then
		$__iLineNumber=297 & ' - $tBuffers[0][0] = DllStructCreate("wchar[" & $tBuffers[0][1] ...•_WinHttp.au3'
		$tBuffers[0][0] = DllStructCreate("wchar[" & $tBuffers[0][1] + 1 & "]")
		$__iLineNumber=298 & ' - DllStructSetData($tBuffers[0][0], 1, $aURLArray[0])•_WinHttp.au3'
		DllStructSetData($tBuffers[0][0], 1, $aURLArray[0])
	EndIf
	$__iLineNumber=300 & ' - $tBuffers[1][1] = StringLen($aURLArray[2])•_WinHttp.au3'
	$tBuffers[1][1] = StringLen($aURLArray[2])
	$__iLineNumber=301 & ' - If $tBuffers[1][1] Then•_WinHttp.au3'
	If $tBuffers[1][1] Then
		$__iLineNumber=302 & ' - $tBuffers[1][0] = DllStructCreate("wchar[" & $tBuffers[1][1] ...•_WinHttp.au3'
		$tBuffers[1][0] = DllStructCreate("wchar[" & $tBuffers[1][1] + 1 & "]")
		$__iLineNumber=303 & ' - DllStructSetData($tBuffers[1][0], 1, $aURLArray[2])•_WinHttp.au3'
		DllStructSetData($tBuffers[1][0], 1, $aURLArray[2])
	EndIf
	$__iLineNumber=305 & ' - $tBuffers[2][1] = StringLen($aURLArray[4])•_WinHttp.au3'
	$tBuffers[2][1] = StringLen($aURLArray[4])
	$__iLineNumber=306 & ' - If $tBuffers[2][1] Then•_WinHttp.au3'
	If $tBuffers[2][1] Then
		$__iLineNumber=307 & ' - $tBuffers[2][0] = DllStructCreate("wchar[" & $tBuffers[2][1] ...•_WinHttp.au3'
		$tBuffers[2][0] = DllStructCreate("wchar[" & $tBuffers[2][1] + 1 & "]")
		$__iLineNumber=308 & ' - DllStructSetData($tBuffers[2][0], 1, $aURLArray[4])•_WinHttp.au3'
		DllStructSetData($tBuffers[2][0], 1, $aURLArray[4])
	EndIf
	$__iLineNumber=310 & ' - $tBuffers[3][1] = StringLen($aURLArray[5])•_WinHttp.au3'
	$tBuffers[3][1] = StringLen($aURLArray[5])
	$__iLineNumber=311 & ' - If $tBuffers[3][1] Then•_WinHttp.au3'
	If $tBuffers[3][1] Then
		$__iLineNumber=312 & ' - $tBuffers[3][0] = DllStructCreate("wchar[" & $tBuffers[3][1] ...•_WinHttp.au3'
		$tBuffers[3][0] = DllStructCreate("wchar[" & $tBuffers[3][1] + 1 & "]")
		$__iLineNumber=313 & ' - DllStructSetData($tBuffers[3][0], 1, $aURLArray[5])•_WinHttp.au3'
		DllStructSetData($tBuffers[3][0], 1, $aURLArray[5])
	EndIf
	$__iLineNumber=315 & ' - $tBuffers[4][1] = StringLen($aURLArray[6])•_WinHttp.au3'
	$tBuffers[4][1] = StringLen($aURLArray[6])
	$__iLineNumber=316 & ' - If $tBuffers[4][1] Then•_WinHttp.au3'
	If $tBuffers[4][1] Then
		$__iLineNumber=317 & ' - $tBuffers[4][0] = DllStructCreate("wchar[" & $tBuffers[4][1] ...•_WinHttp.au3'
		$tBuffers[4][0] = DllStructCreate("wchar[" & $tBuffers[4][1] + 1 & "]")
		$__iLineNumber=318 & ' - DllStructSetData($tBuffers[4][0], 1, $aURLArray[6])•_WinHttp.au3'
		DllStructSetData($tBuffers[4][0], 1, $aURLArray[6])
	EndIf
	$__iLineNumber=320 & ' - $tBuffers[5][1] = StringLen($aURLArray[7])•_WinHttp.au3'
	$tBuffers[5][1] = StringLen($aURLArray[7])
	$__iLineNumber=321 & ' - If $tBuffers[5][1] Then•_WinHttp.au3'
	If $tBuffers[5][1] Then
		$__iLineNumber=322 & ' - $tBuffers[5][0] = DllStructCreate("wchar[" & $tBuffers[5][1] ...•_WinHttp.au3'
		$tBuffers[5][0] = DllStructCreate("wchar[" & $tBuffers[5][1] + 1 & "]")
		$__iLineNumber=323 & ' - DllStructSetData($tBuffers[5][0], 1, $aURLArray[7])•_WinHttp.au3'
		DllStructSetData($tBuffers[5][0], 1, $aURLArray[7])
	EndIf
	$__iLineNumber=325 & ' - DllStructSetData($tURL_COMPONENTS, "SchemeNameLength", $tBuf ...•_WinHttp.au3'
	DllStructSetData($tURL_COMPONENTS, "SchemeNameLength", $tBuffers[0][1])
	$__iLineNumber=326 & ' - DllStructSetData($tURL_COMPONENTS, "SchemeName", DllStructGe ...•_WinHttp.au3'
	DllStructSetData($tURL_COMPONENTS, "SchemeName", DllStructGetPtr($tBuffers[0][0]))
	$__iLineNumber=327 & ' - DllStructSetData($tURL_COMPONENTS, "HostNameLength", $tBuffe ...•_WinHttp.au3'
	DllStructSetData($tURL_COMPONENTS, "HostNameLength", $tBuffers[1][1])
	$__iLineNumber=328 & ' - DllStructSetData($tURL_COMPONENTS, "HostName", DllStructGetP ...•_WinHttp.au3'
	DllStructSetData($tURL_COMPONENTS, "HostName", DllStructGetPtr($tBuffers[1][0]))
	$__iLineNumber=329 & ' - DllStructSetData($tURL_COMPONENTS, "UserNameLength", $tBuffe ...•_WinHttp.au3'
	DllStructSetData($tURL_COMPONENTS, "UserNameLength", $tBuffers[2][1])
	$__iLineNumber=330 & ' - DllStructSetData($tURL_COMPONENTS, "UserName", DllStructGetP ...•_WinHttp.au3'
	DllStructSetData($tURL_COMPONENTS, "UserName", DllStructGetPtr($tBuffers[2][0]))
	$__iLineNumber=331 & ' - DllStructSetData($tURL_COMPONENTS, "PasswordLength", $tBuffe ...•_WinHttp.au3'
	DllStructSetData($tURL_COMPONENTS, "PasswordLength", $tBuffers[3][1])
	$__iLineNumber=332 & ' - DllStructSetData($tURL_COMPONENTS, "Password", DllStructGetP ...•_WinHttp.au3'
	DllStructSetData($tURL_COMPONENTS, "Password", DllStructGetPtr($tBuffers[3][0]))
	$__iLineNumber=333 & ' - DllStructSetData($tURL_COMPONENTS, "UrlPathLength", $tBuffer ...•_WinHttp.au3'
	DllStructSetData($tURL_COMPONENTS, "UrlPathLength", $tBuffers[4][1])
	$__iLineNumber=334 & ' - DllStructSetData($tURL_COMPONENTS, "UrlPath", DllStructGetPt ...•_WinHttp.au3'
	DllStructSetData($tURL_COMPONENTS, "UrlPath", DllStructGetPtr($tBuffers[4][0]))
	$__iLineNumber=335 & ' - DllStructSetData($tURL_COMPONENTS, "ExtraInfoLength", $tBuff ...•_WinHttp.au3'
	DllStructSetData($tURL_COMPONENTS, "ExtraInfoLength", $tBuffers[5][1])
	$__iLineNumber=336 & ' - DllStructSetData($tURL_COMPONENTS, "ExtraInfo", DllStructGet ...•_WinHttp.au3'
	DllStructSetData($tURL_COMPONENTS, "ExtraInfo", DllStructGetPtr($tBuffers[5][0]))
	$__iLineNumber=337 & ' - DllStructSetData($tURL_COMPONENTS, "Scheme", $aURLArray[1])•_WinHttp.au3'
	DllStructSetData($tURL_COMPONENTS, "Scheme", $aURLArray[1])
	$__iLineNumber=338 & ' - DllStructSetData($tURL_COMPONENTS, "Port", $aURLArray[3])•_WinHttp.au3'
	DllStructSetData($tURL_COMPONENTS, "Port", $aURLArray[3])
	$__iLineNumber=339 & ' - Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHt ...•_WinHttp.au3'
	Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHttpCreateUrl", _
			"struct*", $tURL_COMPONENTS, _
			"dword", $ICU_ESCAPE, _
			"ptr", 0, _
			"dword*", 0)
	$__iLineNumber=344 & ' - If @error Then Return SetError(2, 0, "")•_WinHttp.au3'
	If @error Then Return SetError(2, 0, "")
	$__iLineNumber=345 & ' - Local $iURLLen = $aCall[4]•_WinHttp.au3'
	Local $iURLLen = $aCall[4]
	$__iLineNumber=346 & ' - Local $URLBuffer = DllStructCreate("wchar[" & ($iURLLen + 1) ...•_WinHttp.au3'
	Local $URLBuffer = DllStructCreate("wchar[" & ($iURLLen + 1) & "]")
	$__iLineNumber=347 & ' - $aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHttpCrea ...•_WinHttp.au3'
	$aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHttpCreateUrl", _
			"struct*", $tURL_COMPONENTS, _
			"dword", $ICU_ESCAPE, _
			"struct*", $URLBuffer, _
			"dword*", $iURLLen)
	$__iLineNumber=352 & ' - If @error Or Not $aCall[0] Then Return SetError(3, 0, "")•_WinHttp.au3'
	If @error Or Not $aCall[0] Then Return SetError(3, 0, "")
	$__iLineNumber=353 & ' - Return DllStructGetData($URLBuffer, 1)•_WinHttp.au3'
	Return DllStructGetData($URLBuffer, 1)
EndFunc

; #FUNCTION# ;===============================================================================
; Name...........: _WinHttpDetectAutoProxyConfigUrl
; Description ...: Finds the URL for the Proxy Auto-Configuration (PAC) file.
; Syntax.........: _WinHttpDetectAutoProxyConfigUrl($iAutoDetectFlags)
; Parameters ....: $iAutoDetectFlags - Specifies what protocols to use to locate the PAC file.
; Return values .: Success - Returns URL for the PAC file.
;                  Failure - Returns empty string and sets @error:
;                  |1 - DllCall failed
;                  |2 - Internal failure.
; Author ........: trancexx
; Remarks .......: [[$iAutoDetectFlags]] values are defined in WinHttpconstants.au3
; Related .......: _WinHttpGetDefaultProxyConfiguration, _WinHttpGetIEProxyConfigForCurrentUser, _WinHttpSetDefaultProxyConfiguration
; Link ..........: http://msdn.microsoft.com/en-us/library/aa384094.aspx
;============================================================================================
$__iLineNumber=370 & ' - Func _WinHttpDetectAutoProxyConfigUrl($iAutoDetectFlags)•_WinHttp.au3'
Func _WinHttpDetectAutoProxyConfigUrl($iAutoDetectFlags)
	$__iLineNumber=371 & ' - Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHt ...•_WinHttp.au3'
	Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHttpDetectAutoProxyConfigUrl", "dword", $iAutoDetectFlags, "ptr*", 0)
	$__iLineNumber=372 & ' - If @error Or Not $aCall[0] Then Return SetError(1, 0, "")•_WinHttp.au3'
	If @error Or Not $aCall[0] Then Return SetError(1, 0, "")
	$__iLineNumber=373 & ' - Local $pStr = $aCall[2]•_WinHttp.au3'
	Local $pStr = $aCall[2]
	$__iLineNumber=374 & ' - If $pStr Then•_WinHttp.au3'
	If $pStr Then
		$__iLineNumber=375 & ' - Local $iLen = __WinHttpPtrStringLenW($pStr)•_WinHttp.au3'
		Local $iLen = __WinHttpPtrStringLenW($pStr)
		$__iLineNumber=376 & ' - If @error Then Return SetError(2, 0, "")•_WinHttp.au3'
		If @error Then Return SetError(2, 0, "")
		$__iLineNumber=377 & ' - Local $tString = DllStructCreate("wchar[" & $iLen + 1 & "]", ...•_WinHttp.au3'
		Local $tString = DllStructCreate("wchar[" & $iLen + 1 & "]", $pStr)
		$__iLineNumber=378 & ' - Local $sString = DllStructGetData($tString, 1)•_WinHttp.au3'
		Local $sString = DllStructGetData($tString, 1)
		$__iLineNumber=379 & ' - __WinHttpMemGlobalFree($pStr)•_WinHttp.au3'
		__WinHttpMemGlobalFree($pStr)
		$__iLineNumber=380 & ' - Return $sString•_WinHttp.au3'
		Return $sString
	EndIf
	$__iLineNumber=382 & ' - Return ""•_WinHttp.au3'
	Return ""
EndFunc

; #FUNCTION# ;===============================================================================
; Name...........: _WinHttpGetDefaultProxyConfiguration
; Description ...: Retrieves the default WinHttp proxy configuration.
; Syntax.........: _WinHttpGetDefaultProxyConfiguration()
; Parameters ....: None.
; Return values .: Success - Returns array with 3 elements:
;                  |$array[0] - Integer. Access type.
;                  |$array[1] - String. Proxy server list.
;                  |$array[2] - String. Proxy bypass list.
;                  Failure - Returns 0 and sets @error:
;                  |1 - DllCall failed
; Author ........: trancexx
; Remarks .......: Access types are defined in WinHttpconstants.au3:
;                  |[[$WINHTTP_ACCESS_TYPE_DEFAULT_PROXY = 0]]
;                  |[[$WINHTTP_ACCESS_TYPE_NO_PROXY = 1]]
;                  |[[$WINHTTP_ACCESS_TYPE_NAMED_PROXY = 3]]
; Related .......: _WinHttpDetectAutoProxyConfigUrl, _WinHttpGetIEProxyConfigForCurrentUser, _WinHttpSetDefaultProxyConfiguration
; Link ..........: http://msdn.microsoft.com/en-us/library/aa384095.aspx
;============================================================================================
$__iLineNumber=404 & ' - Func _WinHttpGetDefaultProxyConfiguration()•_WinHttp.au3'
Func _WinHttpGetDefaultProxyConfiguration()
	$__iLineNumber=405 & ' - Local $tWINHTTP_PROXY_INFO = DllStructCreate("dword AccessTy ...•_WinHttp.au3'
	Local $tWINHTTP_PROXY_INFO = DllStructCreate("dword AccessType;" & _
			"ptr Proxy;" & _
			"ptr ProxyBypass")
	$__iLineNumber=408 & ' - Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHt ...•_WinHttp.au3'
	Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHttpGetDefaultProxyConfiguration", "struct*", $tWINHTTP_PROXY_INFO)
	$__iLineNumber=409 & ' - If @error Or Not $aCall[0] Then Return SetError(1, 0, 0)•_WinHttp.au3'
	If @error Or Not $aCall[0] Then Return SetError(1, 0, 0)
	$__iLineNumber=410 & ' - Local $iAccessType = DllStructGetData($tWINHTTP_PROXY_INFO,  ...•_WinHttp.au3'
	Local $iAccessType = DllStructGetData($tWINHTTP_PROXY_INFO, "AccessType")
	$__iLineNumber=411 & ' - Local $pProxy = DllStructGetData($tWINHTTP_PROXY_INFO, "Prox ...•_WinHttp.au3'
	Local $pProxy = DllStructGetData($tWINHTTP_PROXY_INFO, "Proxy")
	$__iLineNumber=412 & ' - Local $pProxyBypass = DllStructGetData($tWINHTTP_PROXY_INFO, ...•_WinHttp.au3'
	Local $pProxyBypass = DllStructGetData($tWINHTTP_PROXY_INFO, "ProxyBypass")
	$__iLineNumber=413 & ' - Local $sProxy•_WinHttp.au3'
	Local $sProxy
	$__iLineNumber=414 & ' - If $pProxy Then•_WinHttp.au3'
	If $pProxy Then
		$__iLineNumber=415 & ' - Local $iProxyLen = __WinHttpPtrStringLenW($pProxy)•_WinHttp.au3'
		Local $iProxyLen = __WinHttpPtrStringLenW($pProxy)
		$__iLineNumber=416 & ' - If Not @error Then•_WinHttp.au3'
		If Not @error Then
			$__iLineNumber=417 & ' - Local $tProxy = DllStructCreate("wchar[" & $iProxyLen + 1 &  ...•_WinHttp.au3'
			Local $tProxy = DllStructCreate("wchar[" & $iProxyLen + 1 & "]", $pProxy)
			$__iLineNumber=418 & ' - $sProxy = DllStructGetData($tProxy, 1)•_WinHttp.au3'
			$sProxy = DllStructGetData($tProxy, 1)
			$__iLineNumber=419 & ' - __WinHttpMemGlobalFree($pProxy)•_WinHttp.au3'
			__WinHttpMemGlobalFree($pProxy)
		EndIf
	EndIf
	$__iLineNumber=422 & ' - Local $sProxyBypass•_WinHttp.au3'
	Local $sProxyBypass
	$__iLineNumber=423 & ' - If $pProxyBypass Then•_WinHttp.au3'
	If $pProxyBypass Then
		$__iLineNumber=424 & ' - Local $iProxyBypassLen = __WinHttpPtrStringLenW($pProxyBypas ...•_WinHttp.au3'
		Local $iProxyBypassLen = __WinHttpPtrStringLenW($pProxyBypass)
		$__iLineNumber=425 & ' - If Not @error Then•_WinHttp.au3'
		If Not @error Then
			$__iLineNumber=426 & ' - Local $tProxyBypass = DllStructCreate("wchar[" & $iProxyBypa ...•_WinHttp.au3'
			Local $tProxyBypass = DllStructCreate("wchar[" & $iProxyBypassLen + 1 & "]", $pProxyBypass)
			$__iLineNumber=427 & ' - $sProxyBypass = DllStructGetData($tProxyBypass, 1)•_WinHttp.au3'
			$sProxyBypass = DllStructGetData($tProxyBypass, 1)
			$__iLineNumber=428 & ' - __WinHttpMemGlobalFree($pProxyBypass)•_WinHttp.au3'
			__WinHttpMemGlobalFree($pProxyBypass)
		EndIf
	EndIf
	$__iLineNumber=431 & ' - Local $aRet[3] = [$iAccessType, $sProxy, $sProxyBypass]•_WinHttp.au3'
	Local $aRet[3] = [$iAccessType, $sProxy, $sProxyBypass]
	$__iLineNumber=432 & ' - Return $aRet•_WinHttp.au3'
	Return $aRet
EndFunc

; #FUNCTION# ;===============================================================================
; Name...........: _WinHttpGetIEProxyConfigForCurrentUser
; Description ...: Retrieves the Internet Explorer proxy configuration for the current user.
; Syntax.........: _WinHttpGetIEProxyConfigForCurrentUser()
; Parameters ....: None.
; Return values .: Success - Returns array with 4 elements:
;                  |$array[0] - if 1 indicates that the IE proxy configuration for the current user specifies "automatically detect settings",
;                  |$array[1] - auto-configuration URL if the IE proxy configuration for the current user specifies "Use automatic proxy configuration",
;                  |$array[2] - proxy URL if the IE proxy configuration for the current user specifies "use a proxy server",
;                  |$array[3] - optional proxy by-pass server list.
;                  Failure - Returns 0 and sets @error:
;                  |1 - DllCall failed
;                  |2 - Internal failure.
; Author ........: trancexx
; Related .......: _WinHttpDetectAutoProxyConfigUrl, _WinHttpGetDefaultProxyConfiguration, _WinHttpSetDefaultProxyConfiguration
; Link ..........: http://msdn.microsoft.com/en-us/library/aa384096.aspx
;============================================================================================
$__iLineNumber=452 & ' - Func _WinHttpGetIEProxyConfigForCurrentUser()•_WinHttp.au3'
Func _WinHttpGetIEProxyConfigForCurrentUser()
	$__iLineNumber=453 & ' - Local $tWINHTTP_CURRENT_USER_IE_PROXY_CONFIG = DllStructCrea ...•_WinHttp.au3'
	Local $tWINHTTP_CURRENT_USER_IE_PROXY_CONFIG = DllStructCreate("int AutoDetect;" & _
			"ptr AutoConfigUrl;" & _
			"ptr Proxy;" & _
			"ptr ProxyBypass;")
	$__iLineNumber=457 & ' - Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHt ...•_WinHttp.au3'
	Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHttpGetIEProxyConfigForCurrentUser", "struct*", $tWINHTTP_CURRENT_USER_IE_PROXY_CONFIG)
	$__iLineNumber=458 & ' - If @error Or Not $aCall[0] Then Return SetError(1, 0, 0)•_WinHttp.au3'
	If @error Or Not $aCall[0] Then Return SetError(1, 0, 0)
	$__iLineNumber=459 & ' - Local $iAutoDetect = DllStructGetData($tWINHTTP_CURRENT_USER ...•_WinHttp.au3'
	Local $iAutoDetect = DllStructGetData($tWINHTTP_CURRENT_USER_IE_PROXY_CONFIG, "AutoDetect")
	$__iLineNumber=460 & ' - Local $pAutoConfigUrl = DllStructGetData($tWINHTTP_CURRENT_U ...•_WinHttp.au3'
	Local $pAutoConfigUrl = DllStructGetData($tWINHTTP_CURRENT_USER_IE_PROXY_CONFIG, "AutoConfigUrl")
	$__iLineNumber=461 & ' - Local $pProxy = DllStructGetData($tWINHTTP_CURRENT_USER_IE_P ...•_WinHttp.au3'
	Local $pProxy = DllStructGetData($tWINHTTP_CURRENT_USER_IE_PROXY_CONFIG, "Proxy")
	$__iLineNumber=462 & ' - Local $pProxyBypass = DllStructGetData($tWINHTTP_CURRENT_USE ...•_WinHttp.au3'
	Local $pProxyBypass = DllStructGetData($tWINHTTP_CURRENT_USER_IE_PROXY_CONFIG, "ProxyBypass")
	$__iLineNumber=463 & ' - Local $sAutoConfigUrl•_WinHttp.au3'
	Local $sAutoConfigUrl
	$__iLineNumber=464 & ' - If $pAutoConfigUrl Then•_WinHttp.au3'
	If $pAutoConfigUrl Then
		$__iLineNumber=465 & ' - Local $iAutoConfigUrlLen = __WinHttpPtrStringLenW($pAutoConf ...•_WinHttp.au3'
		Local $iAutoConfigUrlLen = __WinHttpPtrStringLenW($pAutoConfigUrl)
		$__iLineNumber=466 & ' - If Not @error Then•_WinHttp.au3'
		If Not @error Then
			$__iLineNumber=467 & ' - Local $tAutoConfigUrl = DllStructCreate("wchar[" & $iAutoCon ...•_WinHttp.au3'
			Local $tAutoConfigUrl = DllStructCreate("wchar[" & $iAutoConfigUrlLen + 1 & "]", $pAutoConfigUrl)
			$__iLineNumber=468 & ' - $sAutoConfigUrl = DllStructGetData($tAutoConfigUrl, 1)•_WinHttp.au3'
			$sAutoConfigUrl = DllStructGetData($tAutoConfigUrl, 1)
			$__iLineNumber=469 & ' - __WinHttpMemGlobalFree($pAutoConfigUrl)•_WinHttp.au3'
			__WinHttpMemGlobalFree($pAutoConfigUrl)
		EndIf
	EndIf
	$__iLineNumber=472 & ' - Local $sProxy•_WinHttp.au3'
	Local $sProxy
	$__iLineNumber=473 & ' - If $pProxy Then•_WinHttp.au3'
	If $pProxy Then
		$__iLineNumber=474 & ' - Local $iProxyLen = __WinHttpPtrStringLenW($pProxy)•_WinHttp.au3'
		Local $iProxyLen = __WinHttpPtrStringLenW($pProxy)
		$__iLineNumber=475 & ' - If Not @error Then•_WinHttp.au3'
		If Not @error Then
			$__iLineNumber=476 & ' - Local $tProxy = DllStructCreate("wchar[" & $iProxyLen + 1 &  ...•_WinHttp.au3'
			Local $tProxy = DllStructCreate("wchar[" & $iProxyLen + 1 & "]", $pProxy)
			$__iLineNumber=477 & ' - $sProxy = DllStructGetData($tProxy, 1)•_WinHttp.au3'
			$sProxy = DllStructGetData($tProxy, 1)
			$__iLineNumber=478 & ' - __WinHttpMemGlobalFree($pProxy)•_WinHttp.au3'
			__WinHttpMemGlobalFree($pProxy)
		EndIf
	EndIf
	$__iLineNumber=481 & ' - Local $sProxyBypass•_WinHttp.au3'
	Local $sProxyBypass
	$__iLineNumber=482 & ' - If $pProxyBypass Then•_WinHttp.au3'
	If $pProxyBypass Then
		$__iLineNumber=483 & ' - Local $iProxyBypassLen = __WinHttpPtrStringLenW($pProxyBypas ...•_WinHttp.au3'
		Local $iProxyBypassLen = __WinHttpPtrStringLenW($pProxyBypass)
		$__iLineNumber=484 & ' - If Not @error Then•_WinHttp.au3'
		If Not @error Then
			$__iLineNumber=485 & ' - Local $tProxyBypass = DllStructCreate("wchar[" & $iProxyBypa ...•_WinHttp.au3'
			Local $tProxyBypass = DllStructCreate("wchar[" & $iProxyBypassLen + 1 & "]", $pProxyBypass)
			$__iLineNumber=486 & ' - $sProxyBypass = DllStructGetData($tProxyBypass, 1)•_WinHttp.au3'
			$sProxyBypass = DllStructGetData($tProxyBypass, 1)
			$__iLineNumber=487 & ' - __WinHttpMemGlobalFree($pProxyBypass)•_WinHttp.au3'
			__WinHttpMemGlobalFree($pProxyBypass)
		EndIf
	EndIf
	$__iLineNumber=490 & ' - Local $aOutput[4] = [$iAutoDetect, $sAutoConfigUrl, $sProxy, ...•_WinHttp.au3'
	Local $aOutput[4] = [$iAutoDetect, $sAutoConfigUrl, $sProxy, $sProxyBypass]
	$__iLineNumber=491 & ' - Return $aOutput•_WinHttp.au3'
	Return $aOutput
EndFunc

; #FUNCTION# ;===============================================================================
; Name...........: _WinHttpOpen
; Description ...: Initializes the use of WinHttp functions and returns a WinHttp-session handle.
; Syntax.........: _WinHttpOpen([$sUserAgent = Default [, $iAccessType = Default [, $sProxyName = Default [, $sProxyBypass = Default [, $iFlag = Default ]]]]])
; Parameters ....: $sUserAgent - [optional] The name of the application or entity calling the WinHttp functions.
;                  $iAccessType - [optional] Type of access required. Default is $WINHTTP_ACCESS_TYPE_NO_PROXY.
;                  $sProxyName - [optional] The name of the proxy server to use when proxy access is specified by setting $iAccessType to $WINHTTP_ACCESS_TYPE_NAMED_PROXY. Default is $WINHTTP_NO_PROXY_NAME.
;                  $sProxyBypass - [optional] An optional list of host names or IP addresses, or both, that should not be routed through the proxy when $iAccessType is set to $WINHTTP_ACCESS_TYPE_NAMED_PROXY. Default is $WINHTTP_NO_PROXY_BYPASS.
;                  $iFlag - [optional] Integer containing the flags that indicate various options affecting the behavior of this function. Default is 0.
; Return values .: Success - Returns valid session handle.
;                  Failure - Returns 0 and sets @error:
;                  |1 - DllCall failed
; Author ........: trancexx
; Remarks .......: <b>You are strongly discouraged to use WinHTTP in asynchronous mode with AutoIt. AutoIt's callback implementation can't handle reentrancy properly.</b>
;                  +For asynchronous mode set [[$iFlag]] to [[$WINHTTP_FLAG_ASYNC]]. In that case [[$WINHTTP_OPTION_CONTEXT_VALUE]] for the handle will inernally be set to [[$WINHTTP_FLAG_ASYNC]] also.
; Related .......: _WinHttpCloseHandle, _WinHttpConnect
; Link ..........: http://msdn.microsoft.com/en-us/library/aa384098.aspx
;============================================================================================
$__iLineNumber=512 & ' - Func _WinHttpOpen($sUserAgent = Default, $iAccessType = Defa ...•_WinHttp.au3'
Func _WinHttpOpen($sUserAgent = Default, $iAccessType = Default, $sProxyName = Default, $sProxyBypass = Default, $iFlag = Default)
	$__iLineNumber=513 & ' - __WinHttpDefault($sUserAgent, __WinHttpUA())•_WinHttp.au3'
	__WinHttpDefault($sUserAgent, __WinHttpUA())
	$__iLineNumber=514 & ' - __WinHttpDefault($iAccessType, $WINHTTP_ACCESS_TYPE_NO_PROXY ...•_WinHttp.au3'
	__WinHttpDefault($iAccessType, $WINHTTP_ACCESS_TYPE_NO_PROXY)
	$__iLineNumber=515 & ' - __WinHttpDefault($sProxyName, $WINHTTP_NO_PROXY_NAME)•_WinHttp.au3'
	__WinHttpDefault($sProxyName, $WINHTTP_NO_PROXY_NAME)
	$__iLineNumber=516 & ' - __WinHttpDefault($sProxyBypass, $WINHTTP_NO_PROXY_BYPASS)•_WinHttp.au3'
	__WinHttpDefault($sProxyBypass, $WINHTTP_NO_PROXY_BYPASS)
	$__iLineNumber=517 & ' - __WinHttpDefault($iFlag, 0)•_WinHttp.au3'
	__WinHttpDefault($iFlag, 0)
	$__iLineNumber=518 & ' - Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "handle", "Win ...•_WinHttp.au3'
	Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "handle", "WinHttpOpen", _
			"wstr", $sUserAgent, _
			"dword", $iAccessType, _
			"wstr", $sProxyName, _
			"wstr", $sProxyBypass, _
			"dword", $iFlag)
	$__iLineNumber=524 & ' - If @error Or Not $aCall[0] Then Return SetError(1, 0, 0)•_WinHttp.au3'
	If @error Or Not $aCall[0] Then Return SetError(1, 0, 0)
	$__iLineNumber=525 & ' - If $iFlag = $WINHTTP_FLAG_ASYNC Then _WinHttpSetOption($aCal ...•_WinHttp.au3'
	If $iFlag = $WINHTTP_FLAG_ASYNC Then _WinHttpSetOption($aCall[0], $WINHTTP_OPTION_CONTEXT_VALUE, $WINHTTP_FLAG_ASYNC)
	$__iLineNumber=526 & ' - Return $aCall[0]•_WinHttp.au3'
	Return $aCall[0]
EndFunc

; #FUNCTION# ;===============================================================================
; Name...........: _WinHttpOpenRequest
; Description ...: Creates an HTTP request handle.
; Syntax.........: _WinHttpOpenRequest($hConnect [, $sVerb = Default [, $sObjectName = Default [, $sVersion = Default [, $sReferrer = Default [, $sAcceptTypes = Default [, $iFlags = Default ]]]]]])
; Parameters ....: $hConnect - Handle to an HTTP session returned by _WinHttpConnect().
;                  $sVerb - [optional] HTTP verb to use in the request. Default is "GET".
;                  $sObjectName - [optional] The name of the target resource of the specified HTTP verb.
;                  $sVersion - [optional] HTTP version. Default is "HTTP/1.1"
;                  $sReferrer - [optional] URL of the document from which the URL in the request $sObjectName was obtained. Default is $WINHTTP_NO_REFERER.
;                  $sAcceptTypes - [optional] Media types accepted by the client. Default is $WINHTTP_DEFAULT_ACCEPT_TYPES
;                  $iFlags - [optional] Integer specifying the Internet flag values. Default is $WINHTTP_FLAG_ESCAPE_DISABLE
; Return values .: Success - Returns valid session handle.
;                  Failure - Returns 0 and sets @error:
;                  |1 - DllCall failed
; Author ........: trancexx
; Related .......: _WinHttpCloseHandle, _WinHttpConnect, _WinHttpSendRequest
; Link ..........: http://msdn.microsoft.com/en-us/library/aa384099.aspx
;============================================================================================
$__iLineNumber=547 & ' - Func _WinHttpOpenRequest($hConnect, $sVerb = Default, $sObje ...•_WinHttp.au3'
Func _WinHttpOpenRequest($hConnect, $sVerb = Default, $sObjectName = Default, $sVersion = Default, $sReferrer = Default, $sAcceptTypes = Default, $iFlags = Default)
	$__iLineNumber=548 & ' - __WinHttpDefault($sVerb, "GET")•_WinHttp.au3'
	__WinHttpDefault($sVerb, "GET")
	$__iLineNumber=549 & ' - __WinHttpDefault($sObjectName, "")•_WinHttp.au3'
	__WinHttpDefault($sObjectName, "")
	$__iLineNumber=550 & ' - __WinHttpDefault($sVersion, "HTTP/1.1")•_WinHttp.au3'
	__WinHttpDefault($sVersion, "HTTP/1.1")
	$__iLineNumber=551 & ' - __WinHttpDefault($sReferrer, $WINHTTP_NO_REFERER)•_WinHttp.au3'
	__WinHttpDefault($sReferrer, $WINHTTP_NO_REFERER)
	$__iLineNumber=552 & ' - __WinHttpDefault($iFlags, $WINHTTP_FLAG_ESCAPE_DISABLE)•_WinHttp.au3'
	__WinHttpDefault($iFlags, $WINHTTP_FLAG_ESCAPE_DISABLE)
	$__iLineNumber=553 & ' - Local $pAcceptTypes•_WinHttp.au3'
	Local $pAcceptTypes
	$__iLineNumber=554 & ' - If $sAcceptTypes = Default Or Number($sAcceptTypes) = -1 The ...•_WinHttp.au3'
	If $sAcceptTypes = Default Or Number($sAcceptTypes) = -1 Then
		$__iLineNumber=555 & ' - $pAcceptTypes = $WINHTTP_DEFAULT_ACCEPT_TYPES•_WinHttp.au3'
		$pAcceptTypes = $WINHTTP_DEFAULT_ACCEPT_TYPES
	Else
		$__iLineNumber=557 & ' - Local $aTypes = StringSplit($sAcceptTypes, ",", 2)•_WinHttp.au3'
		Local $aTypes = StringSplit($sAcceptTypes, ",", 2)
		$__iLineNumber=558 & ' - Local $tAcceptTypes = DllStructCreate("ptr[" & UBound($aType ...•_WinHttp.au3'
		Local $tAcceptTypes = DllStructCreate("ptr[" & UBound($aTypes) + 1 & "]")
		$__iLineNumber=559 & ' - Local $tType[UBound($aTypes)]•_WinHttp.au3'
		Local $tType[UBound($aTypes)]
		$__iLineNumber=560 & ' - For $i = 0 To UBound($aTypes) - 1•_WinHttp.au3'
		For $i = 0 To UBound($aTypes) - 1
			$__iLineNumber=561 & ' - $tType[$i] = DllStructCreate("wchar[" & StringLen($aTypes[$i ...•_WinHttp.au3'
			$tType[$i] = DllStructCreate("wchar[" & StringLen($aTypes[$i]) + 1 & "]")
			$__iLineNumber=562 & ' - DllStructSetData($tType[$i], 1, $aTypes[$i])•_WinHttp.au3'
			DllStructSetData($tType[$i], 1, $aTypes[$i])
			$__iLineNumber=563 & ' - DllStructSetData($tAcceptTypes, 1, DllStructGetPtr($tType[$i ...•_WinHttp.au3'
			DllStructSetData($tAcceptTypes, 1, DllStructGetPtr($tType[$i]), $i + 1)
		Next
		$__iLineNumber=565 & ' - $pAcceptTypes = DllStructGetPtr($tAcceptTypes)•_WinHttp.au3'
		$pAcceptTypes = DllStructGetPtr($tAcceptTypes)
	EndIf
	$__iLineNumber=567 & ' - Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "handle", "Win ...•_WinHttp.au3'
	Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "handle", "WinHttpOpenRequest", _
			"handle", $hConnect, _
			"wstr", StringUpper($sVerb), _
			"wstr", $sObjectName, _
			"wstr", StringUpper($sVersion), _
			"wstr", $sReferrer, _
			"ptr", $pAcceptTypes, _
			"dword", $iFlags)
	$__iLineNumber=575 & ' - If @error Or Not $aCall[0] Then Return SetError(1, 0, 0)•_WinHttp.au3'
	If @error Or Not $aCall[0] Then Return SetError(1, 0, 0)
	$__iLineNumber=576 & ' - Return $aCall[0]•_WinHttp.au3'
	Return $aCall[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name ..........: _WinHttpQueryAuthSchemes
; Description ...: Returns the authorization schemes that are supported by the server.
; Syntax ........: _WinHttpQueryAuthSchemes($hRequest, Byref $iSupportedSchemes, Byref $iFirstScheme, Byref $iAuthTarget)
; Parameters ....: $hRequest - Valid handle returned by _WinHttpSendRequest().
;                  $iSupportedSchemes - [out] Supported authentication schemes. See remarks.
;                  $iFirstScheme - [out] First authentication scheme listed by the server. See remarks.
;                  $iAuthTarget - [out] A flag that contains the authentication target. See remarks.
; Return values .: Success - Returns 1
;                  Failure - Returns 0 and sets @error:
;                  |1 - DllCall failed
; Author ........: trancexx
; Remarks .......: _WinHttpQueryAuthSchemes() is called after _WinHttpQueryHeaders().
;                  +Arguments are accepted ByRef.
;                  +Both [[$iSupportedSchemes]] and [[$iFirstScheme]] is set to combination of any of [[$WINHTTP_AUTH_SCHEME_]] flags.
;                  +[[$iAuthTarget]] parameter is set to one or more [[$WINHTTP_AUTH_TARGET_]] constants values.
; Related .......: _WinHttpSetCredentials, _WinHttpQueryHeaders, _WinHttpOpenRequest
; Link ..........: http://msdn.microsoft.com/en-us/library/aa384100.aspx
; ===============================================================================================================================
$__iLineNumber=598 & ' - Func _WinHttpQueryAuthSchemes($hRequest, ByRef $iSupportedSc ...•_WinHttp.au3'
Func _WinHttpQueryAuthSchemes($hRequest, ByRef $iSupportedSchemes, ByRef $iFirstScheme, ByRef $iAuthTarget)
	$__iLineNumber=599 & ' - Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHt ...•_WinHttp.au3'
	Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHttpQueryAuthSchemes", _
			"handle", $hRequest, _
			"dword*", 0, _
			"dword*", 0, _
			"dword*", 0)
	$__iLineNumber=604 & ' - If @error Or Not $aCall[0] Then Return SetError(1, 0, 0)•_WinHttp.au3'
	If @error Or Not $aCall[0] Then Return SetError(1, 0, 0)
	$__iLineNumber=605 & ' - $iSupportedSchemes = $aCall[2]•_WinHttp.au3'
	$iSupportedSchemes = $aCall[2]
	$__iLineNumber=606 & ' - $iFirstScheme = $aCall[3]•_WinHttp.au3'
	$iFirstScheme = $aCall[3]
	$__iLineNumber=607 & ' - $iAuthTarget = $aCall[4]•_WinHttp.au3'
	$iAuthTarget = $aCall[4]
	$__iLineNumber=608 & ' - Return 1•_WinHttp.au3'
	Return 1
EndFunc

; #FUNCTION# ;===============================================================================
; Name...........: _WinHttpQueryDataAvailable
; Description ...: Returns the availability to be read with _WinHttpReadData().
; Syntax.........: _WinHttpQueryDataAvailable($hRequest)
; Parameters ....: $hRequest - handle returned by _WinHttpOpenRequest().
; Return values .: Success - Returns 1 if data is available.
;                          - Returns 0 if no data is available.
;                          - @extended receives the number of available bytes.
;                  Failure - Returns 0 and sets @error:
;                  |1 - DllCall failed
; Author ........: trancexx
; Remarks .......: _WinHttpReceiveResponse must have been called for this handle and completed before _WinHttpQueryDataAvailable is called.
; Related .......: _WinHttpOpenRequest, _WinHttpReadData, _WinHttpReceiveResponse
; Link ..........: http://msdn.microsoft.com/en-us/library/aa384101.aspx
;============================================================================================
$__iLineNumber=626 & ' - Func _WinHttpQueryDataAvailable($hRequest)•_WinHttp.au3'
Func _WinHttpQueryDataAvailable($hRequest)
	$__iLineNumber=627 & ' - Local $sReadType = "dword*"•_WinHttp.au3'
	Local $sReadType = "dword*"
	$__iLineNumber=628 & ' - If BitAND(_WinHttpQueryOption(_WinHttpQueryOption(_WinHttpQu ...•_WinHttp.au3'
	If BitAND(_WinHttpQueryOption(_WinHttpQueryOption(_WinHttpQueryOption($hRequest, $WINHTTP_OPTION_PARENT_HANDLE), $WINHTTP_OPTION_PARENT_HANDLE), $WINHTTP_OPTION_CONTEXT_VALUE), $WINHTTP_FLAG_ASYNC) Then $sReadType = "ptr"
	$__iLineNumber=629 & ' - Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHt ...•_WinHttp.au3'
	Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHttpQueryDataAvailable", "handle", $hRequest, $sReadType, 0)
	$__iLineNumber=630 & ' - If @error Then Return SetError(1, 0, 0)•_WinHttp.au3'
	If @error Then Return SetError(1, 0, 0)
	$__iLineNumber=631 & ' - Return SetExtended($aCall[2], $aCall[0])•_WinHttp.au3'
	Return SetExtended($aCall[2], $aCall[0])
EndFunc

; #FUNCTION# ;===============================================================================
; Name...........: _WinHttpQueryHeaders
; Description ...: Retrieves header information associated with an HTTP request.
; Syntax.........: _WinHttpQueryHeaders($hRequest [, $iInfoLevel = Default [, $sName = Default [, $iIndex = Default ]]])
; Parameters ....: $hRequest - Handle returned by _WinHttpOpenRequest().
;                  $iInfoLevel - [optional] A combination of attribute and modifier flags. Default is $WINHTTP_QUERY_RAW_HEADERS_CRLF.
;                  $sName - [optional] Header name string. Default is $WINHTTP_HEADER_NAME_BY_INDEX.
;                  $iIndex - [optional] Index used to enumerate multiple headers with the same name
; Return values .: Success - Returns string that contains header.
;                          - @extended is set to the index of the next header
;                  Failure - Returns empty string and sets @error:
;                  |1 - DllCall failed
; Author ........: trancexx
; Related .......: _WinHttpAddRequestHeaders, _WinHttpOpenRequest
; Link ..........: http://msdn.microsoft.com/en-us/library/aa384102.aspx
;============================================================================================
$__iLineNumber=650 & ' - Func _WinHttpQueryHeaders($hRequest, $iInfoLevel = Default,  ...•_WinHttp.au3'
Func _WinHttpQueryHeaders($hRequest, $iInfoLevel = Default, $sName = Default, $iIndex = Default)
	$__iLineNumber=651 & ' - __WinHttpDefault($iInfoLevel, $WINHTTP_QUERY_RAW_HEADERS_CRL ...•_WinHttp.au3'
	__WinHttpDefault($iInfoLevel, $WINHTTP_QUERY_RAW_HEADERS_CRLF)
	$__iLineNumber=652 & ' - __WinHttpDefault($sName, $WINHTTP_HEADER_NAME_BY_INDEX)•_WinHttp.au3'
	__WinHttpDefault($sName, $WINHTTP_HEADER_NAME_BY_INDEX)
	$__iLineNumber=653 & ' - __WinHttpDefault($iIndex, $WINHTTP_NO_HEADER_INDEX)•_WinHttp.au3'
	__WinHttpDefault($iIndex, $WINHTTP_NO_HEADER_INDEX)
	$__iLineNumber=654 & ' - Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHt ...•_WinHttp.au3'
	Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHttpQueryHeaders", _
			"handle", $hRequest, _
			"dword", $iInfoLevel, _
			"wstr", $sName, _
			"wstr", "", _
			"dword*", 65536, _
			"dword*", $iIndex)
	$__iLineNumber=661 & ' - If @error Or Not $aCall[0] Then Return SetError(1, 0, "")•_WinHttp.au3'
	If @error Or Not $aCall[0] Then Return SetError(1, 0, "")
	$__iLineNumber=662 & ' - Return SetExtended($aCall[6], $aCall[4])•_WinHttp.au3'
	Return SetExtended($aCall[6], $aCall[4])
EndFunc

; #FUNCTION# ;===============================================================================
; Name...........: _WinHttpQueryOption
; Description ...: Queries an Internet option on the specified handle.
; Syntax.........: _WinHttpQueryOption($hInternet, $iOption)
; Parameters ....: $hInternet - Handle on which to query information.
;                  $iOption - Internet option to query.
; Return values .: Success - Returns data containing requested information.
;                  Failure - Returns empty string and sets @error:
;                  |1 - Initial DllCall failed
;                  |2 - Main DllCall failed
; Author ........: trancexx
; Remarks .......: Type of the returned data varies on request.
; Related .......: _WinHttpSetOption
; Link ..........: http://msdn.microsoft.com/en-us/library/aa384103.aspx
;============================================================================================
$__iLineNumber=680 & ' - Func _WinHttpQueryOption($hInternet, $iOption)•_WinHttp.au3'
Func _WinHttpQueryOption($hInternet, $iOption)
	$__iLineNumber=681 & ' - Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHt ...•_WinHttp.au3'
	Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHttpQueryOption", _
			"handle", $hInternet, _
			"dword", $iOption, _
			"ptr", 0, _
			"dword*", 0)
	$__iLineNumber=686 & ' - If @error Or $aCall[0] Then Return SetError(1, 0, "")•_WinHttp.au3'
	If @error Or $aCall[0] Then Return SetError(1, 0, "")
	$__iLineNumber=687 & ' - Local $iSize = $aCall[4]•_WinHttp.au3'
	Local $iSize = $aCall[4]
	$__iLineNumber=688 & ' - Local $tBuffer•_WinHttp.au3'
	Local $tBuffer
	$__iLineNumber=689 & ' - Switch $iOption•_WinHttp.au3'
	$__iLineNumber=690 & ' - Case $WINHTTP_OPTION_CONNECTION_INFO, $WINHTTP_OPTION_PASSWO ...•_WinHttp.au3'
	Switch $iOption
		Case $WINHTTP_OPTION_CONNECTION_INFO, $WINHTTP_OPTION_PASSWORD, $WINHTTP_OPTION_PROXY_PASSWORD, $WINHTTP_OPTION_PROXY_USERNAME, $WINHTTP_OPTION_URL, $WINHTTP_OPTION_USERNAME, $WINHTTP_OPTION_USER_AGENT, _
				$WINHTTP_OPTION_PASSPORT_COBRANDING_TEXT, $WINHTTP_OPTION_PASSPORT_COBRANDING_URL
			$__iLineNumber=692 & ' - $tBuffer = DllStructCreate("wchar[" & $iSize + 1 & "]")•_WinHttp.au3'
			$tBuffer = DllStructCreate("wchar[" & $iSize + 1 & "]")
		$__iLineNumber=693 & ' - Case $WINHTTP_OPTION_PARENT_HANDLE, $WINHTTP_OPTION_CALLBACK ...•_WinHttp.au3'
		Case $WINHTTP_OPTION_PARENT_HANDLE, $WINHTTP_OPTION_CALLBACK, $WINHTTP_OPTION_SERVER_CERT_CONTEXT
			$__iLineNumber=694 & ' - $tBuffer = DllStructCreate("ptr")•_WinHttp.au3'
			$tBuffer = DllStructCreate("ptr")
		$__iLineNumber=695 & ' - Case $WINHTTP_OPTION_CONNECT_TIMEOUT, $WINHTTP_AUTOLOGON_SEC ...•_WinHttp.au3'
		Case $WINHTTP_OPTION_CONNECT_TIMEOUT, $WINHTTP_AUTOLOGON_SECURITY_LEVEL_HIGH, $WINHTTP_AUTOLOGON_SECURITY_LEVEL_LOW, $WINHTTP_AUTOLOGON_SECURITY_LEVEL_MEDIUM, _
				$WINHTTP_OPTION_CONFIGURE_PASSPORT_AUTH, $WINHTTP_OPTION_CONNECT_RETRIES, $WINHTTP_OPTION_EXTENDED_ERROR, $WINHTTP_OPTION_HANDLE_TYPE, $WINHTTP_OPTION_MAX_CONNS_PER_1_0_SERVER, _
				$WINHTTP_OPTION_MAX_CONNS_PER_SERVER, $WINHTTP_OPTION_MAX_HTTP_AUTOMATIC_REDIRECTS, $WINHTTP_OPTION_RECEIVE_RESPONSE_TIMEOUT, $WINHTTP_OPTION_RECEIVE_TIMEOUT, _
				$WINHTTP_OPTION_RESOLVE_TIMEOUT, $WINHTTP_OPTION_SECURITY_FLAGS, $WINHTTP_OPTION_SECURITY_KEY_BITNESS, $WINHTTP_OPTION_SEND_TIMEOUT
			$__iLineNumber=699 & ' - $tBuffer = DllStructCreate("int")•_WinHttp.au3'
			$tBuffer = DllStructCreate("int")
		$__iLineNumber=700 & ' - Case $WINHTTP_OPTION_CONTEXT_VALUE•_WinHttp.au3'
		Case $WINHTTP_OPTION_CONTEXT_VALUE
			$__iLineNumber=701 & ' - $tBuffer = DllStructCreate("dword_ptr")•_WinHttp.au3'
			$tBuffer = DllStructCreate("dword_ptr")
		Case Else
			$__iLineNumber=703 & ' - $tBuffer = DllStructCreate("byte[" & $iSize & "]")•_WinHttp.au3'
			$tBuffer = DllStructCreate("byte[" & $iSize & "]")
	EndSwitch
	$__iLineNumber=705 & ' - $aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHttpQuer ...•_WinHttp.au3'
	$aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHttpQueryOption", _
			"handle", $hInternet, _
			"dword", $iOption, _
			"struct*", $tBuffer, _
			"dword*", $iSize)
	$__iLineNumber=710 & ' - If @error Or Not $aCall[0] Then Return SetError(2, 0, "")•_WinHttp.au3'
	If @error Or Not $aCall[0] Then Return SetError(2, 0, "")
	$__iLineNumber=711 & ' - Return DllStructGetData($tBuffer, 1)•_WinHttp.au3'
	Return DllStructGetData($tBuffer, 1)
EndFunc

; #FUNCTION# ;===============================================================================
; Name...........: _WinHttpReadData
; Description ...: Reads data from a handle opened by the _WinHttpOpenRequest() function.
; Syntax.........: _WinHttpReadData($hRequest [, $iMode = Default [, $iNumberOfBytesToRead = Default ]])
; Parameters ....: $hRequest - Valid handle returned from a previous call to _WinHttpOpenRequest().
;                  $iMode - [optional] Integer representing reading mode. Default is 0 (charset is decoded as it is ANSI).
;                  $iNumberOfBytesToRead - [optional] The number of bytes to read. Default is 8192 bytes.
; Return values .: Success - Returns data read.
;                          - @extended receives the number of bytes read.
;                  Special: Sets @error to -1 if no more data to read (end reached).
;                  Failure - Returns empty string and sets @error:
;                  |1 - DllCall failed
; Author ........: trancexx, ProgAndy
; Remarks .......: [[$iMode]] can have these values:
;                  |[[0]] - ANSI
;                  |[[1]] - UTF8
;                  |[[2]] - Binary
; Related .......: _WinHttpOpenRequest, _WinHttpWriteData
; Link ..........: http://msdn.microsoft.com/en-us/library/aa384104.aspx
;============================================================================================
$__iLineNumber=734 & ' - Func _WinHttpReadData($hRequest, $iMode = Default, $iNumberO ...•_WinHttp.au3'
Func _WinHttpReadData($hRequest, $iMode = Default, $iNumberOfBytesToRead = Default, $pBuffer = Default)
	$__iLineNumber=735 & ' - __WinHttpDefault($iMode, 0)•_WinHttp.au3'
	__WinHttpDefault($iMode, 0)
	$__iLineNumber=736 & ' - __WinHttpDefault($iNumberOfBytesToRead, 8192)•_WinHttp.au3'
	__WinHttpDefault($iNumberOfBytesToRead, 8192)
	$__iLineNumber=737 & ' - Local $tBuffer, $vOutOnError = ""•_WinHttp.au3'
	Local $tBuffer, $vOutOnError = ""
	$__iLineNumber=738 & ' - If $iMode = 2 Then $vOutOnError = Binary($vOutOnError)•_WinHttp.au3'
	If $iMode = 2 Then $vOutOnError = Binary($vOutOnError)
	$__iLineNumber=739 & ' - Switch $iMode•_WinHttp.au3'
	$__iLineNumber=740 & ' - Case 1, 2•_WinHttp.au3'
	Switch $iMode
		Case 1, 2
			$__iLineNumber=741 & ' - If $pBuffer And $pBuffer <> Default Then•_WinHttp.au3'
			If $pBuffer And $pBuffer <> Default Then
				$__iLineNumber=742 & ' - $tBuffer = DllStructCreate("byte[" & $iNumberOfBytesToRead & ...•_WinHttp.au3'
				$tBuffer = DllStructCreate("byte[" & $iNumberOfBytesToRead & "]", $pBuffer)
			Else
				$__iLineNumber=744 & ' - $tBuffer = DllStructCreate("byte[" & $iNumberOfBytesToRead & ...•_WinHttp.au3'
				$tBuffer = DllStructCreate("byte[" & $iNumberOfBytesToRead & "]")
			EndIf
		Case Else
			$__iLineNumber=747 & ' - $iMode = 0•_WinHttp.au3'
			$iMode = 0
			$__iLineNumber=748 & ' - If $pBuffer And $pBuffer <> Default Then•_WinHttp.au3'
			If $pBuffer And $pBuffer <> Default Then
				$__iLineNumber=749 & ' - $tBuffer = DllStructCreate("char[" & $iNumberOfBytesToRead & ...•_WinHttp.au3'
				$tBuffer = DllStructCreate("char[" & $iNumberOfBytesToRead & "]", $pBuffer)
			Else
				$__iLineNumber=751 & ' - $tBuffer = DllStructCreate("char[" & $iNumberOfBytesToRead & ...•_WinHttp.au3'
				$tBuffer = DllStructCreate("char[" & $iNumberOfBytesToRead & "]")
			EndIf
	EndSwitch
	$__iLineNumber=754 & ' - Local $sReadType = "dword*"•_WinHttp.au3'
	Local $sReadType = "dword*"
	$__iLineNumber=755 & ' - If BitAND(_WinHttpQueryOption(_WinHttpQueryOption(_WinHttpQu ...•_WinHttp.au3'
	If BitAND(_WinHttpQueryOption(_WinHttpQueryOption(_WinHttpQueryOption($hRequest, $WINHTTP_OPTION_PARENT_HANDLE), $WINHTTP_OPTION_PARENT_HANDLE), $WINHTTP_OPTION_CONTEXT_VALUE), $WINHTTP_FLAG_ASYNC) Then $sReadType = "ptr"
	$__iLineNumber=756 & ' - Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHt ...•_WinHttp.au3'
	Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHttpReadData", _
			"handle", $hRequest, _
			"struct*", $tBuffer, _
			"dword", $iNumberOfBytesToRead, _
			$sReadType, 0)
	$__iLineNumber=761 & ' - If @error Or Not $aCall[0] Then Return SetError(1, 0, "")•_WinHttp.au3'
	If @error Or Not $aCall[0] Then Return SetError(1, 0, "")
	$__iLineNumber=762 & ' - If Not $aCall[4] Then Return SetError(-1, 0, $vOutOnError)•_WinHttp.au3'
	If Not $aCall[4] Then Return SetError(-1, 0, $vOutOnError)
	$__iLineNumber=763 & ' - If $aCall[4] < $iNumberOfBytesToRead Then•_WinHttp.au3'
	If $aCall[4] < $iNumberOfBytesToRead Then
		$__iLineNumber=764 & ' - Switch $iMode•_WinHttp.au3'
		$__iLineNumber=765 & ' - Case 0•_WinHttp.au3'
		Switch $iMode
			Case 0
				$__iLineNumber=766 & ' - Return SetExtended($aCall[4], StringLeft(DllStructGetData($t ...•_WinHttp.au3'
				Return SetExtended($aCall[4], StringLeft(DllStructGetData($tBuffer, 1), $aCall[4]))
			$__iLineNumber=767 & ' - Case 1•_WinHttp.au3'
			Case 1
				$__iLineNumber=768 & ' - Return SetExtended($aCall[4], BinaryToString(BinaryMid(DllSt ...•_WinHttp.au3'
				Return SetExtended($aCall[4], BinaryToString(BinaryMid(DllStructGetData($tBuffer, 1), 1, $aCall[4]), 4))
			$__iLineNumber=769 & ' - Case 2•_WinHttp.au3'
			Case 2
				$__iLineNumber=770 & ' - Return SetExtended($aCall[4], BinaryMid(DllStructGetData($tB ...•_WinHttp.au3'
				Return SetExtended($aCall[4], BinaryMid(DllStructGetData($tBuffer, 1), 1, $aCall[4]))
		EndSwitch
	Else
		$__iLineNumber=773 & ' - Switch $iMode•_WinHttp.au3'
		$__iLineNumber=774 & ' - Case 0, 2•_WinHttp.au3'
		Switch $iMode
			Case 0, 2
				$__iLineNumber=775 & ' - Return SetExtended($aCall[4], DllStructGetData($tBuffer, 1))•_WinHttp.au3'
				Return SetExtended($aCall[4], DllStructGetData($tBuffer, 1))
			$__iLineNumber=776 & ' - Case 1•_WinHttp.au3'
			Case 1
				$__iLineNumber=777 & ' - Return SetExtended($aCall[4], BinaryToString(DllStructGetDat ...•_WinHttp.au3'
				Return SetExtended($aCall[4], BinaryToString(DllStructGetData($tBuffer, 1), 4))
		EndSwitch
	EndIf
EndFunc

; #FUNCTION# ;===============================================================================
; Name...........: _WinHttpReceiveResponse
; Description ...: Waits to receive the response to an HTTP request initiated by WinHttpSendRequest().
; Syntax.........: _WinHttpReceiveResponse($hRequest)
; Parameters ....: $hRequest - Handle returned by _WinHttpOpenRequest() and sent by _WinHttpSendRequest().
; Return values .: Success - Returns 1.
;                  Failure - Returns 0 and sets @error:
;                  |1 - DllCall failed
; Author ........: trancexx
; Remarks .......: Call to _WinHttpReceiveResponse() must be done before _WinHttpQueryDataAvailable() and _WinHttpReadData().
; Related .......: _WinHttpOpenRequest, _WinHttpSetTimeouts
; Link ..........: http://msdn.microsoft.com/en-us/library/aa384105.aspx
;============================================================================================
$__iLineNumber=795 & ' - Func _WinHttpReceiveResponse($hRequest)•_WinHttp.au3'
Func _WinHttpReceiveResponse($hRequest)
	$__iLineNumber=796 & ' - Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHt ...•_WinHttp.au3'
	Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHttpReceiveResponse", "handle", $hRequest, "ptr", 0)
	$__iLineNumber=797 & ' - If @error Or Not $aCall[0] Then Return SetError(1, 0, 0)•_WinHttp.au3'
	If @error Or Not $aCall[0] Then Return SetError(1, 0, 0)
	$__iLineNumber=798 & ' - Return 1•_WinHttp.au3'
	Return 1
EndFunc

; #FUNCTION# ;===============================================================================
; Name...........: _WinHttpSendRequest
; Description ...: Sends the specified request to the HTTP server.
; Syntax.........: _WinHttpSendRequest($hRequest [, $sHeaders = Default [, $sOptional = Default [, $iTotalLength = Default [, $iContext = Default ]]]])
; Parameters ....: $hRequest - Handle returned by _WinHttpOpenRequest().
;                  $sHeaders - [optional] Additional headers to append to the request. Default is $WINHTTP_NO_ADDITIONAL_HEADERS.
;                  $vOptional - [optional] Optional data to send immediately after the request headers. Default is $WINHTTP_NO_REQUEST_DATA.
;                  $iTotalLength - [optional] Length, in bytes, of the total optional data sent. Default is 0.
;                  $iContext - [optional] Application-defined value that is passed, with the request handle, to any callback functions. Default is 0.
; Return values .: Success - Returns 1.
;                  Failure - Returns 0 and sets @error:
;                  |1 - DllCall failed
; Author ........: trancexx
; Remarks .......: Specifying optional data [[$vOptional]] will cause [[$iTotalLength]] to receive the size of that data if left default value.
; Related .......: _WinHttpOpenRequest
; Link ..........: http://msdn.microsoft.com/en-us/library/aa384110.aspx
;============================================================================================
$__iLineNumber=818 & ' - Func _WinHttpSendRequest($hRequest, $sHeaders = Default, $vO ...•_WinHttp.au3'
Func _WinHttpSendRequest($hRequest, $sHeaders = Default, $vOptional = Default, $iTotalLength = Default, $iContext = Default)
	$__iLineNumber=819 & ' - __WinHttpDefault($sHeaders, $WINHTTP_NO_ADDITIONAL_HEADERS)•_WinHttp.au3'
	__WinHttpDefault($sHeaders, $WINHTTP_NO_ADDITIONAL_HEADERS)
	$__iLineNumber=820 & ' - __WinHttpDefault($vOptional, $WINHTTP_NO_REQUEST_DATA)•_WinHttp.au3'
	__WinHttpDefault($vOptional, $WINHTTP_NO_REQUEST_DATA)
	$__iLineNumber=821 & ' - __WinHttpDefault($iTotalLength, 0)•_WinHttp.au3'
	__WinHttpDefault($iTotalLength, 0)
	$__iLineNumber=822 & ' - __WinHttpDefault($iContext, 0)•_WinHttp.au3'
	__WinHttpDefault($iContext, 0)
	$__iLineNumber=823 & ' - Local $pOptional = 0, $iOptionalLength = 0•_WinHttp.au3'
	Local $pOptional = 0, $iOptionalLength = 0
	$__iLineNumber=824 & ' - If @NumParams > 2 Then•_WinHttp.au3'
	If @NumParams > 2 Then
		$__iLineNumber=825 & ' - Local $tOptional•_WinHttp.au3'
		Local $tOptional
		$__iLineNumber=826 & ' - $iOptionalLength = BinaryLen($vOptional)•_WinHttp.au3'
		$iOptionalLength = BinaryLen($vOptional)
		$__iLineNumber=827 & ' - $tOptional = DllStructCreate("byte[" & $iOptionalLength & "] ...•_WinHttp.au3'
		$tOptional = DllStructCreate("byte[" & $iOptionalLength & "]")
		$__iLineNumber=828 & ' - If $iOptionalLength Then $pOptional = DllStructGetPtr($tOpti ...•_WinHttp.au3'
		If $iOptionalLength Then $pOptional = DllStructGetPtr($tOptional)
		$__iLineNumber=829 & ' - DllStructSetData($tOptional, 1, $vOptional)•_WinHttp.au3'
		DllStructSetData($tOptional, 1, $vOptional)
	EndIf
	$__iLineNumber=831 & ' - If Not $iTotalLength Or $iTotalLength < $iOptionalLength The ...•_WinHttp.au3'
	If Not $iTotalLength Or $iTotalLength < $iOptionalLength Then $iTotalLength += $iOptionalLength
	$__iLineNumber=832 & ' - Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHt ...•_WinHttp.au3'
	Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHttpSendRequest", _
			"handle", $hRequest, _
			"wstr", $sHeaders, _
			"dword", 0, _
			"ptr", $pOptional, _
			"dword", $iOptionalLength, _
			"dword", $iTotalLength, _
			"dword_ptr", $iContext)
	$__iLineNumber=840 & ' - If @error Or Not $aCall[0] Then Return SetError(1, 0, 0)•_WinHttp.au3'
	If @error Or Not $aCall[0] Then Return SetError(1, 0, 0)
	$__iLineNumber=841 & ' - Return 1•_WinHttp.au3'
	Return 1
EndFunc

; #FUNCTION# ;===============================================================================
; Name...........: _WinHttpSetCredentials
; Description ...: Passes the required authorization credentials to the server.
; Syntax.........: _WinHttpSetCredentials($hRequest, $iAuthTargets, $iAuthScheme, $sUserName, $sPassword)
; Parameters ....: $hRequest - Valid handle returned by _WinHttpOpenRequest().
;                  $iAuthTargets - Authentication target.
;                  $iAuthScheme - Authentication scheme.
;                  $sUserName - Valid user name.
;                  $sPassword - Valid password.
; Return values .: Success - Returns 1.
;                  Failure - Returns 0 and sets @error:
;                  |1 - DllCall failed
; Author ........: trancexx
; Related .......: _WinHttpOpenRequest
; Link ..........: http://msdn.microsoft.com/en-us/library/aa384112.aspx
;============================================================================================
$__iLineNumber=860 & ' - Func _WinHttpSetCredentials($hRequest, $iAuthTargets, $iAuth ...•_WinHttp.au3'
Func _WinHttpSetCredentials($hRequest, $iAuthTargets, $iAuthScheme, $sUserName, $sPassword)
	$__iLineNumber=861 & ' - Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHt ...•_WinHttp.au3'
	Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHttpSetCredentials", _
			"handle", $hRequest, _
			"dword", $iAuthTargets, _
			"dword", $iAuthScheme, _
			"wstr", $sUserName, _
			"wstr", $sPassword, _
			"ptr", 0)
	$__iLineNumber=868 & ' - If @error Or Not $aCall[0] Then Return SetError(1, 0, 0)•_WinHttp.au3'
	If @error Or Not $aCall[0] Then Return SetError(1, 0, 0)
	$__iLineNumber=869 & ' - Return 1•_WinHttp.au3'
	Return 1
EndFunc

; #FUNCTION# ;===============================================================================
; Name...........: _WinHttpSetDefaultProxyConfiguration
; Description ...: Sets the default WinHttp proxy configuration.
; Syntax.........: _WinHttpSetDefaultProxyConfiguration($iAccessType [, $sProxy = "" [, $sProxyBypass = ""])
; Parameters ....: $iAccessType - Integer. Access type.
;                  $sProxy - [optional] String. Proxy server list.
;                  $sProxyBypass - [optional] String. Proxy bypass list.
; Return values .: Success - Returns 1.
;                  Failure - Returns 0 and sets @error:
;                  |1 - DllCall failed
; Author ........: trancexx
; Related .......: _WinHttpDetectAutoProxyConfigUrl, _WinHttpGetDefaultProxyConfiguration, _WinHttpGetIEProxyConfigForCurrentUser
; Link ..........: http://msdn.microsoft.com/en-us/library/aa384113.aspx
;============================================================================================
$__iLineNumber=886 & ' - Func _WinHttpSetDefaultProxyConfiguration($iAccessType, $sPr ...•_WinHttp.au3'
Func _WinHttpSetDefaultProxyConfiguration($iAccessType, $sProxy = "", $sProxyBypass = "")
	$__iLineNumber=887 & ' - Local $tProxy = DllStructCreate("wchar[" & StringLen($sProxy ...•_WinHttp.au3'
	Local $tProxy = DllStructCreate("wchar[" & StringLen($sProxy) + 1 & "]")
	$__iLineNumber=888 & ' - DllStructSetData($tProxy, 1, $sProxy)•_WinHttp.au3'
	DllStructSetData($tProxy, 1, $sProxy)
	$__iLineNumber=889 & ' - Local $tProxyBypass = DllStructCreate("wchar[" & StringLen($ ...•_WinHttp.au3'
	Local $tProxyBypass = DllStructCreate("wchar[" & StringLen($sProxyBypass) + 1 & "]")
	$__iLineNumber=890 & ' - DllStructSetData($tProxyBypass, 1, $sProxyBypass)•_WinHttp.au3'
	DllStructSetData($tProxyBypass, 1, $sProxyBypass)
	$__iLineNumber=891 & ' - Local $tWINHTTP_PROXY_INFO = DllStructCreate("dword AccessTy ...•_WinHttp.au3'
	Local $tWINHTTP_PROXY_INFO = DllStructCreate("dword AccessType;" & _
			"ptr Proxy;" & _
			"ptr ProxyBypass")
	$__iLineNumber=894 & ' - DllStructSetData($tWINHTTP_PROXY_INFO, "AccessType", $iAcces ...•_WinHttp.au3'
	DllStructSetData($tWINHTTP_PROXY_INFO, "AccessType", $iAccessType)
	$__iLineNumber=895 & ' - If $iAccessType <> $WINHTTP_ACCESS_TYPE_NO_PROXY Then•_WinHttp.au3'
	If $iAccessType <> $WINHTTP_ACCESS_TYPE_NO_PROXY Then
		$__iLineNumber=896 & ' - DllStructSetData($tWINHTTP_PROXY_INFO, "Proxy", DllStructGet ...•_WinHttp.au3'
		DllStructSetData($tWINHTTP_PROXY_INFO, "Proxy", DllStructGetPtr($tProxy))
		$__iLineNumber=897 & ' - DllStructSetData($tWINHTTP_PROXY_INFO, "ProxyBypass", DllStr ...•_WinHttp.au3'
		DllStructSetData($tWINHTTP_PROXY_INFO, "ProxyBypass", DllStructGetPtr($tProxyBypass))
	EndIf
	$__iLineNumber=899 & ' - Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHt ...•_WinHttp.au3'
	Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHttpSetDefaultProxyConfiguration", "struct*", $tWINHTTP_PROXY_INFO)
	$__iLineNumber=900 & ' - If @error Or Not $aCall[0] Then Return SetError(1, 0, 0)•_WinHttp.au3'
	If @error Or Not $aCall[0] Then Return SetError(1, 0, 0)
	$__iLineNumber=901 & ' - Return 1•_WinHttp.au3'
	Return 1
EndFunc

; #FUNCTION# ;===============================================================================
; Name...........: _WinHttpSetOption
; Description ...: Sets an Internet option.
; Syntax.........: _WinHttpSetOption($hInternet, $iOption, $vSetting [, $iSize = Default ])
; Parameters ....: $hInternet - Handle on which to set data.
;                  $iOption - Integer value that contains the Internet option to set.
;                  $vSetting - Value of setting
;                  $iSize    - [optional] Size of $vSetting, required if $vSetting is pointer to memory block
; Return values .: Success - Returns 1.
;                  Failure - Returns 0 and sets @error:
;                  |1 - Invalid Internet option
;                  |2 - Size required
;                  |3 - Datatype of value does not fit to option
;                  |4 - DllCall failed
; Author ........: ProgAndy, trancexx
; Related .......: _WinHttpQueryOption
; Link ..........: http://msdn.microsoft.com/en-us/library/aa384114.aspx
;============================================================================================
$__iLineNumber=922 & ' - Func _WinHttpSetOption($hInternet, $iOption, $vSetting, $iSi ...•_WinHttp.au3'
Func _WinHttpSetOption($hInternet, $iOption, $vSetting, $iSize = Default)
	$__iLineNumber=923 & ' - If $iSize = Default Then $iSize = -1•_WinHttp.au3'
	If $iSize = Default Then $iSize = -1
	$__iLineNumber=924 & ' - If IsBinary($vSetting) Then•_WinHttp.au3'
	If IsBinary($vSetting) Then
		$__iLineNumber=925 & ' - $iSize = DllStructCreate("byte[" & BinaryLen($vSetting) & "] ...•_WinHttp.au3'
		$iSize = DllStructCreate("byte[" & BinaryLen($vSetting) & "]")
		$__iLineNumber=926 & ' - DllStructSetData($iSize, 1, $vSetting)•_WinHttp.au3'
		DllStructSetData($iSize, 1, $vSetting)
		$__iLineNumber=927 & ' - $vSetting = $iSize•_WinHttp.au3'
		$vSetting = $iSize
		$__iLineNumber=928 & ' - $iSize = DllStructGetSize($vSetting)•_WinHttp.au3'
		$iSize = DllStructGetSize($vSetting)
	EndIf
	$__iLineNumber=930 & ' - Local $sType•_WinHttp.au3'
	Local $sType
	$__iLineNumber=931 & ' - Switch $iOption•_WinHttp.au3'
	$__iLineNumber=932 & ' - Case $WINHTTP_OPTION_AUTOLOGON_POLICY, $WINHTTP_OPTION_CODEP ...•_WinHttp.au3'
	Switch $iOption
		Case $WINHTTP_OPTION_AUTOLOGON_POLICY, $WINHTTP_OPTION_CODEPAGE, $WINHTTP_OPTION_CONFIGURE_PASSPORT_AUTH, $WINHTTP_OPTION_CONNECT_RETRIES, _
				$WINHTTP_OPTION_CONNECT_TIMEOUT, $WINHTTP_OPTION_DISABLE_FEATURE, $WINHTTP_OPTION_ENABLE_FEATURE, $WINHTTP_OPTION_ENABLETRACING, _
				$WINHTTP_OPTION_MAX_CONNS_PER_1_0_SERVER, $WINHTTP_OPTION_MAX_CONNS_PER_SERVER, $WINHTTP_OPTION_MAX_HTTP_AUTOMATIC_REDIRECTS, _
				$WINHTTP_OPTION_MAX_HTTP_STATUS_CONTINUE, $WINHTTP_OPTION_MAX_RESPONSE_DRAIN_SIZE, $WINHTTP_OPTION_MAX_RESPONSE_HEADER_SIZE, _
				$WINHTTP_OPTION_READ_BUFFER_SIZE, $WINHTTP_OPTION_RECEIVE_TIMEOUT, _
				$WINHTTP_OPTION_RECEIVE_RESPONSE_TIMEOUT, $WINHTTP_OPTION_REDIRECT_POLICY, $WINHTTP_OPTION_REJECT_USERPWD_IN_URL, _
				$WINHTTP_OPTION_REQUEST_PRIORITY, $WINHTTP_OPTION_RESOLVE_TIMEOUT, $WINHTTP_OPTION_SECURE_PROTOCOLS, $WINHTTP_OPTION_SECURITY_FLAGS, _
				$WINHTTP_OPTION_SECURITY_KEY_BITNESS, $WINHTTP_OPTION_SEND_TIMEOUT, $WINHTTP_OPTION_SPN, $WINHTTP_OPTION_USE_GLOBAL_SERVER_CREDENTIALS, _
				$WINHTTP_OPTION_WORKER_THREAD_COUNT, $WINHTTP_OPTION_WRITE_BUFFER_SIZE, $WINHTTP_OPTION_DECOMPRESSION, $WINHTTP_OPTION_UNSAFE_HEADER_PARSING
			$__iLineNumber=941 & ' - $sType = "dword*"•_WinHttp.au3'
			$sType = "dword*"
			$__iLineNumber=942 & ' - $iSize = 4•_WinHttp.au3'
			$iSize = 4
		$__iLineNumber=943 & ' - Case $WINHTTP_OPTION_CALLBACK, $WINHTTP_OPTION_PASSPORT_SIGN ...•_WinHttp.au3'
		Case $WINHTTP_OPTION_CALLBACK, $WINHTTP_OPTION_PASSPORT_SIGN_OUT
			$__iLineNumber=944 & ' - $sType = "ptr*"•_WinHttp.au3'
			$sType = "ptr*"
			$__iLineNumber=945 & ' - $iSize = 4•_WinHttp.au3'
			$iSize = 4
			$__iLineNumber=946 & ' - If @AutoItX64 Then $iSize = 8•_WinHttp.au3'
			If @AutoItX64 Then $iSize = 8
			$__iLineNumber=947 & ' - If Not IsPtr($vSetting) Then Return SetError(3, 0, 0)•_WinHttp.au3'
			If Not IsPtr($vSetting) Then Return SetError(3, 0, 0)
		$__iLineNumber=948 & ' - Case $WINHTTP_OPTION_CONTEXT_VALUE•_WinHttp.au3'
		Case $WINHTTP_OPTION_CONTEXT_VALUE
			$__iLineNumber=949 & ' - $sType = "dword_ptr*"•_WinHttp.au3'
			$sType = "dword_ptr*"
			$__iLineNumber=950 & ' - $iSize = 4•_WinHttp.au3'
			$iSize = 4
			$__iLineNumber=951 & ' - If @AutoItX64 Then $iSize = 8•_WinHttp.au3'
			If @AutoItX64 Then $iSize = 8
		$__iLineNumber=952 & ' - Case $WINHTTP_OPTION_PASSWORD, $WINHTTP_OPTION_PROXY_PASSWOR ...•_WinHttp.au3'
		Case $WINHTTP_OPTION_PASSWORD, $WINHTTP_OPTION_PROXY_PASSWORD, $WINHTTP_OPTION_PROXY_USERNAME, $WINHTTP_OPTION_USER_AGENT, $WINHTTP_OPTION_USERNAME
			$__iLineNumber=953 & ' - $sType = "wstr"•_WinHttp.au3'
			$sType = "wstr"
			$__iLineNumber=954 & ' - If (IsDllStruct($vSetting) Or IsPtr($vSetting)) Then Return  ...•_WinHttp.au3'
			If (IsDllStruct($vSetting) Or IsPtr($vSetting)) Then Return SetError(3, 0, 0)
			$__iLineNumber=955 & ' - If $iSize < 1 Then $iSize = StringLen($vSetting)•_WinHttp.au3'
			If $iSize < 1 Then $iSize = StringLen($vSetting)
		$__iLineNumber=956 & ' - Case $WINHTTP_OPTION_CLIENT_CERT_CONTEXT, $WINHTTP_OPTION_GL ...•_WinHttp.au3'
		Case $WINHTTP_OPTION_CLIENT_CERT_CONTEXT, $WINHTTP_OPTION_GLOBAL_PROXY_CREDS, $WINHTTP_OPTION_GLOBAL_SERVER_CREDS, $WINHTTP_OPTION_HTTP_VERSION, _
				$WINHTTP_OPTION_PROXY
			$__iLineNumber=958 & ' - $sType = "ptr"•_WinHttp.au3'
			$sType = "ptr"
			$__iLineNumber=959 & ' - If Not (IsDllStruct($vSetting) Or IsPtr($vSetting)) Then Ret ...•_WinHttp.au3'
			If Not (IsDllStruct($vSetting) Or IsPtr($vSetting)) Then Return SetError(3, 0, 0)
		Case Else
			$__iLineNumber=961 & ' - Return SetError(1, 0, 0)•_WinHttp.au3'
			Return SetError(1, 0, 0)
	EndSwitch
	$__iLineNumber=963 & ' - If $iSize < 1 Then•_WinHttp.au3'
	If $iSize < 1 Then
		$__iLineNumber=964 & ' - If IsDllStruct($vSetting) Then•_WinHttp.au3'
		If IsDllStruct($vSetting) Then
			$__iLineNumber=965 & ' - $iSize = DllStructGetSize($vSetting)•_WinHttp.au3'
			$iSize = DllStructGetSize($vSetting)
		Else
			$__iLineNumber=967 & ' - Return SetError(2, 0, 0)•_WinHttp.au3'
			Return SetError(2, 0, 0)
		EndIf
	EndIf
	$__iLineNumber=970 & ' - Local $aCall•_WinHttp.au3'
	Local $aCall
	$__iLineNumber=971 & ' - If IsDllStruct($vSetting) Then•_WinHttp.au3'
	If IsDllStruct($vSetting) Then
		$__iLineNumber=972 & ' - $aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHttpSetO ...•_WinHttp.au3'
		$aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHttpSetOption", "handle", $hInternet, "dword", $iOption, $sType, DllStructGetPtr($vSetting), "dword", $iSize)
	Else
		$__iLineNumber=974 & ' - $aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHttpSetO ...•_WinHttp.au3'
		$aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHttpSetOption", "handle", $hInternet, "dword", $iOption, $sType, $vSetting, "dword", $iSize)
	EndIf
	$__iLineNumber=976 & ' - If @error Or Not $aCall[0] Then Return SetError(4, 0, 0)•_WinHttp.au3'
	If @error Or Not $aCall[0] Then Return SetError(4, 0, 0)
	$__iLineNumber=977 & ' - Return 1•_WinHttp.au3'
	Return 1
EndFunc

; #FUNCTION# ;===============================================================================
; Name...........: _WinHttpSetStatusCallback
; Description ...: Sets up a callback function that WinHttp can call as progress is made during an operation.
; Syntax.........: _WinHttpSetStatusCallback($hInternet, $hInternetCallback [, $iNotificationFlags = Default ])
; Parameters ....: $hInternet - Handle for which the callback is to be set.
;                  $hInternetCallback - Callback function to call when progress is made.
;                  $iNotificationFlags - [optional] Flags to indicate which events activate the callback function. Default is $WINHTTP_CALLBACK_FLAG_ALL_NOTIFICATIONS.
; Return values .: Success - Returns a pointer to the previously defined status callback function or NULL if there was no previously defined status callback function.
;                  Failure - Returns 0 and sets @error:
;                  |1 - DllCall failed
; Author ........: ProgAndy
; Modified.......: trancexx
; Related .......: _WinHttpOpen
; Link ..........: http://msdn.microsoft.com/en-us/library/aa384115.aspx
;============================================================================================
$__iLineNumber=995 & ' - Func _WinHttpSetStatusCallback($hInternet, $hInternetCallbac ...•_WinHttp.au3'
Func _WinHttpSetStatusCallback($hInternet, $hInternetCallback, $iNotificationFlags = Default)
	$__iLineNumber=996 & ' - __WinHttpDefault($iNotificationFlags, $WINHTTP_CALLBACK_FLAG ...•_WinHttp.au3'
	__WinHttpDefault($iNotificationFlags, $WINHTTP_CALLBACK_FLAG_ALL_NOTIFICATIONS)
	$__iLineNumber=997 & ' - Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "ptr", "WinHtt ...•_WinHttp.au3'
	Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "ptr", "WinHttpSetStatusCallback", _
			"handle", $hInternet, _
			"ptr", DllCallbackGetPtr($hInternetCallback), _
			"dword", $iNotificationFlags, _
			"ptr", 0)
	$__iLineNumber=1002 & ' - If @error Then Return SetError(1, 0, 0)•_WinHttp.au3'
	If @error Then Return SetError(1, 0, 0)
	$__iLineNumber=1003 & ' - Return $aCall[0]•_WinHttp.au3'
	Return $aCall[0]
EndFunc

; #FUNCTION# ;===============================================================================
; Name...........: _WinHttpSetTimeouts
; Description ...: Sets time-outs involved with HTTP transactions.
; Syntax.........: _WinHttpSetTimeouts($hInternet [, $iResolveTimeout = Default [, $iConnectTimeout = Default [, $iSendTimeout = Default [, $iReceiveTimeout = Default ]]]])
; Parameters ....: $hInternet - Handle returned by _WinHttpOpen() or _WinHttpOpenRequest().
;                  $iResolveTimeout - [optional] Time-out value, in milliseconds, to use for name resolution. Default is 0 ms.
;                  $iConnectTimeout - [optional] Time-out value, in milliseconds, to use for server connection requests. Default is 60000 ms.
;                  $iSendTimeout - [optional] Time-out value, in milliseconds, to use for sending requests. Default is 30000 ms.
;                  $iReceiveTimeout - [optional] Time-out value, in milliseconds, to receive a response to a request. Default is 30000 ms.
; Return values .: Success - Returns 1.
;                  Failure - Returns 0 and sets @error:
;                  |1 - DllCall failed
; Author ........: trancexx
; Remarks .......: Initial values are:
;                  |- $iResolveTimeout = 0
;                  |- $iConnectTimeout = 60000
;                  |- $iSendTimeout = 30000
;                  |- $iReceiveTimeout = 30000
; Related .......: _WinHttpReceiveResponse
; Link ..........: http://msdn.microsoft.com/en-us/library/aa384116.aspx
;============================================================================================
$__iLineNumber=1027 & ' - Func _WinHttpSetTimeouts($hInternet, $iResolveTimeout = Defa ...•_WinHttp.au3'
Func _WinHttpSetTimeouts($hInternet, $iResolveTimeout = Default, $iConnectTimeout = Default, $iSendTimeout = Default, $iReceiveTimeout = Default)
	$__iLineNumber=1028 & ' - __WinHttpDefault($iResolveTimeout, 0)•_WinHttp.au3'
	__WinHttpDefault($iResolveTimeout, 0)
	$__iLineNumber=1029 & ' - __WinHttpDefault($iConnectTimeout, 60000)•_WinHttp.au3'
	__WinHttpDefault($iConnectTimeout, 60000)
	$__iLineNumber=1030 & ' - __WinHttpDefault($iSendTimeout, 30000)•_WinHttp.au3'
	__WinHttpDefault($iSendTimeout, 30000)
	$__iLineNumber=1031 & ' - __WinHttpDefault($iReceiveTimeout, 30000)•_WinHttp.au3'
	__WinHttpDefault($iReceiveTimeout, 30000)
	$__iLineNumber=1032 & ' - Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHt ...•_WinHttp.au3'
	Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHttpSetTimeouts", _
			"handle", $hInternet, _
			"int", $iResolveTimeout, _
			"int", $iConnectTimeout, _
			"int", $iSendTimeout, _
			"int", $iReceiveTimeout)
	$__iLineNumber=1038 & ' - If @error Or Not $aCall[0] Then Return SetError(1, 0, 0)•_WinHttp.au3'
	If @error Or Not $aCall[0] Then Return SetError(1, 0, 0)
	$__iLineNumber=1039 & ' - Return 1•_WinHttp.au3'
	Return 1
EndFunc

; #FUNCTION# ;===============================================================================
; Name...........: _WinHttpSimpleBinaryConcat
; Description ...: Concatenates two binary data returned by _WinHttpReadData() in binary mode.
; Syntax.........: _WinHttpSimpleBinaryConcat(ByRef $bBinary1, ByRef $bBinary2)
; Parameters ....: $bBinary1 - Binary data that is to be concatenated.
;                  $bBinary2 - Binary data to concatenate.
; Return values .: Success - Returns concatenated binary data.
;                  Failure - Returns empty binary and sets @error:
;                  |1 - Invalid input.
; Author ........: ProgAndy
; Modified.......: trancexx
; Related .......: _WinHttpReadData
;============================================================================================
$__iLineNumber=1055 & ' - Func _WinHttpSimpleBinaryConcat(ByRef $bBinary1, ByRef $bBin ...•_WinHttp.au3'
Func _WinHttpSimpleBinaryConcat(ByRef $bBinary1, ByRef $bBinary2)
	$__iLineNumber=1056 & ' - Switch IsBinary($bBinary1) + 2 * IsBinary($bBinary2)•_WinHttp.au3'
	$__iLineNumber=1057 & ' - Case 0•_WinHttp.au3'
	Switch IsBinary($bBinary1) + 2 * IsBinary($bBinary2)
		Case 0
			$__iLineNumber=1058 & ' - Return SetError(1, 0, Binary(""))•_WinHttp.au3'
			Return SetError(1, 0, Binary(''))
		$__iLineNumber=1059 & ' - Case 1•_WinHttp.au3'
		Case 1
			$__iLineNumber=1060 & ' - Return $bBinary1•_WinHttp.au3'
			Return $bBinary1
		$__iLineNumber=1061 & ' - Case 2•_WinHttp.au3'
		Case 2
			$__iLineNumber=1062 & ' - Return $bBinary2•_WinHttp.au3'
			Return $bBinary2
	EndSwitch
	$__iLineNumber=1064 & ' - Local $tAuxiliary = DllStructCreate("byte[" & BinaryLen($bBi ...•_WinHttp.au3'
	Local $tAuxiliary = DllStructCreate("byte[" & BinaryLen($bBinary1) & "];byte[" & BinaryLen($bBinary2) & "]")
	$__iLineNumber=1065 & ' - DllStructSetData($tAuxiliary, 1, $bBinary1)•_WinHttp.au3'
	DllStructSetData($tAuxiliary, 1, $bBinary1)
	$__iLineNumber=1066 & ' - DllStructSetData($tAuxiliary, 2, $bBinary2)•_WinHttp.au3'
	DllStructSetData($tAuxiliary, 2, $bBinary2)
	$__iLineNumber=1067 & ' - Local $tOutput = DllStructCreate("byte[" & DllStructGetSize( ...•_WinHttp.au3'
	Local $tOutput = DllStructCreate("byte[" & DllStructGetSize($tAuxiliary) & "]", DllStructGetPtr($tAuxiliary))
	$__iLineNumber=1068 & ' - Return DllStructGetData($tOutput, 1)•_WinHttp.au3'
	Return DllStructGetData($tOutput, 1)
EndFunc

; #FUNCTION# ;===============================================================================
; Name...........: _WinHttpSimpleFormFill
; Description ...: Fills web form.
; Syntax.........: _WinHttpSimpleFormFill(ByRef $hInternet [, $sActionPage = Default [, $sFormId = Default [, $sFldId1 = Default [, $sDta1 = Default [, (...) [, $sAdditionalData]]]]]])
; Parameters ....: $hInternet - Handle returned by _WinHttpConnect() or string variable with form.
;                  $sActionPage -  [optional] path to the page with form or session handle if $hInternet is string (default: "" - empty string; meaning 'default' page on the server in former).
;                  $sFormId - [optional] Id of the form. Can be name or zero-based index too (read Remarks section).
;                  $sFldId1 - [optional] Id of the input.
;                  $sDta1 - [optional] Data to set to coresponding field.
;                  (...) - [optional] Other pairs of Id/Data. Overall number of fields is 40.
;                  $sAdditionalData - [optional] Additional data (read Remarks section).
; Return values .: Success - Returns HTML source of the page returned by the server on submited form. @extended is set to HTTP status code.
;                  Failure - Returns empty string and sets @error:
;                  |1 - No forms on the page
;                  |2 - Invalid form
;                  |3 - No forms with specified attributes on the page
;                  |4 - Connection problems
;                  |5 - form's "action" is invalid
;                  |6 - invalid session handle passed
; Author ........: trancexx
; Remarks .......: In case form requires redirection and [[$hInternet]] is internet handle, this handle will be closed and replaced with new and required one.
;                  +When [[$hInternet]] is form string, form's "action" must specify URL and [[$sActionPage]] parameter must be session handle. On succesful call this variable will be changed to connection handle of the internally made connection.
;                  Don't forget to close this handle after the function returns and when no longer needed.
;                  +[[$sFormId]] specifies Id of the form same as [[.getElementById(FormId)]]. Aditionally you can use [["index:FormIndex"]] to
;                  identify form by its zero-based index number (in case of e.g. three forms on some page first one will have index=0, second index=1, third index=2).
;                  Use [["name:FormName"]] to identify form by its name like with [[.getElementsByName(FormName)]]. FormName will be taken to be what's right of colon mark.
;                  In that case first form with that name is filled.
;                  +As for fields, If [["name:FieldName"]] option is used all the fields except last with that name are removed from the form. Last one is filled with specified [[$sDta]] data.
;                  +This function can be used to fill forms with up to 40 fields at once.
;                  +"Submit" control you want to keep (click) set to True. If no such control is set then the first one found in the form is "clicked". You can also use [["type:submit", zero_based_index_of_the_submit]] to "click" if no id or name is available.
;                  +All other "submit" controls are removed from the submited form (including images).
;                  +If form is submitted by clicking an image then pass click coordinates [["name:image_name", "Xcoord,Ycoord"]] or [["image_id", "Xcoord,Ycoord"]]. If the image has no name or id then you can use its index of appearance [["type:image", "zero_based_index_of_the_image Xcoord,Ycoord"]].
;                  +"Checkbox" and "Button" input types are removed from the submitted form unless explicitly set. Same goes for "Radio" with exception that
;                  only one such control can be set, the rest are removed. These controls are set by their values. Wrong value makes them invalid and therefore not part of the submited data.
;                  +All other non-set fields are left default.
;                  +Last (superfluous) [[$sAdditionalData]] argument can be used to pass authorization credentials in form [["[CRED:username:password]"]], magic string to ignore certificate errors in form [["[IGNORE_CERT_ERRORS]"]], change output type to extended array with [["[RETURN_ARRAY]"]] moniker, and/or HTTP request header data to add.
;                  If array is returned then [[array[0]]] is the response header, [[array[1]]] is returned data and [[array[2]]] is URL of the final request.
;                  +
;                  +If this function is used to upload multiple files then there are two available ways. Default would be to submit the form following RFC2388 specification.
;                  In that case every file is represented as multipart/mixed part embedded within the multipart/form-data.
;                  +If you want to upload using alternative way (to avoid certain PHP bug that could exist on server side) then prefix the file string with [["PHP#50338:"]] string.
;                  +For example: [[..."name:files[]", "PHP#50338:" & $sFile1 & "|" & $sFile2 ...]]
;                  +Muliple files are always separated with vertical line ASCII character when filling the form.
; Related .......: _WinHttpConnect, _WinHttpSimpleFormFill_SetUploadCallback
;============================================================================================
$__iLineNumber=1116 & ' - Func _WinHttpSimpleFormFill(ByRef $hInternet, $sActionPage = ...•_WinHttp.au3'
Func _WinHttpSimpleFormFill(ByRef $hInternet, $sActionPage = Default, $sFormId = Default, $sFldId1 = Default, $sDta1 = Default, $sFldId2 = Default, $sDta2 = Default, $sFldId3 = Default, $sDta3 = Default, $sFldId4 = Default, $sDta4 = Default, $sFldId5 = Default, $sDta5 = Default, $sFldId6 = Default, $sDta6 = Default, $sFldId7 = Default, $sDta7 = Default, $sFldId8 = Default, $sDta8 = Default, $sFldId9 = Default, $sDta9 = Default, $sFldId10 = Default, $sDta10 = Default, _
		$sFldId11 = Default, $sDta11 = Default, $sFldId12 = Default, $sDta12 = Default, $sFldId13 = Default, $sDta13 = Default, $sFldId14 = Default, $sDta14 = Default, $sFldId15 = Default, $sDta15 = Default, $sFldId16 = Default, $sDta16 = Default, $sFldId17 = Default, $sDta17 = Default, $sFldId18 = Default, $sDta18 = Default, $sFldId19 = Default, $sDta19 = Default, $sFldId20 = Default, $sDta20 = Default, _
		$sFldId21 = Default, $sDta21 = Default, $sFldId22 = Default, $sDta22 = Default, $sFldId23 = Default, $sDta23 = Default, $sFldId24 = Default, $sDta24 = Default, $sFldId25 = Default, $sDta25 = Default, $sFldId26 = Default, $sDta26 = Default, $sFldId27 = Default, $sDta27 = Default, $sFldId28 = Default, $sDta28 = Default, $sFldId29 = Default, $sDta29 = Default, $sFldId30 = Default, $sDta30 = Default, _
		$sFldId31 = Default, $sDta31 = Default, $sFldId32 = Default, $sDta32 = Default, $sFldId33 = Default, $sDta33 = Default, $sFldId34 = Default, $sDta34 = Default, $sFldId35 = Default, $sDta35 = Default, $sFldId36 = Default, $sDta36 = Default, $sFldId37 = Default, $sDta37 = Default, $sFldId38 = Default, $sDta38 = Default, $sFldId39 = Default, $sDta39 = Default, $sFldId40 = Default, $sDta40 = Default)
	$__iLineNumber=1120 & ' - __WinHttpDefault($sActionPage, "")•_WinHttp.au3'
	__WinHttpDefault($sActionPage, "")
	$__iLineNumber=1121 & ' - Local $iNumArgs = @NumParams, $sAdditionalHeaders, $sCredNam ...•_WinHttp.au3'
	Local $iNumArgs = @NumParams, $sAdditionalHeaders, $sCredName, $sCredPass, $iIgnoreCertErr, $iRetArr
	$__iLineNumber=1122 & ' - Local $aDtas[41] = [0, $sDta1, $sDta2, $sDta3, $sDta4, $sDta ...•_WinHttp.au3'
	Local $aDtas[41] = [0, $sDta1, $sDta2, $sDta3, $sDta4, $sDta5, $sDta6, $sDta7, $sDta8, $sDta9, $sDta10, $sDta11, $sDta12, $sDta13, $sDta14, $sDta15, $sDta16, $sDta17, $sDta18, $sDta19, $sDta20, $sDta21, $sDta22, $sDta23, $sDta24, $sDta25, $sDta26, $sDta27, $sDta28, $sDta29, $sDta30, $sDta31, $sDta32, $sDta33, $sDta34, $sDta35, $sDta36, $sDta37, $sDta38, $sDta39, $sDta40]
	$__iLineNumber=1123 & ' - Local $aFlds[41] = [0, $sFldId1, $sFldId2, $sFldId3, $sFldId ...•_WinHttp.au3'
	Local $aFlds[41] = [0, $sFldId1, $sFldId2, $sFldId3, $sFldId4, $sFldId5, $sFldId6, $sFldId7, $sFldId8, $sFldId9, $sFldId10, $sFldId11, $sFldId12, $sFldId13, $sFldId14, $sFldId15, $sFldId16, $sFldId17, $sFldId18, $sFldId19, $sFldId20, $sFldId21, $sFldId22, $sFldId23, $sFldId24, $sFldId25, $sFldId26, $sFldId27, $sFldId28, $sFldId29, $sFldId30, $sFldId31, $sFldId32, $sFldId33, $sFldId34, $sFldId35, $sFldId36, $sFldId37, $sFldId38, $sFldId39, $sFldId40]
	$__iLineNumber=1124 & ' - If Not Mod($iNumArgs, 2) Then•_WinHttp.au3'
	If Not Mod($iNumArgs, 2) Then
		$__iLineNumber=1125 & ' - $sAdditionalHeaders = $aFlds[$iNumArgs / 2 - 1]•_WinHttp.au3'
		$sAdditionalHeaders = $aFlds[$iNumArgs / 2 - 1]
		$__iLineNumber=1126 & ' - $aFlds[$iNumArgs / 2 - 1] = 0•_WinHttp.au3'
		$aFlds[$iNumArgs / 2 - 1] = 0
		$__iLineNumber=1127 & ' - $iIgnoreCertErr = StringInStr($sAdditionalHeaders, "[IGNORE_ ...•_WinHttp.au3'
		$iIgnoreCertErr = StringInStr($sAdditionalHeaders, "[IGNORE_CERT_ERRORS]")
		$__iLineNumber=1128 & ' - If $iIgnoreCertErr Then $sAdditionalHeaders = StringReplace( ...•_WinHttp.au3'
		If $iIgnoreCertErr Then $sAdditionalHeaders = StringReplace($sAdditionalHeaders, "[IGNORE_CERT_ERRORS]", "", 1)
		$__iLineNumber=1129 & ' - $iRetArr = StringInStr($sAdditionalHeaders, "[RETURN_ARRAY]" ...•_WinHttp.au3'
		$iRetArr = StringInStr($sAdditionalHeaders, "[RETURN_ARRAY]")
		$__iLineNumber=1130 & ' - If $iRetArr Then $sAdditionalHeaders = StringReplace($sAddit ...•_WinHttp.au3'
		If $iRetArr Then $sAdditionalHeaders = StringReplace($sAdditionalHeaders, "[RETURN_ARRAY]", "", 1)
		$__iLineNumber=1131 & ' - Local $aCred = StringRegExp($sAdditionalHeaders, "\[CRED:(.* ...•_WinHttp.au3'
		Local $aCred = StringRegExp($sAdditionalHeaders, "\[CRED:(.*?)\]", 2)
		$__iLineNumber=1132 & ' - If Not @error Then•_WinHttp.au3'
		If Not @error Then
			$__iLineNumber=1133 & ' - Local $sCredDelim = ":"•_WinHttp.au3'
			Local $sCredDelim = ":"
			$__iLineNumber=1134 & ' - If Not StringInStr($aCred[1], $sCredDelim) Then $sCredDelim  ...•_WinHttp.au3'
			If Not StringInStr($aCred[1], $sCredDelim) Then $sCredDelim = ","
			$__iLineNumber=1135 & ' - Local $aStrSplit = StringSplit($aCred[1], $sCredDelim, 3)•_WinHttp.au3'
			Local $aStrSplit = StringSplit($aCred[1], $sCredDelim, 3)
			$__iLineNumber=1136 & ' - If Not @error Then•_WinHttp.au3'
			If Not @error Then
				$__iLineNumber=1137 & ' - $sCredName = $aStrSplit[0]•_WinHttp.au3'
				$sCredName = $aStrSplit[0]
				$__iLineNumber=1138 & ' - $sCredPass = $aStrSplit[1]•_WinHttp.au3'
				$sCredPass = $aStrSplit[1]
			EndIf
			$__iLineNumber=1140 & ' - $sAdditionalHeaders = StringReplace($sAdditionalHeaders, $aC ...•_WinHttp.au3'
			$sAdditionalHeaders = StringReplace($sAdditionalHeaders, $aCred[0], "", 1)
		EndIf
	EndIf
	; Get page source
	$__iLineNumber=1144 & ' - Local $hOpen, $aHTML, $sHTML, $sURL, $fVarForm, $iScheme = $ ...•_WinHttp.au3'
	Local $hOpen, $aHTML, $sHTML, $sURL, $fVarForm, $iScheme = $INTERNET_SCHEME_HTTP
	$__iLineNumber=1145 & ' - If IsString($hInternet) Then ; $hInternet is page source•_WinHttp.au3'
	If IsString($hInternet) Then ; $hInternet is page source
		$__iLineNumber=1146 & ' - $sHTML = $hInternet•_WinHttp.au3'
		$sHTML = $hInternet
		$__iLineNumber=1147 & ' - If _WinHttpQueryOption($sActionPage, $WINHTTP_OPTION_HANDLE_ ...•_WinHttp.au3'
		If _WinHttpQueryOption($sActionPage, $WINHTTP_OPTION_HANDLE_TYPE) <> $WINHTTP_HANDLE_TYPE_SESSION Then Return SetError(6, 0, "")
		$__iLineNumber=1148 & ' - $hOpen = $sActionPage•_WinHttp.au3'
		$hOpen = $sActionPage
		$__iLineNumber=1149 & ' - $fVarForm = True•_WinHttp.au3'
		$fVarForm = True
	Else
		$__iLineNumber=1151 & ' - $iScheme = _WinHttpQueryOption($hInternet, $WINHTTP_OPTION_C ...•_WinHttp.au3'
		$iScheme = _WinHttpQueryOption($hInternet, $WINHTTP_OPTION_CONTEXT_VALUE); read internet scheme from the connection handle
		$__iLineNumber=1152 & ' - Local $sAccpt = "Accept: text/html;q=0.9,text/plain;q=0.8,*/ ...•_WinHttp.au3'
		Local $sAccpt = "Accept: text/html;q=0.9,text/plain;q=0.8,*/*;q=0.5"
		$__iLineNumber=1153 & ' - If $iScheme = $INTERNET_SCHEME_HTTPS Then•_WinHttp.au3'
		If $iScheme = $INTERNET_SCHEME_HTTPS Then
			$__iLineNumber=1154 & ' - $aHTML = _WinHttpSimpleSSLRequest($hInternet, Default, $sAct ...•_WinHttp.au3'
			$aHTML = _WinHttpSimpleSSLRequest($hInternet, Default, $sActionPage, Default, Default, $sAccpt, 1, Default, $sCredName, $sCredPass, $iIgnoreCertErr)
		ElseIf $iScheme = $INTERNET_SCHEME_HTTP Then
			$__iLineNumber=1156 & ' - $aHTML = _WinHttpSimpleRequest($hInternet, Default, $sAction ...•_WinHttp.au3'
			$aHTML = _WinHttpSimpleRequest($hInternet, Default, $sActionPage, Default, Default, $sAccpt, 1, Default, $sCredName, $sCredPass)
		Else
			; Try both http and https scheme and deduct the right one besed on response
			$__iLineNumber=1159 & ' - $aHTML = _WinHttpSimpleRequest($hInternet, Default, $sAction ...•_WinHttp.au3'
			$aHTML = _WinHttpSimpleRequest($hInternet, Default, $sActionPage, Default, Default, $sAccpt, 1, Default, $sCredName, $sCredPass)
			$__iLineNumber=1160 & ' - If @error Or @extended >= $HTTP_STATUS_BAD_REQUEST Then•_WinHttp.au3'
			If @error Or @extended >= $HTTP_STATUS_BAD_REQUEST Then
				$__iLineNumber=1161 & ' - $aHTML = _WinHttpSimpleSSLRequest($hInternet, Default, $sAct ...•_WinHttp.au3'
				$aHTML = _WinHttpSimpleSSLRequest($hInternet, Default, $sActionPage, Default, Default, $sAccpt, 1, Default, $sCredName, $sCredPass, $iIgnoreCertErr)
				$__iLineNumber=1162 & ' - $iScheme = $INTERNET_SCHEME_HTTPS•_WinHttp.au3'
				$iScheme = $INTERNET_SCHEME_HTTPS
			Else
				$__iLineNumber=1164 & ' - $iScheme = $INTERNET_SCHEME_HTTP•_WinHttp.au3'
				$iScheme = $INTERNET_SCHEME_HTTP
			EndIf
		EndIf
		$__iLineNumber=1167 & ' - If Not @error Then ; Error is checked after If...Then...Else ...•_WinHttp.au3'
		If Not @error Then ; Error is checked after If...Then...Else block. Be careful before changing anything!
			$__iLineNumber=1168 & ' - $sHTML = $aHTML[1]•_WinHttp.au3'
			$sHTML = $aHTML[1]
			$__iLineNumber=1169 & ' - $sURL = $aHTML[2]•_WinHttp.au3'
			$sURL = $aHTML[2]
		EndIf
	EndIf
	$__iLineNumber=1172 & ' - $sHTML = StringRegExpReplace($sHTML, "(?s)<!--.*?-->", "") ; ...•_WinHttp.au3'
	$sHTML = StringRegExpReplace($sHTML, "(?s)<!--.*?-->", "") ; removing comments
	$__iLineNumber=1173 & ' - $sHTML = StringRegExpReplace($sHTML, "(?s)<!\[CDATA\[.*?\]\] ...•_WinHttp.au3'
	$sHTML = StringRegExpReplace($sHTML, "(?s)<!\[CDATA\[.*?\]\]>", "") ; removing CDATA
	$__iLineNumber=1174 & ' - Local $fSend = False ; preset "Sending flag"•_WinHttp.au3'
	Local $fSend = False ; preset 'Sending flag'
	; Find all forms on page
	$__iLineNumber=1176 & ' - Local $aForm = StringRegExp($sHTML, "(?si)<\s*form(?:[^\w])\ ...•_WinHttp.au3'
	Local $aForm = StringRegExp($sHTML, "(?si)<\s*form(?:[^\w])\s*(.*?)(?:(?:<\s*/form\s*>)|\Z)", 3)
	$__iLineNumber=1177 & ' - If @error Then Return SetError(1, 0, "") ; There are no form ...•_WinHttp.au3'
	If @error Then Return SetError(1, 0, "") ; There are no forms available
	; Process input
	$__iLineNumber=1179 & ' - Local $fGetFormByName, $sFormName, $fGetFormByIndex, $fGetFo ...•_WinHttp.au3'
	Local $fGetFormByName, $sFormName, $fGetFormByIndex, $fGetFormById, $iFormIndex
	$__iLineNumber=1180 & ' - Local $aSplitForm = StringSplit($sFormId, ":", 2)•_WinHttp.au3'
	Local $aSplitForm = StringSplit($sFormId, ":", 2)
	$__iLineNumber=1181 & ' - If @error Then ; like .getElementById(FormId)•_WinHttp.au3'
	If @error Then ; like .getElementById(FormId)
		$__iLineNumber=1182 & ' - $fGetFormById = True•_WinHttp.au3'
		$fGetFormById = True
	Else
		$__iLineNumber=1184 & ' - If $aSplitForm[0] = "name" Then ; like .getElementsByName(Fo ...•_WinHttp.au3'
		If $aSplitForm[0] = "name" Then ; like .getElementsByName(FormName)
			$__iLineNumber=1185 & ' - $sFormName = $aSplitForm[1]•_WinHttp.au3'
			$sFormName = $aSplitForm[1]
			$__iLineNumber=1186 & ' - $fGetFormByName = True•_WinHttp.au3'
			$fGetFormByName = True
		ElseIf $aSplitForm[0] = "index" Then
			$__iLineNumber=1188 & ' - $iFormIndex = Number($aSplitForm[1])•_WinHttp.au3'
			$iFormIndex = Number($aSplitForm[1])
			$__iLineNumber=1189 & ' - $fGetFormByIndex = True•_WinHttp.au3'
			$fGetFormByIndex = True
		ElseIf $aSplitForm[0] = "id" Then ; like .getElementById(FormId)
			$__iLineNumber=1191 & ' - $sFormId = $aSplitForm[1]•_WinHttp.au3'
			$sFormId = $aSplitForm[1]
			$__iLineNumber=1192 & ' - $fGetFormById = True•_WinHttp.au3'
			$fGetFormById = True
		Else ; like .getElementById(FormId)
			$__iLineNumber=1194 & ' - $sFormId = $aSplitForm[0]•_WinHttp.au3'
			$sFormId = $aSplitForm[0]
			$__iLineNumber=1195 & ' - $fGetFormById = True•_WinHttp.au3'
			$fGetFormById = True
		EndIf
	EndIf
	; Variables
	$__iLineNumber=1199 & ' - Local $sForm, $sAttributes, $aInput•_WinHttp.au3'
	Local $sForm, $sAttributes, $aInput
	$__iLineNumber=1200 & ' - Local $iNumParams = Ceiling(($iNumArgs - 2) / 2) - 1•_WinHttp.au3'
	Local $iNumParams = Ceiling(($iNumArgs - 2) / 2) - 1
	$__iLineNumber=1201 & ' - Local $sAddData, $sNewURL•_WinHttp.au3'
	Local $sAddData, $sNewURL
	; Loop thru all forms on the page and find one that was specified
	$__iLineNumber=1203 & ' - For $iFormOrdinal = 0 To UBound($aForm) - 1•_WinHttp.au3'
	For $iFormOrdinal = 0 To UBound($aForm) - 1
		$__iLineNumber=1204 & ' - If $fGetFormByIndex And $iFormOrdinal <> $iFormIndex Then Co ...•_WinHttp.au3'
		If $fGetFormByIndex And $iFormOrdinal <> $iFormIndex Then ContinueLoop
		$__iLineNumber=1205 & ' - $sForm = $aForm[$iFormOrdinal]•_WinHttp.au3'
		$sForm = $aForm[$iFormOrdinal]
		; Extract form attributes
		$__iLineNumber=1207 & ' - $sAttributes = StringRegExp($sForm, "(?s)(.*?)>", 3)•_WinHttp.au3'
		$sAttributes = StringRegExp($sForm, "(?s)(.*?)>", 3)
		$__iLineNumber=1208 & ' - If Not @error Then $sAttributes = StringRegExpReplace($sAttr ...•_WinHttp.au3'
		If Not @error Then $sAttributes = StringRegExpReplace($sAttributes[0], "\v", " ")
		$__iLineNumber=1209 & ' - Local $sAction = "", $sAccept = "", $sEnctype = "", $sMethod ...•_WinHttp.au3'
		Local $sAction = "", $sAccept = "", $sEnctype = "", $sMethod = "", $sName = "", $sId = ""
		; Check set attributes
		$__iLineNumber=1211 & ' - $sId = __WinHttpAttribVal($sAttributes, "id")•_WinHttp.au3'
		$sId = __WinHttpAttribVal($sAttributes, "id")
		$__iLineNumber=1212 & ' - If $fGetFormById And $sFormId <> Default And $sId <> $sFormI ...•_WinHttp.au3'
		If $fGetFormById And $sFormId <> Default And $sId <> $sFormId Then ContinueLoop
		$__iLineNumber=1213 & ' - $sName = __WinHttpAttribVal($sAttributes, "name")•_WinHttp.au3'
		$sName = __WinHttpAttribVal($sAttributes, "name")
		$__iLineNumber=1214 & ' - If $fGetFormByName And $sFormName <> $sName Then ContinueLoo ...•_WinHttp.au3'
		If $fGetFormByName And $sFormName <> $sName Then ContinueLoop
		$__iLineNumber=1215 & ' - $sAction = __WinHttpHTMLDecode(__WinHttpAttribVal($sAttribut ...•_WinHttp.au3'
		$sAction = __WinHttpHTMLDecode(__WinHttpAttribVal($sAttributes, "action"))
		$__iLineNumber=1216 & ' - $sAccept = __WinHttpAttribVal($sAttributes, "accept")•_WinHttp.au3'
		$sAccept = __WinHttpAttribVal($sAttributes, "accept")
		$__iLineNumber=1217 & ' - $sEnctype = __WinHttpAttribVal($sAttributes, "enctype")•_WinHttp.au3'
		$sEnctype = __WinHttpAttribVal($sAttributes, "enctype")
		$__iLineNumber=1218 & ' - $sMethod = __WinHttpAttribVal($sAttributes, "method")•_WinHttp.au3'
		$sMethod = __WinHttpAttribVal($sAttributes, "method")
		; Requested form is found. Set $fSend flag to true
		$__iLineNumber=1220 & ' - $fSend = True•_WinHttp.au3'
		$fSend = True
		$__iLineNumber=1221 & ' - Local $sSpr1 = Chr(27), $sSpr2 = Chr(26)•_WinHttp.au3'
		Local $sSpr1 = Chr(27), $sSpr2 = Chr(26)
		$__iLineNumber=1222 & ' - __WinHttpNormalizeForm($sForm, $sSpr1, $sSpr2)•_WinHttp.au3'
		__WinHttpNormalizeForm($sForm, $sSpr1, $sSpr2)
		$__iLineNumber=1223 & ' - $aInput = StringRegExp($sForm, "(?si)<\h*(?:input|textarea|l ...•_WinHttp.au3'
		$aInput = StringRegExp($sForm, "(?si)<\h*(?:input|textarea|label|fieldset|legend|select|optgroup|option|button)\h*(.*?)/*\h*>", 3)
		$__iLineNumber=1224 & ' - If @error Then Return SetError(2, 0, "") ; invalid form•_WinHttp.au3'
		If @error Then Return SetError(2, 0, "") ; invalid form
		; HTML5 allows for "formaction", "formenctype", "formmethod" submit-control attributes to be set. If such control is "clicked" then form's attributes needs updating/correcting
		$__iLineNumber=1226 & ' - __WinHttpHTML5FormAttribs($aDtas, $aFlds, $iNumParams, $aInp ...•_WinHttp.au3'
		__WinHttpHTML5FormAttribs($aDtas, $aFlds, $iNumParams, $aInput, $sAction, $sEnctype, $sMethod)
		; Workout correct URL, scheme, etc...
		$__iLineNumber=1228 & ' - __WinHttpNormalizeActionURL($sActionPage, $sAction, $iScheme ...•_WinHttp.au3'
		__WinHttpNormalizeActionURL($sActionPage, $sAction, $iScheme, $sNewURL, $sEnctype, $sMethod, $sURL)
		$__iLineNumber=1229 & ' - If $fVarForm And Not $sNewURL Then Return SetError(5, 0, "") ...•_WinHttp.au3'
		If $fVarForm And Not $sNewURL Then Return SetError(5, 0, "") ; "action" must have URL specified
		$__iLineNumber=1230 & ' - Local $aSplit, $sBoundary, $sPassedId, $sPassedData, $iNumRe ...•_WinHttp.au3'
		Local $aSplit, $sBoundary, $sPassedId, $sPassedData, $iNumRepl, $fMultiPart = False, $sSubmit, $sRadio, $sCheckBox, $sButton
		$__iLineNumber=1231 & ' - Local $sGrSep = Chr(29), $iErr•_WinHttp.au3'
		Local $sGrSep = Chr(29), $iErr
		$__iLineNumber=1232 & ' - Local $aInputIds[4][UBound($aInput)]•_WinHttp.au3'
		Local $aInputIds[4][UBound($aInput)]
		$__iLineNumber=1233 & ' - Switch $sEnctype•_WinHttp.au3'
		$__iLineNumber=1234 & ' - Case "", "application/x-www-form-urlencoded", "text/plain"•_WinHttp.au3'
		Switch $sEnctype
			Case "", "application/x-www-form-urlencoded", "text/plain"
				$__iLineNumber=1235 & ' - For $i = 0 To UBound($aInput) - 1 ; for all input elements•_WinHttp.au3'
				For $i = 0 To UBound($aInput) - 1 ; for all input elements
					$__iLineNumber=1236 & ' - __WinHttpFormAttrib($aInputIds, $i, $aInput[$i])•_WinHttp.au3'
					__WinHttpFormAttrib($aInputIds, $i, $aInput[$i])
					$__iLineNumber=1237 & ' - If $aInputIds[1][$i] Then ; if there is "name" field then ad ...•_WinHttp.au3'
					If $aInputIds[1][$i] Then ; if there is 'name' field then add it
						$__iLineNumber=1238 & ' - $aInputIds[1][$i] = __WinHttpURLEncode(StringReplace($aInput ...•_WinHttp.au3'
						$aInputIds[1][$i] = __WinHttpURLEncode(StringReplace($aInputIds[1][$i], $sSpr1, " "), $sEnctype)
						$__iLineNumber=1239 & ' - $aInputIds[2][$i] = __WinHttpURLEncode(StringReplace(StringR ...•_WinHttp.au3'
						$aInputIds[2][$i] = __WinHttpURLEncode(StringReplace(StringReplace($aInputIds[2][$i], $sSpr2, ">"), $sSpr1, " "), $sEnctype)
						$__iLineNumber=1240 & ' - $sAddData &= $aInputIds[1][$i] & "=" & $aInputIds[2][$i] & " ...•_WinHttp.au3'
						$sAddData &= $aInputIds[1][$i] & "=" & $aInputIds[2][$i] & "&"
						$__iLineNumber=1241 & ' - If $aInputIds[3][$i] = "submit" Then $sSubmit &= $aInputIds[ ...•_WinHttp.au3'
						If $aInputIds[3][$i] = "submit" Then $sSubmit &= $aInputIds[1][$i] & "=" & $aInputIds[2][$i] & $sGrSep ; add to overall "submit" string
						$__iLineNumber=1242 & ' - If $aInputIds[3][$i] = "radio" Then $sRadio &= $aInputIds[1] ...•_WinHttp.au3'
						If $aInputIds[3][$i] = "radio" Then $sRadio &= $aInputIds[1][$i] & "=" & $aInputIds[2][$i] & $sGrSep ; add to overall "radio" string
						$__iLineNumber=1243 & ' - If $aInputIds[3][$i] = "checkbox" Then $sCheckBox &= $aInput ...•_WinHttp.au3'
						If $aInputIds[3][$i] = "checkbox" Then $sCheckBox &= $aInputIds[1][$i] & "=" & $aInputIds[2][$i] & $sGrSep ; add to overall "checkbox" string
						$__iLineNumber=1244 & ' - If $aInputIds[3][$i] = "button" Then $sButton &= $aInputIds[ ...•_WinHttp.au3'
						If $aInputIds[3][$i] = "button" Then $sButton &= $aInputIds[1][$i] & "=" & $aInputIds[2][$i] & $sGrSep ; add to overall "button" string
					EndIf
				Next
				$__iLineNumber=1247 & ' - $sSubmit = StringTrimRight($sSubmit, 1)•_WinHttp.au3'
				$sSubmit = StringTrimRight($sSubmit, 1)
				$__iLineNumber=1248 & ' - $sRadio = StringTrimRight($sRadio, 1)•_WinHttp.au3'
				$sRadio = StringTrimRight($sRadio, 1)
				$__iLineNumber=1249 & ' - $sCheckBox = StringTrimRight($sCheckBox, 1)•_WinHttp.au3'
				$sCheckBox = StringTrimRight($sCheckBox, 1)
				$__iLineNumber=1250 & ' - $sButton = StringTrimRight($sButton, 1)•_WinHttp.au3'
				$sButton = StringTrimRight($sButton, 1)
				$__iLineNumber=1251 & ' - $sAddData = StringTrimRight($sAddData, 1)•_WinHttp.au3'
				$sAddData = StringTrimRight($sAddData, 1)
				$__iLineNumber=1252 & ' - For $k = 1 To $iNumParams•_WinHttp.au3'
				For $k = 1 To $iNumParams
					$__iLineNumber=1253 & ' - $sPassedData = __WinHttpURLEncode($aDtas[$k], $sEnctype)•_WinHttp.au3'
					$sPassedData = __WinHttpURLEncode($aDtas[$k], $sEnctype)
					$__iLineNumber=1254 & ' - $aDtas[$k] = 0•_WinHttp.au3'
					$aDtas[$k] = 0
					$__iLineNumber=1255 & ' - $sPassedId = $aFlds[$k]•_WinHttp.au3'
					$sPassedId = $aFlds[$k]
					$__iLineNumber=1256 & ' - $aFlds[$k] = 0•_WinHttp.au3'
					$aFlds[$k] = 0
					$__iLineNumber=1257 & ' - $aSplit = StringSplit($sPassedId, ":", 2)•_WinHttp.au3'
					$aSplit = StringSplit($sPassedId, ":", 2)
					$__iLineNumber=1258 & ' - $iErr = @error•_WinHttp.au3'
					$iErr = @error
					$__iLineNumber=1259 & ' - $aSplit[0] = __WinHttpURLEncode($aSplit[0], $sEnctype)•_WinHttp.au3'
					$aSplit[0] = __WinHttpURLEncode($aSplit[0], $sEnctype)
					$__iLineNumber=1260 & ' - If Not $iErr Then $aSplit[1] = __WinHttpURLEncode($aSplit[1] ...•_WinHttp.au3'
					If Not $iErr Then $aSplit[1] = __WinHttpURLEncode($aSplit[1], $sEnctype)
					$__iLineNumber=1261 & ' - If $iErr Or $aSplit[0] <> "name" Then ; like .getElementById•_WinHttp.au3'
					If $iErr Or $aSplit[0] <> "name" Then ; like .getElementById
						$__iLineNumber=1262 & ' - If Not $iErr And $aSplit[0] = "id" Then $sPassedId = $aSplit ...•_WinHttp.au3'
						If Not $iErr And $aSplit[0] = "id" Then $sPassedId = $aSplit[1]
						$__iLineNumber=1263 & ' - For $j = 0 To UBound($aInputIds, 2) - 1•_WinHttp.au3'
						For $j = 0 To UBound($aInputIds, 2) - 1
							$__iLineNumber=1264 & ' - If $aInputIds[0][$j] = $sPassedId Then•_WinHttp.au3'
							If $aInputIds[0][$j] = $sPassedId Then
								$__iLineNumber=1265 & ' - If $aInputIds[3][$j] = "submit" Then•_WinHttp.au3'
								If $aInputIds[3][$j] = "submit" Then
									$__iLineNumber=1266 & ' - If $sPassedData = True Then ; if this "submit" is set to TRU ...•_WinHttp.au3'
									If $sPassedData = True Then ; if this "submit" is set to TRUE then
										$__iLineNumber=1267 & ' - If $sSubmit Then ; If not already processed; only the first  ...•_WinHttp.au3'
										If $sSubmit Then ; If not already processed; only the first is valid
											$__iLineNumber=1268 & ' - Local $fDelId = False•_WinHttp.au3'
											Local $fDelId = False
											$__iLineNumber=1269 & ' - For $sChunkSub In StringSplit($sSubmit, $sGrSep, 3) ; go tru ...•_WinHttp.au3'
											For $sChunkSub In StringSplit($sSubmit, $sGrSep, 3) ; go tru all "submit" controls
												$__iLineNumber=1270 & ' - If $sChunkSub == $aInputIds[1][$j] & "=" & $aInputIds[2][$j] ...•_WinHttp.au3'
												If $sChunkSub == $aInputIds[1][$j] & "=" & $aInputIds[2][$j] Then
													$__iLineNumber=1271 & ' - If $fDelId Then $sAddData = StringRegExpReplace($sAddData, " ...•_WinHttp.au3'
													If $fDelId Then $sAddData = StringRegExpReplace($sAddData, "(?:&|\A)\Q" & $sChunkSub & "\E(?:&|\Z)", "&", 1)
													$__iLineNumber=1272 & ' - $fDelId = True•_WinHttp.au3'
													$fDelId = True
												Else
													$__iLineNumber=1274 & ' - $sAddData = StringRegExpReplace($sAddData, "(?:&|\A)\Q" & $s ...•_WinHttp.au3'
													$sAddData = StringRegExpReplace($sAddData, "(?:&|\A)\Q" & $sChunkSub & "\E(?:&|\Z)", "&") ; delete all but the TRUE one
												EndIf
												$__iLineNumber=1276 & ' - __WinHttpTrimBounds($sAddData, "&")•_WinHttp.au3'
												__WinHttpTrimBounds($sAddData, "&")
											Next
											$__iLineNumber=1278 & ' - $sSubmit = ""•_WinHttp.au3'
											$sSubmit = ""
										EndIf
									EndIf
								ElseIf $aInputIds[3][$j] = "radio" Then
									$__iLineNumber=1282 & ' - If $sPassedData = $aInputIds[2][$j] Then•_WinHttp.au3'
									If $sPassedData = $aInputIds[2][$j] Then
										$__iLineNumber=1283 & ' - For $sChunkSub In StringSplit($sRadio, $sGrSep, 3) ; go tru  ...•_WinHttp.au3'
										For $sChunkSub In StringSplit($sRadio, $sGrSep, 3) ; go tru all "radio" controls
											$__iLineNumber=1284 & ' - If $sChunkSub == $aInputIds[1][$j] & "=" & $sPassedData Then•_WinHttp.au3'
											If $sChunkSub == $aInputIds[1][$j] & "=" & $sPassedData Then
												$__iLineNumber=1285 & ' - $sAddData = StringRegExpReplace(StringReplace($sAddData, "&" ...•_WinHttp.au3'
												$sAddData = StringRegExpReplace(StringReplace($sAddData, "&", "&&"), "(?:&|\A)\Q" & $aInputIds[1][$j] & "\E(.*?)(?:&|\Z)", "&")
												$__iLineNumber=1286 & ' - $sAddData = StringReplace(StringReplace($sAddData, "&&", "&" ...•_WinHttp.au3'
												$sAddData = StringReplace(StringReplace($sAddData, "&&", "&"), "&&", "&")
												$__iLineNumber=1287 & ' - If StringLeft($sAddData, 1) = "&" Then $sAddData = StringTri ...•_WinHttp.au3'
												If StringLeft($sAddData, 1) = "&" Then $sAddData = StringTrimLeft($sAddData, 1)
												$__iLineNumber=1288 & ' - $sAddData &= "&" & $sChunkSub•_WinHttp.au3'
												$sAddData &= "&" & $sChunkSub
												$__iLineNumber=1289 & ' - $sRadio = StringRegExpReplace(StringReplace($sRadio, $sGrSep ...•_WinHttp.au3'
												$sRadio = StringRegExpReplace(StringReplace($sRadio, $sGrSep, $sGrSep & $sGrSep), "(?:" & $sGrSep & "|\A)\Q" & $aInputIds[1][$j] & "\E(.*?)(?:" & $sGrSep & "|\Z)", $sGrSep)
												$__iLineNumber=1290 & ' - $sRadio = StringReplace(StringReplace($sRadio, $sGrSep & $sG ...•_WinHttp.au3'
												$sRadio = StringReplace(StringReplace($sRadio, $sGrSep & $sGrSep, $sGrSep), $sGrSep & $sGrSep, $sGrSep)
											EndIf
										Next
									EndIf
								ElseIf $aInputIds[3][$j] = "checkbox" Then
									$__iLineNumber=1295 & ' - $sCheckBox = StringRegExpReplace($sCheckBox, "\Q" & $aInputI ...•_WinHttp.au3'
									$sCheckBox = StringRegExpReplace($sCheckBox, "\Q" & $aInputIds[1][$j] & "=" & $sPassedData & "\E" & $sGrSep & "*", "")
									$__iLineNumber=1296 & ' - __WinHttpTrimBounds($sCheckBox, $sGrSep)•_WinHttp.au3'
									__WinHttpTrimBounds($sCheckBox, $sGrSep)
								ElseIf $aInputIds[3][$j] = "button" Then
									$__iLineNumber=1298 & ' - $sButton = StringRegExpReplace($sButton, "\Q" & $aInputIds[1 ...•_WinHttp.au3'
									$sButton = StringRegExpReplace($sButton, "\Q" & $aInputIds[1][$j] & "=" & $sPassedData & "\E" & $sGrSep & "*", "")
									$__iLineNumber=1299 & ' - __WinHttpTrimBounds($sButton, $sGrSep)•_WinHttp.au3'
									__WinHttpTrimBounds($sButton, $sGrSep)
								Else
									$__iLineNumber=1301 & ' - $sAddData = StringRegExpReplace(StringReplace($sAddData, "&" ...•_WinHttp.au3'
									$sAddData = StringRegExpReplace(StringReplace($sAddData, "&", "&&"), "(?:&|\A)\Q" & $aInputIds[1][$j] & "=" & $aInputIds[2][$j] & "\E(?:&|\Z)", "&" & $aInputIds[1][$j] & "=" & $sPassedData & "&")
									$__iLineNumber=1302 & ' - $iNumRepl = @extended•_WinHttp.au3'
									$iNumRepl = @extended
									$__iLineNumber=1303 & ' - $sAddData = StringReplace($sAddData, "&&", "&")•_WinHttp.au3'
									$sAddData = StringReplace($sAddData, "&&", "&")
									$__iLineNumber=1304 & ' - If $iNumRepl > 1 Then ; equalize ; TODO: remove duplicates•_WinHttp.au3'
									If $iNumRepl > 1 Then ; equalize ; TODO: remove duplicates
										$__iLineNumber=1305 & ' - $sAddData = StringRegExpReplace($sAddData, "(?:&|\A)\Q" & $a ...•_WinHttp.au3'
										$sAddData = StringRegExpReplace($sAddData, "(?:&|\A)\Q" & $aInputIds[1][$j] & "\E=.*?(?:&|\Z)", "&", $iNumRepl - 1)
									EndIf
									$__iLineNumber=1307 & ' - __WinHttpTrimBounds($sAddData, "&")•_WinHttp.au3'
									__WinHttpTrimBounds($sAddData, "&")
								EndIf
							EndIf
						Next
					Else ; like .getElementsByName
						$__iLineNumber=1312 & ' - For $j = 0 To UBound($aInputIds, 2) - 1•_WinHttp.au3'
						For $j = 0 To UBound($aInputIds, 2) - 1
							$__iLineNumber=1313 & ' - If $aInputIds[3][$j] = "submit" Then•_WinHttp.au3'
							If $aInputIds[3][$j] = "submit" Then
								$__iLineNumber=1314 & ' - If $sPassedData = True Then ; if this "submit" is set to TRU ...•_WinHttp.au3'
								If $sPassedData = True Then ; if this "submit" is set to TRUE then
									$__iLineNumber=1315 & ' - If $aInputIds[1][$j] == $aSplit[1] Then•_WinHttp.au3'
									If $aInputIds[1][$j] == $aSplit[1] Then
										$__iLineNumber=1316 & ' - If $sSubmit Then ; If not already processed; only the first  ...•_WinHttp.au3'
										If $sSubmit Then ; If not already processed; only the first is valid
											$__iLineNumber=1317 & ' - Local $fDel = False•_WinHttp.au3'
											Local $fDel = False
											$__iLineNumber=1318 & ' - For $sChunkSub In StringSplit($sSubmit, $sGrSep, 3) ; go tru ...•_WinHttp.au3'
											For $sChunkSub In StringSplit($sSubmit, $sGrSep, 3) ; go tru all "submit" controls
												$__iLineNumber=1319 & ' - If $sChunkSub = $aInputIds[1][$j] & "=" & $aInputIds[2][$j]  ...•_WinHttp.au3'
												If $sChunkSub = $aInputIds[1][$j] & "=" & $aInputIds[2][$j] Then
													$__iLineNumber=1320 & ' - If $fDel Then $sAddData = StringRegExpReplace($sAddData, "(? ...•_WinHttp.au3'
													If $fDel Then $sAddData = StringRegExpReplace($sAddData, "(?:&|\A)\Q" & $sChunkSub & "\E(?:&|\Z)", "&", 1)
													$__iLineNumber=1321 & ' - $fDel = True•_WinHttp.au3'
													$fDel = True
												Else
													$__iLineNumber=1323 & ' - $sAddData = StringRegExpReplace($sAddData, "(?:&|\A)\Q" & $s ...•_WinHttp.au3'
													$sAddData = StringRegExpReplace($sAddData, "(?:&|\A)\Q" & $sChunkSub & "\E(?:&|\Z)", "&") ; delete all but the TRUE one
												EndIf
												$__iLineNumber=1325 & ' - __WinHttpTrimBounds($sAddData, "&")•_WinHttp.au3'
												__WinHttpTrimBounds($sAddData, "&")
											Next
											$__iLineNumber=1327 & ' - $sSubmit = ""•_WinHttp.au3'
											$sSubmit = ""
										EndIf
										ContinueLoop 2 ; process next parameter
									EndIf
								Else ; False means do nothing
									ContinueLoop 2 ; process next parameter
								EndIf
							ElseIf $aInputIds[1][$j] == $aSplit[1] And $aInputIds[3][$j] = "radio" Then
								$__iLineNumber=1335 & ' - For $sChunkSub In StringSplit($sRadio, $sGrSep, 3) ; go tru  ...•_WinHttp.au3'
								For $sChunkSub In StringSplit($sRadio, $sGrSep, 3) ; go tru all "radio" controls
									$__iLineNumber=1336 & ' - If $sChunkSub == $aInputIds[1][$j] & "=" & $sPassedData Then•_WinHttp.au3'
									If $sChunkSub == $aInputIds[1][$j] & "=" & $sPassedData Then
										$__iLineNumber=1337 & ' - $sAddData = StringReplace(StringReplace(StringRegExpReplace( ...•_WinHttp.au3'
										$sAddData = StringReplace(StringReplace(StringRegExpReplace(StringReplace($sAddData, "&", "&&"), "(?:&|\A)\Q" & $aInputIds[1][$j] & "\E(.*?)(?:&|\Z)", "&"), "&&", "&"), "&&", "&")
										$__iLineNumber=1338 & ' - If StringLeft($sAddData, 1) = "&" Then $sAddData = StringTri ...•_WinHttp.au3'
										If StringLeft($sAddData, 1) = "&" Then $sAddData = StringTrimLeft($sAddData, 1)
										$__iLineNumber=1339 & ' - $sAddData &= "&" & $sChunkSub•_WinHttp.au3'
										$sAddData &= "&" & $sChunkSub
										$__iLineNumber=1340 & ' - $sRadio = StringRegExpReplace(StringReplace($sRadio, $sGrSep ...•_WinHttp.au3'
										$sRadio = StringRegExpReplace(StringReplace($sRadio, $sGrSep, $sGrSep & $sGrSep), "(?:" & $sGrSep & "|\A)\Q" & $aInputIds[1][$j] & "\E(.*?)(?:" & $sGrSep & "|\Z)", $sGrSep)
										$__iLineNumber=1341 & ' - $sRadio = StringReplace(StringReplace($sRadio, $sGrSep & $sG ...•_WinHttp.au3'
										$sRadio = StringReplace(StringReplace($sRadio, $sGrSep & $sGrSep, $sGrSep), $sGrSep & $sGrSep, $sGrSep)
									EndIf
								Next
								ContinueLoop 2 ; process next parameter
							ElseIf $aInputIds[1][$j] == $aSplit[1] And $aInputIds[3][$j] = "checkbox" Then
								$__iLineNumber=1346 & ' - $sCheckBox = StringRegExpReplace($sCheckBox, "\Q" & $aInputI ...•_WinHttp.au3'
								$sCheckBox = StringRegExpReplace($sCheckBox, "\Q" & $aInputIds[1][$j] & "=" & $sPassedData & "\E" & $sGrSep & "*", "")
								$__iLineNumber=1347 & ' - __WinHttpTrimBounds($sCheckBox, $sGrSep)•_WinHttp.au3'
								__WinHttpTrimBounds($sCheckBox, $sGrSep)
								ContinueLoop 2 ; process next parameter
							ElseIf $aInputIds[1][$j] == $aSplit[1] And $aInputIds[3][$j] = "button" Then
								$__iLineNumber=1350 & ' - $sButton = StringRegExpReplace($sButton, "\Q" & $aInputIds[1 ...•_WinHttp.au3'
								$sButton = StringRegExpReplace($sButton, "\Q" & $aInputIds[1][$j] & "=" & $sPassedData & "\E" & $sGrSep & "*", "")
								$__iLineNumber=1351 & ' - __WinHttpTrimBounds($sButton, $sGrSep)•_WinHttp.au3'
								__WinHttpTrimBounds($sButton, $sGrSep)
								ContinueLoop 2 ; process next parameter
							EndIf
						Next
						$__iLineNumber=1355 & ' - $sAddData = StringRegExpReplace(StringReplace($sAddData, "&" ...•_WinHttp.au3'
						$sAddData = StringRegExpReplace(StringReplace($sAddData, "&", "&&"), "(?:&|\A)\Q" & $aSplit[1] & "\E=.*?(?:&|\Z)", "&" & $aSplit[1] & "=" & $sPassedData & "&")
						$__iLineNumber=1356 & ' - $iNumRepl = @extended•_WinHttp.au3'
						$iNumRepl = @extended
						$__iLineNumber=1357 & ' - $sAddData = StringReplace($sAddData, "&&", "&")•_WinHttp.au3'
						$sAddData = StringReplace($sAddData, "&&", "&")
						$__iLineNumber=1358 & ' - If $iNumRepl > 1 Then ; remove duplicates•_WinHttp.au3'
						If $iNumRepl > 1 Then ; remove duplicates
							$__iLineNumber=1359 & ' - $sAddData = StringRegExpReplace($sAddData, "(?:&|\A)\Q" & $a ...•_WinHttp.au3'
							$sAddData = StringRegExpReplace($sAddData, "(?:&|\A)\Q" & $aSplit[1] & "\E=.*?(?:&|\Z)", "&", $iNumRepl - 1)
						EndIf
						$__iLineNumber=1361 & ' - __WinHttpTrimBounds($sAddData, "&")•_WinHttp.au3'
						__WinHttpTrimBounds($sAddData, "&")
					EndIf
				Next
				$__iLineNumber=1364 & ' - __WinHttpFinalizeCtrls($sSubmit, $sRadio, $sCheckBox, $sButt ...•_WinHttp.au3'
				__WinHttpFinalizeCtrls($sSubmit, $sRadio, $sCheckBox, $sButton, $sAddData, $sGrSep, "&")
				$__iLineNumber=1365 & ' - If $sMethod = "GET" Then•_WinHttp.au3'
				If $sMethod = "GET" Then
					$__iLineNumber=1366 & ' - $sAction &= "?" & $sAddData•_WinHttp.au3'
					$sAction &= "?" & $sAddData
					$__iLineNumber=1367 & ' - $sAddData = "" ; not to send as addition to the request (thi ...•_WinHttp.au3'
					$sAddData = "" ; not to send as addition to the request (this is GET)
				EndIf
			$__iLineNumber=1369 & ' - Case "multipart/form-data"•_WinHttp.au3'
			Case "multipart/form-data"
				$__iLineNumber=1370 & ' - If $sMethod = "POST" Then ; can"t be GET•_WinHttp.au3'
				If $sMethod = "POST" Then ; can't be GET
					$__iLineNumber=1371 & ' - $fMultiPart = True•_WinHttp.au3'
					$fMultiPart = True
					; Define boundary line
					$__iLineNumber=1373 & ' - $sBoundary = StringFormat("%s%.5f", "----WinHttpBoundaryLine ...•_WinHttp.au3'
					$sBoundary = StringFormat("%s%.5f", "----WinHttpBoundaryLine_", Random(10000, 99999))
					$__iLineNumber=1374 & ' - Local $sCDisp = "Content-Disposition: form-data; name=""•_WinHttp.au3'
					Local $sCDisp = 'Content-Disposition: form-data; name="'
					$__iLineNumber=1375 & ' - For $i = 0 To UBound($aInput) - 1 ; for all input elements•_WinHttp.au3'
					For $i = 0 To UBound($aInput) - 1 ; for all input elements
						$__iLineNumber=1376 & ' - __WinHttpFormAttrib($aInputIds, $i, $aInput[$i])•_WinHttp.au3'
						__WinHttpFormAttrib($aInputIds, $i, $aInput[$i])
						$__iLineNumber=1377 & ' - If $aInputIds[1][$i] Then ; if there is "name" field•_WinHttp.au3'
						If $aInputIds[1][$i] Then ; if there is 'name' field
							$__iLineNumber=1378 & ' - $aInputIds[1][$i] = StringReplace($aInputIds[1][$i], $sSpr1, ...•_WinHttp.au3'
							$aInputIds[1][$i] = StringReplace($aInputIds[1][$i], $sSpr1, " ")
							$__iLineNumber=1379 & ' - $aInputIds[2][$i] = StringReplace(StringReplace($aInputIds[2 ...•_WinHttp.au3'
							$aInputIds[2][$i] = StringReplace(StringReplace($aInputIds[2][$i], $sSpr2, ">"), $sSpr1, " ")
							$__iLineNumber=1380 & ' - If $aInputIds[3][$i] = "file" Then•_WinHttp.au3'
							If $aInputIds[3][$i] = "file" Then
								$__iLineNumber=1381 & ' - $sAddData &= "--" & $sBoundary & @CRLF & _•_WinHttp.au3'
								$sAddData &= "--" & $sBoundary & @CRLF & _
										$sCDisp & $aInputIds[1][$i] & '"; filename=""' & @CRLF & @CRLF & _
										$aInputIds[2][$i] & @CRLF
							Else
								$__iLineNumber=1385 & ' - $sAddData &= "--" & $sBoundary & @CRLF & _•_WinHttp.au3'
								$sAddData &= "--" & $sBoundary & @CRLF & _
										$sCDisp & $aInputIds[1][$i] & '"' & @CRLF & @CRLF & _
										$aInputIds[2][$i] & @CRLF
							EndIf
							$__iLineNumber=1389 & ' - If $aInputIds[3][$i] = "submit" Then $sSubmit &= "--" & $sBo ...•_WinHttp.au3'
							If $aInputIds[3][$i] = "submit" Then $sSubmit &= "--" & $sBoundary & @CRLF & _
									$sCDisp & $aInputIds[1][$i] & '"' & @CRLF & @CRLF & _
									$aInputIds[2][$i] & @CRLF & $sGrSep
							$__iLineNumber=1392 & ' - If $aInputIds[3][$i] = "radio" Then $sRadio &= "--" & $sBoun ...•_WinHttp.au3'
							If $aInputIds[3][$i] = "radio" Then $sRadio &= "--" & $sBoundary & @CRLF & _
									$sCDisp & $aInputIds[1][$i] & '"' & @CRLF & @CRLF & _
									$aInputIds[2][$i] & @CRLF & $sGrSep
							$__iLineNumber=1395 & ' - If $aInputIds[3][$i] = "checkbox" Then $sCheckBox &= "--" &  ...•_WinHttp.au3'
							If $aInputIds[3][$i] = "checkbox" Then $sCheckBox &= "--" & $sBoundary & @CRLF & _
									$sCDisp & $aInputIds[1][$i] & '"' & @CRLF & @CRLF & _
									$aInputIds[2][$i] & @CRLF & $sGrSep
							$__iLineNumber=1398 & ' - If $aInputIds[3][$i] = "button" Then $sButton &= "--" & $sBo ...•_WinHttp.au3'
							If $aInputIds[3][$i] = "button" Then $sButton &= "--" & $sBoundary & @CRLF & _
									$sCDisp & $aInputIds[1][$i] & '"' & @CRLF & @CRLF & _
									$aInputIds[2][$i] & @CRLF & $sGrSep
						EndIf
					Next
					$__iLineNumber=1403 & ' - $sSubmit = StringTrimRight($sSubmit, 1)•_WinHttp.au3'
					$sSubmit = StringTrimRight($sSubmit, 1)
					$__iLineNumber=1404 & ' - $sRadio = StringTrimRight($sRadio, 1)•_WinHttp.au3'
					$sRadio = StringTrimRight($sRadio, 1)
					$__iLineNumber=1405 & ' - $sCheckBox = StringTrimRight($sCheckBox, 1)•_WinHttp.au3'
					$sCheckBox = StringTrimRight($sCheckBox, 1)
					$__iLineNumber=1406 & ' - $sButton = StringTrimRight($sButton, 1)•_WinHttp.au3'
					$sButton = StringTrimRight($sButton, 1)
					$__iLineNumber=1407 & ' - $sAddData &= "--" & $sBoundary & "--" & @CRLF•_WinHttp.au3'
					$sAddData &= "--" & $sBoundary & "--" & @CRLF
					$__iLineNumber=1408 & ' - For $k = 1 To $iNumParams•_WinHttp.au3'
					For $k = 1 To $iNumParams
						$__iLineNumber=1409 & ' - $sPassedData = $aDtas[$k]•_WinHttp.au3'
						$sPassedData = $aDtas[$k]
						$__iLineNumber=1410 & ' - $aDtas[$k] = 0•_WinHttp.au3'
						$aDtas[$k] = 0
						$__iLineNumber=1411 & ' - $sPassedId = $aFlds[$k]•_WinHttp.au3'
						$sPassedId = $aFlds[$k]
						$__iLineNumber=1412 & ' - $aFlds[$k] = 0•_WinHttp.au3'
						$aFlds[$k] = 0
						$__iLineNumber=1413 & ' - $aSplit = StringSplit($sPassedId, ":", 2)•_WinHttp.au3'
						$aSplit = StringSplit($sPassedId, ":", 2)
						$__iLineNumber=1414 & ' - If @error Or $aSplit[0] <> "name" Then ; like getElementById•_WinHttp.au3'
						If @error Or $aSplit[0] <> "name" Then ; like getElementById
							$__iLineNumber=1415 & ' - If Not @error And $aSplit[0] = "id" Then $sPassedId = $aSpli ...•_WinHttp.au3'
							If Not @error And $aSplit[0] = "id" Then $sPassedId = $aSplit[1]
							$__iLineNumber=1416 & ' - For $j = 0 To UBound($aInputIds, 2) - 1•_WinHttp.au3'
							For $j = 0 To UBound($aInputIds, 2) - 1
								$__iLineNumber=1417 & ' - If $aInputIds[0][$j] = $sPassedId Then•_WinHttp.au3'
								If $aInputIds[0][$j] = $sPassedId Then
									$__iLineNumber=1418 & ' - If $aInputIds[3][$j] = "file" Then•_WinHttp.au3'
									If $aInputIds[3][$j] = "file" Then
										$__iLineNumber=1419 & ' - $sAddData = StringReplace($sAddData, _•_WinHttp.au3'
										$sAddData = StringReplace($sAddData, _
												$sCDisp & $aInputIds[1][$j] & '"; filename=""' & @CRLF & @CRLF & $aInputIds[2][$j] & @CRLF, _
												__WinHttpFileContent($sAccept, $aInputIds[1][$j], $sPassedData, $sBoundary), 0, 1)
									ElseIf $aInputIds[3][$j] = "submit" Then
										$__iLineNumber=1423 & ' - If $sPassedData = True Then ; if this "submit" is set to TRU ...•_WinHttp.au3'
										If $sPassedData = True Then ; if this "submit" is set to TRUE then
											$__iLineNumber=1424 & ' - If $sSubmit Then ; If not already processed; only the first  ...•_WinHttp.au3'
											If $sSubmit Then ; If not already processed; only the first is valid
												$__iLineNumber=1425 & ' - Local $fMDelId = False•_WinHttp.au3'
												Local $fMDelId = False
												$__iLineNumber=1426 & ' - For $sChunkSub In StringSplit($sSubmit, $sGrSep, 3) ; go tru ...•_WinHttp.au3'
												For $sChunkSub In StringSplit($sSubmit, $sGrSep, 3) ; go tru all "submit" controls
													$__iLineNumber=1427 & ' - If $sChunkSub = "--" & $sBoundary & @CRLF & _•_WinHttp.au3'
													If $sChunkSub = "--" & $sBoundary & @CRLF & _
															$sCDisp & $aInputIds[1][$j] & '"' & @CRLF & @CRLF & _
															$aInputIds[2][$j] & @CRLF Then
														$__iLineNumber=1430 & ' - If $fMDelId Then $sAddData = StringReplace($sAddData, $sChun ...•_WinHttp.au3'
														If $fMDelId Then $sAddData = StringReplace($sAddData, $sChunkSub, "", 1, 1) ; Removing duplicates
														$__iLineNumber=1431 & ' - $fMDelId = True•_WinHttp.au3'
														$fMDelId = True
													Else
														$__iLineNumber=1433 & ' - $sAddData = StringReplace($sAddData, $sChunkSub, "", 0, 1) ; ...•_WinHttp.au3'
														$sAddData = StringReplace($sAddData, $sChunkSub, "", 0, 1) ; delete all but the TRUE one
													EndIf
												Next
												$__iLineNumber=1436 & ' - $sSubmit = ""•_WinHttp.au3'
												$sSubmit = ""
											EndIf
										EndIf
									ElseIf $aInputIds[3][$j] = "radio" Then
										$__iLineNumber=1440 & ' - If $sPassedData = $aInputIds[2][$j] Then•_WinHttp.au3'
										If $sPassedData = $aInputIds[2][$j] Then
											$__iLineNumber=1441 & ' - For $sChunkSub In StringSplit($sRadio, $sGrSep, 3) ; go tru  ...•_WinHttp.au3'
											For $sChunkSub In StringSplit($sRadio, $sGrSep, 3) ; go tru all "radio" controls
												$__iLineNumber=1442 & ' - If StringInStr($sChunkSub, "--" & $sBoundary & @CRLF & $sCDi ...•_WinHttp.au3'
												If StringInStr($sChunkSub, "--" & $sBoundary & @CRLF & $sCDisp & $aInputIds[1][$j] & '"' & @CRLF & @CRLF & $sPassedData & @CRLF, 1) Then
													$__iLineNumber=1443 & ' - $sAddData = StringRegExpReplace($sAddData, "\Q--" & $sBounda ...•_WinHttp.au3'
													$sAddData = StringRegExpReplace($sAddData, "\Q--" & $sBoundary & @CRLF & $sCDisp & $aInputIds[1][$j] & '"' & @CRLF & @CRLF & "\E" & "(.*?)" & @CRLF, "")
													$__iLineNumber=1444 & ' - $sAddData = StringReplace($sAddData, "--" & $sBoundary & "-- ...•_WinHttp.au3'
													$sAddData = StringReplace($sAddData, "--" & $sBoundary & "--" & @CRLF, "", 0, 1)
													$__iLineNumber=1445 & ' - $sAddData &= $sChunkSub & "--" & $sBoundary & "--" & @CRLF•_WinHttp.au3'
													$sAddData &= $sChunkSub & "--" & $sBoundary & "--" & @CRLF
													$__iLineNumber=1446 & ' - $sRadio = StringRegExpReplace($sRadio, "\Q--" & $sBoundary & ...•_WinHttp.au3'
													$sRadio = StringRegExpReplace($sRadio, "\Q--" & $sBoundary & @CRLF & $sCDisp & $aInputIds[1][$j] & '"' & @CRLF & @CRLF & "\E(.*?)" & @CRLF & $sGrSep & "?", "")
												EndIf
											Next
										EndIf
									ElseIf $aInputIds[3][$j] = "checkbox" Then
										$__iLineNumber=1451 & ' - $sCheckBox = StringRegExpReplace($sCheckBox, "\Q--" & $sBoun ...•_WinHttp.au3'
										$sCheckBox = StringRegExpReplace($sCheckBox, "\Q--" & $sBoundary & @CRLF & _
												$sCDisp & $aInputIds[1][$j] & '"' & @CRLF & @CRLF & _
												$sPassedData & @CRLF & "\E" & $sGrSep & "*", "")
										$__iLineNumber=1454 & ' - If StringRight($sCheckBox, 1) = $sGrSep Then $sCheckBox = St ...•_WinHttp.au3'
										If StringRight($sCheckBox, 1) = $sGrSep Then $sCheckBox = StringTrimRight($sCheckBox, 1)
									ElseIf $aInputIds[3][$j] = "button" Then
										$__iLineNumber=1456 & ' - $sButton = StringRegExpReplace($sButton, "\Q--" & $sBoundary ...•_WinHttp.au3'
										$sButton = StringRegExpReplace($sButton, "\Q--" & $sBoundary & @CRLF & _
												$sCDisp & $aInputIds[1][$j] & '"' & @CRLF & @CRLF & _
												$sPassedData & @CRLF & "\E" & $sGrSep & "*", "")
										$__iLineNumber=1459 & ' - If StringRight($sButton, 1) = $sGrSep Then $sButton = String ...•_WinHttp.au3'
										If StringRight($sButton, 1) = $sGrSep Then $sButton = StringTrimRight($sButton, 1)
									Else
										$__iLineNumber=1461 & ' - $sAddData = StringReplace($sAddData, _•_WinHttp.au3'
										$sAddData = StringReplace($sAddData, _
												$sCDisp & $aInputIds[1][$j] & '"' & @CRLF & @CRLF & $aInputIds[2][$j] & @CRLF, _
												$sCDisp & $aInputIds[1][$j] & '"' & @CRLF & @CRLF & $sPassedData & @CRLF, 0, 1)
										$__iLineNumber=1464 & ' - $iNumRepl = @extended•_WinHttp.au3'
										$iNumRepl = @extended
										$__iLineNumber=1465 & ' - If $iNumRepl > 1 Then ; equalize ; TODO: remove duplicates•_WinHttp.au3'
										If $iNumRepl > 1 Then ; equalize ; TODO: remove duplicates
											$__iLineNumber=1466 & ' - $sAddData = StringRegExpReplace($sAddData, "(?s)\Q--" & $sBo ...•_WinHttp.au3'
											$sAddData = StringRegExpReplace($sAddData, '(?s)\Q--' & $sBoundary & @CRLF & $sCDisp & $aInputIds[1][$j] & '"' & '\E\r\n\r\n.*?\r\n', "", $iNumRepl - 1)
										EndIf
									EndIf
								EndIf
							Next
						Else ; like getElementsByName
							$__iLineNumber=1472 & ' - For $j = 0 To UBound($aInputIds, 2) - 1•_WinHttp.au3'
							For $j = 0 To UBound($aInputIds, 2) - 1
								$__iLineNumber=1473 & ' - If $aInputIds[1][$j] == $aSplit[1] And $aInputIds[3][$j] = " ...•_WinHttp.au3'
								If $aInputIds[1][$j] == $aSplit[1] And $aInputIds[3][$j] = "file" Then
									$__iLineNumber=1474 & ' - $sAddData = StringReplace($sAddData, _•_WinHttp.au3'
									$sAddData = StringReplace($sAddData, _
											$sCDisp & $aSplit[1] & '"; filename=""' & @CRLF & @CRLF & $aInputIds[2][$j] & @CRLF, _
											__WinHttpFileContent($sAccept, $aInputIds[1][$j], $sPassedData, $sBoundary), 0, 1)
								ElseIf $aInputIds[1][$j] == $aSplit[1] And $aInputIds[3][$j] = "submit" Then
									$__iLineNumber=1478 & ' - If $sPassedData = True Then ; if this "submit" is set to TRU ...•_WinHttp.au3'
									If $sPassedData = True Then ; if this "submit" is set to TRUE then
										$__iLineNumber=1479 & ' - If $sSubmit Then ; If not already processed; only the first  ...•_WinHttp.au3'
										If $sSubmit Then ; If not already processed; only the first is valid
											$__iLineNumber=1480 & ' - Local $fMDel = False•_WinHttp.au3'
											Local $fMDel = False
											$__iLineNumber=1481 & ' - For $sChunkSub In StringSplit($sSubmit, $sGrSep, 3) ; go tru ...•_WinHttp.au3'
											For $sChunkSub In StringSplit($sSubmit, $sGrSep, 3) ; go tru all "submit" controls
												$__iLineNumber=1482 & ' - If $sChunkSub = "--" & $sBoundary & @CRLF & _•_WinHttp.au3'
												If $sChunkSub = "--" & $sBoundary & @CRLF & _
														$sCDisp & $aInputIds[1][$j] & '"' & @CRLF & @CRLF & _
														$aInputIds[2][$j] & @CRLF Then
													$__iLineNumber=1485 & ' - If $fMDel Then $sAddData = StringReplace($sAddData, $sChunkS ...•_WinHttp.au3'
													If $fMDel Then $sAddData = StringReplace($sAddData, $sChunkSub, "", 1, 1) ; Removing duplicates
													$__iLineNumber=1486 & ' - $fMDel = True•_WinHttp.au3'
													$fMDel = True
												Else
													$__iLineNumber=1488 & ' - $sAddData = StringReplace($sAddData, $sChunkSub, "", 0, 1) ; ...•_WinHttp.au3'
													$sAddData = StringReplace($sAddData, $sChunkSub, "", 0, 1) ; delete all but the TRUE one
												EndIf
											Next
											$__iLineNumber=1491 & ' - $sSubmit = ""•_WinHttp.au3'
											$sSubmit = ""
										EndIf
										ContinueLoop 2 ; process next parameter
									Else ; False means do nothing
										ContinueLoop 2 ; process next parameter
									EndIf
								ElseIf $aInputIds[1][$j] == $aSplit[1] And $aInputIds[3][$j] = "radio" Then
									$__iLineNumber=1498 & ' - For $sChunkSub In StringSplit($sRadio, $sGrSep, 3) ; go tru  ...•_WinHttp.au3'
									For $sChunkSub In StringSplit($sRadio, $sGrSep, 3) ; go tru all "radio" controls
										$__iLineNumber=1499 & ' - If StringInStr($sChunkSub, "--" & $sBoundary & @CRLF & $sCDi ...•_WinHttp.au3'
										If StringInStr($sChunkSub, "--" & $sBoundary & @CRLF & $sCDisp & $aInputIds[1][$j] & '"' & @CRLF & @CRLF & $sPassedData & @CRLF, 1) Then
											$__iLineNumber=1500 & ' - $sAddData = StringRegExpReplace($sAddData, "\Q--" & $sBounda ...•_WinHttp.au3'
											$sAddData = StringRegExpReplace($sAddData, "\Q--" & $sBoundary & @CRLF & $sCDisp & $aInputIds[1][$j] & '"' & @CRLF & @CRLF & "\E" & "(.*?)" & @CRLF, "")
											$__iLineNumber=1501 & ' - $sAddData = StringReplace($sAddData, "--" & $sBoundary & "-- ...•_WinHttp.au3'
											$sAddData = StringReplace($sAddData, "--" & $sBoundary & "--" & @CRLF, "", 0, 1)
											$__iLineNumber=1502 & ' - $sAddData &= $sChunkSub & "--" & $sBoundary & "--" & @CRLF•_WinHttp.au3'
											$sAddData &= $sChunkSub & "--" & $sBoundary & "--" & @CRLF
											$__iLineNumber=1503 & ' - $sRadio = StringRegExpReplace($sRadio, "\Q--" & $sBoundary & ...•_WinHttp.au3'
											$sRadio = StringRegExpReplace($sRadio, "\Q--" & $sBoundary & @CRLF & $sCDisp & $aInputIds[1][$j] & '"' & @CRLF & @CRLF & "\E(.*?)" & @CRLF & $sGrSep & "?", "")
										EndIf
									Next
									ContinueLoop 2 ; process next parameter
								ElseIf $aInputIds[1][$j] == $aSplit[1] And $aInputIds[3][$j] = "checkbox" Then
									$__iLineNumber=1508 & ' - $sCheckBox = StringRegExpReplace($sCheckBox, "\Q--" & $sBoun ...•_WinHttp.au3'
									$sCheckBox = StringRegExpReplace($sCheckBox, "\Q--" & $sBoundary & @CRLF & _
											$sCDisp & $aInputIds[1][$j] & '"' & @CRLF & @CRLF & _
											$sPassedData & @CRLF & "\E" & $sGrSep & "*", "")
									$__iLineNumber=1511 & ' - If StringRight($sCheckBox, 1) = $sGrSep Then $sCheckBox = St ...•_WinHttp.au3'
									If StringRight($sCheckBox, 1) = $sGrSep Then $sCheckBox = StringTrimRight($sCheckBox, 1)
									ContinueLoop 2 ; process next parameter
								ElseIf $aInputIds[1][$j] == $aSplit[1] And $aInputIds[3][$j] = "button" Then
									$__iLineNumber=1514 & ' - $sButton = StringRegExpReplace($sButton, "\Q--" & $sBoundary ...•_WinHttp.au3'
									$sButton = StringRegExpReplace($sButton, "\Q--" & $sBoundary & @CRLF & _
											$sCDisp & $aInputIds[1][$j] & '"' & @CRLF & @CRLF & _
											$sPassedData & @CRLF & "\E" & $sGrSep & "*", "")
									$__iLineNumber=1517 & ' - If StringRight($sButton, 1) = $sGrSep Then $sButton = String ...•_WinHttp.au3'
									If StringRight($sButton, 1) = $sGrSep Then $sButton = StringTrimRight($sButton, 1)
									ContinueLoop 2 ; process next parameter
								EndIf
							Next
							$__iLineNumber=1521 & ' - $sAddData = StringRegExpReplace($sAddData, "(?s)\Q" & $sCDis ...•_WinHttp.au3'
							$sAddData = StringRegExpReplace($sAddData, '(?s)\Q' & $sCDisp & $aSplit[1] & '"' & '\E\r\n\r\n.*?\r\n', _
									$sCDisp & $aSplit[1] & '"' & @CRLF & @CRLF & StringReplace($sPassedData, "\", "\\") & @CRLF)
							$__iLineNumber=1523 & ' - $iNumRepl = @extended•_WinHttp.au3'
							$iNumRepl = @extended
							$__iLineNumber=1524 & ' - If $iNumRepl > 1 Then ; remove duplicates•_WinHttp.au3'
							If $iNumRepl > 1 Then ; remove duplicates
								$__iLineNumber=1525 & ' - $sAddData = StringRegExpReplace($sAddData, "(?s)\Q--" & $sBo ...•_WinHttp.au3'
								$sAddData = StringRegExpReplace($sAddData, '(?s)\Q--' & $sBoundary & @CRLF & $sCDisp & $aSplit[1] & '"' & '\E\r\n\r\n.*?\r\n', "", $iNumRepl - 1)
							EndIf
						EndIf
					Next
				EndIf
				$__iLineNumber=1530 & ' - __WinHttpFinalizeCtrls($sSubmit, $sRadio, $sCheckBox, $sButt ...•_WinHttp.au3'
				__WinHttpFinalizeCtrls($sSubmit, $sRadio, $sCheckBox, $sButton, $sAddData, $sGrSep)
		EndSwitch
		ExitLoop
	Next
	; Send
	$__iLineNumber=1535 & ' - If $fSend Then•_WinHttp.au3'
	If $fSend Then
		$__iLineNumber=1536 & ' - If $fVarForm Then•_WinHttp.au3'
		If $fVarForm Then
			$__iLineNumber=1537 & ' - $hInternet = _WinHttpConnect($hOpen, $sNewURL)•_WinHttp.au3'
			$hInternet = _WinHttpConnect($hOpen, $sNewURL)
		Else
			$__iLineNumber=1539 & ' - If $sNewURL Then•_WinHttp.au3'
			If $sNewURL Then
				$__iLineNumber=1540 & ' - $hOpen = _WinHttpQueryOption($hInternet, $WINHTTP_OPTION_PAR ...•_WinHttp.au3'
				$hOpen = _WinHttpQueryOption($hInternet, $WINHTTP_OPTION_PARENT_HANDLE)
				$__iLineNumber=1541 & ' - _WinHttpCloseHandle($hInternet)•_WinHttp.au3'
				_WinHttpCloseHandle($hInternet)
				$__iLineNumber=1542 & ' - $hInternet = _WinHttpConnect($hOpen, $sNewURL)•_WinHttp.au3'
				$hInternet = _WinHttpConnect($hOpen, $sNewURL)
			EndIf
		EndIf
		$__iLineNumber=1545 & ' - Local $hRequest•_WinHttp.au3'
		Local $hRequest
		$__iLineNumber=1546 & ' - If $iScheme = $INTERNET_SCHEME_HTTPS Then•_WinHttp.au3'
		If $iScheme = $INTERNET_SCHEME_HTTPS Then
			$__iLineNumber=1547 & ' - $hRequest = __WinHttpFormSend($hInternet, $sMethod, $sAction ...•_WinHttp.au3'
			$hRequest = __WinHttpFormSend($hInternet, $sMethod, $sAction, $fMultiPart, $sBoundary, $sAddData, True, $sAdditionalHeaders, $sCredName, $sCredPass, $iIgnoreCertErr)
		Else
			$__iLineNumber=1549 & ' - $hRequest = __WinHttpFormSend($hInternet, $sMethod, $sAction ...•_WinHttp.au3'
			$hRequest = __WinHttpFormSend($hInternet, $sMethod, $sAction, $fMultiPart, $sBoundary, $sAddData, False, $sAdditionalHeaders, $sCredName, $sCredPass)
			$__iLineNumber=1550 & ' - If _WinHttpQueryHeaders($hRequest, $WINHTTP_QUERY_STATUS_COD ...•_WinHttp.au3'
			If _WinHttpQueryHeaders($hRequest, $WINHTTP_QUERY_STATUS_CODE) >= $HTTP_STATUS_BAD_REQUEST Then
				$__iLineNumber=1551 & ' - _WinHttpCloseHandle($hRequest)•_WinHttp.au3'
				_WinHttpCloseHandle($hRequest)
				$__iLineNumber=1552 & ' - $hRequest = __WinHttpFormSend($hInternet, $sMethod, $sAction ...•_WinHttp.au3'
				$hRequest = __WinHttpFormSend($hInternet, $sMethod, $sAction, $fMultiPart, $sBoundary, $sAddData, True, $sAdditionalHeaders, $sCredName, $sCredPass, $iIgnoreCertErr) ; try adding $WINHTTP_FLAG_SECURE
			EndIf
		EndIf
		$__iLineNumber=1555 & ' - Local $vReturned = _WinHttpSimpleReadData($hRequest)•_WinHttp.au3'
		Local $vReturned = _WinHttpSimpleReadData($hRequest)
		$__iLineNumber=1556 & ' - If @error Then•_WinHttp.au3'
		If @error Then
			$__iLineNumber=1557 & ' - _WinHttpCloseHandle($hRequest)•_WinHttp.au3'
			_WinHttpCloseHandle($hRequest)
			$__iLineNumber=1558 & ' - Return SetError(4, 0, "") ; either site is expiriencing prob ...•_WinHttp.au3'
			Return SetError(4, 0, "") ; either site is expiriencing problems or your connection
		EndIf
		$__iLineNumber=1560 & ' - Local $iSCode = _WinHttpQueryHeaders($hRequest, $WINHTTP_QUE ...•_WinHttp.au3'
		Local $iSCode = _WinHttpQueryHeaders($hRequest, $WINHTTP_QUERY_STATUS_CODE)
		$__iLineNumber=1561 & ' - If $iRetArr Then•_WinHttp.au3'
		If $iRetArr Then
			$__iLineNumber=1562 & ' - Local $aReturn[3] = [_WinHttpQueryHeaders($hRequest), $vRetu ...•_WinHttp.au3'
			Local $aReturn[3] = [_WinHttpQueryHeaders($hRequest), $vReturned, _WinHttpQueryOption($hRequest, $WINHTTP_OPTION_URL)]
			$__iLineNumber=1563 & ' - $vReturned = $aReturn•_WinHttp.au3'
			$vReturned = $aReturn
		EndIf
		$__iLineNumber=1565 & ' - _WinHttpCloseHandle($hRequest)•_WinHttp.au3'
		_WinHttpCloseHandle($hRequest)
		$__iLineNumber=1566 & ' - Return SetExtended($iSCode, $vReturned)•_WinHttp.au3'
		Return SetExtended($iSCode, $vReturned)
	EndIf
	; If here then there is no form on the page with specified attributes (name, id or index)
	$__iLineNumber=1569 & ' - Return SetError(3, 0, "")•_WinHttp.au3'
	Return SetError(3, 0, "")
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _WinHttpSimpleFormFill_SetUploadCallback
; Description ...: Sets user defined function as callback function for _WinHttpSimpleFormFill
; Syntax.........: _WinHttpSimpleFormFill_SetUploadCallback($vCallback [, $iNumChunks = 100 ])
; Parameters ....: $vCallback - UDF's name
;                  $iNumChunks - [optional] number of chunks to send during form submitting. Default is 100.
; Return values .: Undefined.
; Author ........: trancexx
; Remarks .......: Unregistering is done by passing [[0]] as first argument.
; Related .......: _WinHttpSimpleFormFill
; ===============================================================================================================================
$__iLineNumber=1583 & ' - Func _WinHttpSimpleFormFill_SetUploadCallback($vCallback = D ...•_WinHttp.au3'
Func _WinHttpSimpleFormFill_SetUploadCallback($vCallback = Default, $iNumChunks = 100)
	$__iLineNumber=1584 & ' - If $iNumChunks <= 0 Then $iNumChunks = 100•_WinHttp.au3'
	If $iNumChunks <= 0 Then $iNumChunks = 100
	$__iLineNumber=1585 & ' - Local Static $vFunc = Default, $iParts = $iNumChunks•_WinHttp.au3'
	Local Static $vFunc = Default, $iParts = $iNumChunks
	$__iLineNumber=1586 & ' - If $vCallback <> Default Then•_WinHttp.au3'
	If $vCallback <> Default Then
		$__iLineNumber=1587 & ' - $vFunc = $vCallback•_WinHttp.au3'
		$vFunc = $vCallback
		$__iLineNumber=1588 & ' - $iParts = Ceiling($iNumChunks)•_WinHttp.au3'
		$iParts = Ceiling($iNumChunks)
	ElseIf $vCallback = 0 Then
		$__iLineNumber=1590 & ' - $vFunc = Default•_WinHttp.au3'
		$vFunc = Default
		$__iLineNumber=1591 & ' - $iParts = 1•_WinHttp.au3'
		$iParts = 1
	EndIf
	$__iLineNumber=1593 & ' - Local $aOut[2] = [$vFunc, $iParts]•_WinHttp.au3'
	Local $aOut[2] = [$vFunc, $iParts]
	$__iLineNumber=1594 & ' - Return $aOut•_WinHttp.au3'
	Return $aOut
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _WinHttpSimpleReadData
; Description ...: Reads data from a request
; Syntax.........: _WinHttpSimpleReadData($hRequest [, $iMode = Default ])
; Parameters ....: $hRequest - request handle after _WinHttpReceiveResponse
;                  $iMode         - [optional] type of data returned
;                  |0 - ASCII-String
;                  |1 - UTF-8-String
;                  |2 - binary data
; Return values .: Success      - String or binary depending on $iMode
;                  Failure      - empty string or empty binary (mode 2) and set @error
;                  |1 - invalid mode
;                  |2 - no data available
; Author ........: ProgAndy
; Modified.......: trancexx
; Remarks .......: In case of default reading mode, if the server specifies utf-8 content type, function will force UTF-8 string.
; Related .......: _WinHttpReadData, _WinHttpSimpleRequest, _WinHttpSimpleSSLRequest
; ===============================================================================================================================
$__iLineNumber=1615 & ' - Func _WinHttpSimpleReadData($hRequest, $iMode = Default)•_WinHttp.au3'
Func _WinHttpSimpleReadData($hRequest, $iMode = Default)
	$__iLineNumber=1616 & ' - If $iMode = Default Then•_WinHttp.au3'
	If $iMode = Default Then
		$__iLineNumber=1617 & ' - $iMode = 0•_WinHttp.au3'
		$iMode = 0
		$__iLineNumber=1618 & ' - If __WinHttpCharSet(_WinHttpQueryHeaders($hRequest, $WINHTTP ...•_WinHttp.au3'
		If __WinHttpCharSet(_WinHttpQueryHeaders($hRequest, $WINHTTP_QUERY_CONTENT_TYPE)) = 65001 Then $iMode = 1 ; header suggest utf-8
	Else
		$__iLineNumber=1620 & ' - __WinHttpDefault($iMode, 0)•_WinHttp.au3'
		__WinHttpDefault($iMode, 0)
	EndIf
	$__iLineNumber=1622 & ' - If $iMode > 2 Or $iMode < 0 Then Return SetError(1, 0, "")•_WinHttp.au3'
	If $iMode > 2 Or $iMode < 0 Then Return SetError(1, 0, '')
	$__iLineNumber=1623 & ' - Local $vData = Binary("")•_WinHttp.au3'
	Local $vData = Binary('')
	$__iLineNumber=1624 & ' - If _WinHttpQueryDataAvailable($hRequest) Then•_WinHttp.au3'
	If _WinHttpQueryDataAvailable($hRequest) Then
		Do
			$__iLineNumber=1626 & ' - $vData &= _WinHttpReadData($hRequest, 2)•_WinHttp.au3'
			$vData &= _WinHttpReadData($hRequest, 2)
		$__iLineNumber=1627 & ' - Until @error•_WinHttp.au3'
		Until @error
		$__iLineNumber=1628 & ' - Switch $iMode•_WinHttp.au3'
		$__iLineNumber=1629 & ' - Case 0•_WinHttp.au3'
		Switch $iMode
			Case 0
				$__iLineNumber=1630 & ' - Return BinaryToString($vData)•_WinHttp.au3'
				Return BinaryToString($vData)
			$__iLineNumber=1631 & ' - Case 1•_WinHttp.au3'
			Case 1
				$__iLineNumber=1632 & ' - Return BinaryToString($vData, 4)•_WinHttp.au3'
				Return BinaryToString($vData, 4)
			Case Else
				$__iLineNumber=1634 & ' - Return $vData•_WinHttp.au3'
				Return $vData
		EndSwitch
	EndIf
	$__iLineNumber=1637 & ' - Return SetError(2, 0, $vData)•_WinHttp.au3'
	Return SetError(2, 0, $vData)
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _WinHttpSimpleReadDataAsync
; Description ...: Reads data from a request in asynchronous mode
; Syntax.........: _WinHttpSimpleReadDataAsync($hInternet, Byref $pBuffer [, $iNumberOfBytesToRead = Default ])
; Parameters ....: $hInternet - Request handle (first parameter while in callback function).
;                  $pBuffer - Pointer to memory buffer to which to read.
;                  $iNumberOfBytesToRead - [optional] The number of bytes to read. Default is 8192 bytes.
;                  |0 - ASCII-String
;                  |1 - UTF-8-String
;                  |2 - binary data
; Return values .: Same as for _WinHttpReadData. Due to async nature here it has no meaning except in case of possible error.
; Author ........: trancexx
; Remarks .......: <b>You are strongly discouraged to use WinHTTP in asynchronous mode with AutoIt. AutoIt's callback implementation can't handle reentrancy properly.</b>
;                  +WinHttp is rentrant during asynchronous completion callback. Make sure you have only one callback running and only one request handled though it at time.
;                  +Also make sure memory buffer is at least 8192 bytes in size if [[$iNumberOfBytesToRead]] is left default.
; Related .......: _WinHttpSimpleReadData, _WinHttpReadData
; ===============================================================================================================================
$__iLineNumber=1657 & ' - Func _WinHttpSimpleReadDataAsync($hInternet, ByRef $pBuffer, ...•_WinHttp.au3'
Func _WinHttpSimpleReadDataAsync($hInternet, ByRef $pBuffer, $iNumberOfBytesToRead = Default)
	$__iLineNumber=1658 & ' - __WinHttpDefault($iNumberOfBytesToRead, 8192)•_WinHttp.au3'
	__WinHttpDefault($iNumberOfBytesToRead, 8192)
	$__iLineNumber=1659 & ' - Local $vOut = _WinHttpReadData($hInternet, 2, $iNumberOfByte ...•_WinHttp.au3'
	Local $vOut = _WinHttpReadData($hInternet, 2, $iNumberOfBytesToRead, $pBuffer)
	$__iLineNumber=1660 & ' - Return SetError(@error, @extended, $vOut)•_WinHttp.au3'
	Return SetError(@error, @extended, $vOut)
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _WinHttpSimpleRequest
; Description ...: A function to send a request in a simpler form
; Syntax.........: _WinHttpSimpleRequest($hConnect, $sType, $sPath [, $sReferrer = Default [, $sDta = Default [, $sHeader = Default [, $fGetHeaders = Default [, $iMode = Default ]]]]])
; Parameters ....: $hConnect  - Handle from _WinHttpConnect
;                  $sType       - [optional] GET or POST (default: GET)
;                  $sPath       - [optional] request path (default: "" - empty string; meaning 'default' page on the server)
;                  $sReferrer   - [optional] referrer (default: $WINHTTP_NO_REFERER)
;                  $sDta        - [optional] POST-Data (default: $WINHTTP_NO_REQUEST_DATA)
;                  $sHeader     - [optional] additional Headers (default: $WINHTTP_NO_ADDITIONAL_HEADERS)
;                  $fGetHeaders - [optional] return response headers (default: False)
;                  $iMode       - [optional] reading mode of result
;                  |0 - ASCII-text
;                  |1 - UTF-8 text
;                  |2 - binary data
; Return values .: Success      - response data if $fGetHeaders = False (default)
;                  |Array if $fGetHeaders = True
;                  | [0] - response headers
;                  | [1] - response data
;                  Failure      - 0 and set @error
;                  |1 - could not open request
;                  |2 - could not send request
;                  |3 - could not receive response
;                  |4 - $iMode is not valid
; Author ........: ProgAndy
; Modified.......: trancexx
; Related .......: _WinHttpSimpleSSLRequest, _WinHttpSimpleSendRequest, _WinHttpSimpleSendSSLRequest, _WinHttpQueryHeaders, _WinHttpSimpleReadData
; ===============================================================================================================================
$__iLineNumber=1691 & ' - Func _WinHttpSimpleRequest($hConnect, $sType = Default, $sPa ...•_WinHttp.au3'
Func _WinHttpSimpleRequest($hConnect, $sType = Default, $sPath = Default, $sReferrer = Default, $sDta = Default, $sHeader = Default, $fGetHeaders = Default, $iMode = Default, $sCredName = Default, $sCredPass = Default)
	; Author: ProgAndy
	$__iLineNumber=1693 & ' - __WinHttpDefault($sType, "GET")•_WinHttp.au3'
	__WinHttpDefault($sType, "GET")
	$__iLineNumber=1694 & ' - __WinHttpDefault($sPath, "")•_WinHttp.au3'
	__WinHttpDefault($sPath, "")
	$__iLineNumber=1695 & ' - __WinHttpDefault($sReferrer, $WINHTTP_NO_REFERER)•_WinHttp.au3'
	__WinHttpDefault($sReferrer, $WINHTTP_NO_REFERER)
	$__iLineNumber=1696 & ' - __WinHttpDefault($sDta, $WINHTTP_NO_REQUEST_DATA)•_WinHttp.au3'
	__WinHttpDefault($sDta, $WINHTTP_NO_REQUEST_DATA)
	$__iLineNumber=1697 & ' - __WinHttpDefault($sHeader, $WINHTTP_NO_ADDITIONAL_HEADERS)•_WinHttp.au3'
	__WinHttpDefault($sHeader, $WINHTTP_NO_ADDITIONAL_HEADERS)
	$__iLineNumber=1698 & ' - __WinHttpDefault($fGetHeaders, False)•_WinHttp.au3'
	__WinHttpDefault($fGetHeaders, False)
	$__iLineNumber=1699 & ' - __WinHttpDefault($iMode, Default)•_WinHttp.au3'
	__WinHttpDefault($iMode, Default)
	$__iLineNumber=1700 & ' - __WinHttpDefault($sCredName, "")•_WinHttp.au3'
	__WinHttpDefault($sCredName, "")
	$__iLineNumber=1701 & ' - __WinHttpDefault($sCredPass, "")•_WinHttp.au3'
	__WinHttpDefault($sCredPass, "")
	$__iLineNumber=1702 & ' - If $iMode > 2 Or $iMode < 0 Then Return SetError(4, 0, 0)•_WinHttp.au3'
	If $iMode > 2 Or $iMode < 0 Then Return SetError(4, 0, 0)
	$__iLineNumber=1703 & ' - Local $hRequest = _WinHttpSimpleSendRequest($hConnect, $sTyp ...•_WinHttp.au3'
	Local $hRequest = _WinHttpSimpleSendRequest($hConnect, $sType, $sPath, $sReferrer, $sDta, $sHeader)
	$__iLineNumber=1704 & ' - If @error Then Return SetError(@error, 0, 0)•_WinHttp.au3'
	If @error Then Return SetError(@error, 0, 0)
	$__iLineNumber=1705 & ' - __WinHttpSetCredentials($hRequest, $sHeader, $sDta, $sCredNa ...•_WinHttp.au3'
	__WinHttpSetCredentials($hRequest, $sHeader, $sDta, $sCredName, $sCredPass)
	$__iLineNumber=1706 & ' - Local $iExtended = _WinHttpQueryHeaders($hRequest, $WINHTTP_ ...•_WinHttp.au3'
	Local $iExtended = _WinHttpQueryHeaders($hRequest, $WINHTTP_QUERY_STATUS_CODE)
	$__iLineNumber=1707 & ' - If $fGetHeaders Then•_WinHttp.au3'
	If $fGetHeaders Then
		$__iLineNumber=1708 & ' - Local $aData[3] = [_WinHttpQueryHeaders($hRequest), _WinHttp ...•_WinHttp.au3'
		Local $aData[3] = [_WinHttpQueryHeaders($hRequest), _WinHttpSimpleReadData($hRequest, $iMode), _WinHttpQueryOption($hRequest, $WINHTTP_OPTION_URL)]
		$__iLineNumber=1709 & ' - _WinHttpCloseHandle($hRequest)•_WinHttp.au3'
		_WinHttpCloseHandle($hRequest)
		$__iLineNumber=1710 & ' - Return SetExtended($iExtended, $aData)•_WinHttp.au3'
		Return SetExtended($iExtended, $aData)
	EndIf
	$__iLineNumber=1712 & ' - Local $sOutData = _WinHttpSimpleReadData($hRequest, $iMode)•_WinHttp.au3'
	Local $sOutData = _WinHttpSimpleReadData($hRequest, $iMode)
	$__iLineNumber=1713 & ' - _WinHttpCloseHandle($hRequest)•_WinHttp.au3'
	_WinHttpCloseHandle($hRequest)
	$__iLineNumber=1714 & ' - Return SetExtended($iExtended, $sOutData)•_WinHttp.au3'
	Return SetExtended($iExtended, $sOutData)
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _WinHttpSimpleSendRequest
; Description ...: A function to send a request in a simpler form, but not read the data
; Syntax.........: _WinHttpSimpleSendRequest($hConnect, $sType, $sPath [, $sReferrer = Default [, $sDta = Default [, $sHeader = Default ]]])
; Parameters ....: $hConnect  - Handle from _WinHttpConnect
;                  $sType       - [optional] GET or POST (default: GET)
;                  $sPath       - [optional] request path (default: "" - empty string; meaning 'default' page on the server)
;                  $sReferrer   - [optional] referrer (default: $WINHTTP_NO_REFERER)
;                  $sDta        - [optional] POST-Data (default: $WINHTTP_NO_REQUEST_DATA)
;                  $sHeader     - [optional] additional Headers (default: $WINHTTP_NO_ADDITIONAL_HEADERS)
; Return values .: Success      - handle of request after _WinHttpReceiveResponse.
;                  Failure      - 0 and set @error
;                  |1 - could not open request
;                  |2 - could not send request
;                  |3 - could not receive response
; Author ........: ProgAndy
; Related .......: _WinHttpSimpleRequest, _WinHttpSimpleSendSSLRequest, _WinHttpSimpleReadData
; ===============================================================================================================================
$__iLineNumber=1735 & ' - Func _WinHttpSimpleSendRequest($hConnect, $sType = Default,  ...•_WinHttp.au3'
Func _WinHttpSimpleSendRequest($hConnect, $sType = Default, $sPath = Default, $sReferrer = Default, $sDta = Default, $sHeader = Default)
	; Author: ProgAndy
	$__iLineNumber=1737 & ' - __WinHttpDefault($sType, "GET")•_WinHttp.au3'
	__WinHttpDefault($sType, "GET")
	$__iLineNumber=1738 & ' - __WinHttpDefault($sPath, "")•_WinHttp.au3'
	__WinHttpDefault($sPath, "")
	$__iLineNumber=1739 & ' - __WinHttpDefault($sReferrer, $WINHTTP_NO_REFERER)•_WinHttp.au3'
	__WinHttpDefault($sReferrer, $WINHTTP_NO_REFERER)
	$__iLineNumber=1740 & ' - __WinHttpDefault($sDta, $WINHTTP_NO_REQUEST_DATA)•_WinHttp.au3'
	__WinHttpDefault($sDta, $WINHTTP_NO_REQUEST_DATA)
	$__iLineNumber=1741 & ' - __WinHttpDefault($sHeader, $WINHTTP_NO_ADDITIONAL_HEADERS)•_WinHttp.au3'
	__WinHttpDefault($sHeader, $WINHTTP_NO_ADDITIONAL_HEADERS)
	$__iLineNumber=1742 & ' - Local $hRequest = _WinHttpOpenRequest($hConnect, $sType, $sP ...•_WinHttp.au3'
	Local $hRequest = _WinHttpOpenRequest($hConnect, $sType, $sPath, Default, $sReferrer)
	$__iLineNumber=1743 & ' - If Not $hRequest Then Return SetError(1, @error, 0)•_WinHttp.au3'
	If Not $hRequest Then Return SetError(1, @error, 0)
	$__iLineNumber=1744 & ' - If $sType = "POST" And $sHeader = $WINHTTP_NO_ADDITIONAL_HEA ...•_WinHttp.au3'
	If $sType = "POST" And $sHeader = $WINHTTP_NO_ADDITIONAL_HEADERS Then $sHeader = "Content-Type: application/x-www-form-urlencoded" & @CRLF
	$__iLineNumber=1745 & ' - _WinHttpSetOption($hRequest, $WINHTTP_OPTION_DECOMPRESSION,  ...•_WinHttp.au3'
	_WinHttpSetOption($hRequest, $WINHTTP_OPTION_DECOMPRESSION, $WINHTTP_DECOMPRESSION_FLAG_ALL)
	$__iLineNumber=1746 & ' - _WinHttpSetOption($hRequest, $WINHTTP_OPTION_UNSAFE_HEADER_P ...•_WinHttp.au3'
	_WinHttpSetOption($hRequest, $WINHTTP_OPTION_UNSAFE_HEADER_PARSING, 1)
	$__iLineNumber=1747 & ' - _WinHttpSendRequest($hRequest, $sHeader, $sDta)•_WinHttp.au3'
	_WinHttpSendRequest($hRequest, $sHeader, $sDta)
	$__iLineNumber=1748 & ' - If @error Then Return SetError(2, 0 * _WinHttpCloseHandle($h ...•_WinHttp.au3'
	If @error Then Return SetError(2, 0 * _WinHttpCloseHandle($hRequest), 0)
	$__iLineNumber=1749 & ' - _WinHttpReceiveResponse($hRequest)•_WinHttp.au3'
	_WinHttpReceiveResponse($hRequest)
	$__iLineNumber=1750 & ' - If @error Then Return SetError(3, 0 * _WinHttpCloseHandle($h ...•_WinHttp.au3'
	If @error Then Return SetError(3, 0 * _WinHttpCloseHandle($hRequest), 0)
	$__iLineNumber=1751 & ' - Return $hRequest•_WinHttp.au3'
	Return $hRequest
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _WinHttpSimpleSendSSLRequest
; Description ...: A function to send a SSL request in a simpler form, but not read the data
; Syntax.........: _WinHttpSimpleSendSSLRequest($hConnect [, $sType [, $sPath [, $sReferrer = Default [, $sDta = Default [, $sHeader = Default ]]]]])
; Parameters ....: $hConnect  - Handle from _WinHttpConnect
;                  $sType       - [optional] GET or POST (default: GET)
;                  $sPath       - [optional] request path (default: "" - empty string; meaning 'default' page on the server)
;                  $sReferrer   - [optional] referrer (default: $WINHTTP_NO_REFERER)
;                  $sDta        - [optional] POST-Data (default: $WINHTTP_NO_REQUEST_DATA)
;                  $sHeader     - [optional] additional Headers (default: $WINHTTP_NO_ADDITIONAL_HEADERS)
; Return values .: Success      - handle of request after _WinHttpReceiveResponse.
;                  Failure      - 0 and set @error
;                  |1 - could not open request
;                  |2 - could not send request
;                  |3 - could not receive response
; Author ........: ProgAndy
; Related .......: _WinHttpSimpleSSLRequest, _WinHttpSimpleSendRequest, _WinHttpSimpleReadData
; ===============================================================================================================================
$__iLineNumber=1772 & ' - Func _WinHttpSimpleSendSSLRequest($hConnect, $sType = Defaul ...•_WinHttp.au3'
Func _WinHttpSimpleSendSSLRequest($hConnect, $sType = Default, $sPath = Default, $sReferrer = Default, $sDta = Default, $sHeader = Default, $iIgnoreAllCertErrors = 0)
	; Author: ProgAndy
	$__iLineNumber=1774 & ' - __WinHttpDefault($sType, "GET")•_WinHttp.au3'
	__WinHttpDefault($sType, "GET")
	$__iLineNumber=1775 & ' - __WinHttpDefault($sPath, "")•_WinHttp.au3'
	__WinHttpDefault($sPath, "")
	$__iLineNumber=1776 & ' - __WinHttpDefault($sReferrer, $WINHTTP_NO_REFERER)•_WinHttp.au3'
	__WinHttpDefault($sReferrer, $WINHTTP_NO_REFERER)
	$__iLineNumber=1777 & ' - __WinHttpDefault($sDta, $WINHTTP_NO_REQUEST_DATA)•_WinHttp.au3'
	__WinHttpDefault($sDta, $WINHTTP_NO_REQUEST_DATA)
	$__iLineNumber=1778 & ' - __WinHttpDefault($sHeader, $WINHTTP_NO_ADDITIONAL_HEADERS)•_WinHttp.au3'
	__WinHttpDefault($sHeader, $WINHTTP_NO_ADDITIONAL_HEADERS)
	$__iLineNumber=1779 & ' - Local $hRequest = _WinHttpOpenRequest($hConnect, $sType, $sP ...•_WinHttp.au3'
	Local $hRequest = _WinHttpOpenRequest($hConnect, $sType, $sPath, Default, $sReferrer, Default, BitOR($WINHTTP_FLAG_SECURE, $WINHTTP_FLAG_ESCAPE_DISABLE))
	$__iLineNumber=1780 & ' - If Not $hRequest Then Return SetError(1, @error, 0)•_WinHttp.au3'
	If Not $hRequest Then Return SetError(1, @error, 0)
	$__iLineNumber=1781 & ' - If $iIgnoreAllCertErrors Then _WinHttpSetOption($hRequest, $ ...•_WinHttp.au3'
	If $iIgnoreAllCertErrors Then _WinHttpSetOption($hRequest, $WINHTTP_OPTION_SECURITY_FLAGS, BitOR($SECURITY_FLAG_IGNORE_UNKNOWN_CA, $SECURITY_FLAG_IGNORE_CERT_DATE_INVALID, $SECURITY_FLAG_IGNORE_CERT_CN_INVALID, $SECURITY_FLAG_IGNORE_CERT_WRONG_USAGE))
	$__iLineNumber=1782 & ' - If $sType = "POST" And $sHeader = $WINHTTP_NO_ADDITIONAL_HEA ...•_WinHttp.au3'
	If $sType = "POST" And $sHeader = $WINHTTP_NO_ADDITIONAL_HEADERS Then $sHeader = "Content-Type: application/x-www-form-urlencoded" & @CRLF
	$__iLineNumber=1783 & ' - _WinHttpSetOption($hRequest, $WINHTTP_OPTION_DECOMPRESSION,  ...•_WinHttp.au3'
	_WinHttpSetOption($hRequest, $WINHTTP_OPTION_DECOMPRESSION, $WINHTTP_DECOMPRESSION_FLAG_ALL)
	$__iLineNumber=1784 & ' - _WinHttpSetOption($hRequest, $WINHTTP_OPTION_UNSAFE_HEADER_P ...•_WinHttp.au3'
	_WinHttpSetOption($hRequest, $WINHTTP_OPTION_UNSAFE_HEADER_PARSING, 1)
	$__iLineNumber=1785 & ' - _WinHttpSendRequest($hRequest, $sHeader, $sDta)•_WinHttp.au3'
	_WinHttpSendRequest($hRequest, $sHeader, $sDta)
	$__iLineNumber=1786 & ' - If @error Then Return SetError(2, 0 * _WinHttpCloseHandle($h ...•_WinHttp.au3'
	If @error Then Return SetError(2, 0 * _WinHttpCloseHandle($hRequest), 0)
	$__iLineNumber=1787 & ' - _WinHttpReceiveResponse($hRequest)•_WinHttp.au3'
	_WinHttpReceiveResponse($hRequest)
	$__iLineNumber=1788 & ' - If @error Then Return SetError(3, 0 * _WinHttpCloseHandle($h ...•_WinHttp.au3'
	If @error Then Return SetError(3, 0 * _WinHttpCloseHandle($hRequest), 0)
	$__iLineNumber=1789 & ' - Return $hRequest•_WinHttp.au3'
	Return $hRequest
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _WinHttpSimpleSSLRequest
; Description ...: A function to send a SSL request in a simpler form
; Syntax.........: _WinHttpSimpleSSLRequest($hConnect [, $sType [, $sPath [, $sReferrer = Default [, $sDta = Default [, $sHeader = Default [, $fGetHeaders = Default [, $iMode = Default ]]]]]]])
; Parameters ....: $hConnect  - Handle from _WinHttpConnect
;                  $sType       - [optional] GET or POST (default: GET)
;                  $sPath       - [optional] request path (default: "" - empty string; meaning 'default' page on the server)
;                  $sReferrer   - [optional] referrer (default: $WINHTTP_NO_REFERER)
;                  $sDta        - [optional] POST-Data (default: $WINHTTP_NO_REQUEST_DATA)
;                  $sHeader     - [optional] additional Headers (default: $WINHTTP_NO_ADDITIONAL_HEADERS)
;                  $fGetHeaders - [optional] return response headers (default: False)
;                  $iMode       - [optional] reading mode of result
;                  |0 - ASCII-text
;                  |1 - UTF-8 text
;                  |2 - binary data
; Return values .: Success      - response data if $fGetHeaders = False (default)
;                  |Array if $fGetHeaders = True
;                  | [0] - response headers
;                  | [1] - response data
;                  Failure      - 0 and set @error
;                  |1 - could not open request
;                  |2 - could not send request
;                  |3 - could not receive response
;                  |4 - $iMode is not valid
; Author ........: ProgAndy
; Modified.......: trancexx
; Related .......: _WinHttpSimpleRequest, _WinHttpSimpleSendSSLRequest, _WinHttpSimpleSendRequest, _WinHttpQueryHeaders, _WinHttpSimpleReadData
; ===============================================================================================================================
$__iLineNumber=1820 & ' - Func _WinHttpSimpleSSLRequest($hConnect, $sType = Default, $ ...•_WinHttp.au3'
Func _WinHttpSimpleSSLRequest($hConnect, $sType = Default, $sPath = Default, $sReferrer = Default, $sDta = Default, $sHeader = Default, $fGetHeaders = Default, $iMode = Default, $sCredName = Default, $sCredPass = Default, $iIgnoreCertErrors = 0)
	; Author: ProgAndy
	$__iLineNumber=1822 & ' - __WinHttpDefault($sType, "GET")•_WinHttp.au3'
	__WinHttpDefault($sType, "GET")
	$__iLineNumber=1823 & ' - __WinHttpDefault($sPath, "")•_WinHttp.au3'
	__WinHttpDefault($sPath, "")
	$__iLineNumber=1824 & ' - __WinHttpDefault($sReferrer, $WINHTTP_NO_REFERER)•_WinHttp.au3'
	__WinHttpDefault($sReferrer, $WINHTTP_NO_REFERER)
	$__iLineNumber=1825 & ' - __WinHttpDefault($sDta, $WINHTTP_NO_REQUEST_DATA)•_WinHttp.au3'
	__WinHttpDefault($sDta, $WINHTTP_NO_REQUEST_DATA)
	$__iLineNumber=1826 & ' - __WinHttpDefault($sHeader, $WINHTTP_NO_ADDITIONAL_HEADERS)•_WinHttp.au3'
	__WinHttpDefault($sHeader, $WINHTTP_NO_ADDITIONAL_HEADERS)
	$__iLineNumber=1827 & ' - __WinHttpDefault($fGetHeaders, False)•_WinHttp.au3'
	__WinHttpDefault($fGetHeaders, False)
	$__iLineNumber=1828 & ' - __WinHttpDefault($iMode, Default)•_WinHttp.au3'
	__WinHttpDefault($iMode, Default)
	$__iLineNumber=1829 & ' - __WinHttpDefault($sCredName, "")•_WinHttp.au3'
	__WinHttpDefault($sCredName, "")
	$__iLineNumber=1830 & ' - __WinHttpDefault($sCredPass, "")•_WinHttp.au3'
	__WinHttpDefault($sCredPass, "")
	$__iLineNumber=1831 & ' - If $iMode > 2 Or $iMode < 0 Then Return SetError(4, 0, 0)•_WinHttp.au3'
	If $iMode > 2 Or $iMode < 0 Then Return SetError(4, 0, 0)
	$__iLineNumber=1832 & ' - Local $hRequest = _WinHttpSimpleSendSSLRequest($hConnect, $s ...•_WinHttp.au3'
	Local $hRequest = _WinHttpSimpleSendSSLRequest($hConnect, $sType, $sPath, $sReferrer, $sDta, $sHeader, $iIgnoreCertErrors)
	$__iLineNumber=1833 & ' - If @error Then Return SetError(@error, 0, 0)•_WinHttp.au3'
	If @error Then Return SetError(@error, 0, 0)
	$__iLineNumber=1834 & ' - __WinHttpSetCredentials($hRequest, $sHeader, $sDta, $sCredNa ...•_WinHttp.au3'
	__WinHttpSetCredentials($hRequest, $sHeader, $sDta, $sCredName, $sCredPass)
	$__iLineNumber=1835 & ' - If $fGetHeaders Then•_WinHttp.au3'
	If $fGetHeaders Then
		$__iLineNumber=1836 & ' - Local $aData[3] = [_WinHttpQueryHeaders($hRequest), _WinHttp ...•_WinHttp.au3'
		Local $aData[3] = [_WinHttpQueryHeaders($hRequest), _WinHttpSimpleReadData($hRequest, $iMode), _WinHttpQueryOption($hRequest, $WINHTTP_OPTION_URL)]
		$__iLineNumber=1837 & ' - _WinHttpCloseHandle($hRequest)•_WinHttp.au3'
		_WinHttpCloseHandle($hRequest)
		$__iLineNumber=1838 & ' - Return $aData•_WinHttp.au3'
		Return $aData
	EndIf
	$__iLineNumber=1840 & ' - Local $sOutData = _WinHttpSimpleReadData($hRequest, $iMode)•_WinHttp.au3'
	Local $sOutData = _WinHttpSimpleReadData($hRequest, $iMode)
	$__iLineNumber=1841 & ' - _WinHttpCloseHandle($hRequest)•_WinHttp.au3'
	_WinHttpCloseHandle($hRequest)
	$__iLineNumber=1842 & ' - Return $sOutData•_WinHttp.au3'
	Return $sOutData
EndFunc

; #FUNCTION# ;===============================================================================
; Name...........: _WinHttpTimeFromSystemTime
; Description ...: Formats a system date and time according to the HTTP version 1.0 specification.
; Syntax.........: _WinHttpTimeFromSystemTime()
; Parameters ....: None.
; Return values .: Success - Returns time string.
;                  Failure - Returns empty string and sets @error:
;                  |1 - Initial DllCall failed
;                  |2 - Main DllCall failed
; Author ........: trancexx
; Related .......: _WinHttpTimeToSystemTime
; Link ..........: http://msdn.microsoft.com/en-us/library/aa384117.aspx
;============================================================================================
$__iLineNumber=1858 & ' - Func _WinHttpTimeFromSystemTime()•_WinHttp.au3'
Func _WinHttpTimeFromSystemTime()
	$__iLineNumber=1859 & ' - Local $SYSTEMTIME = DllStructCreate("word Year;" & _•_WinHttp.au3'
	Local $SYSTEMTIME = DllStructCreate("word Year;" & _
			"word Month;" & _
			"word DayOfWeek;" & _
			"word Day;" & _
			"word Hour;" & _
			"word Minute;" & _
			"word Second;" & _
			"word Milliseconds")
	$__iLineNumber=1867 & ' - DllCall("kernel32.dll", "none", "GetSystemTime", "struct*",  ...•_WinHttp.au3'
	DllCall("kernel32.dll", "none", "GetSystemTime", "struct*", $SYSTEMTIME)
	$__iLineNumber=1868 & ' - If @error Then Return SetError(1, 0, "")•_WinHttp.au3'
	If @error Then Return SetError(1, 0, "")
	$__iLineNumber=1869 & ' - Local $tTime = DllStructCreate("wchar[62]")•_WinHttp.au3'
	Local $tTime = DllStructCreate("wchar[62]")
	$__iLineNumber=1870 & ' - Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHt ...•_WinHttp.au3'
	Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHttpTimeFromSystemTime", "struct*", $SYSTEMTIME, "struct*", $tTime)
	$__iLineNumber=1871 & ' - If @error Or Not $aCall[0] Then Return SetError(2, 0, "")•_WinHttp.au3'
	If @error Or Not $aCall[0] Then Return SetError(2, 0, "")
	$__iLineNumber=1872 & ' - Return DllStructGetData($tTime, 1)•_WinHttp.au3'
	Return DllStructGetData($tTime, 1)
EndFunc

; #FUNCTION# ;===============================================================================
; Name...........: _WinHttpTimeToSystemTime
; Description ...: Takes an HTTP time/date string and converts it to array (SYSTEMTIME structure values).
; Syntax.........: _WinHttpTimeToSystemTime($sHttpTime)
; Parameters ....: $sHttpTime - Date/time string to convert.
; Return values .: Success - Returns array with 8 elements:
;                  |$array[0] - Year,
;                  |$array[1] - Month,
;                  |$array[2] - DayOfWeek,
;                  |$array[3] - Day,
;                  |$array[4] - Hour,
;                  |$array[5] - Minute,
;                  |$array[6] - Second.,
;                  |$array[7] - Milliseconds.
;                  Failure - Returns 0 and sets @error:
;                  |1 - DllCall failed
; Author ........: trancexx
; Related .......: _WinHttpTimeFromSystemTime
; Link ..........: http://msdn.microsoft.com/en-us/library/aa384118.aspx
;============================================================================================
$__iLineNumber=1895 & ' - Func _WinHttpTimeToSystemTime($sHttpTime)•_WinHttp.au3'
Func _WinHttpTimeToSystemTime($sHttpTime)
	$__iLineNumber=1896 & ' - Local $SYSTEMTIME = DllStructCreate("word Year;" & _•_WinHttp.au3'
	Local $SYSTEMTIME = DllStructCreate("word Year;" & _
			"word Month;" & _
			"word DayOfWeek;" & _
			"word Day;" & _
			"word Hour;" & _
			"word Minute;" & _
			"word Second;" & _
			"word Milliseconds")
	$__iLineNumber=1904 & ' - Local $tTime = DllStructCreate("wchar[62]")•_WinHttp.au3'
	Local $tTime = DllStructCreate("wchar[62]")
	$__iLineNumber=1905 & ' - DllStructSetData($tTime, 1, $sHttpTime)•_WinHttp.au3'
	DllStructSetData($tTime, 1, $sHttpTime)
	$__iLineNumber=1906 & ' - Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHt ...•_WinHttp.au3'
	Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHttpTimeToSystemTime", "struct*", $tTime, "struct*", $SYSTEMTIME)
	$__iLineNumber=1907 & ' - If @error Or Not $aCall[0] Then Return SetError(2, 0, 0)•_WinHttp.au3'
	If @error Or Not $aCall[0] Then Return SetError(2, 0, 0)
	$__iLineNumber=1908 & ' - Local $aRet[8] = [DllStructGetData($SYSTEMTIME, "Year"), _•_WinHttp.au3'
	Local $aRet[8] = [DllStructGetData($SYSTEMTIME, "Year"), _
			DllStructGetData($SYSTEMTIME, "Month"), _
			DllStructGetData($SYSTEMTIME, "DayOfWeek"), _
			DllStructGetData($SYSTEMTIME, "Day"), _
			DllStructGetData($SYSTEMTIME, "Hour"), _
			DllStructGetData($SYSTEMTIME, "Minute"), _
			DllStructGetData($SYSTEMTIME, "Second"), _
			DllStructGetData($SYSTEMTIME, "Milliseconds")]
	$__iLineNumber=1916 & ' - Return $aRet•_WinHttp.au3'
	Return $aRet
EndFunc

; #FUNCTION# ;===============================================================================
; Name...........: _WinHttpWriteData
; Description ...: Writes request data to an HTTP server.
; Syntax.........: _WinHttpWriteData($hRequest, $vData [, $iMode = Default ])
; Parameters ....: $hRequest - Valid handle returned by _WinHttpSendRequest().
;                  $vData - Data to write.
;                  $iMode - [optional] Integer representing writing mode. Default is 0 - write ANSI string.
; Return values .: Success - Returns 1
;                          - @extended receives the number of bytes written.
;                  Failure - Returns 0 and sets @error:
;                  |1 - DllCall failed
; Author ........: trancexx, ProgAndy
; Remarks .......: [[$vData]] variable is either string or binary data to write.
;                  [[$iMode]] can have these values:
;                  |[[0]] - to write ANSI string
;                  |[[1]] - to write binary data
; Related .......: _WinHttpSendRequest, _WinHttpReadData
; Link ..........: http://msdn.microsoft.com/en-us/library/aa384120.aspx
;============================================================================================
$__iLineNumber=1938 & ' - Func _WinHttpWriteData($hRequest, $vData, $iMode = Default)•_WinHttp.au3'
Func _WinHttpWriteData($hRequest, $vData, $iMode = Default)
	$__iLineNumber=1939 & ' - __WinHttpDefault($iMode, 0)•_WinHttp.au3'
	__WinHttpDefault($iMode, 0)
	$__iLineNumber=1940 & ' - Local $iNumberOfBytesToWrite, $tData•_WinHttp.au3'
	Local $iNumberOfBytesToWrite, $tData
	$__iLineNumber=1941 & ' - If $iMode = 1 Then•_WinHttp.au3'
	If $iMode = 1 Then
		$__iLineNumber=1942 & ' - $iNumberOfBytesToWrite = BinaryLen($vData)•_WinHttp.au3'
		$iNumberOfBytesToWrite = BinaryLen($vData)
		$__iLineNumber=1943 & ' - $tData = DllStructCreate("byte[" & $iNumberOfBytesToWrite &  ...•_WinHttp.au3'
		$tData = DllStructCreate("byte[" & $iNumberOfBytesToWrite & "]")
		$__iLineNumber=1944 & ' - DllStructSetData($tData, 1, $vData)•_WinHttp.au3'
		DllStructSetData($tData, 1, $vData)
	ElseIf IsDllStruct($vData) Then
		$__iLineNumber=1946 & ' - $iNumberOfBytesToWrite = DllStructGetSize($vData)•_WinHttp.au3'
		$iNumberOfBytesToWrite = DllStructGetSize($vData)
		$__iLineNumber=1947 & ' - $tData = $vData•_WinHttp.au3'
		$tData = $vData
	Else
		$__iLineNumber=1949 & ' - $iNumberOfBytesToWrite = StringLen($vData)•_WinHttp.au3'
		$iNumberOfBytesToWrite = StringLen($vData)
		$__iLineNumber=1950 & ' - $tData = DllStructCreate("char[" & $iNumberOfBytesToWrite +  ...•_WinHttp.au3'
		$tData = DllStructCreate("char[" & $iNumberOfBytesToWrite + 1 & "]")
		$__iLineNumber=1951 & ' - DllStructSetData($tData, 1, $vData)•_WinHttp.au3'
		DllStructSetData($tData, 1, $vData)
	EndIf
	$__iLineNumber=1953 & ' - Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHt ...•_WinHttp.au3'
	Local $aCall = DllCall($hWINHTTPDLL__WINHTTP, "bool", "WinHttpWriteData", _
			"handle", $hRequest, _
			"struct*", $tData, _
			"dword", $iNumberOfBytesToWrite, _
			"dword*", 0)
	$__iLineNumber=1958 & ' - If @error Or Not $aCall[0] Then Return SetError(1, 0, 0)•_WinHttp.au3'
	If @error Or Not $aCall[0] Then Return SetError(1, 0, 0)
	$__iLineNumber=1959 & ' - Return SetExtended($aCall[4], 1)•_WinHttp.au3'
	Return SetExtended($aCall[4], 1)
EndFunc


; #INTERNAL FUNCTIONS# ;=====================================================================
$__iLineNumber=1964 & ' - Func __WinHttpFileContent($sAccept, $sName, $sFileString, $s ...•_WinHttp.au3'
Func __WinHttpFileContent($sAccept, $sName, $sFileString, $sBoundaryMain = "")
	#forceref $sAccept ; FIXME: $sAccept is specified by the server (or left default). In case $sFileString is non-supported MIME type action should be aborted.
	$__iLineNumber=1966 & ' - Local $fNonStandard = False•_WinHttp.au3'
	Local $fNonStandard = False
	$__iLineNumber=1967 & ' - If StringLeft($sFileString, 10) = "PHP#50338:" Then•_WinHttp.au3'
	If StringLeft($sFileString, 10) = "PHP#50338:" Then
		$__iLineNumber=1968 & ' - $sFileString = StringTrimLeft($sFileString, 10)•_WinHttp.au3'
		$sFileString = StringTrimLeft($sFileString, 10)
		$__iLineNumber=1969 & ' - $fNonStandard = True•_WinHttp.au3'
		$fNonStandard = True
	EndIf
	$__iLineNumber=1971 & ' - Local $sOut = "Content-Disposition: form-data; name="" & $sN ...•_WinHttp.au3'
	Local $sOut = 'Content-Disposition: form-data; name="' & $sName & '"'
	$__iLineNumber=1972 & ' - If Not $sFileString Then Return $sOut & "; filename=""" & @C ...•_WinHttp.au3'
	If Not $sFileString Then Return $sOut & '; filename=""' & @CRLF & @CRLF & @CRLF
	; Check $sFileString string
	$__iLineNumber=1974 & ' - If StringRight($sFileString, 1) = "|" Then $sFileString = St ...•_WinHttp.au3'
	If StringRight($sFileString, 1) = "|" Then $sFileString = StringTrimRight($sFileString, 1)
	$__iLineNumber=1975 & ' - Local $aFiles = StringSplit($sFileString, "|", 2), $hFile•_WinHttp.au3'
	Local $aFiles = StringSplit($sFileString, "|", 2), $hFile
	$__iLineNumber=1976 & ' - If UBound($aFiles) = 1 Then•_WinHttp.au3'
	If UBound($aFiles) = 1 Then
		$__iLineNumber=1977 & ' - $hFile = FileOpen($aFiles[0], 16)•_WinHttp.au3'
		$hFile = FileOpen($aFiles[0], 16)
		$__iLineNumber=1978 & ' - $sOut &= "; filename="" & StringRegExpReplace($aFiles[0], ". ...•_WinHttp.au3'
		$sOut &= '; filename="' & StringRegExpReplace($aFiles[0], ".*\\", "") & '"' & @CRLF & _
				"Content-Type: " & __WinHttpMIMEType($aFiles[0]) & @CRLF & @CRLF & BinaryToString(FileRead($hFile), 1) & @CRLF
		$__iLineNumber=1980 & ' - FileClose($hFile)•_WinHttp.au3'
		FileClose($hFile)
		$__iLineNumber=1981 & ' - Return $sOut ; That"s it•_WinHttp.au3'
		Return $sOut ; That's it
	EndIf
	; Multiple files specified, separated by "|". Support on server side required!
	$__iLineNumber=1984 & ' - If $fNonStandard Then•_WinHttp.au3'
	If $fNonStandard Then
		; This way is forced by some browsers to avoid PHP's inability to parse multipart/mixed content
		$__iLineNumber=1986 & ' - $sOut = "" ; discharge•_WinHttp.au3'
		$sOut = "" ; discharge
		$__iLineNumber=1987 & ' - Local $iFiles = UBound($aFiles)•_WinHttp.au3'
		Local $iFiles = UBound($aFiles)
		$__iLineNumber=1988 & ' - For $i = 0 To $iFiles - 1•_WinHttp.au3'
		For $i = 0 To $iFiles - 1
			$__iLineNumber=1989 & ' - $hFile = FileOpen($aFiles[$i], 16)•_WinHttp.au3'
			$hFile = FileOpen($aFiles[$i], 16)
			$__iLineNumber=1990 & ' - $sOut &= "Content-Disposition: form-data; name="" & $sName & ...•_WinHttp.au3'
			$sOut &= 'Content-Disposition: form-data; name="' & $sName & '"' & _
					'; filename="' & StringRegExpReplace($aFiles[$i], ".*\\", "") & '"' & @CRLF & _
					"Content-Type: " & __WinHttpMIMEType($aFiles[$i]) & @CRLF & @CRLF & BinaryToString(FileRead($hFile), 1) & @CRLF
			$__iLineNumber=1993 & ' - FileClose($hFile)•_WinHttp.au3'
			FileClose($hFile)
			$__iLineNumber=1994 & ' - If $i < $iFiles - 1 Then $sOut &= "--" & $sBoundaryMain & @C ...•_WinHttp.au3'
			If $i < $iFiles - 1 Then $sOut &= "--" & $sBoundaryMain & @CRLF
		Next
	Else
		; RFC2388 ( http://www.ietf.org/rfc/rfc2388.txt )
		$__iLineNumber=1998 & ' - Local $sBoundary = StringFormat("%s%.5f", "----WinHttpSubBou ...•_WinHttp.au3'
		Local $sBoundary = StringFormat("%s%.5f", "----WinHttpSubBoundaryLine_", Random(10000, 99999))
		$__iLineNumber=1999 & ' - $sOut &= @CRLF & "Content-Type: multipart/mixed; boundary="  ...•_WinHttp.au3'
		$sOut &= @CRLF & "Content-Type: multipart/mixed; boundary=" & $sBoundary & @CRLF & @CRLF
		$__iLineNumber=2000 & ' - For $i = 0 To UBound($aFiles) - 1•_WinHttp.au3'
		For $i = 0 To UBound($aFiles) - 1
			$__iLineNumber=2001 & ' - $hFile = FileOpen($aFiles[$i], 16)•_WinHttp.au3'
			$hFile = FileOpen($aFiles[$i], 16)
			$__iLineNumber=2002 & ' - $sOut &= "--" & $sBoundary & @CRLF & _•_WinHttp.au3'
			$sOut &= "--" & $sBoundary & @CRLF & _
					'Content-Disposition: file; filename="' & StringRegExpReplace($aFiles[$i], ".*\\", "") & '"' & @CRLF & _
					"Content-Type: " & __WinHttpMIMEType($aFiles[$i]) & @CRLF & @CRLF & BinaryToString(FileRead($hFile), 1) & @CRLF
			$__iLineNumber=2005 & ' - FileClose($hFile)•_WinHttp.au3'
			FileClose($hFile)
		Next
		$__iLineNumber=2007 & ' - $sOut &= "--" & $sBoundary & "--" & @CRLF•_WinHttp.au3'
		$sOut &= "--" & $sBoundary & "--" & @CRLF
	EndIf
	$__iLineNumber=2009 & ' - Return $sOut•_WinHttp.au3'
	Return $sOut
EndFunc

$__iLineNumber=2012 & ' - Func __WinHttpMIMEType($sFileName)•_WinHttp.au3'
Func __WinHttpMIMEType($sFileName)
	$__iLineNumber=2013 & ' - Local $aArray = StringRegExp(__WinHttpMIMEAssocString(), "(? ...•_WinHttp.au3'
	Local $aArray = StringRegExp(__WinHttpMIMEAssocString(), "(?i)\Q;" & StringRegExpReplace($sFileName, ".*\.", "") & "\E\|(.*?);", 3)
	$__iLineNumber=2014 & ' - If @error Then Return "application/octet-stream"•_WinHttp.au3'
	If @error Then Return "application/octet-stream"
	$__iLineNumber=2015 & ' - Return $aArray[0]•_WinHttp.au3'
	Return $aArray[0]
EndFunc

$__iLineNumber=2018 & ' - Func __WinHttpMIMEAssocString()•_WinHttp.au3'
Func __WinHttpMIMEAssocString()
	$__iLineNumber=2019 & ' - Return ";ai|application/postscript;aif|audio/x-aiff;aifc|aud ...•_WinHttp.au3'
	Return ";ai|application/postscript;aif|audio/x-aiff;aifc|audio/x-aiff;aiff|audio/x-aiff;asc|text/plain;atom|application/atom+xml;au|audio/basic;avi|video/x-msvideo;bcpio|application/x-bcpio;bin|application/octet-stream;bmp|image/bmp;cdf|application/x-netcdf;cgm|image/cgm;class|application/octet-stream;cpio|application/x-cpio;cpt|application/mac-compactpro;csh|application/x-csh;css|text/css;dcr|application/x-director;dif|video/x-dv;dir|application/x-director;djv|image/vnd.djvu;djvu|image/vnd.djvu;dll|application/octet-stream;dmg|application/octet-stream;dms|application/octet-stream;doc|application/msword;dtd|application/xml-dtd;dv|video/x-dv;dvi|application/x-dvi;dxr|application/x-director;eps|application/postscript;etx|text/x-setext;exe|application/octet-stream;ez|application/andrew-inset;gif|image/gif;gram|application/srgs;grxml|application/srgs+xml;gtar|application/x-gtar;hdf|application/x-hdf;hqx|application/mac-binhex40;htm|text/html;html|text/html;ice|x-conference/x-cooltalk;ico|image/x-icon;ics|text/calendar;ief|image/ief;ifb|text/calendar;iges|model/iges;igs|model/iges;jnlp|application/x-java-jnlp-file;jp2|image/jp2;jpe|image/jpeg;jpeg|image/jpeg;jpg|image/jpeg;js|application/x-javascript;kar|audio/midi;latex|application/x-latex;lha|application/octet-stream;lzh|application/octet-stream;m3u|audio/x-mpegurl;m4a|audio/mp4a-latm;m4b|audio/mp4a-latm;m4p|audio/mp4a-latm;m4u|video/vnd.mpegurl;m4v|video/x-m4v;mac|image/x-macpaint;man|application/x-troff-man;mathml|application/mathml+xml;me|application/x-troff-me;mesh|model/mesh;mid|audio/midi;midi|audio/midi;mif|application/vnd.mif;mov|video/quicktime;movie|video/x-sgi-movie;mp2|audio/mpeg;mp3|audio/mpeg;mp4|video/mp4;mpe|video/mpeg;mpeg|video/mpeg;mpg|video/mpeg;mpga|audio/mpeg;ms|application/x-troff-ms;msh|model/mesh;mxu|video/vnd.mpegurl;nc|application/x-netcdf;oda|application/oda;ogg|application/ogg;pbm|image/x-portable-bitmap;pct|image/pict;pdb|chemical/x-pdb;pdf|application/pdf;pgm|image/x-portable-graymap;pgn|application/x-chess-pgn;pic|image/pict;pict|image/pict;png|image/png;pnm|image/x-portable-anymap;pnt|image/x-macpaint;pntg|image/x-macpaint;ppm|image/x-portable-pixmap;ppt|application/vnd.ms-powerpoint;ps|application/postscript;qt|video/quicktime;qti|image/x-quicktime;qtif|image/x-quicktime;ra|audio/x-pn-realaudio;ram|audio/x-pn-realaudio;ras|image/x-cmu-raster;rdf|application/rdf+xml;rgb|image/x-rgb;rm|application/vnd.rn-realmedia;roff|application/x-troff;rtf|text/rtf;rtx|text/richtext;sgm|text/sgml;sgml|text/sgml;sh|application/x-sh;shar|application/x-shar;silo|model/mesh;sit|application/x-stuffit;skd|application/x-koan;skm|application/x-koan;skp|application/x-koan;skt|application/x-koan;smi|application/smil;smil|application/smil;snd|audio/basic;so|application/octet-stream;spl|application/x-futuresplash;src|application/x-wais-source;sv4cpio|application/x-sv4cpio;sv4crc|application/x-sv4crc;svg|image/svg+xml;swf|application/x-shockwave-flash;t|application/x-troff;tar|application/x-tar;tcl|application/x-tcl;tex|application/x-tex;texi|application/x-texinfo;texinfo|application/x-texinfo;tif|image/tiff;tiff|image/tiff;tr|application/x-troff;tsv|text/tab-separated-values;txt|text/plain;ustar|application/x-ustar;vcd|application/x-cdlink;vrml|model/vrml;vxml|application/voicexml+xml;wav|audio/x-wav;wbmp|image/vnd.wap.wbmp;wbmxl|application/vnd.wap.wbxml;wml|text/vnd.wap.wml;wmlc|application/vnd.wap.wmlc;wmls|text/vnd.wap.wmlscript;wmlsc|application/vnd.wap.wmlscriptc;wrl|model/vrml;xbm|image/x-xbitmap;xht|application/xhtml+xml;xhtml|application/xhtml+xml;xls|application/vnd.ms-excel;xml|application/xml;xpm|image/x-xpixmap;xsl|application/xml;xslt|application/xslt+xml;xul|application/vnd.mozilla.xul+xml;xwd|image/x-xwindowdump;xyz|chemical/x-xyz;zip|application/zip;"
EndFunc

$__iLineNumber=2022 & ' - Func __WinHttpCharSet($sContentType)•_WinHttp.au3'
Func __WinHttpCharSet($sContentType)
	$__iLineNumber=2023 & ' - Local $aContentType = StringRegExp($sContentType, "(?i).*?\Q ...•_WinHttp.au3'
	Local $aContentType = StringRegExp($sContentType, "(?i).*?\Qcharset=\E(?U)([^ ]+)(;| |\Z)", 2)
	$__iLineNumber=2024 & ' - If Not @error Then $sContentType = $aContentType[1]•_WinHttp.au3'
	If Not @error Then $sContentType = $aContentType[1]
	$__iLineNumber=2025 & ' - If StringLeft($sContentType, 2) = "cp" Then Return Int(Strin ...•_WinHttp.au3'
	If StringLeft($sContentType, 2) = "cp" Then Return Int(StringTrimLeft($sContentType, 2))
	$__iLineNumber=2026 & ' - If $sContentType = "utf-8" Then Return 65001•_WinHttp.au3'
	If $sContentType = "utf-8" Then Return 65001
EndFunc

$__iLineNumber=2029 & ' - Func __WinHttpURLEncode($vData, $sEncType = "")•_WinHttp.au3'
Func __WinHttpURLEncode($vData, $sEncType = "")
	$__iLineNumber=2030 & ' - If IsBool($vData) Then Return $vData•_WinHttp.au3'
	If IsBool($vData) Then Return $vData
	$__iLineNumber=2031 & ' - $vData = __WinHttpHTMLDecode($vData)•_WinHttp.au3'
	$vData = __WinHttpHTMLDecode($vData)
	$__iLineNumber=2032 & ' - If $sEnctype = "text/plain" Then Return StringReplace($vData ...•_WinHttp.au3'
	If $sEnctype = "text/plain" Then Return StringReplace($vData, " ", "+")
	$__iLineNumber=2033 & ' - Local $aData = StringToASCIIArray($vData, Default, Default,  ...•_WinHttp.au3'
	Local $aData = StringToASCIIArray($vData, Default, Default, 2)
	$__iLineNumber=2034 & ' - Local $sOut•_WinHttp.au3'
	Local $sOut
	$__iLineNumber=2035 & ' - For $i = 0 To UBound($aData) - 1•_WinHttp.au3'
	For $i = 0 To UBound($aData) - 1
		$__iLineNumber=2036 & ' - Switch $aData[$i]•_WinHttp.au3'
		$__iLineNumber=2037 & ' - Case 45, 46, 48 To 57, 65 To 90, 95, 97 To 122, 126•_WinHttp.au3'
		Switch $aData[$i]
			Case 45, 46, 48 To 57, 65 To 90, 95, 97 To 122, 126
				$__iLineNumber=2038 & ' - $sOut &= Chr($aData[$i])•_WinHttp.au3'
				$sOut &= Chr($aData[$i])
			$__iLineNumber=2039 & ' - Case 32•_WinHttp.au3'
			Case 32
				$__iLineNumber=2040 & ' - $sOut &= "+"•_WinHttp.au3'
				$sOut &= "+"
			Case Else
				$__iLineNumber=2042 & ' - $sOut &= "%" & Hex($aData[$i], 2)•_WinHttp.au3'
				$sOut &= "%" & Hex($aData[$i], 2)
		EndSwitch
	Next
	$__iLineNumber=2045 & ' - Return $sOut•_WinHttp.au3'
	Return $sOut
EndFunc

$__iLineNumber=2048 & ' - Func __WinHttpHTMLDecode($vData)•_WinHttp.au3'
Func __WinHttpHTMLDecode($vData)
	$__iLineNumber=2049 & ' - Return StringReplace(StringReplace(StringReplace(StringRepla ...•_WinHttp.au3'
	Return StringReplace(StringReplace(StringReplace(StringReplace($vData, "&amp;", "&"), "&lt;", "<"), "&gt;", ">"), "&quot;", '"')
EndFunc

$__iLineNumber=2052 & ' - Func __WinHttpNormalizeActionURL($sActionPage, ByRef $sActio ...•_WinHttp.au3'
Func __WinHttpNormalizeActionURL($sActionPage, ByRef $sAction, ByRef $iScheme, ByRef $sNewURL, ByRef $sEnctype, ByRef $sMethod, $sURL = "")
	$__iLineNumber=2053 & ' - Local $aCrackURL = _WinHttpCrackUrl($sAction)•_WinHttp.au3'
	Local $aCrackURL = _WinHttpCrackUrl($sAction)
	$__iLineNumber=2054 & ' - If @error Then•_WinHttp.au3'
	If @error Then
		$__iLineNumber=2055 & ' - If $sAction Then•_WinHttp.au3'
		If $sAction Then
			$__iLineNumber=2056 & ' - If StringLeft($sAction, 2) = "//" Then•_WinHttp.au3'
			If StringLeft($sAction, 2) = "//" Then
				$__iLineNumber=2057 & ' - $aCrackURL = _WinHttpCrackUrl($sURL)•_WinHttp.au3'
				$aCrackURL = _WinHttpCrackUrl($sURL)
				$__iLineNumber=2058 & ' - If Not @error Then•_WinHttp.au3'
				If Not @error Then
					$__iLineNumber=2059 & ' - $aCrackURL = _WinHttpCrackUrl($aCrackURL[0] & ":" & $sAction ...•_WinHttp.au3'
					$aCrackURL = _WinHttpCrackUrl($aCrackURL[0] & ":" & $sAction)
					$__iLineNumber=2060 & ' - If Not @error Then•_WinHttp.au3'
					If Not @error Then
						$__iLineNumber=2061 & ' - $sNewURL = $aCrackURL[0] & "://" & $aCrackURL[2] & ":" & $aC ...•_WinHttp.au3'
						$sNewURL = $aCrackURL[0] & "://" & $aCrackURL[2] & ":" & $aCrackURL[3]
						$__iLineNumber=2062 & ' - $iScheme = $aCrackURL[1]•_WinHttp.au3'
						$iScheme = $aCrackURL[1]
						$__iLineNumber=2063 & ' - $sAction = $aCrackURL[6] & $aCrackURL[7]•_WinHttp.au3'
						$sAction = $aCrackURL[6] & $aCrackURL[7]
						$__iLineNumber=2064 & ' - $sActionPage = ""•_WinHttp.au3'
						$sActionPage = ""
					EndIf
				EndIf
			ElseIf StringLeft($sAction, 1) = "?" Then
				$__iLineNumber=2068 & ' - $aCrackURL = _WinHttpCrackUrl($sURL)•_WinHttp.au3'
				$aCrackURL = _WinHttpCrackUrl($sURL)
				$__iLineNumber=2069 & ' - $sAction = $aCrackURL[6] & $sAction•_WinHttp.au3'
				$sAction = $aCrackURL[6] & $sAction
			ElseIf StringLeft($sAction, 1) = "#" Then
				$__iLineNumber=2071 & ' - $sAction = StringReplace($sActionPage, StringRegExpReplace($ ...•_WinHttp.au3'
				$sAction = StringReplace($sActionPage, StringRegExpReplace($sActionPage, "(.*?)(#.*?)", "$2"), $sAction)
			ElseIf StringLeft($sAction, 1) <> "/" Then
					$__iLineNumber=2073 & ' - Local $sCurrent•_WinHttp.au3'
					Local $sCurrent
					$__iLineNumber=2074 & ' - Local $aURL = StringRegExp($sActionPage, "(.*)/", 3)•_WinHttp.au3'
					Local $aURL = StringRegExp($sActionPage, '(.*)/', 3)
					$__iLineNumber=2075 & ' - If Not @error Then $sCurrent = $aURL[0]•_WinHttp.au3'
					If Not @error Then $sCurrent = $aURL[0]
					$__iLineNumber=2076 & ' - If $sCurrent Then $sAction = $sCurrent & "/" & $sAction•_WinHttp.au3'
					If $sCurrent Then $sAction = $sCurrent & "/" & $sAction
			EndIf
			$__iLineNumber=2078 & ' - If StringLeft($sAction, 1) = "?" Then $sAction = $sActionPag ...•_WinHttp.au3'
			If StringLeft($sAction, 1) = "?" Then $sAction = $sActionPage & $sAction
		EndIf
		$__iLineNumber=2080 & ' - If Not $sAction Then $sAction = $sActionPage•_WinHttp.au3'
		If Not $sAction Then $sAction = $sActionPage
		$__iLineNumber=2081 & ' - $sAction = StringRegExpReplace($sAction, "\A(/*\.\./)*", "") ...•_WinHttp.au3'
		$sAction = StringRegExpReplace($sAction, "\A(/*\.\./)*", "") ; /../
	Else
		$__iLineNumber=2083 & ' - $iScheme = $aCrackURL[1]•_WinHttp.au3'
		$iScheme = $aCrackURL[1]
		$__iLineNumber=2084 & ' - $sNewURL = $aCrackURL[0] & "://" & $aCrackURL[2] & ":" & $aC ...•_WinHttp.au3'
		$sNewURL = $aCrackURL[0] & "://" & $aCrackURL[2] & ":" & $aCrackURL[3]
		$__iLineNumber=2085 & ' - $sAction = $aCrackURL[6] & $aCrackURL[7]•_WinHttp.au3'
		$sAction = $aCrackURL[6] & $aCrackURL[7]
	EndIf
	$__iLineNumber=2087 & ' - If Not $sMethod Then $sMethod = "GET"•_WinHttp.au3'
	If Not $sMethod Then $sMethod = "GET"
	$__iLineNumber=2088 & ' - If $sMethod = "GET" Then $sEnctype = ""•_WinHttp.au3'
	If $sMethod = "GET" Then $sEnctype = ""
EndFunc

$__iLineNumber=2091 & ' - Func __WinHttpHTML5FormAttribs(ByRef $aDtas, ByRef $aFlds, B ...•_WinHttp.au3'
Func __WinHttpHTML5FormAttribs(ByRef $aDtas, ByRef $aFlds, ByRef $iNumParams, ByRef $aInput, ByRef $sAction, ByRef $sEnctype, ByRef $sMethod)
	; Clicking "submit" is done using:
	; "type:submit", zero_based_index_of_the_submit_button
	; "name:whatever", True
	; "id:whatever", True
	; "whatever", True     ;<- same as "id:whatever"
	; Clicking "image" is done using:
	; "type:image", "zero_based_index_of_the_image_control Xcoord,Ycoord"
	; "name:whatever", "Xcoord,Ycoord"
	; "id:whatever", "Xcoord,Ycoord"
	; "whatever", "Xcoord,Ycoord"     ;<- same as "id:whatever"
	$__iLineNumber=2102 & ' - Local $aSpl, $iSubmitHTML5 = 0, $iInpSubm, $sImgAppx = "."•_WinHttp.au3'
	Local $aSpl, $iSubmitHTML5 = 0, $iInpSubm, $sImgAppx = "."
	$__iLineNumber=2103 & ' - For $k = 1 To $iNumParams•_WinHttp.au3'
	For $k = 1 To $iNumParams
		$__iLineNumber=2104 & ' - $aSpl = StringSplit($aFlds[$k], ":", 2)•_WinHttp.au3'
		$aSpl = StringSplit($aFlds[$k], ":", 2)
		$__iLineNumber=2105 & ' - If $aSpl[0] = "type" And ($aSpl[1] = "submit" Or $aSpl[1] =  ...•_WinHttp.au3'
		If $aSpl[0] = "type" And ($aSpl[1] = "submit" Or $aSpl[1] = "image") Then
			$__iLineNumber=2106 & ' - Local $iSubmIndex = $aDtas[$k], $iSubmCur = 0, $iImgCur = 0, ...•_WinHttp.au3'
			Local $iSubmIndex = $aDtas[$k], $iSubmCur = 0, $iImgCur = 0, $sType, $sInpNme
			$__iLineNumber=2107 & ' - If $aSpl[1] = "image" Then•_WinHttp.au3'
			If $aSpl[1] = "image" Then
				$__iLineNumber=2108 & ' - $iSubmIndex = Int($aDtas[$k])•_WinHttp.au3'
				$iSubmIndex = Int($aDtas[$k])
			EndIf
			$__iLineNumber=2110 & ' - For $i = 0 To UBound($aInput) - 1 ; for all input elements•_WinHttp.au3'
			For $i = 0 To UBound($aInput) - 1 ; for all input elements
				$__iLineNumber=2111 & ' - Switch __WinHttpAttribVal($aInput[$i], "type")•_WinHttp.au3'
				$__iLineNumber=2112 & ' - Case "submit"•_WinHttp.au3'
				Switch __WinHttpAttribVal($aInput[$i], "type")
					Case "submit"
						$__iLineNumber=2113 & ' - If $iSubmCur = $iSubmIndex Then•_WinHttp.au3'
						If $iSubmCur = $iSubmIndex Then
							$__iLineNumber=2114 & ' - $iSubmitHTML5 = 1•_WinHttp.au3'
							$iSubmitHTML5 = 1
							$__iLineNumber=2115 & ' - $iInpSubm = $i•_WinHttp.au3'
							$iInpSubm = $i
							ExitLoop 2
						EndIf
						$__iLineNumber=2118 & ' - $iSubmCur += 1•_WinHttp.au3'
						$iSubmCur += 1
					$__iLineNumber=2119 & ' - Case "image"•_WinHttp.au3'
					Case "image"
						$__iLineNumber=2120 & ' - If $iImgCur = $iSubmIndex Then•_WinHttp.au3'
						If $iImgCur = $iSubmIndex Then
							$__iLineNumber=2121 & ' - $iSubmitHTML5 = 1•_WinHttp.au3'
							$iSubmitHTML5 = 1
							$__iLineNumber=2122 & ' - $iInpSubm = $i•_WinHttp.au3'
							$iInpSubm = $i
							$__iLineNumber=2123 & ' - $sInpNme = __WinHttpAttribVal($aInput[$iInpSubm], "name")•_WinHttp.au3'
							$sInpNme = __WinHttpAttribVal($aInput[$iInpSubm], "name")
							$__iLineNumber=2124 & ' - If $sInpNme Then $sInpNme &= $sImgAppx•_WinHttp.au3'
							If $sInpNme Then $sInpNme &= $sImgAppx
							$__iLineNumber=2125 & ' - $aInput[$iInpSubm] = "type="image" formaction="" & __WinHttp ...•_WinHttp.au3'
							$aInput[$iInpSubm] = 'type="image" formaction="' & __WinHttpAttribVal($aInput[$iInpSubm], "formaction") & '" formenctype="' & __WinHttpAttribVal($aInput[$iInpSubm], "formenctype") & '" formmethod="' & __WinHttpAttribVal($aInput[$iInpSubm], "formmethod") & '"'
							$__iLineNumber=2126 & ' - Local $sX = 0, $sY = 0•_WinHttp.au3'
							Local $sX = 0, $sY = 0
							$__iLineNumber=2127 & ' - $iX = Int(StringRegExpReplace($aDtas[$k], "(\d+)\h*(\d+),(\d ...•_WinHttp.au3'
							$iX = Int(StringRegExpReplace($aDtas[$k], "(\d+)\h*(\d+),(\d+)", "$2", 1))
							$__iLineNumber=2128 & ' - $iY = Int(StringRegExpReplace($aDtas[$k], "(\d+)\h*(\d+),(\d ...•_WinHttp.au3'
							$iY = Int(StringRegExpReplace($aDtas[$k], "(\d+)\h*(\d+),(\d+)", "$3", 1))
							$__iLineNumber=2129 & ' - ReDim $aInput[UBound($aInput) + 2]•_WinHttp.au3'
							ReDim $aInput[UBound($aInput) + 2]
							$__iLineNumber=2130 & ' - $aInput[UBound($aInput) - 2] = "type="image" name="" & $sInp ...•_WinHttp.au3'
							$aInput[UBound($aInput) - 2] = 'type="image" name="' & $sInpNme & 'x" value="' & $iX & '"'
							$__iLineNumber=2131 & ' - $aInput[UBound($aInput) - 1] = "type="image" name="" & $sInp ...•_WinHttp.au3'
							$aInput[UBound($aInput) - 1] = 'type="image" name="' & $sInpNme & 'y" value="' & $iY & '"'
							ExitLoop 2
						EndIf
						$__iLineNumber=2134 & ' - $iImgCur += 1•_WinHttp.au3'
						$iImgCur += 1
				EndSwitch
			Next
			ElseIf $aSpl[0] = "name" Then
			$__iLineNumber=2138 & ' - Local $sInpNme = $aSpl[1], $sType•_WinHttp.au3'
			Local $sInpNme = $aSpl[1], $sType
			$__iLineNumber=2139 & ' - For $i = 0 To UBound($aInput) - 1 ; for all input elements•_WinHttp.au3'
			For $i = 0 To UBound($aInput) - 1 ; for all input elements
				$__iLineNumber=2140 & ' - $sType = __WinHttpAttribVal($aInput[$i], "type")•_WinHttp.au3'
				$sType = __WinHttpAttribVal($aInput[$i], "type")
				$__iLineNumber=2141 & ' - If $sType = "submit" Then•_WinHttp.au3'
				If $sType = "submit" Then
					$__iLineNumber=2142 & ' - If __WinHttpAttribVal($aInput[$i], "name") = $sInpNme And $a ...•_WinHttp.au3'
					If __WinHttpAttribVal($aInput[$i], "name") = $sInpNme And $aDtas[$k] = True Then
						$__iLineNumber=2143 & ' - $iSubmitHTML5 = 1•_WinHttp.au3'
						$iSubmitHTML5 = 1
						$__iLineNumber=2144 & ' - $iInpSubm = $i•_WinHttp.au3'
						$iInpSubm = $i
						ExitLoop 2
					EndIf
				ElseIf $sType = "image" Then
					$__iLineNumber=2148 & ' - If __WinHttpAttribVal($aInput[$i], "name") = $sInpNme And $a ...•_WinHttp.au3'
					If __WinHttpAttribVal($aInput[$i], "name") = $sInpNme And $aDtas[$k] Then
						$__iLineNumber=2149 & ' - $iSubmitHTML5 = 1•_WinHttp.au3'
						$iSubmitHTML5 = 1
						$__iLineNumber=2150 & ' - $iInpSubm = $i•_WinHttp.au3'
						$iInpSubm = $i
						$__iLineNumber=2151 & ' - Local $aStrSplit = StringSplit($aDtas[$k], ",", 3), $iX = 0, ...•_WinHttp.au3'
						Local $aStrSplit = StringSplit($aDtas[$k], ",", 3), $iX = 0, $iY = 0
						$__iLineNumber=2152 & ' - If Not @error Then•_WinHttp.au3'
						If Not @error Then
							$__iLineNumber=2153 & ' - $iX = Int($aStrSplit[0])•_WinHttp.au3'
							$iX = Int($aStrSplit[0])
							$__iLineNumber=2154 & ' - $iY = Int($aStrSplit[1])•_WinHttp.au3'
							$iY = Int($aStrSplit[1])
						EndIf
						$__iLineNumber=2156 & ' - $aInput[$iInpSubm] = "type="image" formaction="" & __WinHttp ...•_WinHttp.au3'
						$aInput[$iInpSubm] = 'type="image" formaction="' & __WinHttpAttribVal($aInput[$iInpSubm], "formaction") & '" formenctype="' & __WinHttpAttribVal($aInput[$iInpSubm], "formenctype") & '" formmethod="' & __WinHttpAttribVal($aInput[$iInpSubm], "formmethod") & '"'
						$__iLineNumber=2157 & ' - $sInpNme &= $sImgAppx•_WinHttp.au3'
						$sInpNme &= $sImgAppx
						$__iLineNumber=2158 & ' - ReDim $aInput[UBound($aInput) + 2]•_WinHttp.au3'
						ReDim $aInput[UBound($aInput) + 2]
						$__iLineNumber=2159 & ' - $aInput[UBound($aInput) - 2] = "type="image" name="" & $sInp ...•_WinHttp.au3'
						$aInput[UBound($aInput) - 2] = 'type="image" name="' & $sInpNme & 'x" value="' & $iX & '"'
						$__iLineNumber=2160 & ' - $aInput[UBound($aInput) - 1] = "type="image" name="" & $sInp ...•_WinHttp.au3'
						$aInput[UBound($aInput) - 1] = 'type="image" name="' & $sInpNme & 'y" value="' & $iY & '"'
						ExitLoop 2
					EndIf
				EndIf
			Next
		Else ; id
			$__iLineNumber=2166 & ' - Local $sInpId, $sType•_WinHttp.au3'
			Local $sInpId, $sType
			$__iLineNumber=2167 & ' - If @error Then•_WinHttp.au3'
			If @error Then
				$__iLineNumber=2168 & ' - $sInpId = $aSpl[0]•_WinHttp.au3'
				$sInpId = $aSpl[0]
			ElseIf $aSpl[0] = "id" Then
				$__iLineNumber=2170 & ' - $sInpId = $aSpl[1]•_WinHttp.au3'
				$sInpId = $aSpl[1]
			EndIf
			$__iLineNumber=2172 & ' - For $i = 0 To UBound($aInput) - 1 ; for all input elements•_WinHttp.au3'
			For $i = 0 To UBound($aInput) - 1 ; for all input elements
				$__iLineNumber=2173 & ' - $sType = __WinHttpAttribVal($aInput[$i], "type")•_WinHttp.au3'
				$sType = __WinHttpAttribVal($aInput[$i], "type")
				$__iLineNumber=2174 & ' - If $sType = "submit" Then•_WinHttp.au3'
				If $sType = "submit" Then
					$__iLineNumber=2175 & ' - If __WinHttpAttribVal($aInput[$i], "id") = $sInpId And $aDta ...•_WinHttp.au3'
					If __WinHttpAttribVal($aInput[$i], "id") = $sInpId And $aDtas[$k] = True Then
						$__iLineNumber=2176 & ' - $iSubmitHTML5 = 1•_WinHttp.au3'
						$iSubmitHTML5 = 1
						$__iLineNumber=2177 & ' - $iInpSubm = $i•_WinHttp.au3'
						$iInpSubm = $i
						ExitLoop 2
					EndIf
				ElseIf $sType = "image" Then
					$__iLineNumber=2181 & ' - If __WinHttpAttribVal($aInput[$i], "id") = $sInpId And $aDta ...•_WinHttp.au3'
					If __WinHttpAttribVal($aInput[$i], "id") = $sInpId And $aDtas[$k] Then
						$__iLineNumber=2182 & ' - $iSubmitHTML5 = 1•_WinHttp.au3'
						$iSubmitHTML5 = 1
						$__iLineNumber=2183 & ' - $iInpSubm = $i•_WinHttp.au3'
						$iInpSubm = $i
						$__iLineNumber=2184 & ' - Local $sInpNme = __WinHttpAttribVal($aInput[$iInpSubm], "nam ...•_WinHttp.au3'
						Local $sInpNme = __WinHttpAttribVal($aInput[$iInpSubm], "name")
						$__iLineNumber=2185 & ' - If $sInpNme Then $sInpNme &= $sImgAppx•_WinHttp.au3'
						If $sInpNme Then $sInpNme &= $sImgAppx
						$__iLineNumber=2186 & ' - Local $aStrSplit = StringSplit($aDtas[$k], ",", 3), $iX = 0, ...•_WinHttp.au3'
						Local $aStrSplit = StringSplit($aDtas[$k], ",", 3), $iX = 0, $iY = 0
						$__iLineNumber=2187 & ' - If Not @error Then•_WinHttp.au3'
						If Not @error Then
							$__iLineNumber=2188 & ' - $iX = Int($aStrSplit[0])•_WinHttp.au3'
							$iX = Int($aStrSplit[0])
							$__iLineNumber=2189 & ' - $iY = Int($aStrSplit[1])•_WinHttp.au3'
							$iY = Int($aStrSplit[1])
						EndIf
						$__iLineNumber=2191 & ' - $aInput[$iInpSubm] = "type="image" formaction="" & __WinHttp ...•_WinHttp.au3'
						$aInput[$iInpSubm] = 'type="image" formaction="' & __WinHttpAttribVal($aInput[$iInpSubm], "formaction") & '" formenctype="' & __WinHttpAttribVal($aInput[$iInpSubm], "formenctype") & '" formmethod="' & __WinHttpAttribVal($aInput[$iInpSubm], "formmethod") & '"'
						$__iLineNumber=2192 & ' - ReDim $aInput[UBound($aInput) + 2]•_WinHttp.au3'
						ReDim $aInput[UBound($aInput) + 2]
						$__iLineNumber=2193 & ' - $aInput[UBound($aInput) - 2] = "type="image" name="" & $sInp ...•_WinHttp.au3'
						$aInput[UBound($aInput) - 2] = 'type="image" name="' & $sInpNme & 'x" value="' & $iX & '"'
						$__iLineNumber=2194 & ' - $aInput[UBound($aInput) - 1] = "type="image" name="" & $sInp ...•_WinHttp.au3'
						$aInput[UBound($aInput) - 1] = 'type="image" name="' & $sInpNme & 'y" value="' & $iY & '"'
						ExitLoop 2
					EndIf
				EndIf
			Next
		EndIf
	Next
	$__iLineNumber=2201 & ' - If $iSubmitHTML5 Then•_WinHttp.au3'
	If $iSubmitHTML5 Then
		$__iLineNumber=2202 & ' - Local $iUbound = UBound($aInput) - 1•_WinHttp.au3'
		Local $iUbound = UBound($aInput) - 1
		$__iLineNumber=2203 & ' - If __WinHttpAttribVal($aInput[$iInpSubm], "type") = "image"  ...•_WinHttp.au3'
		If __WinHttpAttribVal($aInput[$iInpSubm], "type") = "image" Then $iUbound -= 2 ; two form fields are added for "image"
		$__iLineNumber=2204 & ' - For $j = 0 To $iUbound ; for all other input elements•_WinHttp.au3'
		For $j = 0 To $iUbound ; for all other input elements
			$__iLineNumber=2205 & ' - If $j = $iInpSubm Then ContinueLoop•_WinHttp.au3'
			If $j = $iInpSubm Then ContinueLoop
			$__iLineNumber=2206 & ' - Switch __WinHttpAttribVal($aInput[$j], "type")•_WinHttp.au3'
			$__iLineNumber=2207 & ' - Case "submit", "image"•_WinHttp.au3'
			Switch __WinHttpAttribVal($aInput[$j], "type")
				Case "submit", "image"
					$__iLineNumber=2208 & ' - $aInput[$j] = "" ; remove any other submit/image controls•_WinHttp.au3'
					$aInput[$j] = "" ; remove any other submit/image controls
			EndSwitch
		Next
		$__iLineNumber=2211 & ' - Local $sAttr = __WinHttpAttribVal($aInput[$iInpSubm], "forma ...•_WinHttp.au3'
		Local $sAttr = __WinHttpAttribVal($aInput[$iInpSubm], "formaction")
		$__iLineNumber=2212 & ' - If $sAttr Then $sAction = $sAttr•_WinHttp.au3'
		If $sAttr Then $sAction = $sAttr
		$__iLineNumber=2213 & ' - $sAttr = __WinHttpAttribVal($aInput[$iInpSubm], "formenctype ...•_WinHttp.au3'
		$sAttr = __WinHttpAttribVal($aInput[$iInpSubm], "formenctype")
		$__iLineNumber=2214 & ' - If $sAttr Then $sEnctype = $sAttr•_WinHttp.au3'
		If $sAttr Then $sEnctype = $sAttr
		$__iLineNumber=2215 & ' - $sAttr = __WinHttpAttribVal($aInput[$iInpSubm], "formmethod" ...•_WinHttp.au3'
		$sAttr = __WinHttpAttribVal($aInput[$iInpSubm], "formmethod")
		$__iLineNumber=2216 & ' - If $sAttr Then $sMethod = $sAttr•_WinHttp.au3'
		If $sAttr Then $sMethod = $sAttr
		$__iLineNumber=2217 & ' - If __WinHttpAttribVal($aInput[$iInpSubm], "type") = "image"  ...•_WinHttp.au3'
		If __WinHttpAttribVal($aInput[$iInpSubm], "type") = "image" Then $aInput[$iInpSubm] = ""
	EndIf
EndFunc

$__iLineNumber=2221 & ' - Func __WinHttpNormalizeForm(ByRef $sForm, $sSpr1, $sSpr2)•_WinHttp.au3'
Func __WinHttpNormalizeForm(ByRef $sForm, $sSpr1, $sSpr2)
	$__iLineNumber=2222 & ' - Local $aData = StringToASCIIArray($sForm, Default, Default,  ...•_WinHttp.au3'
	Local $aData = StringToASCIIArray($sForm, Default, Default, 2)
	$__iLineNumber=2223 & ' - Local $sOut, $bQuot = False, $bSQuot = False•_WinHttp.au3'
	Local $sOut, $bQuot = False, $bSQuot = False
	$__iLineNumber=2224 & ' - For $i = 0 To UBound($aData) - 1•_WinHttp.au3'
	For $i = 0 To UBound($aData) - 1
		$__iLineNumber=2225 & ' - Switch $aData[$i]•_WinHttp.au3'
		$__iLineNumber=2226 & ' - Case 34•_WinHttp.au3'
		Switch $aData[$i]
			Case 34
				$__iLineNumber=2227 & ' - $bQuot = Not $bQuot•_WinHttp.au3'
				$bQuot = Not $bQuot
			$__iLineNumber=2228 & ' - Case 39•_WinHttp.au3'
			Case 39
				$__iLineNumber=2229 & ' - $bSQuot = Not $bSQuot•_WinHttp.au3'
				$bSQuot = Not $bSQuot
			$__iLineNumber=2230 & ' - Case 32 ; space•_WinHttp.au3'
			Case 32 ; space
				$__iLineNumber=2231 & ' - If $bQuot Or $bSQuot Then•_WinHttp.au3'
				If $bQuot Or $bSQuot Then
					$__iLineNumber=2232 & ' - $sOut &= $sSpr1•_WinHttp.au3'
					$sOut &= $sSpr1
				Else
					$__iLineNumber=2234 & ' - $sOut &= Chr($aData[$i])•_WinHttp.au3'
					$sOut &= Chr($aData[$i])
				EndIf
			$__iLineNumber=2236 & ' - Case 62 ; >•_WinHttp.au3'
			Case 62 ; >
				$__iLineNumber=2237 & ' - If $bQuot Or $bSQuot Then•_WinHttp.au3'
				If $bQuot Or $bSQuot Then
					$__iLineNumber=2238 & ' - $sOut &= $sSpr2•_WinHttp.au3'
					$sOut &= $sSpr2
				Else
					$__iLineNumber=2240 & ' - $sOut &= Chr($aData[$i])•_WinHttp.au3'
					$sOut &= Chr($aData[$i])
				EndIf
			Case Else
				$__iLineNumber=2243 & ' - $sOut &= Chr($aData[$i])•_WinHttp.au3'
				$sOut &= Chr($aData[$i])
		EndSwitch
	Next
	$__iLineNumber=2246 & ' - $sForm = $sOut•_WinHttp.au3'
	$sForm = $sOut
EndFunc

$__iLineNumber=2249 & ' - Func __WinHttpFinalizeCtrls($sSubmit, $sRadio, $sCheckBox, $ ...•_WinHttp.au3'
Func __WinHttpFinalizeCtrls($sSubmit, $sRadio, $sCheckBox, $sButton, ByRef $sAddData, $sGrSep, $sBound = "")
	$__iLineNumber=2250 & ' - If $sSubmit Then ; If no submit is specified•_WinHttp.au3'
	If $sSubmit Then ; If no submit is specified
		$__iLineNumber=2251 & ' - Local $aSubmit = StringSplit($sSubmit, $sGrSep, 3)•_WinHttp.au3'
		Local $aSubmit = StringSplit($sSubmit, $sGrSep, 3)
		$__iLineNumber=2252 & ' - For $m = 1 To UBound($aSubmit) - 1•_WinHttp.au3'
		For $m = 1 To UBound($aSubmit) - 1
			$__iLineNumber=2253 & ' - $sAddData = StringRegExpReplace($sAddData, "(?:\Q" & $sBound ...•_WinHttp.au3'
			$sAddData = StringRegExpReplace($sAddData, "(?:\Q" & $sBound & "\E|\A)\Q" & $aSubmit[$m] & "\E(?:\Q" & $sBound & "\E|\z)", $sBound)
		Next
		$__iLineNumber=2255 & ' - __WinHttpTrimBounds($sAddData, $sBound)•_WinHttp.au3'
		__WinHttpTrimBounds($sAddData, $sBound)
	EndIf
	$__iLineNumber=2257 & ' - If $sRadio Then ; If no radio is specified•_WinHttp.au3'
	If $sRadio Then ; If no radio is specified
		$__iLineNumber=2258 & ' - If $sRadio <> $sGrSep Then•_WinHttp.au3'
		If $sRadio <> $sGrSep Then
			$__iLineNumber=2259 & ' - For $sElem In StringSplit($sRadio, $sGrSep, 3)•_WinHttp.au3'
			For $sElem In StringSplit($sRadio, $sGrSep, 3)
				$__iLineNumber=2260 & ' - $sAddData = StringRegExpReplace($sAddData, "(?:\Q" & $sBound ...•_WinHttp.au3'
				$sAddData = StringRegExpReplace($sAddData, "(?:\Q" & $sBound & "\E|\A)\Q" & $sElem & "\E(?:\Q" & $sBound & "\E|\z)", $sBound)
			Next
			$__iLineNumber=2262 & ' - __WinHttpTrimBounds($sAddData, $sBound)•_WinHttp.au3'
			__WinHttpTrimBounds($sAddData, $sBound)
		EndIf
	EndIf
	$__iLineNumber=2265 & ' - If $sCheckBox Then ; If no checkbox is specified•_WinHttp.au3'
	If $sCheckBox Then ; If no checkbox is specified
		$__iLineNumber=2266 & ' - For $sElem In StringSplit($sCheckBox, $sGrSep, 3)•_WinHttp.au3'
		For $sElem In StringSplit($sCheckBox, $sGrSep, 3)
			$__iLineNumber=2267 & ' - $sAddData = StringRegExpReplace($sAddData, "(?:\Q" & $sBound ...•_WinHttp.au3'
			$sAddData = StringRegExpReplace($sAddData, "(?:\Q" & $sBound & "\E|\A)\Q" & $sElem & "\E(?:\Q" & $sBound & "\E|\z)", $sBound)
		Next
		$__iLineNumber=2269 & ' - __WinHttpTrimBounds($sAddData, $sBound)•_WinHttp.au3'
		__WinHttpTrimBounds($sAddData, $sBound)
	EndIf
	$__iLineNumber=2271 & ' - If $sButton Then ; If no button is specified•_WinHttp.au3'
	If $sButton Then ; If no button is specified
		$__iLineNumber=2272 & ' - For $sElem In StringSplit($sButton, $sGrSep, 3)•_WinHttp.au3'
		For $sElem In StringSplit($sButton, $sGrSep, 3)
			$__iLineNumber=2273 & ' - $sAddData = StringRegExpReplace($sAddData, "(?:\Q" & $sBound ...•_WinHttp.au3'
			$sAddData = StringRegExpReplace($sAddData, "(?:\Q" & $sBound & "\E|\A)\Q" & $sElem & "\E(?:\Q" & $sBound & "\E|\z)", $sBound)
		Next
		$__iLineNumber=2275 & ' - __WinHttpTrimBounds($sAddData, $sBound)•_WinHttp.au3'
		__WinHttpTrimBounds($sAddData, $sBound)
	EndIf
EndFunc

$__iLineNumber=2279 & ' - Func __WinHttpTrimBounds(ByRef $sDta, $sBound)•_WinHttp.au3'
Func __WinHttpTrimBounds(ByRef $sDta, $sBound)
	$__iLineNumber=2280 & ' - Local $iBLen = StringLen($sBound)•_WinHttp.au3'
	Local $iBLen = StringLen($sBound)
	$__iLineNumber=2281 & ' - If StringRight($sDta, $iBLen) = $sBound Then $sDta = StringT ...•_WinHttp.au3'
	If StringRight($sDta, $iBLen) = $sBound Then $sDta = StringTrimRight($sDta, $iBLen)
	$__iLineNumber=2282 & ' - If StringLeft($sDta, $iBLen) = $sBound Then $sDta = StringTr ...•_WinHttp.au3'
	If StringLeft($sDta, $iBLen) = $sBound Then $sDta = StringTrimLeft($sDta, $iBLen)
EndFunc

$__iLineNumber=2285 & ' - Func __WinHttpFormAttrib(ByRef $aAttrib, $i, $sElement)•_WinHttp.au3'
Func __WinHttpFormAttrib(ByRef $aAttrib, $i, $sElement)
	$__iLineNumber=2286 & ' - $aAttrib[0][$i] = __WinHttpAttribVal($sElement, "id")•_WinHttp.au3'
	$aAttrib[0][$i] = __WinHttpAttribVal($sElement, "id")
	$__iLineNumber=2287 & ' - $aAttrib[1][$i] = __WinHttpAttribVal($sElement, "name")•_WinHttp.au3'
	$aAttrib[1][$i] = __WinHttpAttribVal($sElement, "name")
	$__iLineNumber=2288 & ' - $aAttrib[2][$i] = __WinHttpAttribVal($sElement, "value")•_WinHttp.au3'
	$aAttrib[2][$i] = __WinHttpAttribVal($sElement, "value")
	$__iLineNumber=2289 & ' - $aAttrib[3][$i] = __WinHttpAttribVal($sElement, "type")•_WinHttp.au3'
	$aAttrib[3][$i] = __WinHttpAttribVal($sElement, "type")
EndFunc

$__iLineNumber=2292 & ' - Func __WinHttpAttribVal($sIn, $sAttrib)•_WinHttp.au3'
Func __WinHttpAttribVal($sIn, $sAttrib)
	$__iLineNumber=2293 & ' - Local $aArray = StringRegExp($sIn, "(?i).*?(\A| )\b" & $sAtt ...•_WinHttp.au3'
	Local $aArray = StringRegExp($sIn, '(?i).*?(\A| )\b' & $sAttrib & '\h*=(\h*"(.*?)"|' & "\h*'(.*?)'|" & '\h*(.*?)(?: |\Z))', 1) ; e.g. id="abc" or id='abc' or id=abc
	$__iLineNumber=2294 & ' - If @error Then Return ""•_WinHttp.au3'
	If @error Then Return ""
	$__iLineNumber=2295 & ' - Return $aArray[UBound($aArray) - 1]•_WinHttp.au3'
	Return $aArray[UBound($aArray) - 1]
EndFunc

$__iLineNumber=2298 & ' - Func __WinHttpFormSend($hInternet, $sMethod, $sAction, $fMul ...•_WinHttp.au3'
Func __WinHttpFormSend($hInternet, $sMethod, $sAction, $fMultiPart, $sBoundary, $sAddData, $fSecure = False, $sAdditionalHeaders = "", $sCredName = "", $sCredPass = "", $iIgnoreAllCertErrors = 0)
	$__iLineNumber=2299 & ' - Local $hRequest•_WinHttp.au3'
	Local $hRequest
	$__iLineNumber=2300 & ' - If $fSecure Then•_WinHttp.au3'
	If $fSecure Then
		$__iLineNumber=2301 & ' - $hRequest = _WinHttpOpenRequest($hInternet, $sMethod, $sActi ...•_WinHttp.au3'
		$hRequest = _WinHttpOpenRequest($hInternet, $sMethod, $sAction, Default, Default, Default, $WINHTTP_FLAG_SECURE)
		$__iLineNumber=2302 & ' - If $iIgnoreAllCertErrors Then _WinHttpSetOption($hRequest, $ ...•_WinHttp.au3'
		If $iIgnoreAllCertErrors Then _WinHttpSetOption($hRequest, $WINHTTP_OPTION_SECURITY_FLAGS, BitOR($SECURITY_FLAG_IGNORE_UNKNOWN_CA, $SECURITY_FLAG_IGNORE_CERT_DATE_INVALID, $SECURITY_FLAG_IGNORE_CERT_CN_INVALID, $SECURITY_FLAG_IGNORE_CERT_WRONG_USAGE))
	Else
		$__iLineNumber=2304 & ' - $hRequest = _WinHttpOpenRequest($hInternet, $sMethod, $sActi ...•_WinHttp.au3'
		$hRequest = _WinHttpOpenRequest($hInternet, $sMethod, $sAction)
	EndIf
	$__iLineNumber=2306 & ' - If $fMultiPart Then•_WinHttp.au3'
	If $fMultiPart Then
		$__iLineNumber=2307 & ' - _WinHttpAddRequestHeaders($hRequest, "Content-Type: multipar ...•_WinHttp.au3'
		_WinHttpAddRequestHeaders($hRequest, "Content-Type: multipart/form-data; boundary=" & $sBoundary)
	Else
		$__iLineNumber=2309 & ' - If $sMethod = "POST" Then _WinHttpAddRequestHeaders($hReques ...•_WinHttp.au3'
		If $sMethod = "POST" Then _WinHttpAddRequestHeaders($hRequest, "Content-Type: application/x-www-form-urlencoded")
	EndIf
	$__iLineNumber=2311 & ' - _WinHttpAddRequestHeaders($hRequest, "Accept: application/xm ...•_WinHttp.au3'
	_WinHttpAddRequestHeaders($hRequest, "Accept: application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,*/*;q=0.5")
	$__iLineNumber=2312 & ' - _WinHttpAddRequestHeaders($hRequest, "Accept-Charset: utf-8; ...•_WinHttp.au3'
	_WinHttpAddRequestHeaders($hRequest, "Accept-Charset: utf-8;q=0.7")
	$__iLineNumber=2313 & ' - If $sAdditionalHeaders Then _WinHttpAddRequestHeaders($hRequ ...•_WinHttp.au3'
	If $sAdditionalHeaders Then _WinHttpAddRequestHeaders($hRequest, $sAdditionalHeaders, BitOR($WINHTTP_ADDREQ_FLAG_REPLACE, $WINHTTP_ADDREQ_FLAG_ADD))
	$__iLineNumber=2314 & ' - _WinHttpSetOption($hRequest, $WINHTTP_OPTION_DECOMPRESSION,  ...•_WinHttp.au3'
	_WinHttpSetOption($hRequest, $WINHTTP_OPTION_DECOMPRESSION, $WINHTTP_DECOMPRESSION_FLAG_ALL)
	$__iLineNumber=2315 & ' - _WinHttpSetOption($hRequest, $WINHTTP_OPTION_UNSAFE_HEADER_P ...•_WinHttp.au3'
	_WinHttpSetOption($hRequest, $WINHTTP_OPTION_UNSAFE_HEADER_PARSING, 1)
	$__iLineNumber=2316 & ' - __WinHttpFormUpload($hRequest, "", $sAddData)•_WinHttp.au3'
	__WinHttpFormUpload($hRequest, "", $sAddData)
	$__iLineNumber=2317 & ' - _WinHttpReceiveResponse($hRequest)•_WinHttp.au3'
	_WinHttpReceiveResponse($hRequest)
	$__iLineNumber=2318 & ' - __WinHttpSetCredentials($hRequest, "", $sAddData, $sCredName ...•_WinHttp.au3'
	__WinHttpSetCredentials($hRequest, "", $sAddData, $sCredName, $sCredPass, 1)
	$__iLineNumber=2319 & ' - Return $hRequest•_WinHttp.au3'
	Return $hRequest
EndFunc

$__iLineNumber=2322 & ' - Func __WinHttpSetCredentials($hRequest, $sHeaders = "", $sOp ...•_WinHttp.au3'
Func __WinHttpSetCredentials($hRequest, $sHeaders = "", $sOptional = "", $sCredName = "", $sCredPass = "", $iFormFill = 0)
	$__iLineNumber=2323 & ' - If $sCredName And $sCredPass Then•_WinHttp.au3'
	If $sCredName And $sCredPass Then
		$__iLineNumber=2324 & ' - Local $iStatusCode = _WinHttpQueryHeaders($hRequest, $WINHTT ...•_WinHttp.au3'
		Local $iStatusCode = _WinHttpQueryHeaders($hRequest, $WINHTTP_QUERY_STATUS_CODE)
		; Check status code
		$__iLineNumber=2326 & ' - If $iStatusCode = $HTTP_STATUS_DENIED Or $iStatusCode = $HTT ...•_WinHttp.au3'
		If $iStatusCode = $HTTP_STATUS_DENIED Or $iStatusCode = $HTTP_STATUS_PROXY_AUTH_REQ Then
			; Query Authorization scheme
			$__iLineNumber=2328 & ' - Local $iSupportedSchemes, $iFirstScheme, $iAuthTarget•_WinHttp.au3'
			Local $iSupportedSchemes, $iFirstScheme, $iAuthTarget
			$__iLineNumber=2329 & ' - If _WinHttpQueryAuthSchemes($hRequest, $iSupportedSchemes, $ ...•_WinHttp.au3'
			If _WinHttpQueryAuthSchemes($hRequest, $iSupportedSchemes, $iFirstScheme, $iAuthTarget) Then
				; Set passed credentials
				$__iLineNumber=2331 & ' - If $iFirstScheme = $WINHTTP_AUTH_SCHEME_PASSPORT And $iStatu ...•_WinHttp.au3'
				If $iFirstScheme = $WINHTTP_AUTH_SCHEME_PASSPORT And $iStatusCode = $HTTP_STATUS_PROXY_AUTH_REQ Then
					$__iLineNumber=2332 & ' - _WinHttpSetOption($hRequest, $WINHTTP_OPTION_CONFIGURE_PASSP ...•_WinHttp.au3'
					_WinHttpSetOption($hRequest, $WINHTTP_OPTION_CONFIGURE_PASSPORT_AUTH, $WINHTTP_ENABLE_PASSPORT_AUTH)
					$__iLineNumber=2333 & ' - _WinHttpSetOption($hRequest, $WINHTTP_OPTION_PROXY_USERNAME, ...•_WinHttp.au3'
					_WinHttpSetOption($hRequest, $WINHTTP_OPTION_PROXY_USERNAME, $sCredName)
					$__iLineNumber=2334 & ' - _WinHttpSetOption($hRequest, $WINHTTP_OPTION_PROXY_PASSWORD, ...•_WinHttp.au3'
					_WinHttpSetOption($hRequest, $WINHTTP_OPTION_PROXY_PASSWORD, $sCredPass)
				Else
					$__iLineNumber=2336 & ' - _WinHttpSetCredentials($hRequest, $iAuthTarget, $iFirstSchem ...•_WinHttp.au3'
					_WinHttpSetCredentials($hRequest, $iAuthTarget, $iFirstScheme, $sCredName, $sCredPass)
				EndIf
				; Send request again now
				$__iLineNumber=2339 & ' - If $iFormFill Then•_WinHttp.au3'
				If $iFormFill Then
					$__iLineNumber=2340 & ' - __WinHttpFormUpload($hRequest, $sHeaders, $sOptional)•_WinHttp.au3'
					__WinHttpFormUpload($hRequest, $sHeaders, $sOptional)
				Else
					$__iLineNumber=2342 & ' - _WinHttpSendRequest($hRequest, $sHeaders, $sOptional)•_WinHttp.au3'
					_WinHttpSendRequest($hRequest, $sHeaders, $sOptional)
				EndIf
				; And wait for the response again
				$__iLineNumber=2345 & ' - _WinHttpReceiveResponse($hRequest)•_WinHttp.au3'
				_WinHttpReceiveResponse($hRequest)
			EndIf
		EndIf
	EndIf
EndFunc

$__iLineNumber=2351 & ' - Func __WinHttpFormUpload($hRequest, $sHeaders, $sData)•_WinHttp.au3'
Func __WinHttpFormUpload($hRequest, $sHeaders, $sData)
	$__iLineNumber=2352 & ' - Local $aClbk = _WinHttpSimpleFormFill_SetUploadCallback()•_WinHttp.au3'
	Local $aClbk = _WinHttpSimpleFormFill_SetUploadCallback()
	$__iLineNumber=2353 & ' - If $aClbk[0] <> Default Then•_WinHttp.au3'
	If $aClbk[0] <> Default Then
		$__iLineNumber=2354 & ' - Local $iSize = StringLen($sData), $iChunk = Floor($iSize / $ ...•_WinHttp.au3'
		Local $iSize = StringLen($sData), $iChunk = Floor($iSize / $aClbk[1]), $iRest = $iSize - ($aClbk[1] - 1) * $iChunk, $iCurCh = $iChunk
		$__iLineNumber=2355 & ' - _WinHttpSendRequest($hRequest, Default, Default, $iSize)•_WinHttp.au3'
		_WinHttpSendRequest($hRequest, Default, Default, $iSize)
		$__iLineNumber=2356 & ' - For $i = 1 To $aClbk[1]•_WinHttp.au3'
		For $i = 1 To $aClbk[1]
			$__iLineNumber=2357 & ' - If $i = $aClbk[1] Then $iCurCh = $iRest•_WinHttp.au3'
			If $i = $aClbk[1] Then $iCurCh = $iRest
			$__iLineNumber=2358 & ' - _WinHttpWriteData($hRequest, StringMid($sData, 1 + $iChunk * ...•_WinHttp.au3'
			_WinHttpWriteData($hRequest, StringMid($sData, 1 + $iChunk * ($i -1), $iCurCh))
			$__iLineNumber=2359 & ' - Call($aClbk[0], Floor($i * 100 / $aClbk[1]))•_WinHttp.au3'
			Call($aClbk[0], Floor($i * 100 / $aClbk[1]))
		Next
	Else
		$__iLineNumber=2362 & ' - _WinHttpSendRequest($hRequest, Default, $sData)•_WinHttp.au3'
		_WinHttpSendRequest($hRequest, Default, $sData)
	EndIf
EndFunc

$__iLineNumber=2366 & ' - Func __WinHttpDefault(ByRef $vInput, $vOutput)•_WinHttp.au3'
Func __WinHttpDefault(ByRef $vInput, $vOutput)
	$__iLineNumber=2367 & ' - If $vInput = Default Or Number($vInput) = -1 Then $vInput =  ...•_WinHttp.au3'
	If $vInput = Default Or Number($vInput) = -1 Then $vInput = $vOutput
EndFunc

$__iLineNumber=2370 & ' - Func __WinHttpMemGlobalFree($pMem)•_WinHttp.au3'
Func __WinHttpMemGlobalFree($pMem)
	$__iLineNumber=2371 & ' - Local $aCall = DllCall("kernel32.dll", "ptr", "GlobalFree",  ...•_WinHttp.au3'
	Local $aCall = DllCall("kernel32.dll", "ptr", "GlobalFree", "ptr", $pMem)
	$__iLineNumber=2372 & ' - If @error Or $aCall[0] Then Return SetError(1, 0, 0)•_WinHttp.au3'
	If @error Or $aCall[0] Then Return SetError(1, 0, 0)
	$__iLineNumber=2373 & ' - Return 1•_WinHttp.au3'
	Return 1
EndFunc

$__iLineNumber=2376 & ' - Func __WinHttpPtrStringLenW($pStr)•_WinHttp.au3'
Func __WinHttpPtrStringLenW($pStr)
	$__iLineNumber=2377 & ' - Local $aCall = DllCall("kernel32.dll", "dword", "lstrlenW",  ...•_WinHttp.au3'
	Local $aCall = DllCall("kernel32.dll", "dword", "lstrlenW", "ptr", $pStr)
	$__iLineNumber=2378 & ' - If @error Then Return SetError(1, 0, 0)•_WinHttp.au3'
	If @error Then Return SetError(1, 0, 0)
	$__iLineNumber=2379 & ' - Return $aCall[0]•_WinHttp.au3'
	Return $aCall[0]
EndFunc

$__iLineNumber=2382 & ' - Func __WinHttpUA()•_WinHttp.au3'
Func __WinHttpUA()
	$__iLineNumber=2383 & ' - Local Static $sUA = "Mozilla/5.0 " & __WinHttpSysInfo() & "  ...•_WinHttp.au3'
	Local Static $sUA = "Mozilla/5.0 " & __WinHttpSysInfo() & " WinHttp/" & __WinHttpVer() & " (WinHTTP/5.1) like Gecko"
	$__iLineNumber=2384 & ' - Return $sUA•_WinHttp.au3'
	Return $sUA
EndFunc

$__iLineNumber=2387 & ' - Func __WinHttpSysInfo()•_WinHttp.au3'
Func __WinHttpSysInfo()
	$__iLineNumber=2388 & ' - Local $sDta = FileGetVersion("kernel32.dll")•_WinHttp.au3'
	Local $sDta = FileGetVersion("kernel32.dll")
	$__iLineNumber=2389 & ' - $sDta = "(Windows NT " & StringLeft($sDta, StringInStr($sDta ...•_WinHttp.au3'
	$sDta = "(Windows NT " & StringLeft($sDta, StringInStr($sDta, ".", 1, 2) - 1)
	$__iLineNumber=2390 & ' - If StringInStr(@OSArch, "64") And Not @AutoItX64 Then $sDta  ...•_WinHttp.au3'
	If StringInStr(@OSArch, "64") And Not @AutoItX64 Then $sDta &= "; WOW64"
	$__iLineNumber=2391 & ' - $sDta &= ")"•_WinHttp.au3'
	$sDta &= ")"
	$__iLineNumber=2392 & ' - Return $sDta•_WinHttp.au3'
	Return $sDta
EndFunc

$__iLineNumber=2395 & ' - Func __WinHttpVer()•_WinHttp.au3'
Func __WinHttpVer()
	$__iLineNumber=2396 & ' - Return "1.6.4.0"•_WinHttp.au3'
	Return "1.6.4.0"
EndFunc

$__iLineNumber=2399 & ' - Func _WinHttpBinaryConcat(ByRef $bBinary1, ByRef $bBinary2)•_WinHttp.au3'
Func _WinHttpBinaryConcat(ByRef $bBinary1, ByRef $bBinary2)
	$__iLineNumber=2400 & ' - Local $bOut = _WinHttpSimpleBinaryConcat($bBinary1, $bBinary ...•_WinHttp.au3'
	Local $bOut = _WinHttpSimpleBinaryConcat($bBinary1, $bBinary2)
	$__iLineNumber=2401 & ' - Return SetError(@error, 0, $bOut)•_WinHttp.au3'
	Return SetError(@error, 0, $bOut)
EndFunc
;============================================================================================
