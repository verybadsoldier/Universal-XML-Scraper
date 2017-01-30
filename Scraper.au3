#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=Ressources\Scraper.ico
#AutoIt3Wrapper_Outfile=.\Scraper.exe
#AutoIt3Wrapper_Outfile_x64=.\Scraper64.exe
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_Description=Scraper
#AutoIt3Wrapper_Res_Fileversion=1.2.0.2
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=p
#AutoIt3Wrapper_Res_LegalCopyright=LEGRAS David
#AutoIt3Wrapper_Res_Language=1036
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=y
#AutoIt3Wrapper_Run_Before=ShowOriginalLine.exe %in%
#AutoIt3Wrapper_Run_After=ShowOriginalLine.exe %in%
#AutoIt3Wrapper_Run_Tidy=y
#Tidy_Parameters=/reel
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
TraySetState(2)

If $CmdLine[0] = 0 Then Exit
$vThreadNumber = $CmdLine[1]

#include <Date.au3>
#include <array.au3>
#include <File.au3>
#include <String.au3>
#include <Crypt.au3>
#include <InetConstants.au3>
#include <ComboConstants.au3>
#include <GUIConstantsEx.au3>

If Not _FileCreate(@ScriptDir & "\test") Then ; Testing UXS Directory
	Global $iScriptPath = @AppDataDir & "\UXMLS" ; If not, use Path to current user's Roaming Application Data
	DirCreate($iScriptPath) ;
Else
	Global $iScriptPath = @ScriptDir
	FileDelete($iScriptPath & "\test")
EndIf

Global $iINIPath = $iScriptPath & "\UXS-config.ini"
Global $iLOGPath = $iScriptPath & "\LOGs\log" & $vThreadNumber & ".txt"
Global $iVerboseLVL = IniRead($iINIPath, "GENERAL", "$vVerbose", 0)

_LOG_Ceation($iLOGPath) ; Starting Log

#include "./Include/_MultiLang.au3"
#include "./Include/_XML.au3"
#include "./Include/MailSlot.au3"
#include "./Include/_GraphGDIPlus.au3"
#include "./Include/_MyFunction.au3"
#include "./Include/_AutoItErrorTrap.au3"

; Custom title and text...
_AutoItErrorTrap("Scraper No " & $vThreadNumber, "Hi!" & @CRLF & @CRLF & "An error was detected in the program, you can try again," & _
		" cancel to exit or continue to see more details of the error." & @CRLF & @CRLF & "Sorry for the inconvenience!")

Local $iScriptVer = FileGetVersion(@ScriptFullPath)
Local $iINIVer = IniRead($iINIPath, "GENERAL", "$verINI", '0.0.0.0')
Local $iSoftname = "UniversalXMLScraperV" & $iScriptVer

Global $iDevId = BinaryToString(_Crypt_DecryptData("0x1552EDED2FA9B5", "1gdf1g1gf", $CALG_RC4))
Global $iDevPassword = BinaryToString(_Crypt_DecryptData("0x1552EDED2FA9B547FBD0D9A623D954AE7BEDC681", "1gdf1g1gf", $CALG_RC4))
Global $iTEMPPath = $iScriptPath & "\TEMP\MIX" & $vThreadNumber
Global $iTEMPPathGlobal = $iScriptPath & "\TEMP"
Global $iRessourcesPath = $iScriptPath & "\Ressources"
Global $iLangPath = $iScriptPath & "\LanguageFiles" ; Where we are storing the language files.
Global $iProfilsPath = $iScriptPath & "\ProfilsFiles" ; Where we are storing the profils files.
Global $vNodeType = "Element"

Local $iSize, $aRomList, $vBoucle, $aConfig, $vProfilsPath, $oXMLProfil, $oXMLSystem, $aMatchingCountry, $oXMLGenre
Local $sMailSlotMother = "\\.\mailslot\Mother"
Local $sMailSlotName = "\\.\mailslot\Son" & $vThreadNumber
Local $sMailSlotCancel = "\\.\mailslot\Cancel" & $vThreadNumber
Local $sMailSlotCheckEngine = "\\.\mailslot\CheckEngine"
Local $hMailSlot = _CreateMailslot($sMailSlotName)
Local $hMailSlotCancel = _CreateMailslot($sMailSlotCancel)
Local $iNumberOfMessagesOverall = 1

$oXMLSystem = _XMLSystem_Create()
If $oXMLSystem = -1 Then Exit

$oXMLGenre = _XMLGenre_Create()
If $oXMLGenre = -1 Then Exit

_SendMail($sMailSlotCheckEngine, $vThreadNumber)

While $iNumberOfMessagesOverall < 5
	If _MailSlotGetMessageCount($hMailSlot) >= 1 Then
		Switch $iNumberOfMessagesOverall
			Case 1
				$aRomList = _ReadMessage($hMailSlot)
;~ 				_SendMail($sMailSlotMother, $aRomList)
				_LOG("Read Message $aRomList : " & $aRomList, 1, $iLOGPath)
				$aRomList = StringSplit($aRomList, '{Break}', $STR_ENTIRESPLIT + $STR_NOCOUNT)
				ReDim $aRomList[13]
				$iNumberOfMessagesOverall += 1
			Case 2
				$vBoucle = _ReadMessage($hMailSlot)
