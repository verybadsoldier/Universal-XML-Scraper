#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w- 4 -w 5 -w 6 -w 7
#Tidy_Parameters=/sort_funcs /reel

#include <array.au3>
#include <date.au3>
#include <MsgBoxConstants.au3>
#include "./Include/_XML.au3"

; This COM Error Hanlder will be used globally (excepting inside UDF Functions)
Global $oErrorHandler = ObjEvent("AutoIt.Error", ErrFunc_CustomUserHandler_MAIN)
#forceref $oErrorHandler

; This is SetUp for the transfer UDF internal COM Error Handler to the user function
_XML_ComErrorHandler_UserFunction(ErrFunc_CustomUserHandler_XML)

Local $XML_Path = "C:\Developpement\Github\Universal-XML-Scraper\Scrape_Profil\Screenscraper-RecalboxV4.xml"
Local $sXPath = "Profil/Element/Source_Type"
Local $sXPath_Attr = "Profil"
Local $sXPath_Attr_Name = "Name"
Local $XML_Path_API = "C:\Developpement\Github\Universal-XML-Scraper\API.xml"
Local $RechMultiLang = StringSplit('us|en|origine|eu|es|fr|de|pt|jp|xx', "|")
Local $ROM_NAME = "Sonic The Hedgehog 2 (World).zip"
Local $Local_Rom_Path = "C:\Local_Rom_Path\" & $ROM_NAME
Local $XML_Rom_Path = "./XML_Rom_Path/" & $ROM_NAME
Local $Local_Path_File = "C:\Local_Path_File\"
Local $XML_Path_File = "./XML_Path_File/"


;~ Local $oErrorHandler = ObjEvent("AutoIt.Error", "_ErrFunc_CustomUserHandler")
#forceref $oErrorHandler

; first you must create $oXmlDoc object
Local $oXMLDoc = _XML_CreateDOMDocument()
_XML_Load($oXMLDoc, $XML_Path)
_XML_TIDY($oXMLDoc)
If @error Then MsgBox(0, '_XML_TIDY @error:', XML_My_ErrorParser(@error))

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
	ConsoleWrite("> Elements :" & $B_Element & "/" & $Nb_Element & @CRLF)
	$Element_Champ0 = _XML_GetValue_TEMP($oXMLDoc, "Profil/Element[" & $B_Element & "]/Target_Value")
	$Element_Champ1 = _XML_GetValue_TEMP($oXMLDoc, "Profil/Element[" & $B_Element & "]/Target_Type")
	Switch $Element_Champ1
		Case "XML_Attribute"
			$Element_Champ2 = _XML_GetValue_TEMP($oXMLDoc, "Profil/Element[" & $B_Element & "]/Target_Attribute_Name")
		Case "XML_Path"
			$Element_Champ2 = _XML_GetValue_TEMP($oXMLDoc, "Profil/Element[" & $B_Element & "]/Target_Path_Type")
		Case " XML_Value_FORMAT"
			$Element_Champ2 = _XML_GetValue_TEMP($oXMLDoc, "Profil/Element[" & $B_Element & "]/Target_FORMAT")
	EndSwitch
	ConsoleWrite("!--" & $Element_Champ1 & ":")
	ConsoleWrite($Element_Champ0 & @CRLF)
	$Element_Champ3 = _XML_GetValue_TEMP($oXMLDoc, "Profil/Element[" & $B_Element & "]/Source_Value")
	$Element_Champ4 = _XML_GetValue_TEMP($oXMLDoc, "Profil/Element[" & $B_Element & "]/Source_Type")
	Switch $Element_Champ4
		Case "XML_Attribute"
			$Element_Champ5 = _XML_GetValue_TEMP($oXMLDoc, "Profil/Element[" & $B_Element & "]/Source_Attribute_Name")
		Case "XML_Download"
			$Element_Champ5 = _XML_GetValue_TEMP($oXMLDoc, "Profil/Element[" & $B_Element & "]/Source_Download_Path")
			$Element_Champ5 = $Element_Champ5 & "¤¤" & _XML_GetValue_TEMP($oXMLDoc, "Profil/Element[" & $B_Element & "]/Source_Download_Tag")
	EndSwitch
	ConsoleWrite("!--" & $Element_Champ3 & ":")
	ConsoleWrite($Element_Champ3 & @CRLF)
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
	ConsoleWrite("> Elements :" & $B_Element & "/" & UBound($A_Element) - 1 & @CRLF)
	If $B_Element > UBound($A_Element) - 1 Then ExitLoop
	If $B_Element - 1 > 0 And $A_Element[$B_Element - 1][0] = $A_Element[$B_Element][0] And $A_Element[$B_Element - 1][2] = $A_Element[$B_Element][2] And $A_Element[$B_Element - 1][6] <> "" Then
		ConsoleWrite("! DELETING : " & $A_Element[$B_Element][2] & @CRLF)
		_ArrayDelete($A_Element, $B_Element)
		$B_Element = $B_Element - 1
	Else
		Switch $A_Element[$B_Element][4]
			Case "XML_Value"
				ConsoleWrite("+--" & $A_Element[$B_Element][3] & ":")
				$Element = _XML_GetValue($oXMLAPI, $A_Element[$B_Element][3])
				If IsArray($Element) Then $A_Element[$B_Element][6] = $Element[1]
				ConsoleWrite($A_Element[$B_Element][6] & @CRLF)
			Case "XML_Attribute"
				ConsoleWrite("+--" & $A_Element[$B_Element][3] & "("&$A_Element[$B_Element][4]&") :")
				Local $oNode = _XML_SelectSingleNode($oXMLDoc, $A_Element[$B_Element][3])
				$A_Element[$B_Element][6] = _XML_GetNodeAttributeValue($oNode, $A_Element[$B_Element][4])
				ConsoleWrite($A_Element[$B_Element][6] & @CRLF)
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

