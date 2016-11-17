;TEST

#include <Date.au3>
#include <array.au3>
#include <File.au3>
#include <String.au3>
#include <GuiStatusBar.au3>
#include <Crypt.au3>
#include <GDIPlus.au3>
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <InetConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <StaticConstants.au3>
#include <GDIPlus.au3>

If Not _FileCreate(@ScriptDir & "\test") Then ; Testing UXS Directory
	Global $iScriptPath = @AppDataDir & "\UXMLS" ; If not, use Path to current user's Roaming Application Data
	DirCreate($iScriptPath) ;
Else
	Global $iScriptPath = @ScriptDir
	FileDelete($iScriptPath & "\test")
EndIf
Global $iINIPath = $iScriptPath & "\UXS-config.ini"
Global $iLOGPath = $iScriptPath & "\LOGs\log.txt"
Global $iVerboseLVL = IniRead($iINIPath, "GENERAL", "$vVerbose", 0)
Global $MS_AutoConfigItem
#include "./Include/_MultiLang.au3"
#include "./Include/_ExtMsgBox.au3"
#include "./Include/_Trim.au3"
#include "./Include/_Hash.au3"
#include "./Include/_zip.au3"
#include "./Include/_XML.au3"
#include "./Include/MailSlot.au3"
#include "./Include/_GraphGDIPlus.au3"
#include "./Include/_MyFunction.au3"

Dim $aPicParameters[11]
$aPicParameters[0] = '%1'
$aPicParameters[1] = '-1'
$aPicParameters[2] = 'CENTER'
$aPicParameters[3] = 'CENTER'
$aPicParameters[4] = ''
$aPicParameters[5] = ''
$aPicParameters[6] = ''
$aPicParameters[7] = ''
$aPicParameters[8] = 'Yes'
$aPicParameters[9] = ''
$aPicParameters[10] = ''


$vTarget_Width = 1920
$vTarget_Height= 1080
;~ $vTarget_Width = 300
;~ $vTarget_Height= 140
$iPath = "C:\Developpement\Github\Universal-XML-Scraper\photo.png"
;~ $iPath = "C:\Developpement\Github\Universal-XML-Scraper\wheel(jp).png"

;~ _GDIPlus_Imaging($iPath, $aPicParameters, $vTarget_Width, $vTarget_Height)
_GDIPlus_ResizeMax($iPath, $vTarget_Width, $vTarget_Height)