;~ 				_SendMail($sMailSlotMother, $vBoucle)
				_LOG("Read Message $vBoucle : " & $vBoucle, 1, $iLOGPath)
				$iNumberOfMessagesOverall += 1
			Case 3
				$aConfig = _ReadMessage($hMailSlot)
;~ 				_SendMail($sMailSlotMother, $aConfig)
				_LOG("Read Message $aConfig : " & $aConfig, 1, $iLOGPath)
				$aConfig = StringSplit($aConfig, '{Break}', $STR_ENTIRESPLIT + $STR_NOCOUNT)
				ReDim $aConfig[16]

				$aConfig[8] = _XML_Open($iTEMPPathGlobal & "\scraped\" & $vBoucle & ".xml")
				$aConfig[9] = StringSplit($aConfig[9], "|")
				$aConfig[10] = StringSplit($aConfig[10], "|")
				_FileReadToArray($aConfig[11], $aMatchingCountry, $FRTA_NOCOUNT, "|")
				$aConfig[11] = $aMatchingCountry
				$iNumberOfMessagesOverall += 1
			Case 4
				$vProfilsPath = _ReadMessage($hMailSlot)
;~ 				_SendMail($sMailSlotMother, $vProfilsPath)
				_LOG("Read Message $vProfilsPath : " & $vProfilsPath, 1, $iLOGPath)
				$oXMLProfil = _XML_Open($vProfilsPath)
				$iNumberOfMessagesOverall += 1
		EndSwitch
	Else
		; no new message - just yield
		Sleep(200)
	EndIf
	If $iNumberOfMessagesOverall = 5 Then
		$vRomTimer = TimerInit()
		_LOG("-----Making " & $aRomList[2], 1, $iLOGPath)
;~ 		Sleep(1000)
		$aRomList = _Game_Make($aRomList, $vBoucle, $aConfig, $oXMLProfil)
		$oXMLAfterTidy = _XML_CreateDOMDocument(Default)
		$vXMLAfterTidy = _XML_TIDY($aConfig[8])
		_XML_LoadXML($oXMLAfterTidy, $vXMLAfterTidy)
		FileDelete($iTEMPPathGlobal & "\scraped\" & $vBoucle & ".xml")
		_XML_SaveToFile($oXMLAfterTidy, $iTEMPPathGlobal & "\scraped\" & $vBoucle & ".xml")
		$iNumberOfMessagesOverall = 1
		$vScrapedTime = Round((TimerDiff($vRomTimer) / 1000), 2)
		_SendMail($sMailSlotMother, $vBoucle & "|" & $vScrapedTime)
		_LOG("-----" & $aRomList[2] & " scraped in " & $vScrapedTime & "s", 3, $iLOGPath)
		If _CheckCount($hMailSlotCancel) >= 1 Then Exit
	EndIf
WEnd

Func _Game_Make($aRomList, $vBoucle, $aConfig, $oXMLProfil)
	Local $vValue = "", $vAttributeName, $vWhile = 1, $vNode, $vBracketPos = 0, $vHookPos = 0, $vSystem
	While 1
		If $aRomList[3] = 4 Then
			$vNodeType = "Folder"
			_LOG("Creating Folder", 1, $iLOGPath)
		Else
			$vNodeType = "Element"
			_LOG("Creating Element", 1, $iLOGPath)
		EndIf
		_LOG("/Profil/" & $vNodeType & "[" & $vWhile & "]/Target_Type = " & _XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & "]/Target_Type", 0, "", $oXMLProfil), 1, $iLOGPath)
		Switch _XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & "]/Target_Type", 0, "", $oXMLProfil)
			Case "XML_Value"
				$vValue = _XML_Read_Source($aRomList, $vBoucle, $aConfig, $oXMLProfil, $vWhile)
				$vNode = _XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & "]/Target_Value", 0, "", $oXMLProfil)
				Switch _Coalesce(StringLower(_XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & "]/Target_CASE", 0, "", $oXMLProfil)), "default")
					Case "true"
						$vValue = StringUpper($vValue)
					Case "false"
						$vValue = StringLower($vValue)
				EndSwitch
				If $aConfig[5] <> 2 Then
					_LOG($vNode & " <-- " & $vValue, 1, $iLOGPath)
					_XML_WriteValue($vNode, $vValue, "", $aConfig[8])
				EndIf
			Case "XML_Attribute"
				$vValue = _XML_Read_Source($aRomList, $vBoucle, $aConfig, $oXMLProfil, $vWhile)
				$vAttributeName = _XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & "]/Target_Attribute_Name", 0, "", $oXMLProfil)
				$vNode = _XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & "]/Target_Value", 0, "", $oXMLProfil)
				Switch _Coalesce(StringLower(_XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & "]/Target_CASE", 0, "", $oXMLProfil)), "default")
					Case "true"
						$vValue = StringUpper($vValue)
					Case "false"
						$vValue = StringLower($vValue)
				EndSwitch
				If $aConfig[5] <> 2 Then
					_LOG($vNode & " <-- " & $vValue, 1, $iLOGPath)
					_XML_WriteAttributs($vNode, $vAttributeName, $vValue, "", $aConfig[8])
				EndIf
			Case "XML_Path"
				$vValue = _XML_Read_Source($aRomList, $vBoucle, $aConfig, $oXMLProfil, $vWhile)
				$vNode = _XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & "]/Target_Value", 0, "", $oXMLProfil)
				_LOG($vNode & " <-- " & $vValue, 1, $iLOGPath)
				If Number($vValue) < 0 Or $aConfig[5] = 2 Then
					_LOG($vNode & " <-- No value to write", 1, $iLOGPath)
				Else
					$vSystem = StringSplit(IniRead($iINIPath, "LAST_USE", "$vSource_RomPath", ""), "\")
					$vSystem = $vSystem[UBound($vSystem) - 1]
					$vValue = StringReplace($vValue, '%system%', $vSystem)
					_XML_WriteValue($vNode, $vValue, "", $aConfig[8])
				EndIf
			Case "XML_Value_FORMAT"
				$vValue = _XML_Read_Source($aRomList, $vBoucle, $aConfig, $oXMLProfil, $vWhile)
				Switch _XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & "]/Target_FORMAT", 0, "", $oXMLProfil)
					Case '%20on1%'
						$vValue = StringReplace(Round(($vValue * 100 / 20) / 100, 2), ",", ".")
					Case '%ES_Date%'
						$vValue = StringLeft(StringReplace($vValue, "-", "") & '00000000', 8) & "T000000"
					Case '%Filename%'
						$vValue = $aRomList[2]
					Case '%Name+Filename_Bracket%'
						If StringInStr($aRomList[2], "(") > 0 Then $vBracketPos = StringInStr($aRomList[2], "(")
						If StringInStr($aRomList[2], "[") > 0 Then $vHookPos = StringInStr($aRomList[2], "[")
						If $vHookPos < $vBracketPos And $vHookPos > 0 Then $vBracketPos = $vHookPos
						If $vBracketPos > 0 Then $vValue = $vValue & " " & StringMid($aRomList[2], $vBracketPos)
					Case '%Name+Country%'
						$vCountryshort = _Coalesce(_XML_Read("/Data/jeu/regionshortname", 0, $aRomList[8]), "unknown")
						If $vCountryshort <> "unknown" Then
							Local $aLangPref = $aConfig[9]
							For $vBoucle2 = 1 To UBound($aLangPref) - 1
								$vXpathTemp = '/Data/regions/region[nomcourt="' & $vCountryshort & '"]/nom_' & $aLangPref[$vBoucle2]
								$vCountry = _XML_Read($vXpathTemp, 0, $iRessourcesPath & "\Countrylist.xml")
								If $vValue <> -1 And $vValue <> "" Then
									$vValue = $vValue & " (" & $vCountry & ")"
									$vBoucle2 = UBound($aLangPref) - 1
								EndIf
							Next
						EndIf
				EndSwitch
				$vNode = _XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & "]/Target_Value", 0, "", $oXMLProfil)
				Switch _Coalesce(StringLower(_XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & "]/Target_CASE", 0, "", $oXMLProfil)), "default")
					Case "true"
						$vValue = StringUpper($vValue)
					Case "false"
						$vValue = StringLower($vValue)
				EndSwitch
				If $aConfig[5] <> 2 Then
					_LOG($vNode & " <-- " & $vValue, 1, $iLOGPath)
					_XML_WriteValue($vNode, $vValue, "", $aConfig[8])
				EndIf
			Case Else
				_LOG("End Of Elements", 1, $iLOGPath)
				ExitLoop
		EndSwitch
		$vWhile = $vWhile + 1
	WEnd
	Return $aRomList
