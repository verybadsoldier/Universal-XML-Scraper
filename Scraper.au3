Global $__iLineNumber = 0
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=Ressources\Images\Scraper.ico
#AutoIt3Wrapper_Outfile=.\Scraper.exe
#AutoIt3Wrapper_Outfile_x64=.\Scraper64.exe
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_Description=Scraper
#AutoIt3Wrapper_Res_Fileversion=1.2.0.6
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=p
#AutoIt3Wrapper_Res_LegalCopyright=LEGRAS David
#AutoIt3Wrapper_Res_Language=1036
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=y
#AutoIt3Wrapper_Run_Tidy=y
#Tidy_Parameters=/reel
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
$__iLineNumber = 16 & ' - TraySetState(2)•'
TraySetState(2)

$__iLineNumber = 18 & ' - If $CmdLine[0] = 0 Then Exit•'
If $CmdLine[0] = 0 Then Exit
$__iLineNumber = 19 & ' - $vThreadNumber = $CmdLine[1]•'
$vThreadNumber = $CmdLine[1]

#include <Date.au3>
#include <array.au3>
#include <File.au3>
#include <String.au3>
#include <Crypt.au3>
#include <InetConstants.au3>
#include <ComboConstants.au3>
#include <GUIConstantsEx.au3>

$__iLineNumber = 30 & ' - If Not _FileCreate(@ScriptDir & "\test") Then ; Testing UXS  ...•'
If Not _FileCreate(@ScriptDir & "\test") Then ; Testing UXS Directory
	$__iLineNumber = 31 & ' - Global $iScriptPath = @AppDataDir & "\UXMLS" ; If not, use P ...•'
	Global $iScriptPath = @AppDataDir & "\UXMLS" ; If not, use Path to current user's Roaming Application Data
	$__iLineNumber = 32 & ' - DirCreate($iScriptPath) ;•'
	DirCreate($iScriptPath) ;
Else
	$__iLineNumber = 34 & ' - Global $iScriptPath = @ScriptDir•'
	Global $iScriptPath = @ScriptDir
	$__iLineNumber = 35 & ' - FileDelete($iScriptPath & "\test")•'
	FileDelete($iScriptPath & "\test")
EndIf

$__iLineNumber = 38 & ' - Global $iINIPath = $iScriptPath & "\UXS-config.ini"•'
Global $iINIPath = $iScriptPath & "\UXS-config.ini"
$__iLineNumber = 39 & ' - Global $iLOGPath = $iScriptPath & "\LOGs\log" & $vThreadNumb ...•'
Global $iLOGPath = $iScriptPath & "\LOGs\log" & $vThreadNumber & ".txt"
$__iLineNumber = 40 & ' - Global $iVerboseLVL = IniRead($iINIPath, "GENERAL", "$vVerbo ...•'
Global $iVerboseLVL = IniRead($iINIPath, "GENERAL", "$vVerbose", 0)

$__iLineNumber = 42 & ' - _LOG_Ceation($iLOGPath) ; Starting Log•'
_LOG_Ceation($iLOGPath) ; Starting Log

#include "./Include/_MultiLang.au3"
#include "./Include/_XML.au3"
#include "./Include/_MailSlot.au3"
#include "./Include/_GraphGDIPlus.au3"
#include "./Include/_MyFunction.au3"
#include "./Include/_AutoItErrorTrap.au3"
#include "./Include/_Hash.au3"

; Custom title and text...
$__iLineNumber = 53 & ' - _AutoItErrorTrap("AutoItErrorTrap", "Hi!" & @CRLF & @CRLF &  ...•'
_AutoItErrorTrap("AutoItErrorTrap", "Hi!" & @CRLF & @CRLF & "An error was detected in the program, you can try again," & _
		" cancel to exit or continue to see more details of the error." & @CRLF & @CRLF & "Sorry for the inconvenience!")

$__iLineNumber = 56 & ' - Local $iScriptVer = FileGetVersion(@ScriptFullPath)•'
Local $iScriptVer = FileGetVersion(@ScriptFullPath)
$__iLineNumber = 57 & ' - Local $iINIVer = IniRead($iINIPath, "GENERAL", "$verINI", "0 ...•'
Local $iINIVer = IniRead($iINIPath, "GENERAL", "$verINI", '0.0.0.0')
$__iLineNumber = 58 & ' - Local $iSoftname = "UniversalXMLScraperV" & $iScriptVer•'
Local $iSoftname = "UniversalXMLScraperV" & $iScriptVer

$__iLineNumber = 60 & ' - Global $iDevId = BinaryToString(_Crypt_DecryptData("0x1552ED ...•'
Global $iDevId = BinaryToString(_Crypt_DecryptData("0x1552EDED2FA9B5", "1gdf1g1gf", $CALG_RC4))
$__iLineNumber = 61 & ' - Global $iDevPassword = BinaryToString(_Crypt_DecryptData("0x ...•'
Global $iDevPassword = BinaryToString(_Crypt_DecryptData("0x1552EDED2FA9B547FBD0D9A623D954AE7BEDC681", "1gdf1g1gf", $CALG_RC4))
$__iLineNumber = 62 & ' - Global $iTEMPPath = $iScriptPath & "\TEMP\MIX" & $vThreadNum ...•'
Global $iTEMPPath = $iScriptPath & "\TEMP\MIX" & $vThreadNumber
$__iLineNumber = 63 & ' - Global $iTEMPPathGlobal = $iScriptPath & "\TEMP"•'
Global $iTEMPPathGlobal = $iScriptPath & "\TEMP"
$__iLineNumber = 64 & ' - Global $iRessourcesPath = $iScriptPath & "\Ressources"•'
Global $iRessourcesPath = $iScriptPath & "\Ressources"
$__iLineNumber = 65 & ' - Global $iLangPath = $iScriptPath & "\LanguageFiles" ; Where  ...•'
Global $iLangPath = $iScriptPath & "\LanguageFiles" ; Where we are storing the language files.
$__iLineNumber = 66 & ' - Global $iProfilsPath = $iScriptPath & "\ProfilsFiles" ; Wher ...•'
Global $iProfilsPath = $iScriptPath & "\ProfilsFiles" ; Where we are storing the profils files.
$__iLineNumber = 67 & ' - Global $vNodeType = "Element"•'
Global $vNodeType = "Element"
$__iLineNumber = 68 & ' - Global $vSSLogin = IniRead($iINIPath, "LAST_USE", "$vSSLogin ...•'
Global $vSSLogin = IniRead($iINIPath, "LAST_USE", "$vSSLogin", "")
$__iLineNumber = 69 & ' - Global $vSSPassword = BinaryToString(_Crypt_DecryptData(IniR ...•'
Global $vSSPassword = BinaryToString(_Crypt_DecryptData(IniRead($iINIPath, "LAST_USE", "$vSSPassword", ""), "1gdf1g1gf", $CALG_RC4))

$__iLineNumber = 71 & ' - Local $iSize, $aRomList, $vBoucle, $aConfig, $vProfilsPath,  ...•'
Local $iSize, $aRomList, $vBoucle, $aConfig, $vProfilsPath, $oXMLProfil, $oXMLSystem, $aMatchingCountry, $oXMLGenre
$__iLineNumber = 72 & ' - Local $sMailSlotMother = "\\.\mailslot\Mother"•'
Local $sMailSlotMother = "\\.\mailslot\Mother"
$__iLineNumber = 73 & ' - Local $sMailSlotName = "\\.\mailslot\Son" & $vThreadNumber•'
Local $sMailSlotName = "\\.\mailslot\Son" & $vThreadNumber
$__iLineNumber = 74 & ' - Local $sMailSlotCancel = "\\.\mailslot\Cancel" & $vThreadNum ...•'
Local $sMailSlotCancel = "\\.\mailslot\Cancel" & $vThreadNumber
$__iLineNumber = 75 & ' - Local $sMailSlotCheckEngine = "\\.\mailslot\CheckEngine"•'
Local $sMailSlotCheckEngine = "\\.\mailslot\CheckEngine"
$__iLineNumber = 76 & ' - Local $hMailSlot = _CreateMailslot($sMailSlotName)•'
Local $hMailSlot = _CreateMailslot($sMailSlotName)
$__iLineNumber = 77 & ' - Local $hMailSlotCancel = _CreateMailslot($sMailSlotCancel)•'
Local $hMailSlotCancel = _CreateMailslot($sMailSlotCancel)
$__iLineNumber = 78 & ' - Local $iNumberOfMessagesOverall = 1•'
Local $iNumberOfMessagesOverall = 1

$__iLineNumber = 80 & ' - _SendMail($sMailSlotCheckEngine, $vThreadNumber & "|0")•'
_SendMail($sMailSlotCheckEngine, $vThreadNumber & "|0")

$__iLineNumber = 82 & ' - $oXMLSystem = _XMLSystem_Create()•'
$oXMLSystem = _XMLSystem_Create()
$__iLineNumber = 83 & ' - If $oXMLSystem = -1 Then Exit•'
If $oXMLSystem = -1 Then Exit

$__iLineNumber = 85 & ' - $oXMLGenre = _XMLGenre_Create()•'
$oXMLGenre = _XMLGenre_Create()
$__iLineNumber = 86 & ' - If $oXMLGenre = -1 Then Exit•'
If $oXMLGenre = -1 Then Exit

Sleep(1000)

$__iLineNumber = 90 & ' - _SendMail($sMailSlotCheckEngine, $vThreadNumber & "|0")•'
_SendMail($sMailSlotCheckEngine, $vThreadNumber & "|0")

