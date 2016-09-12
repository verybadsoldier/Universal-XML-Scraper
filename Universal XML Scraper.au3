#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=Ressources\Universal_Xml_Scraper.ico
#AutoIt3Wrapper_Outfile=..\BIN\Universal_XML_Scraper.exe
#AutoIt3Wrapper_Outfile_x64=..\BIN\Universal_XML_Scraper64.exe
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_Description=Scraper XML Universel
#AutoIt3Wrapper_Res_Fileversion=1.5.0.12
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=p
#AutoIt3Wrapper_Res_LegalCopyright=LEGRAS David
#AutoIt3Wrapper_Res_Language=1036
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=y
#AutoIt3Wrapper_Run_Tidy=y
#AutoIt3Wrapper_UseUpx=n
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
#include <Crypt.au3>
#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>
#include <GuiStatusBar.au3>
#include <WindowsConstants.au3>
#include <StaticConstants.au3>
;~ #include <EditConstants.au3>
;~ #include <GUIListBox.au3>
;~ #include <FileConstants.au3>
;~ #include <MsgBoxConstants.au3>
;~ #include <Color.au3>

#include "./Include/_MultiLang.au3"
#include "./Include/_ExtMsgBox.au3"
#include "./Include/_Trim.au3"
#include "./Include/_Hash.au3"
#include "./Include/_XMLDomWrapper.au3"
#include "./Include/_zip.au3"
;~ #include "./Include/_ExtGDIPlus.au3"
#include "./Include/_XML.au3"

TraySetState(2)

;FileInstall
;-----------
Global $SOURCE_DIRECTORY = @ScriptDir
If Not _FileCreate($SOURCE_DIRECTORY & "\test") Then
	$SOURCE_DIRECTORY = @AppDataDir & "\Universal_XML_Scraper"
	DirCreate($SOURCE_DIRECTORY & "\UXMLS")
Else
	FileDelete($SOURCE_DIRECTORY & "\test")
EndIf

Global $PathConfigINI = $SOURCE_DIRECTORY & "\UXS-config.ini"
Global $path_LOG = IniRead($PathConfigINI, "GENERAL", "Path_LOG", $SOURCE_DIRECTORY & "\log.txt")
Global $Verbose = IniRead($PathConfigINI, "GENERAL", "$Verbose", 0)
Global $iVerboseLVL = $Verbose
Global $Softname
ConsoleWrite($Verbose & @CRLF)
_CREATION_LOG()

Global $Rev
If @Compiled Then
	$Rev = FileGetVersion(@ScriptFullPath)
	Local $verINI = IniRead($PathConfigINI, "GENERAL", "$verINI", '0.0.0.0')
	$Softname = "UniversalXMLScraperV" & $Rev
	If $verINI <> $Rev Then
		FileDelete($SOURCE_DIRECTORY & "\UXS-config.ini")
		FileDelete($SOURCE_DIRECTORY & "\LanguageFiles")
		FileDelete($SOURCE_DIRECTORY & "\Ressources")
		ConsoleWrite("Ini Deleted" & @CRLF) ;Debug
		_CREATION_LOGMESS(1, "Mise a  jour de " & $verINI & " vers " & $Rev)
	Else
		_CREATION_LOGMESS(1, "Version : " & $Rev)
	EndIf
Else
	$Rev = 'In Progress'
	$Softname = "UniversalXMLScraper(TestDev)"
	_CREATION_LOGMESS(1, "Version : " & $Rev)
EndIf

