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
#include <Crypt.au3>
#include <GDIPlus.au3>

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


Global $PathDIRTmp = $SOURCE_DIRECTORY & "\TEMP\"
Global $IMG_2dcase = $PathDIRTmp & "2dCase.png"
Global $IMG_3dcase = $PathDIRTmp & "3dCase.png"
Global $IMG_screenshot = $PathDIRTmp & "screenshot.png"
Global $IMG_wheel = $PathDIRTmp & "wheel.png"
Global $IMG_wheelcarbon = $PathDIRTmp & "wheel-carbon.png"
Global $IMG_wheelsteel = $PathDIRTmp & "wheel-steel.png"
Global $IMG_TEST = $PathDIRTmp & "TEST.png"

;~ #include <GuiConstants.au3>
Opt("GUIOnEventMode", 1) ;0=disabled, 1=OnEvent mode enabled

$ScriptTitle = @ScriptName ; "Merge2Images"
$ScriptRev = "B.0"

Global $Title = $ScriptTitle & " - " & $ScriptRev
Local $ShowMergeGUIWindow, $SleepTimeShowMergeGUIWindow, $MergedImageBackgroundColor, $ShowFinaleMergedImage, $CenterImageVertically, $StrechImageVertically, $GuiSizeX, $GuiSizeY, $FirstPicName, $ImageName1, $ImageName2, $ImageCompositeName, $MergeImageMode, $MergeExtension, $MergeMode

; -----------------------------------8<-----------------------------------
;For debugging purpose only, please do not modify this !
$ShowMergeGUIWindow = False
$SleepTimeShowMergeGUIWindow = 2000
;For debugging purpose only, please do not modify this !
; -----------------------------------8<-----------------------------------

; -----------------------------------8<-----------------------------------
; TBD (not specially in this order) :
;     - Define size of merged image X * Y ;Done, but FTM wondering how to use it.
;     - Center Horizontally (X) images ? ;Done ;... need "Define size of merged image X * Y" predefined ! ;No.
;     - Strech Horizontally (X) images ? ;Done ;... need "Define size of merged image X * Y" predefined ! ;No.
; -----------------------------------8<-----------------------------------


$MergedImageBackgroundColor = 0x00000000 ;Specify 00 on first "digits" for transparent color (.png only !), all other values (......) will be ignored.
$ShowFinaleMergedImage = False
$CenterImageVertically = False
$StrechImageVertically = False
$CenterImageHorizontally = False
$StrechImageHorizontally = False

$GuiSizeX = 0
$GuiSizeY = 0

$FirstPicName = 0 ;1 = First pic first / 2 = First pic second
$ImageName1 = $IMG_screenshot
$ImageName2 = $IMG_3dcase
$ImageName3 = $IMG_wheelcarbon
$ImageCompositeName = $IMG_TEST
$MergeImageMode = 0 ;0 New Image / 1 Merge on 1st / 2 Merge on 2nd
$MergeExtension = ".png" ; .jpg -or- .png
$MergeMode = 3 ;0 = Merge vertically (add on same line) / 1 = Merge horizontally (add on same colon)


; -----------------------------------8)-----------------------------------
;Traitement des résidus
If $ImageName1 = "" Then ;Résidu : pas de source
	If $ImageName2 = "" Then ;Résidu : pas d'alternative non-plus (rien à traiter)
		$ImageName1 = FileOpenDialog(@ScriptName & " - Image source ?", "", "Images (*.jpg; *.png)")
		$ImageName2 = FileOpenDialog(@ScriptName & " - Image alternative ?", "", "Images (*.jpg; *.png)")
		$ImageCompositeName = FileOpenDialog(@ScriptName & " - Image destination ?", "", "Images (*.jpg; *.png)")
		$FirstPicName = 1
	Else
		$ImageName1 = $ImageName2 ;Résidu : seulement l'alternative
	EndIf
Else
	If $ImageName2 = "" Then
		$ImageName2 = $ImageName1 ;Résidu : seulement la source
	EndIf
EndIf

