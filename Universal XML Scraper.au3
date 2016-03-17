#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=Ressources\Universal_Xml_Scraper.ico
#AutoIt3Wrapper_Outfile=..\BIN\Universal_XML_Scraper.exe
#AutoIt3Wrapper_Outfile_x64=..\BIN\Universal_XML_Scraper64.exe
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_Description=Scraper XML Universel
#AutoIt3Wrapper_Res_Fileversion=1.0.0.4
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=p
#AutoIt3Wrapper_Res_LegalCopyright=LEGRAS David
#AutoIt3Wrapper_Res_Language=1036
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=y
#AutoIt3Wrapper_Run_Tidy=y
#Tidy_Parameters=/reel
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;*************************************************************************
;**																		**
;**						Universal XML Scraper							**
;**						LEGRAS David									**
;**																		**
;*************************************************************************

;Definition des librairies
;-------------------------
#include <Date.au3>
#include <array.au3>
#include <File.au3>
#include <String.au3>
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

#include "./Include/_MultiLang.au3"
#include "./Include/_ExtMsgBox.au3"
#include "./Include/_Trim.au3"
#include "./Include/_XMLDomWrapper.au3"
#include "./Include/_Hash.au3"

;FileInstall
;-----------
Global $SOURCE_DIRECTORY = @ScriptDir
If Not _FileCreate($SOURCE_DIRECTORY & "\test") Then
	$SOURCE_DIRECTORY = @AppDataDir & "\Universal_XML_Scraper"
	DirCreate($SOURCE_DIRECTORY & "\UXMLS")
Else
	FileDelete($SOURCE_DIRECTORY & "\test")
EndIf

DirCreate($SOURCE_DIRECTORY & "\LanguageFiles")
DirCreate($SOURCE_DIRECTORY & "\Ressources")
FileInstall(".\UXS-config.ini", $SOURCE_DIRECTORY & "\UXS-config.ini")
FileInstall(".\LanguageFiles\UXS-ENGLISH.XML", $SOURCE_DIRECTORY & "\LanguageFiles\UXS-ENGLISH.XML")
FileInstall(".\LanguageFiles\UXS-FRENCH.XML", $SOURCE_DIRECTORY & "\LanguageFiles\UXS-FRENCH.XML")
FileInstall(".\Ressources\empty.jpg", $SOURCE_DIRECTORY & "\Ressources\empty.jpg")
FileInstall(".\Ressources\Fleche.jpg", $SOURCE_DIRECTORY & "\Ressources\Fleche.jpg")
FileInstall(".\Ressources\thegamedb.jpg", $SOURCE_DIRECTORY & "\Ressources\thegamedb.jpg")
FileInstall(".\Ressources\Screenscraper.jpg", $SOURCE_DIRECTORY & "\Ressources\Screenscraper.jpg")
FileInstall(".\Ressources\RecalboxV3.jpg", $SOURCE_DIRECTORY & "\Ressources\RecalboxV3.jpg")
FileInstall(".\Ressources\RecalboxV4.jpg", $SOURCE_DIRECTORY & "\Ressources\RecalboxV4.jpg")
FileInstall(".\Ressources\Recalbox.jpg", $SOURCE_DIRECTORY & "\Ressources\Recalbox.jpg")
FileInstall(".\Ressources\Hyperspin.jpg", $SOURCE_DIRECTORY & "\Ressources\Hyperspin.jpg")
FileInstall(".\Ressources\Emulationstation.jpg", $SOURCE_DIRECTORY & "\Ressources\Emulationstation.jpg")
FileInstall(".\Ressources\Fleche_DISABLE.bmp", $SOURCE_DIRECTORY & "\Ressources\Fleche_DISABLE.bmp")
FileInstall(".\Ressources\Fleche_ENABLE.bmp", $SOURCE_DIRECTORY & "\Ressources\Fleche_ENABLE.bmp")
FileInstall(".\Ressources\Fleche_IP1.bmp", $SOURCE_DIRECTORY & "\Ressources\Fleche_IP1.bmp")
FileInstall(".\Ressources\Fleche_IP2.bmp", $SOURCE_DIRECTORY & "\Ressources\Fleche_IP2.bmp")
FileInstall(".\Ressources\plink.exe", $SOURCE_DIRECTORY & "\Ressources\plink.exe")

;Definition des Variables
;-------------------------
Global $LANG_DIR = $SOURCE_DIRECTORY & "\LanguageFiles"; Where we are storing the language files.
Global $INI_P_SOURCE = "empty.jpg"
Global $INI_P_CIBLE = "empty.jpg"
Global $PathTmp = $SOURCE_DIRECTORY & "\API_temp.tmp"
Global $PathConfigINI = $SOURCE_DIRECTORY & "\UXS-config.ini"
Global $PathPlink = $SOURCE_DIRECTORY & "\Ressources\plink.exe"
Local $path_LOG = IniRead($PathConfigINI, "GENERAL", "Path_LOG", $SOURCE_DIRECTORY & "\log.txt")
Local $Verbose = IniRead($PathConfigINI, "GENERAL", "Verbose", 1)
Local $Menu_SSH = IniRead($PathConfigINI, "CONNEXION", "Menu_SSH", 0)
Local $Plink_root = IniRead($PathConfigINI, "CONNEXION", "Plink_root", "root")
Local $Plink_mdp = IniRead($PathConfigINI, "CONNEXION", "Plink_mdp", "recalboxroot")
Local $Plink_IP = IniRead($PathConfigINI, "CONNEXION", "Plink_IP", "RECALBOX")
Global $PathNew = IniRead($PathConfigINI, "LAST_USE", "$PathNew", "")
Global $PathRom = IniRead($PathConfigINI, "LAST_USE", "$PathRom", "")
Global $PathRomSub = IniRead($PathConfigINI, "LAST_USE", "$PathRomSub", "")
Global $PathImage = IniRead($PathConfigINI, "LAST_USE", "$PathImage", "")
Global $PathImageSub = IniRead($PathConfigINI, "LAST_USE", "$PathImageSub", "")
Global $No_Profil = IniRead($PathConfigINI, "LAST_USE", "$No_Profil", 1)
Global $user_lang = IniRead($PathConfigINI, "LAST_USE", "$user_lang", "-1")
Global $No_system = IniRead($PathConfigINI, "LAST_USE", "$No_system", "-1")
Global $HauteurImage = IniRead($PathConfigINI, "LAST_USE", "$HauteurImage", "")
Global $LargeurImage = IniRead($PathConfigINI, "LAST_USE", "$LargeurImage", "")
Global $TMP_LastChild = ''
Global $DevId = 'Screech'
Global $DevPassword = 'Screech201601281533y'
Global $Rev
If @Compiled Then
	$Rev = "BETA " & FileGetVersion(@ScriptFullPath)
Else
	$Rev = 'In Progress'
EndIf

;---------;
;Principal;
;---------;

_CREATION_LOG()
_LANG_LOAD($LANG_DIR, $user_lang)
_CREATION_LOGMESS("Langue Selectionnee : " & $user_lang)

