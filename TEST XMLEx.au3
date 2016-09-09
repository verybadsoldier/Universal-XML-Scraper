#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w- 4 -w 5 -w 6 -w 7
#Tidy_Parameters=/sort_funcs /reel

Global $iVerboseLVL = 2

#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>
#include <File.au3>
#include <String.au3>
#include <array.au3>
#include <date.au3>
#include <InetConstants.au3>
#include "./Include/_XML.au3"
#include "./Include/_MyFunction.au3"


Local $XML_Path = "C:\Developpement\Github\Universal-XML-Scraper\Scrape_Profil\Screenscraper-RecalboxV4.xml"
Local $sXPath = "Profil/Element/Source_Type"
Local $sXPath_Attr = "Profil"
Local $sXPath_Attr_Name = "Name"
Local $URL = "http://www.screenscraper.fr/api/jeuInfos.php?devid=xxx&devpassword=yyy&softname=zzz&output=xml&crc=50ABC90A&systemeid=1&romtype=rom&romnom=Sonic%20The%20Hedgehog%202%20(World).zip&romtaille=749652"
Local $XML_Path_API = "C:\Developpement\Github\Universal-XML-Scraper\API.xml"
Local $XML_Path_DEST = "C:\Developpement\Github\Universal-XML-Scraper\TEST.xml"
Local $RechMultiLang = StringSplit('us|en|origine|eu|es|fr|de|pt|jp|xx', "|")
Local $ROM_NAME = "Sonic The Hedgehog 2 (World).zip"
Local $Local_Rom_Path = "C:\Local_Rom_Path\" & $ROM_NAME
Local $XML_Rom_Path = "./XML_Rom_Path/" & $ROM_NAME
Local $Local_Path_File = "C:\Local_Path_File\"
Local $XML_Path_File = "./XML_Path_File/"


_CREATION_LOG()

FileDelete($XML_Path_API)
_DownloadWRetry($URL, $XML_Path_API)

; first you must create $oXmlDoc object
Local $oXMLDoc = _XML_CreateDOMDocument()
_XML_Load($oXMLDoc, $XML_Path)
_XML_TIDY($oXMLDoc)
If @error Then _LOG('_XML_TIDY @error: ' & XML_My_ErrorParser(@error))

Local $Value = _XML_GetValue($oXMLDoc, $sXPath)
Local $Nb_Element = $Value[0]

Local $A_Element[1][7]
Local $Source_Type, $Target_Type, $Element, $Element_Champ0, $Element_Champ1, $Element_Champ2, $Element_Champ3Mod, $Element_Champ3, $Element_Champ4, $Element_Champ5, $Element_Champ6

For $B_Element = 1 To $Nb_Element
	$Element_Champ0 = ""
	$Element_Champ1 = ""
	$Element_Champ2 = ""
	$Element_Champ3 = ""
	$Element_Champ4 = ""
	$Element_Champ5 = ""
	$Element_Champ6 = ""
	_LOG("Elements :" & $B_Element & "/" & $Nb_Element)
;~ 	$Element_Champ0 = _XML_GetValue_TEMP($oXMLDoc, "Profil/Element[" & $B_Element & "]/Target_Value")
	$Element_Champ0 = _XML_Read("Profil/Element[" & $B_Element & "]/Target_Value", 0, "", $oXMLDoc)
;~ 	$Element_Champ1 = _XML_GetValue_TEMP($oXMLDoc, "Profil/Element[" & $B_Element & "]/Target_Type")
	$Element_Champ1 = _XML_Read("Profil/Element[" & $B_Element & "]/Target_Type", 0, "", $oXMLDoc)
	Switch $Element_Champ1
		Case "XML_Attribute"
;~ 			$Element_Champ2 = _XML_GetValue_TEMP($oXMLDoc, "Profil/Element[" & $B_Element & "]/Target_Attribute_Name")
			$Element_Champ2 = _XML_Read("Profil/Element[" & $B_Element & "]/Target_Attribute_Name", 0, "", $oXMLDoc)
		Case "XML_Path"
;~ 			$Element_Champ2 = _XML_GetValue_TEMP($oXMLDoc, "Profil/Element[" & $B_Element & "]/Target_Path_Type")
			$Element_Champ2 = _XML_Read("Profil/Element[" & $B_Element & "]/Target_Path_Type", 0, "", $oXMLDoc)
		Case " XML_Value_FORMAT"
;~ 			$Element_Champ2 = _XML_GetValue_TEMP($oXMLDoc, "Profil/Element[" & $B_Element & "]/Target_FORMAT")
			$Element_Champ2 = _XML_Read("Profil/Element[" & $B_Element & "]/Target_FORMAT", 0, "", $oXMLDoc)
	EndSwitch
;~ 	$Element_Champ3 = _XML_GetValue_TEMP($oXMLDoc, "Profil/Element[" & $B_Element & "]/Source_Value")
	$Element_Champ3 = _XML_Read("Profil/Element[" & $B_Element & "]/Source_Value", 0, "", $oXMLDoc)