If $ImageCompositeName = "" Then ;Résidu : pas de destination renseignée
	If $ImageName1 = $ImageName2 And $MergeImageMode <> 0 Then
		$ImageCompositeName = $ImageName1 ;Résidu : destination unique en écrasement
	ElseIf $MergeImageMode = 1 Then
		$ImageCompositeName = $ImageName1 ;Résidu : destination unique source
	ElseIf $MergeImageMode = 2 Then
		$ImageCompositeName = $ImageName2 ;Résidu : destination unique alternative
	Else
		If Not $FirstPicName = 1 Then
			$ImageCompositeName = $ImageName2 & "+" & $ImageName1 & $MergeExtension ;Résidu : destination=alternative+source.ext
		Else
			$ImageCompositeName = $ImageName1 & "+" & $ImageName2 & $MergeExtension ;Résidu : destination=source+alternative.ext
		EndIf
	EndIf
EndIf
; -----------------------------------8)-----------------------------------

_GDIPlus_Startup()

; Load image 1
$hImage1 = _GDIPlus_ImageLoadFromFile($ImageName1)
$hImage1 = _GDIPlus_ImageResize($hImage1, 500, 375)
$iX1 = _GDIPlus_ImageGetWidth($hImage1)
If $iX1 = 4294967295 Then $iX1 = 0 ;4294967295 en cas d'erreur, soit 32 bits à 1 (11111...1111111).
$iY1 = _GDIPlus_ImageGetHeight($hImage1)

; Load image 2
$hImage2 = _GDIPlus_ImageLoadFromFile($ImageName2)
$hImage2 = _GDIPlus_ImageResize($hImage2, 150, 277)
$iX2 = _GDIPlus_ImageGetWidth($hImage2)
If $iX2 = 4294967295 Then $iX2 = 0 ;4294967295 en cas d'erreur, soit 32 bits à 1 (11111...1111111).
$iY2 = _GDIPlus_ImageGetHeight($hImage2)

; Load image 3
$hImage3 = _GDIPlus_ImageLoadFromFile($ImageName3)
$hImage3 = _GDIPlus_ImageResize($hImage3, 300, 150)
$iX3 = _GDIPlus_ImageGetWidth($hImage3)
If $iX3 = 4294967295 Then $iX3 = 0 ;4294967295 en cas d'erreur, soit 32 bits à 1 (11111...1111111).
$iY3 = _GDIPlus_ImageGetHeight($hImage3)

; Define the Merged (Composite) image size
Select
	Case $MergeMode = 0 ;Horizontally merge
		If $GuiSizeX = 0 Then $GuiSizeX = $iX1 + $iX2
		If $GuiSizeY = 0 Then
			If $iY1 > $iY2 Then
				$GuiSizeY = $iY1
			Else
				$GuiSizeY = $iY2
			EndIf
		EndIf
		$VPos1 = 0
		$HPos1 = 0
		$XStrech1 = $iX1
		$YStrech1 = $iY1
		If $StrechImageVertically Then $YStrech1 = $GuiSizeY
		If $CenterImageVertically And Not $StrechImageVertically Then $VPos1 = ($GuiSizeY - $iY1) / 2
		$VPos2 = 0
		$HPos2 = $XStrech1 ;/!\
		$XStrech2 = $iX2
		$YStrech2 = $iY2
		If $StrechImageVertically Then $YStrech2 = $GuiSizeY
		If $CenterImageVertically And Not $StrechImageVertically Then $VPos2 = ($GuiSizeY - $iY2) / 2
	Case $MergeMode = 1 ;Vertically merge
		If $GuiSizeY = 0 Then $GuiSizeY = $iY1 + $iY2
		If $GuiSizeX = 0 Then
			If $iX1 > $iX2 Then
				$GuiSizeX = $iX1
			Else
				$GuiSizeX = $iX2
			EndIf
		EndIf
		$VPos1 = 0
		$HPos1 = 0
		$XStrech1 = $iX1
		$YStrech1 = $iY1
		If $StrechImageHorizontally Then $XStrech1 = $GuiSizeX
		If $CenterImageHorizontally And Not $StrechImageHorizontally Then $HPos1 = ($GuiSizeX - $iX1) / 2
		$VPos2 = $YStrech1 ;/!\
		$HPos2 = 0
		$XStrech2 = $iX2
		$YStrech2 = $iY2
		If $StrechImageHorizontally Then $XStrech2 = $GuiSizeX
		If $CenterImageHorizontally And Not $StrechImageHorizontally Then $HPos2 = ($GuiSizeX - $iX2) / 2
	Case Else
		If $GuiSizeX = 0 Then $GuiSizeX = $iX1 + ($iX2 / 2) + ($iX3 / 3)
		If $GuiSizeY = 0 Then
			If $iY1 > $iY2 Then
				$GuiSizeY = $iY1 + ($iY2 / 3)
			Else
				$GuiSizeY = $iY2
			EndIf
		EndIf
		$VPos1 = 0
		$HPos1 = 0+($iX2/2)
		$XStrech1 = $iX1
		$YStrech1 = $iY1
		If $StrechImageVertically Then $YStrech1 = $GuiSizeY
		If $CenterImageVertically And Not $StrechImageVertically Then $VPos1 = ($GuiSizeY - $iY1) / 2
		$VPos2 = $YStrech1 + ($iY2 / 3) - $iY2
		$HPos2 = 0
		$XStrech2 = $iX2
		$YStrech2 = $iY2
		If $StrechImageVertically Then $YStrech2 = $GuiSizeY
		If $CenterImageVertically And Not $StrechImageVertically Then $VPos2 = ($GuiSizeY - $iY2) / 2
		$VPos3 = $YStrech1 + ($iY3 / 2) - $iY3
		$HPos3 = 0+($iX2/2)+$iY1-(($iY3/3)*2)
		$XStrech3 = $iX3
		$YStrech3 = $iY3
