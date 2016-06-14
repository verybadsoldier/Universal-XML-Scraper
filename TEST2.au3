#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compression=0
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_UseX64=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <GDIPlus.au3>
#include <GuiConstants.au3>
Opt("GUIOnEventMode", 1) ;0=disabled, 1=OnEvent mode enabled

$ScriptTitle = @ScriptName ; "Merge2Images"
$ScriptRev = "B.0"

Global $Title = $ScriptTitle & " - " & $ScriptRev
Local $ShowMergeGUIWindow, $SleepTimeShowMergeGUIWindow, $MergedImageBackgroundColor, $ShowFinaleMergedImage, $CenterImageVertically, $StrechImageVertically, $GuiSizeX, $GuiSizeY, $FirstPicName, $ImageName1, $ImageName2, $ImageCompositeName, $MergeImageMode, $MergeExtension, $MergeMode

; -----------------------------------8<-----------------------------------
;For debugging purpose only, please do not modify this !
$ShowMergeGUIWindow = True
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
$ShowFinaleMergedImage = True
$CenterImageVertically = False
$StrechImageVertically = False
$CenterImageHorizontally = False
$StrechImageHorizontally = False

$GuiSizeX = 0
$GuiSizeY = 0

$FirstPicName = 0 ;1 = First pic first / 2 = First pic second
$ImageName1 = ""
$ImageName2 = ""
$ImageCompositeName = ""
$MergeImageMode = 0 ;0 New Image / 1 Merge on 1st / 2 Merge on 2nd
$MergeExtension = ".png" ; .jpg -or- .png
$MergeMode = 0 ;0 = Merge vertically (add on same line) / 1 = Merge horizontally (add on same colon)

$temp = 1 ;Mise en place de la configuration
$Ub = UBound($CmdLine)
While $temp < $Ub ;Paramètres passés en raccourcis
    Switch $CmdLine[$temp]
    Case "?", "/?", "-?", "--?", "h", "/h", "-h", "--h", "help", "/help", "-help", "--help"
        MsgBox(0+48,$Title,"Usage is:" & @CR & _
            @TAB & @ScriptName & "    F:\ull\path\to\ImageName1<.png|.jpg>    [F:\ull\path\to\ImageName2<.png|.jpg>    [F:\ull\path\to\MergedImageName<.png|.jpg>]]" & @CR & @CR & _
            "Size of MergedImage destination file will be on Vertically merged mode:" & @CR & _
            @TAB & "X Size = " & @TAB & "X ImageName1 size    +    X ImageName2" & @CR & _
            @TAB & "Y Size = " & @TAB & "Size Max [ Y ImageName1    ,    Y ImageName2]")
        Exit
    Case "s", "/s", "-s", "--s", "source", "/source", "-source", "--source", "o", "/o", "-o", "--o", "origine", "/origine", "-origine", "--origine"
        If $temp < $Ub - 1 Then
            $temp += 1
            $ImageName1 = $CmdLine[$temp]
        EndIf
        If $FirstPicName = 0 Then $FirstPicName = 1
    Case "a", "/a", "-a", "--a", "/alt", "-alt", "--alt", "/alternative", "-alternative", "--alternative"
        If $temp < $Ub - 1 Then
            $temp += 1
            $ImageName1 = $CmdLine[$temp]
        EndIf
        If $FirstPicName = 0 Then $FirstPicName = 2
    Case "d", "/d", "-d", "--d", "dest", "/dest", "-dest", "--dest", "destination", "/destination", "-destination", "--destination"
        If $temp < $Ub - 1 Then
            $temp += 1
            $ImageCompositeName = $CmdLine[$temp]
        EndIf
    Case "imagemode", "/imagemode", "-imagemode", "--imagemode", "mergeimagemode", "/mergeimagemode", "-mergeimagemode", "--mergeimagemode"
        If $temp < $Ub - 1 Then
            $temp += 1
            $MergeImageMode = $CmdLine[$temp]
        EndIf
    Case "extension", "mergeextension" ;etc / - --.
        If $temp < $Ub - 1 Then
            $temp += 1
            $MergeExtension = $CmdLine[$temp]
        EndIf
    Case "mode", "mergemode"
        If $temp < $Ub - 1 Then
            $temp += 1
            $MergeMode = $CmdLine[$temp]
        EndIf
    Case "firstpicname"
        If $temp < $Ub - 1 Then
            $temp += 1
            $FirstPicName = $CmdLine[$temp]
        EndIf
    Case "showmergeguiwindow"
        If $temp < $Ub - 1 Then
            $temp += 1
            $ShowMergeGUIWindow = $CmdLine[$temp]
        EndIf
    Case "stretchimagevertically"
        If $temp < $Ub - 1 Then
            $temp += 1
            $StrechImageVertically = $CmdLine[$temp]
        EndIf
    Case "stretchimagehorizontally"
        If $temp < $Ub - 1 Then
            $temp += 1
            $StrechImageHorizontally = $CmdLine[$temp]
        EndIf
    Case "centerimagevertically"
        If $temp < $Ub - 1 Then
            $temp += 1
            $CenterImageVertically = $CmdLine[$temp]
        EndIf
    Case "centerimagehorizontally"
        If $temp < $Ub - 1 Then
            $temp += 1
            $CenterImageHorizontally = $CmdLine[$temp]
        EndIf
    Case "showfinallymergedimage"
        If $temp < $Ub - 1 Then
            $temp += 1
            $ShowFinaleMergedImage = $CmdLine[$temp]
        EndIf
    Case "mergedimagebackgroundcolor"
        If $temp < $Ub - 1 Then
            $temp += 1
            $MergedImageBackgroundColor = $CmdLine[$temp]
        EndIf
    Case "w", "x", "sizex", "guisizex"
        If $temp < $Ub - 1 Then
            $temp += 1
            $GuiSizeX = $CmdLine[$temp]
        EndIf
    Case "h", "y", "sizey", "guisizey"
        If $temp < $Ub - 1 Then
            $temp += 1
            $GuiSizeY = $CmdLine[$temp]
        EndIf
    ;You shall keep at least one "" (blank) Case, in order to keep the Else Case safe.
    Case ""
