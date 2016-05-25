#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=Ressources\Universal_Xml_Scraper.ico
#AutoIt3Wrapper_Outfile=..\BIN\Universal_XML_Scraper.exe
#AutoIt3Wrapper_Outfile_x64=..\BIN\Universal_XML_Scraper64.exe
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_Description=Scraper XML Universel
#AutoIt3Wrapper_Res_Fileversion=1.1.1.4
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=p
#AutoIt3Wrapper_Res_LegalCopyright=LEGRAS David
#AutoIt3Wrapper_Res_Language=1036
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=y
#AutoIt3Wrapper_Run_Tidy=y
#Tidy_Parameters=/reel
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;*************************************************************************
;**																		**
;**						Universal XML Scraper	TEST					**
;**						LEGRAS David									**
;**																		**
;*************************************************************************

;Definition des librairies
;-------------------------
#include <Date.au3>
#include <array.au3>
#include <File.au3>
#include <String.au3>
#include <AutoItConstants.au3>
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#include <GuiStatusBar.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
#include <Color.au3>
#include <Crypt.au3>
#include <GDIPlus.au3>
; SQLite.dll version must match

#include <MsgBoxConstants.au3>
#include <SQLite.au3>
#include <SQLite.dll.au3>

Local $sSQliteDll = _SQLite_Startup()

If @error Then
	MsgBox($MB_SYSTEMMODAL, "SQLite Error", "SQLite3.dll Can't be Loaded!" & @CRLF & @CRLF & _
			"Not FOUND in @SystemDir, @WindowsDir, @ScriptDir, @WorkingDir, @LocalAppDataDir\AutoIt v3\SQLite")
	Exit -1
EndIf

MsgBox($MB_SYSTEMMODAL, "SQLite3.dll Loaded", $sSQliteDll & " (" & _SQLite_LibVersion() & ")")
ConsoleWrite("_SQLite_LibVersion=" & _SQLite_LibVersion() & @CRLF)
_SQLite_Shutdown()

#include "./Include/_MultiLang.au3"
#include "./Include/_ExtMsgBox.au3"
#include "./Include/_Trim.au3"
#include "./Include/_XMLDomWrapper.au3"
#include "./Include/_Hash.au3"

Global $SOURCE_DIRECTORY = @ScriptDir
If Not _FileCreate($SOURCE_DIRECTORY & "\test") Then
	$SOURCE_DIRECTORY = @AppDataDir & "\Universal_XML_Scraper"
	DirCreate($SOURCE_DIRECTORY & "\UXMLS")
Else
	FileDelete($SOURCE_DIRECTORY & "\test")
EndIf

Global $Pathshasum = $SOURCE_DIRECTORY & "\Ressources\shasum.exe"
Global $PathRom = '"C:\Developpement\Romset\nes\Airwolf (USA).zip"'
Global $PathCsv = $SOURCE_DIRECTORY & "\Ressources\hash.csv"
Dim $aRetArray

Local $iPID = Run($Pathshasum & " " & $PathRom, "", @SW_MAXIMIZE, $STDOUT_CHILD)

ProcessWaitClose($iPID)

Local $sOutput = StdoutRead($iPID)
Local $aArray = StringSplit(StringTrimRight(StringStripCR($sOutput), StringLen(@CRLF)), ' ')

If @error Then
	MsgBox($MB_SYSTEMMODAL, "", "It appears there was an error trying to find all the files in the current script directory.")
Else
	; Display the results.
	_ArrayDisplay($aArray)
EndIf

_ReplaceStringInFile($PathCsv, ';', '')
_ReplaceStringInFile($PathCsv, '"', '')
;~ _FileReadToArray($PathCsv, $aRetArray, $FRTA_NOCOUNT)

;~ For $Boucle = 0 To UBound($aRetArray) - 1
;~ 	FileWrite($PathCsv & ".tmp", StringReplace($aRetArray[$Boucle], ",", @TAB, 3) & @LF)
;~ 	ConsoleWrite(StringReplace($aRetArray[$Boucle], ",", @TAB, 3) & @CRLF)
;~ Next

If Not _FileReadToArray($PathCsv & ".tmp", $aRetArray, $FRTA_NOCOUNT + $FRTA_ENTIRESPLIT, @TAB) Then
	MsgBox($MB_SYSTEMMODAL, "", "There was an error reading the file. @error: " & @error) ; An error occurred reading the current script file.
EndIf

_ArrayDisplay($aRetArray, "2D array - no count", Default, 8)