EndFunc   ;==>_Game_Make

Func _XML_Read_Source($aRomList, $vBoucle, $aConfig, $oXMLProfil, $vWhile)
	Local $vXpath, $vValue, $vXpathTemp, $aXpathCountry, $aPathSplit, $sDrive, $sDir, $sFileName, $sExtension
	$vSource_Type = _XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & "]/Source_Type", 0, "", $oXMLProfil)
	_LOG("/Profil/" & $vNodeType & "[" & $vWhile & "]/Source_Type = " & $vSource_Type, 1, $iLOGPath)
	Switch $vSource_Type
		Case "XML_Value"
			_LOG("->XML_Value", 1, $iLOGPath)
			If $aRomList[9] = 0 Or $aConfig[5] = 2 Then Return ""
			$vXpath = _XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & "]/Source_Value", 0, "", $oXMLProfil)
			_LOG("$vXpath : " & $vXpath, 2, $iLOGPath)
			If StringInStr($vXpath, '%LANG%') Then
				_LOG('%LANG%', 3, $iLOGPath)
				Local $aLangPref = $aConfig[9]
				For $vBoucle2 = 1 To UBound($aLangPref) - 1
					$vXpathTemp = StringReplace($vXpath, '%LANG%', $aLangPref[$vBoucle2])
					$vValue = _XML_Read($vXpathTemp, 0, $aRomList[8])
					If $vValue <> -1 And $vValue <> "" Then Return $vValue
				Next
			EndIf

			If StringInStr($vXpath, '%COUNTRY%') Then
				_LOG('%COUNTRY%', 3, $iLOGPath)
				$aXpathCountry = _Fallback($aConfig, $vXpath, $aRomList[8])
				For $vBoucle2 = 1 To UBound($aXpathCountry) - 1
					$vValue = _XML_Read($aXpathCountry[$vBoucle2], 0, $aRomList[8])
					_LOG("COUNTRY " & $aXpathCountry[$vBoucle2] & "=" & $vValue, 1, $iLOGPath)
					If $vValue <> -1 And $vValue <> "" Then Return $vValue
				Next
			EndIf
			_LOG('NO TAG', 3, $iLOGPath)
			$vValue = _XML_Read($vXpath, 0, $aRomList[8])
			_LOG($vXpath & "=" & $vValue, 1, $iLOGPath)
			If $vValue <> -1 Then Return $vValue
			Return ""

		Case "XML_Attribute"
			_LOG("->XML_Attribute", 1, $iLOGPath)
			If $aRomList[9] = 0 Or $aConfig[5] = 2 Then Return ""
			Return _XML_Read(_XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & "]/Source_Value", 1, "", $oXMLProfil), 0, $aRomList[8])
		Case "XML_Download"
			_LOG("->XML_Download", 1, $iLOGPath)
			If $aRomList[9] = 0 Then Return ""
			$vXpath = _XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & "]/Source_Value", 0, "", $oXMLProfil)
			$aXpathCountry = _Fallback($aConfig, $vXpath, $aRomList[8])
			For $vBoucle2 = 1 To UBound($aXpathCountry) - 1
				$vDownloadURL = _Coalesce(_XML_Read($aXpathCountry[$vBoucle2], 0, $aRomList[8]), -1)
				If $vDownloadURL < 0 Then
					_LOG($aXpathCountry[$vBoucle2] & " problem : " & $vDownloadURL, 2, $iLOGPath)
				Else
					$vDownloadMaxWidth = _Coalesce(_XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & "]/Target_Image_Width", 0, "", $oXMLProfil), 0)
					$vDownloadMaxHeight = _Coalesce(_XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & "]/Target_Image_Height", 0, "", $oXMLProfil), 0)

					$vDownloadTag = _XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & "]/Source_Download_Tag", 0, "", $oXMLProfil)
					If $vNodeType = "Folder" Then $vDownloadTag = $vDownloadTag & "-folder"
					$vDownloadExt = _Coalesce(IniRead($iINIPath, "LAST_USE", "$vTarget_Image_Ext", ""), _XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & "]/Source_Download_Ext", 0, "", $oXMLProfil))
					$aPathSplit = _PathSplit(StringReplace($aRomList[0], "\", "_"), $sDrive, $sDir, $sFileName, $sExtension)
					$vSource_ImagePath = $aConfig[3] & "\" & $sFileName & $vDownloadTag & "." & $vDownloadExt
					$vSource_ImagePath = _Picture_Download($vDownloadURL, $vSource_ImagePath, $oXMLProfil, $vDownloadMaxWidth, $vDownloadMaxHeight)

					If $vSource_ImagePath < 0 Then Return -1

					$vTarget_ImagePath = $aConfig[4] & $sFileName & $vDownloadTag & "." & $vDownloadExt
					If $vNodeType = "Folder" Then
						$vCheckExist = _XML_NodeExists($aConfig[8], _XML_Read('/Profil/Folder/Target_Value', 0, "", $oXMLProfil) & '[* = "' & $vTarget_ImagePath & '"]')
					Else
						$vCheckExist = _XML_NodeExists($aConfig[8], _XML_Read('/Profil/Game/Target_Value', 0, "", $oXMLProfil) & '[* = "' & $vTarget_ImagePath & '"]')
					EndIf
					If $vCheckExist = $XML_RET_SUCCESS Then
						_LOG(_XML_Read('/Profil/Game/Target_Value', 0, "", $oXMLProfil) & '[* = "' & $vTarget_ImagePath & '"]' & " Already exist in XML ( " & $vCheckExist & ")", 1, $iLOGPath)
						Return -2
					EndIf

					Return $vTarget_ImagePath
				EndIf
			Next
			Return ""
		Case "Fixe_Value"
			_LOG("->Fixe_Value", 1, $iLOGPath)
			Return _XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & "]/Source_Value", 0, "", $oXMLProfil)
		Case "Variable_Value"
			_LOG("->Variable_Value", 1, $iLOGPath)
			Switch _XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & "]/Source_Value", 0, "", $oXMLProfil)
				Case '%XML_Rom_Path%'
					$vSystem = StringSplit(IniRead($iINIPath, "LAST_USE", "$vSource_RomPath", ""), "\")
					$vSystem = $vSystem[UBound($vSystem) - 1]
					$vXMLRomPath = $aConfig[2] & StringReplace($aRomList[0], "\", "/")
					$vXMLRomPath = StringReplace($vXMLRomPath, '%system%', $vSystem)
					Return $vXMLRomPath
				Case '%AutoHide%'
					If $aRomList[3] = 2 Or $aRomList[3] = 3 Then Return "true"
				Case Else
					_LOG("SOURCE Unknown", 1, $iLOGPath)
					Return ""
			EndSwitch
		Case "MIX_Template"
			_LOG("->MIX_Template", 1, $iLOGPath)
			If $aRomList[9] = 0 And $aConfig[6] = 0 Then Return ""
			Local $vDownloadTag, $vDownloadExt, $vTargetPicturePath, $aPathSplit, $sDrive, $sDir, $sFileName, $sExtension
			$vDownloadTag = _XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & "]/Source_Download_Tag", 0, "", $oXMLProfil)
			If $vNodeType = "Folder" Then $vDownloadTag = $vDownloadTag & "-folder"
			$vDownloadExt = _XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & "]/Source_Download_Ext", 0, "", $oXMLProfil)
			$aPathSplit = _PathSplit(StringReplace($aRomList[0], "\", "_"), $sDrive, $sDir, $sFileName, $sExtension)
			$vTargetPicturePath = $aConfig[4] & $sFileName & $vDownloadTag & "." & $vDownloadExt
			Switch _XML_Read("/Profil/" & $vNodeType & "[" & $vWhile & "]/Source_Download_Path", 0, "", $oXMLProfil)
				Case '%Local_Path_File%'
					$vDownloadPath = $aConfig[3] & "\" & $sFileName & $vDownloadTag & "." & $vDownloadExt
				Case Else ; For the futur
					$vDownloadPath = $aConfig[3] & "\" & $sFileName & $vDownloadTag & "." & $vDownloadExt
			EndSwitch
			If FileExists($vDownloadPath) And $aConfig[5] <> 2 Then Return $vTargetPicturePath

			$vValue = _MIX_Engine($aRomList, $vBoucle, $aConfig, $oXMLProfil)
			If Not FileExists($vValue) Then Return -1
			FileCopy($vValue, $vDownloadPath, $FC_OVERWRITE)

			_LOG("MIX Template finished (" & $vTargetPicturePath & ")", 1, $iLOGPath)
			Return $vTargetPicturePath
		Case Else
			_LOG("->SOURCE Unknown", 1, $iLOGPath)
			Return ""
	EndSwitch
EndFunc   ;==>_XML_Read_Source

Func _Fallback($aConfig, $vXpath, $vSource_RomXMLPath)
	Local $vCountryPref = '', $vIdGenre = ''
	If StringInStr($vXpath, '%COUNTRY%') Then
		Local $aCountryPref = $aConfig[10]
	Else
		Local $aCountryPref[2] = ["", $vXpath]
	EndIf
	Local $aXpathCountry[UBound($aCountryPref)]
	For $vBoucle = 1 To UBound($aCountryPref) - 1
		$vCountryPref = $aCountryPref[$vBoucle]
		If $vCountryPref = '%COUNTRY%' Then $vCountryPref = _XML_Read("Data/jeu/regionshortnames/regionshortname", 0, $vSource_RomXMLPath)
		$aXpathCountry[$vBoucle] = StringReplace($vXpath, '%COUNTRY%', $vCountryPref)
	Next
	Return $aXpathCountry
EndFunc   ;==>_Fallback

Func _Picture_Download($vDownloadURL, $vSource_ImagePath, $oXMLProfil, $vDownloadMaxWidth = 0, $vDownloadMaxHeight = 0)
	Local $vDownloadOutputFormat, $aPathSplit, $sDrive, $sDir, $sFileName, $sExtension
	$aPathSplit = _PathSplit($vSource_ImagePath, $sDrive, $sDir, $sFileName, $sExtension)
	If $vDownloadMaxWidth > 0 Then
		$vDownloadMaxWidth = "&maxwidth=" & $vDownloadMaxWidth
	Else
		$vDownloadMaxWidth = "&maxwidth=" & _Coalesce(IniRead($iINIPath, "LAST_USE", "$vTarget_Image_Width", ""), _XML_Read("Profil/General/Target_Image_Width", 0, "", $oXMLProfil))
	EndIf
	If $vDownloadMaxHeight > 0 Then
		$vDownloadMaxHeight = "&maxheight=" & $vDownloadMaxHeight
	Else
		$vDownloadMaxHeight = "&maxheight=" & _Coalesce(IniRead($iINIPath, "LAST_USE", "$vTarget_Image_Height", ""), _XML_Read("Profil/General/Target_Image_Height", 0, "", $oXMLProfil))
	EndIf
	$vDownloadOutputFormat = "&outputformat=" & StringMid($sExtension, 2)

	If FileExists($vSource_ImagePath) And $aConfig[5] <> 2 Then
		_LOG($vSource_ImagePath & " File already exist", 1, $iLOGPath)
		Return $vSource_ImagePath
	EndIf

	$vDownloadURL = $vDownloadURL & $vDownloadMaxWidth & $vDownloadMaxHeight & $vDownloadOutputFormat
	$vValue = _DownloadWRetry($vDownloadURL, $vSource_ImagePath)
	If $vValue < 0 Or Not FileExists($vSource_ImagePath) Then
		Return -1
	Else
		Return $vSource_ImagePath
	EndIf
EndFunc   ;==>_Picture_Download

Func _MIX_Engine($aRomList, $vBoucle, $aConfig, $oXMLProfil)
	Local $vMIXTemplatePath = $iScriptPath & "\Mix\TEMP\"
	Local $oMixConfig = _XML_Open($vMIXTemplatePath & "config.xml")
	Local $vTarget_Width = _Coalesce(IniRead($iINIPath, "LAST_USE", "$vTarget_Image_Width", ""), _XML_Read("/Profil/General/Target_Width", 0, "", $oMixConfig))
	Local $vTarget_Height = _Coalesce(IniRead($iINIPath, "LAST_USE", "$vTarget_Image_Height", ""), _XML_Read("/Profil/General/Target_Height", 0, "", $oMixConfig))
	Local $vRoot_Game = _XML_Read("/Profil/Root/Root_Game", 0, "", $oMixConfig) & "/"
	Local $vRoot_System = _XML_Read("/Profil/Root/Root_System", 0, "", $oMixConfig) & "[id=" & $aConfig[12] & "]/"
	Local $vPicTarget = -1, $vWhile = 1, $vFinalValue = ""
	Dim $aMiXPicTemp[1]
	Sleep(250)
	FileDelete($iTEMPPath & "\MIX")
	Sleep(250)
	DirCreate($iTEMPPath & "\MIX")
	FileSetAttrib($iTEMPPath, "+H")
	While 1
		$iString = ""
		Switch StringLower(_XML_Read("/Profil/Element[" & $vWhile & "]/Source_Type", 0, "", $oMixConfig))
			Case "fixe_value"
				$vPicTarget = $iTEMPPath & "\MIX\" & _XML_Read("/Profil/Element[" & $vWhile & "]/Name", 0, "", $oMixConfig) & ".png"
				If Not FileCopy($vMIXTemplatePath & _XML_Read("/Profil/Element[" & $vWhile & "]/Source_Value", 0, "", $oMixConfig), $vPicTarget, $FC_OVERWRITE + $FC_CREATEPATH) Then _LOG("Error copying " & $vMIXTemplatePath & _XML_Read("/Profil/Element[" & $vWhile & "]/Source_Value", 0, "", $oMixConfig) & " to " & $vPicTarget, 2, $iLOGPath)
				$aPicParameters = _MIX_Engine_Dim($vWhile, $oMixConfig)
				_GDIPlus_Imaging($vPicTarget, $aPicParameters, $vTarget_Width, $vTarget_Height)
				_LOG("fixe_value : " & $vPicTarget & " Created", 1, $iLOGPath)
				_ArrayAdd($aMiXPicTemp, $vPicTarget)
			Case "xml_value"
				$vPicTarget = $iTEMPPath & "\MIX\" & _XML_Read("/Profil/Element[" & $vWhile & "]/Name", 0, "", $oMixConfig) & ".png"
				$vXpath = _XML_Read("/Profil/Element[" & $vWhile & "]/Source_Value", 0, "", $oMixConfig)
				$vOrigin = StringLower(_XML_Read("/Profil/Element[" & $vWhile & "]/source_Origin", 0, "", $oMixConfig))
				If $vOrigin = -1 Then $vOrigin = 'game'
				$aPicParameters = _MIX_Engine_Dim($vWhile, $oMixConfig)
				$aXpathCountry = _Fallback($aConfig, $vXpath, $aRomList[8])
				For $vBoucle2 = 1 To UBound($aXpathCountry) - 1
					If StringInStr($aXpathCountry[$vBoucle2], '%IDGENRE%') Then
						$vIdGenre = _XML_Read("Data/jeu/genres/genres_id/genre_id", 0, $aRomList[8])
						$aXpathCountry[$vBoucle2] = StringReplace($aXpathCountry[$vBoucle2], '%IDGENRE%', $vIdGenre)
					EndIf
					Switch $vOrigin
						Case 'game'
							$vDownloadURL = StringTrimRight(_XML_Read($vRoot_Game & $aXpathCountry[$vBoucle2], 0, $aRomList[8]), 3) & "png"
						Case 'system'
							$vDownloadURL = StringTrimRight(_XML_Read($vRoot_System & $aXpathCountry[$vBoucle2], 0, "", $oXMLSystem), 3) & "png"
					EndSwitch
					If $vDownloadURL <> "png" And Not FileExists($vPicTarget) Then
						$vDownloadMaxWidth = "&maxwidth=" & _GDIPlus_RelativePos($aPicParameters[0], $vTarget_Width)
						$vDownloadMaxHeight = "&maxheight=" & _GDIPlus_RelativePos($aPicParameters[1], $vTarget_Width)
						$vDownloadOutputFormat = "&outputformat=png" & "&forceupdate=1"
						$vValue = _DownloadWRetry($vDownloadURL & $vDownloadMaxWidth & $vDownloadMaxHeight & $vDownloadOutputFormat, $vPicTarget)
						If $vValue < 0 Then
							_LOG("xml_value : " & $vPicTarget & " Not Added", 2, $iLOGPath)
						Else
							$vRotationLvl = _Coalesce(_XML_Read("/Profil/Element[" & $vWhile & "]/Target_Rotation", 0, "", $oMixConfig), -1)
							If $vRotationLvl >= 0 Then
								If _GDIPlus_Rotation($vPicTarget, $vRotationLvl) = -1 Then _LOG("Rotation Failed", 2, $iLOGPath)
							EndIf
							_GDIPlus_Imaging($vPicTarget, $aPicParameters, $vTarget_Width, $vTarget_Height)
							_ArrayAdd($aMiXPicTemp, $vPicTarget)
							_LOG("xml_value : " & $vPicTarget & " Created", 1, $iLOGPath)
						EndIf
					EndIf
				Next
			Case "text"
				Switch StringLower(_XML_Read("/Profil/Element[" & $vWhile & "]/Source_TextType", 0, "", $oMixConfig))
					Case "xml_value"
						$vXpath = (_XML_Read("/Profil/Element[" & $vWhile & "]/Source_Value", 0, "", $oMixConfig))
						If StringInStr($vXpath, '%LANG%') Then
							Local $aLangPref = $aConfig[9]
							For $vBoucle2 = 1 To UBound($aLangPref) - 1
								$vXpathTemp = StringReplace($vXpath, '%LANG%', $aLangPref[$vBoucle2])
								$vValue = _XML_Read($vXpathTemp, 0, $aRomList[8])
								If $vValue <> -1 And $vValue <> "" Then
									$vBoucle2 = UBound($aLangPref) - 1
									$iString = $vValue
								EndIf
							Next
						EndIf
						$aXpathCountry = _Fallback($aConfig, $vXpath, $aRomList[8])
						For $vBoucle2 = 1 To UBound($aXpathCountry) - 1
							$vValue = _XML_Read($aXpathCountry[$vBoucle2], 0, $aRomList[8])
							_LOG("COUNTRY " & $aXpathCountry[$vBoucle2] & "=" & $vValue, 1, $iLOGPath)
							If $vValue <> -1 And $vValue <> "" And $iString = "" Then
								$vBoucle2 = UBound($aXpathCountry) - 1
								$iString = $vValue
							EndIf
						Next
						_LOG("Text = " & $iString, 1, $iLOGPath)
					Case "fixe"
						$iString = (_XML_Read("/Profil/Element[" & $vWhile & "]/Source_Value", 0, "", $oMixConfig))
						_LOG("Text = " & $iString, 1, $iLOGPath)
				EndSwitch
				$aPicParameters = _MIX_Engine_Dim($vWhile, $oMixConfig)
				$iFont = _XML_Read("/Profil/Element[" & $vWhile & "]/Target_Font", 0, "", $oMixConfig)
				$iFontSize = _XML_Read("/Profil/Element[" & $vWhile & "]/Target_FontSize", 0, "", $oMixConfig)
				$iFontStyle = _XML_Read("/Profil/Element[" & $vWhile & "]/Target_FontStyle", 0, "", $oMixConfig)
				$iFontColor = _XML_Read("/Profil/Element[" & $vWhile & "]/Target_FontColor", 0, "", $oMixConfig)
				$vPath = $aMiXPicTemp[UBound($aMiXPicTemp) - 1]

				_GDIPlus_Text($vPath, $iString, $aPicParameters[2], $aPicParameters[3], $iFont, $iFontSize, $iFontStyle, $iFontColor, $aPicParameters[13], $aPicParameters[14])

			Case 'gdi_function'
				Switch StringLower(_XML_Read("/Profil/Element[" & $vWhile & "]/Source_Function", 0, "", $oMixConfig))
					Case 'transparency'
						$aPicParameters = _MIX_Engine_Dim($vWhile, $oMixConfig)
						$vTransLvl = _XML_Read("/Profil/Element[" & $vWhile & "]/Source_Value", 0, "", $oMixConfig)
						$vPath = $aMiXPicTemp[UBound($aMiXPicTemp) - 1]
						If _GDIPlus_Transparency($vPath, $vTransLvl) = -1 Then _LOG("Transparency Failed", 2, $iLOGPath)
					Case 'merge'
						If _GDIPlus_Merge($aMiXPicTemp[UBound($aMiXPicTemp) - 2], $aMiXPicTemp[UBound($aMiXPicTemp) - 1]) = -1 Then _LOG("Merging Failed", 2, $iLOGPath)
						_ArrayDelete($aMiXPicTemp, UBound($aMiXPicTemp) - 1)
					Case 'transparencyzone'
						$aPicParameters = _MIX_Engine_Dim($vWhile, $oMixConfig)
						$vTransLvl = _XML_Read("/Profil/Element[" & $vWhile & "]/Source_Value", 0, "", $oMixConfig)
						$vPath = $aMiXPicTemp[UBound($aMiXPicTemp) - 1]
						If _GDIPlus_TransparencyZone($vPath, $vTarget_Width, $vTarget_Height, $vTransLvl, $aPicParameters[2], $aPicParameters[3], $aPicParameters[0], $aPicParameters[1]) = -1 Then _LOG("Transparency Failed", 2, $iLOGPath)
					Case Else
						_LOG("Unknown GDI_Function", 2, $iLOGPath)
				EndSwitch
			Case Else
				_LOG("End Of MIX", 1, $iLOGPath)
				ExitLoop
		EndSwitch
		$vWhile = $vWhile + 1
	WEnd

	For $vBoucle2 = UBound($aMiXPicTemp) - 1 To 2 Step -1
		If FileExists($aMiXPicTemp[$vBoucle2 - 1]) Then _GDIPlus_Merge($aMiXPicTemp[$vBoucle2 - 1], $aMiXPicTemp[$vBoucle2])
	Next

	If Not IsArray($aMiXPicTemp) Or UBound($aMiXPicTemp) - 1 = 0 Then
		_LOG("End Of Elements", 1, $iLOGPath)
		Return -1
	EndIf

	$vCompression = _XML_Read("/Profil/Compression/use", 0, "", $oMixConfig)
	$vCompressionSoft = _XML_Read("/Profil/Compression/soft", 0, "", $oMixConfig)
	$vCompressionParameter = _XML_Read("/Profil/Compression/parameter", 0, "", $oMixConfig)
	If StringLower($vCompression) = 'yes' Then _Compression($aMiXPicTemp[1], $vCompressionSoft, $vCompressionParameter)

	If UBound($aMiXPicTemp) - 1 > 0 Then Return $aMiXPicTemp[1]
	Return -1
EndFunc   ;==>_MIX_Engine

Func _MIX_Engine_Dim($vWhile, $oMixConfig)
	Dim $aPicParameters[15]
	$aPicParameters[0] = _XML_Read("/Profil/Element[" & $vWhile & "]/Target_Width", 0, "", $oMixConfig)
	$aPicParameters[1] = _XML_Read("/Profil/Element[" & $vWhile & "]/Target_Height", 0, "", $oMixConfig)
	$aPicParameters[2] = _XML_Read("/Profil/Element[" & $vWhile & "]/Target_TopLeftX", 0, "", $oMixConfig)
	$aPicParameters[3] = _XML_Read("/Profil/Element[" & $vWhile & "]/Target_TopLeftY", 0, "", $oMixConfig)
	$aPicParameters[4] = _XML_Read("/Profil/Element[" & $vWhile & "]/Target_TopRightX", 0, "", $oMixConfig)
	$aPicParameters[5] = _XML_Read("/Profil/Element[" & $vWhile & "]/Target_TopRightY", 0, "", $oMixConfig)
	$aPicParameters[6] = _XML_Read("/Profil/Element[" & $vWhile & "]/Target_BottomLeftX", 0, "", $oMixConfig)
	$aPicParameters[7] = _XML_Read("/Profil/Element[" & $vWhile & "]/Target_BottomLeftY", 0, "", $oMixConfig)
	$aPicParameters[8] = _XML_Read("/Profil/Element[" & $vWhile & "]/Target_Maximize", 0, "", $oMixConfig)
	$aPicParameters[9] = _XML_Read("/Profil/Element[" & $vWhile & "]/Target_OriginX", 0, "", $oMixConfig)
	$aPicParameters[10] = _XML_Read("/Profil/Element[" & $vWhile & "]/Target_OriginY", 0, "", $oMixConfig)
	$aPicParameters[11] = _XML_Read("/Profil/Element[" & $vWhile & "]/Target_BottomRightX", 0, "", $oMixConfig)
	$aPicParameters[12] = _XML_Read("/Profil/Element[" & $vWhile & "]/Target_BottomRightY", 0, "", $oMixConfig)
	$aPicParameters[13] = _Coalesce(_XML_Read("/Profil/Element[" & $vWhile & "]/Target_OriginPicX", 0, "", $oMixConfig), Default)
	$aPicParameters[14] = _Coalesce(_XML_Read("/Profil/Element[" & $vWhile & "]/Target_OriginPicY", 0, "", $oMixConfig), Default)
	Return $aPicParameters
EndFunc   ;==>_MIX_Engine_Dim

Func _XMLSystem_Create()
	Local $oXMLSystem, $vXMLSystemPath = $iScriptPath & "\Ressources\systemlist.xml"
	$oXMLSystem = _XML_Open($vXMLSystemPath)
	If $oXMLSystem = -1 Then
		MsgBox(0, 'ERREUR', '')
		Exit
	Else
		_LOG("systemlist.xml Opened", 1, $iLOGPath)
		Return $oXMLSystem
	EndIf
EndFunc   ;==>_XMLSystem_Create

Func _XMLGenre_Create()
	Local $oXMLGenre, $vXMLGenrePath = $iScriptPath & "\Ressources\Genresliste.xml"
	$oXMLGenre = _XML_Open($vXMLGenrePath)
	If $oXMLGenre = -1 Then
		MsgBox(0, 'ERREUR', '')
		Exit
	Else
		_LOG("Genrelist.xml Opened", 1, $iLOGPath)
		Return $oXMLGenre
	EndIf
EndFunc   ;==>_XMLGenre_Create