;~         If $temp < $Ub - 1 Then
;~             $temp += 1
;~             $ = $CmdLine[$temp]
;~         EndIf
    Case Else
        If $ImageName1 = "" Then
            $ImageName1 = $CmdLine[$temp]
            If $FirstPicName = 0 Then $FirstPicName = 1
        ElseIf $ImageName2 = "" Then
            $ImageName2 = $CmdLine[$temp]
        ElseIf $ImageCompositeName = "" Then
            $ImageCompositeName = $CmdLine[$temp]
        EndIf
    EndSwitch
    $temp += 1
WEnd

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
$iX1 = _GDIPlus_ImageGetWidth($hImage1)
If $iX1 = 4294967295 Then $iX1 = 0 ;4294967295 en cas d'erreur, soit 32 bits à 1 (11111...1111111).
$iY1 = _GDIPlus_ImageGetHeight($hImage1)

; Load image 2
$hImage2 = _GDIPlus_ImageLoadFromFile($ImageName2)
$iX2 = _GDIPlus_ImageGetWidth($hImage2)
If $iX2 = 4294967295 Then $iX2 = 0 ;4294967295 en cas d'erreur, soit 32 bits à 1 (11111...1111111).
$iY2 = _GDIPlus_ImageGetHeight($hImage2)

; Define the Merged (Composite) image size
If $MergeMode = 0 Then ;Horizontally merge
    If $GuiSizeX = 0 Then $GuiSizeX = $iX1 + $iX2
    If $GuiSizeY = 0 Then
        If $iY1 > $iY2 then
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
    If $CenterImageVertically and Not $StrechImageVertically Then $VPos1 = ($GuiSizeY - $iY1)/2
    $VPos2 = 0
    $HPos2 = $XStrech1 ;/!\
    $XStrech2 = $iX2
    $YStrech2 = $iY2
    If $StrechImageVertically Then $YStrech2 = $GuiSizeY
    If $CenterImageVertically and Not $StrechImageVertically Then $VPos2 = ($GuiSizeY - $iY2)/2