EndSelect

; Initialise the Drawing windows/composite image...
$hGui = GUICreate("GDIPlus Example", $GuiSizeX, $GuiSizeY)
; Show drawing window ?
GUISetState()
GUISetOnEvent(-3, "_Close")

; Create Double Buffer, so the doesn't need to be repainted on PAINT-Event
$hGraphicGUI = _GDIPlus_GraphicsCreateFromHWND($hGui) ;Draw to this graphics, $hGraphicGUI, to display on GUI
$hBMPBuff = _GDIPlus_BitmapCreateFromGraphics($GuiSizeX, $GuiSizeY, $hGraphicGUI) ; $hBMPBuff is a bitmap in memory
$hGraphic = _GDIPlus_ImageGetGraphicsContext($hBMPBuff) ; Draw to this graphics, $hGraphic, being the graphics of $hBMPBuff

;Fill the Graphic Background (0x00000000 for transparent background in .png files)
_GDIPlus_GraphicsClear($hGraphic, $MergedImageBackgroundColor)

;Put the previously opened images together on the same Graphic and closing them
_GDIPlus_GraphicsDrawImageRectRect($hGraphic, $hImage1, 0, 0, $iX1, $iY1, $HPos1, $VPos1, $XStrech1, $YStrech1)
_GDIPlus_GraphicsDrawImageRectRect($hGraphic, $hImage2, 0, 0, $iX2, $iY2, $HPos2, $VPos2, $XStrech2, $YStrech2)
_GDIPlus_GraphicsDrawImageRectRect($hGraphic, $hImage3, 0, 0, $iX3, $iY3, $HPos3, $VPos3, $XStrech3, $YStrech3)
_GDIPlus_ImageDispose($hImage1)
_GDIPlus_ImageDispose($hImage2)
_GDIPlus_ImageDispose($hImage3)

; Save composite image (need that previously opened images have been closed if self-merging a file)
Local $sNewName = $ImageCompositeName
_GDIPlus_ImageSaveToFile($hBMPBuff, $sNewName) ; $hBMPBuff the bitmap

; Show drawing window ?
_GDIPlus_GraphicsDrawImage($hGraphicGUI, $hBMPBuff, 0, 0) ; Draw bitmap, $hBMPBuff, to the GUI's graphics, $hGraphicGUI.
Sleep($SleepTimeShowMergeGUIWindow) ; Wait $SleepTimeShowMergeGUIWindow ms, or press Esc.

; Show result saved file ?
ShellExecute($sNewName)

_Quit()


Func _Close() ;Close the previously opened images, only called when gui window is manually closed
	_GDIPlus_ImageDispose($hImage1)
	_GDIPlus_ImageDispose($hImage2)
	_Quit()
EndFunc   ;==>_Close

Func _Quit()
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_GraphicsDispose($hGraphicGUI)
	_WinAPI_DeleteObject($hBMPBuff)
	_GDIPlus_Shutdown()
	Exit
EndFunc   ;==>_Quit

;Func to auto-redraw on Windows internal PAINT messages.
Func MY_PAINT($hWnd, $msg, $wParam, $lParam)
	_GDIPlus_GraphicsDrawImage($hGraphicGUI, $hBMPBuff, 0, 0)
	Return $GUI_RUNDEFMSG
EndFunc   ;==>MY_PAINT
; -----------------------------------8<-----------------------------------