$__iLineNumber = 92 & ' - While $iNumberOfMessagesOverall < 5•'
While $iNumberOfMessagesOverall < 5
	$__iLineNumber = 93 & ' - If _CheckCount($hMailSlotCancel) >= 1 Then•'
	If _CheckCount($hMailSlotCancel) >= 1 Then
		$__iLineNumber = 94 & ' - _MailSlotClose($hMailSlot)•'
		_MailSlotClose($hMailSlot)
		$__iLineNumber = 95 & ' - _MailSlotClose($hMailSlotCancel)•'
		_MailSlotClose($hMailSlotCancel)
		Exit
	EndIf
	$__iLineNumber = 98 & ' - If _MailSlotGetMessageCount($hMailSlot) >= 1 Then•'
	If _MailSlotGetMessageCount($hMailSlot) >= 1 Then
		$__iLineNumber = 99 & ' - Switch $iNumberOfMessagesOverall•'
		$__iLineNumber = 100 & ' - Case 1•'
		Switch $iNumberOfMessagesOverall
			Case 1
				$__iLineNumber = 101 & ' - $aRomList = _ReadMessage($hMailSlot)•'
				$aRomList = _ReadMessage($hMailSlot)
				$__iLineNumber = 102 & ' - _LOG("Read Message $aRomList : " & $aRomList, 1, $iLOGPath)•'
				_LOG("Read Message $aRomList : " & $aRomList, 1, $iLOGPath)
				$__iLineNumber = 103 & ' - $aRomList = StringSplit($aRomList, "{Break}", $STR_ENTIRESPL ...•'
				$aRomList = StringSplit($aRomList, '{Break}', $STR_ENTIRESPLIT + $STR_NOCOUNT)
				$__iLineNumber = 104 & ' - ReDim $aRomList[13]•'
				ReDim $aRomList[13]
				$__iLineNumber = 105 & ' - $iNumberOfMessagesOverall += 1•'
				$iNumberOfMessagesOverall += 1
				$__iLineNumber = 106 & ' - Case 2•'
			Case 2
				$__iLineNumber = 107 & ' - $vBoucle = _ReadMessage($hMailSlot)•'
				$vBoucle = _ReadMessage($hMailSlot)
				$__iLineNumber = 108 & ' - _LOG("Read Message $vBoucle : " & $vBoucle, 1, $iLOGPath)•'
				_LOG("Read Message $vBoucle : " & $vBoucle, 1, $iLOGPath)
				$__iLineNumber = 109 & ' - $iNumberOfMessagesOverall += 1•'
				$iNumberOfMessagesOverall += 1
				$__iLineNumber = 110 & ' - Case 3•'
			Case 3
				$__iLineNumber = 111 & ' - $aConfig = _ReadMessage($hMailSlot)•'
				$aConfig = _ReadMessage($hMailSlot)
				$__iLineNumber = 112 & ' - _LOG("Read Message $aConfig : " & $aConfig, 1, $iLOGPath)•'
				_LOG("Read Message $aConfig : " & $aConfig, 1, $iLOGPath)
				$__iLineNumber = 113 & ' - $aConfig = StringSplit($aConfig, "{Break}", $STR_ENTIRESPLIT ...•'
				$aConfig = StringSplit($aConfig, '{Break}', $STR_ENTIRESPLIT + $STR_NOCOUNT)
				$__iLineNumber = 114 & ' - ReDim $aConfig[16]•'
				ReDim $aConfig[16]

				$__iLineNumber = 116 & ' - $aConfig[8] = _XML_Open($iTEMPPathGlobal & "\scraped\" & $vB ...•'
				$aConfig[8] = _XML_Open($iTEMPPathGlobal & "\scraped\" & $vBoucle & ".xml")
				$__iLineNumber = 117 & ' - $aConfig[9] = StringSplit($aConfig[9], "|")•'
				$aConfig[9] = StringSplit($aConfig[9], "|")
				$__iLineNumber = 118 & ' - $aConfig[10] = StringSplit($aConfig[10], "|")•'
				$aConfig[10] = StringSplit($aConfig[10], "|")
				$__iLineNumber = 119 & ' - _FileReadToArray($aConfig[11], $aMatchingCountry, $FRTA_NOCO ...•'
				_FileReadToArray($aConfig[11], $aMatchingCountry, $FRTA_NOCOUNT, "|")
				$__iLineNumber = 120 & ' - $aConfig[11] = $aMatchingCountry•'
				$aConfig[11] = $aMatchingCountry
				$__iLineNumber = 121 & ' - $iNumberOfMessagesOverall += 1•'
				$iNumberOfMessagesOverall += 1
				$__iLineNumber = 122 & ' - Case 4•'
			Case 4
				$__iLineNumber = 123 & ' - $vProfilsPath = _ReadMessage($hMailSlot)•'
				$vProfilsPath = _ReadMessage($hMailSlot)
				$__iLineNumber = 124 & ' - _LOG("Read Message $vProfilsPath : " & $vProfilsPath, 1, $iL ...•'
				_LOG("Read Message $vProfilsPath : " & $vProfilsPath, 1, $iLOGPath)
				$__iLineNumber = 125 & ' - $oXMLProfil = _XML_Open($vProfilsPath)•'
				$oXMLProfil = _XML_Open($vProfilsPath)
				$__iLineNumber = 126 & ' - $iNumberOfMessagesOverall += 1•'
				$iNumberOfMessagesOverall += 1
		EndSwitch
	Else
		; no new message - just yield
		Sleep(200)
	EndIf
	$__iLineNumber = 132 & ' - If $iNumberOfMessagesOverall = 5 Then•'
	If $iNumberOfMessagesOverall = 5 Then
		$__iLineNumber = 133 & ' - _SendMail($sMailSlotCheckEngine, $vThreadNumber & "|1")•'
		_SendMail($sMailSlotCheckEngine, $vThreadNumber & "|1")
		$__iLineNumber = 134 & ' - $vRomTimer = TimerInit()•'
		$vRomTimer = TimerInit()
		$__iLineNumber = 135 & ' - _LOG("-----Making " & $aRomList[2], 1, $iLOGPath)•'
		_LOG("-----Making " & $aRomList[2], 1, $iLOGPath)
		$__iLineNumber = 136 & ' - $aRomList = _Game_Make($aRomList, $vBoucle, $aConfig, $oXMLP ...•'
		$aRomList = _Game_Make($aRomList, $vBoucle, $aConfig, $oXMLProfil)
		$__iLineNumber = 137 & ' - $oXMLAfterTidy = _XML_CreateDOMDocument(Default)•'
		$oXMLAfterTidy = _XML_CreateDOMDocument(Default)
		$__iLineNumber = 138 & ' - $vXMLAfterTidy = _XML_TIDY($aConfig[8])•'
		$vXMLAfterTidy = _XML_TIDY($aConfig[8])
		$__iLineNumber = 139 & ' - _XML_LoadXML($oXMLAfterTidy, $vXMLAfterTidy)•'
		_XML_LoadXML($oXMLAfterTidy, $vXMLAfterTidy)
		$__iLineNumber = 140 & ' - FileDelete($iTEMPPathGlobal & "\scraped\" & $vBoucle & ".xml ...•'
		FileDelete($iTEMPPathGlobal & "\scraped\" & $vBoucle & ".xml")
		$__iLineNumber = 141 & ' - _XML_SaveToFile($oXMLAfterTidy, $iTEMPPathGlobal & "\scraped ...•'
		_XML_SaveToFile($oXMLAfterTidy, $iTEMPPathGlobal & "\scraped\" & $vBoucle & ".xml")
		$__iLineNumber = 142 & ' - $iNumberOfMessagesOverall = 1•'
		$iNumberOfMessagesOverall = 1
		$__iLineNumber = 143 & ' - $vScrapedTime = Round((TimerDiff($vRomTimer) / 1000), 2)•'
		$vScrapedTime = Round((TimerDiff($vRomTimer) / 1000), 2)
		$__iLineNumber = 144 & ' - _SendMail($sMailSlotMother, $vBoucle & "|" & $vScrapedTime)•'
		_SendMail($sMailSlotMother, $vBoucle & "|" & $vScrapedTime)
		$__iLineNumber = 145 & ' - _LOG("-----" & $aRomList[2] & " scraped in " & $vScrapedTime ...•'
		_LOG("-----" & $aRomList[2] & " scraped in " & $vScrapedTime & "s", 3, $iLOGPath)
		$__iLineNumber = 146 & ' - _SendMail($sMailSlotCheckEngine, $vThreadNumber & "|0")•'
		_SendMail($sMailSlotCheckEngine, $vThreadNumber & "|0")
		$__iLineNumber = 147 & ' - If _CheckCount($hMailSlotCancel) >= 1 Then Exit•'
		If _CheckCount($hMailSlotCancel) >= 1 Then Exit
	EndIf
WEnd

$__iLineNumber = 151 & ' - Func _Game_Make($aRomList, $vBoucle, $aConfig, $oXMLProfil)•'
Func _Game_Make($aRomList, $vBoucle, $aConfig, $oXMLProfil)
	$__iLineNumber = 152 & ' - Local $vValue = "", $vAttributeName, $vWhile = 1, $vNode, $v ...•'
	Local $vValue = "", $vAttributeName, $vWhile = 1, $vNode, $vBracketPos = 0, $vHookPos = 0, $vSystem
	$__iLineNumber = 153 & ' - While 1•'
	While 1
		$__iLineNumber = 154 & ' - If $aRomList[3] = 4 Then•'
		If $aRomList[3] = 4 Then
			$__iLineNumber = 155 & ' - $vNodeType = "Folder"•'
			$vNodeType = "Folder"
			$__iLineNumber = 156 & ' - _LOG("Creating Folder", 1, $iLOGPath)•'
			_LOG("Creating Folder", 1, $iLOGPath)
		Else
			$__iLineNumber = 158 & ' - $vNodeType = "Element"•'
			$vNodeType = "Element"
			$__iLineNumber = 159 & ' - _LOG("Creating Element", 1, $iLOGPath)•'
			_LOG("Creating Element", 1, $iLOGPath)
		EndIf
		$__iLineNumber = 161 & ' - _LOG("/Profil/" & $vNodeType & "[" & $vWhile & "]/Target_Typ ...•'
		_LOG("/Profil/" & $vNodeType & "[" & $vWhile & "]/Target_Type = " & _XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & "]/Target_Type", 0, "", $oXMLProfil), 1, $iLOGPath)
		$__iLineNumber = 162 & ' - Switch _XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & " ...•'
		$__iLineNumber = 163 & ' - Case "XML_Value"•'
		Switch _XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & "]/Target_Type", 0, "", $oXMLProfil)
			Case "XML_Value"
				$__iLineNumber = 164 & ' - $vValue = _XML_Read_Source($aRomList, $vBoucle, $aConfig, $o ...•'
				$vValue = _XML_Read_Source($aRomList, $vBoucle, $aConfig, $oXMLProfil, $vWhile)
				$__iLineNumber = 165 & ' - $vNode = _XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & ...•'
				$vNode = _XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & "]/Target_Value", 0, "", $oXMLProfil)
				$__iLineNumber = 166 & ' - Switch _Coalesce(StringLower(_XML_Read("/Profil/" & $vNodeTy ...•'
				$__iLineNumber = 167 & ' - Case "true"•'
				Switch _Coalesce(StringLower(_XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & "]/Target_CASE", 0, "", $oXMLProfil)), "default")
					Case "true"
						$__iLineNumber = 168 & ' - $vValue = StringUpper($vValue)•'
						$vValue = StringUpper($vValue)
						$__iLineNumber = 169 & ' - Case "false"•'
					Case "false"
						$__iLineNumber = 170 & ' - $vValue = StringLower($vValue)•'
						$vValue = StringLower($vValue)
				EndSwitch
				$__iLineNumber = 172 & ' - If $aConfig[5] <> 2 Then•'
				If $aConfig[5] <> 2 Then
					$__iLineNumber = 173 & ' - _LOG($vNode & " <-- " & $vValue, 1, $iLOGPath)•'
					_LOG($vNode & " <-- " & $vValue, 1, $iLOGPath)
					$__iLineNumber = 174 & ' - _XML_WriteValue($vNode, $vValue, "", $aConfig[8])•'
					_XML_WriteValue($vNode, $vValue, "", $aConfig[8])
				EndIf
				$__iLineNumber = 176 & ' - Case "XML_Attribute"•'
			Case "XML_Attribute"
				$__iLineNumber = 177 & ' - $vValue = _XML_Read_Source($aRomList, $vBoucle, $aConfig, $o ...•'
				$vValue = _XML_Read_Source($aRomList, $vBoucle, $aConfig, $oXMLProfil, $vWhile)
				$__iLineNumber = 178 & ' - $vAttributeName = _XML_Read("/Profil/" & $vNodeType & "[" &  ...•'
				$vAttributeName = _XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & "]/Target_Attribute_Name", 0, "", $oXMLProfil)
				$__iLineNumber = 179 & ' - $vNode = _XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & ...•'
				$vNode = _XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & "]/Target_Value", 0, "", $oXMLProfil)
				$__iLineNumber = 180 & ' - Switch _Coalesce(StringLower(_XML_Read("/Profil/" & $vNodeTy ...•'
				$__iLineNumber = 181 & ' - Case "true"•'
				Switch _Coalesce(StringLower(_XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & "]/Target_CASE", 0, "", $oXMLProfil)), "default")
					Case "true"
						$__iLineNumber = 182 & ' - $vValue = StringUpper($vValue)•'
						$vValue = StringUpper($vValue)
						$__iLineNumber = 183 & ' - Case "false"•'
					Case "false"
						$__iLineNumber = 184 & ' - $vValue = StringLower($vValue)•'
						$vValue = StringLower($vValue)
				EndSwitch
				$__iLineNumber = 186 & ' - If $aConfig[5] <> 2 Then•'
				If $aConfig[5] <> 2 Then
					$__iLineNumber = 187 & ' - _LOG($vNode & " <-- " & $vValue, 1, $iLOGPath)•'
					_LOG($vNode & " <-- " & $vValue, 1, $iLOGPath)
					$__iLineNumber = 188 & ' - _XML_WriteAttributs($vNode, $vAttributeName, $vValue, "", $a ...•'
					_XML_WriteAttributs($vNode, $vAttributeName, $vValue, "", $aConfig[8])
				EndIf
				$__iLineNumber = 190 & ' - Case "XML_Path"•'
			Case "XML_Path"
				$__iLineNumber = 191 & ' - $vValue = _XML_Read_Source($aRomList, $vBoucle, $aConfig, $o ...•'
				$vValue = _XML_Read_Source($aRomList, $vBoucle, $aConfig, $oXMLProfil, $vWhile)
				$__iLineNumber = 192 & ' - $vNode = _XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & ...•'
				$vNode = _XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & "]/Target_Value", 0, "", $oXMLProfil)
				$__iLineNumber = 193 & ' - _LOG($vNode & " <-- " & $vValue, 1, $iLOGPath)•'
				_LOG($vNode & " <-- " & $vValue, 1, $iLOGPath)
				$__iLineNumber = 194 & ' - If Number($vValue) < 0 Or $aConfig[5] = 2 Then•'
				If Number($vValue) < 0 Or $aConfig[5] = 2 Then
					$__iLineNumber = 195 & ' - _LOG($vNode & " <-- No value to write", 1, $iLOGPath)•'
					_LOG($vNode & " <-- No value to write", 1, $iLOGPath)
				Else
					$__iLineNumber = 197 & ' - $vSystem = StringSplit(IniRead($iINIPath, "LAST_USE", "$vSou ...•'
					$vSystem = StringSplit(IniRead($iINIPath, "LAST_USE", "$vSource_RomPath", ""), "\")
					$__iLineNumber = 198 & ' - $vSystem = $vSystem[UBound($vSystem) - 1]•'
					$vSystem = $vSystem[UBound($vSystem) - 1]
					$__iLineNumber = 199 & ' - $vValue = StringReplace($vValue, "%system%", $vSystem)•'
					$vValue = StringReplace($vValue, '%system%', $vSystem)
					$__iLineNumber = 200 & ' - _XML_WriteValue($vNode, $vValue, "", $aConfig[8])•'
					_XML_WriteValue($vNode, $vValue, "", $aConfig[8])
				EndIf
				$__iLineNumber = 202 & ' - Case "XML_Value_FORMAT"•'
			Case "XML_Value_FORMAT"
				$__iLineNumber = 203 & ' - $vValue = _XML_Read_Source($aRomList, $vBoucle, $aConfig, $o ...•'
				$vValue = _XML_Read_Source($aRomList, $vBoucle, $aConfig, $oXMLProfil, $vWhile)
				$__iLineNumber = 204 & ' - Switch _XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & " ...•'
				$__iLineNumber = 205 & ' - Case "%20on1%"•'
				Switch _XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & "]/Target_FORMAT", 0, "", $oXMLProfil)
					Case '%20on1%'
						$__iLineNumber = 206 & ' - $vValue = StringReplace(Round(($vValue * 100 / 20) / 100, 2) ...•'
						$vValue = StringReplace(Round(($vValue * 100 / 20) / 100, 2), ",", ".")
						$__iLineNumber = 207 & ' - Case "%ES_Date%"•'
					Case '%ES_Date%'
						$__iLineNumber = 208 & ' - $vValue = StringLeft(StringReplace($vValue, "-", "") & "0000 ...•'
						$vValue = StringLeft(StringReplace($vValue, "-", "") & '00000000', 8) & "T000000"
						$__iLineNumber = 209 & ' - Case "%Filename%"•'
					Case '%Filename%'
						$__iLineNumber = 210 & ' - $vValue = $aRomList[2]•'
						$vValue = $aRomList[2]
						$__iLineNumber = 211 & ' - Case "%Name+Filename_Bracket%"•'
					Case '%Name+Filename_Bracket%'
						$__iLineNumber = 212 & ' - If StringInStr($aRomList[2], "(") > 0 Then $vBracketPos = St ...•'
						If StringInStr($aRomList[2], "(") > 0 Then $vBracketPos = StringInStr($aRomList[2], "(")
						$__iLineNumber = 213 & ' - If StringInStr($aRomList[2], "[") > 0 Then $vHookPos = Strin ...•'
						If StringInStr($aRomList[2], "[") > 0 Then $vHookPos = StringInStr($aRomList[2], "[")
						$__iLineNumber = 214 & ' - If $vHookPos < $vBracketPos And $vHookPos > 0 Then $vBracket ...•'
						If $vHookPos < $vBracketPos And $vHookPos > 0 Then $vBracketPos = $vHookPos
						$__iLineNumber = 215 & ' - If $vBracketPos > 0 Then $vValue = $vValue & " " & StringMid ...•'
						If $vBracketPos > 0 Then $vValue = $vValue & " " & StringMid($aRomList[2], $vBracketPos)
						$__iLineNumber = 216 & ' - Case "%Name+Option%"•'
					Case '%Name+Option%'
						$__iLineNumber = 217 & ' - $vRomId = _XML_Read("Data/jeu/romid", 0, $aRomList[8]) ;RomI ...•'
						$vRomId = _XML_Read("Data/jeu/romid", 0, $aRomList[8]) ;RomId
						$__iLineNumber = 218 & ' - $vTarget_NameOption_Country = _XML_Read("Profil/Element[@Typ ...•'
						$vTarget_NameOption_Country = _XML_Read('Profil/Element[@Type="Name"]/Target_NameOption_Country', 0, "", $oXMLProfil)
						$__iLineNumber = 219 & ' - Switch $vTarget_NameOption_Country•'
						$__iLineNumber = 220 & ' - Case "Yes"•'
						Switch $vTarget_NameOption_Country
							Case "Yes"
								$__iLineNumber = 221 & ' - $vCountryshort = _Coalesce(_XML_Read("Data/jeu/regionshortna ...•'
								$vCountryshort = _Coalesce(_XML_Read("Data/jeu/regionshortnames/regionshortname", 0, $aRomList[8]), "unknown")
								$__iLineNumber = 222 & ' - If $vCountryshort <> "unknown" Then•'
								If $vCountryshort <> "unknown" Then
									$__iLineNumber = 223 & ' - Local $aLangPref = $aConfig[9]•'
									Local $aLangPref = $aConfig[9]
									$__iLineNumber = 224 & ' - For $vBoucle2 = 1 To UBound($aLangPref) - 1•'
									For $vBoucle2 = 1 To UBound($aLangPref) - 1
										$__iLineNumber = 225 & ' - $vXpathTemp = "/Data/regions/region[nomcourt="" & $vCountrys ...•'
										$vXpathTemp = '/Data/regions/region[nomcourt="' & $vCountryshort & '"]/nom_' & $aLangPref[$vBoucle2]
										$__iLineNumber = 226 & ' - $vCountry = _XML_Read($vXpathTemp, 0, $iRessourcesPath & "\C ...•'
										$vCountry = _XML_Read($vXpathTemp, 0, $iRessourcesPath & "\Countrylist.xml")
										$__iLineNumber = 227 & ' - If $vValue <> -1 And $vValue <> "" Then•'
										If $vValue <> -1 And $vValue <> "" Then
											$__iLineNumber = 228 & ' - $vValue = $vValue & " [" & $vCountry & "]"•'
											$vValue = $vValue & " [" & $vCountry & "]"
											$__iLineNumber = 229 & ' - $vBoucle2 = UBound($aLangPref) - 1•'
											$vBoucle2 = UBound($aLangPref) - 1
										EndIf
									Next
								EndIf
								$__iLineNumber = 233 & ' - Case "YesNoWorld"•'
							Case "YesNoWorld"
								$__iLineNumber = 234 & ' - $vCountryshort = _Coalesce(_XML_Read("Data/jeu/regionshortna ...•'
								$vCountryshort = _Coalesce(_XML_Read("Data/jeu/regionshortnames/regionshortname", 0, $aRomList[8]), "unknown")
								$__iLineNumber = 235 & ' - If $vCountryshort <> "unknown" And $vCountryshort <> "wor" T ...•'
								If $vCountryshort <> "unknown" And $vCountryshort <> "wor" Then
									$__iLineNumber = 236 & ' - Local $aLangPref = $aConfig[9]•'
									Local $aLangPref = $aConfig[9]
									$__iLineNumber = 237 & ' - For $vBoucle2 = 1 To UBound($aLangPref) - 1•'
									For $vBoucle2 = 1 To UBound($aLangPref) - 1
										$__iLineNumber = 238 & ' - $vXpathTemp = "/Data/regions/region[nomcourt="" & $vCountrys ...•'
										$vXpathTemp = '/Data/regions/region[nomcourt="' & $vCountryshort & '"]/nom_' & $aLangPref[$vBoucle2]
										$__iLineNumber = 239 & ' - $vCountry = _XML_Read($vXpathTemp, 0, $iRessourcesPath & "\C ...•'
										$vCountry = _XML_Read($vXpathTemp, 0, $iRessourcesPath & "\Countrylist.xml")
										$__iLineNumber = 240 & ' - If $vValue <> -1 And $vValue <> "" Then•'
										If $vValue <> -1 And $vValue <> "" Then
											$__iLineNumber = 241 & ' - $vValue = $vValue & " [" & $vCountry & "]"•'
											$vValue = $vValue & " [" & $vCountry & "]"
											$__iLineNumber = 242 & ' - $vBoucle2 = UBound($aLangPref) - 1•'
											$vBoucle2 = UBound($aLangPref) - 1
										EndIf
									Next
								EndIf
						EndSwitch

						$__iLineNumber = 248 & ' - Local $vTarget_NameOption_Clone_Value = "0"•'
						Local $vTarget_NameOption_Clone_Value = "0"
						$__iLineNumber = 249 & ' - Local $vTarget_NameOption_Beta_Value = "0"•'
						Local $vTarget_NameOption_Beta_Value = "0"
						$__iLineNumber = 250 & ' - Local $vTarget_NameOption_Demo_Value = "0"•'
						Local $vTarget_NameOption_Demo_Value = "0"
						$__iLineNumber = 251 & ' - Local $vTarget_NameOption_Proto_Value = "0"•'
						Local $vTarget_NameOption_Proto_Value = "0"
						$__iLineNumber = 252 & ' - Local $vTarget_NameOption_Trad_Value = "0"•'
						Local $vTarget_NameOption_Trad_Value = "0"
						$__iLineNumber = 253 & ' - Local $vTarget_NameOption_Hack_Value = "0"•'
						Local $vTarget_NameOption_Hack_Value = "0"
						$__iLineNumber = 254 & ' - Local $vTarget_NameOption_Unl_Value = "0"•'
						Local $vTarget_NameOption_Unl_Value = "0"
						$__iLineNumber = 255 & ' - Local $vTarget_NameOption_Alt_Value = "0"•'
						Local $vTarget_NameOption_Alt_Value = "0"
						$__iLineNumber = 256 & ' - Local $vTarget_NameOption_Best_Value = "0"•'
						Local $vTarget_NameOption_Best_Value = "0"

						$__iLineNumber = 259 & ' - If _XML_Read("Profil/Element[@Type="Name"]/Target_NameOption ...•'
						If _XML_Read('Profil/Element[@Type="Name"]/Target_NameOption_Clone', 0, "", $oXMLProfil) = "Yes" Then $vTarget_NameOption_Clone_Value = _Coalesce(_XML_Read("Data/jeu/cloneof", 0, $aRomList[8]), 0)
						$__iLineNumber = 260 & ' - If _XML_Read("Profil/Element[@Type="Name"]/Target_NameOption ...•'
						If _XML_Read('Profil/Element[@Type="Name"]/Target_NameOption_Beta', 0, "", $oXMLProfil) = "Yes" Then $vTarget_NameOption_Beta_Value = _Coalesce(_XML_Read('Data/jeu/roms/rom[romid="' & $vRomId & '"]/beta', 0, $aRomList[8]), 0)
						$__iLineNumber = 261 & ' - If _XML_Read("Profil/Element[@Type="Name"]/Target_NameOption ...•'
						If _XML_Read('Profil/Element[@Type="Name"]/Target_NameOption_Demo', 0, "", $oXMLProfil) = "Yes" Then $vTarget_NameOption_Demo_Value = _Coalesce(_XML_Read('Data/jeu/roms/rom[romid="' & $vRomId & '"]/demo', 0, $aRomList[8]), 0)
						$__iLineNumber = 262 & ' - If _XML_Read("Profil/Element[@Type="Name"]/Target_NameOption ...•'
						If _XML_Read('Profil/Element[@Type="Name"]/Target_NameOption_Proto', 0, "", $oXMLProfil) = "Yes" Then $vTarget_NameOption_Proto_Value = _Coalesce(_XML_Read('Data/jeu/roms/rom[romid="' & $vRomId & '"]/proto', 0, $aRomList[8]), 0)
						$__iLineNumber = 263 & ' - If _XML_Read("Profil/Element[@Type="Name"]/Target_NameOption ...•'
						If _XML_Read('Profil/Element[@Type="Name"]/Target_NameOption_Trad', 0, "", $oXMLProfil) = "Yes" Then $vTarget_NameOption_Trad_Value = _Coalesce(_XML_Read('Data/jeu/roms/rom[romid="' & $vRomId & '"]/trad', 0, $aRomList[8]), 0)
						$__iLineNumber = 264 & ' - If _XML_Read("Profil/Element[@Type="Name"]/Target_NameOption ...•'
						If _XML_Read('Profil/Element[@Type="Name"]/Target_NameOption_Hack', 0, "", $oXMLProfil) = "Yes" Then $vTarget_NameOption_Hack_Value = _Coalesce(_XML_Read('Data/jeu/roms/rom[romid="' & $vRomId & '"]/hack', 0, $aRomList[8]), 0)
						$__iLineNumber = 265 & ' - If _XML_Read("Profil/Element[@Type="Name"]/Target_NameOption ...•'
						If _XML_Read('Profil/Element[@Type="Name"]/Target_NameOption_Unl', 0, "", $oXMLProfil) = "Yes" Then $vTarget_NameOption_Unl_Value = _Coalesce(_XML_Read('Data/jeu/roms/rom[romid="' & $vRomId & '"]/unl', 0, $aRomList[8]), 0)
						$__iLineNumber = 266 & ' - If _XML_Read("Profil/Element[@Type="Name"]/Target_NameOption ...•'
						If _XML_Read('Profil/Element[@Type="Name"]/Target_NameOption_Alt', 0, "", $oXMLProfil) = "Yes" Then $vTarget_NameOption_Alt_Value = _Coalesce(_XML_Read('Data/jeu/roms/rom[romid="' & $vRomId & '"]/alt', 0, $aRomList[8]), 0)
						$__iLineNumber = 267 & ' - If _XML_Read("Profil/Element[@Type="Name"]/Target_NameOption ...•'
						If _XML_Read('Profil/Element[@Type="Name"]/Target_NameOption_Best', 0, "", $oXMLProfil) = "Yes" Then $vTarget_NameOption_Best_Value = _Coalesce(_XML_Read('Data/jeu/roms/rom[romid="' & $vRomId & '"]/best', 0, $aRomList[8]), 0)

						$__iLineNumber = 269 & ' - $vNameTag = ""•'
						$vNameTag = ""
						$__iLineNumber = 270 & ' - If $vTarget_NameOption_Clone_Value <> "0" Then $vNameTag = $ ...•'
						If $vTarget_NameOption_Clone_Value <> "0" Then $vNameTag = $vNameTag & "Clone, "
						$__iLineNumber = 271 & ' - If $vTarget_NameOption_Beta_Value <> "0" Then $vNameTag = $v ...•'
						If $vTarget_NameOption_Beta_Value <> "0" Then $vNameTag = $vNameTag & "Beta, "
						$__iLineNumber = 272 & ' - If $vTarget_NameOption_Demo_Value <> "0" Then $vNameTag = $v ...•'
						If $vTarget_NameOption_Demo_Value <> "0" Then $vNameTag = $vNameTag & "Demo, "
						$__iLineNumber = 273 & ' - If $vTarget_NameOption_Proto_Value <> "0" Then $vNameTag = $ ...•'
						If $vTarget_NameOption_Proto_Value <> "0" Then $vNameTag = $vNameTag & "Proto, "
						$__iLineNumber = 274 & ' - If $vTarget_NameOption_Trad_Value <> "0" Then $vNameTag = $v ...•'
						If $vTarget_NameOption_Trad_Value <> "0" Then $vNameTag = $vNameTag & "Trad, "
						$__iLineNumber = 275 & ' - If $vTarget_NameOption_Hack_Value <> "0" Then $vNameTag = $v ...•'
						If $vTarget_NameOption_Hack_Value <> "0" Then $vNameTag = $vNameTag & "Hack, "
						$__iLineNumber = 276 & ' - If $vTarget_NameOption_Unl_Value <> "0" Then $vNameTag = $vN ...•'
						If $vTarget_NameOption_Unl_Value <> "0" Then $vNameTag = $vNameTag & "Unl, "
						$__iLineNumber = 277 & ' - If $vTarget_NameOption_Alt_Value <> "0" Then $vNameTag = $vN ...•'
						If $vTarget_NameOption_Alt_Value <> "0" Then $vNameTag = $vNameTag & "Alt, "
						$__iLineNumber = 278 & ' - If $vTarget_NameOption_Best_Value <> "0" Then $vNameTag = $v ...•'
						If $vTarget_NameOption_Best_Value <> "0" Then $vNameTag = $vNameTag & "Best, "
						$__iLineNumber = 279 & ' - If StringRight($vNameTag, 2) = ", " Then $vNameTag = StringT ...•'
						If StringRight($vNameTag, 2) = ", " Then $vNameTag = StringTrimRight($vNameTag, 2)
						$__iLineNumber = 280 & ' - If $vNameTag <> "" Then $vValue = $vValue & " (" & $vNameTag ...•'
						If $vNameTag <> "" Then $vValue = $vValue & " (" & $vNameTag & ")"

						$__iLineNumber = 282 & ' - _LOG("Final name : " & $vValue, 1, $iLOGPath)•'
						_LOG("Final name : " & $vValue, 1, $iLOGPath)
				EndSwitch
				$__iLineNumber = 284 & ' - $vNode = _XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & ...•'
				$vNode = _XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & "]/Target_Value", 0, "", $oXMLProfil)
				$__iLineNumber = 285 & ' - Switch _Coalesce(StringLower(_XML_Read("/Profil/" & $vNodeTy ...•'
				$__iLineNumber = 286 & ' - Case "true"•'
				Switch _Coalesce(StringLower(_XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & "]/Target_CASE", 0, "", $oXMLProfil)), "default")
					Case "true"
						$__iLineNumber = 287 & ' - $vValue = StringUpper($vValue)•'
						$vValue = StringUpper($vValue)
						$__iLineNumber = 288 & ' - Case "false"•'
					Case "false"
						$__iLineNumber = 289 & ' - $vValue = StringLower($vValue)•'
						$vValue = StringLower($vValue)
				EndSwitch
				$__iLineNumber = 291 & ' - If $aConfig[5] <> 2 Then•'
				If $aConfig[5] <> 2 Then
					$__iLineNumber = 292 & ' - _LOG($vNode & " <-- " & $vValue, 1, $iLOGPath)•'
					_LOG($vNode & " <-- " & $vValue, 1, $iLOGPath)
					$__iLineNumber = 293 & ' - _XML_WriteValue($vNode, $vValue, "", $aConfig[8])•'
					_XML_WriteValue($vNode, $vValue, "", $aConfig[8])
				EndIf
			Case Else
				$__iLineNumber = 296 & ' - _LOG("End Of Elements", 1, $iLOGPath)•'
				_LOG("End Of Elements", 1, $iLOGPath)
				ExitLoop
		EndSwitch
		$__iLineNumber = 299 & ' - $vWhile = $vWhile + 1•'
		$vWhile = $vWhile + 1
	WEnd
	$__iLineNumber = 301 & ' - Return $aRomList•'
	Return $aRomList