Func _XML_GetValue_TEMP($oXmlDoc, $sXPath)
	Local $TEMP = _XML_GetValue($oXmlDoc, $sXPath)
	If IsArray($TEMP) Then Return $TEMP[1]
	Return ""
EndFunc

#Region XMLWrapperEx__Examples.au3 - XML DOM Error/Event Handling

Func ErrFunc_CustomUserHandler_MAIN($oError)

	ConsoleWrite(@ScriptName & " (" & $oError.scriptline & ") : MainScript ==> COM Error intercepted !" & @CRLF & _
			@TAB & "err.number is: " & @TAB & @TAB & "0x" & Hex($oError.number) & @CRLF & _
			@TAB & "err.windescription:" & @TAB & $oError.windescription & @CRLF & _
			@TAB & "err.description is: " & @TAB & $oError.description & @CRLF & _
			@TAB & "err.source is: " & @TAB & @TAB & $oError.source & @CRLF & _
			@TAB & "err.helpfile is: " & @TAB & $oError.helpfile & @CRLF & _
			@TAB & "err.helpcontext is: " & @TAB & $oError.helpcontext & @CRLF & _
			@TAB & "err.lastdllerror is: " & @TAB & $oError.lastdllerror & @CRLF & _
			@TAB & "err.scriptline is: " & @TAB & $oError.scriptline & @CRLF & _
			@TAB & "err.retcode is: " & @TAB & "0x" & Hex($oError.retcode) & @CRLF & @CRLF)
EndFunc   ;==>ErrFunc_CustomUserHandler_MAIN

Func ErrFunc_CustomUserHandler_XML($oError)

	; here is declared another path to UDF au3 file
	; thanks to this with using _XML_ComErrorHandler_UserFunction(ErrFunc_CustomUserHandler_XML)
	;  you get errors which after pressing F4 in SciTE4AutoIt you goes directly to the specified UDF Error Line
	ConsoleWrite(@ScriptDir & '\XMLWrapperEx.au3' & " (" & $oError.scriptline & ") : UDF ==> COM Error intercepted ! " & @CRLF & _
			@TAB & "err.number is: " & @TAB & @TAB & "0x" & Hex($oError.number) & @CRLF & _
			@TAB & "err.windescription:" & @TAB & $oError.windescription & @CRLF & _
			@TAB & "err.description is: " & @TAB & $oError.description & @CRLF & _
			@TAB & "err.source is: " & @TAB & @TAB & $oError.source & @CRLF & _
			@TAB & "err.helpfile is: " & @TAB & $oError.helpfile & @CRLF & _
			@TAB & "err.helpcontext is: " & @TAB & $oError.helpcontext & @CRLF & _
			@TAB & "err.lastdllerror is: " & @TAB & $oError.lastdllerror & @CRLF & _
			@TAB & "err.scriptline is: " & @TAB & $oError.scriptline & @CRLF & _
			@TAB & "err.retcode is: " & @TAB & "0x" & Hex($oError.retcode) & @CRLF & @CRLF)