#Region ### START Koda GUI section ### Form=
Local $F_UniversalScraper = GUICreate(_MultiLang_GetText("main_gui"), 350, 181, 215, 143)
GUISetBkColor(0x34495c, $F_UniversalScraper)
Local $MF = GUICtrlCreateMenu(_MultiLang_GetText("mnu_file"))
Local $MF_Profil = GUICtrlCreateMenuItem(_MultiLang_GetText("mnu_file_profil"), $MF)
Local $MF_Separation = GUICtrlCreateMenuItem("", $MF)
Local $MF_Exit = GUICtrlCreateMenuItem(_MultiLang_GetText("mnu_file_exit"), $MF)
Local $ME = GUICtrlCreateMenu(_MultiLang_GetText("mnu_edit"))
Local $ME_Langue = GUICtrlCreateMenuItem(_MultiLang_GetText("mnu_edit_langue"), $ME)
Local $ME_Config = GUICtrlCreateMenuItem(_MultiLang_GetText("mnu_edit_config"), $ME)
Local $MP = GUICtrlCreateMenu("SSH")
Local $MP_KILLALL = GUICtrlCreateMenuItem("KillAll Emulationstation", $MP)
Local $MP_REBOOT = GUICtrlCreateMenuItem("Reboot", $MP)
Local $MP_POWEROFF = GUICtrlCreateMenuItem("Power off", $MP)
GUICtrlSetState($MP, $GUI_DISABLE)
Local $MH = GUICtrlCreateMenu(_MultiLang_GetText("mnu_help"))
Local $MH_Help = GUICtrlCreateMenuItem(_MultiLang_GetText("mnu_help_about"), $MH)
Local $P_SOURCE = GUICtrlCreatePic($SOURCE_DIRECTORY & "\Ressources\" & $INI_P_SOURCE, 0, 0, 150, 100)
Local $P_CIBLE = GUICtrlCreatePic($SOURCE_DIRECTORY & "\Ressources\" & $INI_P_CIBLE, 200, 0, 150, 100)
Local $PB_SCRAPE = GUICtrlCreateProgress(0, 110, 350, 25)
Local $B_SCRAPE = GUICtrlCreateButton(_MultiLang_GetText("scrap_button"), 150, 2, 50, 100, BitOR($BS_BITMAP, $BS_FLAT))
GUICtrlSetImage($B_SCRAPE, $SOURCE_DIRECTORY & "\Ressources\Fleche_DISABLE.bmp", -1, 0)
Local $L_SCRAPE = _GUICtrlStatusBar_Create($F_UniversalScraper)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

; Initialisation interface
Local $A_Profil = _INI_CREATEARRAY_SCRAPER()
Local $INI_P_SOURCE = IniRead($PathConfigINI, $A_Profil[$No_Profil], "$IMAGE_SOURCE", "empty.jpg")
Local $INI_P_CIBLE = IniRead($PathConfigINI, $A_Profil[$No_Profil], "$IMAGE_CIBLE", "empty.jpg")
_GUI_REFRESH($INI_P_SOURCE, $INI_P_CIBLE)

While 1
	Local $nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE, $MF_Exit
			_CREATION_LOGMESS("Fermeture du Soft")
			Exit
		Case $MP_KILLALL
			If MsgBox($MB_OKCANCEL, "KillAll Emulationstation", "Etes vous sur de vouloir arreter EmulationStation ?") = $IDOK Then
				Run($PathPlink & $Plink_IP & " -l " & $Plink_root & " -pw " & $Plink_mdp & " killall emulationstation")
				_CREATION_LOGMESS("SSH : KillAll Emulationstation")
			EndIf
		Case $MP_REBOOT
			If MsgBox($MB_OKCANCEL, "Reboot", "Etes vous sur de vouloir Rebooter la machine distante ?") = $IDOK Then
				Run($PathPlink & $Plink_IP & " -l " & $Plink_root & " -pw " & $Plink_mdp & " /sbin/reboot")
				_CREATION_LOGMESS("SSH : Reboot")
			EndIf
		Case $MP_POWEROFF
			If MsgBox($MB_OKCANCEL, "Power Off", "Etes vous sur de vouloir ArrÃªter la machine distante ?") = $IDOK Then
				Run($PathPlink & $Plink_IP & " -l " & $Plink_root & " -pw " & $Plink_mdp & " /sbin/poweroff")
				_CREATION_LOGMESS("SSH : Power Off")
			EndIf
		Case $MF_Profil
			$No_Profil = _PROFIL_SelectGUI($A_Profil)
			$INI_P_SOURCE = IniRead($PathConfigINI, $A_Profil[$No_Profil], "$IMAGE_SOURCE", "empty.jpg")
			$INI_P_CIBLE = IniRead($PathConfigINI, $A_Profil[$No_Profil], "$IMAGE_CIBLE", "empty.jpg")
			_CREATION_LOGMESS("Profil : " & $A_Profil[$No_Profil])
			_GUI_REFRESH($INI_P_SOURCE, $INI_P_CIBLE)
		Case $ME_Langue
			_LANG_LOAD($LANG_DIR, -1)
			_CREATION_LOGMESS("Langue Selectionnee : " & $user_lang)
			_GUI_REFRESH($INI_P_SOURCE, $INI_P_CIBLE)
		Case $B_SCRAPE
			If _GUI_REFRESH($INI_P_SOURCE, $INI_P_CIBLE, 1) = 1 Then
				$FullTimer = TimerInit()
				$A_SYSTEM = _SYSTEM_CREATEARRAY_SCREENSCRAPER($PathTmp)
				$No_system = _SYSTEM_SelectGUI($A_SYSTEM)
				Local $A_ROMList = _SCRAPING($No_Profil, $A_Profil, $PathRom, $No_system)
				$FullTimer = Round(TimerDiff($FullTimer))
				_SCRAPING_BILAN($FullTimer, $A_ROMList)
			EndIf
			_GUI_REFRESH($INI_P_SOURCE, $INI_P_CIBLE, 0)
		Case $ME_Config
			_GUI_Config()
			_GUI_REFRESH($INI_P_SOURCE, $INI_P_CIBLE)
		Case $MH_Help
			$sMsg = "UNIVERSAL XML SCRAPER - " & $Rev & @CRLF
			$sMsg &= _MultiLang_GetText("win_About_By") & @CRLF & @CRLF
			$sMsg &= _MultiLang_GetText("win_About_Thanks") & @CRLF
			$sMsg &= "http://www.screenzone.fr/" & @CRLF
			$sMsg &= "http://www.screenscraper.fr/" & @CRLF
			$sMsg &= "http://www.recalbox.com/" & @CRLF
			$sMsg &= "http://www.emulationstation.org/" & @CRLF
			_ExtMsgBoxSet(1, 2, 0x34495c, 0xFFFF00, 10, "Arial")
			_ExtMsgBox($EMB_ICONINFO, "OK", _MultiLang_GetText("win_About_Title"), $sMsg, 15)
	EndSwitch
WEnd

;---------;
;Fonctions;
;---------;

Func _CREATION_LOG()
	If Not _FileCreate($path_LOG) Then MsgBox(4096, "Error", " Erreur creation du Fichier LOG      error:" & @error)
	$tCur = _Date_Time_GetLocalTime()
	$dtCur = _Date_Time_SystemTimeToArray($tCur)
	FileWrite($path_LOG, "Universal XML Scraper [" & $Rev & "]" & @CRLF)
	FileWrite($path_LOG, "Demarrage le " & StringRight("0" & $dtCur[1], 2) & "/" & StringRight("0" & $dtCur[0], 2) & "/" & StringRight("0" & $dtCur[2], 2) & " - " & StringRight("0" & $dtCur[3], 2) & ":" & StringRight("0" & $dtCur[4], 2) & ":" & StringRight("0" & $dtCur[5], 2) & @CRLF & @CRLF)
EndFunc   ;==>_CREATION_LOG

Func _CREATION_LOGMESS($Mess)
	$tCur = _Date_Time_GetLocalTime()
	$dtCur = _Date_Time_SystemTimeToArray($tCur)
	FileWrite($path_LOG, "[" & StringRight("0" & $dtCur[3], 2) & ":" & StringRight("0" & $dtCur[4], 2) & ":" & StringRight("0" & $dtCur[5], 2) & "] - " & $Mess & @CRLF)
EndFunc   ;==>_CREATION_LOGMESS

Func _GUI_Config()
	#Region ### START Koda GUI section ### Form=
	Local $F_CONFIG = GUICreate(_MultiLang_GetText("win_config_Title"), 242, 346, -1, -1, -1, BitOR($WS_EX_TOPMOST, $WS_EX_WINDOWEDGE))
	Local $B_CONFENREG = GUICtrlCreateButton(_MultiLang_GetText("win_config_Enreg"), 8, 312, 107, 25)
	Local $B_CONFANNUL = GUICtrlCreateButton(_MultiLang_GetText("win_config_Cancel"), 120, 312, 115, 25)
	Local $G_Scrape = GUICtrlCreateGroup(_MultiLang_GetText("win_config_GroupScrap"), 8, 0, 225, 153)
	Local $L_PathRom = GUICtrlCreateLabel(_MultiLang_GetText("win_config_GroupScrap_PathRom"), 16, 16, 208, 17)
	Local $I_PathRom = GUICtrlCreateInput(IniRead($PathConfigINI, "LAST_USE", "$PathRom", $PathRom), 16, 34, 177, 21)
	Local $B_PathRom = GUICtrlCreateButton("...", 198, 34, 27, 21)
	Local $L_PathXML = GUICtrlCreateLabel(_MultiLang_GetText("win_config_GroupScrap_PathXML"), 16, 56, 110, 15)
	Local $I_PathXML = GUICtrlCreateInput(IniRead($PathConfigINI, "LAST_USE", "$PathNew", $PathNew), 16, 74, 177, 21)
	Local $B_PathXML = GUICtrlCreateButton("...", 198, 74, 27, 21)
	Local $L_PathRomSub = GUICtrlCreateLabel(_MultiLang_GetText("win_config_GroupScrap_PathRomSub"), 16, 104, 208, 17)
	Local $I_PathRomSub = GUICtrlCreateInput(IniRead($PathConfigINI, "LAST_USE", "$PathRomSub", $PathRomSub), 16, 122, 177, 21)
	Local $B_PathRomSub = GUICtrlCreateButton("...", 198, 122, 27, 21)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	Local $G_Image = GUICtrlCreateGroup(_MultiLang_GetText("win_config_GroupImage"), 8, 160, 225, 145)
	Local $L_PathImage = GUICtrlCreateLabel(_MultiLang_GetText("win_config_GroupImage_PathImage"), 16, 176, 177, 21)
	Local $I_PathImage = GUICtrlCreateInput(IniRead($PathConfigINI, "LAST_USE", "$PathImage", $PathImage), 16, 194, 177, 21)
	Local $B_PathImage = GUICtrlCreateButton("...", 198, 194, 27, 21)
	Local $L_ImageHauteur = GUICtrlCreateLabel(_MultiLang_GetText("win_config_GroupImage_hautImage"), 24, 226, 40, 17)
	Local $I_ImageHauteur = GUICtrlCreateInput("", 72, 224, 41, 21)
	Local $L_LargeurImage = GUICtrlCreateLabel(_MultiLang_GetText("win_config_GroupImage_LongImage"), 120, 226, 49, 17)
	Local $I_LargeurImage = GUICtrlCreateInput("", 168, 224, 41, 21)
	Local $L_PathImageSub = GUICtrlCreateLabel(_MultiLang_GetText("win_config_GroupImage_PathImageSub"), 16, 256, 208, 17)
	Local $I_PathImageSub = GUICtrlCreateInput(IniRead($PathConfigINI, "LAST_USE", "$PathImageSub", $PathImageSub), 16, 274, 177, 21)
	Local $B_PathImageSub = GUICtrlCreateButton("...", 198, 274, 27, 21)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	GUISetState(@SW_SHOW)
	GUISetState(@SW_DISABLE, $F_UniversalScraper)
	#EndRegion ### END Koda GUI section ###

	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE, $B_CONFANNUL
				GUIDelete($F_CONFIG)
				GUISetState(@SW_ENABLE, $F_UniversalScraper)
				WinActivate($F_UniversalScraper)
				Return
			Case $B_PathRom
				$PathRom = FileSelectFolder(_MultiLang_GetText("win_config_GroupScrap_PathRom"), GUICtrlRead($I_PathRom), $FSF_CREATEBUTTON, GUICtrlRead($I_PathRom), $F_CONFIG)
				If StringRight($PathRom, 1) <> '\' Then $PathRom = $PathRom & '\'
				GUICtrlSetData($I_PathRom, $PathRom)
			Case $B_PathXML
				$PathNew = FileSaveDialog(_MultiLang_GetText("win_config_GroupScrap_PathXML"), GUICtrlRead($I_PathXML), "xml (*.xml)", 18, "", $F_CONFIG)
				GUICtrlSetData($I_PathXML, $PathNew)
			Case $B_PathRomSub
				GUICtrlSetData($I_PathRomSub, FileSelectFolder(_MultiLang_GetText("win_config_GroupScrap_PathRomSub"), GUICtrlRead($I_PathRomSub), $FSF_CREATEBUTTON, GUICtrlRead($I_PathRomSub), $F_CONFIG))
			Case $B_PathImage
				$PathImage = FileSelectFolder(_MultiLang_GetText("win_config_GroupImage_PathImage"), GUICtrlRead($I_PathImage), $FSF_CREATEBUTTON, GUICtrlRead($I_PathImage), $F_CONFIG)
				If StringRight($PathImage, 1) <> '\' Then $PathImage = $PathImage & '\'
				GUICtrlSetData($I_PathImage, $PathImage)
			Case $B_PathImageSub
				GUICtrlSetData($I_PathImageSub, FileSelectFolder(_MultiLang_GetText("win_config_GroupImage_PathImageSub"), GUICtrlRead($I_PathImageSub), $FSF_CREATEBUTTON, GUICtrlRead($I_PathImageSub), $F_CONFIG))
			Case $B_CONFENREG
				$PathRom = GUICtrlRead($I_PathRom)
				IniWrite($PathConfigINI, "LAST_USE", "$PathRom", $PathRom)
				$PathRomSub = GUICtrlRead($I_PathRomSub)
				IniWrite($PathConfigINI, "LAST_USE", "$PathRomSub", $PathRomSub)
				$PathNew = GUICtrlRead($I_PathXML)
				IniWrite($PathConfigINI, "LAST_USE", "$PathNew", $PathNew)
				$PathImage = GUICtrlRead($I_PathImage)
				IniWrite($PathConfigINI, "LAST_USE", "$PathImage", $PathImage)
				$PathImageSub = GUICtrlRead($I_PathImageSub)
				IniWrite($PathConfigINI, "LAST_USE", "$PathImageSub", $PathImageSub)
				$HauteurImage = GUICtrlRead($I_ImageHauteur)
				If $HauteurImage < 1 Then $HauteurImage = ""
				IniWrite($PathConfigINI, "LAST_USE", "$HauteurImage", $HauteurImage)
				$LargeurImage = GUICtrlRead($I_LargeurImage)
				If $LargeurImage < 1 Then $LargeurImage = ""
				IniWrite($PathConfigINI, "LAST_USE", "$LargeurImage", $LargeurImage)
				If Not FileExists($PathNew) And $PathNew <> "" Then
					If Not _FileCreate($PathNew) Then MsgBox($MB_SYSTEMMODAL, "Error", "Error Creating: " & $PathNew & @CRLF & "     error:" & @error)
				EndIf
				_CREATION_LOGMESS("Modification de la config :" & @CRLF)
				_CREATION_LOGMESS(" PathRom : " & $PathRom)
				_CREATION_LOGMESS(" PathRomSub : " & $PathRomSub)
				_CREATION_LOGMESS(" PathNew : " & $PathNew)
				_CREATION_LOGMESS(" PathImage : " & $PathImage)
				_CREATION_LOGMESS(" PathImageSub : " & $PathImageSub)
				_CREATION_LOGMESS(" HauteurImage : " & $HauteurImage)
				_CREATION_LOGMESS(" LargeurImage : " & $LargeurImage & @CRLF)
				GUIDelete($F_CONFIG)
				GUISetState(@SW_ENABLE, $F_UniversalScraper)
				WinActivate($F_UniversalScraper)
				Return
		EndSwitch
	WEnd
EndFunc   ;==>_GUI_Config

Func _GUI_REFRESH($INI_P_SOURCE, $INI_P_CIBLE, $ScrapIP = 0)
	Local $SCRAP_ENABLE
	If $ScrapIP = 0 Then
		If FileExists($PathRom) And FileExists($PathNew) And FileExists($PathImage) And $No_Profil >= 1 Then
			GUICtrlSetImage($B_SCRAPE, $SOURCE_DIRECTORY & "\Ressources\Fleche_ENABLE.bmp", -1, 0)
			$SCRAP_ENABLE = 1
		Else
			GUICtrlSetImage($B_SCRAPE, $SOURCE_DIRECTORY & "\Ressources\Fleche_DISABLE.bmp", -1, 0)
			$SCRAP_ENABLE = 0
		EndIf

		Select
			Case $Menu_SSH = 1
				$Menu_SSH = 2
				GUICtrlSetState($MP, $GUI_ENABLE)
			Case $Menu_SSH = 2
				GUICtrlSetState($MP, $GUI_ENABLE)
		EndSelect

		GUICtrlSetData($MF, _MultiLang_GetText("mnu_file"))
		GUICtrlSetState($MF, $GUI_ENABLE)
		GUICtrlSetData($MF_Profil, _MultiLang_GetText("mnu_file_profil"))
		GUICtrlSetData($MF_Exit, _MultiLang_GetText("mnu_file_exit"))
		GUICtrlSetData($ME, _MultiLang_GetText("mnu_edit"))
		GUICtrlSetState($ME, $GUI_ENABLE)
		GUICtrlSetData($ME_Langue, _MultiLang_GetText("mnu_edit_langue"))
		GUICtrlSetData($ME_Config, _MultiLang_GetText("mnu_edit_config"))
		GUICtrlSetData($MH, _MultiLang_GetText("mnu_help"))
		GUICtrlSetState($MH, $GUI_ENABLE)
		GUICtrlSetData($MH_Help, _MultiLang_GetText("mnu_help_about"))
		GUICtrlSetData($B_SCRAPE, _MultiLang_GetText("scrap_button"))
		GUICtrlSetImage($P_SOURCE, $SOURCE_DIRECTORY & "\Ressources\" & $INI_P_SOURCE)
		GUICtrlSetImage($P_CIBLE, $SOURCE_DIRECTORY & "\Ressources\" & $INI_P_CIBLE)
		GUICtrlSetState($PB_SCRAPE, $GUI_HIDE)
		_GUICtrlStatusBar_SetText($L_SCRAPE, "")
	Else
		If $Menu_SSH = 2 Then GUICtrlSetState($MP, $GUI_DISABLE)
		GUICtrlSetState($MF, $GUI_DISABLE)
		GUICtrlSetState($ME, $GUI_DISABLE)
		GUICtrlSetState($MH, $GUI_DISABLE)
		If FileExists($PathRom) And FileExists($PathNew) And FileExists($PathImage) And $No_Profil >= 1 Then
			GUICtrlSetImage($B_SCRAPE, $SOURCE_DIRECTORY & "\Ressources\Fleche_IP1.bmp", -1, 0)
			$SCRAP_ENABLE = 1
		Else
			$SCRAP_ENABLE = 0
		EndIf
		GUICtrlSetState($PB_SCRAPE, $GUI_SHOW)
	EndIf
	Return $SCRAP_ENABLE
EndFunc   ;==>_GUI_REFRESH

Func _INI_CREATEARRAY_SCRAPER()
	Local $A_Profil[1]
	Local $B_Profils = 1
	While IniRead($PathConfigINI, "PROFILS_SCRAPER", "$PROFILS_SCRAPER_" & $B_Profils, "Ending") <> "Ending"
		_ArrayAdd($A_Profil, IniRead($PathConfigINI, "PROFILS_SCRAPER", "$PROFILS_SCRAPER_" & $B_Profils, "default"))
		$B_Profils = $B_Profils + 1
	WEnd
	_CREATION_LOGMESS("Recuperation des Profil")
;~ 	_ArrayDisplay($A_Profil, '$A_Profil') ; Debug
	Return $A_Profil
EndFunc   ;==>_INI_CREATEARRAY_SCRAPER

Func _LANG_LOAD($LANG_DIR, $user_lang)
	;Create an array of available language files
	; ** n=0 is the default language file
	; [n][0] = Display Name in Local Language (Used for Select Function)
	; [n][1] = Language File (Full path.  In this case we used a $LANG_DIR
	; [n][2] = [Space delimited] Character codes as used by @OS_LANG (used to select correct lang file)
	Local $LANGFILES[2][3]

	$LANGFILES[0][0] = "English (US)" ;
	$LANGFILES[0][1] = $LANG_DIR & "\UXS-ENGLISH.XML"
	$LANGFILES[0][2] = "0409 " & _ ;English_United_States
			"0809 " & _ ;English_United_Kingdom
			"0c09 " & _ ;English_Australia
			"1009 " & _ ;English_Canadian
			"1409 " & _ ;English_New_Zealand
			"1809 " & _ ;English_Irish
			"1c09 " & _ ;English_South_Africa
			"2009 " & _ ;English_Jamaica
			"2409 " & _ ;English_Caribbean
			"2809 " & _ ;English_Belize
			"2c09 " & _ ;English_Trinidad
			"3009 " & _ ;English_Zimbabwe
			"3409" ;English_Philippines

	$LANGFILES[1][0] = "Français" ; French
	$LANGFILES[1][1] = $LANG_DIR & "\UXS-FRENCH.XML"
	$LANGFILES[1][2] = "040c " & _ ;French_Standard
			"080c " & _ ;French_Belgian
			"0c0c " & _ ;French_Canadian
			"100c " & _ ;French_Swiss
			"140c " & _ ;French_Luxembourg
			"180c" ;French_Monaco

	;Set the available language files, names, and codes.
	_MultiLang_SetFileInfo($LANGFILES)
	If @error Then
		MsgBox(48, "Error", "Could not set file info.  Error Code " & @error)
		Exit
	EndIf

	;Check if the loaded settings file exists.  If not ask user to select language.
	If $user_lang = -1 Then
		;Create Selection GUI
		$user_lang = _LANGUE_SelectGUI($LANGFILES)
		If @error Then
			MsgBox(48, "Error", "Could not create selection GUI.  Error Code " & @error)
			Exit
		EndIf
		IniWrite($PathConfigINI, "LAST_USE", "$user_lang", $user_lang)
	EndIf

	Local $ret = _MultiLang_LoadLangFile($user_lang)
	If @error Then
		MsgBox(48, "Error", "Could not load lang file.  Error Code " & @error)
		Exit
	EndIf

	;If you supplied an invalid $user_lang, we will load the default language file
	If $ret = 2 Then
		MsgBox(64, "Information", "Just letting you know that we loaded the default language file")
	EndIf

	Return $LANGFILES
EndFunc   ;==>_LANG_LOAD

Func _LANGUE_SelectGUI($_gh_aLangFileArray, $default = @OSLang)
	GUISetState(@SW_DISABLE, $F_UniversalScraper)
	If $_gh_aLangFileArray = -1 Then Return SetError(1, 0, 0)
	If IsArray($_gh_aLangFileArray) = 0 Then Return SetError(1, 0, 0)
	Local $_multilang_gui_GUI = GUICreate(_MultiLang_GetText("win_sel_langue_Title"), 230, 100)
	Local $_multilang_gui_Combo = GUICtrlCreateCombo("(" & _MultiLang_GetText("win_sel_langue_Title") & ")", 8, 48, 209, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	Local $_multilang_gui_Button = GUICtrlCreateButton(_MultiLang_GetText("win_sel_langue_button"), 144, 72, 75, 25)
	Local $_multilang_gui_Label = GUICtrlCreateLabel(_MultiLang_GetText("win_sel_langue_text"), 8, 8, 212, 33)

	;Create List of available languages
	For $i = 0 To UBound($_gh_aLangFileArray) - 1
		GUICtrlSetData($_multilang_gui_Combo, $_gh_aLangFileArray[$i][0], "(" & _MultiLang_GetText("win_sel_langue_Title") & ")")
	Next

	GUISetState(@SW_SHOW)
	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case -3, $_multilang_gui_Button
				ExitLoop
		EndSwitch
	WEnd
	Local $_selected = GUICtrlRead($_multilang_gui_Combo)
	GUIDelete($_multilang_gui_GUI)
	For $i = 0 To UBound($_gh_aLangFileArray) - 1
		If StringInStr($_gh_aLangFileArray[$i][0], $_selected) Then
			GUISetState(@SW_ENABLE, $F_UniversalScraper)
			WinActivate($F_UniversalScraper)
			Return StringLeft($_gh_aLangFileArray[$i][2], 4)
		EndIf
	Next
	GUISetState(@SW_ENABLE, $F_UniversalScraper)
	WinActivate($F_UniversalScraper)
	Return $default
EndFunc   ;==>_LANGUE_SelectGUI

Func _PROFIL_SelectGUI($A_Profil)
	GUISetState(@SW_DISABLE, $F_UniversalScraper)
	If $A_Profil = -1 Then Return SetError(1, 0, 0)
	If IsArray($A_Profil) = 0 Then Return SetError(1, 0, 0)
	Local $_profil_gui_GUI = GUICreate(_MultiLang_GetText("win_sel_profil_Title"), 230, 100)
	Local $_profil_gui_Combo = GUICtrlCreateCombo("(" & _MultiLang_GetText("win_sel_profil_Title") & ")", 8, 48, 209, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	Local $_profil_gui_Button = GUICtrlCreateButton(_MultiLang_GetText("win_sel_profil_button"), 144, 72, 75, 25)
	Local $_profil_gui_Label = GUICtrlCreateLabel(_MultiLang_GetText("win_sel_profil_text"), 8, 8, 212, 33)

	;Create List of available profile
	For $i = 1 To UBound($A_Profil) - 1
		GUICtrlSetData($_profil_gui_Combo, $A_Profil[$i], "(" & _MultiLang_GetText("win_sel_profil_Title") & ")")
	Next

	GUISetState(@SW_SHOW)
	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case -3, $_profil_gui_Button
				ExitLoop
		EndSwitch
	WEnd
	Local $_selected = GUICtrlRead($_profil_gui_Combo)
	GUIDelete($_profil_gui_GUI)
	For $i = 1 To UBound($A_Profil) - 1
		If StringInStr($A_Profil[$i], $_selected) Then
			IniWrite($PathConfigINI, "LAST_USE", "$No_Profil", $i)
			GUISetState(@SW_ENABLE, $F_UniversalScraper)
			WinActivate($F_UniversalScraper)
			Return $i
		EndIf
	Next
	GUISetState(@SW_ENABLE, $F_UniversalScraper)
	WinActivate($F_UniversalScraper)
	Return 1
EndFunc   ;==>_PROFIL_SelectGUI

Func _ROM_CREATEARRAY($PathRom)
	Global $A_ROMList = _FileListToArray($PathRom, "*.*z*")
	$TimerHash = TimerInit()
	If @error = 1 Then
		_CREATION_LOGMESS("/!\ Chemin de recherche des roms invalide " & $PathRom)
		MsgBox($MB_SYSTEMMODAL, "", $PathRom & " - Path was invalid.")
		Return -1
	EndIf
	If @error = 4 Then
		_CREATION_LOGMESS("/!\ Aucune rom trouvee dans  " & $PathRom)
		MsgBox($MB_SYSTEMMODAL, "", "No file(s) were found.")
		Return -1
	EndIf

	For $B_COLINSRT = 1 To 8
		_ArrayColInsert($A_ROMList, $B_COLINSRT)
	Next

	_CREATION_LOGMESS("Nombre de roms trouvees : " & UBound($A_ROMList) - 1)
	_CREATION_LOGMESS("Calcul des Hash")
	For $B_ROMList = 1 To UBound($A_ROMList) - 1
		If GUIGetMsg() = $B_SCRAPE Then
			Return -1
		EndIf
		$A_ROMList[$B_ROMList][1] = $PathRom & $A_ROMList[$B_ROMList][0]
		$A_ROMList[$B_ROMList][2] = StringRight(_CRC32ForFile($A_ROMList[$B_ROMList][1]), 8)
		$A_ROMList[$B_ROMList][3] = _MD5ForFile($A_ROMList[$B_ROMList][1])
		$A_ROMList[$B_ROMList][4] = _SHA1ForFile($A_ROMList[$B_ROMList][1])
		$A_ROMList[$B_ROMList][5] = FileGetSize($A_ROMList[$B_ROMList][1])
		Local $PercentProgression = Round(($B_ROMList * 100) / UBound($A_ROMList) - 1)
		GUICtrlSetData($PB_SCRAPE, $PercentProgression)
		_GUICtrlStatusBar_SetText($L_SCRAPE, _MultiLang_GetText("prSET_ROM_CREATEARRAY"))
	Next
	_CREATION_LOGMESS("Fin de Calcul des Hash en : " & Round((TimerDiff($TimerHash) / 1000), 2) & "s")
;~ 	_ArrayDisplay($A_ROMList, '$A_ROMList') ; Debug
;~ 	_ArraySort($A_ROMList)
	Return $A_ROMList
EndFunc   ;==>_ROM_CREATEARRAY

Func _SCRAPING($No_Profil, $A_Profil, $PathRom, $No_system)
	Local $A_ROMList = _ROM_CREATEARRAY($PathRom)
	If $A_ROMList = -1 Then Return -1
	$A_Profil = _INI_CREATEARRAY_SCRAPER()
	Local $A_XMLFormat = _XML_CREATEFORMAT($A_Profil[$No_Profil])
	Local $Nb_XMLElements = UBound($A_XMLFormat) - 1
	Local $Nb_Roms = UBound($A_ROMList) - 1
	Local $Moy_Timer = 0

	For $B_XMLElements = 0 To $Nb_XMLElements - 1
		If $A_XMLFormat[$B_XMLElements][1] = "root" Then Local $xpath_root_cible = "//" & $A_XMLFormat[$B_XMLElements][0]
		If $A_XMLFormat[$B_XMLElements][3] = "root" Then Local $xpath_root_source = "//" & $A_XMLFormat[$B_XMLElements][2]
	Next
	ConsoleWrite("$xpath_root_source : " & $xpath_root_source & @CRLF) ; Debug
	ConsoleWrite("$xpath_root_cible : " & $xpath_root_cible & @CRLF) ; Debug

	_XMLCreateFile($PathNew, StringMid($xpath_root_cible, 3), True, 1)
	If @error Then ConsoleWrite("!_XML_CreateFile : " & _XMLError("") & @CRLF) ; Debug

	For $B_ROMList = 1 To $Nb_Roms
		$Timer = TimerInit()
;~ 		_ArrayDisplay($A_ROMList, '$A_ROMList') ; Debug
		$CreateROM = _XML_CREATEROM($PathTmp, $PathNew, $xpath_root_source, $xpath_root_cible, $A_XMLFormat, $A_ROMList, $B_ROMList, $No_system)
		If $CreateROM = 0 Then
			_CREATION_LOGMESS("(*)Rom non trouve : " & $A_ROMList[$B_ROMList][0])
			$A_ROMList[$B_ROMList][7] = 0
		Else
			_CREATION_LOGMESS("Rom trouve : " & $A_ROMList[$B_ROMList][0])
			$A_ROMList[$B_ROMList][7] = 1
		EndIf
		$A_ROMList[$B_ROMList][6] = Round(TimerDiff($Timer))
		Local $PercentProgression = Round(($B_ROMList * 100) / $Nb_Roms)
		$Text = " - Rom no" & $B_ROMList & "/" & $Nb_Roms
		GUICtrlSetData($PB_SCRAPE, $PercentProgression)
		_GUICtrlStatusBar_SetText($L_SCRAPE, _MultiLang_GetText("prSET_XML_CREATEROM") & $Text)
		If GUIGetMsg() = $B_SCRAPE Or $CreateROM = -1 Then
;~ 			_ArrayDisplay($A_ROMList, '$A_ROMList') ; Debug
			_CREATION_LOGMESS("Correction des fins de ligne")
			_ReplaceStringInFile($PathNew, @CRLF, @LF)
			Return $A_ROMList
		EndIf
	Next
	_CREATION_LOGMESS("Correction des fins de ligne")
	_ReplaceStringInFile($PathNew, @CRLF, @LF)
;~ 	_ArrayDisplay($A_ROMList, '$A_ROMList') ; Debug
;~ _ArrayDisplay($A_XMLSources, '$A_XMLSources') ; Debug
;~ 	GUISetState(@SW_ENABLE, $F_UniversalScraper)
	Return $A_ROMList
EndFunc   ;==>_SCRAPING

Func _SCRAPING_BILAN($FullTimer, $A_ROMList)
	Local $Hour, $Mins, $Secs, $Cancelled = 0
	$Nb_Roms = UBound($A_ROMList) - 1
	$MoyTimer = 0
	$ROMFound = 0
	$Nb_Roms_Scanned = 0
	_CREATION_LOGMESS("Bilan" & @CRLF)
	For $B_ROMList = 1 To $Nb_Roms
		$MoyTimer = $MoyTimer + ($A_ROMList[$B_ROMList][6] / 1000)
		$ROMFound = $ROMFound + $A_ROMList[$B_ROMList][7]
		If $A_ROMList[$B_ROMList][6] = "" Then
			$Cancelled = 1
		Else
			$Nb_Roms_Scanned = $Nb_Roms_Scanned + 1
		EndIf
	Next
	_TicksToTime(Int($FullTimer), $Hour, $Mins, $Secs)
	If $Cancelled = 1 Then
		$sMsg = _MultiLang_GetText("win_Cancel_Text") & @CRLF & @CRLF
		_CREATION_LOGMESS("Scrape Annule")
	Else
		_CREATION_LOGMESS("Scrape Termine")
		$sMsg = _MultiLang_GetText("win_Datas_Text") & @CRLF & @CRLF
	EndIf
	$sMsg &= _MultiLang_GetText("win_Datas_Roms") & " " & $ROMFound & " / " & $Nb_Roms & @CRLF
	_CREATION_LOGMESS(" Roms trouvees :" & $ROMFound & " / " & $Nb_Roms)
	$sMsg &= _MultiLang_GetText("win_Datas_MoyTime") & " " & Round($MoyTimer / $Nb_Roms_Scanned, 2) & "s" & @CRLF
	_CREATION_LOGMESS(" Temps moyen par Rom :" & Round($MoyTimer / $Nb_Roms_Scanned, 2) & "s")
	$sMsg &= _MultiLang_GetText("win_Datas_FullTime") & " " & $Hour & "h " & $Mins & "m " & $Secs & "s" & @CRLF
	_CREATION_LOGMESS(" Temps Total :" & $Hour & "h " & $Mins & "m " & $Secs & "s")
	_ExtMsgBoxSet(1, 2, 0x34495c, 0xFFFF00, 10, "Arial")
	If $Cancelled = 1 Then
		_ExtMsgBox($EMB_ICONSTOP, "OK", _MultiLang_GetText("win_Cancel_Title"), $sMsg)
	Else
		_ExtMsgBox($EMB_ICONINFO, "OK", _MultiLang_GetText("win_Datas_Title"), $sMsg)
	EndIf
EndFunc   ;==>_SCRAPING_BILAN

Func _SYSTEM_CREATEARRAY_SCREENSCRAPER($PathTmp)
	Local $A_XMLSources[1][3]
	Local $TMP_LastUbound = UBound($A_XMLSources)
	Local $sNode_Values
	_GUICtrlStatusBar_SetText($L_SCRAPE, _MultiLang_GetText("prSET_SYSTEM_CREATEARRAY"))
	_CREATION_LOGMESS("Recuperation des informations des systemes")
	InetGet("http://www.screenscraper.fr/api/systemesListe.php?devid=" & $DevId & "&devpassword=" & $DevPassword & "&softname=Universal_XML_Scraper&output=XML", $PathTmp)
	_XMLFileOpen($PathTmp)
	If @error Then
		ConsoleWrite("!_XMLFileOpen : " & _XMLError("") & @CRLF) ; Debug
		_CREATION_LOGMESS("Fichier d'informations non valide")
		FileDelete($PathTmp)
		Return -1
	EndIf

	Local $A_Nodes = _XMLGetChildNodes("//Data")
	If @error Then
		ConsoleWrite("!__XMLGetChildNodes : " & _XMLError("") & @CRLF) ; Debug
		FileDelete($PathTmp)
		Return -1
	EndIf
;~ 	_ArrayDisplay($A_Nodes, '$A_Nodes') ; Debug

	For $B_Nodes = 1 To UBound($A_Nodes) - 1
		Local $PercentProgression = Round(($B_Nodes * 100) / (UBound($A_Nodes) - 1))
		$TMP_LastUbound = UBound($A_XMLSources)
		ReDim $A_XMLSources[$TMP_LastUbound + 1][3]
		$sNode_Values = _XMLGetValue("//Data/*[" & $B_Nodes & "]/noms/nom_eu")
		If IsArray($sNode_Values) Then
			$A_XMLSources[$TMP_LastUbound][0] = ($sNode_Values[1])
			If $A_XMLSources[$TMP_LastUbound][0] = Null Then $A_XMLSources[$TMP_LastUbound][0] = ""
		EndIf
		$sNode_Values = _XMLGetValue("//Data/*[" & $B_Nodes & "]/medias/media_photos/media_photo_eu")
		If IsArray($sNode_Values) Then
			$A_XMLSources[$TMP_LastUbound][1] = ($sNode_Values[1])
			If $A_XMLSources[$TMP_LastUbound][1] = Null Then $A_XMLSources[$TMP_LastUbound][0] = ""
		EndIf
		$sNode_Values = _XMLGetValue("//Data/*[" & $B_Nodes & "]/id")
		If IsArray($sNode_Values) Then
			$A_XMLSources[$TMP_LastUbound][2] = ($sNode_Values[1])
			If $A_XMLSources[$TMP_LastUbound][2] = Null Then $A_XMLSources[$TMP_LastUbound][0] = ""
		EndIf
		GUICtrlSetData($PB_SCRAPE, $PercentProgression)
	Next
;~ 	_ArrayDisplay($A_XMLSources, '$A_XMLSources') ; Debug
	_ArraySort($A_XMLSources)
;~ 	_ArrayDisplay($A_XMLSources, '$A_XMLSources') ; Debug
	FileDelete($PathTmp)
	Return $A_XMLSources
EndFunc   ;==>_SYSTEM_CREATEARRAY_SCREENSCRAPER

Func _SYSTEM_SelectGUI($A_SYSTEM)
	GUISetState(@SW_DISABLE, $F_UniversalScraper)
	If $A_SYSTEM = -1 Then Return SetError(1, 0, 0)
	If IsArray($A_SYSTEM) = 0 Then Return SetError(1, 0, 0)
	Local $_system_gui_GUI = GUICreate(_MultiLang_GetText("win_sel_SYSTEM_Title"), 230, 100)
	Local $_system_gui_Combo = GUICtrlCreateCombo("(" & _MultiLang_GetText("win_sel_SYSTEM_Title") & ")", 8, 48, 209, 25, BitOR($GUI_SS_DEFAULT_COMBO, $CBS_SIMPLE))
	Local $_system_gui_Button = GUICtrlCreateButton(_MultiLang_GetText("win_sel_SYSTEM_button"), 144, 72, 75, 25)
	Local $_system_gui_Label = GUICtrlCreateLabel(_MultiLang_GetText("win_sel_SYSTEM_text"), 8, 8, 212, 33)

	For $i = 0 To UBound($A_SYSTEM) - 1
		GUICtrlSetData($_system_gui_Combo, $A_SYSTEM[$i][0], "(" & _MultiLang_GetText("win_sel_SYSTEM_Title") & ")")
	Next

	GUISetState(@SW_SHOW)
	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case -3, $_system_gui_Button
				ExitLoop
		EndSwitch
	WEnd
	Local $_selected = GUICtrlRead($_system_gui_Combo)
	GUIDelete($_system_gui_GUI)
	For $i = 0 To UBound($A_SYSTEM) - 1
		If StringInStr($A_SYSTEM[$i][0], $_selected) Then
			GUISetState(@SW_ENABLE, $F_UniversalScraper)
			WinActivate($F_UniversalScraper)
			_CREATION_LOGMESS("Systeme selectionne : " & $A_SYSTEM[$i][0])
			Return $A_SYSTEM[$i][2]
		EndIf
	Next
	GUISetState(@SW_ENABLE, $F_UniversalScraper)
	WinActivate($F_UniversalScraper)
	Return -1
EndFunc   ;==>_SYSTEM_SelectGUI

Func _XML_CREATEFORMAT($Profil)
	Local $A_XMLFormat[1][4]
	Local $B_Elements = 1
	_CREATION_LOGMESS("Recuperation des champs du profil")
	While IniRead($PathConfigINI, $Profil, "$ELEMENT_" & $B_Elements, "Ending") <> "Ending"
		_ArrayAdd($A_XMLFormat, IniRead($PathConfigINI, $Profil, "$ELEMENT_" & $B_Elements, ""))
		$B_Elements = $B_Elements + 1
	WEnd
;~ 	_ArrayDisplay($A_XMLFormat, '$A_XMLFormat') ; Debug
	Return $A_XMLFormat
EndFunc   ;==>_XML_CREATEFORMAT

Func _XML_CREATEROM($Path_source, $Path_cible, $xpath_root_source, $xpath_root_cible, $A_XMLFormat, $A_ROMList, $No_ROM, $No_system)
	Local $XML_Type, $TMP_LastRootChild, $Return = 1
	$TimerRom = TimerInit()
	_CREATION_LOGMESS("Recuperation des informations de la Rom no " & $No_ROM)
	InetGet("http://www.screenscraper.fr/api/jeuInfos.php?devid=" & $DevId & "&devpassword=" & $DevPassword & "&softname=Universal_XML_Scraper&output=xml&crc=" & $A_ROMList[$No_ROM][2] & "&md5=" & $A_ROMList[$No_ROM][3] & "sha1=" & $A_ROMList[$No_ROM][4] & "&systemeid=" & $No_system & "&romtype=rom&romnom=" & $A_ROMList[$No_ROM][0] & "&romtaille=" & $A_ROMList[$No_ROM][5], $Path_source)
	ConsoleWrite("+Debut de la ROM no : " & $No_ROM & @CRLF) ; Debug
	For $B_XMLElements = 1 To UBound($A_XMLFormat) - 1
		If GUIGetMsg() = $B_SCRAPE Then
			FileDelete($Path_source)
			Return -1
		EndIf
		GUICtrlSetImage($B_SCRAPE, $SOURCE_DIRECTORY & "\Ressources\Fleche_IP1.bmp", -1, 0)
		$XML_Type = StringLeft($A_XMLFormat[$B_XMLElements][3], 5)
		$XML_Value = _XML_GETROMINFO($Path_source, $xpath_root_source, $XML_Type, $B_XMLElements, $A_XMLFormat, $A_ROMList, $No_ROM)
		ConsoleWrite("!" & $A_XMLFormat[$B_XMLElements][2] & " = " & $XML_Value & @CRLF)
		$XML_Type = StringLeft($A_XMLFormat[$B_XMLElements][1], 5)
		ConsoleWrite("!" & $A_XMLFormat[$B_XMLElements][0] & " = " & $XML_Value & @CRLF)
		GUICtrlSetImage($B_SCRAPE, $SOURCE_DIRECTORY & "\Ressources\Fleche_IP2.bmp", -1, 0)
		If $XML_Value <> -1 And $XML_Value <> -2 Then _XML_PUTROMINFO($Path_cible, $xpath_root_cible, $XML_Type, $B_XMLElements, $A_XMLFormat, $No_ROM, $XML_Value)
		If $XML_Value = -2 Then $Return = 0
	Next
	ConsoleWrite("+Fin du Node : " & $No_ROM & @CRLF) ; Debug
	_CREATION_LOGMESS("Fin de l'ecriture des informations de la Rom no " & $No_ROM & " en " & Round((TimerDiff($TimerRom) / 1000), 3) & "s")
	FileDelete($Path_source)
	Return $Return
EndFunc   ;==>_XML_CREATEROM

Func _XML_GETROMINFO($PathTmp, $xpath_root, $XML_Type, $B_XMLElements, $A_XMLFormat, $A_ROMList, $No_ROM)
	Switch $XML_Type
		Case 'child'
			$XML_Value = $A_XMLFormat[$B_XMLElements][0]
			Return $XML_Value
		Case 'value'
			$ERROR_XMLFileOpen = _XMLFileOpen($PathTmp)
			If @error Then
				ConsoleWrite("!_XMLFileOpen (" & $ERROR_XMLFileOpen & ") : " & $PathTmp & " : " & _XMLError("") & @CRLF) ; Debug
				FileDelete($PathTmp)
				Return -2
			EndIf
			Local $sNode_Values = _XMLGetValue($xpath_root & "/*[1]/" & $A_XMLFormat[$B_XMLElements][2])
			If IsArray($sNode_Values) Then
				$XML_Value = StringUpper($sNode_Values[1])
				If $XML_Value = Null Then
					Return ""
				Else
					Return $XML_Value
				EndIf
			EndIf
		Case 'attr:'
			_XMLFileOpen($PathTmp)
			If @error Then
				ConsoleWrite("!_XMLFileOpen (attr:) : " & $PathTmp & " : " & _XMLError("") & @CRLF) ; Debug
				FileDelete($PathTmp)
				Return -2
			EndIf
			Return _XMLGetAttrib($xpath_root & '/' & StringMid($A_XMLFormat[$B_XMLElements][3], 6) & "[1]", $A_XMLFormat[$B_XMLElements][2])
		Case 'varia'
			Switch $A_XMLFormat[$B_XMLElements][2]
				Case '%RomPath%'
					Return $PathRomSub & $A_ROMList[$No_ROM][0]
				Case '%crc32%'
					Return $A_ROMList[$No_ROM][2]
				Case '%md5%'
					Return $A_ROMList[$No_ROM][3]
				Case '%sha1%'
					Return $A_ROMList[$No_ROM][4]
				Case Else
					Return $A_XMLFormat[$B_XMLElements][2]
			EndSwitch
		Case 'path:'
			Switch StringMid($A_XMLFormat[$B_XMLElements][3], 6, 5)
				Case 'image'
					_XMLFileOpen($PathTmp)
					If @error Then
						ConsoleWrite("!_XMLFileOpen (path:) : " & $PathTmp & " : " & _XMLError("") & @CRLF) ; Debug
						FileDelete($PathTmp)
						Return -2
					EndIf
					$sNode_Values = _XMLGetValue($xpath_root & "/*[1]/" & $A_XMLFormat[$B_XMLElements][2])
					If IsArray($sNode_Values) Then
;~ 						Local $PathImage_Temp = $PathImage & StringTrimRight($A_ROMList[$No_ROM][0], 4) & "-" & $A_XMLFormat[$B_XMLElements][0] & "." & StringRight($sNode_Values[1], 3)
;~ 						Local $PathImageSub_Temp = $PathImageSub & StringTrimRight($A_ROMList[$No_ROM][0], 4) & "-" & $A_XMLFormat[$B_XMLElements][0] & "." & StringRight($sNode_Values[1], 3)
;~ 						If FileExists($PathImageSub_Temp) = 0 Then
;~ 							_FileCreate($PathImageSub_Temp)
;~ 							If $HauteurImage <> 0 Then $maxheight = "&maxheight=" & $HauteurImage
;~ 							If $LargeurImage <> 0 Then $maxwidth = "&maxwidth=" & $LargeurImage
;~ 							InetGet($sNode_Values[1] & $maxheight & $maxwidth, $PathImage_Temp, 0, 1)
;~ 						EndIf
;~ 						Return $PathImageSub_Temp
						Return $sNode_Values[1]
					EndIf
			EndSwitch
		Case Else
			Return -1
	EndSwitch
EndFunc   ;==>_XML_GETROMINFO

Func _XML_PUTROMINFO($PathTmp, $xpath_root_cible, $XML_Type, $B_XMLElements, $A_XMLFormat, $No_ROM, $XML_Value)
	Local $TMP_LastChildName = ""
	Local $maxheight = ""
	Local $maxwidth = ""

	_XMLFileOpen($PathTmp)
	If @error Then
		ConsoleWrite("!_XMLFileOpen : " & _XMLError("") & @CRLF) ; Debug
		Return -1
	EndIf

	Switch $XML_Type
		Case 'child'
			_XMLCreateRootChild($XML_Value)
			$TMP_LastChild = $XML_Value
			ConsoleWrite(">_XMLCreateRootChild : " & $TMP_LastChild & @CRLF) ; Debug
		Case 'attr:'
			_XMLCreateAttrib($xpath_root_cible & '/' & StringMid($A_XMLFormat[$B_XMLElements][1], 6) & "[" & $No_ROM & "]", $A_XMLFormat[$B_XMLElements][0], $XML_Value)
			ConsoleWrite(">_XMLCreateAttrib : " & $XML_Value & @CRLF) ; Debug
		Case 'value'
			Local $sNode_Values = _XMLGetValue($xpath_root_cible & '/' & $TMP_LastChild & "[" & $No_ROM & "]/" & $A_XMLFormat[$B_XMLElements][0])
			If IsArray($sNode_Values) = 0 Then
				_XMLCreateChildNode($xpath_root_cible & '/' & $TMP_LastChild & "[" & $No_ROM & "]", $A_XMLFormat[$B_XMLElements][0], $XML_Value)
				ConsoleWrite(">_XMLCreateChildNode : " & $A_XMLFormat[$B_XMLElements][0] & " = " & $XML_Value & @CRLF) ; Debug
			Else
				ConsoleWrite("-ZAPPER : " & $XML_Value & @CRLF) ; Debug
			EndIf
		Case 'path:'
			If $XML_Value = "0" Then Return
			Local $sNode_Values = _XMLGetValue($xpath_root_cible & '/' & $TMP_LastChild & "[" & $No_ROM & "]/" & $A_XMLFormat[$B_XMLElements][0])
			If IsArray($sNode_Values) = 0 Then
				Local $PathImage_Temp = $PathImage & StringTrimRight($A_ROMList[$No_ROM][0], 4) & "-" & $A_XMLFormat[$B_XMLElements][0] & "." & StringRight($XML_Value, 3)
				Local $PathImageSub_Temp = $PathImageSub & StringTrimRight($A_ROMList[$No_ROM][0], 4) & "-" & $A_XMLFormat[$B_XMLElements][0] & "." & StringRight($XML_Value, 3)
				If FileExists($PathImage_Temp) = 0 Then
					If $HauteurImage <> 0 Then $maxheight = "&maxheight=" & $HauteurImage
					If $LargeurImage <> 0 Then $maxwidth = "&maxwidth=" & $LargeurImage
					ConsoleWrite("+ Download : " & $XML_Value & $maxheight & $maxwidth & " dans " & $PathImage_Temp & @CRLF) ; Debug
					InetGet($XML_Value & $maxheight & $maxwidth, $PathImage_Temp, 0, 0)
					_XMLCreateChildNode($xpath_root_cible & '/' & $TMP_LastChild & "[" & $No_ROM & "]", $A_XMLFormat[$B_XMLElements][0], $PathImageSub_Temp)
					ConsoleWrite(">_XMLCreateChildNode : " & $A_XMLFormat[$B_XMLElements][0] & " = " & $PathImageSub_Temp & @CRLF) ; Debug
				EndIf
			Else
				ConsoleWrite("-ZAPPER : " & $XML_Value & @CRLF) ; Debug
			EndIf

	EndSwitch
;~ 			ConsoleWrite($TMP_Text & @CRLF) ; Debug
EndFunc   ;==>_XML_PUTROMINFO