_CREATION_LOGMESS(2, "Creation des fichiers ressources")
DirCreate($SOURCE_DIRECTORY & "\LanguageFiles")
DirCreate($SOURCE_DIRECTORY & "\Ressources")
DirCreate($SOURCE_DIRECTORY & "\Mix")
DirCreate($SOURCE_DIRECTORY & "\Mix\TEMP")
FileInstall(".\UXS-config.ini", $SOURCE_DIRECTORY & "\UXS-config.ini")
FileInstall(".\LanguageFiles\UXS-ENGLISH.XML", $SOURCE_DIRECTORY & "\LanguageFiles\UXS-ENGLISH.XML")
FileInstall(".\LanguageFiles\UXS-FRENCH.XML", $SOURCE_DIRECTORY & "\LanguageFiles\UXS-FRENCH.XML")
FileInstall(".\LanguageFiles\UXS-PORTUGUESE.XML", $SOURCE_DIRECTORY & "\LanguageFiles\UXS-PORTUGUESE.XML")
FileInstall(".\LanguageFiles\UXS-GERMAN.XML", $SOURCE_DIRECTORY & "\LanguageFiles\UXS-GERMAN.XML")
FileInstall(".\LanguageFiles\UXS-SPANISH.XML", $SOURCE_DIRECTORY & "\LanguageFiles\UXS-SPANISH.XML")
FileInstall(".\Ressources\empty.jpg", $SOURCE_DIRECTORY & "\Ressources\empty.jpg")
FileInstall(".\Ressources\emptySYS.jpg", $SOURCE_DIRECTORY & "\Ressources\emptySYS.jpg")
FileInstall(".\Ressources\Fleche.jpg", $SOURCE_DIRECTORY & "\Ressources\Fleche.jpg")
FileInstall(".\Ressources\thegamedb.jpg", $SOURCE_DIRECTORY & "\Ressources\thegamedb.jpg")
FileInstall(".\Ressources\Screenscraper.jpg", $SOURCE_DIRECTORY & "\Ressources\Screenscraper.jpg")
FileInstall(".\Ressources\Screenscraper (MIX).jpg", $SOURCE_DIRECTORY & "\Ressources\Screenscraper (MIX).jpg")
FileInstall(".\Ressources\RecalboxV3.jpg", $SOURCE_DIRECTORY & "\Ressources\RecalboxV3.jpg")
FileInstall(".\Ressources\RecalboxV4.jpg", $SOURCE_DIRECTORY & "\Ressources\RecalboxV4.jpg")
FileInstall(".\Ressources\Recalbox.jpg", $SOURCE_DIRECTORY & "\Ressources\Recalbox.jpg")
FileInstall(".\Ressources\Hyperspin.jpg", $SOURCE_DIRECTORY & "\Ressources\Hyperspin.jpg")
FileInstall(".\Ressources\Retropie.jpg", $SOURCE_DIRECTORY & "\Ressources\Retropie.jpg")
FileInstall(".\Ressources\Emulationstation.jpg", $SOURCE_DIRECTORY & "\Ressources\Emulationstation.jpg")
FileInstall(".\Ressources\Attract-Mode.jpg", $SOURCE_DIRECTORY & "\Ressources\Attract-Mode.jpg")
FileInstall(".\Ressources\Fleche_DISABLE.bmp", $SOURCE_DIRECTORY & "\Ressources\Fleche_DISABLE.bmp")
FileInstall(".\Ressources\Fleche_ENABLE.bmp", $SOURCE_DIRECTORY & "\Ressources\Fleche_ENABLE.bmp")
FileInstall(".\Ressources\Fleche_IP1.bmp", $SOURCE_DIRECTORY & "\Ressources\Fleche_IP1.bmp")
FileInstall(".\Ressources\Fleche_IP2.bmp", $SOURCE_DIRECTORY & "\Ressources\Fleche_IP2.bmp")
FileInstall(".\Ressources\plink.exe", $SOURCE_DIRECTORY & "\Ressources\plink.exe")
FileInstall(".\Ressources\systemlist.txt", $SOURCE_DIRECTORY & "\Ressources\systemlist.txt")
FileInstall(".\Ressources\regionlist.txt", $SOURCE_DIRECTORY & "\Ressources\regionlist.txt")
FileInstall(".\Mix\Arcade (moon) By Supernature2k.zip", $SOURCE_DIRECTORY & "\Mix\")
FileInstall(".\Mix\Arcade (moon).zip", $SOURCE_DIRECTORY & "\Mix\")
FileInstall(".\Mix\Background (Modified DarKade-Theme by Nachtgarm).zip", $SOURCE_DIRECTORY & "\Mix\")
FileInstall(".\Mix\Oldtv (Multi Sys).zip", $SOURCE_DIRECTORY & "\Mix\")
FileInstall(".\Mix\Standard (3img).zip", $SOURCE_DIRECTORY & "\Mix\")
FileInstall(".\Mix\Standard (4img)  By Supernature2k.zip", $SOURCE_DIRECTORY & "\Mix\")

_CREATION_LOGMESS(2, "Fin de creation des fichiers ressources")

;Definition des Variables
;-------------------------
_CREATION_LOGMESS(2, "Definition des variables")
Global $LANG_DIR = $SOURCE_DIRECTORY & "\LanguageFiles" ; Where we are storing the language files.
Global $INI_P_SOURCE = "empty.jpg"
Global $INI_P_CIBLE = "empty.jpg"
Global $PathSystemList = $SOURCE_DIRECTORY & "\Ressources\systemlist.txt"
Global $PathRegionList = $SOURCE_DIRECTORY & "\Ressources\regionlist.txt"
Global $PathTmp_GAME = $SOURCE_DIRECTORY & "\GAME_temp.tmp"
Global $PathTmp_SYS = $SOURCE_DIRECTORY & "\SYS_temp.tmp"
Global $PathTmp_Changelog = $SOURCE_DIRECTORY & "\changelog.txt"
Global $PathDIRTmp = $SOURCE_DIRECTORY & "\TEMP\"
Global $PathMix = $SOURCE_DIRECTORY & "\Mix\"
Global $PathMixTmp = $SOURCE_DIRECTORY & "\Mix\TEMP"
Global $PathPlink = $SOURCE_DIRECTORY & "\Ressources\plink.exe"
Global $PathNew = IniRead($PathConfigINI, "LAST_USE", "$PathNew", "")
Global $PathRom = IniRead($PathConfigINI, "LAST_USE", "$PathRom", "")
Global $PathRomSub = IniRead($PathConfigINI, "LAST_USE", "$PathRomSub", "")
Global $PathImage = IniRead($PathConfigINI, "LAST_USE", "$PathImage", "")
Global $PathImageSub = IniRead($PathConfigINI, "LAST_USE", "$PathImageSub", "")
Global $No_Profil = IniRead($PathConfigINI, "LAST_USE", "$No_Profil", -1)
Global $user_lang = IniRead($PathConfigINI, "LAST_USE", "$user_lang", -1)
Global $No_system = IniRead($PathConfigINI, "LAST_USE", "$No_system", -1)
Global $HauteurImage = IniRead($PathConfigINI, "LAST_USE", "$HauteurImage", 0)
Global $LargeurImage = IniRead($PathConfigINI, "LAST_USE", "$LargeurImage", 0)
Global $EmptyRom = IniRead($PathConfigINI, "LAST_USE", "$EmptyRom", 0)
Global $ScrapeMode = IniRead($PathConfigINI, "LAST_USE", "$ScrapeMode", 0)
Global $Autoconf_Use = IniRead($PathConfigINI, "LAST_USE", "$Autoconf_Use", -1)
Global $Picture_Region = IniRead($PathConfigINI, "LAST_USE", "$Picture_Region", 0)
Global $A_RegionList
Global $TMP_LastChild = ''
Global $DevId = BinaryToString(_Crypt_DecryptData("0x1552EDED2FA9B5", "1gdf1g1gf", $CALG_RC4))
Global $DevPassword = BinaryToString(_Crypt_DecryptData("0x1552EDED2FA9B547FBD0D9A623D954AE7BEDC681", "1gdf1g1gf", $CALG_RC4))
Global $ME_AutoConfigItem[1]
Global $FullScrapeIP = 0
Global $root_cible
Global $ScrapeCancelled = 0
Global $A_DIRList
Global $A_System
Global $A_XMLSourcesFIXE[1][4]
Global $Nb_MIX_Image = 0
Global $Last_PathImage_TempLast, $Last_PathImage_TempLast_Fus
Local $SCRAP_OK = 0
Local $Moy_Timer = 0
Local $Total_Timer = 0
Local $Menu_SSH = IniRead($PathConfigINI, "CONNEXION", "Menu_SSH", 0)
Local $Plink_root = IniRead($PathConfigINI, "CONNEXION", "Plink_root", "root")
Local $Plink_mdp = IniRead($PathConfigINI, "CONNEXION", "Plink_mdp", "recalboxroot")
Local $Plink_IP = IniRead($PathConfigINI, "CONNEXION", "Plink_IP", "RECALBOX")
Local $L_SCRAPE_Parts[2] = [275, -1]
_CREATION_LOGMESS(2, "Fin de Definition des variables")

;---------;
;Principal;
;---------;

_LANG_LOAD($LANG_DIR, $user_lang)

; Update Checking
_CREATION_LOGMESS(1, "Update Checking")
FileDelete($PathTmp_Changelog)
$hDownload = InetGet("https://raw.githubusercontent.com/Universal-Rom-Tools/Universal-XML-Scraper/master/changelog.txt", $PathTmp_Changelog, 0, 1)
_TimeOut($hDownload)
If FileExists($PathTmp_Changelog) Then
	$ChangelogVersion = FileReadLine($PathTmp_Changelog)
	ConsoleWrite("Local : " & $Rev & " - Github : " & $ChangelogVersion & @CRLF)
	If $ChangelogVersion <> $Rev Then
		_CREATION_LOGMESS(2, "Update dispo")
		$UpdateVersion = MsgBox($MB_YESNO, _MultiLang_GetText("mess_update_Title"), _MultiLang_GetText("mess_update_Question"))
		If $UpdateVersion = $IDYES Then
			_CREATION_LOGMESS(2, "Ouverture de la page des release")
			ShellExecute("https://github.com/Universal-Rom-Tools/Universal-XML-Scraper/releases")
			Exit
		EndIf
	EndIf
EndIf

; Initialisation interface
Global $A_Profil = _INI_CREATEARRAY_SCRAPER()
If IsArray($A_Profil) Then _CREATION_LOGMESS(2, "Creation de la table A_Profil OK")

If $No_Profil = -1 Then
	_CREATION_LOGMESS(2, "Pas de profil selectionne")
	$No_Profil = _PROFIL_SelectGUI($A_Profil, $No_Profil)
EndIf

Local $INI_P_SOURCE = IniRead($PathConfigINI, $A_Profil[$No_Profil], "$IMAGE_SOURCE", "empty.jpg")
Local $INI_P_CIBLE = IniRead($PathConfigINI, $A_Profil[$No_Profil], "$IMAGE_CIBLE", "empty.jpg")
Global $INI_OPTION_MAJ = IniRead($PathConfigINI, $A_Profil[$No_Profil], "$OPTION_MAJ", 0)
Local $PATHAUTOCONF_PathRom = IniRead($PathConfigINI, $A_Profil[$No_Profil], "$PATHAUTOCONF_PathRom", "")
Local $PATHAUTOCONF_PathRomSub = IniRead($PathConfigINI, $A_Profil[$No_Profil], "$PATHAUTOCONF_PathRomSub", "")
Local $PATHAUTOCONF_PathNew = IniRead($PathConfigINI, $A_Profil[$No_Profil], "$PATHAUTOCONF_PathNew", "")
Local $PATHAUTOCONF_PathImage = IniRead($PathConfigINI, $A_Profil[$No_Profil], "$PATHAUTOCONF_PathImage", "")
Local $PATHAUTOCONF_PathImageSub = IniRead($PathConfigINI, $A_Profil[$No_Profil], "$PATHAUTOCONF_PathImageSub", "")

_CREATION_LOGMESS(2, "Creation de l'interface")
#Region ### START Koda GUI section ### Form=
Local $F_UniversalScraper = GUICreate(_MultiLang_GetText("main_gui"), 350, 181, 215, 143)
GUISetBkColor(0x34495c, $F_UniversalScraper)
Local $MF = GUICtrlCreateMenu(_MultiLang_GetText("mnu_file"))
Local $MF_Profil = GUICtrlCreateMenuItem(_MultiLang_GetText("mnu_file_profil"), $MF)
Local $MF_Separation = GUICtrlCreateMenuItem("", $MF)
Local $MF_Exit = GUICtrlCreateMenuItem(_MultiLang_GetText("mnu_file_exit"), $MF)
Local $ME = GUICtrlCreateMenu(_MultiLang_GetText("mnu_edit"))
Local $ME_AutoConfig = GUICtrlCreateMenu(_MultiLang_GetText("mnu_edit_autoconf"), $ME, 1)
Local $ME_FullScrape = GUICtrlCreateMenuItem(_MultiLang_GetText("mnu_edit_fullscrape"), $ME)
Local $ME_Separation = GUICtrlCreateMenuItem("", $ME)
Local $ME_Miximage = GUICtrlCreateMenuItem(_MultiLang_GetText("mnu_edit_miximage"), $ME)
Local $ME_Langue = GUICtrlCreateMenuItem(_MultiLang_GetText("mnu_edit_langue"), $ME)
Local $ME_Config = GUICtrlCreateMenuItem(_MultiLang_GetText("mnu_edit_config"), $ME)
Local $MP = GUICtrlCreateMenu(_MultiLang_GetText("mnu_ssh"))
Local $MP_KILLALL = GUICtrlCreateMenuItem(_MultiLang_GetText("mnu_ssh_killall"), $MP)
Local $MP_START = GUICtrlCreateMenuItem(_MultiLang_GetText("mnu_ssh_start"), $MP)
Local $MP_REBOOT = GUICtrlCreateMenuItem(_MultiLang_GetText("mnu_ssh_reboot"), $MP)
Local $MP_POWEROFF = GUICtrlCreateMenuItem(_MultiLang_GetText("mnu_ssh_halt"), $MP)
GUICtrlSetState($MP, $GUI_DISABLE)
Local $MH = GUICtrlCreateMenu(_MultiLang_GetText("mnu_help"))
Local $MH_Help = GUICtrlCreateMenuItem(_MultiLang_GetText("mnu_help_about"), $MH)
Local $P_SOURCE = GUICtrlCreatePic($SOURCE_DIRECTORY & "\Ressources\" & $INI_P_SOURCE, 0, 0, 150, 100)
Local $P_CIBLE = GUICtrlCreatePic($SOURCE_DIRECTORY & "\Ressources\" & $INI_P_CIBLE, 200, 0, 150, 100)
Local $PB_SCRAPE = GUICtrlCreateProgress(0, 110, 350, 25)
Local $B_SCRAPE = GUICtrlCreateButton(_MultiLang_GetText("scrap_button"), 150, 2, 50, 60, BitOR($BS_BITMAP, $BS_FLAT))
GUICtrlSetImage($B_SCRAPE, $SOURCE_DIRECTORY & "\Ressources\Fleche_DISABLE.bmp", -1, 0)
Local $L_SCRAPE = _GUICtrlStatusBar_Create($F_UniversalScraper)
_GUICtrlStatusBar_SetParts($L_SCRAPE, $L_SCRAPE_Parts)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
_CREATION_LOGMESS(2, "Fin de creation de l'interface")

_GUI_REFRESH($INI_P_SOURCE, $INI_P_CIBLE)

_CREATION_LOGMESS(2, "Preparation du profil MIX Image par defaut")
$MIX_IMG_LASTPROFIL = $PathMix & IniRead($PathConfigINI, "LAST_USE", "$MixImage", "") & ".zip"
FileDelete($PathMixTmp)
DirCreate($PathMixTmp)
_Zip_UnzipAll($MIX_IMG_LASTPROFIL, $PathMixTmp, 0)
_CREATION_LOGMESS(2, "Fin de preparation du profil MIX Image par defaut")

While 1
	Local $nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE, $MF_Exit
			_CREATION_LOGMESS(1, "Fermeture du Soft")
			Exit
		Case $MF_Profil
			$No_Profil = _PROFIL_SelectGUI($A_Profil)
			$INI_P_SOURCE = IniRead($PathConfigINI, $A_Profil[$No_Profil], "$IMAGE_SOURCE", "empty.jpg")
			$INI_P_CIBLE = IniRead($PathConfigINI, $A_Profil[$No_Profil], "$IMAGE_CIBLE", "empty.jpg")
			$INI_OPTION_MAJ = IniRead($PathConfigINI, $A_Profil[$No_Profil], "$OPTION_MAJ", 0)
			Local $PATHAUTOCONF_PathRom = IniRead($PathConfigINI, $A_Profil[$No_Profil], "$PATHAUTOCONF_PathRom", "")
			Local $PATHAUTOCONF_PathRomSub = IniRead($PathConfigINI, $A_Profil[$No_Profil], "$PATHAUTOCONF_PathRomSub", "")
			Local $PATHAUTOCONF_PathNew = IniRead($PathConfigINI, $A_Profil[$No_Profil], "$PATHAUTOCONF_PathNew", "foo.xml")
			Local $PATHAUTOCONF_PathImage = IniRead($PathConfigINI, $A_Profil[$No_Profil], "$PATHAUTOCONF_PathImage", "")
			Local $PATHAUTOCONF_PathImageSub = IniRead($PathConfigINI, $A_Profil[$No_Profil], "$PATHAUTOCONF_PathImageSub", "")
			_GUI_REFRESH($INI_P_SOURCE, $INI_P_CIBLE)
		Case $ME_Miximage
			_MIX_IMAGE_PROFIL()
		Case $ME_Langue
			_LANG_LOAD($LANG_DIR, -1)
			_GUI_REFRESH($INI_P_SOURCE, $INI_P_CIBLE)
		Case $ME_Config
			_GUI_Config($A_Profil, $No_Profil)
			_GUI_REFRESH($INI_P_SOURCE, $INI_P_CIBLE)
		Case $MP_KILLALL
			If MsgBox($MB_OKCANCEL, "Stop Emulationstation", _MultiLang_GetText("mess_ssh_killall")) = $IDOK Then
				ConsoleWrite($PathPlink & " " & $Plink_IP & " -l " & $Plink_root & " -pw " & $Plink_mdp & " /etc/init.d/S31emulationstation stop" & @CRLF)
				Run($PathPlink & " " & $Plink_IP & " -l " & $Plink_root & " -pw " & $Plink_mdp & " /etc/init.d/S31emulationstation stop")
				ConsoleWrite($PathPlink & " " & $Plink_IP & " -l " & $Plink_root & " -pw " & $Plink_mdp & " killall emulationstation" & @CRLF)
				Run($PathPlink & " " & $Plink_IP & " -l " & $Plink_root & " -pw " & $Plink_mdp & " killall emulationstation")
				_CREATION_LOGMESS(1, "SSH : Stop Emulationstation OK")
			Else
				_CREATION_LOGMESS(1, "SSH : Stop Emulationstation ANNULE")
			EndIf
		Case $MP_START
			If MsgBox($MB_OKCANCEL, "Start Emulationstation", _MultiLang_GetText("mess_ssh_start")) = $IDOK Then
				ConsoleWrite($PathPlink & " " & $Plink_IP & " -l " & $Plink_root & " -pw " & $Plink_mdp & " /etc/init.d/S31emulationstation start" & @CRLF)
				Run($PathPlink & " " & $Plink_IP & " -l " & $Plink_root & " -pw " & $Plink_mdp & " /etc/init.d/S31emulationstation start")
				_CREATION_LOGMESS(1, "SSH : Start Emulationstation OK")
			Else
				_CREATION_LOGMESS(1, "SSH : Start Emulationstation ANNULE")
			EndIf
		Case $MP_REBOOT
			If MsgBox($MB_OKCANCEL, "Reboot", _MultiLang_GetText("mess_ssh_reboot")) = $IDOK Then
				Run($PathPlink & " " & $Plink_IP & " -l " & $Plink_root & " -pw " & $Plink_mdp & " /sbin/reboot")
				_CREATION_LOGMESS(1, "SSH : Reboot OK")
			Else
				_CREATION_LOGMESS(1, "SSH : Reboot ANNULE")
			EndIf
		Case $MP_POWEROFF
			If MsgBox($MB_OKCANCEL, "Power Off", _MultiLang_GetText("mess_ssh_poweroff")) = $IDOK Then
				Run($PathPlink & " " & $Plink_IP & " -l " & $Plink_root & " -pw " & $Plink_mdp & " /sbin/poweroff")
				_CREATION_LOGMESS(1, "SSH : Power Off OK")
			Else
				_CREATION_LOGMESS(1, "SSH : Power Off ANNULE")
			EndIf
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
		Case $ME_FullScrape
			If _SCRAPING_VERIF() = 0 Then
				If _GUI_REFRESH($INI_P_SOURCE, $INI_P_CIBLE, 1) = 1 Then
					Local $A_FULL_ROMList[1][9]
					$FullScrapeIP = 1
					$FullTimer = TimerInit()
					$V_Header = IniRead($PathConfigINI, $A_Profil[$No_Profil], "$HEADER_1", "0")
					$A_System = _SYSTEM_CREATEARRAY_SCREENSCRAPER()
					For $B_SYSTEM = 1 To UBound($A_DIRList) - 1
						If GUIGetMsg() = $B_SCRAPE Or $ScrapeCancelled = 1 Then
							_GUICtrlStatusBar_SetText($L_SCRAPE, "", 1)
							$ScrapeCancelled = 1
							ExitLoop
						EndIf
						ConsoleWrite($A_DIRList[$B_SYSTEM][0] & @CRLF)
						$PathRom = $A_DIRList[$B_SYSTEM][1]
						$PathRomSub = $A_DIRList[$B_SYSTEM][2]
						$PathNew = $A_DIRList[$B_SYSTEM][3]
						$PathImage = $A_DIRList[$B_SYSTEM][4]
						$PathImageSub = $A_DIRList[$B_SYSTEM][5]
						$No_system = _SYSTEM_SelectGUI($A_System, 1)
						$A_TMP_ROMList = _SCRAPING($No_Profil, $A_Profil, $PathRom, $No_system, $INI_OPTION_MAJ, $V_Header)
						If IsArray($A_TMP_ROMList) And UBound($A_TMP_ROMList) > 1 Then
							_FUSIONXML($V_Header, $A_TMP_ROMList)
							_ArrayDelete($A_TMP_ROMList, 0)
							_ArrayAdd($A_FULL_ROMList, $A_TMP_ROMList)
						EndIf
						FileDelete($PathDIRTmp)
						FileDelete($PathTmp_GAME)
					Next
					FileDelete($PathTmp_SYS)
					If IsArray($A_FULL_ROMList) Then _SCRAPING_BILAN(TimerDiff($FullTimer), $A_FULL_ROMList)
				EndIf
			EndIf
			$FullScrapeIP = 0
			_GUI_REFRESH($INI_P_SOURCE, $INI_P_CIBLE, 0)
			GUISetState(@SW_ENABLE, $F_UniversalScraper)
			WinActivate($F_UniversalScraper)
		Case $B_SCRAPE
			If _SCRAPING_VERIF() = 0 Then
				If _GUI_REFRESH($INI_P_SOURCE, $INI_P_CIBLE, 1) = 1 Then
					$FullTimer = TimerInit()
					$V_Header = IniRead($PathConfigINI, $A_Profil[$No_Profil], "$HEADER_1", "0")
					$A_System = _SYSTEM_CREATEARRAY_SCREENSCRAPER()
					$No_system = _SYSTEM_SelectGUI($A_System)
					$A_ROMList = _SCRAPING($No_Profil, $A_Profil, $PathRom, $No_system, $INI_OPTION_MAJ, $V_Header)
					If IsArray($A_ROMList) Then
						_FUSIONXML($V_Header, $A_ROMList)
						_SCRAPING_BILAN(TimerDiff($FullTimer), $A_ROMList)
					EndIf
					FileDelete($PathDIRTmp)
					FileDelete($PathTmp_GAME)
					FileDelete($PathTmp_SYS)
				EndIf
			EndIf
			_GUI_REFRESH($INI_P_SOURCE, $INI_P_CIBLE, 0)
	EndSwitch
	If $A_DIRList <> -1 Then
		For $B_AutoConfigItem = 1 To UBound($ME_AutoConfigItem) - 1
			If $nMsg = $ME_AutoConfigItem[$B_AutoConfigItem] Then
				ConsoleWrite($A_DIRList[$B_AutoConfigItem][0] & @CRLF)
				For $B_AutoConfigItem2 = 1 To UBound($ME_AutoConfigItem) - 1
					GUICtrlSetState($ME_AutoConfigItem[$B_AutoConfigItem2], $GUI_UNCHECKED)
				Next
				GUICtrlSetState($ME_AutoConfigItem[$B_AutoConfigItem], $GUI_CHECKED)
				$PathRom = $A_DIRList[$B_AutoConfigItem][1]
				$PathRomSub = $A_DIRList[$B_AutoConfigItem][2]
				$PathNew = $A_DIRList[$B_AutoConfigItem][3]
				$PathImage = $A_DIRList[$B_AutoConfigItem][4]
				$PathImageSub = $A_DIRList[$B_AutoConfigItem][5]
				IniWrite($PathConfigINI, "LAST_USE", "$PathRom", $PathRom)
				IniWrite($PathConfigINI, "LAST_USE", "$PathRomSub", $PathRomSub)
				IniWrite($PathConfigINI, "LAST_USE", "$PathNew", $PathNew)
				IniWrite($PathConfigINI, "LAST_USE", "$PathImage", $PathImage)
				IniWrite($PathConfigINI, "LAST_USE", "$PathImageSub", $PathImageSub)
				$nMsg = ""
			EndIf
		Next
	Else
		$PathNew = IniRead($PathConfigINI, "LAST_USE", "$PathNew", "")
		$PathRom = IniRead($PathConfigINI, "LAST_USE", "$PathRom", "")
		$PathRomSub = IniRead($PathConfigINI, "LAST_USE", "$PathRomSub", "")
		$PathImage = IniRead($PathConfigINI, "LAST_USE", "$PathImage", "")
		$PathImageSub = IniRead($PathConfigINI, "LAST_USE", "$PathImageSub", "")
	EndIf
WEnd

;---------;
;Fonctions;
;---------;

Func _MIX_IMAGE_PROFIL()
	Local $T_MIXPROFIL = ""
	$A_MIX_PROFIL_List = _FileListToArrayRec($PathMix, "*.zip", $FLTAR_FILES, $FLTAR_NORECUR, $FLTAR_SORT, $FLTAR_NOPATH)
;~ 	_ArrayDisplay($A_MIX_PROFIL_List, "$A_MIX_PROFIL_List") ; Debug
	For $B_MIXPROFIL = 1 To UBound($A_MIX_PROFIL_List) - 1
		$T_MIXPROFIL = $T_MIXPROFIL & "|" & StringTrimRight($A_MIX_PROFIL_List[$B_MIXPROFIL], 4)
	Next

	$MIX_IMG_LASTPROFIL = IniRead($PathMixTmp & "\config.ini", "MIX_IMG", "$MIX_IMG_NAME", "")

	#Region ### START Koda GUI section ### Form=
	$F_MIXIMAGE = GUICreate(_MultiLang_GetText("win_config_mix_Title"), 825, 272, 192, 124)
	$C_MIXIMAGE = GUICtrlCreateCombo("", 8, 242, 401, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData($C_MIXIMAGE, $T_MIXPROFIL, $MIX_IMG_LASTPROFIL)
	$B_OK = GUICtrlCreateButton(_MultiLang_GetText("win_config_mix_Enreg"), 416, 240, 200, 25)
	$B_CANCEL = GUICtrlCreateButton(_MultiLang_GetText("win_config_mix_Cancel"), 616, 240, 200, 25)
	$L_Empy = GUICtrlCreateLabel(_MultiLang_GetText("win_config_mix_empty"), 144, 216, 116, 17, $SS_CENTER)
	$L_Exemple = GUICtrlCreateLabel(_MultiLang_GetText("win_config_mix_exemple"), 592, 216, 44, 17)
	GUISetState(@SW_SHOW)
	GUISetState(@SW_DISABLE, $F_UniversalScraper)
	#EndRegion ### END Koda GUI section ###

	$MIX_IMG_EXEMPLE = $PathMixTmp & "\" & IniRead($PathMixTmp & "\config.ini", "MIX_IMG", "$MIX_IMG_EXEMPLE", "\exemple.png")
	_GUI_REFRESH_MIXIMG($F_MIXIMAGE, $MIX_IMG_EXEMPLE)

	While 1
		Local $nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE, $B_CANCEL
				If Not FileDelete($PathMixTmp & "\") Then _CREATION_LOGMESS(2, "Impossible de supprimer " & $PathMixTmp)
				DirCreate($PathMixTmp)
				_Zip_UnzipAll($PathMix & $MIX_IMG_LASTPROFIL & ".zip", $PathMixTmp, 1)
				IniWrite($PathConfigINI, "LAST_USE", "$MixImage", $MIX_IMG_LASTPROFIL)
				GUIDelete($F_MIXIMAGE)
				GUISetState(@SW_ENABLE, $F_UniversalScraper)
				WinActivate($F_UniversalScraper)
				Return
			Case $B_OK
				IniWrite($PathConfigINI, "LAST_USE", "$MixImage", GUICtrlRead($C_MIXIMAGE))
				GUIDelete($F_MIXIMAGE)
				GUISetState(@SW_ENABLE, $F_UniversalScraper)
				WinActivate($F_UniversalScraper)
				Return
			Case $C_MIXIMAGE
				If GUICtrlRead($C_MIXIMAGE) <> IniRead($PathMixTmp & "\config.ini", "MIX_IMG", "$MIX_IMG_NAME", "") Then
					IniRead($PathMixTmp & "\config.ini", "MIX_IMG", "$MIX_IMG_NAME", "")
					If Not FileDelete($PathMixTmp & "\") Then _CREATION_LOGMESS(2, "Impossible de supprimer " & $PathMixTmp)
					DirCreate($PathMixTmp)
					_Zip_UnzipAll($PathMix & GUICtrlRead($C_MIXIMAGE) & ".zip", $PathMixTmp, 1)
					$MIX_IMG_EXEMPLE = $PathMixTmp & "\" & IniRead($PathMixTmp & "\config.ini", "MIX_IMG", "$MIX_IMG_EXEMPLE", "\exemple.png")
					_GUI_REFRESH_MIXIMG($F_MIXIMAGE, $MIX_IMG_EXEMPLE)
				EndIf
		EndSwitch
	WEnd

EndFunc   ;==>_MIX_IMAGE_PROFIL

Func _GUI_REFRESH_MIXIMG($F_MIXIMAGE, $IMAGE_PATH)
	Local $MergedImageBackgroundColor = 0xFF527392
	_GDIPlus_Startup()
	$hImageMIX = _GDIPlus_ImageLoadFromFile($IMAGE_PATH)
	$ImageWidthOG = _GDIPlus_ImageGetWidth($hImageMIX)
	$ImageHeightOG = _GDIPlus_ImageGetHeight($hImageMIX)
	$hGraphicGUI = _GDIPlus_GraphicsCreateFromHWND($F_MIXIMAGE)
	$hBMPBuffMIX = _GDIPlus_BitmapCreateFromGraphics(825, 210, $hGraphicGUI) ; $hBMPBuff is a bitmap in memory
	$hGraphicMIX = _GDIPlus_ImageGetGraphicsContext($hBMPBuffMIX) ; Draw to this graphics, $hGraphic, being the graphics of $hBMPBuff
	_GDIPlus_GraphicsClear($hGraphicMIX, $MergedImageBackgroundColor)
	_GDIPlus_GraphicsDrawImageRectRect($hGraphicMIX, $hImageMIX, 0, 0, 805, 200, 10, 8, 805, 200)
	_GDIPlus_ImageDispose($hImageMIX)
	_WinAPI_RedrawWindow($F_MIXIMAGE, 0, 0, $RDW_UPDATENOW)
	_GDIPlus_GraphicsDrawImage($hGraphicGUI, $hBMPBuffMIX, 0, 0)
	_WinAPI_RedrawWindow($F_MIXIMAGE, 0, 0, $RDW_VALIDATE)
	_GDIPlus_GraphicsDispose($hGraphicMIX)
	_GDIPlus_GraphicsDispose($hGraphicGUI)
	_GDIPlus_BitmapDispose($hBMPBuffMIX)
	_WinAPI_DeleteObject($hBMPBuffMIX)
	_GDIPlus_Shutdown()
EndFunc   ;==>_GUI_REFRESH_MIXIMG

Func _AUTOCONF($PATHAUTOCONF_PathRom, $PATHAUTOCONF_PathRomSub, $PATHAUTOCONF_PathNew = "foo.xml", $PATHAUTOCONF_PathImage = "", $PATHAUTOCONF_PathImageSub = "")
	If $Autoconf_Use = "-1" Then
		If MsgBox(BitOR($MB_ICONQUESTION, $MB_YESNO), _MultiLang_GetText("mess_autoconf_ask_Title"), _MultiLang_GetText("mess_autoconf_ask_Question")) = $IDYES Then
			$Autoconf_Use = 1
		Else
			$Autoconf_Use = 0
		EndIf
	EndIf
	IniWrite($PathConfigINI, "LAST_USE", "$Autoconf_Use", $Autoconf_Use)

	If $PATHAUTOCONF_PathRom = "" Or $Autoconf_Use = 0 Then
		GUICtrlSetState($ME_AutoConfig, $GUI_DISABLE)
		GUICtrlSetState($ME_FullScrape, $GUI_DISABLE)
		Return -1
	Else
		GUICtrlSetState($ME_AutoConfig, $GUI_ENABLE)
		GUICtrlSetState($ME_FullScrape, $GUI_ENABLE)
		If StringRight($PATHAUTOCONF_PathRom, 1) = '\' Then $PATHAUTOCONF_PathRom = StringTrimRight($PATHAUTOCONF_PathRom, 1)
	EndIf

	GUISetState(@SW_DISABLE, $F_UniversalScraper)
	SplashTextOn(_MultiLang_GetText("mnu_edit_autoconf"), _MultiLang_GetText("mess_autoconf"), 400, 50)
	$A_DIRList = _FileListToArrayRec($PATHAUTOCONF_PathRom, "*", $FLTAR_FOLDERS, $FLTAR_NORECUR, $FLTAR_SORT, $FLTAR_RELPATH)
	If IsArray($A_DIRList) Then
;~ 		_ArrayDisplay($A_DIRList, '$A_DIRList') ; Debug
		If IsArray($ME_AutoConfigItem) Then
			For $B_ArrayDelete = 1 To UBound($ME_AutoConfigItem) - 1
				GUICtrlSetState($ME_AutoConfigItem[$B_ArrayDelete], $GUI_UNCHECKED)
				GUICtrlDelete($ME_AutoConfigItem[$B_ArrayDelete])
			Next
		EndIf

		GUICtrlSetState($ME_AutoConfig, $GUI_ENABLE)
		GUICtrlSetState($ME_FullScrape, $GUI_ENABLE)
		Dim $ME_AutoConfigItem[UBound($A_DIRList)]
		For $B_COLINSRT = 1 To 5
			_ArrayColInsert($A_DIRList, $B_COLINSRT)
		Next
		For $B_DIRList = 1 To UBound($A_DIRList) - 1
			$A_DIRList[$B_DIRList][1] = $PATHAUTOCONF_PathRom & "\" & $A_DIRList[$B_DIRList][0] & "\"
			$A_DIRList[$B_DIRList][2] = $PATHAUTOCONF_PathRomSub
			$A_DIRList[$B_DIRList][3] = $A_DIRList[$B_DIRList][1] & $PATHAUTOCONF_PathNew
			$A_DIRList[$B_DIRList][4] = $A_DIRList[$B_DIRList][1] & $PATHAUTOCONF_PathImage & "\"
			$A_DIRList[$B_DIRList][5] = $PATHAUTOCONF_PathImageSub
			DirCreate($A_DIRList[$B_DIRList][4])
			$ME_AutoConfigItem[$B_DIRList] = GUICtrlCreateMenuItem($A_DIRList[$B_DIRList][0], $ME_AutoConfig)
		Next
;~ 		_ArrayDisplay($A_DIRList, '$A_DIRList') ; Debug
		GUISetState(@SW_ENABLE, $F_UniversalScraper)
		SplashOff()
		Return $A_DIRList
	Else
		GUICtrlSetState($ME_AutoConfig, $GUI_DISABLE)
		GUICtrlSetState($ME_FullScrape, $GUI_DISABLE)
		GUISetState(@SW_ENABLE, $F_UniversalScraper)
		SplashOff()
		MsgBox($MB_ICONERROR, _MultiLang_GetText("err_title"), _MultiLang_GetText("err_autoconfPathRom"))
		Return -1
	EndIf
EndFunc   ;==>_AUTOCONF

Func _FUSIONXML($V_Header, $A_ROMList)
	_CREATION_LOGMESS(1, "---------------------------------------------------------------------------------------")
	_CREATION_LOGMESS(1, "Debut de fusion des fichiers")
	$TimerFusion = TimerInit()
	Local $A_XMLCible[1], $A_XMLSourceTemp, $LastLine, $Cancelled = 0
	$Nb_Roms = UBound($A_ROMList) - 1
	$No_Roms = 1
	$CheckError = 0
	$Starter = 1

	For $B_ROMList = 1 To $Nb_Roms
		If $A_ROMList[$B_ROMList][7] = 1 Or ($A_ROMList[$B_ROMList][7] = 0 And $EmptyRom = 1) Then
			$CheckError = $CheckError + 1
		Else
			If $CheckError = 0 And $EmptyRom = 0 Then
				$Starter = $B_ROMList + 1
				$No_Roms = $B_ROMList + 1
			EndIf
		EndIf
		ConsoleWrite(">ROM nÂ°" & $B_ROMList & " - $CheckError =" & $CheckError & " - $Starter = " & $Starter & " - $No_Roms = " & $No_Roms & @CRLF) ; Debug
	Next
	If $CheckError < 1 Then Return

	_GUICtrlStatusBar_SetText($L_SCRAPE, _MultiLang_GetText("prSET_XML_FUSIONROM"))
;~ 	_ArrayDisplay($A_ROMList, "$A_ROMList")

	ConsoleWrite(">Remplacement des CRLF" & @CRLF) ; Debug
	_ReplaceStringInFile($PathNew, @CRLF, @LF)

	If $V_Header = 1 And $ScrapeMode = 0 Then ConsoleWrite("NE PAS OUBLIER D'AJOUTER LE HEADER" & @CRLF) ; Debug

	If $ScrapeMode = 1 Then
		If _FileReadToArray($PathNew, $A_XMLCible) And $A_XMLCible[0] > 2 Then
			ConsoleWrite(">Scrape Mode = 1" & @CRLF) ; Debug
;~ 			_ArrayDisplay($A_XMLCible, "$A_XMLCible") ; Debug
			Local $B_DELLAST = $A_XMLCible[0]
			While $B_DELLAST > 0
				ConsoleWrite(">Suppression de la ligne " & $B_DELLAST & "- " & $A_XMLCible[$B_DELLAST] & " = " & $root_cible & @CRLF)
;~ 				$LastLine = $A_XMLCible[$B_DELLAST]
				If StringInStr($A_XMLCible[$B_DELLAST], $root_cible) > 0 Then
					_ArrayDelete($A_XMLCible, $B_DELLAST)
					$B_DELLAST = 0
				Else
					_ArrayDelete($A_XMLCible, $B_DELLAST)
				EndIf
				$B_DELLAST = $B_DELLAST - 1
			WEnd
			_ArrayDelete($A_XMLCible, 0)
;~ 			_ArrayDisplay($A_XMLCible, "$A_XMLCible Clean") ; Debug
		Else
			FileDelete($PathNew)
			ConsoleWrite(">Suppression d'ancien fichier et passage en Scrapemode = 0" & @CRLF) ; Debug
			$ScrapeMode = 0
		EndIf
	Else
		ConsoleWrite(">Scrape Mode = 0" & @CRLF) ; Debug
		FileDelete($PathNew)
		ConsoleWrite(">Suppression d'ancien fichier" & @CRLF) ; Debug
	EndIf

	While $No_Roms <= $Nb_Roms
		If $A_ROMList[$No_Roms][7] < 0 Then
			$Cancelled = 1
			ExitLoop
		EndIf
		ConsoleWrite(">Lecture du fichier" & $PathDIRTmp & $No_Roms & ".xml" & @CRLF) ; Debug
		_FileReadToArray($PathDIRTmp & $No_Roms & ".xml", $A_XMLSourceTemp, $FRTA_NOCOUNT)
;~ 		_ArrayDisplay($A_XMLSourceTemp, "$A_XMLSourceTemp Avant Clean") ; Debug
;~ 		If Not @error And $A_XMLSourceTemp[UBound($A_XMLSourceTemp) - 1] <> "" Then $LastLine = $A_XMLSourceTemp[UBound($A_XMLSourceTemp) - 1]
		Select
			Case $No_Roms = $Starter And $ScrapeMode = 0
				ConsoleWrite(">Suppression derniere ligne" & @CRLF) ; Debug
				_ArrayDelete($A_XMLSourceTemp, UBound($A_XMLSourceTemp) - 1)
			Case $No_Roms = $Nb_Roms And $ScrapeMode = 0
				ConsoleWrite(">Suppression premiere ligne" & @CRLF) ; Debug
				_ArrayDelete($A_XMLSourceTemp, 0)
			Case Else
				ConsoleWrite(">Suppression premiere et derniere ligne" & @CRLF) ; Debug
				_ArrayDelete($A_XMLSourceTemp, 0)
				_ArrayDelete($A_XMLSourceTemp, UBound($A_XMLSourceTemp) - 1)
		EndSelect
;~ 		_ArrayDisplay($A_XMLSourceTemp, "$A_XMLSourceTemp AprÃ¨s Clean") ; Debug

		ConsoleWrite("-TEST : $A_ROMList[$No_Roms][7]=" & $A_ROMList[$No_Roms][7] & " et $EmptyRom = " & $EmptyRom & @CRLF) ; Debug
		If $A_ROMList[$No_Roms][7] = 1 Or ($A_ROMList[$No_Roms][7] = 0 And $EmptyRom = 1) Then
			ConsoleWrite("!Ajout du fichier dans l'Array" & @CRLF) ; Debug
			For $B_Fusion = 0 To UBound($A_XMLSourceTemp) - 1
				_ArrayAdd($A_XMLCible, $A_XMLSourceTemp[$B_Fusion])
			Next
		EndIf
;~ 		_ArrayDisplay($A_XMLCible, "$A_XMLCible Rom nÂ°" & $No_Roms) ; Debug
		Local $PercentProgression = Round(($No_Roms * 100) / $Nb_Roms)
		GUICtrlSetData($PB_SCRAPE, $PercentProgression)
		$No_Roms = $No_Roms + 1
		ConsoleWrite(">Prochaine Rom no " & $No_Roms & " Sur " & $Nb_Roms & @CRLF) ; Debug
	WEnd

;~ 	_ArrayDisplay($A_XMLCible, "$A_XMLCible Avant Clean") ; Debug
	If @error Then MsgBox(0, 'Erreur', @error)
	Select
		Case $ScrapeMode = 1
			ConsoleWrite(">Ajout de la derniere ligne" & @CRLF) ; Debug
;~ 			_ArrayAdd($A_XMLCible, $LastLine)
		Case $Cancelled = 1
			ConsoleWrite(">Ajout de la derniere ligne et Suppression premiere ligne" & @CRLF) ; Debug
			_ArrayDelete($A_XMLCible, 0)
;~ 			_ArrayAdd($A_XMLCible, $LastLine)
		Case Else
			ConsoleWrite(">Suppression premiere ligne" & @CRLF) ; Debug
			_ArrayDelete($A_XMLCible, 0)
	EndSelect

	If StringInStr($A_XMLCible[UBound($A_XMLCible) - 1], "/" & $root_cible) < 1 Then _ArrayAdd($A_XMLCible, "</" & $root_cible & ">")

;~ 	_ArrayDisplay($A_XMLCible, "$A_XMLCible Apres Clean") ; Debug
	If UBound($A_XMLCible) - 1 > 0 Then
		ConsoleWrite(">Ecriture du fichier" & @CRLF) ; Debug
		_FileWriteFromArray($PathNew, $A_XMLCible)
		If @error Then MsgBox(1, "Erreur", "Ecriture du fichier impossible : " & $PathNew & "Error : " & @error & ")") ; Debug
		ConsoleWrite(">Remplacement des CRLF" & @CRLF) ; Debug
;~ 		_ReplaceStringInFile($PathNew, @CR, "")
;~ 		_ReplaceStringInFile($PathNew, @LF, "")
		_ReplaceStringInFile($PathNew, @CRLF, "")
		_ReplaceStringInFile($PathNew, @TAB, "")
	EndIf
	$ScrapeMode = IniRead($PathConfigINI, "LAST_USE", "$ScrapeMode", 0)

	ConsoleWrite(">Tidy du XML" & @CRLF) ; Debug
	Local $oXMLDoc = _XML_CreateDOMDocument(Default)
	_XML_Load($oXMLDoc, $PathNew)
	Local $sXmlAfterTidy = _XML_TIDY($oXMLDoc, -1)
	_XML_LoadXML($oXMLDoc, $sXmlAfterTidy)
	FileDelete($PathNew)
	_XML_SaveToFile($oXMLDoc, $PathNew)

	_CREATION_LOGMESS(1, "Fin de fusion des fichiers en " & Round((TimerDiff($TimerFusion) / 1000), 2) & "s")

	Return
EndFunc   ;==>_FUSIONXML

Func _CREATION_LOG()
	If Not _FileCreate($path_LOG) Then MsgBox(4096, "Error", " Erreur creation du Fichier LOG      error:" & @error)
	$tCur = _Date_Time_GetLocalTime()
	$dtCur = _Date_Time_SystemTimeToArray($tCur)
	FileWrite($path_LOG, "Universal XML Scraper" & @CRLF)
	FileWrite($path_LOG, "Demarrage le " & StringRight("0" & $dtCur[1], 2) & "/" & StringRight("0" & $dtCur[0], 2) & "/" & StringRight("0" & $dtCur[2], 2) & " - " & StringRight("0" & $dtCur[3], 2) & ":" & StringRight("0" & $dtCur[4], 2) & ":" & StringRight("0" & $dtCur[5], 2) & @CRLF & @CRLF)
EndFunc   ;==>_CREATION_LOG

Func _CREATION_LOGMESS($NivVerbose, $Mess)
	If $NivVerbose <= $Verbose Then
		$tCur = _Date_Time_GetLocalTime()
		$dtCur = _Date_Time_SystemTimeToArray($tCur)
		FileWrite($path_LOG, "[" & StringRight("0" & $dtCur[3], 2) & ":" & StringRight("0" & $dtCur[4], 2) & ":" & StringRight("0" & $dtCur[5], 2) & "] - " & $Mess & @CRLF)
	EndIf
EndFunc   ;==>_CREATION_LOGMESS

Func _GUI_Config($A_Profil, $No_Profil)
	#Region ### START Koda GUI section ### Form=
	$F_CONFIG = GUICreate(_MultiLang_GetText("win_config_Title"), 474, 347, -1, -1, -1, BitOR($WS_EX_TOPMOST, $WS_EX_WINDOWEDGE))
	$G_Scrape = GUICtrlCreateGroup(_MultiLang_GetText("win_config_GroupScrap"), 8, 0, 225, 153)
	$L_PathRom = GUICtrlCreateLabel(_MultiLang_GetText("win_config_GroupScrap_PathRom"), 16, 16, 208, 17)
	GUICtrlSetTip(-1, _MultiLang_GetText("tips_config_GroupScrap_PathRom"))
	$I_PathRom = GUICtrlCreateInput(IniRead($PathConfigINI, "LAST_USE", "$PathRom", $PathRom), 16, 34, 177, 21)
	$B_PathRom = GUICtrlCreateButton("...", 198, 34, 27, 21)
	$L_PathXML = GUICtrlCreateLabel(_MultiLang_GetText("win_config_GroupScrap_PathXML"), 16, 56, 110, 15)
	GUICtrlSetTip(-1, _MultiLang_GetText("tips_config_GroupScrap_PathXML"))
	$I_PathXML = GUICtrlCreateInput(IniRead($PathConfigINI, "LAST_USE", "$PathNew", $PathNew), 16, 74, 177, 21)
	$B_PathXML = GUICtrlCreateButton("...", 198, 74, 27, 21)
	$L_PathRomSub = GUICtrlCreateLabel(_MultiLang_GetText("win_config_GroupScrap_PathRomSub"), 16, 104, 208, 17)
	GUICtrlSetTip(-1, _MultiLang_GetText("tips_config_GroupScrap_PathRomSub"))
	$I_PathRomSub = GUICtrlCreateInput(IniRead($PathConfigINI, "LAST_USE", "$PathRomSub", $PathRomSub), 16, 122, 177, 21)
	$B_PathRomSub = GUICtrlCreateButton("...", 198, 122, 27, 21)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$G_Image = GUICtrlCreateGroup(_MultiLang_GetText("win_config_GroupImage"), 8, 160, 225, 177)
	$L_PathImage = GUICtrlCreateLabel(_MultiLang_GetText("win_config_GroupImage_PathImage"), 16, 176, 177, 21)
	GUICtrlSetTip(-1, _MultiLang_GetText("tips_config_GroupImage_PathImage"))
	$I_PathImage = GUICtrlCreateInput(IniRead($PathConfigINI, "LAST_USE", "$PathImage", $PathImage), 16, 194, 177, 21)
	$B_PathImage = GUICtrlCreateButton("...", 198, 194, 27, 21)
	$L_LargeurImage = GUICtrlCreateLabel(_MultiLang_GetText("win_config_GroupImage_LongImage"), 16, 274, 40, 17)
	GUICtrlSetTip(-1, _MultiLang_GetText("tips_config_GroupImage_LongImage"))
	$I_LargeurImage = GUICtrlCreateInput(IniRead($PathConfigINI, "LAST_USE", "$LargeurImage", $LargeurImage), 64, 272, 41, 21)
	$L_ImageHauteur = GUICtrlCreateLabel(_MultiLang_GetText("win_config_GroupImage_hautImage"), 128, 274, 49, 17)
	GUICtrlSetTip(-1, _MultiLang_GetText("tips_config_GroupImage_hautImage"))
	$I_ImageHauteur = GUICtrlCreateInput(IniRead($PathConfigINI, "LAST_USE", "$HauteurImage", $HauteurImage), 184, 272, 41, 21)
	$L_PathImageSub = GUICtrlCreateLabel(_MultiLang_GetText("win_config_GroupImage_PathImageSub"), 16, 224, 208, 17)
	GUICtrlSetTip(-1, _MultiLang_GetText("tips_config_GroupImage_PathImageSub"))
	$I_PathImageSub = GUICtrlCreateInput(IniRead($PathConfigINI, "LAST_USE", "$PathImageSub", $PathImageSub), 16, 242, 177, 21)
	$B_PathImageSub = GUICtrlCreateButton("...", 198, 242, 27, 21)
	$L_Ext = GUICtrlCreateLabel(_MultiLang_GetText("win_config_GroupImage_Extension"), 88, 306, 49, 17)
	GUICtrlSetTip(-1, _MultiLang_GetText("tips_config_GroupImage_Extension"))
	$C_Ext = GUICtrlCreateCombo("", 144, 304, 81, 25, BitOR($CBS_DROPDOWN, $CBS_AUTOHSCROLL))
	GUICtrlSetData($C_Ext, "defaut|jpg|png")
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$G_Autoconf = GUICtrlCreateGroup(_MultiLang_GetText("win_config_GroupAutoconf") & " - " & $A_Profil[$No_Profil], 240, 0, 225, 273)
	$L_Autoconf_PathRom = GUICtrlCreateLabel(_MultiLang_GetText("win_config_GroupAutoconf_PathRom"), 248, 16, 208, 17)
	GUICtrlSetTip(-1, _MultiLang_GetText("tips_config_GroupAutoconf_PathRom"))
	$PATHAUTOCONF_PathRom = IniRead($PathConfigINI, $A_Profil[$No_Profil], "$PATHAUTOCONF_PathRom", $PATHAUTOCONF_PathRom)
	If StringRight($PATHAUTOCONF_PathRom, 1) = '\' Then $PATHAUTOCONF_PathRom = StringTrimRight($PATHAUTOCONF_PathRom, 1)
	$I_Autoconf_PathRom = GUICtrlCreateInput($PATHAUTOCONF_PathRom, 248, 34, 177, 21)
	$B_Autoconf_PathRom = GUICtrlCreateButton("...", 430, 34, 27, 21)
	$L_Autoconf_PathXML = GUICtrlCreateLabel(_MultiLang_GetText("win_config_GroupAutoconf_PathXML"), 248, 56, 110, 15)
	GUICtrlSetTip(-1, _MultiLang_GetText("tips_config_GroupAutoconf_PathXML"))
	$I_Autoconf_PathXML = GUICtrlCreateInput(IniRead($PathConfigINI, $A_Profil[$No_Profil], "$PATHAUTOCONF_PathNew", $PATHAUTOCONF_PathNew), 248, 74, 177, 21)
	$L_Autoconf_PathRomSub = GUICtrlCreateLabel(_MultiLang_GetText("win_config_GroupAutoconf_PathRomSub"), 248, 104, 208, 17)
	GUICtrlSetTip(-1, _MultiLang_GetText("tips_config_GroupAutoconf_PathRomSub"))
	$I_Autoconf_PathRomSub = GUICtrlCreateInput(IniRead($PathConfigINI, $A_Profil[$No_Profil], "$PATHAUTOCONF_PathRomSub", $PATHAUTOCONF_PathRomSub), 248, 122, 177, 21)
	$L_Autoconf_PathImage = GUICtrlCreateLabel(_MultiLang_GetText("win_config_GroupAutoconf_PathImage"), 248, 152, 177, 21)
	GUICtrlSetTip(-1, _MultiLang_GetText("tips_config_GroupAutoconf_PathImage"))
	$I_Autoconf_PathImage = GUICtrlCreateInput(IniRead($PathConfigINI, $A_Profil[$No_Profil], "$PATHAUTOCONF_PathImage", $PATHAUTOCONF_PathImage), 248, 170, 177, 21)
	$L_Autoconf_PathImageSub = GUICtrlCreateLabel(_MultiLang_GetText("win_config_GroupAutoconf_PathImageSub"), 248, 200, 208, 17)
	GUICtrlSetTip(-1, _MultiLang_GetText("tips_config_GroupAutoconf_PathImageSub"))
	$I_Autoconf_PathImageSub = GUICtrlCreateInput(IniRead($PathConfigINI, $A_Profil[$No_Profil], "$PATHAUTOCONF_PathImageSub", $PATHAUTOCONF_PathImageSub), 248, 218, 177, 21)
	$CB_Autoconf_Use = GUICtrlCreateCheckbox(_MultiLang_GetText("win_config_GroupAutoconf_Use"), 296, 248, 97, 17)
	GUICtrlSetTip(-1, _MultiLang_GetText("tips_config_GroupAutoconf_Use"))
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$CB_EmptyRom = GUICtrlCreateCheckbox(_MultiLang_GetText("win_config_mode_empty"), 240, 280, 97, 17)
	GUICtrlSetTip(-1, _MultiLang_GetText("tips_config_mode_empty"))
	$CB_MAJ = GUICtrlCreateCheckbox(_MultiLang_GetText("win_config_mode_MAJ"), 240, 296, 97, 17)
	GUICtrlSetTip(-1, _MultiLang_GetText("tips_config_mode_MAJ"))
	$R_ScrapeMode1 = GUICtrlCreateRadio(_MultiLang_GetText("win_config_mode_new"), 344, 280, 113, 17)
	GUICtrlSetTip(-1, _MultiLang_GetText("tips_config_mode_new"))
	$R_ScrapeMode2 = GUICtrlCreateRadio(_MultiLang_GetText("win_config_mode_append"), 344, 296, 113, 17)
	GUICtrlSetTip(-1, _MultiLang_GetText("tips_config_mode_append"))
	$B_CONFENREG = GUICtrlCreateButton(_MultiLang_GetText("win_config_Enreg"), 240, 320, 67, 25)
	$B_CONFANNUL = GUICtrlCreateButton(_MultiLang_GetText("win_config_Cancel"), 310, 320, 75, 25)
	$B_CONFADVANCED = GUICtrlCreateButton(_MultiLang_GetText("win_config_Advanced"), 390, 320, 75, 25)
	GUISetState(@SW_SHOW)
	GUISetState(@SW_DISABLE, $F_UniversalScraper)
	#EndRegion ### END Koda GUI section ###

	;Initialisation
	$ExtImage = IniRead($PathConfigINI, $A_Profil[$No_Profil], "$ExtImage", "defaut")
	If $ExtImage = "defaut" Or $ExtImage = "" Then
		ConsoleWrite("$ExtImage = defaut" & @CRLF)
		$ExtImage = ""
		GUICtrlSetData($C_Ext, "defaut")
	Else
		GUICtrlSetData($C_Ext, $ExtImage)
		ConsoleWrite("$ExtImage = " & $ExtImage & @CRLF)
	EndIf

	$Autoconf_Use = IniRead($PathConfigINI, "LAST_USE", "$Autoconf_Use", $Autoconf_Use)
	If $Autoconf_Use = 1 Then
		GUICtrlSetState($CB_Autoconf_Use, $GUI_CHECKED)
	Else
		GUICtrlSetState($CB_Autoconf_Use, $GUI_UNCHECKED)
	EndIf

	$ScrapeMode = IniRead($PathConfigINI, "LAST_USE", "$ScrapeMode", $ScrapeMode)
	If $ScrapeMode = 0 Then
		GUICtrlSetState($R_ScrapeMode1, $GUI_CHECKED)
	Else
		GUICtrlSetState($R_ScrapeMode2, $GUI_CHECKED)
	EndIf

	$EmptyRom = IniRead($PathConfigINI, "LAST_USE", "$EmptyRom", $EmptyRom)
	If $EmptyRom = 1 Then
		GUICtrlSetState($CB_EmptyRom, $GUI_CHECKED)
	Else
		GUICtrlSetState($CB_EmptyRom, $GUI_UNCHECKED)
	EndIf

	$INI_OPTION_MAJ = IniRead($PathConfigINI, $A_Profil[$No_Profil], "$OPTION_MAJ", $INI_OPTION_MAJ)
	If $INI_OPTION_MAJ = 1 Then
		GUICtrlSetState($CB_MAJ, $GUI_CHECKED)
	Else
		GUICtrlSetState($CB_MAJ, $GUI_UNCHECKED)
	EndIf

	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE, $B_CONFANNUL
				GUIDelete($F_CONFIG)
				GUISetState(@SW_ENABLE, $F_UniversalScraper)
				WinActivate($F_UniversalScraper)
				Return
			Case $B_CONFADVANCED
				_GUI_ConfigA($F_CONFIG)
			Case $B_PathRom
				$PathRom = FileSelectFolder(_MultiLang_GetText("win_config_GroupScrap_PathRom"), GUICtrlRead($I_PathRom), $FSF_CREATEBUTTON, GUICtrlRead($I_PathRom), $F_CONFIG)
				If StringRight($PathRom, 1) <> '\' Then $PathRom = $PathRom & '\'
				GUICtrlSetData($I_PathRom, $PathRom)
			Case $B_PathXML
				$PathTemp = FileSaveDialog(_MultiLang_GetText("win_config_GroupScrap_PathXML"), GUICtrlRead($I_PathXML), "xml (*.xml)", 18, "gamelist.xml", $F_CONFIG)
				If Not @error Then $PathNew = $PathTemp
				GUICtrlSetData($I_PathXML, $PathNew)
			Case $B_PathRomSub
				GUICtrlSetData($I_PathRomSub, FileSelectFolder(_MultiLang_GetText("win_config_GroupScrap_PathRomSub"), GUICtrlRead($I_PathRomSub), $FSF_CREATEBUTTON, GUICtrlRead($I_PathRomSub), $F_CONFIG))
			Case $B_PathImage
				$PathImage = FileSelectFolder(_MultiLang_GetText("win_config_GroupImage_PathImage"), GUICtrlRead($I_PathRom), $FSF_CREATEBUTTON, GUICtrlRead($I_PathRom), $F_CONFIG)
				If StringRight($PathImage, 1) <> '\' Then $PathImage = $PathImage & '\'
				GUICtrlSetData($I_PathImage, $PathImage)
			Case $B_PathImageSub
				GUICtrlSetData($I_PathImageSub, FileSelectFolder(_MultiLang_GetText("win_config_GroupImage_PathImageSub"), GUICtrlRead($I_PathImageSub), $FSF_CREATEBUTTON, GUICtrlRead($I_PathImageSub), $F_CONFIG))
			Case $B_Autoconf_PathRom
				$PATHAUTOCONF_PathRom = FileSelectFolder(_MultiLang_GetText("win_config_GroupScrap_PathRom"), GUICtrlRead($I_Autoconf_PathRom), $FSF_CREATEBUTTON, GUICtrlRead($I_Autoconf_PathRom), $F_CONFIG)
				If StringRight($PATHAUTOCONF_PathRom, 1) = '\' Then $PATHAUTOCONF_PathRom = StringTrimRight($PATHAUTOCONF_PathRom, 1)
				GUICtrlSetData($I_Autoconf_PathRom, $PATHAUTOCONF_PathRom)
			Case $B_CONFENREG
				For $B_AutoConfigItem2 = 1 To UBound($ME_AutoConfigItem) - 1
					GUICtrlSetState($ME_AutoConfigItem[$B_AutoConfigItem2], $GUI_UNCHECKED)
				Next
				$PathRom = GUICtrlRead($I_PathRom) ;$PathRom
				If (StringRight($PathRom, 1) <> '\') Then $PathRom &= '\'
				IniWrite($PathConfigINI, "LAST_USE", "$PathRom", $PathRom)
				$PathRomSub = GUICtrlRead($I_PathRomSub) ;$PathRomSub
				IniWrite($PathConfigINI, "LAST_USE", "$PathRomSub", $PathRomSub)
				$PathNew = GUICtrlRead($I_PathXML) ;$PathNew
				IniWrite($PathConfigINI, "LAST_USE", "$PathNew", $PathNew)
				$PathImage = GUICtrlRead($I_PathImage) ;$PathImage
				If (StringRight($PathImage, 1) <> '\') Then $PathImage &= '\'
				IniWrite($PathConfigINI, "LAST_USE", "$PathImage", $PathImage)
				$PathImageSub = GUICtrlRead($I_PathImageSub) ;$PathImageSub
				IniWrite($PathConfigINI, "LAST_USE", "$PathImageSub", $PathImageSub)
				$HauteurImage = GUICtrlRead($I_ImageHauteur) ;$HauteurImage
				If $HauteurImage < 1 Then $HauteurImage = ""
				IniWrite($PathConfigINI, "LAST_USE", "$HauteurImage", $HauteurImage)
				$LargeurImage = GUICtrlRead($I_LargeurImage) ;$LargeurImage
				If $LargeurImage < 1 Then $LargeurImage = ""
				IniWrite($PathConfigINI, "LAST_USE", "$LargeurImage", $LargeurImage)
				$ExtImage = GUICtrlRead($C_Ext) ;$ExtImage
				If $ExtImage = "defaut" Then $ExtImage = ""
				IniWrite($PathConfigINI, $A_Profil[$No_Profil], "$ExtImage", $ExtImage)
				$PATHAUTOCONF_PathRom = GUICtrlRead($I_Autoconf_PathRom) ;$PATHAUTOCONF_PathRom
				IniWrite($PathConfigINI, $A_Profil[$No_Profil], "$PATHAUTOCONF_PathRom", $PATHAUTOCONF_PathRom)
				$PATHAUTOCONF_PathNew = GUICtrlRead($I_Autoconf_PathXML) ;$PATHAUTOCONF_PathNew
				IniWrite($PathConfigINI, $A_Profil[$No_Profil], "$PATHAUTOCONF_PathNew", $PATHAUTOCONF_PathNew)
				$PATHAUTOCONF_PathRomSub = GUICtrlRead($I_Autoconf_PathRomSub) ;$PATHAUTOCONF_PathRomSub
				IniWrite($PathConfigINI, $A_Profil[$No_Profil], "$PATHAUTOCONF_PathRomSub", $PATHAUTOCONF_PathRomSub)
				$PATHAUTOCONF_PathImage = GUICtrlRead($I_Autoconf_PathImage) ;$PATHAUTOCONF_PathImage
				IniWrite($PathConfigINI, $A_Profil[$No_Profil], "$PATHAUTOCONF_PathImage", $PATHAUTOCONF_PathImage)
				$PATHAUTOCONF_PathImageSub = GUICtrlRead($I_Autoconf_PathImageSub) ;$PATHAUTOCONF_PathImageSub
				IniWrite($PathConfigINI, $A_Profil[$No_Profil], "$PATHAUTOCONF_PathImageSub", $PATHAUTOCONF_PathImageSub)

				If _IsChecked($CB_Autoconf_Use) Then ;$Autoconf_Use
					$Autoconf_Use = 1
				Else
					$Autoconf_Use = 0
				EndIf
				IniWrite($PathConfigINI, "LAST_USE", "$Autoconf_Use", $Autoconf_Use)

				If _IsChecked($CB_MAJ) Then ;$INI_OPTION_MAJ
					$INI_OPTION_MAJ = 1
				Else
					$INI_OPTION_MAJ = 0
				EndIf
				IniWrite($PathConfigINI, $A_Profil[$No_Profil], "$OPTION_MAJ", $INI_OPTION_MAJ)

				If _IsChecked($R_ScrapeMode1) Then $ScrapeMode = 0 ;$ScrapeMode
				If _IsChecked($R_ScrapeMode2) Then $ScrapeMode = 1 ;$ScrapeMode
				IniWrite($PathConfigINI, "LAST_USE", "$ScrapeMode", $ScrapeMode) ;$ScrapeMode

				If _IsChecked($CB_EmptyRom) Then ;$EmptyRom
					$EmptyRom = 1
				Else
					$EmptyRom = 0
				EndIf
				IniWrite($PathConfigINI, "LAST_USE", "$EmptyRom", $EmptyRom)

				If Not FileExists($PathNew) And $PathNew <> "" Then
					If Not _FileCreate($PathNew) Then MsgBox($MB_SYSTEMMODAL, "Error", "Error Creating: " & $PathNew & @CRLF & "     error:" & @error)
				EndIf
				_CREATION_LOGMESS(2, "Modification de la config :" & @CRLF)
				_CREATION_LOGMESS(2, " PathRom : " & $PathRom)
				_CREATION_LOGMESS(2, " PathRomSub : " & $PathRomSub)
				_CREATION_LOGMESS(2, " PathNew : " & $PathNew)
				_CREATION_LOGMESS(2, " PathImage : " & $PathImage)
				_CREATION_LOGMESS(2, " PathImageSub : " & $PathImageSub)
				_CREATION_LOGMESS(2, " HauteurImage : " & $HauteurImage)
				_CREATION_LOGMESS(2, " LargeurImage : " & $LargeurImage & @CRLF)
				GUIDelete($F_CONFIG)
				GUISetState(@SW_ENABLE, $F_UniversalScraper)
				WinActivate($F_UniversalScraper)
				Return
		EndSwitch
	WEnd
EndFunc   ;==>_GUI_Config

Func _GUI_ConfigA($F_CONFIG)
	#Region ### START Koda GUI section ### Form=
	$F_CONFIGA = GUICreate(_MultiLang_GetText("win_config_Advanced"), 139, 295)
	$L_RechFiles = GUICtrlCreateLabel("RechFiles", 8, 8, 51, 17)
	$I_RechFiles = GUICtrlCreateInput(IniRead($PathConfigINI, "GENERAL", "$RechFiles", ""), 8, 32, 121, 21)
	$L_RechAPI = GUICtrlCreateLabel("RechAPI", 8, 120, 47, 17)
	$I_RechAPI = GUICtrlCreateInput(IniRead($PathConfigINI, "GENERAL", "$RechAPI", ""), 8, 144, 121, 21)
	$L_Verbose = GUICtrlCreateLabel("Verbose", 8, 176, 43, 17)
	$C_Verbose = GUICtrlCreateCombo("", 8, 200, 121, 25, BitOR($CBS_DROPDOWN, $CBS_AUTOHSCROLL))
	GUICtrlSetData($C_Verbose, "0|1|2", IniRead($PathConfigINI, "GENERAL", "$Verbose ", 1))
	$L_RechSYS = GUICtrlCreateLabel("RechSYS", 8, 64, 51, 17)
	$C_RechSYS = GUICtrlCreateCombo("", 8, 88, 121, 25, BitOR($CBS_DROPDOWN, $CBS_AUTOHSCROLL))
	GUICtrlSetData($C_RechSYS, "0|1", IniRead($PathConfigINI, "GENERAL", "$RechSYS", 1))
	$B_CONFAENREG = GUICtrlCreateButton(_MultiLang_GetText("win_config_Enreg"), 8, 232, 123, 25)
	$B_CONFAANNUL = GUICtrlCreateButton(_MultiLang_GetText("win_config_Cancel"), 8, 264, 123, 25)
	GUISetState(@SW_SHOW)
	#EndRegion ### END Koda GUI section ###
	GUISetState(@SW_DISABLE, $F_CONFIG)
	$aWinGetPos = WinGetPos($F_CONFIG)
	WinMove($F_CONFIGA, "", $aWinGetPos[0] + 475, $aWinGetPos[1])
	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE, $B_CONFAANNUL
				GUIDelete($F_CONFIGA)
				GUISetState(@SW_ENABLE, $F_CONFIG)
				WinActivate($F_CONFIG)
				Return
			Case $B_CONFAENREG
				$RechFiles = GUICtrlRead($I_RechFiles)
				IniWrite($PathConfigINI, "GENERAL", "$RechFiles", $RechFiles)
				$RechAPI = GUICtrlRead($I_RechAPI)
				IniWrite($PathConfigINI, "GENERAL", "$RechAPI", $RechAPI)
				$Verbose = GUICtrlRead($C_Verbose)
				IniWrite($PathConfigINI, "GENERAL", "$Verbose", $Verbose)
				$RechSYS = GUICtrlRead($C_RechSYS)
				IniWrite($PathConfigINI, "GENERAL", "$RechSYS", $RechSYS)
				GUIDelete($F_CONFIGA)
				GUISetState(@SW_ENABLE, $F_CONFIG)
				WinActivate($F_CONFIG)
				Return
		EndSwitch
	WEnd

EndFunc   ;==>_GUI_ConfigA

Func _SCRAPING_VERIF()
	Local $ERROR_MESSAGE = "", $SCRAP_OK = 0
	_CREATION_LOGMESS(2, "Test de la config")
	If (StringRight($PathRom, 1) = '\') Then $PathRom = StringTrimRight($PathRom, 1)
	If FileExists($PathRom) Then
		If (StringRight($PathRom, 1) <> '\') Then $PathRom &= '\'
		_CREATION_LOGMESS(2, "Chemin des Roms : " & $PathRom)
	Else
		$ERROR_MESSAGE = _MultiLang_GetText("err_PathRom") & @CRLF
		_CREATION_LOGMESS(2, _MultiLang_GetText("err_PathRom") & " : " & $PathRom)
		$SCRAP_OK = $SCRAP_OK + 1
	EndIf
	If Not FileExists($PathNew) Then
		If Not _FileCreate($PathNew) Then
			$ERROR_MESSAGE &= _MultiLang_GetText("err_PathNew") & @CRLF
			_CREATION_LOGMESS(2, _MultiLang_GetText("err_PathNew") & " : " & $PathNew)
			$SCRAP_OK = $SCRAP_OK + 1
		EndIf
	EndIf
	If Not FileExists($PathImage) Then
		If Not DirCreate($PathImage) Then
			$ERROR_MESSAGE &= _MultiLang_GetText("err_PathImage") & @CRLF
			_CREATION_LOGMESS(2, _MultiLang_GetText("err_PathImage") & " : " & $PathImage)
			$SCRAP_OK = $SCRAP_OK + 1
		EndIf
	EndIf
	If StringLower(StringRight($PathNew, 4)) <> ".xml" Then
		$ERROR_MESSAGE &= _MultiLang_GetText("err_PathNew_ext") & @CRLF
		_CREATION_LOGMESS(2, _MultiLang_GetText("err_PathNew_ext") & " : " & StringLower(StringRight($PathNew, 4)))
		$SCRAP_OK = $SCRAP_OK + 1
	EndIf
	If $SCRAP_OK > 0 Then _ExtMsgBox($EMB_ICONEXCLAM, "OK", _MultiLang_GetText("err_title"), $ERROR_MESSAGE, 15)
	Return $SCRAP_OK
EndFunc   ;==>_SCRAPING_VERIF

Func _GUI_REFRESH($INI_P_SOURCE, $INI_P_CIBLE, $ScrapIP = 0, $SCRAP_OK = 0)
	Local $SCRAP_ENABLE
	Local $ERROR_MESSAGE = ""
	_CREATION_LOGMESS(2, "Refresh de l'interface")
	If $ScrapIP = 0 Then

		$user_lang = IniRead($PathConfigINI, "LAST_USE", "$user_lang", -1)
		ConsoleWrite("+$user_lang = " & $user_lang & @CRLF)

		_GDIPlus_Startup()
		$hGraphic = _GDIPlus_GraphicsCreateFromHWND($F_UniversalScraper)
		$hImage = _GDIPlus_ImageLoadFromFile($SOURCE_DIRECTORY & "\Ressources\empty.jpg")
		$hImage = _GDIPlus_ImageResize($hImage, 100, 40)
		$ImageWidth = _GDIPlus_ImageGetWidth($hImage)
		$ImageHeight = _GDIPlus_ImageGetHeight($hImage)
		_WinAPI_RedrawWindow($F_UniversalScraper, 0, 0, $RDW_UPDATENOW)
		_GDIPlus_GraphicsDrawImage($hGraphic, $hImage, 175 - ($ImageWidth / 2), 82 - ($ImageHeight / 2))
		_WinAPI_RedrawWindow($F_UniversalScraper, 0, 0, $RDW_VALIDATE)
		_GDIPlus_ImageDispose($hImage)
		_GDIPlus_GraphicsDispose($hGraphic)
		_GDIPlus_Shutdown()
		If $No_Profil < 1 Then
			$ERROR_MESSAGE &= _MultiLang_GetText("err_No_Profil") & @CRLF
			_CREATION_LOGMESS(2, _MultiLang_GetText("err_No_Profil") & " : " & $No_Profil)
			$SCRAP_OK = $SCRAP_OK + 1
		EndIf
		If $SCRAP_OK = 0 Then
			GUICtrlSetImage($B_SCRAPE, $SOURCE_DIRECTORY & "\Ressources\Fleche_ENABLE.bmp", -1, 0)
			_CREATION_LOGMESS(2, "SCRAPE Enable")
			$SCRAP_ENABLE = 1
		Else
			GUICtrlSetImage($B_SCRAPE, $SOURCE_DIRECTORY & "\Ressources\Fleche_DISABLE.bmp", -1, 0)
			_CREATION_LOGMESS(2, "SCRAPE Disable")
			$SCRAP_ENABLE = 0
		EndIf

		Select
			Case $Menu_SSH = 1
				$Menu_SSH = 2
				_CREATION_LOGMESS(2, "Menu SSH Enable")
				GUICtrlSetState($MP, $GUI_ENABLE)
			Case $Menu_SSH = 2
				_CREATION_LOGMESS(2, "Menu SSH Enable")
				GUICtrlSetState($MP, $GUI_ENABLE)
		EndSelect

		GUICtrlSetState($MF, $GUI_ENABLE)
		GUICtrlSetData($MF, _MultiLang_GetText("mnu_file"))
		GUICtrlSetData($MF_Profil, _MultiLang_GetText("mnu_file_profil"))
		GUICtrlSetData($MF_Exit, _MultiLang_GetText("mnu_file_exit"))

		GUICtrlSetState($ME, $GUI_ENABLE)
		GUICtrlSetData($ME, _MultiLang_GetText("mnu_edit"))
		GUICtrlSetData($ME_AutoConfig, _MultiLang_GetText("mnu_edit_autoconf"))
		GUICtrlSetData($ME_FullScrape, _MultiLang_GetText("mnu_edit_fullscrape"))
		GUICtrlSetData($ME_Miximage, _MultiLang_GetText("mnu_edit_miximage"))
		GUICtrlSetData($ME_Langue, _MultiLang_GetText("mnu_edit_langue"))
		GUICtrlSetData($ME_Config, _MultiLang_GetText("mnu_edit_config"))

		GUICtrlSetData($MP, _MultiLang_GetText("mnu_ssh"))
		GUICtrlSetData($MP_KILLALL, _MultiLang_GetText("mnu_ssh_killall"))
		GUICtrlSetData($MP_REBOOT, _MultiLang_GetText("mnu_ssh_reboot"))
		GUICtrlSetData($MP_POWEROFF, _MultiLang_GetText("mnu_ssh_halt"))

		GUICtrlSetState($MH, $GUI_ENABLE)
		GUICtrlSetData($MH, _MultiLang_GetText("mnu_help"))
		GUICtrlSetData($MH_Help, _MultiLang_GetText("mnu_help_about"))

		GUICtrlSetData($B_SCRAPE, _MultiLang_GetText("scrap_button"))
		GUICtrlSetImage($P_SOURCE, $SOURCE_DIRECTORY & "\Ressources\" & $INI_P_SOURCE)
		GUICtrlSetImage($P_CIBLE, $SOURCE_DIRECTORY & "\Ressources\" & $INI_P_CIBLE)
		GUICtrlSetState($PB_SCRAPE, $GUI_HIDE)
		_GUICtrlStatusBar_SetText($L_SCRAPE, "")

		$A_DIRList = _AUTOCONF($PATHAUTOCONF_PathRom, $PATHAUTOCONF_PathRomSub, $PATHAUTOCONF_PathNew, $PATHAUTOCONF_PathImage, $PATHAUTOCONF_PathImageSub)

		_CREATION_LOGMESS(2, "Nettoyage de l'image du systeme")

	Else
		If $Menu_SSH = 2 Then GUICtrlSetState($MP, $GUI_DISABLE)
		_CREATION_LOGMESS(2, "Menu SSH Disable")
		GUICtrlSetState($MF, $GUI_DISABLE)
		GUICtrlSetState($ME, $GUI_DISABLE)
		GUICtrlSetState($MH, $GUI_DISABLE)
		GUICtrlSetImage($B_SCRAPE, $SOURCE_DIRECTORY & "\Ressources\Fleche_IP1.bmp", -1, 0)
		$SCRAP_ENABLE = 1
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
	_CREATION_LOGMESS(1, "Recuperation des Profil")
;~ 	_ArrayDisplay($A_Profil, '$A_Profil') ; Debug
	Return $A_Profil
EndFunc   ;==>_INI_CREATEARRAY_SCRAPER

Func _LANG_LOAD($LANG_DIR, $user_lang)
	_CREATION_LOGMESS(2, "Chargement de la langue")
	;Create an array of available language files
	; ** n=0 is the default language file
	; [n][0] = Display Name in Local Language (Used for Select Function)
	; [n][1] = Language File (Full path.  In this case we used a $LANG_DIR
	; [n][2] = [Space delimited] Character codes as used by @OS_LANG (used to select correct lang file)
	Local $LANGFILES[5][3]

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

	$LANGFILES[2][0] = "Português" ; Portuguese
	$LANGFILES[2][1] = $LANG_DIR & "\UXS-PORTUGUESE.XML"
	$LANGFILES[2][2] = "0816 " & _ ;Portuguese - Portugal
			"0416 " ;Portuguese - Brazil

	$LANGFILES[3][0] = "Deutsch" ; German
	$LANGFILES[3][1] = $LANG_DIR & "\UXS-GERMAN.XML"
	$LANGFILES[3][2] = "0407 " & _ ;German - Germany
			"0807 " & _ ;German - Switzerland
			"0C07 " & _ ;German - Austria
			"1007 " & _ ;German - Luxembourg
			"1407 " ;German - Liechtenstein

	$LANGFILES[4][0] = "Español" ; Spanish
	$LANGFILES[4][1] = $LANG_DIR & "\UXS-SPANISH.XML"
	$LANGFILES[4][2] = "040A " & _ ;Spanish - Spain
			"080A " & _ ;Spanish - Mexico
			"0C0A " & _ ;Spanish - Spain
			"100A " & _ ;Spanish - Guatemala
			"140A " & _ ;Spanish - Costa Rica
			"180A " & _ ;Spanish - Panama
			"1C0A " & _ ;Spanish - Dominican Republic
			"200A " & _ ;Spanish - Venezuela
			"240A " & _ ;Spanish - Colombia
			"280A " & _ ;Spanish - Peru
			"2C0A " & _ ;Spanish - Argentina
			"300A " & _ ;Spanish - Ecuador
			"340A " & _ ;Spanish - Chile
			"380A " & _ ;Spanish - Uruguay
			"3C0A " & _ ;Spanish - Paraguay
			"400A " & _ ;Spanish - Bolivia
			"440A " & _ ;Spanish - El Salvador
			"480A " & _ ;Spanish - Honduras
			"4C0A " & _ ;Spanish - Nicaragua
			"500A " & _ ;Spanish - Puerto Rico
			"540A " ;Spanish - United State

	;Set the available language files, names, and codes.
	_MultiLang_SetFileInfo($LANGFILES)
	If @error Then
		MsgBox(48, "Error", "Could not set file info.  Error Code " & @error)
		Exit
	EndIf

	;Check if the loaded settings file exists.  If not ask user to select language.
	If $user_lang = -1 Then
		;Create Selection GUI
		ConsoleWrite(StringLower(@OSLang) & @CRLF)
		_MultiLang_LoadLangFile(StringLower(@OSLang))
		$user_lang = _LANGUE_SelectGUI($LANGFILES, StringLower(@OSLang), -1)
		If @error Then
			MsgBox(48, "Error", "Could not create selection GUI.  Error Code " & @error)
			Exit
		EndIf
		IniWrite($PathConfigINI, "LAST_USE", "$user_lang", $user_lang)
	EndIf

	_CREATION_LOGMESS(1, "Langue Selectionnee : " & $user_lang)

	Local $ret = _MultiLang_LoadLangFile($user_lang)
	If @error Then
		MsgBox(48, "Error", "Could not load lang file.  Error Code " & @error)
		Exit
	EndIf

	;If you supplied an invalid $user_lang, we will load the default language file
	If $ret = 2 Then
		MsgBox(64, "Information", "Just letting you know that we loaded the default language file")
	EndIf

	Switch StringRight($user_lang, 2)
		Case '09'
			IniWrite($PathConfigINI, "GENERAL", "$RechMultiLang", 'us|en|origine|eu|es|fr|de|pt|jp|xx')
		Case '0c'
			IniWrite($PathConfigINI, "GENERAL", "$RechMultiLang", 'fr|eu|us|en|origine|de|es|pt|jp|xx')
		Case '16'
			IniWrite($PathConfigINI, "GENERAL", "$RechMultiLang", 'pt|eu|us|en|origine|fr|de|es|jp|xx')
		Case '07'
			IniWrite($PathConfigINI, "GENERAL", "$RechMultiLang", 'de|eu|us|en|origine|fr|es|pt|jp|xx')
		Case '0A'
			IniWrite($PathConfigINI, "GENERAL", "$RechMultiLang", 'es|eu|us|en|origine|fr|de|pt|jp|xx')
	EndSwitch
	Return $LANGFILES
EndFunc   ;==>_LANG_LOAD

Func _LANGUE_SelectGUI($_gh_aLangFileArray, $default = @OSLang, $demarrage = 0)
	_CREATION_LOGMESS(2, "Selection de la langue")
	If $demarrage = 0 Then GUISetState(@SW_DISABLE, $F_UniversalScraper)
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
			If $demarrage = 0 Then
				GUISetState(@SW_ENABLE, $F_UniversalScraper)
				WinActivate($F_UniversalScraper)
			EndIf
			Switch StringRight($user_lang, 2)
				Case '09'
					IniWrite($PathConfigINI, "GENERAL", "$RechMultiLang", 'us|en|origine|eu|es|fr|de|pt|jp|xx')
				Case '0c'
					IniWrite($PathConfigINI, "GENERAL", "$RechMultiLang", 'fr|eu|us|en|origine|de|es|pt|jp|xx')
				Case '16'
					IniWrite($PathConfigINI, "GENERAL", "$RechMultiLang", 'pt|eu|us|en|origine|fr|de|es|jp|xx')
				Case '07'
					IniWrite($PathConfigINI, "GENERAL", "$RechMultiLang", 'de|eu|us|en|origine|fr|es|pt|jp|xx')
				Case '0A'
					IniWrite($PathConfigINI, "GENERAL", "$RechMultiLang", 'es|eu|us|en|origine|fr|de|pt|jp|xx')
			EndSwitch
			Return StringLeft($_gh_aLangFileArray[$i][2], 4)
		EndIf
	Next
	If $demarrage = 0 Then
		GUISetState(@SW_ENABLE, $F_UniversalScraper)
		WinActivate($F_UniversalScraper)
	EndIf

	Return $default
EndFunc   ;==>_LANGUE_SelectGUI

Func _PROFIL_SelectGUI($A_Profil, $No_Profil = 0)
	_CREATION_LOGMESS(2, "Selection du profil")
	If $No_Profil = 0 Then GUISetState(@SW_DISABLE, $F_UniversalScraper)
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
			_CREATION_LOGMESS(1, "Profil : " & $A_Profil[$i])
			IniWrite($PathConfigINI, "LAST_USE", "$No_Profil", $i)
			If $No_Profil = 0 Then
				GUISetState(@SW_ENABLE, $F_UniversalScraper)
				WinActivate($F_UniversalScraper)
			EndIf
			Return $i
		EndIf
	Next
	If $No_Profil = 0 Then
		GUISetState(@SW_ENABLE, $F_UniversalScraper)
		WinActivate($F_UniversalScraper)
	EndIf
	Return 1
EndFunc   ;==>_PROFIL_SelectGUI

Func _ROM_CREATEARRAY($PathRom)
	$RechFiles = IniRead($PathConfigINI, "GENERAL", "$RechFiles ", "*.*z*")
	_CREATION_LOGMESS(2, "Recuperation de la liste des ROM")
;~ 	Global $A_ROMList = _FileListToArray($PathRom, "*.*")
	Global $A_ROMList = _FileListToArrayRec($PathRom, $RechFiles, $FLTAR_FILES, $FLTAR_NORECUR, $FLTAR_SORT)

	If @error = 1 Then
		_CREATION_LOGMESS(1, "/!\ Chemin de recherche des roms invalide " & $PathRom)
		If $FullScrapeIP = 0 Then MsgBox($MB_ICONERROR, _MultiLang_GetText("err_title"), _MultiLang_GetText("err_PathRom"))
		Return -1
	EndIf
	If @error = 4 Then
		_CREATION_LOGMESS(1, "/!\ Aucune rom trouvee dans  " & $PathRom)
		If $FullScrapeIP = 0 Then MsgBox($MB_ICONERROR, _MultiLang_GetText("err_title"), _MultiLang_GetText("err_FillRomList"))
		Return -1
	EndIf

	For $B_COLINSRT = 1 To 9
		_ArrayColInsert($A_ROMList, $B_COLINSRT)
	Next

	_CREATION_LOGMESS(1, "Nombre de roms trouvees : " & UBound($A_ROMList) - 1)

	For $B_ROMList = 1 To UBound($A_ROMList) - 1
		$A_ROMList[$B_ROMList][7] = -1
	Next

;~ 	_ArrayDisplay($A_ROMList, '$A_ROMList') ; Debug
;~ 	_ArraySort($A_ROMList)
	Return $A_ROMList
EndFunc   ;==>_ROM_CREATEARRAY

Func _SCRAPING($No_Profil, $A_Profil, $PathRom, $No_system, $INI_OPTION_MAJ, $V_Header)
;~ 	Initialisation Variables
	Local $A_ROMXMLList
	Local $A_MIX_IMAGE_Format
	$Moy_Timer = 0
	$Total_Timer = 0
	$ScrapeMode = IniRead($PathConfigINI, "LAST_USE", "$ScrapeMode", 0)

;~ 	Initialisation Profil
	$A_Profil = _INI_CREATEARRAY_SCRAPER()
	Local $A_XMLFormat = _XML_CREATEFORMAT($A_Profil[$No_Profil])
	Local $Nb_XMLElements = UBound($A_XMLFormat) - 1
;~ 	_ArrayDisplay($A_XMLFormat, '$A_XMLFormat') ; Debug

;~ 	Initialisation ROMList
	$A_ROMList = _ROM_CREATEARRAY($PathRom)
	If $A_ROMList = -1 Then Return -1
	Local $Nb_Roms = UBound($A_ROMList) - 1

;~ 	Initialisation des Xpath
	For $B_XMLElements = 0 To $Nb_XMLElements
		If $A_XMLFormat[$B_XMLElements][1] = "root" Then
			Local $xpath_root_cible = "//" & $A_XMLFormat[$B_XMLElements][0]
			$root_cible = $A_XMLFormat[$B_XMLElements][0]
		EndIf
		If $A_XMLFormat[$B_XMLElements][3] = "root" Then Local $xpath_root_source = "//" & $A_XMLFormat[$B_XMLElements][2]
		If StringLeft($A_XMLFormat[$B_XMLElements][2], 11) = "%mix_image%" Then $A_MIX_IMAGE_Format = _MIX_IMAGE_CREATEFORMAT()
	Next
	ConsoleWrite("$xpath_root_source : " & $xpath_root_source & @CRLF) ; Debug
	ConsoleWrite("$xpath_root_cible : " & $xpath_root_cible & @CRLF) ; Debug

;~ 	Initialisation Repertoire Temporaire
	DirCreate($PathDIRTmp)

;~ 	Recherche des roms deja existantes
	If $ScrapeMode = 1 Then $A_ROMXMLList = _ROMXML_CREATEARRAY($PathNew, $A_XMLFormat)
	If $A_ROMXMLList = -1 Then
		$ScrapeMode = 0
		ConsoleWrite("Passage en Scrapmode = 0" & @CRLF) ; Debug
	EndIf

;~ 	Creation du header
	If $V_Header = 1 And $ScrapeMode = 0 Then
		_CREATION_LOGMESS(1, "Creation du Header")
		$PathNewTemp = $PathDIRTmp & "0.xml"
		$A_HEADERFormat = _HEADER_CREATEFORMAT($A_Profil[$No_Profil])
		$Nb_XMLHeader = UBound($A_HEADERFormat) - 1
		For $B_XMLHeader = 0 To $Nb_XMLHeader - 1
			If $A_HEADERFormat[$B_XMLHeader][1] = "root" Then Local $xpath_root_cible = "//" & $A_HEADERFormat[$B_XMLHeader][0]
			If $A_HEADERFormat[$B_XMLHeader][3] = "root" Then Local $xpath_root_source = "//" & $A_HEADERFormat[$B_XMLHeader][2]
		Next
		ConsoleWrite("$xpath_root_source Header : " & $xpath_root_source & @CRLF) ; Debug
		ConsoleWrite("$xpath_root_cible HEader : " & $xpath_root_cible & @CRLF) ; Debug
		_XML_CREATEHEADER($PathTmp_GAME, $PathNewTemp, $xpath_root_source, $xpath_root_cible, $A_HEADERFormat, $A_ROMList, $No_system, $INI_OPTION_MAJ)
	EndIf

	For $B_ROMList = 1 To $Nb_Roms
;~ 		Demarrage du Timer
		$Timer = TimerInit()
		$TimerHash = TimerInit()
		$FOUND = 0

;~ 		Recherche de rom deja existante
		If _ArraySearch($A_ROMXMLList, $A_ROMList[$B_ROMList][0], 0, 0, 0, 0, 1, 2) <> -1 Then $FOUND = 1
;~ 		MsgBox(0, "Recherche", $A_ROMList[$B_ROMList][0] & " -> " & $FOUND)

		If $FOUND = 0 Then
;~ 		Calcul des Hash et informations sur la ROM
			_CREATION_LOGMESS(1, "---------------------------------------------------------------------------------------")
			$A_ROMList[$B_ROMList][1] = $PathRom & $A_ROMList[$B_ROMList][0]
			_CREATION_LOGMESS(2, "Nom de la ROM : " & $A_ROMList[$B_ROMList][1])
			$A_ROMList[$B_ROMList][2] = StringRight(_CRC32ForFile($A_ROMList[$B_ROMList][1]), 8)
			_CREATION_LOGMESS(2, "CRC32 : " & $A_ROMList[$B_ROMList][2])
			$A_ROMList[$B_ROMList][5] = FileGetSize($A_ROMList[$B_ROMList][1])
			_CREATION_LOGMESS(2, "Taille de la ROM : " & $A_ROMList[$B_ROMList][5])
			If IniRead($PathConfigINI, "GENERAL", "Quick", 0) = 0 Then
				If Int(($A_ROMList[$B_ROMList][5] / 1048576)) < 50 Then
					$A_ROMList[$B_ROMList][3] = _MD5ForFile($A_ROMList[$B_ROMList][1])
					_CREATION_LOGMESS(2, "MD5 : " & $A_ROMList[$B_ROMList][3])
					$A_ROMList[$B_ROMList][4] = _SHA1ForFile($A_ROMList[$B_ROMList][1])
					_CREATION_LOGMESS(2, "SHA1 : " & $A_ROMList[$B_ROMList][4])
				Else
					_CREATION_LOGMESS(2, "Quick Mode ON (Rom Size = " & Int(($A_ROMList[$B_ROMList][5] / 1048576)) & ")")
					ConsoleWrite("Quick Mode ON (Rom Size = " & ($A_ROMList[$B_ROMList][5] / 1048576) & ")" & @CRLF)
				EndIf
			EndIf
			_CREATION_LOGMESS(1, "Calcul des Hash en : " & Round((TimerDiff($TimerHash) / 1000), 2) & "s")
			ConsoleWrite("Calcul des Hash en : " & Round((TimerDiff($TimerHash) / 1000), 2) & "s" & @CRLF)

;~ 		Recuperation et ecriture des informations de la Rom
			$CreateROM = _XML_CREATEROM($PathTmp_GAME, $xpath_root_source, $xpath_root_cible, $A_XMLFormat, $A_ROMList, $B_ROMList, $No_system, $INI_OPTION_MAJ, $A_MIX_IMAGE_Format)
		EndIf

		If GUIGetMsg() = $B_SCRAPE Or $ScrapeCancelled = 1 Then
			_GUICtrlStatusBar_SetText($L_SCRAPE, "", 1)
			$ScrapeCancelled = 1
			Return $A_ROMList
		EndIf

		Select
			Case $FOUND = 1
				_CREATION_LOGMESS(1, "(*)Rom deja existante : " & $A_ROMList[$B_ROMList][0] & " (Hash : " & $A_ROMList[$B_ROMList][2] & ")")
				$A_ROMList[$B_ROMList][7] = 2
				$CreateROM = 0
			Case $CreateROM = 0 And $FOUND = 0
				_CREATION_LOGMESS(1, "(*)Rom non trouve : " & $A_ROMList[$B_ROMList][0] & " (Hash : " & $A_ROMList[$B_ROMList][2] & ")")
				$A_ROMList[$B_ROMList][7] = 0
			Case $CreateROM > 0 And $FOUND = 0
				_CREATION_LOGMESS(1, "Rom trouve : " & $A_ROMList[$B_ROMList][0] & " (Hash : " & $A_ROMList[$B_ROMList][2] & ")")
				$A_ROMList[$B_ROMList][7] = 1
			Case $CreateROM < 0 And $FOUND = 0
				_CREATION_LOGMESS(1, "(*)Time Out : " & $A_ROMList[$B_ROMList][0] & " (Hash : " & $A_ROMList[$B_ROMList][2] & ")")
				$A_ROMList[$B_ROMList][7] = 0
		EndSelect

;~ 		Calcul du temps restant
		$A_ROMList[$B_ROMList][6] = Round((TimerDiff($Timer) / 1000), 3)
		_CREATION_LOGMESS(1, "Fin de l'ecriture des informations de la Rom no " & $B_ROMList & " en " & $A_ROMList[$B_ROMList][6] & "s")
		$Total_Timer = $Total_Timer + $A_ROMList[$B_ROMList][6]
		$Moy_Timer = Round($Total_Timer / $B_ROMList, 3)
		$Rest_Time = $Moy_Timer * ($Nb_Roms - $B_ROMList)
		$Mins = Floor($Rest_Time / 60)
		$Secs = Round(Mod($Rest_Time, 60))
		$Text = " - " & $B_ROMList & "/" & $Nb_Roms
		$Text2 = $Mins & "m " & $Secs & "s"
		_GUICtrlStatusBar_SetText($L_SCRAPE, _MultiLang_GetText("prSET_XML_CREATEROM") & $Text)
		_GUICtrlStatusBar_SetText($L_SCRAPE, @TAB & @TAB & $Text2, 1)
		Local $PercentProgression = Round(($B_ROMList * 100) / $Nb_Roms)
		GUICtrlSetData($PB_SCRAPE, $PercentProgression)

	Next
	_GUICtrlStatusBar_SetText($L_SCRAPE, "", 1)
	Return $A_ROMList
EndFunc   ;==>_SCRAPING

Func _SCRAPING_BILAN($FullTimer, $A_ROMList)
	Local $Hour, $Mins, $Secs, $Cancelled = 0, $Tmp_Drive, $Tmp_Dir, $Tmp_FileName, $Tmp_Extension, $Tmp_Dir_Old = ""
	$Nb_Roms = UBound($A_ROMList) - 1
	$ROMFound = 0
	$ROMAdded = 0
	$ROMMaj = 0
	$Nb_Roms_Scanned = 0

;~ 	_ArrayDisplay($A_ROMList, "$A_ROMList");Debug

	_CREATION_LOGMESS(1, "Bilan" & @CRLF)

	For $B_ROMList = 1 To $Nb_Roms
		$A_PathRomSplit = _PathSplit($A_ROMList[$B_ROMList][1], $Tmp_Drive, $Tmp_Dir, $Tmp_FileName, $Tmp_Extension)
		ConsoleWrite($B_ROMList & " - " & $Tmp_Drive & $Tmp_Dir & " - " & $Tmp_Drive & $Tmp_Dir_Old & @CRLF)
		If $Tmp_Dir <> $Tmp_Dir_Old Then
			If Not _FileCreate($Tmp_Drive & $Tmp_Dir & "missing.txt") Then MsgBox(4096, "Error", " Erreur creation du Fichier missing      error:" & @error)
;~ 			If Not _FileCreate($Tmp_Dir & "missing_Image.txt") Then MsgBox(4096, "Error", " Erreur creation du Fichier missing      error:" & @error)
			$Tmp_Dir_Old = $Tmp_Dir
		EndIf
		$tCur = _Date_Time_GetLocalTime()
		$Missing_Line1 = StringLeft($A_ROMList[$B_ROMList][0] & "                                                                     ", 68)
		$Missing_Line2 = $A_ROMList[$B_ROMList][2]
		$Missing_Line3 = StringRight("                  " & StringRegExpReplace($A_ROMList[$B_ROMList][5], '\G(\d+?)(?=(\d{3})+(\D|$))', '$1 '), 17) & "    "
		$H_File = _WinAPI_CreateFile($A_ROMList[$B_ROMList][1], 2)
		$aTime = _Date_Time_GetFileTime($H_File)
		_WinAPI_CloseHandle($H_File)
		$Time = _Date_Time_FileTimeToStr($aTime[2])
		$Time = StringMid($Time, 12, 5) & ".00 " & StringMid($Time, 7, 4) & "-" & StringLeft($Time, 2) & "-" & StringMid($Time, 4, 2)
		$Missing_Line4 = "    " & $A_ROMList[$B_ROMList][3]

		If $A_ROMList[$B_ROMList][7] = 0 Then FileWrite($Tmp_Drive & $Tmp_Dir & "missing.txt", $Missing_Line1 & $Missing_Line2 & $Missing_Line3 & $Time & $Missing_Line4 & @CRLF)
;~ 		If StringLen($A_ROMList[$B_ROMList][9]) > 1 Then FileWrite($Tmp_Dir & "missing_Image.txt", $A_ROMList[$B_ROMList][8] & @CRLF)
		If $A_ROMList[$B_ROMList][7] = 1 Then $ROMFound = $ROMFound + 1
		If $A_ROMList[$B_ROMList][7] = 2 Then $ROMMaj = $ROMMaj + 1
		If $A_ROMList[$B_ROMList][7] < 0 Then
			$ScrapeCancelled = 1
			ExitLoop
		Else
			If $A_ROMList[$B_ROMList][7] = 1 Or ($A_ROMList[$B_ROMList][7] = 0 And $EmptyRom = 1) Then $ROMAdded = $ROMAdded + 1
			$Nb_Roms_Scanned = $Nb_Roms_Scanned + 1
		EndIf
	Next
	_TicksToTime(Int($FullTimer), $Hour, $Mins, $Secs)
	If $ScrapeCancelled = 1 Then
		$sMsg = _MultiLang_GetText("win_Cancel_Text") & @CRLF & @CRLF
		_CREATION_LOGMESS(1, "Scrape Annule")
	Else
		_CREATION_LOGMESS(1, "Scrape Termine")
		$sMsg = _MultiLang_GetText("win_Datas_Text") & @CRLF & @CRLF
	EndIf
	$sMsg &= _MultiLang_GetText("win_Datas_RomsFound") & " " & $ROMFound & " / " & $Nb_Roms_Scanned & @CRLF
	_CREATION_LOGMESS(1, " Roms trouvees :" & $ROMFound & " / " & $Nb_Roms_Scanned)
	If $ScrapeMode = 1 Then
		$sMsg &= _MultiLang_GetText("win_Datas_RomsExist") & " " & $ROMMaj & " / " & $Nb_Roms_Scanned & @CRLF
		_CREATION_LOGMESS(1, " Roms deja existantes :" & $ROMMaj & " / " & $Nb_Roms_Scanned)
	EndIf
	$sMsg &= _MultiLang_GetText("win_Datas_RomsAdd") & " " & $ROMAdded & " / " & $Nb_Roms_Scanned & @CRLF
	_CREATION_LOGMESS(1, " Roms ajoutes :" & $ROMAdded & " / " & $Nb_Roms_Scanned)
	$sMsg &= _MultiLang_GetText("win_Datas_MoyTime") & " " & $Moy_Timer & "s" & @CRLF
	_CREATION_LOGMESS(1, " Temps moyen par Rom :" & $Moy_Timer & "s")
	$sMsg &= _MultiLang_GetText("win_Datas_FullTime") & " " & $Hour & "h " & $Mins & "m " & $Secs & "s" & @CRLF
	_CREATION_LOGMESS(1, " Temps Total :" & $Hour & "h " & $Mins & "m " & $Secs & "s")
	_ExtMsgBoxSet(1, 2, 0x34495c, 0xFFFF00, 10, "Arial")
	If $ScrapeCancelled = 1 Then
		$ScrapeCancelled = 0
		_ExtMsgBox($EMB_ICONSTOP, "OK", _MultiLang_GetText("win_Cancel_Title"), $sMsg)
	Else
		_ExtMsgBox($EMB_ICONINFO, "OK", _MultiLang_GetText("win_Datas_Title"), $sMsg)
	EndIf
EndFunc   ;==>_SCRAPING_BILAN

Func _SYSTEM_CREATEARRAY_SCREENSCRAPER()
	Local $A_XMLSources[1][4]
	Local $TMP_LastUbound = UBound($A_XMLSources)
	Local $sNode_Values

	_GUICtrlStatusBar_SetText($L_SCRAPE, _MultiLang_GetText("prSET_SYSTEM_CREATEARRAY"))
	_CREATION_LOGMESS(1, "Recuperation des informations des systemes")
	$hDownload = InetGet("http://www.screenscraper.fr/api/systemesListe.php?devid=" & $DevId & "&devpassword=" & $DevPassword & "&softname=" & $Softname & "&output=XML", $PathTmp_SYS, 0, 1)

	If _TimeOut($hDownload) Or Not FileExists($PathTmp_SYS) Then
		MsgBox($MB_ICONERROR, _MultiLang_GetText("err_title"), _MultiLang_GetText("err_TimeOut") & ' (System List)')
		Return -1
	EndIf

	_XMLFileOpen($PathTmp_SYS)
	If @error Then
		ConsoleWrite("!_XMLFileOpen : " & _XMLError("") & @CRLF) ; Debug
		_CREATION_LOGMESS(1, "Fichier d'informations non valide")
		Return -1
	EndIf

	Local $A_Nodes = _XMLGetChildNodes("//Data")
	If @error Then
		ConsoleWrite("!__XMLGetChildNodes : " & _XMLError("") & @CRLF) ; Debug
		Return -1
	EndIf
;~ 	_ArrayDisplay($A_Nodes, '$A_Nodes') ; Debug

	For $B_Nodes = 1 To UBound($A_Nodes) - 1
		Local $PercentProgression = Round(($B_Nodes * 100) / (UBound($A_Nodes) - 1))
		GUICtrlSetData($PB_SCRAPE, $PercentProgression)
		$TMP_LastUbound = UBound($A_XMLSources)
		ReDim $A_XMLSources[$TMP_LastUbound + 1][4]
		$sNode_Values = _XMLGetValue("//Data/*[" & $B_Nodes & "]/noms/nom_eu")
		If IsArray($sNode_Values) Then
			$A_XMLSources[$TMP_LastUbound][0] = ($sNode_Values[1])
			If $A_XMLSources[$TMP_LastUbound][0] = Null Then $A_XMLSources[$TMP_LastUbound][0] = ""
			_CREATION_LOGMESS(2, "Nom du systeme trouve : " & $A_XMLSources[$TMP_LastUbound][0])
		EndIf
		$sNode_Values = _XMLGetValue("//Data/*[" & $B_Nodes & "]/medias/media_wheelssteel/media_wheelsteel_eu")
		If IsArray($sNode_Values) Then
			$A_XMLSources[$TMP_LastUbound][1] = $sNode_Values[1] & "&maxwidth=100&maxheight=40"
			If $A_XMLSources[$TMP_LastUbound][1] = Null Then $A_XMLSources[$TMP_LastUbound][1] = ""
			_CREATION_LOGMESS(2, "Image du systeme EU trouvee ")
		Else
			$sNode_Values = _XMLGetValue("//Data/*[" & $B_Nodes & "]/medias/media_wheelssteel/media_wheelsteel_us")
			If IsArray($sNode_Values) Then
				$A_XMLSources[$TMP_LastUbound][1] = $sNode_Values[1] & "&maxwidth=100&maxheight=40"
				If $A_XMLSources[$TMP_LastUbound][1] = Null Then $A_XMLSources[$TMP_LastUbound][1] = ""
				_CREATION_LOGMESS(2, "Image du systeme US trouvee ")
			Else
				_CREATION_LOGMESS(2, "Image du systeme NON trouvee ")
			EndIf
		EndIf
		$sNode_Values = _XMLGetValue("//Data/*[" & $B_Nodes & "]/id")
		If IsArray($sNode_Values) Then
			$A_XMLSources[$TMP_LastUbound][2] = ($sNode_Values[1])
			$A_XMLSources[$TMP_LastUbound][3] = $TMP_LastUbound
			If $A_XMLSources[$TMP_LastUbound][2] = Null Then $A_XMLSources[$TMP_LastUbound][2] = ""
			_CREATION_LOGMESS(2, "ID du systeme trouve : " & $A_XMLSources[$TMP_LastUbound][2])
		EndIf
	Next
;~ 	_ArrayDisplay($A_XMLSources, '$A_XMLSources pas trié') ; Debug
	_CREATION_LOGMESS(2, "Tri des systemes trouves")
	_ArraySort($A_XMLSources)
;~ 	_ArrayDisplay($A_XMLSources, '$A_XMLSources trié') ; Debug
	$A_XMLSourcesFIXE = $A_XMLSources
	Return $A_XMLSources
EndFunc   ;==>_SYSTEM_CREATEARRAY_SCREENSCRAPER

Func _SYSTEM_SelectGUI($A_System, $FullScrape = 0)

	Local $A_SYSTEMList, $_selected, $I_SystemName = -1

	_CREATION_LOGMESS(1, "Selection du systeme")
	GUISetState(@SW_DISABLE, $F_UniversalScraper)

	_FileReadToArray($PathSystemList, $A_SYSTEMList, $FRTA_NOCOUNT, "|")
	$A_PathRom = StringSplit($PathRom, "\", $STR_NOCOUNT)
	If $A_PathRom[UBound($A_PathRom) - 1] = "" Then _ArrayDelete($A_PathRom, UBound($A_PathRom) - 1)
;~ 	_ArrayDisplay($A_SYSTEMList, "$A_SYSTEMList");Debug
;~ 	_ArrayDisplay($A_PathRom, "$A_PathRom");Debug
	$PathSystemName = StringLower($A_PathRom[UBound($A_PathRom) - 1])
;~ 	MsgBox(0, "$PathSystemName", $PathSystemName) ;Debug
	$I_SystemName = _ArraySearch($A_SYSTEMList, $PathSystemName)
;~ 	MsgBox(0, "$I_SystemName", $I_SystemName) ;Debug
;~ 	MsgBox(0, "System trouve", $PathSystemName & " = " & $A_SYSTEMList[$I_SystemName][1]) ;Debug

	Select
		Case $I_SystemName > 0 And (IniRead($PathConfigINI, "GENERAL", "$RechSYS", '1') = 1 Or $FullScrape = 1)
			$_selected = $A_SYSTEMList[$I_SystemName][1]
		Case $I_SystemName <= 0 And $FullScrape = 1
			$_selected = ""
		Case Else
			If $A_System = -1 Then Return SetError(1, 0, 0)
			If IsArray($A_System) = 0 Then Return SetError(1, 0, 0)
			Local $_system_gui_GUI = GUICreate(_MultiLang_GetText("win_sel_SYSTEM_Title"), 230, 100)
			Local $_system_gui_Combo = GUICtrlCreateCombo("(" & _MultiLang_GetText("win_sel_SYSTEM_Title") & ")", 8, 48, 209, 25, BitOR($GUI_SS_DEFAULT_COMBO, $CBS_SIMPLE))
			Local $_system_gui_Button = GUICtrlCreateButton(_MultiLang_GetText("win_sel_SYSTEM_button"), 144, 72, 75, 25)
			Local $_system_gui_Label = GUICtrlCreateLabel(_MultiLang_GetText("win_sel_SYSTEM_text"), 8, 8, 212, 33)

			For $i = 0 To UBound($A_System) - 1
				GUICtrlSetData($_system_gui_Combo, $A_System[$i][0], "(" & _MultiLang_GetText("win_sel_SYSTEM_Title") & ")")
			Next

			GUISetState(@SW_SHOW)
			While 1
				$nMsg = GUIGetMsg()
				Switch $nMsg
					Case -3, $_system_gui_Button
						ExitLoop
				EndSwitch
			WEnd
			$_selected = GUICtrlRead($_system_gui_Combo)
			GUIDelete($_system_gui_GUI)
	EndSelect

;~ 	_ArrayDisplay($A_SYSTEM, '$A_SYSTEM') ; Debug
	For $i = 0 To UBound($A_System) - 1
;~ 		If StringInStr($A_SYSTEM[$i][0], $_selected) Then
		If $A_System[$i][0] = $_selected Then
			GUISetState(@SW_ENABLE, $F_UniversalScraper)
			WinActivate($F_UniversalScraper)
			_CREATION_LOGMESS(1, "Systeme selectionne : " & $A_System[$i][0])
			ConsoleWrite("Download : " & $A_System[$i][1] & @CRLF) ;Debug
			$ImageSystem = $SOURCE_DIRECTORY & "\Ressources\systeme.png"
			FileDelete($ImageSystem)

			_CREATION_LOGMESS(2, "Telechargement de l'image du systeme")
			$hDownload = InetGet($A_System[$i][1], $ImageSystem, 0, 1)
			_TimeOut($hDownload)

			If Not FileExists($ImageSystem) Then $ImageSystem = $SOURCE_DIRECTORY & "\Ressources\emptySYS.jpg"
			_CREATION_LOGMESS(2, "Affichage de l'image du systeme")
			_GDIPlus_Startup()
			$hGraphic = _GDIPlus_GraphicsCreateFromHWND($F_UniversalScraper)
			$hImage = _GDIPlus_ImageLoadFromFile($ImageSystem)
			$ImageWidth = _GDIPlus_ImageGetWidth($hImage)
			$ImageHeight = _GDIPlus_ImageGetHeight($hImage)
			_WinAPI_RedrawWindow($F_UniversalScraper, 0, 0, $RDW_UPDATENOW)
			_GDIPlus_GraphicsDrawImage($hGraphic, $hImage, 175 - ($ImageWidth / 2), 82 - ($ImageHeight / 2))
			_WinAPI_RedrawWindow($F_UniversalScraper, 0, 0, $RDW_VALIDATE)
			_GDIPlus_GraphicsDispose($hGraphic)
			_GDIPlus_ImageDispose($hImage)
			_GDIPlus_Shutdown()
			FileDelete($ImageSystem)

			Return $A_System[$i][2]
		EndIf
	Next
	GUISetState(@SW_ENABLE, $F_UniversalScraper)
	WinActivate($F_UniversalScraper)
	Return -1
EndFunc   ;==>_SYSTEM_SelectGUI

Func _XML_CREATEFORMAT($Profil)
	_CREATION_LOGMESS(1, "Recuperation des champs du profil")
	Local $A_XMLFormat[1][4]
	Local $B_Elements = 1, $V_Elements2
	Local $RechMultiLang = StringSplit(IniRead($PathConfigINI, "GENERAL", "$RechMultiLang  ", 'us|en|origine|eu|es|fr|de|pt|jp|xx'), "|")
	Local $V_Elements = IniRead($PathConfigINI, $Profil, "$ELEMENT_" & $B_Elements, "Ending")
	While $V_Elements <> "Ending"
		If StringInStr($V_Elements, "%%") Then
			For $B_RechMultiLang = 1 To UBound($RechMultiLang) - 1
				$V_Elements2 = StringReplace($V_Elements, '%%', $RechMultiLang[$B_RechMultiLang])
				_ArrayAdd($A_XMLFormat, $V_Elements2)
			Next
		Else
			_ArrayAdd($A_XMLFormat, $V_Elements)
		EndIf
		$B_Elements = $B_Elements + 1
		$V_Elements = IniRead($PathConfigINI, $Profil, "$ELEMENT_" & $B_Elements, "Ending")
	WEnd
	_CREATION_LOGMESS(2, "Fin de recuperation des champs du profil")
;~ 	_ArrayDisplay($A_XMLFormat, '$A_XMLFormat') ; Debug
	Return $A_XMLFormat
EndFunc   ;==>_XML_CREATEFORMAT

Func _HEADER_CREATEFORMAT($Profil)
	Local $A_HEADERFormat[1][4]
	Local $B_Elements = 1
	_CREATION_LOGMESS(1, "Recuperation des champs du header")
	While IniRead($PathConfigINI, $Profil, "$HEADER_" & $B_Elements, "Ending") <> "Ending"
		_ArrayAdd($A_HEADERFormat, IniRead($PathConfigINI, $Profil, "$HEADER_" & $B_Elements, ""))
		$B_Elements = $B_Elements + 1
	WEnd
	_CREATION_LOGMESS(2, "Fin de recuperation des champs du header")
;~ 	_ArrayDisplay($A_XMLFormat, '$A_XMLFormat') ; Debug
	Return $A_HEADERFormat
EndFunc   ;==>_HEADER_CREATEFORMAT

Func _XML_CREATEROM($Path_source, $xpath_root_source, $xpath_root_cible, $A_XMLFormat, $A_ROMList, $No_ROM, $No_system, $INI_OPTION_MAJ, $A_MIX_IMAGE_Format = 0)
	Local $XML_Type, $TMP_LastRootChild, $Return = 1
	Local $A_RechAPI = StringSplit(IniRead($PathConfigINI, "GENERAL", "$RechAPI ", '1|2|3'), "|")
	Local $timedout = 0
;~ 	_ArrayDisplay($A_RechAPI, "$A_RechAPI") ; Debug

	$RomName = StringReplace($A_ROMList[$No_ROM][0], "&", "%26")
	$RomName = StringReplace($RomName, " ", "%20")

;~ 	Download du XML source
	For $B_RechAPI = 1 To UBound($A_RechAPI) - 1
		Switch $A_RechAPI[$B_RechAPI]
			Case 1
				If (StringInStr(FileReadLine($Path_source), "Erreur") Or Not FileExists($Path_source)) And $No_system <> "" Then
					FileDelete($Path_source)
					_CREATION_LOGMESS(1, "Recuperation des informations de la Rom no " & $No_ROM & " (CRC + SYSTEM)")
					ConsoleWrite(">(CRC + SYSTEM) = http://www.screenscraper.fr/api/jeuInfos.php?devid=" & $DevId & "&devpassword=" & $DevPassword & "&softname=" & $Softname & "&output=xml&crc=" & $A_ROMList[$No_ROM][2] & "&md5=" & $A_ROMList[$No_ROM][3] & "&sha1=" & $A_ROMList[$No_ROM][4] & "&systemeid=" & $No_system & "&romtype=rom&romnom=" & $RomName & "&romtaille=" & $A_ROMList[$No_ROM][5] & @CRLF) ;Debug
					$hDownload = InetGet("http://www.screenscraper.fr/api/jeuInfos.php?devid=" & $DevId & "&devpassword=" & $DevPassword & "&softname=" & $Softname & "&output=xml&crc=" & $A_ROMList[$No_ROM][2] & "&md5=" & $A_ROMList[$No_ROM][3] & "&sha1=" & $A_ROMList[$No_ROM][4] & "&systemeid=" & $No_system & "&romtype=rom&romnom=" & $RomName & "&romtaille=" & $A_ROMList[$No_ROM][5], $Path_source, 1, 1)
					$timedout = _TimeOut($hDownload)
				EndIf
			Case 2
				If StringInStr(FileReadLine($Path_source), "Erreur") Or Not FileExists($Path_source) Then
					FileDelete($Path_source)
					_CREATION_LOGMESS(1, "--Recuperation des informations de la Rom no " & $No_ROM & " (CRC)")
					ConsoleWrite(">(CRC) = http://www.screenscraper.fr/api/jeuInfos.php?devid=" & $DevId & "&devpassword=" & $DevPassword & "&softname=" & $Softname & "&output=xml&crc=" & $A_ROMList[$No_ROM][2] & "&md5=" & $A_ROMList[$No_ROM][3] & "&sha1=" & $A_ROMList[$No_ROM][4] & "&systemeid=" & "&romtype=rom&romnom=" & $RomName & "&romtaille=" & $A_ROMList[$No_ROM][5] & @CRLF) ;Debug
					$hDownload = InetGet("http://www.screenscraper.fr/api/jeuInfos.php?devid=" & $DevId & "&devpassword=" & $DevPassword & "&softname=" & $Softname & "&output=xml&crc=" & $A_ROMList[$No_ROM][2] & "&md5=" & $A_ROMList[$No_ROM][3] & "&sha1=" & $A_ROMList[$No_ROM][4] & "&systemeid=" & "&romtype=rom&romnom=" & $RomName & "&romtaille=" & $A_ROMList[$No_ROM][5], $Path_source, 1, 1)
					$timedout = _TimeOut($hDownload)
				EndIf
			Case 3
				If (StringInStr(FileReadLine($Path_source), "Erreur") Or Not FileExists($Path_source)) And $No_system <> "" Then
					FileDelete($Path_source)
					_CREATION_LOGMESS(1, "Recuperation des informations de la Rom no " & $No_ROM & " (FileName + SYSTEM)")
					$FileName = StringLeft($RomName, StringInStr($RomName, ".", Default, -1) - 1)
					ConsoleWrite(">(FileName + SYSTEM) = http://www.screenscraper.fr/api/jeuInfos.php?devid=" & $DevId & "&devpassword=" & $DevPassword & "&softname=" & $Softname & "&output=xml&crc=" & "&md5=" & "&sha1=" & "&systemeid=" & $No_system & "&romtype=rom&romnom=" & $FileName & "&romtaille=" & $A_ROMList[$No_ROM][5] & @CRLF) ;Debug
					$hDownload = InetGet("http://www.screenscraper.fr/api/jeuInfos.php?devid=" & $DevId & "&devpassword=" & $DevPassword & "&softname=" & $Softname & "&output=xml&crc=" & "&md5=" & "&sha1=" & "&systemeid=" & $No_system & "&romtype=rom&romnom=" & $FileName & "&romtaille=" & $A_ROMList[$No_ROM][5], $Path_source, 1, 1)
					$timedout = _TimeOut($hDownload)
				EndIf
		EndSwitch
	Next

	If Not FileExists($Path_source) Then
		If $timedout = 0 Then
			_GUICtrlStatusBar_SetText($L_SCRAPE, "", 1)
			Return 0
		Else
			_GUICtrlStatusBar_SetText($L_SCRAPE, "TIME OUT", 1)
			_CREATION_LOGMESS(1, "TIME OUT")
			MsgBox($MB_ICONERROR, _MultiLang_GetText("err_title"), _MultiLang_GetText("err_TimeOut"), 10)
			Return -1
		EndIf
	EndIf

;~	Creation du fichier XML Temporaire de la Rom
	$Path_cible = $PathDIRTmp & $No_ROM & ".xml"
	_XMLCreateFile($Path_cible, StringMid($xpath_root_cible, 3), True, 1)
	If @error Then ConsoleWrite("!_XML_CreateFile : " & _XMLError("") & @CRLF) ; Debug

;~ 	Traitement du XML
	ConsoleWrite("+Debut de la ROM no : " & $No_ROM & @CRLF) ; Debug
	For $B_XMLElements = 1 To UBound($A_XMLFormat) - 1
		If GUIGetMsg() = $B_SCRAPE Then
			_GUICtrlStatusBar_SetText($L_SCRAPE, "", 1)
			$ScrapeCancelled = 1
			Return -1 ; Retour en cas d'annulation
		EndIf

		$XML_Type = StringLeft($A_XMLFormat[$B_XMLElements][3], 5)
		If $XML_Type <> "" Then
			$XML_Value = _XML_GETROMINFO($Path_source, $xpath_root_source, $XML_Type, $B_XMLElements, $A_XMLFormat, $A_ROMList, $No_ROM, $INI_OPTION_MAJ, $No_system) ;Lecture des differents elements
		Else
			$XML_Value = -1
		EndIf
		ConsoleWrite("!" & $A_XMLFormat[$B_XMLElements][0] & "->" & $A_XMLFormat[$B_XMLElements][2] & " = " & $XML_Value & @CRLF) ;Debug

		If $XML_Value = -2 Then
			If $EmptyRom = 0 Then Return 0
			$Return = 0
		EndIf

		$XML_Type = StringLeft($A_XMLFormat[$B_XMLElements][1], 5)
		If $XML_Value <> -1 And $XML_Value <> -2 Then _XML_PUTROMINFO($Path_cible, $Path_source, $xpath_root_cible, $xpath_root_source, $XML_Type, $B_XMLElements, $A_XMLFormat, 1, $XML_Value, $No_ROM, $A_MIX_IMAGE_Format) ; Ecriture des differents elements
	Next
;~ 	MsgBox(0, 'PAUSE', 'PAUSE') ; Debug
	FileDelete($Path_source)
	ConsoleWrite("+Fin de la Rom no : " & $No_ROM & @CRLF) ; Debug
	Return $Return
EndFunc   ;==>_XML_CREATEROM

Func _XML_CREATEHEADER($Path_source, $Path_cible, $xpath_root_source, $xpath_root_cible, $A_HEADERFormat, $A_ROMList, $No_system, $INI_OPTION_MAJ)
	Local $XML_Type, $TMP_LastRootChild, $Return = 1
;~ 	_ArrayDisplay($A_HEADERFormat, "$A_HEADERFormat") ; Debug
	$TimerHeader = TimerInit()
	_CREATION_LOGMESS(1, "Recuperation des informations du header")
	For $B_XMLHeader = 1 To UBound($A_HEADERFormat) - 1
		If GUIGetMsg() = $B_SCRAPE Then
			_GUICtrlStatusBar_SetText($L_SCRAPE, "", 1)
			$ScrapeCancelled = 1
			Return -1
		EndIf
		GUICtrlSetImage($B_SCRAPE, $SOURCE_DIRECTORY & "\Ressources\Fleche_IP1.bmp", -1, 0)
		$XML_Type = StringLeft($A_HEADERFormat[$B_XMLHeader][3], 5)
		ConsoleWrite("!$XML_Type" & $XML_Type & @CRLF) ;Debug
		$XML_Value = _XML_GETROMINFO($Path_source, $xpath_root_source, $XML_Type, $B_XMLHeader, $A_HEADERFormat, $A_ROMList, 0, $INI_OPTION_MAJ, $No_system)
		ConsoleWrite("!" & $A_HEADERFormat[$B_XMLHeader][2] & " = " & $XML_Value & @CRLF) ;Debug
		$XML_Type = StringLeft($A_HEADERFormat[$B_XMLHeader][1], 5)
		ConsoleWrite("!" & $A_HEADERFormat[$B_XMLHeader][0] & " = " & $XML_Value & @CRLF) ;Debug
		GUICtrlSetImage($B_SCRAPE, $SOURCE_DIRECTORY & "\Ressources\Fleche_IP2.bmp", -1, 0)
		If $XML_Value <> -1 And $XML_Value <> -2 Then
			If StringLeft($XML_Value, 8) = 'systeme:' Then
				For $B_SYSTEM = 0 To UBound($A_System) - 1
					If $A_System[$B_SYSTEM][2] = StringMid($XML_Value, 9) Then $XML_Value = $A_System[$B_SYSTEM][0]
				Next
			EndIf
			_XML_PUTROMINFO($Path_cible, 0, $xpath_root_cible, 0, $XML_Type, $B_XMLHeader, $A_HEADERFormat, 1, $XML_Value)
		EndIf
		If $XML_Value = -2 Then $Return = 0
	Next
	_CREATION_LOGMESS(1, "Fin de l'ecriture des informations du header en " & Round((TimerDiff($TimerHeader) / 1000), 3) & "s")
	Return $Return
EndFunc   ;==>_XML_CREATEHEADER

Func _XML_GETROMINFO($PathTmp_GAME, $xpath_root, $XML_Type, $B_XMLElements, $A_XMLFormat, $A_ROMList, $No_ROM, $INI_OPTION_MAJ, $No_system, $No_Elements = 1)
	GUICtrlSetImage($B_SCRAPE, $SOURCE_DIRECTORY & "\Ressources\Fleche_IP1.bmp", -1, 0)
	_CREATION_LOGMESS(2, "Recuperation de " & $XML_Type)

	Switch $XML_Type
		Case 'child'
			$XML_Value = $A_XMLFormat[$B_XMLElements][0]
			_CREATION_LOGMESS(2, $XML_Value)
			_XMLFileOpen($PathTmp_GAME)
			If @error And $EmptyRom = 0 Then Return -2
			Return $XML_Value
		Case 'value'
			_XMLFileOpen($PathTmp_GAME)
			If @error Then Return -2
			Local $sNode_Values = _XMLGetValue($xpath_root & "/*[1]/" & $A_XMLFormat[$B_XMLElements][2])
			If IsArray($sNode_Values) Then
				$XML_Value = $sNode_Values[1]
				Switch $XML_Value
					Case Null
						_CREATION_LOGMESS(2, $A_XMLFormat[$B_XMLElements][2] & " : <NULL>")
						$XML_Value = ""
					Case Else
						If $INI_OPTION_MAJ = 1 Then $XML_Value = StringUpper($XML_Value)
						_CREATION_LOGMESS(2, $A_XMLFormat[$B_XMLElements][2] & " : " & $XML_Value)
				EndSwitch
				Return $XML_Value
			EndIf
		Case 'attr:'
			_XMLFileOpen($PathTmp_GAME)
			If @error Then Return -2
			$XML_Value = _XMLGetAttrib($xpath_root & '/' & StringMid($A_XMLFormat[$B_XMLElements][3], 6) & "[1]", $A_XMLFormat[$B_XMLElements][2])
			_CREATION_LOGMESS(2, StringMid($A_XMLFormat[$B_XMLElements][3], 6) & " : " & $XML_Value)
			Return $XML_Value
		Case 'form:'
			Local $XML_Value1 = "", $XML_Value2 = ""
			_XMLFileOpen($PathTmp_GAME)
			If @error Then Return -2
			Local $sNode_Values = _XMLGetValue($xpath_root & "/*[1]/" & $A_XMLFormat[$B_XMLElements][2])
			If IsArray($sNode_Values) Then
				$XML_Value1 = $sNode_Values[1]
				Switch $XML_Value1
					Case Null
						_CREATION_LOGMESS(2, $A_XMLFormat[$B_XMLElements][2] & " : <NULL>")
						$XML_Value1 = ""
					Case Else
						If $INI_OPTION_MAJ = 1 Then $XML_Value1 = StringUpper($XML_Value1)
						_CREATION_LOGMESS(2, $A_XMLFormat[$B_XMLElements][2] & " : " & $XML_Value1)
						ConsoleWrite("+ Form1 :" & $XML_Value1 & @CRLF)
				EndSwitch
			EndIf
			If $XML_Value1 = "" Then Return -1

			Switch StringMid($A_XMLFormat[$B_XMLElements][3], 6)
				Case '%FileNameBracket%'
					Local $BracketPos = 0, $PSDrive, $PSDir, $PSFilename, $PSExt
					$PathSplit = _PathSplit($A_ROMList[$No_ROM][0], $PSDrive, $PSDir, $PSFilename, $PSExt)
					$XML_Value = $PSFilename
					If StringInStr($XML_Value, "(") > 0 Then $BracketPos = StringInStr($XML_Value, "(")
					If StringInStr($XML_Value, "[") > 0 And StringInStr($XML_Value, "[") < $BracketPos Then $BracketPos = StringInStr($XML_Value, "[")
					If $BracketPos > 0 Then $XML_Value2 = " " & StringMid($XML_Value, $BracketPos)
					ConsoleWrite("+ Form2 :" & $XML_Value2 & @CRLF)
					_CREATION_LOGMESS(2, StringMid($A_XMLFormat[$B_XMLElements][3], 6) & " : " & $XML_Value2)
				Case Else
					$sNode_Values = _XMLGetValue($xpath_root & "/*[1]/" & StringMid($A_XMLFormat[$B_XMLElements][3], 6))
					If IsArray($sNode_Values) Then
						$XML_Value2 = $sNode_Values[1]
						Switch $XML_Value2
							Case Null
								_CREATION_LOGMESS(2, StringMid($A_XMLFormat[$B_XMLElements][3], 6) & " : <NULL>")
								$XML_Value2 = ""
							Case Else
								If $INI_OPTION_MAJ = 1 Then $XML_Value2 = StringUpper($XML_Value2)
								$XML_Value2 = " (" & $XML_Value2 & ")"
								ConsoleWrite("+ Form2 :" & $XML_Value2 & @CRLF)
								_CREATION_LOGMESS(2, StringMid($A_XMLFormat[$B_XMLElements][3], 6) & " : " & $XML_Value2)
						EndSwitch
					EndIf
			EndSwitch
			$XML_Value = $XML_Value1 & $XML_Value2
			Return $XML_Value
		Case 'varia'
			Switch $A_XMLFormat[$B_XMLElements][2]
				Case '%RomName%'
					$XML_Value = $A_ROMList[$No_ROM][0]
					_CREATION_LOGMESS(2, "RomName : " & $XML_Value)
					Return $XML_Value
				Case '%RomNameShort%'
					Local $PSDrive, $PSDir, $PSFilename, $PSExt
					$PathSplit = _PathSplit($A_ROMList[$No_ROM][0], $PSDrive, $PSDir, $PSFilename, $PSExt)
					$XML_Value = $PSFilename
					_CREATION_LOGMESS(2, "RomNameShort : " & $XML_Value)
					Return $XML_Value
				Case '%RomPath%'
					$XML_Value = $PathRomSub & $A_ROMList[$No_ROM][0]
					_CREATION_LOGMESS(2, "RomPath : " & $XML_Value)
					Return $XML_Value
				Case '%crc32%'
					$XML_Value = $A_ROMList[$No_ROM][2]
					_CREATION_LOGMESS(2, "crc32 : " & $XML_Value)
					Return $XML_Value
				Case '%md5%'
					$XML_Value = $A_ROMList[$No_ROM][3]
					_CREATION_LOGMESS(2, "md5 : " & $XML_Value)
					Return $XML_Value
				Case '%sha1%'
					$XML_Value = $A_ROMList[$No_ROM][4]
					_CREATION_LOGMESS(2, "sha1 : " & $XML_Value)
					Return $XML_Value
				Case '%systeme%'
					$XML_Value = 'systeme:' & $No_system
					_CREATION_LOGMESS(2, $XML_Value)
					Return $XML_Value
				Case '%date%'
					$tCur = _Date_Time_GetLocalTime()
					$dtCur = _Date_Time_SystemTimeToArray($tCur)
					$XML_Value = StringRight("0" & $dtCur[1], 2) & "/" & StringRight("0" & $dtCur[0], 2) & "/" & StringRight("0" & $dtCur[2], 2)
					_CREATION_LOGMESS(2, "date : " & $XML_Value)
					Return $XML_Value
				Case Else
					$XML_Value = $A_XMLFormat[$B_XMLElements][2]
					_CREATION_LOGMESS(2, "Else : " & $XML_Value)
					Return $XML_Value
			EndSwitch
		Case 'path:'
			Switch StringMid($A_XMLFormat[$B_XMLElements][3], 6, 5)
				Case 'image'
					Local $sNode_Values = ''
					_XMLFileOpen($PathTmp_GAME)
					If @error Then Return -2
;~ 					MsgBox(0, "$A_XMLFormat[$B_XMLElements][2]", $A_XMLFormat[$B_XMLElements][2])
					If StringRight($A_XMLFormat[$B_XMLElements][2], 2) = '%%' Then
						$Node_Region = _XMLGetValue($xpath_root & "/*[1]/region")
						If IsArray($Node_Region) Then
							$XML_Region = $Node_Region[1]
							$I_RegionName = _ArraySearch($A_RegionList, $XML_Region)
							If $I_RegionName > 0 Then
								$Region = $A_RegionList[$I_RegionName][1]
;~ 								MsgBox(0, "$Region", $Region)
								$sNode_Values = _XMLGetValue($xpath_root & "/*[1]/" & StringTrimRight($A_XMLFormat[$B_XMLElements][2], 2) & $Region)
							EndIf
						EndIf
					Else
						$sNode_Values = _XMLGetValue($xpath_root & "/*[" & $No_Elements & "]/" & $A_XMLFormat[$B_XMLElements][2])
					EndIf
					If IsArray($sNode_Values) Then
						$XML_Value = $sNode_Values[1]
						_CREATION_LOGMESS(2, "Chemin de l'image")
						Return $XML_Value
					EndIf
			EndSwitch
		Case Else
			Return -1
	EndSwitch
EndFunc   ;==>_XML_GETROMINFO

Func _XML_PUTROMINFO($PathTmp_GAME, $Path_source, $xpath_root_cible, $xpath_root_source, $XML_Type, $B_XMLElements, $A_XMLFormat, $No_ROM, $XML_Value, $No_ROMXML = 1, $A_MIX_IMAGE_Format = 0)
	Local $TMP_LastChildName = ""
	Local $maxheight = ""
	Local $maxwidth = ""
	GUICtrlSetImage($B_SCRAPE, $SOURCE_DIRECTORY & "\Ressources\Fleche_IP2.bmp", -1, 0)
	_CREATION_LOGMESS(2, "Ecriture de " & $XML_Type)

	_XMLFileOpen($PathTmp_GAME)
	If @error Then
		ConsoleWrite("!_XMLFileOpen : " & _XMLError("") & @CRLF) ; Debug
		Return -1
	EndIf

	Switch $XML_Type
		Case 'child'
			_XMLCreateRootChild($XML_Value)
			_CREATION_LOGMESS(2, $XML_Value)
			$TMP_LastChild = $XML_Value
			ConsoleWrite(">_XMLCreateRootChild : " & $TMP_LastChild & @CRLF) ; Debug
		Case 'attr:'
			_XMLCreateAttrib($xpath_root_cible & '/' & StringMid($A_XMLFormat[$B_XMLElements][1], 6) & "[" & $No_ROM & "]", $A_XMLFormat[$B_XMLElements][0], $XML_Value)
			_CREATION_LOGMESS(2, StringMid($A_XMLFormat[$B_XMLElements][1], 6) & " : " & $XML_Value)
			ConsoleWrite(">_XMLCreateAttrib : " & $XML_Value & @CRLF) ; Debug
		Case 'value'
			If $XML_Value = "0" Then Return
			Local $sNode_Values = _XMLGetValue($xpath_root_cible & '/' & $TMP_LastChild & "[" & $No_ROM & "]/" & $A_XMLFormat[$B_XMLElements][0])
			If IsArray($sNode_Values) = 0 Or $sNode_Values = 0 Then
				Switch StringMid($A_XMLFormat[$B_XMLElements][1], 6)
					Case '100'
						$XML_Value = StringReplace(Round(($XML_Value * 100 / 20) / 100, 2), ",", ".")
					Case 'DES'
						$XML_Value = StringLeft(StringReplace($XML_Value, "-", "") & '00000000', 8) & "T000000"
				EndSwitch
;~ 				If StringMid($A_XMLFormat[$B_XMLElements][1], 6) = 100 Then $XML_Value = StringReplace(Round(($XML_Value * 100 / 20) / 100, 2), ",", ".")
;~ 				If StringMid($A_XMLFormat[$B_XMLElements][1], 6) = 'DES' Then $XML_Value = StringReplace($XML_Value, "-", "") & "T000000"
				_XMLCreateChildNode($xpath_root_cible & '/' & $TMP_LastChild & "[" & $No_ROM & "]", $A_XMLFormat[$B_XMLElements][0], $XML_Value)
				ConsoleWrite(">_XMLCreateChildNode : " & $xpath_root_cible & '/' & $TMP_LastChild & "[" & $No_ROM & "]/" & $A_XMLFormat[$B_XMLElements][0] & " = " & $XML_Value & @CRLF) ; Debug
				_CREATION_LOGMESS(2, $A_XMLFormat[$B_XMLElements][2] & " : " & $XML_Value)
			Else
				ConsoleWrite("+IGNORE : " & $A_XMLFormat[$B_XMLElements][2] & " : " & @CRLF) ; Debug
				_CREATION_LOGMESS(2, "IGNORE : " & $A_XMLFormat[$B_XMLElements][2])
			EndIf
		Case 'path:'
			If $XML_Value = "0" Then Return
			Local $sNode_Values = _XMLGetValue($xpath_root_cible & '/' & $TMP_LastChild & "[" & $No_ROM & "]/" & $A_XMLFormat[$B_XMLElements][0])
			If IsArray($sNode_Values) = 0 Then
				Local $ExtImage = IniRead($PathConfigINI, $A_Profil[$No_Profil], "$ExtImage", "png")
				Local $PathImage_Temp = $PathImage & StringTrimRight($A_ROMList[$No_ROMXML][0], 4) & "-" & $A_XMLFormat[$B_XMLElements][0] & "." & $ExtImage
				Local $PathImageSub_Temp = $PathImageSub & StringTrimRight($A_ROMList[$No_ROMXML][0], 4) & "-" & $A_XMLFormat[$B_XMLElements][0] & "." & $ExtImage

				If StringLeft($XML_Value, 11) = "%mix_image%" Then
					If FileExists($PathImage_Temp) = 0 Then _MIX_IMAGE_CREATEARRAY($Path_source, $xpath_root_source, $XML_Type, $No_ROM, $PathImage_Temp, $No_ROMXML, $A_MIX_IMAGE_Format)
					_XMLFileOpen($PathTmp_GAME)
					If @error Then
						ConsoleWrite("!_XMLFileOpen : " & _XMLError("") & @CRLF) ; Debug
						Return -1
					EndIf
				Else
					If FileExists($PathImage_Temp) = 0 Then
						Local $outputformat = "&outputformat=" & $ExtImage
						If $HauteurImage > 0 Then $maxheight = "&maxheight=" & $HauteurImage
						If $LargeurImage > 0 Then $maxwidth = "&maxwidth=" & $LargeurImage
						ConsoleWrite("+ Download : " & $XML_Value & $maxheight & $maxwidth & " dans " & $PathImage_Temp & @CRLF) ; Debug
						_CREATION_LOGMESS(2, "Download Images : " & $PathImage_Temp)
						$hDownload = InetGet($XML_Value & $maxheight & $maxwidth & $outputformat, $PathImage_Temp, 0, 1)
						_TimeOut($hDownload)

						_CREATION_LOGMESS(2, $A_XMLFormat[$B_XMLElements][0] & " : " & $PathImageSub_Temp)
					EndIf
				EndIf
				If FileExists($PathImage_Temp) Then
					_XMLCreateChildNode($xpath_root_cible & '/' & $TMP_LastChild & "[" & $No_ROM & "]", $A_XMLFormat[$B_XMLElements][0], $PathImageSub_Temp)
					ConsoleWrite(">_XMLCreateChildNode : " & $A_XMLFormat[$B_XMLElements][0] & " = " & $PathImageSub_Temp & @CRLF) ; Debug
				EndIf
			Else
				ConsoleWrite("+IGNORE : " & $XML_Value & @CRLF) ; Debug
				_CREATION_LOGMESS(2, "IGNORE : " & $A_XMLFormat[$B_XMLElements][0])
			EndIf
	EndSwitch
EndFunc   ;==>_XML_PUTROMINFO

Func _MIX_IMAGE_CREATEARRAY($Path_source, $xpath_root_source, $XML_Type, $No_ROM, $PathImageFinal_Temp, $No_ROMXML = 1, $A_MIX_IMAGE_Format = 0)
	Local $A_PathImage[1][3]
	Local $PathImage_Temp, $outputformat, $maxwidth = '', $maxheight = ''
	_CREATION_LOGMESS(1, "Recuperation des Images pour le Mix")
	$A_PathImage[0][0] = IniRead($PathConfigINI, "LAST_USE", "$LargeurImage", 0) ; Width Image Finale
	If $A_PathImage[0][0] < 1 Then $A_PathImage[0][0] = IniRead($PathMixTmp & "\config.ini", "MIX_IMG", "$MIX_IMG_CIBLE_X", 0)
	$A_PathImage[0][1] = IniRead($PathConfigINI, "LAST_USE", "$HauteurImage", 0) ; Height Image Finale
	If $A_PathImage[0][1] < 1 Then $A_PathImage[0][1] = IniRead($PathMixTmp & "\config.ini", "MIX_IMG", "$MIX_IMG_CIBLE_Y", 0)

;~ 	_ArrayDisplay($A_MIX_IMAGE_Format, '$A_MIX_IMAGE_Format') ; Debug
	For $B_Images = 1 To UBound($A_MIX_IMAGE_Format) - 1
		$PathImage_Temp = $PathDIRTmp & StringTrimRight($A_ROMList[$No_ROMXML][0], 4) & "-" & $A_MIX_IMAGE_Format[$B_Images][0] & ".PNG"

		Switch StringLeft($A_MIX_IMAGE_Format[$B_Images][1], 4)
			Case 'Tran'
				$TransLvl = StringMid($A_MIX_IMAGE_Format[$B_Images][1], 7)
				_CREATION_LOGMESS(2, "Ajout de transparence : " & $TransLvl)
				ConsoleWrite("> Ajout de transparence [" & $TransLvl & "]" & @CRLF)
				If UBound($A_PathImage) - 1 > 0 Then
					$PathImage_Temp = $A_PathImage[UBound($A_PathImage) - 1][0]
					ConsoleWrite("> --- Sur " & $PathImage_Temp & @CRLF)
					If FileExists($PathImage_Temp) Then $PathImage_Temp = _MIX_IMAGE_ADDTRANS($PathImage_Temp, $TransLvl)
				EndIf
;~ 				_ArrayDisplay($A_PathImage, '$A_PathImage (Trans)') ; Debug
			Case 'Fus'
				_CREATION_LOGMESS(2, "Fusion")
				ConsoleWrite("> Fusion" & @CRLF)
				If UBound($A_PathImage) - 2 > 0 Then
					ConsoleWrite("> --- De " & $A_PathImage[UBound($A_PathImage) - 1][0] & @CRLF)
					ConsoleWrite("> --- Sur " & $A_PathImage[UBound($A_PathImage) - 2][0] & @CRLF)
					$A_PathImage = _MIX_IMAGE_FUS($A_PathImage)
				EndIf
;~ 				_ArrayDisplay($A_PathImage, '$A_PathImage (Fus)') ; Debug
			Case 'Cut'
				_CREATION_LOGMESS(2, "Decoupage de l'image")
				ConsoleWrite("> Decoupage de l'image" & @CRLF)
				If UBound($A_PathImage) - 1 > 0 Then $PathImage_Temp = _MIX_IMAGE_CUT($A_PathImage, $A_MIX_IMAGE_Format, $B_Images)
;~ 				_ArrayDisplay($A_PathImage, '$A_PathImage (Cut)') ; Debug
			Case 'fixe'
				_CREATION_LOGMESS(2, "Images Fixe : " & $PathImage_Temp)
				ConsoleWrite("> Images Fixe : " & $PathImage_Temp & @CRLF)
				FileCopy($PathMixTmp & "\" & $A_MIX_IMAGE_Format[$B_Images][2], $PathImage_Temp, 9)
				If FileExists($PathImage_Temp) Then
					If $A_MIX_IMAGE_Format[$B_Images][8] = 'ROTATION' Then $A_MIX_IMAGE_Format = _ROTATION($PathImage_Temp, $A_MIX_IMAGE_Format, $B_Images)
					$PathImage_Temp = _IMAGING($PathImage_Temp, $A_PathImage, $A_MIX_IMAGE_Format, $B_Images, $A_MIX_IMAGE_Format[$B_Images][1])
					_ArrayAdd($A_PathImage, $PathImage_Temp & "|FIXE")
				EndIf
;~ 				_ArrayDisplay($A_PathImage, '$A_PathImage (fixe)') ; Debug
			Case 'Game'
				_CREATION_LOGMESS(2, "Download Game de : " & $PathImage_Temp)
				ConsoleWrite("> Download Game de : " & $PathImage_Temp & @CRLF) ; Debug
				If FileExists($PathImage_Temp) = 0 Then
					$XML_Type = StringLeft($A_MIX_IMAGE_Format[$B_Images][3], 5)
					If $XML_Type = "path:" Then
						$XML_Value = _XML_GETROMINFO($PathTmp_GAME, $xpath_root_source, $XML_Type, $B_Images, $A_MIX_IMAGE_Format, $A_ROMList, $No_ROM, $INI_OPTION_MAJ, $No_system) ;Lecture des differents elements
					Else
						$XML_Value = -1
					EndIf
					$DL_Image_Width = _RELATIVPOS($A_MIX_IMAGE_Format[$B_Images][4], $A_PathImage[0][0])
					$DL_Image_Height = _RELATIVPOS($A_MIX_IMAGE_Format[$B_Images][5], $A_PathImage[0][1])
					$outputformat = "&outputformat=png"
					If $DL_Image_Width > 0 Then $maxwidth = "&maxwidth=" & Round($DL_Image_Width, 0)
					If $DL_Image_Height > 0 Then $maxheight = "&maxheight=" & Round($DL_Image_Height, 0)
					$hDownload = InetGet($XML_Value & $maxheight & $maxwidth & $outputformat, $PathImage_Temp, 0, 1)
					_TimeOut($hDownload)
					If FileExists($PathImage_Temp) Then
						If $A_MIX_IMAGE_Format[$B_Images][8] = 'ROTATION' Then $A_MIX_IMAGE_Format = _ROTATION($PathImage_Temp, $A_MIX_IMAGE_Format, $B_Images)
						$PathImage_Temp = _IMAGING($PathImage_Temp, $A_PathImage, $A_MIX_IMAGE_Format, $B_Images, $A_MIX_IMAGE_Format[$B_Images][1])
						_ArrayAdd($A_PathImage, $PathImage_Temp & "|Game")
					EndIf
				Else
					ConsoleWrite("! ANNULE" & @CRLF) ; Debug
				EndIf
;~ 				_ArrayDisplay($A_PathImage, '$A_PathImage (Game)') ; Debug
			Case 'Syst'
				$Index = _ArraySearch($A_XMLSourcesFIXE, $No_system, 0, 0, 0, 0, 1, 2)
				$Id_system = $A_XMLSourcesFIXE[$Index][3]
;~ 				_ArrayDisplay($A_XMLSourcesFIXE, "$A_XMLSources : " & $No_system & " -> " & $Index & " = " & $Id_system)
				_CREATION_LOGMESS(2, "Download Systeme de : " & $PathImage_Temp)
				ConsoleWrite("> Download Systeme de : " & $PathImage_Temp & " (" & $Id_system & ")" & @CRLF) ; Debug
				If FileExists($PathImage_Temp) = 0 Then

					$XML_Type = StringLeft($A_MIX_IMAGE_Format[$B_Images][3], 5)
					If $XML_Type = "path:" Then
						$XML_Value = _XML_GETROMINFO($PathTmp_SYS, $xpath_root_source, $XML_Type, $B_Images, $A_MIX_IMAGE_Format, $A_ROMList, $Id_system, $INI_OPTION_MAJ, $Id_system, $Id_system) ;Lecture des differents elements
					Else
						$XML_Value = -1
					EndIf
					$DL_Image_Width = _RELATIVPOS($A_MIX_IMAGE_Format[$B_Images][4], $A_PathImage[0][0])
					$DL_Image_Height = _RELATIVPOS($A_MIX_IMAGE_Format[$B_Images][5], $A_PathImage[0][1])
					$outputformat = "&outputformat=png"
					If $DL_Image_Width > 0 Then $maxwidth = "&maxwidth=" & Round($DL_Image_Width, 0)
					If $DL_Image_Height > 0 Then $maxheight = "&maxheight=" & Round($DL_Image_Height, 0)
					ConsoleWrite("! Link :" & $XML_Value & $maxheight & $maxwidth & $outputformat & @CRLF) ; Debug
					$hDownload = InetGet($XML_Value & $maxheight & $maxwidth & $outputformat, $PathImage_Temp, 0, 1)
					_TimeOut($hDownload)
					If FileExists($PathImage_Temp) Then
						If $A_MIX_IMAGE_Format[$B_Images][8] = 'ROTATION' Then $A_MIX_IMAGE_Format = _ROTATION($PathImage_Temp, $A_MIX_IMAGE_Format, $B_Images)
						$PathImage_Temp = _IMAGING($PathImage_Temp, $A_PathImage, $A_MIX_IMAGE_Format, $B_Images, $A_MIX_IMAGE_Format[$B_Images][1])
						_ArrayAdd($A_PathImage, $PathImage_Temp & "|Sys")
					EndIf
				Else
					ConsoleWrite("! ANNULE" & @CRLF) ; Debug
				EndIf
;~ 				_ArrayDisplay($A_PathImage, '$A_PathImage (Game)') ; Debug
		EndSwitch
	Next
;~ 	_ArrayDisplay($A_PathImage, '$A_PathImage') ; Debug
	_MIX_IMAGE_CREATECIBLE($A_PathImage, $PathImageFinal_Temp)
EndFunc   ;==>_MIX_IMAGE_CREATEARRAY

Func _MIX_IMAGE_FUS($A_PathImage)

	Local $hGui, $hGraphicGUI, $hBMPBuff, $hGraphic
	Local $MergedImageBackgroundColor = 0x00000000
	Local $Image1 = $A_PathImage[UBound($A_PathImage) - 2][0]
	Local $Image2 = $A_PathImage[UBound($A_PathImage) - 1][0]
	Local $PathImage_FUS_Temp = StringTrimRight($Image1, 4) & "-FUS_Temp.PNG"
	Local $PathImage_Temp = $Image1

	FileDelete($PathImage_FUS_Temp)
	FileCopy($PathImage_Temp, $PathImage_FUS_Temp, 9)
	FileDelete($PathImage_Temp)

	$Image1 = $PathImage_FUS_Temp

	_GDIPlus_Startup()
	$hImage1 = _GDIPlus_ImageLoadFromFile($Image1)
	$hImage2 = _GDIPlus_ImageLoadFromFile($Image2)
	$hGui = GUICreate("", $A_PathImage[0][0], $A_PathImage[0][1])
	$hGraphicGUI = _GDIPlus_GraphicsCreateFromHWND($hGui) ;Draw to this graphics, $hGraphicGUI, to display on GUI
	$hBMPBuff = _GDIPlus_BitmapCreateFromGraphics($A_PathImage[0][0], $A_PathImage[0][1], $hGraphicGUI) ; $hBMPBuff is a bitmap in memory
	$hGraphic = _GDIPlus_ImageGetGraphicsContext($hBMPBuff) ; Draw to this graphics, $hGraphic, being the graphics of $hBMPBuff
	_GDIPlus_GraphicsClear($hGraphic, $MergedImageBackgroundColor) ;Fill the Graphic Background (0x00000000 for transparent background in .png files)
	_GDIPlus_GraphicsDrawImage($hGraphic, $hImage1, 0, 0)
	_GDIPlus_GraphicsDrawImage($hGraphic, $hImage2, 0, 0)

	_GDIPlus_ImageSaveToFile($hBMPBuff, $PathImage_Temp)

	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_BitmapDispose($hBMPBuff)
	_GDIPlus_GraphicsDispose($hGraphicGUI)
	GUIDelete($hGui)
	_GDIPlus_ImageDispose($hImage2)
	_GDIPlus_ImageDispose($hImage1)
	_GDIPlus_Shutdown()
	FileDelete($PathImage_FUS_Temp)
	_ArrayDelete($A_PathImage, UBound($A_PathImage) - 1)

	Return $A_PathImage
EndFunc   ;==>_MIX_IMAGE_FUS

Func _MIX_IMAGE_CUT($A_PathImage, $A_MIX_IMAGE_Format, $B_Images)
	Local $hImage, $hLeftImage, $hRightImage, $hUpImage, $hDownImage, $hGui, $hGraphicGUI, $hBMPBuff, $hGraphic
	Local $MergedImageBackgroundColor = 0x00000000
	Local $PathImage_Temp = $A_PathImage[UBound($A_PathImage) - 1][0]
	Local $PathImage_CUT_Temp = StringTrimRight($PathImage_Temp, 4) & "-CUT_Temp.PNG"

	ConsoleWrite("> --- Image : " & $PathImage_Temp & @CRLF)

	FileDelete($PathImage_CUT_Temp)
	FileCopy($PathImage_Temp, $PathImage_CUT_Temp, 9)
	FileDelete($PathImage_Temp)

	Local $Image_Width = _RELATIVPOS($A_MIX_IMAGE_Format[$B_Images][4], $A_PathImage[0][0])
	Local $Image_Height = _RELATIVPOS($A_MIX_IMAGE_Format[$B_Images][5], $A_PathImage[0][1])
	Local $Image_C1X = _RELATIVPOS($A_MIX_IMAGE_Format[$B_Images][6], $A_PathImage[0][0])
	Local $Image_C1Y = _RELATIVPOS($A_MIX_IMAGE_Format[$B_Images][7], $A_PathImage[0][1])

	Switch $Image_C1X
		Case 'CENTER'
			$Image_C1X = ($A_PathImage[0][0] / 2) - ($Image_Width / 2)
		Case 'LEFT'
			$Image_C1X = 0
		Case 'RIGHT'
			$Image_C1X = $A_PathImage[0][0] - $Image_Width
	EndSwitch
	Switch $Image_C1Y
		Case 'CENTER'
			$Image_C1Y = ($A_PathImage[0][1] / 2) - ($Image_Height / 2)
		Case 'UP'
			$Image_C1Y = 0
		Case 'DOWN'
			$Image_C1Y = $A_PathImage[0][1] - $Image_Height
	EndSwitch

	ConsoleWrite("> --- Pos = " & $Image_C1X & "x" & $Image_C1Y & @CRLF & "> --- Dim = " & $Image_Width & "x" & $Image_Height & @CRLF) ; Debug

	_GDIPlus_Startup()
	$hImage = _GDIPlus_ImageLoadFromFile($PathImage_CUT_Temp)
	$hLeftImage = _GDIPlus_BitmapCloneArea($hImage, 0, 0, $Image_C1X + 1, $A_PathImage[0][1], $GDIP_PXF32ARGB)
	$hRightImage = _GDIPlus_BitmapCloneArea($hImage, $Image_C1X + $Image_Width, 0, $A_PathImage[0][0] - ($Image_C1X + $Image_Width), $A_PathImage[0][1], $GDIP_PXF32ARGB)
	$hUpImage = _GDIPlus_BitmapCloneArea($hImage, $Image_C1X, 0, $Image_Width + 1, $Image_C1Y, $GDIP_PXF32ARGB)
	$hDownImage = _GDIPlus_BitmapCloneArea($hImage, $Image_C1X, $Image_C1Y + $Image_Height, $Image_Width + 1, $A_PathImage[0][1] - ($Image_C1Y + $Image_Height), $GDIP_PXF32ARGB)

	$hGui = GUICreate("", $A_PathImage[0][0], $A_PathImage[0][1])
	$hGraphicGUI = _GDIPlus_GraphicsCreateFromHWND($hGui) ;Draw to this graphics, $hGraphicGUI, to display on GUI
	$hBMPBuff = _GDIPlus_BitmapCreateFromGraphics($A_PathImage[0][0], $A_PathImage[0][1], $hGraphicGUI) ; $hBMPBuff is a bitmap in memory
	$hGraphic = _GDIPlus_ImageGetGraphicsContext($hBMPBuff) ; Draw to this graphics, $hGraphic, being the graphics of $hBMPBuff
	_GDIPlus_GraphicsClear($hGraphic, $MergedImageBackgroundColor)

	_GDIPlus_GraphicsDrawImage($hGraphic, $hLeftImage, 0, 0)
	_GDIPlus_GraphicsDrawImage($hGraphic, $hRightImage, $Image_C1X + $Image_Width, 0)
	_GDIPlus_GraphicsDrawImage($hGraphic, $hUpImage, $Image_C1X, 0)
	_GDIPlus_GraphicsDrawImage($hGraphic, $hDownImage, $Image_C1X, $Image_C1Y + $Image_Height)

	_GDIPlus_ImageSaveToFile($hBMPBuff, $PathImage_Temp)

	; Release resources
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_BitmapDispose($hBMPBuff)
	_GDIPlus_GraphicsDispose($hGraphicGUI)
	GUIDelete($hGui)
	_GDIPlus_ImageDispose($hLeftImage)
	_GDIPlus_ImageDispose($hRightImage)
	_GDIPlus_ImageDispose($hUpImage)
	_GDIPlus_ImageDispose($hDownImage)
	_GDIPlus_ImageDispose($hImage)
	_GDIPlus_Shutdown()
	FileDelete($PathImage_CUT_Temp)

	Return $PathImage_Temp
EndFunc   ;==>_MIX_IMAGE_CUT

Func _MIX_IMAGE_ADDTRANS($PathImage_Temp, $TransLvl)
	Local $hImage, $ImageWidth, $ImageHeight, $hGui, $hGraphicGUI, $hBMPBuff, $hGraphic
	Local $MergedImageBackgroundColor = 0x00000000
	Local $PathImage_TRANS_Temp = StringTrimRight($PathImage_Temp, 4) & "-TRANS_Temp.PNG"

	FileDelete($PathImage_TRANS_Temp)
	FileCopy($PathImage_Temp, $PathImage_TRANS_Temp, 9)
	FileDelete($PathImage_Temp)

	_GDIPlus_Startup()
	$hImage = _GDIPlus_ImageLoadFromFile($PathImage_TRANS_Temp)
	$ImageWidth = _GDIPlus_ImageGetWidth($hImage)
	If $ImageWidth = 4294967295 Then $Image1Width = 0 ;4294967295 en cas d'erreur.
	$ImageHeight = _GDIPlus_ImageGetHeight($hImage)

	$hGui = GUICreate("", $ImageWidth, $ImageHeight)
	$hGraphicGUI = _GDIPlus_GraphicsCreateFromHWND($hGui) ;Draw to this graphics, $hGraphicGUI, to display on GUI
	$hBMPBuff = _GDIPlus_BitmapCreateFromGraphics($ImageWidth, $ImageHeight, $hGraphicGUI) ; $hBMPBuff is a bitmap in memory
	$hGraphic = _GDIPlus_ImageGetGraphicsContext($hBMPBuff) ; Draw to this graphics, $hGraphic, being the graphics of $hBMPBuff
	_GDIPlus_GraphicsClear($hGraphic, $MergedImageBackgroundColor)
	_GDIPlus_GraphicsDrawImageRectRectTrans($hGraphic, $hImage, 0, 0, "", "", "", "", "", "", 2, $TransLvl)
	_GDIPlus_ImageSaveToFile($hBMPBuff, $PathImage_Temp)

	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_BitmapDispose($hBMPBuff)
	_GDIPlus_GraphicsDispose($hGraphicGUI)
	GUIDelete($hGui)
	_GDIPlus_ImageDispose($hImage)
	_GDIPlus_Shutdown()
	FileDelete($PathImage_TRANS_Temp)
	Return $PathImage_Temp
EndFunc   ;==>_MIX_IMAGE_ADDTRANS

Func _MIX_IMAGE_CREATECIBLE($A_PathImage, $PathImage_Temp)
	If UBound($A_PathImage) - 1 < 1 Then Return
	Local $hGui, $hGraphicGUI, $hBMPBuff, $hGraphic
	Local $MergedImageBackgroundColor = 0x00000000

	_CREATION_LOGMESS(2, "Creation du MIX : " & $PathImage_Temp)
	ConsoleWrite("> Creation du MIX : " & $PathImage_Temp & @CRLF)

	_GDIPlus_Startup()
	$hGui = GUICreate("", $A_PathImage[0][0], $A_PathImage[0][1])
	$hGraphicGUI = _GDIPlus_GraphicsCreateFromHWND($hGui) ;Draw to this graphics, $hGraphicGUI, to display on GUI
	$hBMPBuff = _GDIPlus_BitmapCreateFromGraphics($A_PathImage[0][0], $A_PathImage[0][1], $hGraphicGUI) ; $hBMPBuff is a bitmap in memory
	$hGraphic = _GDIPlus_ImageGetGraphicsContext($hBMPBuff) ; Draw to this graphics, $hGraphic, being the graphics of $hBMPBuff
	_GDIPlus_GraphicsClear($hGraphic, $MergedImageBackgroundColor) ;Fill the Graphic Background (0x00000000 for transparent background in .png files)

	For $B_Images = 1 To UBound($A_PathImage) - 1
		$A_PathImage[$B_Images][2] = _GDIPlus_ImageLoadFromFile($A_PathImage[$B_Images][0])
		_GDIPlus_GraphicsDrawImage($hGraphic, $A_PathImage[$B_Images][2], 0, 0)
		_GDIPlus_ImageDispose($A_PathImage[$B_Images][2])
		FileDelete($A_PathImage[$B_Images][0])
	Next

	_GDIPlus_ImageSaveToFile($hBMPBuff, $PathImage_Temp)

	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_BitmapDispose($hBMPBuff)
	_GDIPlus_GraphicsDispose($hGraphicGUI)
	GUIDelete($hGui)
	_GDIPlus_Shutdown()
EndFunc   ;==>_MIX_IMAGE_CREATECIBLE

Func _MIX_IMAGE_CREATEFORMAT()
	Local $A_MIX_IMAGE_Format[1][12]
	Local $B_Sources, $M_Elements, $M_Elements2
	Local $RechMultiLang = StringSplit(IniRead($PathConfigINI, "GENERAL", "$RechMultiLang  ", 'us|en|origine|eu|es|fr|de|pt|jp|xx'), "|")
	$Nb_MIX_Image = IniRead($PathMixTmp & "\config.ini", "MIX_IMG", "$MIX_IMG_NBIMG", 0)
	_CREATION_LOGMESS(1, "Creation des parametres pour le Mix")
	For $B_Images = 1 To $Nb_MIX_Image
		$B_Sources = 1
		$M_Elements = IniRead($PathMixTmp & "\config.ini", "MIX_IMG", "$MIX_IMG" & $B_Images & "_SOURCE_" & $B_Sources, "Ending")
		While $M_Elements <> "Ending"
			If StringInStr($M_Elements, "%%") Then
				Switch $Picture_Region
					Case 1
						_ArrayAdd($A_MIX_IMAGE_Format, $M_Elements)
						_FileReadToArray($PathRegionList, $A_RegionList, $FRTA_NOCOUNT, "|")
						For $B_RechMultiLang = 1 To UBound($RechMultiLang) - 1
							$M_Elements2 = StringReplace($M_Elements, '%%', $RechMultiLang[$B_RechMultiLang])
							_ArrayAdd($A_MIX_IMAGE_Format, $M_Elements2)
						Next
					Case 2
						_ArrayAdd($A_MIX_IMAGE_Format, $M_Elements)
						_FileReadToArray($PathRegionList, $A_RegionList, $FRTA_NOCOUNT, "|")
					Case Else
						For $B_RechMultiLang = 1 To UBound($RechMultiLang) - 1
							$M_Elements2 = StringReplace($M_Elements, '%%', $RechMultiLang[$B_RechMultiLang])
							_ArrayAdd($A_MIX_IMAGE_Format, $M_Elements2)
						Next
				EndSwitch
			Else
				_ArrayAdd($A_MIX_IMAGE_Format, $M_Elements)
			EndIf
			$B_Sources = $B_Sources + 1
			$M_Elements = IniRead($PathMixTmp & "\config.ini", "MIX_IMG", "$MIX_IMG" & $B_Images & "_SOURCE_" & $B_Sources, "Ending")
		WEnd
	Next
	_CREATION_LOGMESS(2, "Fin de recuperation des champs du profil")
;~ 	_ArrayDisplay($A_MIX_IMAGE_Format, '$A_MIX_IMAGE_Format') ; Debug
	Return $A_MIX_IMAGE_Format
EndFunc   ;==>_MIX_IMAGE_CREATEFORMAT

Func _ROMXML_CREATEARRAY($V_XMLPath, $A_XMLFormat)
	Local $Nb_XMLElements = UBound($A_XMLFormat) - 1
	Local $xpath_root, $xpath_child, $xpath_Unique

	ConsoleWrite("+Creation de fichier de Roms existantes" & @CRLF) ; Debug

	For $B_XMLElements = 0 To $Nb_XMLElements - 1
		If $A_XMLFormat[$B_XMLElements][1] = "root" Then Local $xpath_root = "//" & $A_XMLFormat[$B_XMLElements][0]
		If $A_XMLFormat[$B_XMLElements][1] = "child" Then Local $xpath_child = "/" & $A_XMLFormat[$B_XMLElements][0]
		If $A_XMLFormat[$B_XMLElements][2] = "%RomPath%" Then Local $xpath_Unique = "/" & $A_XMLFormat[$B_XMLElements][0]
	Next

	ConsoleWrite("$xpath_root : " & $xpath_root & @CRLF) ; Debug
	ConsoleWrite("$xpath_child : " & $xpath_root & $xpath_child & @CRLF) ; Debug
	ConsoleWrite("$xpath_Unique : " & $xpath_root & $xpath_child & $xpath_Unique & @CRLF) ; Debug

	_XMLFileOpen($V_XMLPath)
	If @error Then
		ConsoleWrite("!_XMLFileOpen : " & $V_XMLPath & " : " & _XMLError("") & @CRLF) ; Debug
		Return -1
	EndIf

	Local $A_Nodes = _XMLGetChildNodes($xpath_root)
	If @error Then
		ConsoleWrite("!__XMLGetChildNodes : " & $V_XMLPath & " : " & _XMLError("") & @CRLF) ; Debug
		Return -1
	EndIf

	Dim $A_ROMXMLList[UBound($A_Nodes)][4]

	For $B_Nodes = 1 To UBound($A_Nodes) - 1
		Local $sNode_Values = _XMLGetValue($xpath_root & "/*[" & $B_Nodes & "]" & $xpath_Unique)
		If IsArray($sNode_Values) Then
			$A_ROMXMLList[$B_Nodes][0] = $sNode_Values[1]
			$sNode_Values_Temp = StringSplit($sNode_Values[1], '\')
			If $sNode_Values_Temp[0] <= 1 Then
				$sNode_Values_Temp = StringSplit($sNode_Values[1], '/')
				For $B_sNode_Values_Temp = 1 To $sNode_Values_Temp[0] - 1
					$A_ROMXMLList[$B_Nodes][1] = $A_ROMXMLList[$B_Nodes][1] & $sNode_Values_Temp[$B_sNode_Values_Temp] & '/'
				Next
			Else
				For $B_sNode_Values_Temp = 1 To $sNode_Values_Temp[0] - 1
					$A_ROMXMLList[$B_Nodes][1] = $A_ROMXMLList[$B_Nodes][1] & $sNode_Values_Temp[$B_sNode_Values_Temp] & '\'
				Next
			EndIf
;~ 			_ArrayDisplay($sNode_Values_Temp, '$sNode_Values_Temp') ; Debug
			$A_ROMXMLList[$B_Nodes][1] = StringTrimRight($A_ROMXMLList[$B_Nodes][0], StringLen($sNode_Values_Temp[$sNode_Values_Temp[0]]))
			$A_ROMXMLList[$B_Nodes][2] = $sNode_Values_Temp[$sNode_Values_Temp[0]]
			$A_ROMXMLList[$B_Nodes][3] = $B_Nodes - 1
		EndIf
	Next
;~ 	_ArrayDelete($A_ROMXMLList, "0")
;~ 	_ArraySort($A_ROMXMLList)
;~ 	_ArrayDisplay($A_ROMXMLList, '$A_ROMXMLList') ; Debug
	Return $A_ROMXMLList
EndFunc   ;==>_ROMXML_CREATEARRAY

Func _IsChecked($idControlID)
	Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
EndFunc   ;==>_IsChecked

Func _TimeOut($hDownload)
	Local $timedout = 0
	Local $inetgettime = 0
	Do
		Sleep(250)
		$inetgettime = $inetgettime + 0.25
		If $inetgettime > 10 Then
			InetClose($hDownload)
			_CREATION_LOGMESS(1, "Time Out : " & $inetgettime)
			ConsoleWrite("timed out waiting for download " & $inetgettime & @CRLF)
			$timedout = 1
			ExitLoop
		EndIf
	Until InetGetInfo($hDownload, 2) ; Check if the download is complete.
	Return $timedout
EndFunc   ;==>_TimeOut

Func _RELATIVPOS($Image_Value, $Image_Value_Max)
	If StringLeft($Image_Value, 1) = '%' Then Return $Image_Value_Max * StringTrimLeft($Image_Value, 1)
	Return $Image_Value
EndFunc   ;==>_RELATIVPOS

Func _RESIZEMAX($PathImage_Temp, $MAX_Width, $MAX_Height)
	Local $Extension = StringRight($PathImage_Temp, 3)
	Local $PathImage_RESIZEMAX_Temp = StringTrimRight($PathImage_Temp, 4) & "-RESIZE_Temp." & $Extension
	Local $hImage, $Image_Width, $Image_Height, $Image_Width_New, $Image_Height_New

	;Travail sur image temporaire
	FileDelete($PathImage_RESIZEMAX_Temp)
	FileCopy($PathImage_Temp, $PathImage_RESIZEMAX_Temp, 9)
	FileDelete($PathImage_Temp)

	_GDIPlus_Startup()
	$hImage = _GDIPlus_ImageLoadFromFile($PathImage_RESIZEMAX_Temp)
	$Image_Width = _GDIPlus_ImageGetWidth($hImage)
	If $Image_Width = 4294967295 Then $Image_Width = 0 ;4294967295 en cas d'erreur.
	$Image_Height = _GDIPlus_ImageGetHeight($hImage)

	If $MAX_Width = '' Then $MAX_Width = $Image_Width
	If $MAX_Height = '' Then $MAX_Height = $Image_Height

	$Image_Width_New = $Image_Width
	$Image_Height_New = $Image_Height

	If $Image_Width > $MAX_Width Then
		$Ratio = $Image_Width / $MAX_Width
		$Image_Width_New = $MAX_Width
		$Image_Height_New = $Image_Height / $Ratio
		If $Image_Height_New > $MAX_Height Then
			$Ratio = $Image_Height_New / $MAX_Height
			$Image_Height_New = $MAX_Height
			$Image_Width_New = $Image_Width_New / $Ratio
		EndIf
	EndIf

	If $Image_Height > $MAX_Height Then
		$Ratio = $Image_Height / $MAX_Height
		$Image_Height_New = $MAX_Height
		$Image_Width_New = $Image_Width / $Ratio
		If $Image_Width_New > $MAX_Width Then
			$Ratio = $Image_Width_New / $MAX_Width
			$Image_Height_New = $Image_Height_New / $Ratio
			$Image_Width_New = $MAX_Width
		EndIf
	EndIf

	If $Image_Width <> $Image_Width_New Or $Image_Height <> $Image_Height_New Then
		ConsoleWrite("+ Redimensionnement (RESIZEMAX) de " & $PathImage_Temp & @CRLF) ; Debug
		ConsoleWrite("+ ----- Origine = " & $Image_Width & "x" & $Image_Height & @CRLF) ; Debug
		ConsoleWrite("+ ----- Finale = " & $Image_Width_New & "x" & $Image_Height_New & @CRLF) ; Debug
	Else
		ConsoleWrite("+ Pas de redimensionnement (RESIZEMAX) de " & $PathImage_Temp & @CRLF) ; Debug
	EndIf

	$hImageResized = _GDIPlus_ImageResize($hImage, $Image_Width_New, $Image_Height_New)

	_GDIPlus_ImageSaveToFile($hImageResized, $PathImage_Temp)
	_GDIPlus_ImageDispose($hImageResized)
	_GDIPlus_ImageDispose($hImage)
	_GDIPlus_Shutdown()
	FileDelete($PathImage_RESIZEMAX_Temp)

	Return $PathImage_Temp
EndFunc   ;==>_RESIZEMAX

Func _ROTATION($PathImage_Temp, $A_MIX_IMAGE_Format, $B_Images)
	Local $Extension = StringRight($PathImage_Temp, 3)
	Local $PathImage_ROTATION_Temp = StringTrimRight($PathImage_Temp, 4) & "-RESIZE_Temp." & $Extension
	Local $hImage, $Image_Width, $Image_Height, $Image_Width_New, $Image_Height_New, $RotationType

	;Travail sur image temporaire
	FileDelete($PathImage_ROTATION_Temp)
	FileCopy($PathImage_Temp, $PathImage_ROTATION_Temp, 9)
	FileDelete($PathImage_Temp)

	If $A_MIX_IMAGE_Format[$B_Images][9] = '' Or $A_MIX_IMAGE_Format[$B_Images][9] > 7 Then
		$RotationType = 0
	Else
		$RotationType = $A_MIX_IMAGE_Format[$B_Images][9]
	EndIf

	_GDIPlus_Startup()
	$hImage = _GDIPlus_ImageLoadFromFile($PathImage_ROTATION_Temp)
	$Image_Width = _GDIPlus_ImageGetWidth($hImage)
	If $Image_Width = 4294967295 Then $Image_Width = 0 ;4294967295 en cas d'erreur.
	$Image_Height = _GDIPlus_ImageGetHeight($hImage)

	_GDIPlus_ImageRotateFlip($hImage, $RotationType)
	$Image_Width_New = _GDIPlus_ImageGetWidth($hImage)
	If $Image_Width = 4294967295 Then $Image_Width = 0 ;4294967295 en cas d'erreur.
	$Image_Height_New = _GDIPlus_ImageGetHeight($hImage)

	ConsoleWrite("+ Redimensionnement (ROTATION:" & $RotationType & ") de " & $PathImage_Temp & @CRLF) ; Debug
	ConsoleWrite("+ ----- Origine = " & $Image_Width & "x" & $Image_Height & @CRLF) ; Debug
	ConsoleWrite("+ ----- Finale = " & $Image_Width_New & "x" & $Image_Height_New & @CRLF) ; Debug

	_GDIPlus_ImageSaveToFile($hImage, $PathImage_Temp)
	_GDIPlus_ImageDispose($hImage)
	_GDIPlus_Shutdown()
	FileDelete($PathImage_ROTATION_Temp)
	$A_MIX_IMAGE_Format[$B_Images][8] = ''
	$A_MIX_IMAGE_Format[$B_Images][9] = ''
	$A_MIX_IMAGE_Format[$B_Images][4] = $Image_Width_New
	$A_MIX_IMAGE_Format[$B_Images][5] = $Image_Height_New
	Return $A_MIX_IMAGE_Format
EndFunc   ;==>_ROTATION

Func _IMAGING($PathImage_Temp, $A_PathImage, $A_MIX_IMAGE_Format, $B_Images, $TYPE = '')
	Local $Extension = StringRight($PathImage_Temp, 3)
	Local $PathImage_IMAGING_Temp = StringTrimRight($PathImage_Temp, 4) & "-IMAGING_Temp." & $Extension
	Local $hImage, $hGui, $hGraphicGUI, $hBMPBuff, $hGraphic
	Local $MergedImageBackgroundColor = 0x00000000

	Local $Image_Width = _RELATIVPOS($A_MIX_IMAGE_Format[$B_Images][4], $A_PathImage[0][0])
	Local $Image_Height = _RELATIVPOS($A_MIX_IMAGE_Format[$B_Images][5], $A_PathImage[0][1])

	If StringRight($TYPE, 3) = 'MAX' Then
		$PathImage_Temp = _RESIZEMAX($PathImage_Temp, $Image_Width, $Image_Height)
;~ 	Else
;~ 		_RESIZEMAX($PathImage_Temp, $A_PathImage[0][0], $A_PathImage[0][1])
	EndIf

	;Travail sur image temporaire
	FileDelete($PathImage_IMAGING_Temp)
	FileCopy($PathImage_Temp, $PathImage_IMAGING_Temp, 9)
	FileDelete($PathImage_Temp)

	_GDIPlus_Startup()
	$hImage = _GDIPlus_ImageLoadFromFile($PathImage_IMAGING_Temp)
	$hGui = GUICreate("", $A_PathImage[0][0], $A_PathImage[0][1])
	$hGraphicGUI = _GDIPlus_GraphicsCreateFromHWND($hGui) ;Draw to this graphics, $hGraphicGUI, to display on GUI
	$hBMPBuff = _GDIPlus_BitmapCreateFromGraphics($A_PathImage[0][0], $A_PathImage[0][1], $hGraphicGUI) ; $hBMPBuff is a bitmap in memory
	$hGraphic = _GDIPlus_ImageGetGraphicsContext($hBMPBuff) ; Draw to this graphics, $hGraphic, being the graphics of $hBMPBuff
	_GDIPlus_GraphicsClear($hGraphic, $MergedImageBackgroundColor) ; Fill the Graphic Background (0x00000000 for transparent background in .png files)

	If $Image_Width = "" Or StringRight($TYPE, 3) = 'MAX' Then $Image_Width = _GDIPlus_ImageGetWidth($hImage)
	If $Image_Height = "" Or StringRight($TYPE, 3) = 'MAX' Then $Image_Height = _GDIPlus_ImageGetHeight($hImage)
	Local $Image_C1X = _RELATIVPOS($A_MIX_IMAGE_Format[$B_Images][6], $A_PathImage[0][0])
	Local $Image_C1Y = _RELATIVPOS($A_MIX_IMAGE_Format[$B_Images][7], $A_PathImage[0][1])
	Local $Image_C2X = _RELATIVPOS($A_MIX_IMAGE_Format[$B_Images][8], $A_PathImage[0][0])
	Local $Image_C2Y = _RELATIVPOS($A_MIX_IMAGE_Format[$B_Images][9], $A_PathImage[0][1])
	Local $Image_C3X = _RELATIVPOS($A_MIX_IMAGE_Format[$B_Images][10], $A_PathImage[0][0])
	Local $Image_C3Y = _RELATIVPOS($A_MIX_IMAGE_Format[$B_Images][11], $A_PathImage[0][1])

	Switch $Image_C1X
		Case 'CENTER'
			$Image_C1X = ($A_PathImage[0][0] / 2) - ($Image_Width / 2)
		Case 'LEFT'
			$Image_C1X = 0
		Case 'RIGHT'
			$Image_C1X = $A_PathImage[0][0] - $Image_Width
	EndSwitch
	Switch $Image_C1Y
		Case 'CENTER'
			$Image_C1Y = ($A_PathImage[0][1] / 2) - ($Image_Height / 2)
		Case 'UP'
			$Image_C1Y = 0
		Case 'DOWN'
			$Image_C1Y = $A_PathImage[0][1] - $Image_Height
	EndSwitch
	Switch $Image_C2X
		Case 'CENTER'
			$Image_C2X = ($A_PathImage[0][0] / 2) + ($Image_Width / 2)
		Case 'LEFT'
			$Image_C2X = $Image_Width
		Case 'RIGHT'
			$Image_C2X = $A_PathImage[0][0]
		Case ''
			$Image_C2X = $Image_C1X + $Image_Width
	EndSwitch
	Switch $Image_C2Y
		Case 'CENTER'
			$Image_C2Y = ($A_PathImage[0][1] / 2) - ($Image_Height / 2)
		Case 'UP'
			$Image_C2Y = 0
		Case 'DOWN'
			$Image_C2Y = $A_PathImage[0][1] - $Image_Height
		Case ''
			$Image_C2Y = $Image_C1Y
	EndSwitch
	Switch $Image_C3X
		Case 'CENTER'
			$Image_C3X = ($A_PathImage[0][0] / 2) - ($Image_Width / 2)
		Case 'LEFT'
			$Image_C3X = 0
		Case 'RIGHT'
			$Image_C3X = $A_PathImage[0][0] - $Image_Width
		Case ''
			$Image_C3X = $Image_C1X
	EndSwitch
	Switch $Image_C3Y
		Case 'CENTER'
			$Image_C3Y = ($A_PathImage[0][1] / 2) + ($Image_Height / 2)
		Case 'UP'
			$Image_C3Y = 0 + $Image_Height
		Case 'DOWN'
			$Image_C3Y = $A_PathImage[0][1]
		Case ''
			$Image_C3Y = $Image_C1Y + $Image_Height
	EndSwitch

;~ 	If $Image_C2X = "" Then $Image_C2X = $Image_C1X + $Image_Width
;~ 	If $Image_C2Y = "" Then $Image_C2Y = $Image_C1Y
;~ 	If $Image_C3X = "" Then $Image_C3X = $Image_C1X
;~ 	If $Image_C3Y = "" Then $Image_C3Y = $Image_C1Y + $Image_Height

	ConsoleWrite("+ Preparation de l'image (_IMAGING) de " & $PathImage_Temp & @CRLF) ; Debug
	ConsoleWrite("+ ----- C1 = " & $Image_C1X & "x" & $Image_C1Y & @CRLF) ; Debug
	ConsoleWrite("+ ----- C2 = " & $Image_C2X & "x" & $Image_C2Y & @CRLF) ; Debug
	ConsoleWrite("+ ----- C3 = " & $Image_C3X & "x" & $Image_C3Y & @CRLF) ; Debug
	ConsoleWrite("+ ----- (Size) = " & $Image_Width & "x" & $Image_Height & @CRLF) ; Debug

	_GDIPlus_DrawImagePoints($hGraphic, $hImage, $Image_C1X, $Image_C1Y, $Image_C2X, $Image_C2Y, $Image_C3X, $Image_C3Y)
	_GDIPlus_ImageSaveToFile($hBMPBuff, $PathImage_Temp)
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_BitmapDispose($hBMPBuff)
	_GDIPlus_GraphicsDispose($hGraphicGUI)
	GUIDelete($hGui)
	_GDIPlus_ImageDispose($hImage)
	_GDIPlus_Shutdown()

	FileDelete($PathImage_IMAGING_Temp)

	Return $PathImage_Temp
EndFunc   ;==>_IMAGING

; #FUNCTION# ===================================================================================================
; Name...........: _GDIPlus_GraphicsDrawImageRectRectTrans
; Description ...: Draw an Image object with transparency
; Syntax.........: _GDIPlus_GraphicsDrawImageRectRect($hGraphics, $hImage, $iSrcX, $iSrcY, [$iSrcWidth, _
;                                   [$iSrcHeight, [$iDstX, [$iDstY, [$iDstWidth, [$iDstHeight[, [$iUnit = 2]]]]]]])
; Parameters ....: $hGraphics   - Handle to a Graphics object
;                  $hImage      - Handle to an Image object
;                  $iSrcX       - The X coordinate of the upper left corner of the source image
;                  $iSrcY       - The Y coordinate of the upper left corner of the source image
;                  $iSrcWidth   - Width of the source image
;                  $iSrcHeight  - Height of the source image
;                  $iDstX       - The X coordinate of the upper left corner of the destination image
;                  $iDstY       - The Y coordinate of the upper left corner of the destination image
;                  $iDstWidth   - Width of the destination image
;                  $iDstHeight  - Height of the destination image
;                  $iUnit       - Specifies the unit of measure for the image
;                  $nTrans      - Value range from 0 (Zero for invisible) to 1.0 (fully opaque)
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Siao
; Modified.......: Malkey
; Remarks .......:
; Related .......:
; Link ..........; http://www.autoitscript.com/forum/index.php?s=&showtopic=70573&view=findpost&p=517195
; Example .......; Yes
Func _GDIPlus_GraphicsDrawImageRectRectTrans($hGraphics, $hImage, $iSrcX, $iSrcY, $iSrcWidth = "", $iSrcHeight = "", _
		$iDstX = "", $iDstY = "", $iDstWidth = "", $iDstHeight = "", $iUnit = 2, $nTrans = 1)
	Local $tColorMatrix, $x, $hImgAttrib, $iW = _GDIPlus_ImageGetWidth($hImage), $iH = _GDIPlus_ImageGetHeight($hImage)
	If $iSrcWidth = 0 Or $iSrcWidth = "" Then $iSrcWidth = $iW
	If $iSrcHeight = 0 Or $iSrcHeight = "" Then $iSrcHeight = $iH
	If $iDstX = "" Then $iDstX = $iSrcX
	If $iDstY = "" Then $iDstY = $iSrcY
	If $iDstWidth = "" Then $iDstWidth = $iSrcWidth
	If $iDstHeight = "" Then $iDstHeight = $iSrcHeight
	If $iUnit = "" Then $iUnit = 2
	;;create color matrix data
	$tColorMatrix = DllStructCreate("float[5];float[5];float[5];float[5];float[5]")
	;blending values:
	$x = DllStructSetData($tColorMatrix, 1, 1, 1) * DllStructSetData($tColorMatrix, 2, 1, 2) * DllStructSetData($tColorMatrix, 3, 1, 3) * _
			DllStructSetData($tColorMatrix, 4, $nTrans, 4) * DllStructSetData($tColorMatrix, 5, 1, 5)
	;;create an image attributes object and update its color matrix
	$hImgAttrib = DllCall($__g_hGDIPDll, "int", "GdipCreateImageAttributes", "ptr*", 0)
	$hImgAttrib = $hImgAttrib[1]
	DllCall($__g_hGDIPDll, "int", "GdipSetImageAttributesColorMatrix", "ptr", $hImgAttrib, "int", 1, _
			"int", 1, "ptr", DllStructGetPtr($tColorMatrix), "ptr", 0, "int", 0)
	;;draw image into graphic object with alpha blend
	DllCall($__g_hGDIPDll, "int", "GdipDrawImageRectRectI", "hwnd", $hGraphics, "hwnd", $hImage, "int", $iDstX, "int", _
			$iDstY, "int", $iDstWidth, "int", $iDstHeight, "int", $iSrcX, "int", $iSrcY, "int", $iSrcWidth, "int", _
			$iSrcHeight, "int", $iUnit, "ptr", $hImgAttrib, "int", 0, "int", 0)
	;;clean up
	DllCall($__g_hGDIPDll, "int", "GdipDisposeImageAttributes", "ptr", $hImgAttrib)
	Return
EndFunc   ;==>_GDIPlus_GraphicsDrawImageRectRectTrans