EndFunc   ;==>_Game_Make

$__iLineNumber = 304 & ' - Func _XML_Read_Source($aRomList, $vBoucle, $aConfig, $oXMLPr ...•'
Func _XML_Read_Source($aRomList, $vBoucle, $aConfig, $oXMLProfil, $vWhile)
	$__iLineNumber = 305 & ' - Local $vXpath, $vValue, $vXpathTemp, $aXpathCountry, $aPathS ...•'
	Local $vXpath, $vValue, $vXpathTemp, $aXpathCountry, $aPathSplit, $sDrive, $sDir, $sFileName, $sExtension
	$__iLineNumber = 306 & ' - $vSource_Type = _XML_Read("/Profil/" & $vNodeType & "[" & $v ...•'
	$vSource_Type = _XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & "]/Source_Type", 0, "", $oXMLProfil)
	$__iLineNumber = 307 & ' - _LOG("/Profil/" & $vNodeType & "[" & $vWhile & "]/Source_Typ ...•'
	_LOG("/Profil/" & $vNodeType & "[" & $vWhile & "]/Source_Type = " & $vSource_Type, 1, $iLOGPath)
	$__iLineNumber = 308 & ' - Switch $vSource_Type•'
	$__iLineNumber = 309 & ' - Case "XML_Value"•'
	Switch $vSource_Type
		Case "XML_Value"
			$__iLineNumber = 310 & ' - _LOG("->XML_Value", 1, $iLOGPath)•'
			_LOG("->XML_Value", 1, $iLOGPath)
			$__iLineNumber = 311 & ' - If $aRomList[9] = 0 Or $aConfig[5] = 2 Then Return ""•'
			If $aRomList[9] = 0 Or $aConfig[5] = 2 Then Return ""
			$__iLineNumber = 312 & ' - $vXpath = _XML_Read("/Profil/" & $vNodeType & "[" & $vWhile  ...•'
			$vXpath = _XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & "]/Source_Value", 0, "", $oXMLProfil)
			$__iLineNumber = 313 & ' - _LOG("$vXpath : " & $vXpath, 3, $iLOGPath)•'
			_LOG("$vXpath : " & $vXpath, 3, $iLOGPath)
			$__iLineNumber = 314 & ' - If StringInStr($vXpath, "%LANG%") Then•'
			If StringInStr($vXpath, '%LANG%') Then
				$__iLineNumber = 315 & ' - _LOG("%LANG%", 3, $iLOGPath)•'
				_LOG('%LANG%', 3, $iLOGPath)
				$__iLineNumber = 316 & ' - Local $aLangPref = $aConfig[9]•'
				Local $aLangPref = $aConfig[9]
				$__iLineNumber = 317 & ' - For $vBoucle2 = 1 To UBound($aLangPref) - 1•'
				For $vBoucle2 = 1 To UBound($aLangPref) - 1
					$__iLineNumber = 318 & ' - $vXpathTemp = StringReplace($vXpath, "%LANG%", $aLangPref[$v ...•'
					$vXpathTemp = StringReplace($vXpath, '%LANG%', $aLangPref[$vBoucle2])
					$__iLineNumber = 319 & ' - $vValue = _XML_Read($vXpathTemp, 0, $aRomList[8])•'
					$vValue = _XML_Read($vXpathTemp, 0, $aRomList[8])
					$__iLineNumber = 320 & ' - If $vValue <> -1 And $vValue <> "" Then Return $vValue•'
					If $vValue <> -1 And $vValue <> "" Then Return $vValue
				Next
			EndIf

			$__iLineNumber = 324 & ' - If StringInStr($vXpath, "%COUNTRY%") Then•'
			If StringInStr($vXpath, '%COUNTRY%') Then
				$__iLineNumber = 325 & ' - _LOG("%COUNTRY%", 3, $iLOGPath)•'
				_LOG('%COUNTRY%', 3, $iLOGPath)
				$__iLineNumber = 326 & ' - $aXpathCountry = _Fallback($aConfig, $vXpath, $aRomList[8])•'
				$aXpathCountry = _Fallback($aConfig, $vXpath, $aRomList[8])
				$__iLineNumber = 327 & ' - For $vBoucle2 = 1 To UBound($aXpathCountry) - 1•'
				For $vBoucle2 = 1 To UBound($aXpathCountry) - 1
					$__iLineNumber = 328 & ' - $vValue = _XML_Read($aXpathCountry[$vBoucle2], 0, $aRomList[ ...•'
					$vValue = _XML_Read($aXpathCountry[$vBoucle2], 0, $aRomList[8])
					$__iLineNumber = 329 & ' - _LOG("COUNTRY " & $aXpathCountry[$vBoucle2] & "=" & $vValue, ...•'
					_LOG("COUNTRY " & $aXpathCountry[$vBoucle2] & "=" & $vValue, 1, $iLOGPath)
					$__iLineNumber = 330 & ' - If $vValue <> -1 And $vValue <> "" Then Return $vValue•'
					If $vValue <> -1 And $vValue <> "" Then Return $vValue
				Next
			EndIf
			$__iLineNumber = 333 & ' - _LOG("NO TAG", 3, $iLOGPath)•'
			_LOG('NO TAG', 3, $iLOGPath)
			$__iLineNumber = 334 & ' - $vValue = _XML_Read($vXpath, 0, $aRomList[8])•'
			$vValue = _XML_Read($vXpath, 0, $aRomList[8])
			$__iLineNumber = 335 & ' - _LOG($vXpath & "=" & $vValue, 1, $iLOGPath)•'
			_LOG($vXpath & "=" & $vValue, 1, $iLOGPath)
			$__iLineNumber = 336 & ' - If $vValue <> -1 Then Return $vValue•'
			If $vValue <> -1 Then Return $vValue
			$__iLineNumber = 337 & ' - Return ""•'
			Return ""

			$__iLineNumber = 339 & ' - Case "XML_Attribute"•'
		Case "XML_Attribute"
			$__iLineNumber = 340 & ' - _LOG("->XML_Attribute", 1, $iLOGPath)•'
			_LOG("->XML_Attribute", 1, $iLOGPath)
			$__iLineNumber = 341 & ' - If $aRomList[9] = 0 Or $aConfig[5] = 2 Then Return ""•'
			If $aRomList[9] = 0 Or $aConfig[5] = 2 Then Return ""
			$__iLineNumber = 342 & ' - Return _XML_Read(_XML_Read("/Profil/" & $vNodeType & "[" & $ ...•'
			Return _XML_Read(_XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & "]/Source_Value", 1, "", $oXMLProfil), 0, $aRomList[8])
			$__iLineNumber = 343 & ' - Case "XML_Download"•'
		Case "XML_Download"
			$__iLineNumber = 344 & ' - _LOG("->XML_Download", 1, $iLOGPath)•'
			_LOG("->XML_Download", 1, $iLOGPath)
			$__iLineNumber = 345 & ' - If $aRomList[9] = 0 Then Return ""•'
			If $aRomList[9] = 0 Then Return ""
			$__iLineNumber = 346 & ' - $vXpath = _XML_Read("/Profil/" & $vNodeType & "[" & $vWhile  ...•'
			$vXpath = _XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & "]/Source_Value", 0, "", $oXMLProfil)
			$__iLineNumber = 347 & ' - $aXpathCountry = _Fallback($aConfig, $vXpath, $aRomList[8])•'
			$aXpathCountry = _Fallback($aConfig, $vXpath, $aRomList[8])
			$__iLineNumber = 348 & ' - For $vBoucle2 = 1 To UBound($aXpathCountry) - 1•'
			For $vBoucle2 = 1 To UBound($aXpathCountry) - 1
				$__iLineNumber = 349 & ' - $vDownloadURL = _Coalesce(_XML_Read($aXpathCountry[$vBoucle2 ...•'
				$vDownloadURL = _Coalesce(_XML_Read($aXpathCountry[$vBoucle2], 0, $aRomList[8]), -1)
				$__iLineNumber = 350 & ' - If $vDownloadURL < 0 Then•'
				If $vDownloadURL < 0 Then
					$__iLineNumber = 351 & ' - If $aXpathCountry[$vBoucle2] <> "None" Then _LOG($aXpathCoun ...•'
					If $aXpathCountry[$vBoucle2] <> 'None' Then _LOG($aXpathCountry[$vBoucle2] & " problem : " & $vDownloadURL, 3, $iLOGPath)
				Else
					$__iLineNumber = 353 & ' - $vDownloadMaxWidth = _Coalesce(_XML_Read("/Profil/" & $vNode ...•'
					$vDownloadMaxWidth = _Coalesce(_XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & "]/Target_Image_Width", 0, "", $oXMLProfil), 0)
					$__iLineNumber = 354 & ' - $vDownloadMaxHeight = _Coalesce(_XML_Read("/Profil/" & $vNod ...•'
					$vDownloadMaxHeight = _Coalesce(_XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & "]/Target_Image_Height", 0, "", $oXMLProfil), 0)

					$__iLineNumber = 356 & ' - $vDownloadTag = _XML_Read("/Profil/" & $vNodeType & "[" & $v ...•'
					$vDownloadTag = _XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & "]/Source_Download_Tag", 0, "", $oXMLProfil)
					$__iLineNumber = 357 & ' - If $vNodeType = "Folder" Then $vDownloadTag = $vDownloadTag  ...•'
					If $vNodeType = "Folder" Then $vDownloadTag = $vDownloadTag & "-folder"
					$__iLineNumber = 358 & ' - $vDownloadExt = _Coalesce(IniRead($iINIPath, "LAST_USE", "$v ...•'
					$vDownloadExt = _Coalesce(IniRead($iINIPath, "LAST_USE", "$vTarget_Image_Ext", ""), _XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & "]/Source_Download_Ext", 0, "", $oXMLProfil))
					$__iLineNumber = 359 & ' - $aPathSplit = _PathSplit(StringReplace($aRomList[0], "\", "_ ...•'
					$aPathSplit = _PathSplit(StringReplace($aRomList[0], "\", "_"), $sDrive, $sDir, $sFileName, $sExtension)
					$__iLineNumber = 360 & ' - $vSource_ImagePath = $aConfig[3] & "\" & $sFileName & $vDown ...•'
					$vSource_ImagePath = $aConfig[3] & "\" & $sFileName & $vDownloadTag & "." & $vDownloadExt
					$__iLineNumber = 361 & ' - $vSource_ImagePath = _Picture_Download($vDownloadURL, $vSour ...•'
					$vSource_ImagePath = _Picture_Download($vDownloadURL, $vSource_ImagePath, $oXMLProfil, $vDownloadMaxWidth, $vDownloadMaxHeight)

					$__iLineNumber = 363 & ' - If $vSource_ImagePath < 0 Then Return -1•'
					If $vSource_ImagePath < 0 Then Return -1

					$__iLineNumber = 365 & ' - $vTarget_ImagePath = $aConfig[4] & $sFileName & $vDownloadTa ...•'
					$vTarget_ImagePath = $aConfig[4] & $sFileName & $vDownloadTag & "." & $vDownloadExt
					$__iLineNumber = 366 & ' - If $vNodeType = "Folder" Then•'
					If $vNodeType = "Folder" Then
						$__iLineNumber = 367 & ' - $vCheckExist = _XML_NodeExists($aConfig[8], _XML_Read("/Prof ...•'
						$vCheckExist = _XML_NodeExists($aConfig[8], _XML_Read('/Profil/Folder/Target_Value', 0, "", $oXMLProfil) & '[* = "' & $vTarget_ImagePath & '"]')
					Else
						$__iLineNumber = 369 & ' - $vCheckExist = _XML_NodeExists($aConfig[8], _XML_Read("/Prof ...•'
						$vCheckExist = _XML_NodeExists($aConfig[8], _XML_Read('/Profil/Game/Target_Value', 0, "", $oXMLProfil) & '[* = "' & $vTarget_ImagePath & '"]')
					EndIf
					$__iLineNumber = 371 & ' - If $vCheckExist = $XML_RET_SUCCESS Then•'
					If $vCheckExist = $XML_RET_SUCCESS Then
						$__iLineNumber = 372 & ' - _LOG(_XML_Read("/Profil/Game/Target_Value", 0, "", $oXMLProf ...•'
						_LOG(_XML_Read('/Profil/Game/Target_Value', 0, "", $oXMLProfil) & '[* = "' & $vTarget_ImagePath & '"]' & " Already exist in XML ( " & $vCheckExist & ")", 1, $iLOGPath)
						$__iLineNumber = 373 & ' - Return -2•'
						Return -2
					EndIf

					$__iLineNumber = 376 & ' - Return $vTarget_ImagePath•'
					Return $vTarget_ImagePath
				EndIf
			Next
			$__iLineNumber = 379 & ' - Return ""•'
			Return ""
			$__iLineNumber = 380 & ' - Case "Fixe_Value"•'
		Case "Fixe_Value"
			$__iLineNumber = 381 & ' - _LOG("->Fixe_Value", 1, $iLOGPath)•'
			_LOG("->Fixe_Value", 1, $iLOGPath)
			$__iLineNumber = 382 & ' - Return _XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & " ...•'
			Return _XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & "]/Source_Value", 0, "", $oXMLProfil)
			$__iLineNumber = 383 & ' - Case "Variable_Value"•'
		Case "Variable_Value"
			$__iLineNumber = 384 & ' - _LOG("->Variable_Value", 1, $iLOGPath)•'
			_LOG("->Variable_Value", 1, $iLOGPath)
			$__iLineNumber = 385 & ' - Switch _XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & " ...•'
			$__iLineNumber = 386 & ' - Case "%XML_Rom_Path%"•'
			Switch _XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & "]/Source_Value", 0, "", $oXMLProfil)
				Case '%XML_Rom_Path%'
					$__iLineNumber = 387 & ' - $vSystem = StringSplit(IniRead($iINIPath, "LAST_USE", "$vSou ...•'
					$vSystem = StringSplit(IniRead($iINIPath, "LAST_USE", "$vSource_RomPath", ""), "\")
					$__iLineNumber = 388 & ' - $vSystem = $vSystem[UBound($vSystem) - 1]•'
					$vSystem = $vSystem[UBound($vSystem) - 1]
					$__iLineNumber = 389 & ' - $vXMLRomPath = $aConfig[2] & StringReplace($aRomList[0], "\" ...•'
					$vXMLRomPath = $aConfig[2] & StringReplace($aRomList[0], "\", "/")
					$__iLineNumber = 390 & ' - $vXMLRomPath = StringReplace($vXMLRomPath, "%system%", $vSys ...•'
					$vXMLRomPath = StringReplace($vXMLRomPath, '%system%', $vSystem)
					$__iLineNumber = 391 & ' - Return $vXMLRomPath•'
					Return $vXMLRomPath
					$__iLineNumber = 392 & ' - Case "%AutoHide%"•'
				Case '%AutoHide%'
					$__iLineNumber = 393 & ' - If $aRomList[3] = 2 Or $aRomList[3] = 3 Then Return "true"•'
					If $aRomList[3] = 2 Or $aRomList[3] = 3 Then Return "true"
				Case Else
					$__iLineNumber = 395 & ' - _LOG("SOURCE Unknown", 1, $iLOGPath)•'
					_LOG("SOURCE Unknown", 1, $iLOGPath)
					$__iLineNumber = 396 & ' - Return ""•'
					Return ""
			EndSwitch
			$__iLineNumber = 398 & ' - Case "MIX_Template"•'
		Case "MIX_Template"
			$__iLineNumber = 399 & ' - _LOG("->MIX_Template", 1, $iLOGPath)•'
			_LOG("->MIX_Template", 1, $iLOGPath)
			$__iLineNumber = 400 & ' - If $aRomList[9] = 0 And $aConfig[6] = 0 Then Return ""•'
			If $aRomList[9] = 0 And $aConfig[6] = 0 Then Return ""
			$__iLineNumber = 401 & ' - Local $vDownloadTag, $vDownloadExt, $vTargetPicturePath, $aP ...•'
			Local $vDownloadTag, $vDownloadExt, $vTargetPicturePath, $aPathSplit, $sDrive, $sDir, $sFileName, $sExtension
			$__iLineNumber = 402 & ' - $vDownloadTag = _XML_Read("/Profil/" & $vNodeType & "[" & $v ...•'
			$vDownloadTag = _XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & "]/Source_Download_Tag", 0, "", $oXMLProfil)
			$__iLineNumber = 403 & ' - If $vNodeType = "Folder" Then $vDownloadTag = $vDownloadTag  ...•'
			If $vNodeType = "Folder" Then $vDownloadTag = $vDownloadTag & "-folder"
			$__iLineNumber = 404 & ' - $vDownloadExt = _XML_Read("/Profil/" & $vNodeType & "[" & $v ...•'
			$vDownloadExt = _XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & "]/Source_Download_Ext", 0, "", $oXMLProfil)
			$__iLineNumber = 405 & ' - $aPathSplit = _PathSplit(StringReplace($aRomList[0], "\", "_ ...•'
			$aPathSplit = _PathSplit(StringReplace($aRomList[0], "\", "_"), $sDrive, $sDir, $sFileName, $sExtension)
			$__iLineNumber = 406 & ' - $vTargetPicturePath = $aConfig[4] & $sFileName & $vDownloadT ...•'
			$vTargetPicturePath = $aConfig[4] & $sFileName & $vDownloadTag & "." & $vDownloadExt
			$__iLineNumber = 407 & ' - Switch _XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & " ...•'
			$__iLineNumber = 408 & ' - Case "%Local_Path_File%"•'
			Switch _XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & "]/Source_Download_Path", 0, "", $oXMLProfil)
				Case '%Local_Path_File%'
					$__iLineNumber = 409 & ' - $vDownloadPath = $aConfig[3] & "\" & $sFileName & $vDownload ...•'
					$vDownloadPath = $aConfig[3] & "\" & $sFileName & $vDownloadTag & "." & $vDownloadExt
				Case Else ; For the futur
					$__iLineNumber = 411 & ' - $vDownloadPath = $aConfig[3] & "\" & $sFileName & $vDownload ...•'
					$vDownloadPath = $aConfig[3] & "\" & $sFileName & $vDownloadTag & "." & $vDownloadExt
			EndSwitch
			$__iLineNumber = 413 & ' - If FileExists($vDownloadPath) And $aConfig[5] <> 2 Then Retu ...•'
			If FileExists($vDownloadPath) And $aConfig[5] <> 2 Then Return $vTargetPicturePath

			$__iLineNumber = 415 & ' - $vValue = _MIX_Engine($aRomList, $vBoucle, $aConfig, $oXMLPr ...•'
			$vValue = _MIX_Engine($aRomList, $vBoucle, $aConfig, $oXMLProfil)
			$__iLineNumber = 416 & ' - If Not FileExists($vValue) Then Return -1•'
			If Not FileExists($vValue) Then Return -1
			$__iLineNumber = 417 & ' - FileCopy($vValue, $vDownloadPath, $FC_OVERWRITE)•'
			FileCopy($vValue, $vDownloadPath, $FC_OVERWRITE)

			$__iLineNumber = 419 & ' - _LOG("MIX Template finished (" & $vTargetPicturePath & ")",  ...•'
			_LOG("MIX Template finished (" & $vTargetPicturePath & ")", 1, $iLOGPath)
			$__iLineNumber = 420 & ' - Return $vTargetPicturePath•'
			Return $vTargetPicturePath
		Case Else
			$__iLineNumber = 422 & ' - _LOG("->SOURCE Unknown", 1, $iLOGPath)•'
			_LOG("->SOURCE Unknown", 1, $iLOGPath)
			$__iLineNumber = 423 & ' - Return ""•'
			Return ""
	EndSwitch
EndFunc   ;==>_XML_Read_Source

$__iLineNumber = 427 & ' - Func _Fallback($aConfig, $vXpath, $vSource_RomXMLPath)•'
Func _Fallback($aConfig, $vXpath, $vSource_RomXMLPath)
	$__iLineNumber = 428 & ' - Local $vCountryPref = "", $vIdGenre = ""•'
	Local $vCountryPref = '', $vIdGenre = ''
	$__iLineNumber = 429 & ' - If StringInStr($vXpath, "%COUNTRY%") Then•'
	If StringInStr($vXpath, '%COUNTRY%') Then
		$__iLineNumber = 430 & ' - Local $aCountryPref = $aConfig[10]•'
		Local $aCountryPref = $aConfig[10]
	Else
		$__iLineNumber = 432 & ' - Local $aCountryPref[2] = ["", $vXpath]•'
		Local $aCountryPref[2] = ["", $vXpath]
	EndIf
	$__iLineNumber = 434 & ' - Local $aXpathCountry[UBound($aCountryPref)]•'
	Local $aXpathCountry[UBound($aCountryPref)]
	$__iLineNumber = 435 & ' - For $vBoucle = 1 To UBound($aCountryPref) - 1•'
	For $vBoucle = 1 To UBound($aCountryPref) - 1
		$__iLineNumber = 436 & ' - $vCountryPref = $aCountryPref[$vBoucle]•'
		$vCountryPref = $aCountryPref[$vBoucle]
		$__iLineNumber = 437 & ' - If $vCountryPref = "%COUNTRY%" Then $vCountryPref = _XML_Rea ...•'
		If $vCountryPref = '%COUNTRY%' Then $vCountryPref = _XML_Read("Data/jeu/regionshortnames/regionshortname", 0, $vSource_RomXMLPath)
		$__iLineNumber = 438 & ' - $aXpathCountry[$vBoucle] = StringReplace($vXpath, "%COUNTRY% ...•'
		$aXpathCountry[$vBoucle] = StringReplace($vXpath, '%COUNTRY%', $vCountryPref)
	Next
	$__iLineNumber = 440 & ' - Return $aXpathCountry•'
	Return $aXpathCountry
EndFunc   ;==>_Fallback

$__iLineNumber = 443 & ' - Func _Picture_Download($vDownloadURL, $vSource_ImagePath, $o ...•'
Func _Picture_Download($vDownloadURL, $vSource_ImagePath, $oXMLProfil, $vDownloadMaxWidth = 0, $vDownloadMaxHeight = 0)
	$__iLineNumber = 444 & ' - Local $vDownloadOutputFormat, $aPathSplit, $sDrive, $sDir, $ ...•'
	Local $vDownloadOutputFormat, $aPathSplit, $sDrive, $sDir, $sFileName, $sExtension
	$__iLineNumber = 445 & ' - $aPathSplit = _PathSplit($vSource_ImagePath, $sDrive, $sDir, ...•'
	$aPathSplit = _PathSplit($vSource_ImagePath, $sDrive, $sDir, $sFileName, $sExtension)
	$__iLineNumber = 446 & ' - If $vDownloadMaxWidth > 0 Then•'
	If $vDownloadMaxWidth > 0 Then
		$__iLineNumber = 447 & ' - $vDownloadMaxWidth = "&maxwidth=" & $vDownloadMaxWidth•'
		$vDownloadMaxWidth = "&maxwidth=" & $vDownloadMaxWidth
	Else
		$__iLineNumber = 449 & ' - $vDownloadMaxWidth = "&maxwidth=" & _Coalesce(IniRead($iINIP ...•'
		$vDownloadMaxWidth = "&maxwidth=" & _Coalesce(IniRead($iINIPath, "LAST_USE", "$vTarget_Image_Width", ""), _XML_Read("Profil/General/Target_Image_Width", 0, "", $oXMLProfil))
	EndIf
	$__iLineNumber = 451 & ' - If $vDownloadMaxHeight > 0 Then•'
	If $vDownloadMaxHeight > 0 Then
		$__iLineNumber = 452 & ' - $vDownloadMaxHeight = "&maxheight=" & $vDownloadMaxHeight•'
		$vDownloadMaxHeight = "&maxheight=" & $vDownloadMaxHeight
	Else
		$__iLineNumber = 454 & ' - $vDownloadMaxHeight = "&maxheight=" & _Coalesce(IniRead($iIN ...•'
		$vDownloadMaxHeight = "&maxheight=" & _Coalesce(IniRead($iINIPath, "LAST_USE", "$vTarget_Image_Height", ""), _XML_Read("Profil/General/Target_Image_Height", 0, "", $oXMLProfil))
	EndIf
	$__iLineNumber = 456 & ' - $vDownloadOutputFormat = "&outputformat=" & StringMid($sExte ...•'
	$vDownloadOutputFormat = "&outputformat=" & StringMid($sExtension, 2)

	$__iLineNumber = 458 & ' - If FileExists($vSource_ImagePath) And $aConfig[5] <> 2 Then•'
	If FileExists($vSource_ImagePath) And $aConfig[5] <> 2 Then
		$__iLineNumber = 459 & ' - _LOG($vSource_ImagePath & " File already exist", 1, $iLOGPat ...•'
		_LOG($vSource_ImagePath & " File already exist", 1, $iLOGPath)
		$__iLineNumber = 460 & ' - Return $vSource_ImagePath•'
		Return $vSource_ImagePath
	EndIf

	$__iLineNumber = 463 & ' - $vDownloadURL = StringReplace($vDownloadURL, "#sspassword#", ...•'
	$vDownloadURL = StringReplace($vDownloadURL, "#sspassword#", $vSSPassword) & $vDownloadMaxWidth & $vDownloadMaxHeight & $vDownloadOutputFormat
	$__iLineNumber = 464 & ' - $vValue = _DownloadWRetry($vDownloadURL, $vSource_ImagePath)•'
	$vValue = _DownloadWRetry($vDownloadURL, $vSource_ImagePath)
	$__iLineNumber = 465 & ' - If $vValue < 0 Or Not FileExists($vSource_ImagePath) Then•'
	If $vValue < 0 Or Not FileExists($vSource_ImagePath) Then
		$__iLineNumber = 466 & ' - Return -1•'
		Return -1
	Else
		$__iLineNumber = 468 & ' - Return $vSource_ImagePath•'
		Return $vSource_ImagePath
	EndIf
EndFunc   ;==>_Picture_Download

$__iLineNumber = 472 & ' - Func _MIX_Engine($aRomList, $vBoucle, $aConfig, $oXMLProfil)•'
Func _MIX_Engine($aRomList, $vBoucle, $aConfig, $oXMLProfil)
	$__iLineNumber = 473 & ' - Local $vMIXTemplatePath = $iScriptPath & "\Mix\TEMP\"•'
	Local $vMIXTemplatePath = $iScriptPath & "\Mix\TEMP\"
	$__iLineNumber = 474 & ' - Local $oMixConfig = _XML_Open($vMIXTemplatePath & "config.xm ...•'
	Local $oMixConfig = _XML_Open($vMIXTemplatePath & "config.xml")
	$__iLineNumber = 475 & ' - Local $vTarget_Width = _Coalesce(IniRead($iINIPath, "LAST_US ...•'
	Local $vTarget_Width = _Coalesce(IniRead($iINIPath, "LAST_USE", "$vTarget_Image_Width", ""), _XML_Read("/Profil/General/Target_Width", 0, "", $oMixConfig))
	$__iLineNumber = 476 & ' - Local $vTarget_Height = _Coalesce(IniRead($iINIPath, "LAST_U ...•'
	Local $vTarget_Height = _Coalesce(IniRead($iINIPath, "LAST_USE", "$vTarget_Image_Height", ""), _XML_Read("/Profil/General/Target_Height", 0, "", $oMixConfig))
	$__iLineNumber = 477 & ' - Local $vID_System = $aConfig[12]•'
	Local $vID_System = $aConfig[12]
	$__iLineNumber = 478 & ' - Local $vPicTarget = -1, $vWhile = 1, $vFinalValue = ""•'
	Local $vPicTarget = -1, $vWhile = 1, $vFinalValue = ""
	$__iLineNumber = 479 & ' - Dim $aMiXPicTemp[1]•'
	Dim $aMiXPicTemp[1]
	Sleep(250)
	$__iLineNumber = 481 & ' - FileDelete($iTEMPPath & "\MIX")•'
	FileDelete($iTEMPPath & "\MIX")
	Sleep(250)
	$__iLineNumber = 483 & ' - DirCreate($iTEMPPath & "\MIX")•'
	DirCreate($iTEMPPath & "\MIX")
	$__iLineNumber = 484 & ' - FileSetAttrib($iTEMPPath, "+H")•'
	FileSetAttrib($iTEMPPath, "+H")
	$__iLineNumber = 485 & ' - While 1•'
	While 1
		$__iLineNumber = 486 & ' - $iString = ""•'
		$iString = ""
		$__iLineNumber = 487 & ' - Switch StringLower(_XML_Read("/Profil/Element[" & $vWhile &  ...•'
		$__iLineNumber = 488 & ' - Case "fixe_value"•'
		Switch StringLower(_XML_Read("/Profil/Element[" & $vWhile & "]/Source_Type", 0, "", $oMixConfig))
			Case "fixe_value"
				$__iLineNumber = 489 & ' - $vPicTarget = $iTEMPPath & "\MIX\" & _XML_Read("/Profil/Elem ...•'
				$vPicTarget = $iTEMPPath & "\MIX\" & _XML_Read("/Profil/Element[" & $vWhile & "]/Name", 0, "", $oMixConfig) & ".png"
				$__iLineNumber = 490 & ' - If Not FileCopy($vMIXTemplatePath & _XML_Read("/Profil/Eleme ...•'
				If Not FileCopy($vMIXTemplatePath & _XML_Read("/Profil/Element[" & $vWhile & "]/Source_Value", 0, "", $oMixConfig), $vPicTarget, $FC_OVERWRITE + $FC_CREATEPATH) Then
					$__iLineNumber = 491 & ' - _LOG("Error copying " & $vMIXTemplatePath & _XML_Read("/Prof ...•'
					_LOG("Error copying " & $vMIXTemplatePath & _XML_Read("/Profil/Element[" & $vWhile & "]/Source_Value", 0, "", $oMixConfig) & " to " & $vPicTarget, 2, $iLOGPath)
				Else
					$__iLineNumber = 493 & ' - $aPicParameters = _MIX_Engine_Dim($vWhile, $oMixConfig)•'
					$aPicParameters = _MIX_Engine_Dim($vWhile, $oMixConfig)
					$__iLineNumber = 494 & ' - _GDIPlus_Imaging($vPicTarget, $aPicParameters, $vTarget_Widt ...•'
					_GDIPlus_Imaging($vPicTarget, $aPicParameters, $vTarget_Width, $vTarget_Height)
					$__iLineNumber = 495 & ' - _LOG("fixe_value : " & $vPicTarget & " Created", 1, $iLOGPat ...•'
					_LOG("fixe_value : " & $vPicTarget & " Created", 1, $iLOGPath)
					$__iLineNumber = 496 & ' - _ArrayAdd($aMiXPicTemp, $vPicTarget)•'
					_ArrayAdd($aMiXPicTemp, $vPicTarget)
				EndIf
				$__iLineNumber = 498 & ' - Case "xml_value"•'
			Case "xml_value"
				$__iLineNumber = 499 & ' - $vPicTarget = $iTEMPPath & "\MIX\" & _XML_Read("/Profil/Elem ...•'
				$vPicTarget = $iTEMPPath & "\MIX\" & _XML_Read("/Profil/Element[" & $vWhile & "]/Name", 0, "", $oMixConfig) & ".png"
				$__iLineNumber = 500 & ' - $vXpath = _XML_Read("/Profil/Element[" & $vWhile & "]/Source ...•'
				$vXpath = _XML_Read("/Profil/Element[" & $vWhile & "]/Source_Value", 0, "", $oMixConfig)
				$__iLineNumber = 501 & ' - $vOrigin = StringLower(_XML_Read("/Profil/Element[" & $vWhil ...•'
				$vOrigin = StringLower(_XML_Read("/Profil/Element[" & $vWhile & "]/source_Origin", 0, "", $oMixConfig))
				$__iLineNumber = 502 & ' - If $vOrigin = -1 Then $vOrigin = "game"•'
				If $vOrigin = -1 Then $vOrigin = 'game'
				$__iLineNumber = 503 & ' - $aPicParameters = _MIX_Engine_Dim($vWhile, $oMixConfig)•'
				$aPicParameters = _MIX_Engine_Dim($vWhile, $oMixConfig)
				$__iLineNumber = 504 & ' - $aXpathCountry = _Fallback($aConfig, $vXpath, $aRomList[8])•'
				$aXpathCountry = _Fallback($aConfig, $vXpath, $aRomList[8])
				$__iLineNumber = 505 & ' - For $vBoucle2 = 1 To UBound($aXpathCountry) - 1•'
				For $vBoucle2 = 1 To UBound($aXpathCountry) - 1
					$__iLineNumber = 506 & ' - If Not FileExists($vPicTarget) Then•'
					If Not FileExists($vPicTarget) Then
						$__iLineNumber = 507 & ' - If StringInStr($aXpathCountry[$vBoucle2], "%IDGENRE%") Then•'
						If StringInStr($aXpathCountry[$vBoucle2], '%IDGENRE%') Then
							$__iLineNumber = 508 & ' - $vIdGenre = _XML_Read("Data/jeu/genres/genres_id/genre_id",  ...•'
							$vIdGenre = _XML_Read("Data/jeu/genres/genres_id/genre_id", 0, $aRomList[8])
							$__iLineNumber = 509 & ' - $aXpathCountry[$vBoucle2] = StringReplace($aXpathCountry[$vB ...•'
							$aXpathCountry[$vBoucle2] = StringReplace($aXpathCountry[$vBoucle2], '%IDGENRE%', $vIdGenre)
						EndIf
						$__iLineNumber = 511 & ' - Switch $vOrigin•'
						$__iLineNumber = 512 & ' - Case "game"•'
						Switch $vOrigin
							Case 'game'
								$__iLineNumber = 513 & ' - $vDownloadURL = _Coalesce(_XML_Read($aXpathCountry[$vBoucle2 ...•'
								$vDownloadURL = _Coalesce(_XML_Read($aXpathCountry[$vBoucle2], 0, $aRomList[8]), -1)
								$__iLineNumber = 514 & ' - $vCRC = _Coalesce(_XML_Read($aXpathCountry[$vBoucle2] & "_cr ...•'
								$vCRC = _Coalesce(_XML_Read($aXpathCountry[$vBoucle2] & "_crc", 0, $aRomList[8]), Default)
								$__iLineNumber = 515 & ' - If $vDownloadURL = -1 Then _LOG("No URL : " & $aXpathCountry ...•'
								If $vDownloadURL = -1 Then _LOG("No URL : " & $aXpathCountry[$vBoucle2], 1, $iLOGPath)
								$__iLineNumber = 516 & ' - Case "system"•'
							Case 'system'
								$__iLineNumber = 517 & ' - $vDownloadURL = _Coalesce(_XML_Read(StringReplace($aXpathCou ...•'
								$vDownloadURL = _Coalesce(_XML_Read(StringReplace($aXpathCountry[$vBoucle2], "%IDSYSTEM%", $vID_System), 0, "", $oXMLSystem), -1)
								$__iLineNumber = 518 & ' - $vCRC = _Coalesce(_XML_Read(StringReplace($aXpathCountry[$vB ...•'
								$vCRC = _Coalesce(_XML_Read(StringReplace($aXpathCountry[$vBoucle2], "%IDSYSTEM%", $vID_System) & "_crc", 0, "", $oXMLSystem), Default)
								$__iLineNumber = 519 & ' - If $vDownloadURL = -1 Then _LOG("No URL : " & StringReplace( ...•'
								If $vDownloadURL = -1 Then _LOG("No URL : " & StringReplace($aXpathCountry[$vBoucle2], "%IDSYSTEM%", $vID_System), 1, $iLOGPath)
						EndSwitch
						$__iLineNumber = 521 & ' - If Not ($vDownloadURL < 0) Then•'
						If Not ($vDownloadURL < 0) Then
							$__iLineNumber = 522 & ' - $vValue = _DownloadWRetry(StringReplace($vDownloadURL, "#ssp ...•'
							$vValue = _DownloadWRetry(StringReplace($vDownloadURL, "#sspassword#", $vSSPassword), $vPicTarget, 15, 20, $vCRC)
							$__iLineNumber = 523 & ' - If $vValue < 0 Then•'
							If $vValue < 0 Then
								$__iLineNumber = 524 & ' - _LOG("xml_value : " & $vPicTarget & " Not Added", 2, $iLOGPa ...•'
								_LOG("xml_value : " & $vPicTarget & " Not Added", 2, $iLOGPath)
							Else
								$__iLineNumber = 526 & ' - $vRotationLvl = _Coalesce(_XML_Read("/Profil/Element[" & $vW ...•'
								$vRotationLvl = _Coalesce(_XML_Read("/Profil/Element[" & $vWhile & "]/Target_Rotation", 0, "", $oMixConfig), 0)
								$__iLineNumber = 527 & ' - If $vRotationLvl > 0 Then•'
								If $vRotationLvl > 0 Then
									$__iLineNumber = 528 & ' - If _GDIPlus_Rotation($vPicTarget, $vRotationLvl) = -1 Then _ ...•'
									If _GDIPlus_Rotation($vPicTarget, $vRotationLvl) = -1 Then _LOG("Rotation Failed", 2, $iLOGPath)
								EndIf
								$__iLineNumber = 530 & ' - _GDIPlus_Imaging($vPicTarget, $aPicParameters, $vTarget_Widt ...•'
								_GDIPlus_Imaging($vPicTarget, $aPicParameters, $vTarget_Width, $vTarget_Height)
								$__iLineNumber = 531 & ' - _ArrayAdd($aMiXPicTemp, $vPicTarget)•'
								_ArrayAdd($aMiXPicTemp, $vPicTarget)
								$__iLineNumber = 532 & ' - _LOG("xml_value : " & $vPicTarget & " Created", 1, $iLOGPath ...•'
								_LOG("xml_value : " & $vPicTarget & " Created", 1, $iLOGPath)
							EndIf
						EndIf
					Else
						$__iLineNumber = 536 & ' - _LOG("File : " & $vPicTarget & " already exist", 1, $iLOGPat ...•'
						_LOG("File : " & $vPicTarget & " already exist", 1, $iLOGPath)
					EndIf
				Next
				$__iLineNumber = 539 & ' - Case "text"•'
			Case "text"
				$__iLineNumber = 540 & ' - Switch StringLower(_XML_Read("/Profil/Element[" & $vWhile &  ...•'
				$__iLineNumber = 541 & ' - Case "xml_value"•'
				Switch StringLower(_XML_Read("/Profil/Element[" & $vWhile & "]/Source_TextType", 0, "", $oMixConfig))
					Case "xml_value"
						$__iLineNumber = 542 & ' - $vXpath = (_XML_Read("/Profil/Element[" & $vWhile & "]/Sourc ...•'
						$vXpath = (_XML_Read("/Profil/Element[" & $vWhile & "]/Source_Value", 0, "", $oMixConfig))
						$__iLineNumber = 543 & ' - If StringInStr($vXpath, "%LANG%") Then•'
						If StringInStr($vXpath, '%LANG%') Then
							$__iLineNumber = 544 & ' - Local $aLangPref = $aConfig[9]•'
							Local $aLangPref = $aConfig[9]
							$__iLineNumber = 545 & ' - For $vBoucle2 = 1 To UBound($aLangPref) - 1•'
							For $vBoucle2 = 1 To UBound($aLangPref) - 1
								$__iLineNumber = 546 & ' - $vXpathTemp = StringReplace($vXpath, "%LANG%", $aLangPref[$v ...•'
								$vXpathTemp = StringReplace($vXpath, '%LANG%', $aLangPref[$vBoucle2])
								$__iLineNumber = 547 & ' - $vValue = _XML_Read($vXpathTemp, 0, $aRomList[8])•'
								$vValue = _XML_Read($vXpathTemp, 0, $aRomList[8])
								$__iLineNumber = 548 & ' - If $vValue <> -1 And $vValue <> "" Then•'
								If $vValue <> -1 And $vValue <> "" Then
									$__iLineNumber = 549 & ' - $vBoucle2 = UBound($aLangPref) - 1•'
									$vBoucle2 = UBound($aLangPref) - 1
									$__iLineNumber = 550 & ' - $iString = $vValue•'
									$iString = $vValue
								EndIf
							Next
						EndIf
						$__iLineNumber = 554 & ' - $aXpathCountry = _Fallback($aConfig, $vXpath, $aRomList[8])•'
						$aXpathCountry = _Fallback($aConfig, $vXpath, $aRomList[8])
						$__iLineNumber = 555 & ' - For $vBoucle2 = 1 To UBound($aXpathCountry) - 1•'
						For $vBoucle2 = 1 To UBound($aXpathCountry) - 1
							$__iLineNumber = 556 & ' - $vValue = _XML_Read($aXpathCountry[$vBoucle2], 0, $aRomList[ ...•'
							$vValue = _XML_Read($aXpathCountry[$vBoucle2], 0, $aRomList[8])
							$__iLineNumber = 557 & ' - _LOG("COUNTRY " & $aXpathCountry[$vBoucle2] & "=" & $vValue, ...•'
							_LOG("COUNTRY " & $aXpathCountry[$vBoucle2] & "=" & $vValue, 1, $iLOGPath)
							$__iLineNumber = 558 & ' - If $vValue <> -1 And $vValue <> "" And $iString = "" Then•'
							If $vValue <> -1 And $vValue <> "" And $iString = "" Then
								$__iLineNumber = 559 & ' - $vBoucle2 = UBound($aXpathCountry) - 1•'
								$vBoucle2 = UBound($aXpathCountry) - 1
								$__iLineNumber = 560 & ' - $iString = $vValue•'
								$iString = $vValue
							EndIf
						Next
						$__iLineNumber = 563 & ' - _LOG("Text = " & $iString, 1, $iLOGPath)•'
						_LOG("Text = " & $iString, 1, $iLOGPath)
						$__iLineNumber = 564 & ' - Case "fixe"•'
					Case "fixe"
						$__iLineNumber = 565 & ' - $iString = (_XML_Read("/Profil/Element[" & $vWhile & "]/Sour ...•'
						$iString = (_XML_Read("/Profil/Element[" & $vWhile & "]/Source_Value", 0, "", $oMixConfig))
						$__iLineNumber = 566 & ' - _LOG("Text = " & $iString, 1, $iLOGPath)•'
						_LOG("Text = " & $iString, 1, $iLOGPath)
				EndSwitch
				$__iLineNumber = 568 & ' - $aPicParameters = _MIX_Engine_Dim($vWhile, $oMixConfig)•'
				$aPicParameters = _MIX_Engine_Dim($vWhile, $oMixConfig)
				$__iLineNumber = 569 & ' - $iFont = _XML_Read("/Profil/Element[" & $vWhile & "]/Target_ ...•'
				$iFont = _XML_Read("/Profil/Element[" & $vWhile & "]/Target_Font", 0, "", $oMixConfig)
				$__iLineNumber = 570 & ' - $iFontSize = _XML_Read("/Profil/Element[" & $vWhile & "]/Tar ...•'
				$iFontSize = _XML_Read("/Profil/Element[" & $vWhile & "]/Target_FontSize", 0, "", $oMixConfig)
				$__iLineNumber = 571 & ' - $iFontStyle = _XML_Read("/Profil/Element[" & $vWhile & "]/Ta ...•'
				$iFontStyle = _XML_Read("/Profil/Element[" & $vWhile & "]/Target_FontStyle", 0, "", $oMixConfig)
				$__iLineNumber = 572 & ' - $iFontColor = _XML_Read("/Profil/Element[" & $vWhile & "]/Ta ...•'
				$iFontColor = _XML_Read("/Profil/Element[" & $vWhile & "]/Target_FontColor", 0, "", $oMixConfig)
				$__iLineNumber = 573 & ' - $vPath = $aMiXPicTemp[UBound($aMiXPicTemp) - 1]•'
				$vPath = $aMiXPicTemp[UBound($aMiXPicTemp) - 1]

				$__iLineNumber = 575 & ' - _GDIPlus_Text($vPath, $iString, $aPicParameters[2], $aPicPar ...•'
				_GDIPlus_Text($vPath, $iString, $aPicParameters[2], $aPicParameters[3], $iFont, $iFontSize, $iFontStyle, $iFontColor, $aPicParameters[13], $aPicParameters[14])

				$__iLineNumber = 577 & ' - Case "gdi_function"•'
			Case 'gdi_function'
				$__iLineNumber = 578 & ' - Switch StringLower(_XML_Read("/Profil/Element[" & $vWhile &  ...•'
				$__iLineNumber = 579 & ' - Case "transparency"•'
				Switch StringLower(_XML_Read("/Profil/Element[" & $vWhile & "]/Source_Function", 0, "", $oMixConfig))
					Case 'transparency'
						$__iLineNumber = 580 & ' - $aPicParameters = _MIX_Engine_Dim($vWhile, $oMixConfig)•'
						$aPicParameters = _MIX_Engine_Dim($vWhile, $oMixConfig)
						$__iLineNumber = 581 & ' - $vTransLvl = _XML_Read("/Profil/Element[" & $vWhile & "]/Sou ...•'
						$vTransLvl = _XML_Read("/Profil/Element[" & $vWhile & "]/Source_Value", 0, "", $oMixConfig)
						$__iLineNumber = 582 & ' - $vPath = $aMiXPicTemp[UBound($aMiXPicTemp) - 1]•'
						$vPath = $aMiXPicTemp[UBound($aMiXPicTemp) - 1]
						$__iLineNumber = 583 & ' - If _GDIPlus_Transparency($vPath, $vTransLvl) = -1 Then _LOG( ...•'
						If _GDIPlus_Transparency($vPath, $vTransLvl) = -1 Then _LOG("Transparency Failed", 2, $iLOGPath)
						$__iLineNumber = 584 & ' - Case "merge"•'
					Case 'merge'
						$__iLineNumber = 585 & ' - If _GDIPlus_Merge($aMiXPicTemp[UBound($aMiXPicTemp) - 2], $a ...•'
						If _GDIPlus_Merge($aMiXPicTemp[UBound($aMiXPicTemp) - 2], $aMiXPicTemp[UBound($aMiXPicTemp) - 1]) = -1 Then _LOG("Merging Failed", 2, $iLOGPath)
						$__iLineNumber = 586 & ' - _ArrayDelete($aMiXPicTemp, UBound($aMiXPicTemp) - 1)•'
						_ArrayDelete($aMiXPicTemp, UBound($aMiXPicTemp) - 1)
						$__iLineNumber = 587 & ' - Case "transparencyzone"•'
					Case 'transparencyzone'
						$__iLineNumber = 588 & ' - $aPicParameters = _MIX_Engine_Dim($vWhile, $oMixConfig)•'
						$aPicParameters = _MIX_Engine_Dim($vWhile, $oMixConfig)
						$__iLineNumber = 589 & ' - $vTransLvl = _XML_Read("/Profil/Element[" & $vWhile & "]/Sou ...•'
						$vTransLvl = _XML_Read("/Profil/Element[" & $vWhile & "]/Source_Value", 0, "", $oMixConfig)
						$__iLineNumber = 590 & ' - $vPath = $aMiXPicTemp[UBound($aMiXPicTemp) - 1]•'
						$vPath = $aMiXPicTemp[UBound($aMiXPicTemp) - 1]
						$__iLineNumber = 591 & ' - If _GDIPlus_TransparencyZone($vPath, $vTarget_Width, $vTarge ...•'
						If _GDIPlus_TransparencyZone($vPath, $vTarget_Width, $vTarget_Height, $vTransLvl, $aPicParameters[2], $aPicParameters[3], $aPicParameters[0], $aPicParameters[1]) = -1 Then _LOG("Transparency Failed", 2, $iLOGPath)
					Case Else
						$__iLineNumber = 593 & ' - _LOG("Unknown GDI_Function", 2, $iLOGPath)•'
						_LOG("Unknown GDI_Function", 2, $iLOGPath)
				EndSwitch
			Case Else
				$__iLineNumber = 596 & ' - _LOG("End Of MIX", 1, $iLOGPath)•'
				_LOG("End Of MIX", 1, $iLOGPath)
				ExitLoop
		EndSwitch
		$__iLineNumber = 599 & ' - $vWhile = $vWhile + 1•'
		$vWhile = $vWhile + 1
	WEnd

;~ 	_ArrayDisplay($aMiXPicTemp);Debug

	$__iLineNumber = 604 & ' - For $vBoucle2 = UBound($aMiXPicTemp) - 1 To 2 Step -1•'
	For $vBoucle2 = UBound($aMiXPicTemp) - 1 To 2 Step -1
		$__iLineNumber = 605 & ' - If FileExists($aMiXPicTemp[$vBoucle2 - 1]) Then _GDIPlus_Mer ...•'
		If FileExists($aMiXPicTemp[$vBoucle2 - 1]) Then _GDIPlus_Merge($aMiXPicTemp[$vBoucle2 - 1], $aMiXPicTemp[$vBoucle2])
	Next

	$__iLineNumber = 608 & ' - If Not IsArray($aMiXPicTemp) Or UBound($aMiXPicTemp) - 1 <=  ...•'
	If Not IsArray($aMiXPicTemp) Or UBound($aMiXPicTemp) - 1 <= 0 Then
		$__iLineNumber = 609 & ' - _LOG("End Of Elements", 1, $iLOGPath)•'
		_LOG("End Of Elements", 1, $iLOGPath)
		$__iLineNumber = 610 & ' - Return -1•'
		Return -1
	EndIf

	$__iLineNumber = 613 & ' - $vCompression = _XML_Read("/Profil/Compression/use", 0, "",  ...•'
	$vCompression = _XML_Read("/Profil/Compression/use", 0, "", $oMixConfig)
	$__iLineNumber = 614 & ' - $vCompressionSoft = _XML_Read("/Profil/Compression/soft", 0, ...•'
	$vCompressionSoft = _XML_Read("/Profil/Compression/soft", 0, "", $oMixConfig)
	$__iLineNumber = 615 & ' - $vCompressionParameter = _XML_Read("/Profil/Compression/para ...•'
	$vCompressionParameter = _XML_Read("/Profil/Compression/parameter", 0, "", $oMixConfig)
	$__iLineNumber = 616 & ' - If StringLower($vCompression) = "yes" Then _Compression($aMi ...•'
	If StringLower($vCompression) = 'yes' Then _Compression($aMiXPicTemp[1], $vCompressionSoft, $vCompressionParameter)

	$__iLineNumber = 618 & ' - If UBound($aMiXPicTemp) - 1 > 0 Then Return $aMiXPicTemp[1]•'
	If UBound($aMiXPicTemp) - 1 > 0 Then Return $aMiXPicTemp[1]
	$__iLineNumber = 619 & ' - Return -1•'
	Return -1
EndFunc   ;==>_MIX_Engine

$__iLineNumber = 622 & ' - Func _MIX_Engine_Dim($vWhile, $oMixConfig)•'
Func _MIX_Engine_Dim($vWhile, $oMixConfig)
	$__iLineNumber = 623 & ' - Dim $aPicParameters[15]•'
	Dim $aPicParameters[15]
	$__iLineNumber = 624 & ' - $aPicParameters[0] = _XML_Read("/Profil/Element[" & $vWhile  ...•'
	$aPicParameters[0] = _XML_Read("/Profil/Element[" & $vWhile & "]/Target_Width", 0, "", $oMixConfig)
	$__iLineNumber = 625 & ' - $aPicParameters[1] = _XML_Read("/Profil/Element[" & $vWhile  ...•'
	$aPicParameters[1] = _XML_Read("/Profil/Element[" & $vWhile & "]/Target_Height", 0, "", $oMixConfig)
	$__iLineNumber = 626 & ' - $aPicParameters[2] = _XML_Read("/Profil/Element[" & $vWhile  ...•'
	$aPicParameters[2] = _XML_Read("/Profil/Element[" & $vWhile & "]/Target_TopLeftX", 0, "", $oMixConfig)
	$__iLineNumber = 627 & ' - $aPicParameters[3] = _XML_Read("/Profil/Element[" & $vWhile  ...•'
	$aPicParameters[3] = _XML_Read("/Profil/Element[" & $vWhile & "]/Target_TopLeftY", 0, "", $oMixConfig)
	$__iLineNumber = 628 & ' - $aPicParameters[4] = _XML_Read("/Profil/Element[" & $vWhile  ...•'
	$aPicParameters[4] = _XML_Read("/Profil/Element[" & $vWhile & "]/Target_TopRightX", 0, "", $oMixConfig)
	$__iLineNumber = 629 & ' - $aPicParameters[5] = _XML_Read("/Profil/Element[" & $vWhile  ...•'
	$aPicParameters[5] = _XML_Read("/Profil/Element[" & $vWhile & "]/Target_TopRightY", 0, "", $oMixConfig)
	$__iLineNumber = 630 & ' - $aPicParameters[6] = _XML_Read("/Profil/Element[" & $vWhile  ...•'
	$aPicParameters[6] = _XML_Read("/Profil/Element[" & $vWhile & "]/Target_BottomLeftX", 0, "", $oMixConfig)
	$__iLineNumber = 631 & ' - $aPicParameters[7] = _XML_Read("/Profil/Element[" & $vWhile  ...•'
	$aPicParameters[7] = _XML_Read("/Profil/Element[" & $vWhile & "]/Target_BottomLeftY", 0, "", $oMixConfig)
	$__iLineNumber = 632 & ' - $aPicParameters[8] = _XML_Read("/Profil/Element[" & $vWhile  ...•'
	$aPicParameters[8] = _XML_Read("/Profil/Element[" & $vWhile & "]/Target_Maximize", 0, "", $oMixConfig)
	$__iLineNumber = 633 & ' - $aPicParameters[9] = _XML_Read("/Profil/Element[" & $vWhile  ...•'
	$aPicParameters[9] = _XML_Read("/Profil/Element[" & $vWhile & "]/Target_OriginX", 0, "", $oMixConfig)
	$__iLineNumber = 634 & ' - $aPicParameters[10] = _XML_Read("/Profil/Element[" & $vWhile ...•'
	$aPicParameters[10] = _XML_Read("/Profil/Element[" & $vWhile & "]/Target_OriginY", 0, "", $oMixConfig)
	$__iLineNumber = 635 & ' - $aPicParameters[11] = _XML_Read("/Profil/Element[" & $vWhile ...•'
	$aPicParameters[11] = _XML_Read("/Profil/Element[" & $vWhile & "]/Target_BottomRightX", 0, "", $oMixConfig)
	$__iLineNumber = 636 & ' - $aPicParameters[12] = _XML_Read("/Profil/Element[" & $vWhile ...•'
	$aPicParameters[12] = _XML_Read("/Profil/Element[" & $vWhile & "]/Target_BottomRightY", 0, "", $oMixConfig)
	$__iLineNumber = 637 & ' - $aPicParameters[13] = _Coalesce(_XML_Read("/Profil/Element[" ...•'
	$aPicParameters[13] = _Coalesce(_XML_Read("/Profil/Element[" & $vWhile & "]/Target_OriginPicX", 0, "", $oMixConfig), Default)
	$__iLineNumber = 638 & ' - $aPicParameters[14] = _Coalesce(_XML_Read("/Profil/Element[" ...•'
	$aPicParameters[14] = _Coalesce(_XML_Read("/Profil/Element[" & $vWhile & "]/Target_OriginPicY", 0, "", $oMixConfig), Default)
	$__iLineNumber = 639 & ' - Return $aPicParameters•'
	Return $aPicParameters
EndFunc   ;==>_MIX_Engine_Dim

$__iLineNumber = 642 & ' - Func _XMLSystem_Create()•'
Func _XMLSystem_Create()
	$__iLineNumber = 643 & ' - Local $oXMLSystem, $vXMLSystemPath = $iScriptPath & "\Ressou ...•'
	Local $oXMLSystem, $vXMLSystemPath = $iScriptPath & "\Ressources\systemlist.xml"
	$__iLineNumber = 644 & ' - $oXMLSystem = _XML_Open($vXMLSystemPath)•'
	$oXMLSystem = _XML_Open($vXMLSystemPath)
	$__iLineNumber = 645 & ' - If $oXMLSystem = -1 Then•'
	If $oXMLSystem = -1 Then
		$__iLineNumber = 646 & ' - MsgBox(0, "ERREUR", "")•'
		MsgBox(0, 'ERREUR', '')
		Exit
	Else
		$__iLineNumber = 649 & ' - _LOG("systemlist.xml Opened", 1, $iLOGPath)•'
		_LOG("systemlist.xml Opened", 1, $iLOGPath)
		$__iLineNumber = 650 & ' - Return $oXMLSystem•'
		Return $oXMLSystem
	EndIf
EndFunc   ;==>_XMLSystem_Create

$__iLineNumber = 654 & ' - Func _XMLGenre_Create()•'
Func _XMLGenre_Create()
	$__iLineNumber = 655 & ' - Local $oXMLGenre, $vXMLGenrePath = $iScriptPath & "\Ressourc ...•'
	Local $oXMLGenre, $vXMLGenrePath = $iScriptPath & "\Ressources\Genresliste.xml"
	$__iLineNumber = 656 & ' - $oXMLGenre = _XML_Open($vXMLGenrePath)•'
	$oXMLGenre = _XML_Open($vXMLGenrePath)
	$__iLineNumber = 657 & ' - If $oXMLGenre = -1 Then•'
	If $oXMLGenre = -1 Then
		$__iLineNumber = 658 & ' - MsgBox(0, "ERREUR", "")•'
		MsgBox(0, 'ERREUR', '')
		Exit
	Else
		$__iLineNumber = 661 & ' - _LOG("Genrelist.xml Opened", 1, $iLOGPath)•'
		_LOG("Genrelist.xml Opened", 1, $iLOGPath)
		$__iLineNumber = 662 & ' - Return $oXMLGenre•'
		Return $oXMLGenre
	EndIf
EndFunc   ;==>_XMLGenre_Create