Else ;Vertically merge
    If $GuiSizeY = 0 Then $GuiSizeY = $iY1 + $iY2
    If $GuiSizeX = 0 Then
        If $iX1 > $iX2 then
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
    If $CenterImageHorizontally and Not $StrechImageHorizontally Then $HPos1 = ($GuiSizeX - $iX1)/2
    $VPos2 = $YStrech1 ;/!\
    $HPos2 = 0
    $XStrech2 = $iX2
    $YStrech2 = $iY2
    If $StrechImageHorizontally Then $XStrech2 = $GuiSizeX
    If $CenterImageHorizontally and Not $StrechImageHorizontally Then $HPos2 = ($GuiSizeX - $iX2)/2
EndIf

; Initialise the Drawing windows/composite image...
$hGui = GUICreate("GDIPlus Example", $GuiSizeX, $GuiSizeY)
; Show drawing window ?
If $ShowMergeGUIWindow Then
    GUISetState()
    GUISetOnEvent(-3, "_Close")
EndIf

; Create Double Buffer, so the doesn't need to be repainted on PAINT-Event
$hGraphicGUI = _GDIPlus_GraphicsCreateFromHWND($hGui) ;Draw to this graphics, $hGraphicGUI, to display on GUI
$hBMPBuff = _GDIPlus_BitmapCreateFromGraphics($GuiSizeX, $GuiSizeY, $hGraphicGUI) ; $hBMPBuff is a bitmap in memory
$hGraphic = _GDIPlus_ImageGetGraphicsContext($hBMPBuff) ; Draw to this graphics, $hGraphic, being the graphics of $hBMPBuff

;Fill the Graphic Background (0x00000000 for transparent background in .png files)
_GDIPlus_GraphicsClear($hGraphic, $MergedImageBackgroundColor)

;Put the previously opened images together on the same Graphic and closing them
_GDIPlus_GraphicsDrawImageRectRect($hGraphic, $hImage1, 0, 0, $iX1, $iY1, $HPos1, $VPos1, $XStrech1, $YStrech1)
_GDIPlus_GraphicsDrawImageRectRect($hGraphic, $hImage2, 0, 0, $iX2, $iY2, $HPos2, $VPos2, $XStrech2, $YStrech2)
_GDIPlus_ImageDispose($hImage1)
_GDIPlus_ImageDispose($hImage2)

; Save composite image (need that previously opened images have been closed if self-merging a file)
Local $sNewName = $ImageCompositeName
_GDIPlus_ImageSaveToFile($hBMPBuff, $sNewName) ; $hBMPBuff the bitmap

; Show drawing window ?
If $ShowMergeGUIWindow Then
    _GDIPlus_GraphicsDrawImage($hGraphicGUI, $hBMPBuff, 0, 0) ; Draw bitmap, $hBMPBuff, to the GUI's graphics, $hGraphicGUI.
	If Not FileDelete($ImageName1) Then MsgBox(1, "erreur", "Impossible de supprimer ")
    Sleep($SleepTimeShowMergeGUIWindow) ; Wait $SleepTimeShowMergeGUIWindow ms, or press Esc.

EndIf

; Show result saved file ?
If $ShowFinaleMergedImage Then ShellExecute($sNewName)

_Quit()


Func _Close() ;Close the previously opened images, only called when gui window is manually closed
    _GDIPlus_ImageDispose($hImage1)
    _GDIPlus_ImageDispose($hImage2)
    _Quit()
EndFunc

Func _Quit()
    _GDIPlus_GraphicsDispose($hGraphic)
    _GDIPlus_GraphicsDispose($hGraphicGUI)
    _WinAPI_DeleteObject($hBMPBuff)
    _GDIPlus_Shutdown()
    Exit
EndFunc     ;==>_Quit


; -----------------------------------8<-----------------------------------
#comments-start
Global $IniFile = StringTrimRight(@ScriptFullPath, 4) & ".ini"
;;This is the content of the original IniFile;;
[Config]