EndFunc   ;==>ErrFunc_CustomUserHandler_XML

Func XML_DOM_EVENT_ondataavailable()
	#CS
		ondataavailable Event
		https://msdn.microsoft.com/en-us/library/ms754530(v=vs.85).aspx
	#CE
	Local $oEventObj = @COM_EventObj
	ConsoleWrite('@COM_EventObj = ' & ObjName($oEventObj, 3) & @CRLF)

	Local $sMessage = 'XML_DOM_EVENT_ fired "ondataavailable"' & @CRLF
	ConsoleWrite($sMessage)
EndFunc   ;==>XML_DOM_EVENT_ondataavailable

Func XML_DOM_EVENT_onreadystatechange()
	#CS
		onreadystatechange Event
		https://msdn.microsoft.com/en-us/library/ms759186(v=vs.85).aspx
	#CE
	Local $oEventObj = @COM_EventObj
	ConsoleWrite('@COM_EventObj = ' & ObjName($oEventObj, 3) & @CRLF)

	Local $sMessage = 'XML_DOM_EVENT_ fired "onreadystatechange" : ReadyState = ' & $oEventObj.ReadyState & @CRLF
	ConsoleWrite($sMessage)

EndFunc   ;==>XML_DOM_EVENT_onreadystatechange

Func XML_DOM_EVENT_ontransformnode($oNodeCode_XSL, $oNodeData_XML, $bBool)
	#forceref $oNodeCode_XSL, $oNodeData_XML, $bBool
	#CS
		ontransformnode Event
		https://msdn.microsoft.com/en-us/library/ms767521(v=vs.85).aspx
	#CE
	Local $oEventObj = @COM_EventObj
	ConsoleWrite('@COM_EventObj = ' & ObjName($oEventObj, 3) & @CRLF)

	Local $sMessage = 'XML_DOM_EVENT_ fired "ontransformnode"' & @CRLF
	ConsoleWrite($sMessage)

EndFunc   ;==>XML_DOM_EVENT_ontransformnode