;~ 	$Element_Champ4 = _XML_GetValue_TEMP($oXMLDoc, "Profil/Element[" & $B_Element & "]/Source_Type")
	$Element_Champ4 = _XML_Read("Profil/Element[" & $B_Element & "]/Source_Type", 0, "", $oXMLDoc)
	Switch $Element_Champ4
		Case "XML_Attribute"
;~ 			$Element_Champ5 = _XML_GetValue_TEMP($oXMLDoc, "Profil/Element[" & $B_Element & "]/Source_Attribute_Name")
			$Element_Champ5 = _XML_Read("Profil/Element[" & $B_Element & "]/Source_Attribute_Name", 0, "", $oXMLDoc)
		Case "XML_Download"
;~ 			$Element_Champ5 = _XML_GetValue_TEMP($oXMLDoc, "Profil/Element[" & $B_Element & "]/Source_Download_Path")
			$Element_Champ5 = _XML_Read("Profil/Element[" & $B_Element & "]/Source_Download_Path", 0, "", $oXMLDoc)
;~ 			$Element_Champ5 = $Element_Champ5 & "¤¤" & _XML_GetValue_TEMP($oXMLDoc, "Profil/Element[" & $B_Element & "]/Source_Download_Tag")
			$Element_Champ5 = $Element_Champ5 & "¤¤" & _XML_Read("Profil/Element[" & $B_Element & "]/Source_Download_Tag", 0, "", $oXMLDoc)
	EndSwitch
	If StringInStr($Element_Champ3, "%LANG%") Then
		For $B_RechMultiLang = 1 To UBound($RechMultiLang) - 1
			$Element_Champ3Mod = StringReplace($Element_Champ3, '%LANG%', $RechMultiLang[$B_RechMultiLang])
			_ArrayAdd($A_Element, $Element_Champ0 & "|" & $Element_Champ1 & "|" & $Element_Champ2 & "|" & $Element_Champ3Mod & "|" & $Element_Champ4& "|" & $Element_Champ5)
		Next
	Else
		_ArrayAdd($A_Element, $Element_Champ0 & "|" & $Element_Champ1 & "|" & $Element_Champ2 & "|" & $Element_Champ3 & "|" & $Element_Champ4& "|" & $Element_Champ5)
	EndIf
;~ 	_ArrayDisplay($A_Element, "$A_Element")
Next
$A_Element[0][0] = UBound($A_Element) - 1
_ArrayDisplay($A_Element, "$A_Element")

Local $oXMLAPI = _XML_CreateDOMDocument()
_XML_Load($oXMLAPI, $XML_Path_API)
_XML_TIDY($oXMLAPI)
If @error Then MsgBox(0, '_XML_TIDY @error:', XML_My_ErrorParser(@error))

$B_Element = 0
While 1
	$B_Element = $B_Element + 1
	_LOG("Elements :" & $B_Element & "/" & UBound($A_Element) - 1)
	If $B_Element > UBound($A_Element) - 1 Then ExitLoop
	If $B_Element - 1 > 0 And $A_Element[$B_Element - 1][0] = $A_Element[$B_Element][0] And $A_Element[$B_Element - 1][2] = $A_Element[$B_Element][2] And $A_Element[$B_Element - 1][6] <> "" Then
		_LOG("DELETING : " & $A_Element[$B_Element][2],2)
		_ArrayDelete($A_Element, $B_Element)
		$B_Element = $B_Element - 1
	Else
		Switch $A_Element[$B_Element][4]
			Case "XML_Value"
;~ 				$Element = _XML_GetValue($oXMLAPI, $A_Element[$B_Element][3])
;~ 				If IsArray($Element) Then $A_Element[$B_Element][6] = $Element[1]
				$Element = _XML_Read($A_Element[$B_Element][3], 0, "", $oXMLAPI)
				If $Element <> -1 Then $A_Element[$B_Element][6] = $Element
			Case "XML_Attribute"
;~ 				Local $oNode = _XML_SelectSingleNode($oXMLDoc, $A_Element[$B_Element][3])
;~ 				$A_Element[$B_Element][6] = _XML_GetNodeAttributeValue($oNode, $A_Element[$B_Element][4])
				$A_Element[$B_Element][6] = _XML_Read($A_Element[$B_Element][4] &'/'& $A_Element[$B_Element][3] , 1, "", $oXMLAPI)
			Case "XML_Download"
				Local $XML_Download_Info = StringSplit($A_Element[$B_Element][5], "¤¤")
				Switch $XML_Download_Info[0]
					Case "%Local_Path_File%"
						$A_Element[$B_Element][6] = $Local_Path_File
				EndSwitch
			Case "Fixe_Value"
			Case "Variable_Value"
		EndSwitch
		Switch $A_Element[$B_Element][1]
			Case "XML_Value"
			Case "XML_Attribute"
			Case "XML_Path"
			Case "XML_Value_FORMAT"
		EndSwitch
	EndIf
WEnd
_ArrayDisplay($A_Element, "$A_Element")