MergedImageBackgroundColor= 0xFF000000
    #~ 0x00...... : Specify 00 on first "digits" for transparent color (.png only !), all other values (......) will be ignored.
    #~ 0xFFRRGGBB : RGB : RR=red color level / GG=green color level / BB=blue color level
    #~ 0xFFFFFFFF : white
    #~ 0xFF000000 : black
    #~ 0xFF0000FF : blue

CenterImageVertically = True
StrechImageVertically = False

ShowFinaleMergedImage = true

#~ -----------------------------------8<-----------------------------------
#~ For Debug only (you should not touch this !):
[Debug]
ShowMergeGUIWindow= False
SleepTimeShowMergeGUIWindow     = 2000
;;End of the original content of the IniFile;;
#comments-end
; -----------------------------------8<-----------------------------------

; -----------------------------------8<-----------------------------------
; Fill Graphics zone in black color : _GDIPlus_GraphicsClear($hGraphic)
; Fill Graphics zone in white color : _GDIPlus_GraphicsClear($hGraphic, 0xFFFFFFFF)
; Fill Graphics zone in transparent : <nothing if Merged ImageExt is .png, default back color if Merged ImageExt is .jpg>
; _GDIPlus_GraphicsClear($hGraphic, $MergedImageBackgroundColor)
; -----------------------------------8<-----------------------------------

; -----------------------------------8<-----------------------------------
;~ ; Merge 2 images (default)
;~ _GDIPlus_GraphicsDrawImageRectRect($hGraphic, $hImage1, 0, 0, $iX1, $iY1,    0, 0, $iX1, $iY1)
;~ _GDIPlus_GraphicsDrawImageRectRect($hGraphic, $hImage2, 0, 0, $iX2, $iY2, $iX1, 0, $iX2, $iY2)


; Image 2 is VCentered
;~ _GDIPlus_GraphicsDrawImageRectRect($hGraphic, $hImage1, 0, 0, $iX1, $iY1,    0, 0, $iX1, $iY1)
;~ _GDIPlus_GraphicsDrawImageRectRect($hGraphic, $hImage2, 0, 0, $iX2, $iY2, $iX1, ($iY1-$iY2)/2, $iX2, $iY2)


; VCenter both images
;~ $VPos = 0
;~ If $CenterImageVertically Then $VPos = ($GuiSizeY - $iY1)/2
;~ _GDIPlus_GraphicsDrawImageRectRect($hGraphic, $hImage1, 0, 0, $iX1, $iY1,    0, $VPos, $iX1, $iY1)
;~ If $CenterImageVertically Then $VPos = ($GuiSizeY - $iY2)/2
;~ _GDIPlus_GraphicsDrawImageRectRect($hGraphic, $hImage2, 0, 0, $iX2, $iY2, $iX1, $VPos, $iX2, $iY2)

;~ Vertical Strech
;~ $YStrech = $iY1
;~ If $StrechImageVertically Then $YStrech = $GuiSizeY
;~ _GDIPlus_GraphicsDrawImageRectRect($hGraphic, $hImage1, 0, 0, $iX1, $iY1,    0, 0, $iX1, $YStrech)
;~ $YStrech = $iY2
;~ If $StrechImageVertically Then $YStrech = $GuiSizeY
;~ _GDIPlus_GraphicsDrawImageRectRect($hGraphic, $hImage2, 0, 0, $iX2, $iY2, $iX1, 0, $iX2, $YStrech)
; -----------------------------------8<-----------------------------------

; -----------------------------------8<-----------------------------------
;Func to auto-redraw on Windows internal PAINT messages.
Func MY_PAINT($hWnd, $msg, $wParam, $lParam)
    _GDIPlus_GraphicsDrawImage($hGraphicGUI, $hBMPBuff, 0, 0)
    ;_WinAPI_RedrawWindow($hGui, "", "", BitOR($RDW_INVALIDATE, $RDW_UPDATENOW, $RDW_FRAME)) ; , $RDW_ALLCHILDREN
    Return $GUI_RUNDEFMSG
EndFunc     ;==>MY_PAINT
; -----------------------------------8<-----------------------------------