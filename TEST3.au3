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





Local $MergedImageBackgroundColor = 0x00000000
	_GDIPlus_Startup()

	$hImageMIX = _GDIPlus_ImageLoadFromFile("C:\Developpement\Github\Universal-XML-Scraper\Mix\TEMP\empty.png")
	$ImageWidthOG = _GDIPlus_ImageGetWidth($hImageMIX)
	If $ImageWidthOG = 4294967295 Then $ImageWidthOG = 0 ;4294967295 en cas d'erreur, soit 32 bits à 1 (11111...1111111).
	$ImageHeightOG = _GDIPlus_ImageGetHeight($hImageMIX)

	If $ImageWidthOG > 400 Then
		$Ratio = 400 / $ImageWidthOG
		$ImageWidth = 400
		$ImageHeight = $ImageHeightOG * $Ratio
	Else
		$ImageWidth = $ImageWidthOG
		$ImageHeight = $ImageHeightOG
	EndIf

	If $ImageHeight > 200 Then
		$Ratio = 200 / $ImageHeightOG
		$ImageHeight = 200
		$ImageWidth = $ImageWidth * $Ratio
	Else
		$ImageHeight = $ImageHeightOG
	EndIf


	#Region ### START Koda GUI section ### Form=
	$F_MIXIMAGE = GUICreate("MixImage", 825, 272, 192, 124)
	$B_OK = GUICtrlCreateButton("OK", 416, 240, 200, 25)
	$B_CANCEL = GUICtrlCreateButton("CANCEL", 616, 240, 200, 25)
	$L_Empy = GUICtrlCreateLabel("Exemple Vide", 168, 216, 68, 17)
	$L_Exemple = GUICtrlCreateLabel("Exemple", 592, 216, 44, 17)
	GUISetState(@SW_SHOW)
	#EndRegion ### END Koda GUI section ###



; Create Double Buffer, so the doesn't need to be repainted on PAINT-Event
$hGraphicGUI = _GDIPlus_GraphicsCreateFromHWND($F_MIXIMAGE) ;Draw to this graphics, $hGraphicGUI, to display on GUI
$hBMPBuffMIX = _GDIPlus_BitmapCreateFromGraphics(400, 200, $hGraphicGUI) ; $hBMPBuff is a bitmap in memory
$hGraphicMIX = _GDIPlus_ImageGetGraphicsContext($hBMPBuffMIX) ; Draw to this graphics, $hGraphic, being the graphics of $hBMPBuff

;Fill the Graphic Background (0x00000000 for transparent background in .png files)
_GDIPlus_GraphicsClear($hGraphicMIX, $MergedImageBackgroundColor)

;~ $hImageMIX = _GDIPlus_ImageResize($hImageMIX, $ImageWidth, $ImageHeight)

	_GDIPlus_GraphicsDrawImageRectRect($hGraphicMIX, $hImageMIX, 0, 0, 400, 200, 8, 8, 408, 208)
	If Not _GDIPlus_ImageDispose($hImageMIX) Then MsgBox($MB_SYSTEMMODAL, "Error", "Problem $hImage.")

	_GDIPlus_GraphicsDrawImage($hGraphicGUI, $hBMPBuffMIX, 0, 0)

	_GDIPlus_GraphicsDispose($hGraphicMIX)
	_GDIPlus_GraphicsDispose($hGraphicGUI)
	_WinAPI_DeleteObject($hBMPBuffMIX)
	If Not _GDIPlus_Shutdown() Then MsgBox($MB_SYSTEMMODAL, "Error", "Problem _GDIPlus_Shutdown")

While 1
		Local $nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE, $B_CANCEL
				Exit
			Case $B_OK
				If Not FileDelete("C:\Developpement\Github\Universal-XML-Scraper\Mix\TEMP\") Then MsgBox(1, "erreur", "Impossible de supprimer ")
		EndSwitch
		wend