; #FUNCTION# ====================================================================================================================
; Name ..........: XML_My_ErrorParser
; Description ...: Changing $XML_ERR_ ... to human readable description
; Syntax ........: XML_My_ErrorParser($iXMLWrapper_Error, $iXMLWrapper_Extended)
; Parameters ....: $iXMLWrapper_Error	- an integer value.
;                  $iXMLWrapper_Extended           - an integer value.
; Return values .: description as string
; Author ........: mLipok
; Modified ......:
; Remarks .......: This function is only example of how user can parse @error and @extended to human readable description
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func XML_My_ErrorParser($iXMLWrapper_Error, $iXMLWrapper_Extended = 0)
	Local $sErrorInfo = ''
	Switch $iXMLWrapper_Error
		Case $XML_ERR_OK
			$sErrorInfo = '$XML_ERR_OK=' & $XML_ERR_OK & @CRLF & 'All is ok.'
		Case $XML_ERR_GENERAL
			$sErrorInfo = '$XML_ERR_GENERAL=' & $XML_ERR_GENERAL & @CRLF & 'The error which is not specifically defined.'
		Case $XML_ERR_COMERROR
			$sErrorInfo = '$XML_ERR_COMERROR=' & $XML_ERR_COMERROR & @CRLF & 'COM ERROR OCCURED. Check @extended and your own error handler function for details.'
		Case $XML_ERR_ISNOTOBJECT
			$sErrorInfo = '$XML_ERR_ISNOTOBJECT=' & $XML_ERR_ISNOTOBJECT & @CRLF & 'No object passed to function'
		Case $XML_ERR_INVALIDDOMDOC
			$sErrorInfo = '$XML_ERR_INVALIDDOMDOC=' & $XML_ERR_INVALIDDOMDOC & @CRLF & 'Invalid object passed to function'
		Case $XML_ERR_INVALIDATTRIB
			$sErrorInfo = '$XML_ERR_INVALIDATTRIB=' & $XML_ERR_INVALIDATTRIB & @CRLF & 'Invalid object passed to function.'
		Case $XML_ERR_INVALIDNODETYPE
			$sErrorInfo = '$XML_ERR_INVALIDNODETYPE=' & $XML_ERR_INVALIDNODETYPE & @CRLF & 'Invalid object passed to function.'
		Case $XML_ERR_OBJCREATE
			$sErrorInfo = '$XML_ERR_OBJCREATE=' & $XML_ERR_OBJCREATE & @CRLF & 'Object can not be created.'
		Case $XML_ERR_NODECREATE
			$sErrorInfo = '$XML_ERR_NODECREATE=' & $XML_ERR_NODECREATE & @CRLF & 'Can not create Node - check also COM Error Handler'
		Case $XML_ERR_NODEAPPEND
			$sErrorInfo = '$XML_ERR_NODEAPPEND=' & $XML_ERR_NODEAPPEND & @CRLF & 'Can not append Node - check also COM Error Handler'
		Case $XML_ERR_PARSE
			$sErrorInfo = '$XML_ERR_PARSE=' & $XML_ERR_PARSE & @CRLF & 'Error: with Parsing objects, .parseError.errorCode=' & $iXMLWrapper_Extended & ' Use _XML_ErrorParser_GetDescription() for get details.'
		Case $XML_ERR_PARSE_XSL
			$sErrorInfo = '$XML_ERR_PARSE_XSL=' & $XML_ERR_PARSE_XSL & @CRLF & 'Error with Parsing XSL objects .parseError.errorCode=' & $iXMLWrapper_Extended & ' Use _XML_ErrorParser_GetDescription() for get details.'
		Case $XML_ERR_LOAD
			$sErrorInfo = '$XML_ERR_LOAD=' & $XML_ERR_LOAD & @CRLF & 'Error opening specified file.'
		Case $XML_ERR_SAVE
			$sErrorInfo = '$XML_ERR_SAVE=' & $XML_ERR_SAVE & @CRLF & 'Error saving file.'
		Case $XML_ERR_PARAMETER
			$sErrorInfo = '$XML_ERR_PARAMETER=' & $XML_ERR_PARAMETER & @CRLF & 'Wrong parameter passed to function.'
		Case $XML_ERR_ARRAY
			$sErrorInfo = '$XML_ERR_ARRAY=' & $XML_ERR_ARRAY & @CRLF & 'Wrong array parameter passed to function. Check array dimension and conent.'
		Case $XML_ERR_XPATH
			$sErrorInfo = '$XML_ERR_XPATH=' & $XML_ERR_XPATH & @CRLF & 'XPath syntax error - check also COM Error Handler.'
		Case $XML_ERR_NONODESMATCH
			$sErrorInfo = '$XML_ERR_NONODESMATCH=' & $XML_ERR_NONODESMATCH & @CRLF & 'No nodes match the XPath expression'
		Case $XML_ERR_NOCHILDMATCH
			$sErrorInfo = '$XML_ERR_NOCHILDMATCH=' & $XML_ERR_NOCHILDMATCH & @CRLF & 'There is no Child in nodes matched by XPath expression.'
		Case $XML_ERR_NOATTRMATCH
			$sErrorInfo = '$XML_ERR_NOATTRMATCH=' & $XML_ERR_NOATTRMATCH & @CRLF & 'There is no such attribute in selected node.'
		Case $XML_ERR_DOMVERSION
			$sErrorInfo = '$XML_ERR_DOMVERSION=' & $XML_ERR_DOMVERSION & @CRLF & 'DOM Version: ' & 'MSXML Version ' & $iXMLWrapper_Extended & ' or greater required for this function'
		Case $XML_ERR_EMPTYCOLLECTION
			$sErrorInfo = '$XML_ERR_EMPTYCOLLECTION=' & $XML_ERR_EMPTYCOLLECTION & @CRLF & 'Collections of objects was empty'
		Case $XML_ERR_EMPTYOBJECT
			$sErrorInfo = '$XML_ERR_EMPTYOBJECT=' & $XML_ERR_EMPTYOBJECT & @CRLF & 'Object is empty'
		Case Else
			$sErrorInfo = '=' & $iXMLWrapper_Error & @CRLF & 'NO ERROR DESCRIPTION FOR THIS @error'
	EndSwitch

	Local $sExtendedInfo = ''
	Switch $iXMLWrapper_Error
		Case $XML_ERR_COMERROR, $XML_ERR_NODEAPPEND, $XML_ERR_NODECREATE
			$sExtendedInfo = 'COM ERROR NUMBER (@error returned via @extended) =' & $iXMLWrapper_Extended
		Case $XML_ERR_PARAMETER
			$sExtendedInfo = 'This @error was fired by parameter: #' & $iXMLWrapper_Extended
		Case Else
			Switch $iXMLWrapper_Extended
				Case $XML_EXT_DEFAULT
					$sExtendedInfo = '$XML_EXT_DEFAULT=' & $XML_EXT_DEFAULT & @CRLF & 'Default - Do not return any additional information'
				Case $XML_EXT_XMLDOM
					$sExtendedInfo = '$XML_EXT_XMLDOM=' & $XML_EXT_XMLDOM & @CRLF & '"Microsoft.XMLDOM" related Error'
				Case $XML_EXT_DOMDOCUMENT
					$sExtendedInfo = '$XML_EXT_DOMDOCUMENT=' & $XML_EXT_DOMDOCUMENT & @CRLF & '"Msxml2.DOMDocument" related Error'
				Case $XML_EXT_XSLTEMPLATE
					$sExtendedInfo = '$XML_EXT_XSLTEMPLATE=' & $XML_EXT_XSLTEMPLATE & @CRLF & '"Msxml2.XSLTemplate" related Error'
				Case $XML_EXT_SAXXMLREADER
					$sExtendedInfo = '$XML_EXT_SAXXMLREADER=' & $XML_EXT_SAXXMLREADER & @CRLF & '"MSXML2.SAXXMLReader" related Error'
				Case $XML_EXT_MXXMLWRITER
					$sExtendedInfo = '$XML_EXT_MXXMLWRITER=' & $XML_EXT_MXXMLWRITER & @CRLF & '"MSXML2.MXXMLWriter" related Error'
				Case $XML_EXT_FREETHREADEDDOMDOCUMENT
					$sExtendedInfo = '$XML_EXT_FREETHREADEDDOMDOCUMENT=' & $XML_EXT_FREETHREADEDDOMDOCUMENT & @CRLF & '"Msxml2.FreeThreadedDOMDocument" related Error'
				Case $XML_EXT_XMLSCHEMACACHE
					$sExtendedInfo = '$XML_EXT_XMLSCHEMACACHE=' & $XML_EXT_XMLSCHEMACACHE & @CRLF & '"Msxml2.XMLSchemaCache." related Error'
				Case $XML_EXT_STREAM
					$sExtendedInfo = '$XML_EXT_STREAM=' & $XML_EXT_STREAM & @CRLF & '"ADODB.STREAM" related Error'
				Case $XML_EXT_ENCODING
					$sExtendedInfo = '$XML_EXT_ENCODING=' & $XML_EXT_ENCODING & @CRLF & 'Encoding related Error'
				Case Else
					$sExtendedInfo = '$iXMLWrapper_Extended=' & $iXMLWrapper_Extended & @CRLF & 'NO ERROR DESCRIPTION FOR THIS @extened'
			EndSwitch
	EndSwitch
	; return back @error and @extended for further debuging
	Return SetError($iXMLWrapper_Error, $iXMLWrapper_Extended, _
			'@error description:' & @CRLF & _
			$sErrorInfo & @CRLF & _
			@CRLF & _
			'@extended description:' & @CRLF & _
			$sExtendedInfo & @CRLF & _
			'')

EndFunc   ;==>XML_My_ErrorParser
#EndRegion XMLWrapperEx__Examples.au3 - XML DOM Error/Event Handling
