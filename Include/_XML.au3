$__iLineNumber=0
#include-once
;~ #include <XMLConstants.au3>
#include <FileConstants.au3>
#include <StringConstants.au3>
#include <AutoItConstants.au3>
#include "ADO_CONSTANTS.au3"

#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w- 4 -w 5 -w 6 -w 7
#Tidy_Parameters=/sort_funcs /reel

#Region XML.au3 - UDF Header
; #INDEX# =======================================================================================================================
; Title .........: XML.au3
; AutoIt Version : 3.3.10.2++
; Language ......: English
; Description ...: Functions to use for reading and writing XML using msxml. (UDF based on XMLWrapper.au3)
; Remarks .......: BETA Version
; Author(s) .....: mLipok, Eltorro, Weaponx, drlava, Lukasz Suleja, oblique, Mike Rerick, Tom Hohmann, guinness, GMK
; Version .......: "1.1.1.10" ; _XML_MiscProperty_UDFVersion()

#CS
	$__iLineNumber=22 & ' - This UDF is created on the basis of:•./Include/_XML.au3'
	This UDF is created on the basis of:
	$__iLineNumber=23 & ' - https://www.autoitscript.com/forum/topic/19848-xml-dom-wrapp ...•./Include/_XML.au3'
	https://www.autoitscript.com/forum/topic/19848-xml-dom-wrapper-com/
	$__iLineNumber=24 & ' - For this reason, I attach also the last known (to me) previo ...•./Include/_XML.au3'
	For this reason, I attach also the last known (to me) previous version ($_XMLUDFVER = "1.0.3.98"  _XMLDomWrapper_1.0.3.98_CN.au3 )
	$__iLineNumber=25 & ' - For the same reason I continue to recognize the achievements ...•./Include/_XML.au3'
	For the same reason I continue to recognize the achievements of the work of my predecessors (they are still noted in each Function header).
	$__iLineNumber=26 & ' - .•./Include/_XML.au3'
	.
	$__iLineNumber=27 & ' - .•./Include/_XML.au3'
	.
	$__iLineNumber=28 & ' - .•./Include/_XML.au3'
	.
	$__iLineNumber=29 & ' - . !!!!!!!!! This is BETA VERSION (all could be changed) !!!! ...•./Include/_XML.au3'
	. !!!!!!!!! This is BETA VERSION (all could be changed) !!!!!!!!!
	$__iLineNumber=30 & ' - .•./Include/_XML.au3'
	.
	$__iLineNumber=31 & ' - .•./Include/_XML.au3'
	.
	$__iLineNumber=32 & ' - .•./Include/_XML.au3'
	.
	$__iLineNumber=33 & ' - WORK IN PROGRESS INFORMATION:•./Include/_XML.au3'
	WORK IN PROGRESS INFORMATION:
	$__iLineNumber=34 & ' - . For now 2015-09-01 the descripion (Function Header) can no ...•./Include/_XML.au3'
	. For now 2015-09-01 the descripion (Function Header) can not entirely correctly describe the function.
	$__iLineNumber=35 & ' - . TODO: in many places I used "TODO" as a keyword to find wh ...•./Include/_XML.au3'
	. TODO: in many places I used "TODO" as a keyword to find what should be done in future
	$__iLineNumber=36 & ' - . TO REMOVE _XML_NodeExists(ByRef $oXmlDoc, $sXPath)as is du ...•./Include/_XML.au3'
	. TO REMOVE _XML_NodeExists(ByRef $oXmlDoc, $sXPath)as is duplicate for _XML_SelectSingleNode($oXmlDoc, $sXPath)
	$__iLineNumber=37 & ' - .•./Include/_XML.au3'
	.
	$__iLineNumber=38 & ' - I want to: PREVENT THIS:•./Include/_XML.au3'
	I want to: PREVENT THIS:
	$__iLineNumber=39 & ' - . The unfortunate nature of both the scripts is that the fun ...•./Include/_XML.au3'
	. The unfortunate nature of both the scripts is that the func return results are strings or arrays instead of objects.
	$__iLineNumber=40 & ' - .•./Include/_XML.au3'
	.
	$__iLineNumber=41 & ' - I want to: USE THIS CONCEPT:•./Include/_XML.au3'
	I want to: USE THIS CONCEPT:
	$__iLineNumber=42 & ' - .   All function should use Refernce to the object as first  ...•./Include/_XML.au3'
	.   All function should use Refernce to the object as first Function parameter
	$__iLineNumber=43 & ' - .   All function should return in most cases objects. There  ...•./Include/_XML.au3'
	.   All function should return in most cases objects. There should be separate functions to Change Object collection to array
	$__iLineNumber=44 & ' - .   All function should use COM Error Handler in local scope ...•./Include/_XML.au3'
	.   All function should use COM Error Handler in local scope.
	$__iLineNumber=45 & ' - .   All function should return @error which are defined in R ...•./Include/_XML.au3'
	.   All function should return @error which are defined in Region XMLWrapperEx.au3 - ERROR Enums
	$__iLineNumber=46 & ' - .	All function should have the same naming convention•./Include/_XML.au3'
	.	All function should have the same naming convention
	$__iLineNumber=47 & ' - .	All variables should have the same naming convention•./Include/_XML.au3'
	.	All variables should have the same naming convention
	$__iLineNumber=48 & ' - .	There should not to be any Global Variable - exception is  ...•./Include/_XML.au3'
	.	There should not to be any Global Variable - exception is $__g_oXMLDOM_EventsHandler
	$__iLineNumber=49 & ' - .   It should be possible easy to use XML DOM Events•./Include/_XML.au3'
	.   It should be possible easy to use XML DOM Events
	$__iLineNumber=50 & ' - .		https://msdn.microsoft.com/en-us/library/ms764697(v=vs.85 ...•./Include/_XML.au3'
	.		https://msdn.microsoft.com/en-us/library/ms764697(v=vs.85).aspx
	$__iLineNumber=51 & ' - .   It should be possible easy to Debug•./Include/_XML.au3'
	.   It should be possible easy to Debug
	$__iLineNumber=52 & ' - .	Ultimately, you should be able to do anything with your XM ...•./Include/_XML.au3'
	.	Ultimately, you should be able to do anything with your XML without having to use your own Error Handler.

	$__iLineNumber=54 & ' - . MAIN MOTTO:  "Programs are meant to be read by humans, and ...•./Include/_XML.au3'
	. MAIN MOTTO:  "Programs are meant to be read by humans, and only incidentally for computers to execute." - Donald Knuth

#CE

#CS
	; !!!!!!!!!!!!!!!!  the previous version of UDF
	; Author ........: Stephen Podhajecki - Eltorro <gehossafats@netmdc.com>
	; Author ........: Weaponx
	; Modified ......: drlava, Lukasz Suleja, oblique, Mike Rerick, Tom Hohmann
	; Initial release Dec. 15, 2005

	;; There is also _MSXML.au3 at http://code.google.com/p/my-autoit/source/browse/#svn/trunk/Scripts/MSXML
	;; http://my-autoit.googlecode.com/files/_MSXML.au3
	;; which return the xml object instead of using a global var.
	;;
	;; Therefore using the one above, more than one xml file can be opened at a time.
	;; The unfortunate nature of both the scripts is that the func return results are strings or arrays instead of objects.

	$__iLineNumber=72 & ' - !!!!!!!!!!!! The following description is intended only to s ...•./Include/_XML.au3'
	!!!!!!!!!!!! The following description is intended only to show the extent of the changes that have taken place in relation to the source version of the UDF
	$__iLineNumber=73 & ' - !!!!!!!!!!!! PLEASE TREAT THIS AS QUITE NEW UDF•./Include/_XML.au3'
	!!!!!!!!!!!! PLEASE TREAT THIS AS QUITE NEW UDF
	$__iLineNumber=74 & ' - 2015/09/02•./Include/_XML.au3'
	2015/09/02
	$__iLineNumber=75 & ' - "1.1.1.01"•./Include/_XML.au3'
	"1.1.1.01"

	$__iLineNumber=77 & ' - . Global Variable renaming: $fXMLAUTOSAVE > $g__bXMLAUTOSAVE ...•./Include/_XML.au3'
	. Global Variable renaming: $fXMLAUTOSAVE > $g__bXMLAUTOSAVE - mLipok
	$__iLineNumber=78 & ' - . Global Variable renaming: $fADDFORMATTING > $g__bADDFORMAT ...•./Include/_XML.au3'
	. Global Variable renaming: $fADDFORMATTING > $g__bADDFORMATTING - mLipok
	$__iLineNumber=79 & ' - . Global Variable renaming: $DOMVERSION > $g__iDOMVERSION -  ...•./Include/_XML.au3'
	. Global Variable renaming: $DOMVERSION > $g__iDOMVERSION - mLipok
	$__iLineNumber=80 & ' - . Global Variable renaming: $_XMLUDFVER > $g__sXML_UDF_VERSI ...•./Include/_XML.au3'
	. Global Variable renaming: $_XMLUDFVER > $g__sXML_UDF_VERSION - mLipok

	$__iLineNumber=82 & ' - . Local Variable renaming: $fDebug > $bDebug - mLipok•./Include/_XML.au3'
	. Local Variable renaming: $fDebug > $bDebug - mLipok
	$__iLineNumber=83 & ' - . Local Variable renaming: $strNameSpc > $sNameSpace - mLipo ...•./Include/_XML.au3'
	. Local Variable renaming: $strNameSpc > $sNameSpace - mLipok
	$__iLineNumber=84 & ' - . Local Variable renaming: $strXPath > $sXPath - mLipok•./Include/_XML.au3'
	. Local Variable renaming: $strXPath > $sXPath - mLipok

	$__iLineNumber=86 & ' - . added EventHandler for __XML_DOM_EVENT_onreadystatechange  ...•./Include/_XML.au3'
	. added EventHandler for __XML_DOM_EVENT_onreadystatechange - mLipok
	$__iLineNumber=87 & ' - . added EventHandler for __XML_DOM_EVENT_ondataavailable - m ...•./Include/_XML.au3'
	. added EventHandler for __XML_DOM_EVENT_ondataavailable - mLipok
	$__iLineNumber=88 & ' - . added EventHandler for __XML_DOM_EVENT_ontransformnode - m ...•./Include/_XML.au3'
	. added EventHandler for __XML_DOM_EVENT_ontransformnode - mLipok

	$__iLineNumber=90 & ' - . _XML_Misc* functions renamed and extended - mLipok•./Include/_XML.au3'
	. _XML_Misc* functions renamed and extended - mLipok
	$__iLineNumber=91 & ' - . #Region -- grouping functions - mLipok•./Include/_XML.au3'
	. #Region -- grouping functions - mLipok
	$__iLineNumber=92 & ' - . New Enums - Stream Object - ReadText Method - StreamReadEn ...•./Include/_XML.au3'
	. New Enums - Stream Object - ReadText Method - StreamReadEnum - mLipok
	$__iLineNumber=93 & ' - . New Enums - readyState Property (DOMDocument) - mLipok•./Include/_XML.au3'
	. New Enums - readyState Property (DOMDocument) - mLipok
	$__iLineNumber=94 & ' - . New Function: __XML_ComErrorHandler_UserFunction - mLipok•./Include/_XML.au3'
	. New Function: __XML_ComErrorHandler_UserFunction - mLipok
	$__iLineNumber=95 & ' - . added ADO_CONSTANTS.au3 - mLipok•./Include/_XML.au3'
	. added ADO_CONSTANTS.au3 - mLipok

	$__iLineNumber=97 & ' - ??•./Include/_XML.au3'
	??
	$__iLineNumber=98 & ' - . __XML_ComErrorHandler_InternalFunction() CleanUp - mLipok•./Include/_XML.au3'
	. __XML_ComErrorHandler_InternalFunction() CleanUp - mLipok
	$__iLineNumber=99 & ' - . __XML_ComErrorHandler_InternalFunction() new parameters -  ...•./Include/_XML.au3'
	. __XML_ComErrorHandler_InternalFunction() new parameters - mLipok

	$__iLineNumber=101 & ' - SCRIPT BREAKING CHANGES•./Include/_XML.au3'
	SCRIPT BREAKING CHANGES
	$__iLineNumber=102 & ' - . all function renamed from _XMLSomeName to _XML_SomeName ;  ...•./Include/_XML.au3'
	. all function renamed from _XMLSomeName to _XML_SomeName ; TODO not yet all, but that is the plan - mLipok
	$__iLineNumber=103 & ' - . Function _DebugWrite renamed to __XML_Misc_ConsoleNotifier ...•./Include/_XML.au3'
	. Function _DebugWrite renamed to __XML_Misc_ConsoleNotifier - mLipok
	$__iLineNumber=104 & ' - . Function _XSL_GetDefaultStyleSheet renamed to __XSL_GetDef ...•./Include/_XML.au3'
	. Function _XSL_GetDefaultStyleSheet renamed to __XSL_GetDefaultStyleSheet - mLipok
	$__iLineNumber=105 & ' - . Function _XMLGetDomVersion renamed to _XML_Misc_GetDomVers ...•./Include/_XML.au3'
	. Function _XMLGetDomVersion renamed to _XML_Misc_GetDomVersion - mLipok
	$__iLineNumber=106 & ' - . Func _SetDebug renamed to _XML_MiscProperty_NotifyToConsol ...•./Include/_XML.au3'
	. Func _SetDebug renamed to _XML_MiscProperty_NotifyToConsole - mLipok
	$__iLineNumber=107 & ' - . Removed $fDEBUGGING as is now used inside _XML_MiscPropert ...•./Include/_XML.au3'
	. Removed $fDEBUGGING as is now used inside _XML_MiscProperty_NotifyToConsole - mLipok
	$__iLineNumber=108 & ' - . Removed $bXMLAUTOSAVE as is now used inside _XML_MiscPrope ...•./Include/_XML.au3'
	. Removed $bXMLAUTOSAVE as is now used inside _XML_MiscProperty_AutoSave - mLipok
	$__iLineNumber=109 & ' - . Removed $bADDFORMATTING as is now used inside _XML_MiscPro ...•./Include/_XML.au3'
	. Removed $bADDFORMATTING as is now used inside _XML_MiscProperty_AutoFormat - mLipok
	$__iLineNumber=110 & ' - . Removed $g__iDOMVERSION as is now used inside __XML_MiscPr ...•./Include/_XML.au3'
	. Removed $g__iDOMVERSION as is now used inside __XML_MiscProperty_DomVersion - mLipok
	$__iLineNumber=111 & ' - . standardarization for using Return Value for failure: retu ...•./Include/_XML.au3'
	. standardarization for using Return Value for failure: return 0 and set @error to none 0 - mLipok
	$__iLineNumber=112 & ' - . _XML_Load on success return $oXmlDoc instead 1 - mLipok•./Include/_XML.au3'
	. _XML_Load on success return $oXmlDoc instead 1 - mLipok
	$__iLineNumber=113 & ' - . _XML_LoadXML on success return $oXmlDoc instead 1 - mLipok•./Include/_XML.au3'
	. _XML_LoadXML on success return $oXmlDoc instead 1 - mLipok
	$__iLineNumber=114 & ' - . $oXmlDoc is no longer global variable (must be passed to f ...•./Include/_XML.au3'
	. $oXmlDoc is no longer global variable (must be passed to function as ByRef) - mLipok
	$__iLineNumber=115 & ' - . removed many variable declaration used even for variable i ...•./Include/_XML.au3'
	. removed many variable declaration used even for variable iteration "For $i to 10" - mLipok

	$__iLineNumber=117 & ' - 2015/09/04•./Include/_XML.au3'
	2015/09/04
	$__iLineNumber=118 & ' - "1.1.1.02"•./Include/_XML.au3'
	"1.1.1.02"
	$__iLineNumber=119 & ' - . event handler renamed to $__g_oXMLDOM_EventsHandler - mLip ...•./Include/_XML.au3'
	. event handler renamed to $__g_oXMLDOM_EventsHandler - mLipok
	$__iLineNumber=120 & ' - . added $XMLWRAPPER_ERROR_SAVEFILERO and checking in - mLipo ...•./Include/_XML.au3'
	. added $XMLWRAPPER_ERROR_SAVEFILERO and checking in - mLipok
	$__iLineNumber=121 & ' - . if variable is ObjectsCollection then variable name ends w ...•./Include/_XML.au3'
	. if variable is ObjectsCollection then variable name ends with sufix "Coll" - mLipok
	$__iLineNumber=122 & ' - . variable used in loops are named with sufix "_idx" like th ...•./Include/_XML.au3'
	. variable used in loops are named with sufix "_idx" like this For $iAttribute_idx = 0 To $oAttributesColl.length - 1 - mLipok
	$__iLineNumber=123 & ' - . variable used in loops are named with sufix "Enum" like th ...•./Include/_XML.au3'
	. variable used in loops are named with sufix "Enum" like this For $oNode_enum in $oNodesColl - mLipok
	$__iLineNumber=124 & ' - . Local Variable renaming: $strQuery > $sQuery - mLipok - th ...•./Include/_XML.au3'
	. Local Variable renaming: $strQuery > $sQuery - mLipok - thanks to guinness
	$__iLineNumber=125 & ' - . Local Variable renaming: $sComment > $sComment - mLipok -  ...•./Include/_XML.au3'
	. Local Variable renaming: $sComment > $sComment - mLipok - thanks to guinness
	$__iLineNumber=126 & ' - . Function renamed fixed typo in function name _XML_CreateAt ...•./Include/_XML.au3'
	. Function renamed fixed typo in function name _XML_CreateAttributeute => _XML_CreateAttribute - mLipok - thanks to guinness
	$__iLineNumber=127 & ' - . Function renamed _XML_Misc_NodesList_GetNames >> _XML_Arra ...•./Include/_XML.au3'
	. Function renamed _XML_Misc_NodesList_GetNames >> _XML_Array_GetNodesNamesFromCollection - mLipok
	$__iLineNumber=128 & ' - . Global Enum renamed from   $g__eXML_ .....    to    $__g_e ...•./Include/_XML.au3'
	. Global Enum renamed from   $g__eXML_ .....    to    $__g_eXML_ ..... - mLipok
	$__iLineNumber=129 & ' - . Function renamed _XML_ArrayAdd >> _XML_Array_AddName - mLi ...•./Include/_XML.au3'
	. Function renamed _XML_ArrayAdd >> _XML_Array_AddName - mLipok
	$__iLineNumber=130 & ' - . Function renamed _XML_Misc_NodesColl_GetNamesToArray >> _X ...•./Include/_XML.au3'
	. Function renamed _XML_Misc_NodesColl_GetNamesToArray >> _XML_Array_GetNodesNamesFromCollection - mLipok
	$__iLineNumber=131 & ' - . Function renamed _XML_DeleteNode_XML_DeleteNode >> _XML_re ...•./Include/_XML.au3'
	. Function renamed _XML_DeleteNode_XML_DeleteNode >> _XML_removeAll - mLipok
	$__iLineNumber=132 & ' - . Function renamed _XML_FileOpen >> _XML_Load - mLipok•./Include/_XML.au3'
	. Function renamed _XML_FileOpen >> _XML_Load - mLipok
	$__iLineNumber=133 & ' - . new Function _XML_Array_GetNodeList() - mLipok•./Include/_XML.au3'
	. new Function _XML_Array_GetNodeList() - mLipok
	$__iLineNumber=134 & ' - . UDF FileName: _XMLWrapperEx.au3 >> XMLWrapperEx.au3 - mLip ...•./Include/_XML.au3'
	. UDF FileName: _XMLWrapperEx.au3 >> XMLWrapperEx.au3 - mLipok
	$__iLineNumber=135 & ' - . !!! EXAMPLES FILE:    XMLWrapperEx__Examples.au3 - mLipok•./Include/_XML.au3'
	. !!! EXAMPLES FILE:    XMLWrapperEx__Examples.au3 - mLipok

	$__iLineNumber=137 & ' - 2015/09/06•./Include/_XML.au3'
	2015/09/06
	$__iLineNumber=138 & ' - "1.1.1.03"•./Include/_XML.au3'
	"1.1.1.03"
	$__iLineNumber=139 & ' - . Renamed Function: _XMLCreateChildWAttr >> _XML_CreateChild ...•./Include/_XML.au3'
	. Renamed Function: _XMLCreateChildWAttr >> _XML_CreateChildWAttr - mLipok
	$__iLineNumber=140 & ' - . Renamed ENUMs:  $__g_eXML_ERROR ... >> $XMLWRAPPER_ERROR . ...•./Include/_XML.au3'
	. Renamed ENUMs:  $__g_eXML_ERROR ... >> $XMLWRAPPER_ERROR ... - mLipok - Thanks to guinness
	$__iLineNumber=141 & ' - . Renamed ENUMs:  $__g_eXML_RESULT ... >> $XMLWRAPPER_RESULT ...•./Include/_XML.au3'
	. Renamed ENUMs:  $__g_eXML_RESULT ... >> $XMLWRAPPER_RESULT ... - mLipok - Thanks to guinness
	$__iLineNumber=142 & ' - . Renamed CONST:  $XMLDOM_DOCUMENT_READYSTATE_ ... >> $XMLWR ...•./Include/_XML.au3'
	. Renamed CONST:  $XMLDOM_DOCUMENT_READYSTATE_ ... >> $XMLWRAPPER_DOCUMENT_READYSTATE_ ... - mLipok - Thanks to guinness
	$__iLineNumber=143 & ' - . Renamed Variable : $oXML_Document >> $oXmlDoc  - for short ...•./Include/_XML.au3'
	. Renamed Variable : $oXML_Document >> $oXmlDoc  - for shortness, and compliance with examples of MSDN - mLipok
	$__iLineNumber=144 & ' - . New Example: _Example_2__XML_CreateChildWAttr - mLipok•./Include/_XML.au3'
	. New Example: _Example_2__XML_CreateChildWAttr - mLipok
	$__iLineNumber=145 & ' - . New Example: _Example_3__XML_Misc_ErrorDecription - mLipok•./Include/_XML.au3'
	. New Example: _Example_3__XML_Misc_ErrorDecription - mLipok
	$__iLineNumber=146 & ' - . New Example: _Example_MSDN_1__setAttributeNode - mLipok•./Include/_XML.au3'
	. New Example: _Example_MSDN_1__setAttributeNode - mLipok
	$__iLineNumber=147 & ' - . New Function: _XML_Misc_Viewer - mLipok•./Include/_XML.au3'
	. New Function: _XML_Misc_Viewer - mLipok
	$__iLineNumber=148 & ' - . New: Function: _XML_Misc_ErrorParser() -- added as a repla ...•./Include/_XML.au3'
	. New: Function: _XML_Misc_ErrorParser() -- added as a replacment for using: _XML_Misc_ErrorDecription() - mLipok
	$__iLineNumber=149 & ' - . NEW: @ERROR result: $XMLWRAPPER_ERROR_ARRAY - mLipok•./Include/_XML.au3'
	. NEW: @ERROR result: $XMLWRAPPER_ERROR_ARRAY - mLipok
	$__iLineNumber=150 & ' - . NEW: @ERROR result: $XMLWRAPPER_ERROR_NODECREATEAPPEND - m ...•./Include/_XML.au3'
	. NEW: @ERROR result: $XMLWRAPPER_ERROR_NODECREATEAPPEND - mLipok
	$__iLineNumber=151 & ' - . Removed: all old _XML_Misc_ErrorDecription() - mLipok•./Include/_XML.au3'
	. Removed: all old _XML_Misc_ErrorDecription() - mLipok
	$__iLineNumber=152 & ' - . Removed: _XML_Misc_ErrorDecription_Reset()- mLipok•./Include/_XML.au3'
	. Removed: _XML_Misc_ErrorDecription_Reset()- mLipok
	$__iLineNumber=153 & ' - . Removed: all $sXML_error - mLipok•./Include/_XML.au3'
	. Removed: all $sXML_error - mLipok
	$__iLineNumber=154 & ' - . Removed: _XML_Error_Reason - mLipok•./Include/_XML.au3'
	. Removed: _XML_Error_Reason - mLipok
	$__iLineNumber=155 & ' - . COMPLETED: @error checking for   .selectNodes  methods: @e ...•./Include/_XML.au3'
	. COMPLETED: @error checking for   .selectNodes  methods: @error is set to: $XMLWRAPPER_ERROR_XPATH - mLipok
	$__iLineNumber=156 & ' - . COMPLETED: _XML_CreateChildWAttr - mLipok•./Include/_XML.au3'
	. COMPLETED: _XML_CreateChildWAttr - mLipok
	$__iLineNumber=157 & ' - . COMPLETED: Standardarization for using Return Value @error ...•./Include/_XML.au3'
	. COMPLETED: Standardarization for using Return Value @error codes returned from function --> ENUMERATED CONSTATNS - mLipok
	$__iLineNumber=158 & ' - . 		Now all functions  Return like the following examples:•./Include/_XML.au3'
	. 		Now all functions  Return like the following examples:
	$__iLineNumber=159 & ' - .				Return SetError($XMLWRAPPER_ERROR_ .........•./Include/_XML.au3'
	.				Return SetError($XMLWRAPPER_ERROR_ .........
	$__iLineNumber=160 & ' - .					or in this way:•./Include/_XML.au3'
	.					or in this way:
	$__iLineNumber=161 & ' - .				If @error Then Return SetError(@error, @extended, $XMLW ...•./Include/_XML.au3'
	.				If @error Then Return SetError(@error, @extended, $XMLWRAPPER_RESULT_FAILURE)

	$__iLineNumber=163 & ' - 2015/09/07•./Include/_XML.au3'
	2015/09/07
	$__iLineNumber=164 & ' - "1.1.1.04"•./Include/_XML.au3'
	"1.1.1.04"
	$__iLineNumber=165 & ' - . Renamed: $iXMLWrapper_Error_number >> $iXMLWrapper_Error - ...•./Include/_XML.au3'
	. Renamed: $iXMLWrapper_Error_number >> $iXMLWrapper_Error - mLipok
	$__iLineNumber=166 & ' - . Removed: almost all MsgBox() - leaves only in __XML_Misc_M ...•./Include/_XML.au3'
	. Removed: almost all MsgBox() - leaves only in __XML_Misc_MsgBoxNotifier() - mLipok
	$__iLineNumber=167 & ' - . Changed: in Examples : Global $oErrorHandler >> Local $oEr ...•./Include/_XML.au3'
	. Changed: in Examples : Global $oErrorHandler >> Local $oErrorHandler - mLipok
	$__iLineNumber=168 & ' - . Renamed _XML_Array_GetNodeList >> _XML_Array_GetNodesPrope ...•./Include/_XML.au3'
	. Renamed _XML_Array_GetNodeList >> _XML_Array_GetNodesProperties - mLipok
	$__iLineNumber=169 & ' - . Removed: _XML_Array_GetNodesFromCollection as this was dup ...•./Include/_XML.au3'
	. Removed: _XML_Array_GetNodesFromCollection as this was duplicate for _XML_Array_GetNodesProperties - mLipok
	$__iLineNumber=170 & ' - . NEW: $__g_eARRAY_NODE_ATTRIBUTES in function _XML_Array_Ge ...•./Include/_XML.au3'
	. NEW: $__g_eARRAY_NODE_ATTRIBUTES in function _XML_Array_GetNodesProperties - now also display all atributes - mLipok
	$__iLineNumber=171 & ' - . Renamed: _XML_MiscProperty_DomVersion >> __XML_MiscPropert ...•./Include/_XML.au3'
	. Renamed: _XML_MiscProperty_DomVersion >> __XML_MiscProperty_DomVersion - as this should be internal - as you can use _XML_Misc_GetDomVersion() - mLipok
	$__iLineNumber=172 & ' - . Renamed: _XML_ComErrorHandler_MainFunction >> __XML_ComErr ...•./Include/_XML.au3'
	. Renamed: _XML_ComErrorHandler_MainFunction >> __XML_ComErrorHandler_UserFunction - as this should be internal - mLipok
	$__iLineNumber=173 & ' - . Renamed: _XML_ErrorParser >> _XML_ErrorParser_GetDescripti ...•./Include/_XML.au3'
	. Renamed: _XML_ErrorParser >> _XML_ErrorParser_GetDescription - mLipok
	$__iLineNumber=174 & ' - . Removed: _XML_Misc_ErrorParser - will be in Examples - mLi ...•./Include/_XML.au3'
	. Removed: _XML_Misc_ErrorParser - will be in Examples - mLipok
	$__iLineNumber=175 & ' - . Changed: Return value behavior - mLipok•./Include/_XML.au3'
	. Changed: Return value behavior - mLipok
	$__iLineNumber=176 & ' - .	From:•./Include/_XML.au3'
	.	From:
	$__iLineNumber=177 & ' - .		SetError($XMLWRAPPER_ERROR_PARSE, $oXmlDoc.parseError.err ...•./Include/_XML.au3'
	.		SetError($XMLWRAPPER_ERROR_PARSE, $oXmlDoc.parseError.errorCode, $oXmlDoc.parseError.reason)
	$__iLineNumber=178 & ' - .		SetError($XMLWRAPPER_ERROR_PARSE, $oXmlDoc.parseError.err ...•./Include/_XML.au3'
	.		SetError($XMLWRAPPER_ERROR_PARSE, $oXmlDoc.parseError.errorCode, $XMLWRAPPER_RESULT_FAILURE)
	$__iLineNumber=179 & ' - . Changed: _XML_Load and _XML_LoadXML require $oXmlDoc as fi ...•./Include/_XML.au3'
	. Changed: _XML_Load and _XML_LoadXML require $oXmlDoc as first parameter, you must use _XML_CreateDOMDocument() as only in this way it is possible to use _XML_ErrorParser_GetDescription() - mLipok
	$__iLineNumber=180 & ' - .		All examples changed to show how to use "new" _XML_Load a ...•./Include/_XML.au3'
	.		All examples changed to show how to use "new" _XML_Load and _XML_LoadXML
	$__iLineNumber=181 & ' - . NEW: ENUMs: $XMLWRAPPER_ERROR_EMPTYCOLLECTION - mLipok•./Include/_XML.au3'
	. NEW: ENUMs: $XMLWRAPPER_ERROR_EMPTYCOLLECTION - mLipok
	$__iLineNumber=182 & ' - . NEW: ENUMs: $XMLWRAPPER_ERROR_NONODESMATCH - mLipok•./Include/_XML.au3'
	. NEW: ENUMs: $XMLWRAPPER_ERROR_NONODESMATCH - mLipok
	$__iLineNumber=183 & ' - . Changed: MAGIC NUMBERS: for StringStripWS in _XML_DeleteNo ...•./Include/_XML.au3'
	. Changed: MAGIC NUMBERS: for StringStripWS in _XML_DeleteNode() - mLipok
	$__iLineNumber=184 & ' - . COMPLETED: _XML_NodeExists - mLipok•./Include/_XML.au3'
	. COMPLETED: _XML_NodeExists - mLipok
	$__iLineNumber=185 & ' - . COMPLETED: Refactroing all functions with "selectNodes" Me ...•./Include/_XML.au3'
	. COMPLETED: Refactroing all functions with "selectNodes" Method now have checking: If (Not IsObj($oNodesColl)) Or $oNodesColl.length = 0 Then ... SetError($XMLWRAPPER_ERROR_EMPTYCOLLECTION ..... - mLipok
	$__iLineNumber=186 & ' - . COMPLETED: Refactroing all functions with "selectSingleNod ...•./Include/_XML.au3'
	. COMPLETED: Refactroing all functions with "selectSingleNode" Method now have checking: If $oNode_Selected = Null Then .. SetError($XMLWRAPPER_ERROR_NONODESMATCH ..... - mLipok

	$__iLineNumber=188 & ' - 2015/09/09•./Include/_XML.au3'
	2015/09/09
	$__iLineNumber=189 & ' - "1.1.1.05"•./Include/_XML.au3'
	"1.1.1.05"
	$__iLineNumber=190 & ' - . NEW: ENUMs: $XMLWRAPPER_ERROR_PARSE_XSL - mLipok•./Include/_XML.au3'
	. NEW: ENUMs: $XMLWRAPPER_ERROR_PARSE_XSL - mLipok
	$__iLineNumber=191 & ' - . NEW: ENUMs: $XMLWRAPPER_ERROR_NOATTRMATCH - mLipok•./Include/_XML.au3'
	. NEW: ENUMs: $XMLWRAPPER_ERROR_NOATTRMATCH - mLipok
	$__iLineNumber=192 & ' - . COMPLETED: Function: _XML_RemoveAttribute() - mLipok•./Include/_XML.au3'
	. COMPLETED: Function: _XML_RemoveAttribute() - mLipok
	$__iLineNumber=193 & ' - . NEW EXAMPLE: _Example_4__XML_RemoveAttribute() - mLipok•./Include/_XML.au3'
	. NEW EXAMPLE: _Example_4__XML_RemoveAttribute() - mLipok
	$__iLineNumber=194 & ' - . Renamed: _XMLReplaceChild >> _XML_ReplaceChild - mLipok•./Include/_XML.au3'
	. Renamed: _XMLReplaceChild >> _XML_ReplaceChild - mLipok
	$__iLineNumber=195 & ' - . COMPLETED: _XML_ReplaceChild - mLipok•./Include/_XML.au3'
	. COMPLETED: _XML_ReplaceChild - mLipok
	$__iLineNumber=196 & ' - . NEW EXAMPLE: _Example_5__XML_ReplaceChild() - mLipok•./Include/_XML.au3'
	. NEW EXAMPLE: _Example_5__XML_ReplaceChild() - mLipok
	$__iLineNumber=197 & ' - . NEW: ENUMs: $XMLWRAPPER_ERROR_NOCHILDMATCH - mLipok•./Include/_XML.au3'
	. NEW: ENUMs: $XMLWRAPPER_ERROR_NOCHILDMATCH - mLipok
	$__iLineNumber=198 & ' - . NEW EXAMPLE: _Example_6__XML_GetChildNodes() - mLipok•./Include/_XML.au3'
	. NEW EXAMPLE: _Example_6__XML_GetChildNodes() - mLipok
	$__iLineNumber=199 & ' - . COMPLETED: _XML_GetChildNodes() - mLipok•./Include/_XML.au3'
	. COMPLETED: _XML_GetChildNodes() - mLipok
	$__iLineNumber=200 & ' - . COMPLETED: _XML_GetAllAttribIndex() - mLipok•./Include/_XML.au3'
	. COMPLETED: _XML_GetAllAttribIndex() - mLipok
	$__iLineNumber=201 & ' - . NEW Function: _XML_Array_GetAttributesProperties() - mLipo ...•./Include/_XML.au3'
	. NEW Function: _XML_Array_GetAttributesProperties() - mLipok
	$__iLineNumber=202 & ' - . NEW EXAMPLE: _Example_7__XML_GetAllAttribIndex() - mLipok•./Include/_XML.au3'
	. NEW EXAMPLE: _Example_7__XML_GetAllAttribIndex() - mLipok
	$__iLineNumber=203 & ' - . ADDED: many IsObj() >> https://www.autoitscript.com/forum/ ...•./Include/_XML.au3'
	. ADDED: many IsObj() >> https://www.autoitscript.com/forum/topic/177176-why-isobj-0-and-vargettype-object/

	$__iLineNumber=205 & ' - 2015/09/11•./Include/_XML.au3'
	2015/09/11
	$__iLineNumber=206 & ' - "1.1.1.06"•./Include/_XML.au3'
	"1.1.1.06"
	$__iLineNumber=207 & ' - . Removed: Function: __XML_Misc_ConsoleNotifier() - mLipok•./Include/_XML.au3'
	. Removed: Function: __XML_Misc_ConsoleNotifier() - mLipok
	$__iLineNumber=208 & ' - . Removed: Function: __XML_Misc_MsgBoxNotifier() - mLipok•./Include/_XML.au3'
	. Removed: Function: __XML_Misc_MsgBoxNotifier() - mLipok
	$__iLineNumber=209 & ' - . Removed: Function: _XML_MiscProperty_Notify() - mLipok•./Include/_XML.au3'
	. Removed: Function: _XML_MiscProperty_Notify() - mLipok
	$__iLineNumber=210 & ' - . Removed: Function: _XML_MiscProperty_NotifyToConsole() - m ...•./Include/_XML.au3'
	. Removed: Function: _XML_MiscProperty_NotifyToConsole() - mLipok
	$__iLineNumber=211 & ' - . Removed: Function: _XML_MiscProperty_NotifyToMsgBox() - mL ...•./Include/_XML.au3'
	. Removed: Function: _XML_MiscProperty_NotifyToMsgBox() - mLipok
	$__iLineNumber=212 & ' - . Removed: Function: _XML_MiscProperty_NotifyAll() - mLipok•./Include/_XML.au3'
	. Removed: Function: _XML_MiscProperty_NotifyAll() - mLipok
	$__iLineNumber=213 & ' - . Removed: Function: __XML_ComErrorHandler_MainFunction() -  ...•./Include/_XML.au3'
	. Removed: Function: __XML_ComErrorHandler_MainFunction() - mLipok
	$__iLineNumber=214 & ' - . Removed: Function: __XML_DOM_EVENT_ondataavailable() >> is ...•./Include/_XML.au3'
	. Removed: Function: __XML_DOM_EVENT_ondataavailable() >> is in example - mLipok
	$__iLineNumber=215 & ' - . Removed: Function: __XML_DOM_EVENT_onreadystatechange() >> ...•./Include/_XML.au3'
	. Removed: Function: __XML_DOM_EVENT_onreadystatechange() >> is in example - mLipok
	$__iLineNumber=216 & ' - . Removed: Function: __XML_DOM_EVENT_ontransformnode() >> is ...•./Include/_XML.au3'
	. Removed: Function: __XML_DOM_EVENT_ontransformnode() >> is in example - mLipok
	$__iLineNumber=217 & ' - . Removed: Function: _XML_UseEventHandler() - as event handl ...•./Include/_XML.au3'
	. Removed: Function: _XML_UseEventHandler() - as event handler should be defined by user in main script - look in examlpes - mLipok
	$__iLineNumber=218 & ' - . Removed: Function: _XML_ComErrorHandler_UseInternalAsUser( ...•./Include/_XML.au3'
	. Removed: Function: _XML_ComErrorHandler_UseInternalAsUser() - mLipok
	$__iLineNumber=219 & ' - . Renamed: Function: _XML_ComErrorHandler_UserFunction >> __ ...•./Include/_XML.au3'
	. Renamed: Function: _XML_ComErrorHandler_UserFunction >> __XML_ComErrorHandler_UserFunction - is now internal - mLipok
	$__iLineNumber=220 & ' - .		User Function are now passed as parameter to _XML_CreateD ...•./Include/_XML.au3'
	.		User Function are now passed as parameter to _XML_CreateDOMDocument()
	$__iLineNumber=221 & ' - . Changed: Examples: XML_Misc_ErrorParser() >> XML_My_ErrorP ...•./Include/_XML.au3'
	. Changed: Examples: XML_Misc_ErrorParser() >> XML_My_ErrorParser() - mLipok
	$__iLineNumber=222 & ' - . Changed: Examples to fit to the changed UDF - mLipok•./Include/_XML.au3'
	. Changed: Examples to fit to the changed UDF - mLipok
	$__iLineNumber=223 & ' - . Modified: Examples: CleanUp +++ Comments - mLipok•./Include/_XML.au3'
	. Modified: Examples: CleanUp +++ Comments - mLipok
	$__iLineNumber=224 & ' - . Removed: Function: __AddFormat - as now is _XML_TIDY() fun ...•./Include/_XML.au3'
	. Removed: Function: __AddFormat - as now is _XML_TIDY() function - mLipok
	$__iLineNumber=225 & ' - . Removed: Function: _XML_MiscProperty_StaticCOMErrorHandler ...•./Include/_XML.au3'
	. Removed: Function: _XML_MiscProperty_StaticCOMErrorHandler() - as was not used - mLipok
	$__iLineNumber=226 & ' - .•./Include/_XML.au3'
	.
	$__iLineNumber=227 & ' - .•./Include/_XML.au3'
	.
	$__iLineNumber=228 & ' - . !!!!!! REMARKS: - mLipok•./Include/_XML.au3'
	. !!!!!! REMARKS: - mLipok
	$__iLineNumber=229 & ' - .       It is user choice to set ERROR HANDLER or not.•./Include/_XML.au3'
	.       It is user choice to set ERROR HANDLER or not.
	$__iLineNumber=230 & ' - .		If user do not set it and something goes wrong with COM t ...•./Include/_XML.au3'
	.		If user do not set it and something goes wrong with COM then this is USER PROBLEM and NOT UDF ISSUE/ERROR
	$__iLineNumber=231 & ' - .			in such case UDF will call empty function for avoid Auto ...•./Include/_XML.au3'
	.			in such case UDF will call empty function for avoid AutoIt Error
	$__iLineNumber=232 & ' - . 	FOR ERROR CHECKING•./Include/_XML.au3'
	. 	FOR ERROR CHECKING
	$__iLineNumber=233 & ' - .		1. check @error•./Include/_XML.au3'
	.		1. check @error
	$__iLineNumber=234 & ' - .		2. _XML_ErrorParser_GetDescription()•./Include/_XML.au3'
	.		2. _XML_ErrorParser_GetDescription()
	$__iLineNumber=235 & ' - .		3. setup your COM ERROR HANDLER and pass it as parameter  ...•./Include/_XML.au3'
	.		3. setup your COM ERROR HANDLER and pass it as parameter to _XML_CreateDOMDocument()
	$__iLineNumber=236 & ' - .		4. you can make in your main script function like XML_My_ ...•./Include/_XML.au3'
	.		4. you can make in your main script function like XML_My_ErrorParser() and use it if you want

	$__iLineNumber=238 & ' - 2015/09/15•./Include/_XML.au3'
	2015/09/15
	$__iLineNumber=239 & ' - "1.1.1.07"•./Include/_XML.au3'
	"1.1.1.07"
	$__iLineNumber=240 & ' - . Renamed: ENUMs: $eAttributeList_ ..... >> $__g_eARRAY_ATTR ...•./Include/_XML.au3'
	. Renamed: ENUMs: $eAttributeList_ ..... >> $__g_eARRAY_ATTR_ .... - as now are Global Enums - mLipok
	$__iLineNumber=241 & ' - . Renamed: ENUMs: $eNodeList_ ..... >> $__g_eARRAY_NODE_ ... ...•./Include/_XML.au3'
	. Renamed: ENUMs: $eNodeList_ ..... >> $__g_eARRAY_NODE_ .... - as now are Global Enums - mLipok
	$__iLineNumber=242 & ' - . Removed: Function: _XML_MiscProperty_AutoFormat() - as is  ...•./Include/_XML.au3'
	. Removed: Function: _XML_MiscProperty_AutoFormat() - as is not used - mLipok
	$__iLineNumber=243 & ' - . Removed: Function: _XML_MiscProperty_EventHandling() - as  ...•./Include/_XML.au3'
	. Removed: Function: _XML_MiscProperty_EventHandling() - as is not used - mLipok
	$__iLineNumber=244 & ' - . Removed: Function: _XML_MiscProperty_AutoSave() - as is no ...•./Include/_XML.au3'
	. Removed: Function: _XML_MiscProperty_AutoSave() - as is not used - mLipok
	$__iLineNumber=245 & ' - . ADDED NEW: Function: __XML_IsValidObject_Attributes() - mL ...•./Include/_XML.au3'
	. ADDED NEW: Function: __XML_IsValidObject_Attributes() - mLipok
	$__iLineNumber=246 & ' - . ADDED NEW: Function: __XML_IsValidObject_NodesColl() - mLi ...•./Include/_XML.au3'
	. ADDED NEW: Function: __XML_IsValidObject_NodesColl() - mLipok
	$__iLineNumber=247 & ' - . ADDED NEW: $XMLWRAPPER_EXT_ ... for proper handling @exten ...•./Include/_XML.au3'
	. ADDED NEW: $XMLWRAPPER_EXT_ ... for proper handling @extended information - mLipok
	$__iLineNumber=248 & ' - . Changed: Examples: XML_My_ErrorParser() - added support fo ...•./Include/_XML.au3'
	. Changed: Examples: XML_My_ErrorParser() - added support for $XMLWRAPPER_EXT_ ...  - mLipok
	$__iLineNumber=249 & ' - . Removed: $sQuery      - DOM compliant query string (not re ...•./Include/_XML.au3'
	. Removed: $sQuery      - DOM compliant query string (not really necessary as it becomes part of the path) - mLipok
	$__iLineNumber=250 & ' - . Changed: All @extended are returned as $XMLWRAPPER_EXT_ .. ...•./Include/_XML.au3'
	. Changed: All @extended are returned as $XMLWRAPPER_EXT_ .... or @extended - never as 0 or directly as number - mLipok
	$__iLineNumber=251 & ' - . REFACTORED: _XML_Tidy() - proper @errors and @extended sup ...•./Include/_XML.au3'
	. REFACTORED: _XML_Tidy() - proper @errors and @extended support - mLipok
	$__iLineNumber=252 & ' - . REFACTORED: _XML_Array_GetAttributesProperties() - proper  ...•./Include/_XML.au3'
	. REFACTORED: _XML_Array_GetAttributesProperties() - proper @errors and @extended support - mLipok
	$__iLineNumber=253 & ' - . REFACTORED: _XML_Array_GetNodesProperties() - proper @erro ...•./Include/_XML.au3'
	. REFACTORED: _XML_Array_GetNodesProperties() - proper @errors and @extended support - mLipok
	$__iLineNumber=254 & ' - . REFACTORED: all this following function uses _XML_SelectNo ...•./Include/_XML.au3'
	. REFACTORED: all this following function uses _XML_SelectNodes() - mLipok
	$__iLineNumber=255 & ' - .		_XMLCreateChildNode() 		_XML_DeleteNode() 			_XML_GetAllA ...•./Include/_XML.au3'
	.		_XMLCreateChildNode() 		_XML_DeleteNode() 			_XML_GetAllAttribIndex()
	$__iLineNumber=256 & ' - .		_XML_GetParentNodeName() 	_XMLSetAttrib() 			_XML_UpdateF ...•./Include/_XML.au3'
	.		_XML_GetParentNodeName() 	_XMLSetAttrib() 			_XML_UpdateField2()
	$__iLineNumber=257 & ' - .		_XMLGetValue() 				_XML_GetNodesCount() 		_XML_ReplaceChi ...•./Include/_XML.au3'
	.		_XMLGetValue() 				_XML_GetNodesCount() 		_XML_ReplaceChild()
	$__iLineNumber=258 & ' - .		_XML_GetNodesPath()			_XMLGetAllAttrib()•./Include/_XML.au3'
	.		_XML_GetNodesPath()			_XMLGetAllAttrib()
	$__iLineNumber=259 & ' - . REFACTORED: all this following function uses _XML_SelectSi ...•./Include/_XML.au3'
	. REFACTORED: all this following function uses _XML_SelectSingleNode() - mLipok
	$__iLineNumber=260 & ' - .		_XML_CreateAttribute() 		_XML_CreateComment() 		_XML_GetA ...•./Include/_XML.au3'
	.		_XML_CreateAttribute() 		_XML_CreateComment() 		_XML_GetAttrib()
	$__iLineNumber=261 & ' - .		_XML_GetChildNodes() 		_XML_GetChildren() 			_XML_NodeExi ...•./Include/_XML.au3'
	.		_XML_GetChildNodes() 		_XML_GetChildren() 			_XML_NodeExist()
	$__iLineNumber=262 & ' - .		_XML_RemoveAttribute() 		_XML_GetChildText() 		_XML_Updat ...•./Include/_XML.au3'
	.		_XML_RemoveAttribute() 		_XML_GetChildText() 		_XML_UpdateField()
	$__iLineNumber=263 & ' - .		_XMLGetField()•./Include/_XML.au3'
	.		_XMLGetField()
	$__iLineNumber=264 & ' - . Renamed: Function: __XML_IsValidObject >> __XML_IsValidObj ...•./Include/_XML.au3'
	. Renamed: Function: __XML_IsValidObject >> __XML_IsValidObject_DOMDocument - mLipok
	$__iLineNumber=265 & ' - . COMPLETED: Function: _XML_SaveToFile - mLipok•./Include/_XML.au3'
	. COMPLETED: Function: _XML_SaveToFile - mLipok
	$__iLineNumber=266 & ' - . Removed: $XMLWRAPPER_ERROR_NODECREATEAPPEND - mLipok•./Include/_XML.au3'
	. Removed: $XMLWRAPPER_ERROR_NODECREATEAPPEND - mLipok
	$__iLineNumber=267 & ' - . ADDED: $XMLWRAPPER_ERROR_NODECREATE - mLipok•./Include/_XML.au3'
	. ADDED: $XMLWRAPPER_ERROR_NODECREATE - mLipok
	$__iLineNumber=268 & ' - . ADDED: $XMLWRAPPER_ERROR_NODEAPPEND - mLipok•./Include/_XML.au3'
	. ADDED: $XMLWRAPPER_ERROR_NODEAPPEND - mLipok
	$__iLineNumber=269 & ' - . Changed: Functions to proper use $XMLWRAPPER_ERROR_NODECRE ...•./Include/_XML.au3'
	. Changed: Functions to proper use $XMLWRAPPER_ERROR_NODECREATE  and $XMLWRAPPER_ERROR_NODEAPPEND - mLipok
	$__iLineNumber=270 & ' - . Renamed: Function: __XML_IsValidObject_Nodes >> __XML_IsVa ...•./Include/_XML.au3'
	. Renamed: Function: __XML_IsValidObject_Nodes >> __XML_IsValidObject_NodesColl - mLipok
	$__iLineNumber=271 & ' - . Renamed: ENUMs: $XMLWRAPPER_EXT_OK >> $XMLWRAPPER_EXT_DEFA ...•./Include/_XML.au3'
	. Renamed: ENUMs: $XMLWRAPPER_EXT_OK >> $XMLWRAPPER_EXT_DEFAULT - mLipok
	$__iLineNumber=272 & ' - . Renamed: Function: _XML_GetNodeCount >> _XML_GetNodesCount ...•./Include/_XML.au3'
	. Renamed: Function: _XML_GetNodeCount >> _XML_GetNodesCount - mLipok
	$__iLineNumber=273 & ' - . Renamed: Function: _XML_GetAttrib >> _XML_GetNodeAttribute ...•./Include/_XML.au3'
	. Renamed: Function: _XML_GetAttrib >> _XML_GetNodeAttributeValue - mLipok
	$__iLineNumber=274 & ' - . Changed: Function: _XML_GetNodeAttributeValue - parameters ...•./Include/_XML.au3'
	. Changed: Function: _XML_GetNodeAttributeValue - parameters chagned - must pass $oNode instead $oXmlDoc - mLipok
	$__iLineNumber=275 & ' - . COMPLETED: Function: _XML_LoadXML - mLipok•./Include/_XML.au3'
	. COMPLETED: Function: _XML_LoadXML - mLipok
	$__iLineNumber=276 & ' - . COMPLETED: Function: _XML_CreateDOMDocument - mLipok•./Include/_XML.au3'
	. COMPLETED: Function: _XML_CreateDOMDocument - mLipok
	$__iLineNumber=277 & ' - . COMPLETED: Function: _XML_Tidy - mLipok•./Include/_XML.au3'
	. COMPLETED: Function: _XML_Tidy - mLipok
	$__iLineNumber=278 & ' - . Renamed: Function: _XML_CreateObject >> _XML_CreateDOMDocu ...•./Include/_XML.au3'
	. Renamed: Function: _XML_CreateObject >> _XML_CreateDOMDocument - mLipok
	$__iLineNumber=279 & ' - . NEW: Region: XMLWrapperEx.au3 - Functions - Not yet review ...•./Include/_XML.au3'
	. NEW: Region: XMLWrapperEx.au3 - Functions - Not yet reviewed - mLipok
	$__iLineNumber=280 & ' - . NEW: Region: XMLWrapperEx.au3 - Functions - COMPLETED - mL ...•./Include/_XML.au3'
	. NEW: Region: XMLWrapperEx.au3 - Functions - COMPLETED - mLipok
	$__iLineNumber=281 & ' - . COMPLETED: Function: _XML_GetNodeAttributeValue - mLipok•./Include/_XML.au3'
	. COMPLETED: Function: _XML_GetNodeAttributeValue - mLipok
	$__iLineNumber=282 & ' - . other CleanUp - mLipok•./Include/_XML.au3'
	. other CleanUp - mLipok

	$__iLineNumber=284 & ' - 2015/10/22•./Include/_XML.au3'
	2015/10/22
	$__iLineNumber=285 & ' - "1.1.1.08"•./Include/_XML.au3'
	"1.1.1.08"
	$__iLineNumber=286 & ' - . ADDED: Description for _XML_ErrorParser_GetDescription() - ...•./Include/_XML.au3'
	. ADDED: Description for _XML_ErrorParser_GetDescription() - mLipok
	$__iLineNumber=287 & ' - . ADDED: Description for _XML_Array_GetNodesProperties() - m ...•./Include/_XML.au3'
	. ADDED: Description for _XML_Array_GetNodesProperties() - mLipok
	$__iLineNumber=288 & ' - . Fixed: Function: _XMLCreateFile () - mLipok•./Include/_XML.au3'
	. Fixed: Function: _XMLCreateFile () - mLipok
	$__iLineNumber=289 & ' - .		Issue with usage of Tenary Operator in $oXmlDoc.createPro ...•./Include/_XML.au3'
	.		Issue with usage of Tenary Operator in $oXmlDoc.createProcessingInstruction("xml", 'version="1.0"' & (($bUTF8) ? ' encoding="UTF-8"' : ''))
	$__iLineNumber=290 & ' - . Renamed: Function: _XMLCreateFile >> _XML_CreateFile - mLi ...•./Include/_XML.au3'
	. Renamed: Function: _XMLCreateFile >> _XML_CreateFile - mLipok
	$__iLineNumber=291 & ' - . Completed: Function: _XML_CreateFile - mLipok•./Include/_XML.au3'
	. Completed: Function: _XML_CreateFile - mLipok
	$__iLineNumber=292 & ' - . !!! EXAMPLES FILE: New Example: Example_9__XML_CreateFile( ...•./Include/_XML.au3'
	. !!! EXAMPLES FILE: New Example: Example_9__XML_CreateFile() - mLipok
	$__iLineNumber=293 & ' - . !!! EXAMPLES FILE: Changed to Keep the changed Script Brea ...•./Include/_XML.au3'
	. !!! EXAMPLES FILE: Changed to Keep the changed Script Breaking Changes - mLipok
	$__iLineNumber=294 & ' - . Renamed: Function: __XML_ComErrorHandler_UserFunction >> _ ...•./Include/_XML.au3'
	. Renamed: Function: __XML_ComErrorHandler_UserFunction >> _XML_ComErrorHandler_UserFunction : is now normal function - not internal - mLipok
	$__iLineNumber=295 & ' - . NEW: methode of transfer UDF internal COM Error Handler to ...•./Include/_XML.au3'
	. NEW: methode of transfer UDF internal COM Error Handler to the user function - mLipok
	$__iLineNumber=296 & ' - .		just use _XML_ComErrorHandler_UserFunction() like in exam ...•./Include/_XML.au3'
	.		just use _XML_ComErrorHandler_UserFunction() like in example
	$__iLineNumber=297 & ' - .•./Include/_XML.au3'
	.
	$__iLineNumber=298 & ' - SCRIPT BREAKING CHANGES•./Include/_XML.au3'
	SCRIPT BREAKING CHANGES
	$__iLineNumber=299 & ' - . Renamed: Enums: $XMLWRAPPER_RESULT_ >> $XML_RET_ - mLipok•./Include/_XML.au3'
	. Renamed: Enums: $XMLWRAPPER_RESULT_ >> $XML_RET_ - mLipok
	$__iLineNumber=300 & ' - . Renamed: Enums: $XMLWRAPPER_EXT_ >> $XML_EXT_ - mLipok•./Include/_XML.au3'
	. Renamed: Enums: $XMLWRAPPER_EXT_ >> $XML_EXT_ - mLipok
	$__iLineNumber=301 & ' - . Renamed: Enums: $XMLWRAPPER_ERROR_ >> $XML_ERR_ - mLipok•./Include/_XML.au3'
	. Renamed: Enums: $XMLWRAPPER_ERROR_ >> $XML_ERR_ - mLipok
	$__iLineNumber=302 & ' - . Renamed: Enums: $NODE_ >> $XML_NODE_ - mLipok•./Include/_XML.au3'
	. Renamed: Enums: $NODE_ >> $XML_NODE_ - mLipok
	$__iLineNumber=303 & ' - . Removed: Parameter: _XML_CreateDOMDocument > $vComErrFunc  ...•./Include/_XML.au3'
	. Removed: Parameter: _XML_CreateDOMDocument > $vComErrFunc - mLipok


	$__iLineNumber=306 & ' - 2016/05/18•./Include/_XML.au3'
	2016/05/18
	$__iLineNumber=307 & ' - "1.1.1.09"•./Include/_XML.au3'
	"1.1.1.09"
	$__iLineNumber=308 & ' - . !!!! UDF RENAMED XMLWrapperEx.au3 >> XML.au3 - mLipok•./Include/_XML.au3'
	. !!!! UDF RENAMED XMLWrapperEx.au3 >> XML.au3 - mLipok
	$__iLineNumber=309 & ' - . Changed: Error Handling: all SetError($XML_ERR_NODEAPPEND, ...•./Include/_XML.au3'
	. Changed: Error Handling: all SetError($XML_ERR_NODEAPPEND, - returns @error as extended - as this is COM ERROR - mLipok
	$__iLineNumber=310 & ' - . Changed: Error Handling: all SetError($XML_ERR_NODECREATE, ...•./Include/_XML.au3'
	. Changed: Error Handling: all SetError($XML_ERR_NODECREATE, - returns @error as extended - as this is COM ERROR - mLipok
	$__iLineNumber=311 & ' - . Removed: Function: _XMLCreateChildNode - as it was duplica ...•./Include/_XML.au3'
	. Removed: Function: _XMLCreateChildNode - as it was duplicate feature with _XML_CreateChildWAttr - mLipok
	$__iLineNumber=312 & ' - .		Thanks to: @scila1996•./Include/_XML.au3'
	.		Thanks to: @scila1996
	$__iLineNumber=313 & ' - .		https://www.autoitscript.com/forum/topic/176895-xmlwrappe ...•./Include/_XML.au3'
	.		https://www.autoitscript.com/forum/topic/176895-xmlwrapperexau3-beta/?do=findComment&comment=1278825
	$__iLineNumber=314 & ' - . Removed: Function: _XMLCreateChildNodeWAttr - as it was on ...•./Include/_XML.au3'
	. Removed: Function: _XMLCreateChildNodeWAttr - as it was only duplicate/wrapper for _XML_CreateChildWAttr - mLipok
	$__iLineNumber=315 & ' - .		Thanks to: @scila1996•./Include/_XML.au3'
	.		Thanks to: @scila1996
	$__iLineNumber=316 & ' - .		https://www.autoitscript.com/forum/topic/176895-xmlwrappe ...•./Include/_XML.au3'
	.		https://www.autoitscript.com/forum/topic/176895-xmlwrapperexau3-beta/?do=findComment&comment=1278825
	$__iLineNumber=317 & ' - . ! EXAMPLES FILE: Modified: XML_My_ErrorParser - mLipok•./Include/_XML.au3'
	. ! EXAMPLES FILE: Modified: XML_My_ErrorParser - mLipok
	$__iLineNumber=318 & ' - . ! EXAMPLES FILE: New: Example_2a__XML_CreateChildWAttr() - ...•./Include/_XML.au3'
	. ! EXAMPLES FILE: New: Example_2a__XML_CreateChildWAttr() - mLipok
	$__iLineNumber=319 & ' - . Removed: Enums: $XML_ERR_SAVEFILERO - New Requirment for s ...•./Include/_XML.au3'
	. Removed: Enums: $XML_ERR_SAVEFILERO - New Requirment for saving - File Can Not Exist - user should manage it by their own - mLipok
	$__iLineNumber=320 & ' - . Renamed: Enums: $XML_ERR_ISNOTVALIDNODESE >> $XML_ERR_ISNO ...•./Include/_XML.au3'
	. Renamed: Enums: $XML_ERR_ISNOTVALIDNODESE >> $XML_ERR_ISNOTVALIDNODETYPE - mLipok
	$__iLineNumber=321 & ' - . Renamed: Enums: $XML_ERR_ISNOTVALIDNODETYPE >> $XML_ERR_IN ...•./Include/_XML.au3'
	. Renamed: Enums: $XML_ERR_ISNOTVALIDNODETYPE >> $XML_ERR_INVALIDNODETYPE - mLipok
	$__iLineNumber=322 & ' - . Renamed: Enums: $XML_ERR_ISNOTVALIDATTRIB >> $XML_ERR_INVA ...•./Include/_XML.au3'
	. Renamed: Enums: $XML_ERR_ISNOTVALIDATTRIB >> $XML_ERR_INVALIDATTRIB - mLipok
	$__iLineNumber=323 & ' - . Renamed: Enums: $XML_ERR_ISNOTVALIDDOMDOC >> $XML_ERR_INVA ...•./Include/_XML.au3'
	. Renamed: Enums: $XML_ERR_ISNOTVALIDDOMDOC >> $XML_ERR_INVALIDDOMDOC - mLipok
	$__iLineNumber=324 & ' - . Removed: $XML_EXT_GENERAL >> $XML_EXT_DEFAULT - mLipok•./Include/_XML.au3'
	. Removed: $XML_EXT_GENERAL >> $XML_EXT_DEFAULT - mLipok
	$__iLineNumber=325 & ' - . Changed: $XML_EXT_.. are reordered - mLipok•./Include/_XML.au3'
	. Changed: $XML_EXT_.. are reordered - mLipok
	$__iLineNumber=326 & ' - . Removed: Function: _XSL_GetDefaultStyleSheet - mLipok•./Include/_XML.au3'
	. Removed: Function: _XSL_GetDefaultStyleSheet - mLipok
	$__iLineNumber=327 & ' - .	This was example from:•./Include/_XML.au3'
	.	This was example from:
	$__iLineNumber=328 & ' - .	http://www.xml.com/lpt/a/1681•./Include/_XML.au3'
	.	http://www.xml.com/lpt/a/1681
	$__iLineNumber=329 & ' - .	But it is: Copyright © 1998-2006 O"Reilly Media, Inc.•./Include/_XML.au3'
	.	But it is: Copyright © 1998-2006 O'Reilly Media, Inc.
	$__iLineNumber=330 & ' - . Renamed: Function: _XMLGetField >> _XML_GetField - mLipok•./Include/_XML.au3'
	. Renamed: Function: _XMLGetField >> _XML_GetField - mLipok
	$__iLineNumber=331 & ' - . Renamed: Function: _XMLGetValue >> _XML_GetValue - mLipok•./Include/_XML.au3'
	. Renamed: Function: _XMLGetValue >> _XML_GetValue - mLipok
	$__iLineNumber=332 & ' - . Renamed: Function: _XMLGetAllAttrib >> _XML_GetAllAttrib - ...•./Include/_XML.au3'
	. Renamed: Function: _XMLGetAllAttrib >> _XML_GetAllAttrib - mLipok
	$__iLineNumber=333 & ' - . Renamed: Function: _XMLSetAttrib >> _XML_SetAttrib - mLipo ...•./Include/_XML.au3'
	. Renamed: Function: _XMLSetAttrib >> _XML_SetAttrib - mLipok
	$__iLineNumber=334 & ' - . New: Function: _XML_InsertChildNode - GMK•./Include/_XML.au3'
	. New: Function: _XML_InsertChildNode - GMK
	$__iLineNumber=335 & ' - . New: Function: _XML_InsertChildWAttr - GMK•./Include/_XML.au3'
	. New: Function: _XML_InsertChildWAttr - GMK
	$__iLineNumber=336 & ' - . Changed: Function: _XML_CreateAttribute - numbers of param ...•./Include/_XML.au3'
	. Changed: Function: _XML_CreateAttribute - numbers of parameters - mLipok
	$__iLineNumber=337 & ' - .			now you must pass an Array with AttributeName and Attrib ...•./Include/_XML.au3'
	.			now you must pass an Array with AttributeName and AttributeValue
	$__iLineNumber=338 & ' - . Fixed: Function: _XMLCreateRootNode - GMK•./Include/_XML.au3'
	. Fixed: Function: _XMLCreateRootNode - GMK
	$__iLineNumber=339 & ' - .		$oXmlDoc.documentElement.appendChild($oChild) >> $oXmlDoc ...•./Include/_XML.au3'
	.		$oXmlDoc.documentElement.appendChild($oChild) >> $oXmlDoc.appendChild($oChild)
	$__iLineNumber=340 & ' - . Fixed: Function: _XMLCreateRootNodeWAttr - GMK•./Include/_XML.au3'
	. Fixed: Function: _XMLCreateRootNodeWAttr - GMK
	$__iLineNumber=341 & ' - .		$oXmlDoc.documentElement.appendChild($oChild_Node) >> $oX ...•./Include/_XML.au3'
	.		$oXmlDoc.documentElement.appendChild($oChild_Node) >> $oXmlDoc.appendChild($oChild_Node)
	$__iLineNumber=342 & ' - . Renamed: Function: _XMLCreateRootChild >> _XML_CreateRootN ...•./Include/_XML.au3'
	. Renamed: Function: _XMLCreateRootChild >> _XML_CreateRootNode - GMK
	$__iLineNumber=343 & ' - .			!!!!!!!! @TODO need to be revisited•./Include/_XML.au3'
	.			!!!!!!!! @TODO need to be revisited
	$__iLineNumber=344 & ' - .•./Include/_XML.au3'
	.
	$__iLineNumber=345 & ' - . Renamed: Function: _XMLCreateRootNodeWAttr >> _XML_CreateR ...•./Include/_XML.au3'
	. Renamed: Function: _XMLCreateRootNodeWAttr >> _XML_CreateRootNodeWAttr - GMK
	$__iLineNumber=346 & ' - . ADDED: #CURRENT# - GMK•./Include/_XML.au3'
	. ADDED: #CURRENT# - GMK
	$__iLineNumber=347 & ' - . ADDED: #IN_PROGESS# - GMK•./Include/_XML.au3'
	. ADDED: #IN_PROGESS# - GMK
	$__iLineNumber=348 & ' - . ADDED: #INTERNAL_USE_ONLY# - GMK•./Include/_XML.au3'
	. ADDED: #INTERNAL_USE_ONLY# - GMK
	$__iLineNumber=349 & ' - . 		!!! Additional Thanks for GMK for testing and many chang ...•./Include/_XML.au3'
	. 		!!! Additional Thanks for GMK for testing and many changes in many Description
	$__iLineNumber=350 & ' - . CleanUp: Function: _XML_GetNodesPath - removed $sNodePathT ...•./Include/_XML.au3'
	. CleanUp: Function: _XML_GetNodesPath - removed $sNodePathTag - mLipok - thanks to GMK
	$__iLineNumber=351 & ' - . CleanUp: Function: _XML_GetParentNodeName - removed $sNode ...•./Include/_XML.au3'
	. CleanUp: Function: _XML_GetParentNodeName - removed $sNodePathTag - mLipok - thanks to GMK
	$__iLineNumber=352 & ' - . CleanUp: Function: removed #include <MsgBoxConstants.au3>  ...•./Include/_XML.au3'
	. CleanUp: Function: removed #include <MsgBoxConstants.au3> - mLipok - thanks to GMK
	$__iLineNumber=353 & ' - . CleanUp: Function: _XML_GetField - removed $oChild - mLipo ...•./Include/_XML.au3'
	. CleanUp: Function: _XML_GetField - removed $oChild - mLipok - thanks to GMK
	$__iLineNumber=354 & ' - . CleanUp: Function: _XML_GetNodesPath - MagicNumber 0 repla ...•./Include/_XML.au3'
	. CleanUp: Function: _XML_GetNodesPath - MagicNumber 0 replaced with $STR_NOCASESENSE - mLipok - thanks to GMK
	$__iLineNumber=355 & ' - . CleanUp: Function: _XML_GetNodesPathInternal - MagicNumber ...•./Include/_XML.au3'
	. CleanUp: Function: _XML_GetNodesPathInternal - MagicNumber 0 replaced with $STR_NOCASESENSE - mLipok - thanks to GMK
	$__iLineNumber=356 & ' - . CleanUp: Function: _XML_GetParentNodeName - MagicNumber 0  ...•./Include/_XML.au3'
	. CleanUp: Function: _XML_GetParentNodeName - MagicNumber 0 replaced with $STR_NOCASESENSE - mLipok - thanks to GMK
	$__iLineNumber=357 & ' - . Renamed: Function: _XMLCreateCDATA >> _XML_CreateCDATA - m ...•./Include/_XML.au3'
	. Renamed: Function: _XMLCreateCDATA >> _XML_CreateCDATA - mLipok - thanks to GMK
	$__iLineNumber=358 & ' - . Rewrite: Function: _XML_GetAllAttrib - Parameters : remove ...•./Include/_XML.au3'
	. Rewrite: Function: _XML_GetAllAttrib - Parameters : removed ByRef $aName, ByRef $aValue - mLipok
	$__iLineNumber=359 & ' - . Fixed Typo: Descripton: Chceck >> Check - mLipok - thanks  ...•./Include/_XML.au3'
	. Fixed Typo: Descripton: Chceck >> Check - mLipok - thanks to GMK
	$__iLineNumber=360 & ' - . Added: Descripton: _XML_GetNodesCount - mLipok - thanks to ...•./Include/_XML.au3'
	. Added: Descripton: _XML_GetNodesCount - mLipok - thanks to GMK
	$__iLineNumber=361 & ' - . Changed: Descripton: _XML_TransformNode - mLipok - thanks  ...•./Include/_XML.au3'
	. Changed: Descripton: _XML_TransformNode - mLipok - thanks to GMK
	$__iLineNumber=362 & ' - . Changed: Descripton: _XML_CreateDOMDocument - mLipok - tha ...•./Include/_XML.au3'
	. Changed: Descripton: _XML_CreateDOMDocument - mLipok - thanks to GMK
	$__iLineNumber=363 & ' - . Added: Descripton: _XML_GetNodeAttributeValue - mLipok - t ...•./Include/_XML.au3'
	. Added: Descripton: _XML_GetNodeAttributeValue - mLipok - thanks to GMK
	$__iLineNumber=364 & ' - . Changed: Descripton: _XML_Misc_Viewer - mLipok - thanks to ...•./Include/_XML.au3'
	. Changed: Descripton: _XML_Misc_Viewer - mLipok - thanks to GMK
	$__iLineNumber=365 & ' - .•./Include/_XML.au3'
	.
	$__iLineNumber=366 & ' - . Changed: Function: _XML_SelectNodes in case of success @ex ...•./Include/_XML.au3'
	. Changed: Function: _XML_SelectNodes in case of success @extended = $oNodesColl.length
	$__iLineNumber=367 & ' - .•./Include/_XML.au3'
	.
	$__iLineNumber=368 & ' - .•./Include/_XML.au3'
	.
	$__iLineNumber=369 & ' - 2016/05/18•./Include/_XML.au3'
	2016/05/18
	$__iLineNumber=370 & ' - "1.1.1.10"•./Include/_XML.au3'
	"1.1.1.10"
	$__iLineNumber=371 & ' - . NEW: Feature: _XML_Tidy:   if Parameter $sEncoding = -1 th ...•./Include/_XML.au3'
	. NEW: Feature: _XML_Tidy:   if Parameter $sEncoding = -1 then .omitXMLDeclaration = true - mLipok
	$__iLineNumber=372 & ' - .			Feature asked by @GMK here:•./Include/_XML.au3'
	.			Feature asked by @GMK here:
	$__iLineNumber=373 & ' - .			https://www.autoitscript.com/forum/topic/176895-xmlau3-v ...•./Include/_XML.au3'
	.			https://www.autoitscript.com/forum/topic/176895-xmlau3-v-11109-formerly-xmlwrapperexau3-beta-support-topic/?do=findComment&comment=1294688
	$__iLineNumber=374 & ' - . Changed: _XML_Tidy(ByRef $oXmlDoc, $sEncoding = -1) - Defa ...•./Include/_XML.au3'
	. Changed: _XML_Tidy(ByRef $oXmlDoc, $sEncoding = -1) - Default value is set to -1    - mLipok
	$__iLineNumber=375 & ' - . New:	XML__Example_TIDY.au3 - mLipok•./Include/_XML.au3'
	. New:	XML__Example_TIDY.au3 - mLipok
	$__iLineNumber=376 & ' - .•./Include/_XML.au3'
	.
	$__iLineNumber=377 & ' - .•./Include/_XML.au3'
	.
	$__iLineNumber=378 & ' - 2016/06/16•./Include/_XML.au3'
	2016/06/16
	$__iLineNumber=379 & ' - "1.1.1.11"•./Include/_XML.au3'
	"1.1.1.11"
	$__iLineNumber=380 & ' - . NEW: Function: __XML_IsValidObject_DOMDocumentOrElement -  ...•./Include/_XML.au3'
	. NEW: Function: __XML_IsValidObject_DOMDocumentOrElement - mLipok
	$__iLineNumber=381 & ' - . Changed: Function: _XML_SelectNodes - parameter validation ...•./Include/_XML.au3'
	. Changed: Function: _XML_SelectNodes - parameter validation __XML_IsValidObject_DOMDocumentOrElement - mLipok
	$__iLineNumber=382 & ' - . 		Currently _XML_SelectNodes can use relative XPath•./Include/_XML.au3'
	. 		Currently _XML_SelectNodes can use relative XPath
	$__iLineNumber=383 & ' - . Changed: Function: _XML_SelectSingleNode - parameter valid ...•./Include/_XML.au3'
	. Changed: Function: _XML_SelectSingleNode - parameter validation __XML_IsValidObject_DOMDocumentOrElement - mLipok
	$__iLineNumber=384 & ' - . 		Currently _XML_SelectSingleNode can use relative XPath•./Include/_XML.au3'
	. 		Currently _XML_SelectSingleNode can use relative XPath
	$__iLineNumber=385 & ' - . Refactored: Function: _XML_CreateComment - mLipok•./Include/_XML.au3'
	. Refactored: Function: _XML_CreateComment - mLipok
	$__iLineNumber=386 & ' - . Changed: Function: @error > $XML_ERR_COMERROR - mLipok•./Include/_XML.au3'
	. Changed: Function: @error > $XML_ERR_COMERROR - mLipok
	$__iLineNumber=387 & ' - . Fixed: Function: _XML_Array_GetNodesProperties - properly  ...•./Include/_XML.au3'
	. Fixed: Function: _XML_Array_GetNodesProperties - properly gets all attributes - mLipok
	$__iLineNumber=388 & ' - .•./Include/_XML.au3'
	.
	$__iLineNumber=389 & ' - . EXAMPLES: New, and checked/refactored/fixed•./Include/_XML.au3'
	. EXAMPLES: New, and checked/refactored/fixed
	$__iLineNumber=390 & ' - .	XML__Examples_TIDY.au3•./Include/_XML.au3'
	.	XML__Examples_TIDY.au3
	$__iLineNumber=391 & ' - .	XML__Examples_User__asdf1nit.au3•./Include/_XML.au3'
	.	XML__Examples_User__asdf1nit.au3
	$__iLineNumber=392 & ' - .	XML__Examples_User_coma.au3•./Include/_XML.au3'
	.	XML__Examples_User_coma.au3
	$__iLineNumber=393 & ' - .	XML__Examples_User_Realm.au3•./Include/_XML.au3'
	.	XML__Examples_User_Realm.au3
	$__iLineNumber=394 & ' - .	XML__Examples_User_scila1996.au3•./Include/_XML.au3'
	.	XML__Examples_User_scila1996.au3
	$__iLineNumber=395 & ' - .	XML__Examples_User_DarkAqua__Tasks.au3•./Include/_XML.au3'
	.	XML__Examples_User_DarkAqua__Tasks.au3
	$__iLineNumber=396 & ' - .•./Include/_XML.au3'
	.
	$__iLineNumber=397 & ' - .•./Include/_XML.au3'
	.



	$__iLineNumber=401 & ' - @LAST - this keyword is usefull for quick jumping here•./Include/_XML.au3'
	@LAST - this keyword is usefull for quick jumping here

	$__iLineNumber=403 & ' - TODO LIST:•./Include/_XML.au3'
	TODO LIST:
	$__iLineNumber=404 & ' - . TODO CHECK: _XML_GetField, _XML_GetValue•./Include/_XML.au3'
	. TODO CHECK: _XML_GetField, _XML_GetValue
	$__iLineNumber=405 & ' - . @WIP TODO: COUNT = 54•./Include/_XML.au3'
	. @WIP TODO: COUNT = 54
	$__iLineNumber=406 & ' - . TODO: Description, Function Header CleanUp (are still old)•./Include/_XML.au3'
	. TODO: Description, Function Header CleanUp (are still old)
	$__iLineNumber=407 & ' - . TODO: browse entire UDF for TODO "Keyword"•./Include/_XML.au3'
	. TODO: browse entire UDF for TODO "Keyword"
	$__iLineNumber=408 & ' - . TODO: Return SetError($XML_ERR_GENERAL ... should be used  ...•./Include/_XML.au3'
	. TODO: Return SetError($XML_ERR_GENERAL ... should be used only once per function
	$__iLineNumber=409 & ' - . TODO: Return SetError($XML_ERR_GENERAL ... should be alway ...•./Include/_XML.au3'
	. TODO: Return SetError($XML_ERR_GENERAL ... should be always ONLY as the last Error returned from function
	$__iLineNumber=410 & ' - . TODO: $XML_ERR_ .... should be reordered it will be SCRIPT ...•./Include/_XML.au3'
	. TODO: $XML_ERR_ .... should be reordered it will be SCRIPT BREAKING CHANGES: only if used MAGIC NUMBERS for @error checking
	$__iLineNumber=411 & ' - . TODO: GMK: What"s a better way to insert a node before a s ...•./Include/_XML.au3'
	. TODO: GMK: What's a better way to insert a node before a specified node object or XPath for _XML_InsertChildNode and _XML_InsertChildWAttr?  Replace $iItem with $oInsertBeforeNode?
	$__iLineNumber=412 & ' - . TODO: GMK: Rename _XML_Transform ==> _XML_TransformNodeToO ...•./Include/_XML.au3'
	. TODO: GMK: Rename _XML_Transform ==> _XML_TransformNodeToObj (?)
	$__iLineNumber=413 & ' - . TODO: GMK: Why not combine _XML_UpdateField and _XML_Updat ...•./Include/_XML.au3'
	. TODO: GMK: Why not combine _XML_UpdateField and _XML_UpdateField2?  Would inputting parameters for a single node XPath not work the same for _XML_UpdateField2 as it would for _XML_UpdateField?

#CE

; #CURRENT# =====================================================================================================================
; _XML_CreateAttribute
; _XML_CreateComment
; _XML_DeleteNote
; _XML_GetChildren
; _XML_GetChildText
; _XML_GetNodesPath
; _XML_GetNodesPathInternal
; _XML_GetParentNodeName
; _XML_RemoveAttributeNode
; _XML_ReplaceChild
; _XML_Transform
; _XML_UpdateField
; _XML_UpdateField2
; _XML_ValidateFile
; _XML_CreateCDATA
; _XML_CreateChildNode
; _XML_CreateRootNode
; _XML_CreateRootNodeWAttr
; _XML_GetAllAttrib
; _XML_GetAllAttribIndex
; _XML_GetField
; _XML_GetValue
; _XML_SetAttrib
; _XML_CreateChildWAttr
; _XML_CreateDOMDocument
; _XML_CreateFile
; _XML_GetChildNodes
; _XML_GetNodeAttributeValue
; _XML_Load
; _XML_LoadXML
; _XML_NodeExists
; _XML_SaveToFile
; _XML_SelectNodes
; _XML_SelectSingleNode
; _XML_Tidy
; _XML_Misc_GetDomVersion
; _XML_Misc_Viewer
; _XML_MiscProperty_UDFVersion
; _XML_Array_AddName
; _XML_Array_GetAttributesProperties
; _XML_Array_GetNodesProperties
; _XML_ErrorParser_GetDescription

; #IN_PROGESS# ==================================================================================================================
; _XML_InsertChildNode
; _XML_InsertChildWAttr
; _XML_GetNodesCount
; _XML_RemoveAttribute
; _XML_TransformNode
; _XML_MiscProperty_Encoding

; #INTERNAL_USE_ONLY# ===========================================================================================================
; __XML_IsValidObject_Attributes
; __XML_IsValidObject_DOMDocument
; __XML_IsValidObject_DOMDocumentOrElement
; __XML_IsValidObject_Node
; __XML_IsValidObject_NodesColl
; __XML_MiscProperty_DomVersion
; __XML_ComErrorHandler_InternalFunction
; __XML_ComErrorHandler_UserFunction

#EndRegion XML.au3 - UDF Header

; #VARIABLES# ===================================================================================================================
#Region XML.au3 - Enumeration - ERROR EXTENDED RETURN
$__iLineNumber=483 & ' - Global Enum _•./Include/_XML.au3'
Global Enum _
		$XML_ERR_OK, _ ; 				All is ok
		$XML_ERR_GENERAL, _ ; 			The error which is not specifically defined.
		$XML_ERR_COMERROR, _ ; 			COM Error occured - Check @extended for COMERROR Number or check you COM Error Handler Function
		$XML_ERR_DOMVERSION, _ ; 		Check @extended for required DOM Version
		$XML_ERR_ISNOTOBJECT, _ ; 		No object passed to function.
		$XML_ERR_INVALIDDOMDOC, _ ; 	Invalid object passed to function - expected Document.
		$XML_ERR_INVALIDATTRIB, _ ; 	Invalid object passed to function - expected Attrib Element.
		$XML_ERR_INVALIDNODETYPE, _ ; 	Invalid object passed to function - expected Node Element.
		$XML_ERR_OBJCREATE, _ ; 		Object can not be created.
		$XML_ERR_NODECREATE, _ ; 		Can not create Node - check also extended for node type
		$XML_ERR_NODEAPPEND, _ ; 		Can not append Node - check also extended for node type
		$XML_ERR_PARSE, _ ; 			Error with Parsing objects use _XML_ErrorParser_GetDescription() for Get details
		$XML_ERR_PARSE_XSL, _ ; 		Error with Parsing XSL objects use _XML_ErrorParser_GetDescription() for Get details
		$XML_ERR_LOAD, _ ; 				Error opening specified file.
		$XML_ERR_SAVE, _ ; 				Error saving file.
		$XML_ERR_PARAMETER, _ ; 		Wrong parameter passed to function.
		$XML_ERR_ARRAY, _ ; 			Wrong array parameter passed to function. Check array dimension and conent.
		$XML_ERR_XPATH, _ ; 			XPath syntax error - you should check also COM Error Handler.
		$XML_ERR_NONODESMATCH, _ ;  	No nodes match the XPath expression
		$XML_ERR_NOCHILDMATCH, _ ; 		There is no Child in nodes matched by XPath expression.
		$XML_ERR_NOATTRMATCH, _ ; 		There is no such attribute in selected node.
		$XML_ERR_EMPTYCOLLECTION, _ ; 	Collections of objects was empty
		$XML_ERR_EMPTYOBJECT, _ ; 		Object is empty
		$XML_ERR_ENUMCOUNTER ; not used in UDF - just for other/future testing
$__iLineNumber=508 & ' - Global Enum _•./Include/_XML.au3'
Global Enum _
		$XML_EXT_DEFAULT, _ ; 					Default - Do not return any additional information, The extended which is not specifically defined.
		$XML_EXT_PARAM1, _ ;					Error Occurs in 1-Parameter
		$XML_EXT_PARAM2, _ ;					Error Occurs in 2-Parameter
		$XML_EXT_PARAM3, _ ;					Error Occurs in 3-Parameter
		$XML_EXT_PARAM4, _ ;					Error Occurs in 4-Parameter
		$XML_EXT_PARAM5, _ ;					Error Occurs in 5-Parameter
		$XML_EXT_PARAM6, _ ;					Error Occurs in 6-Parameter
		$XML_EXT_XMLDOM, _ ; 					"Microsoft.XMLDOM" related Error
		$XML_EXT_DOMDOCUMENT, _ ; 				"Msxml2.DOMDocument" related Error
		$XML_EXT_XSLTEMPLATE, _ ; 				"Msxml2.XSLTemplate" related Error
		$XML_EXT_SAXXMLREADER, _ ; 				"MSXML2.SAXXMLReader" related Error
		$XML_EXT_MXXMLWRITER, _ ; 				"MSXML2.MXXMLWriter" related Error
		$XML_EXT_FREETHREADEDDOMDOCUMENT, _ ; 	"Msxml2.FreeThreadedDOMDocument" related Error
		$XML_EXT_XMLSCHEMACACHE, _ ; 			"Msxml2.XMLSchemaCache." related Error
		$XML_EXT_STREAM, _ ; 					"ADODB.STREAM" related Error
		$XML_EXT_ENCODING, _ ; 					Encoding related Error
		$XML_EXT_ENUMCOUNTER ; not used in UDF - just for other/future testing
$__iLineNumber=526 & ' - Global Enum _•./Include/_XML.au3'
Global Enum _
		$XML_RET_FAILURE, _ ;			UDF Default Failure Return Value
		$XML_RET_SUCCESS, _ ;			UDF Default Success Return Value
		$XML_RET_ENUMCOUNTER ; not used in UDF - just for other/future testing
#EndRegion XML.au3 - Enumeration - ERROR EXTENDED RETURN

#Region XML.au3 - ARRAY Enums
; Enums for _XML_Array_GetAttributesProperties() function
$__iLineNumber=534 & ' - Global Enum _•./Include/_XML.au3'
Global Enum _
		$__g_eARRAY_ATTR_NAME, _
		$__g_eARRAY_ATTR_TYPESTRING, _
		$__g_eARRAY_ATTR_VALUE, _
		$__g_eARRAY_ATTR_TEXT, _
		$__g_eARRAY_ATTR_DATATYPE, _
		$__g_eARRAY_ATTR_XML, _
		$__g_eARRAY_ATTR_ARRAYCOLCOUNT
; Enums for _XML_Array_GetNodesProperties() function
$__iLineNumber=543 & ' - Global Enum _•./Include/_XML.au3'
Global Enum _
		$__g_eARRAY_NODE_NAME, _
		$__g_eARRAY_NODE_TYPESTRING, _
		$__g_eARRAY_NODE_VALUE, _
		$__g_eARRAY_NODE_TEXT, _
		$__g_eARRAY_NODE_DATATYPE, _
		$__g_eARRAY_NODE_XML, _
		$__g_eARRAY_NODE_ATTRIBUTES, _
		$__g_eARRAY_NODE_ARRAYCOLCOUNT
#EndRegion XML.au3 - ARRAY Enums

#Region XML.au3 - XML DOM Enumerated Constants
;~ https://msdn.microsoft.com/en-us/library/ms766473(v=vs.85).aspx
$__iLineNumber=556 & ' - Global Const $XML_NODE_ELEMENT = 1•./Include/_XML.au3'
Global Const $XML_NODE_ELEMENT = 1
$__iLineNumber=557 & ' - Global Const $XML_NODE_ATTRIBUTE = 2•./Include/_XML.au3'
Global Const $XML_NODE_ATTRIBUTE = 2
$__iLineNumber=558 & ' - Global Const $XML_NODE_TEXT = 3•./Include/_XML.au3'
Global Const $XML_NODE_TEXT = 3
$__iLineNumber=559 & ' - Global Const $XML_NODE_CDATA_SECTION = 4•./Include/_XML.au3'
Global Const $XML_NODE_CDATA_SECTION = 4
$__iLineNumber=560 & ' - Global Const $XML_NODE_ENTITY_REFERENCE = 5•./Include/_XML.au3'
Global Const $XML_NODE_ENTITY_REFERENCE = 5
$__iLineNumber=561 & ' - Global Const $XML_NODE_ENTITY = 6•./Include/_XML.au3'
Global Const $XML_NODE_ENTITY = 6
$__iLineNumber=562 & ' - Global Const $XML_NODE_PROCESSING_INSTRUCTION = 7•./Include/_XML.au3'
Global Const $XML_NODE_PROCESSING_INSTRUCTION = 7
$__iLineNumber=563 & ' - Global Const $XML_NODE_COMMENT = 8•./Include/_XML.au3'
Global Const $XML_NODE_COMMENT = 8
$__iLineNumber=564 & ' - Global Const $XML_NODE_DOCUMENT = 9•./Include/_XML.au3'
Global Const $XML_NODE_DOCUMENT = 9
$__iLineNumber=565 & ' - Global Const $XML_NODE_DOCUMENT_TYPE = 10•./Include/_XML.au3'
Global Const $XML_NODE_DOCUMENT_TYPE = 10
$__iLineNumber=566 & ' - Global Const $XML_NODE_DOCUMENT_FRAGMENT = 11•./Include/_XML.au3'
Global Const $XML_NODE_DOCUMENT_FRAGMENT = 11
$__iLineNumber=567 & ' - Global Const $XML_NODE_NOTATION = 12•./Include/_XML.au3'
Global Const $XML_NODE_NOTATION = 12
#EndRegion XML.au3 - XML DOM Enumerated Constants

#Region XML.au3 - readyState Property (DOMDocument)
;~ https://msdn.microsoft.com/en-us/library/ms753702(v=vs.85).aspx
$__iLineNumber=572 & ' - Global Const $XML_DOCUMENT_READYSTATE_LOADING = 1•./Include/_XML.au3'
Global Const $XML_DOCUMENT_READYSTATE_LOADING = 1
$__iLineNumber=573 & ' - Global Const $XML_DOCUMENT_READYSTATE_LOADED = 2•./Include/_XML.au3'
Global Const $XML_DOCUMENT_READYSTATE_LOADED = 2
$__iLineNumber=574 & ' - Global Const $XML_DOCUMENT_READYSTATE_INTERACTIVE = 3•./Include/_XML.au3'
Global Const $XML_DOCUMENT_READYSTATE_INTERACTIVE = 3
$__iLineNumber=575 & ' - Global Const $XML_DOCUMENT_READYSTATE_COMPLETED = 4•./Include/_XML.au3'
Global Const $XML_DOCUMENT_READYSTATE_COMPLETED = 4
#EndRegion XML.au3 - readyState Property (DOMDocument)

#Region XML.au3 - Functions - Not yet reviewed
; ===============================================================================================================================
; XMLWrapper functions

; #FUNCTION# ====================================================================================================================
; Name ..........: _XML_CreateAttribute
; Description ...: Adds an XML Attribute to specified node.
; Syntax ........: _XML_CreateAttribute(Byref $oXmlDoc, $sXPath, $asAttributeList)
; Parameters ....: $oXmlDoc             - [in/out] an object. A valid DOMDocument or IXMLDOMElement object.
;                  $sXPath              - a string value. The XML tree path from root node (root/child/child..)
;                  $asAttributeList		- an array of strings. Column0=AtributeName, Column1=AtributeValue
; Return values .: On Success      	    - Returns $XML_RET_SUCCESS
;                  On Failure           - Returns $XML_RET_FAILURE and sets the @error flag to non-zero (look in #Region XML.au3 - ERROR Enums)
; Author ........: Eltorro
; Modified ......: mLipok, GMK
; Remarks .......:
; Related .......: https://msdn.microsoft.com/en-us/library/ms754616(v=vs.85).aspx
; Link ..........: https://msdn.microsoft.com/en-us/library/ms764615(v=vs.85).aspx
; Example .......: Yes
; ===============================================================================================================================
$__iLineNumber=598 & ' - Func _XML_CreateAttribute(ByRef $oXmlDoc, $sXPath, $asAttrib ...•./Include/_XML.au3'
Func _XML_CreateAttribute(ByRef $oXmlDoc, $sXPath, $asAttributeList)
	; Local Error handler declaration, it will be automatic CleanUp when returning from function
	$__iLineNumber=600 & ' - Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XM ...•./Include/_XML.au3'
	Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XML_ComErrorHandler_InternalFunction)
	#forceref $oXML_COM_ErrorHandler

	$__iLineNumber=603 & ' - Local $oNode_Selected = _XML_SelectSingleNode($oXmlDoc, $sXP ...•./Include/_XML.au3'
	Local $oNode_Selected = _XML_SelectSingleNode($oXmlDoc, $sXPath)
	$__iLineNumber=604 & ' - If @error Then Return SetError(@error, @extended, $XML_RET_F ...•./Include/_XML.au3'
	If @error Then Return SetError(@error, @extended, $XML_RET_FAILURE)

	$__iLineNumber=606 & ' - If Not UBound($asAttributeList) Or UBound($asAttributeList,  ...•./Include/_XML.au3'
	If Not UBound($asAttributeList) Or UBound($asAttributeList, $UBOUND_COLUMNS) <> 2 Then
		$__iLineNumber=607 & ' - Return SetError($XML_ERR_PARAMETER, $XML_EXT_PARAM3, $XML_RE ...•./Include/_XML.au3'
		Return SetError($XML_ERR_PARAMETER, $XML_EXT_PARAM3, $XML_RET_FAILURE)
	EndIf

	$__iLineNumber=610 & ' - Local Enum $eAttribute_Name, $eAttribute_Value•./Include/_XML.au3'
	Local Enum $eAttribute_Name, $eAttribute_Value
	$__iLineNumber=611 & ' - Local $oAttribute = Null•./Include/_XML.au3'
	Local $oAttribute = Null
	#forceref $oAttribute
	$__iLineNumber=613 & ' - For $iAttribute_idx = 0 To UBound($asAttributeList) - 1•./Include/_XML.au3'
	For $iAttribute_idx = 0 To UBound($asAttributeList) - 1
		$__iLineNumber=614 & ' - $oAttribute = $oXmlDoc.createAttribute($asAttributeList[$iAt ...•./Include/_XML.au3'
		$oAttribute = $oXmlDoc.createAttribute($asAttributeList[$iAttribute_idx][$eAttribute_Name]) ;, $sNameSpace) ; TODO Check why $sNameSpace
		$__iLineNumber=615 & ' - If @error Then Return SetError($XML_ERR_COMERROR, @error, $X ...•./Include/_XML.au3'
		If @error Then Return SetError($XML_ERR_COMERROR, @error, $XML_RET_FAILURE)

		$__iLineNumber=617 & ' - $oNode_Selected.SetAttribute($asAttributeList[$iAttribute_id ...•./Include/_XML.au3'
		$oNode_Selected.SetAttribute($asAttributeList[$iAttribute_idx][$eAttribute_Name], $asAttributeList[$iAttribute_idx][$eAttribute_Value])
		$__iLineNumber=618 & ' - If $oXmlDoc.parseError.errorCode Then•./Include/_XML.au3'
		If $oXmlDoc.parseError.errorCode Then
			$__iLineNumber=619 & ' - Return SetError($XML_ERR_PARSE, $oXmlDoc.parseError.errorCod ...•./Include/_XML.au3'
			Return SetError($XML_ERR_PARSE, $oXmlDoc.parseError.errorCode, $XML_RET_FAILURE)
		EndIf
	Next

	; CleanUp
	$__iLineNumber=624 & ' - $oAttribute = Null•./Include/_XML.au3'
	$oAttribute = Null
	$__iLineNumber=625 & ' - $oNode_Selected = Null•./Include/_XML.au3'
	$oNode_Selected = Null
	$__iLineNumber=626 & ' - Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCC ...•./Include/_XML.au3'
	Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCCESS)

EndFunc   ;==>_XML_CreateAttribute

; #FUNCTION# ====================================================================================================================
; Name ..........: _XML_CreateCDATA
; Description ...: Create a CDATA SECTION node directly under root.
; Syntax ........: _XML_CreateCDATA(ByRef $oXmlDoc, $sNode, $sCDATA[, $sNameSpace = ""])
; Parameters ....: $oXmlDoc    - [in/out] an object. A valid DOMDocument object.
;                  $sNode      - a string value. name of node to create
;                  $sCDATA     - a string value. CDATA value
;                  $sNameSpace - a string value. the namespace to specifiy if the xml uses one.
; Return values .: On Success  - Returns $XML_RET_SUCCESS
;                  On Failure  - Returns $XML_RET_FAILURE and sets the @error flag to non-zero (look in #Region XML.au3 - ERROR Enums)
; Author ........: Eltorro
; Modified ......: mLipok
; Remarks .......: fixme, won't append to exisiting node. must create new node.
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ===============================================================================================================================
$__iLineNumber=647 & ' - Func _XML_CreateCDATA(ByRef $oXmlDoc, $sNode, $sCDATA, $sNam ...•./Include/_XML.au3'
Func _XML_CreateCDATA(ByRef $oXmlDoc, $sNode, $sCDATA, $sNameSpace = "")
	; Local Error handler declaration, it will be automatic CleanUp when returning from function
	$__iLineNumber=649 & ' - Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XM ...•./Include/_XML.au3'
	Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XML_ComErrorHandler_InternalFunction)
	#forceref $oXML_COM_ErrorHandler

	$__iLineNumber=652 & ' - __XML_IsValidObject_DOMDocument($oXmlDoc)•./Include/_XML.au3'
	__XML_IsValidObject_DOMDocument($oXmlDoc)
	$__iLineNumber=653 & ' - If @error Then Return SetError(@error, @extended, $XML_RET_F ...•./Include/_XML.au3'
	If @error Then Return SetError(@error, @extended, $XML_RET_FAILURE)

	$__iLineNumber=655 & ' - Local $oNode = $oXmlDoc.createNode($XML_NODE_ELEMENT, $sNode ...•./Include/_XML.au3'
	Local $oNode = $oXmlDoc.createNode($XML_NODE_ELEMENT, $sNode, $sNameSpace)
	$__iLineNumber=656 & ' - If @error Then Return SetError($XML_ERR_NODECREATE, @error,  ...•./Include/_XML.au3'
	If @error Then Return SetError($XML_ERR_NODECREATE, @error, $XML_RET_FAILURE)

	$__iLineNumber=658 & ' - If IsObj($oNode) Then•./Include/_XML.au3'
	If IsObj($oNode) Then
		$__iLineNumber=659 & ' - Local $oChild = $oXmlDoc.createCDATASection($sCDATA)•./Include/_XML.au3'
		Local $oChild = $oXmlDoc.createCDATASection($sCDATA)
		$__iLineNumber=660 & ' - $oNode.appendChild($oChild)•./Include/_XML.au3'
		$oNode.appendChild($oChild)
		$__iLineNumber=661 & ' - If @error Then Return SetError($XML_ERR_NODEAPPEND, @error,  ...•./Include/_XML.au3'
		If @error Then Return SetError($XML_ERR_NODEAPPEND, @error, $XML_RET_FAILURE)

		$__iLineNumber=663 & ' - $oXmlDoc.documentElement.appendChild($oNode)•./Include/_XML.au3'
		$oXmlDoc.documentElement.appendChild($oNode)
		$__iLineNumber=664 & ' - If @error Then Return SetError($XML_ERR_NODEAPPEND, @error,  ...•./Include/_XML.au3'
		If @error Then Return SetError($XML_ERR_NODEAPPEND, @error, $XML_RET_FAILURE)

		$__iLineNumber=666 & ' - $oChild = Null•./Include/_XML.au3'
		$oChild = Null
		$__iLineNumber=667 & ' - Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCC ...•./Include/_XML.au3'
		Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCCESS)
	EndIf

	$__iLineNumber=670 & ' - Return SetError($XML_ERR_GENERAL, $XML_EXT_DEFAULT, $XML_RET ...•./Include/_XML.au3'
	Return SetError($XML_ERR_GENERAL, $XML_EXT_DEFAULT, $XML_RET_FAILURE)

EndFunc   ;==>_XML_CreateCDATA

; #FUNCTION# ====================================================================================================================
; Name ..........: _XML_CreateComment
; Description ...: Create a COMMENT node at specified path.
; Syntax ........: _XML_CreateComment(ByRef $oXmlDoc, $sXPath, $sComment)
; Parameters ....: $oXmlDoc   - [in/out] an object. A valid DOMDocument or IXMLDOMElement object.
;                  $sXPath    - a string value. The XML tree path from root node (root/child/child..)
;                  $sComment  - a string value. The comment to add the to the xml file.
; Return values .: On Success - Returns $XML_RET_SUCCESS
;                  On Failure - Returns $XML_RET_FAILURE and sets the @error flag to non-zero (look in #Region XML.au3 - ERROR Enums)
; Author ........: Eltorro
; Modified ......: mLipok
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ===============================================================================================================================
$__iLineNumber=690 & ' - Func _XML_CreateComment(ByRef $oXmlDoc, $sXPath, $sComment)•./Include/_XML.au3'
Func _XML_CreateComment(ByRef $oXmlDoc, $sXPath, $sComment)
	; Local Error handler declaration, it will be automatic CleanUp when returning from function
	$__iLineNumber=692 & ' - Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XM ...•./Include/_XML.au3'
	Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XML_ComErrorHandler_InternalFunction)
	#forceref $oXML_COM_ErrorHandler

	$__iLineNumber=695 & ' - Local $oNode_Selected = _XML_SelectSingleNode($oXmlDoc, $sXP ...•./Include/_XML.au3'
	Local $oNode_Selected = _XML_SelectSingleNode($oXmlDoc, $sXPath)
	$__iLineNumber=696 & ' - If @error Then Return SetError(@error, @extended, $XML_RET_F ...•./Include/_XML.au3'
	If @error Then Return SetError(@error, @extended, $XML_RET_FAILURE)

	$__iLineNumber=698 & ' - Local $oChild = $oXmlDoc.createComment($sComment)•./Include/_XML.au3'
	Local $oChild = $oXmlDoc.createComment($sComment)
	$__iLineNumber=699 & ' - $oNode_Selected.insertBefore($oChild, $oNode_Selected.childN ...•./Include/_XML.au3'
	$oNode_Selected.insertBefore($oChild, $oNode_Selected.childNodes(0))
	$__iLineNumber=700 & ' - If @error Then•./Include/_XML.au3'
	If @error Then
		$__iLineNumber=701 & ' - Return SetError($XML_ERR_COMERROR, @error, $XML_RET_SUCCESS)•./Include/_XML.au3'
		Return SetError($XML_ERR_COMERROR, @error, $XML_RET_SUCCESS)
	ElseIf $oXmlDoc.parseError.errorCode Then
		$__iLineNumber=703 & ' - Return SetError($XML_ERR_PARSE, $oXmlDoc.parseError.errorCod ...•./Include/_XML.au3'
		Return SetError($XML_ERR_PARSE, $oXmlDoc.parseError.errorCode, $XML_RET_FAILURE)
	EndIf

	$__iLineNumber=706 & ' - Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCC ...•./Include/_XML.au3'
	Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCCESS) ; TODO Check for what we need to return on success

EndFunc   ;==>_XML_CreateComment

; #FUNCTION# ====================================================================================================================
; Name ..........: _XML_CreateRootNode
; Description ...: Create node directly under root.
; Syntax ........: _XML_CreateRootNode(ByRef $oXmlDoc, $sNode[, $sData = ""[, $sNameSpace = ""]])
; Parameters ....: $oXmlDoc    - [in/out] an object. A valid DOMDocument object.
;                  $sNode      - a string value. The name of node to create.
;                  $sData      - a string value. The optional value to create
;                  $sNameSpace - a string value. the namespace to specifiy if the file uses one.
; Return values .: On Success  - Returns $XML_RET_SUCCESS
;                  On Failure  - Returns $XML_RET_FAILURE and sets the @error flag to non-zero (look in #Region XML.au3 - ERROR Enums)
; Author ........: Eltorro
; Modified ......: mLipok, GMK
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ===============================================================================================================================
$__iLineNumber=727 & ' - Func _XML_CreateRootNode(ByRef $oXmlDoc, $sNode, $sData = "" ...•./Include/_XML.au3'
Func _XML_CreateRootNode(ByRef $oXmlDoc, $sNode, $sData = "", $sNameSpace = "")
	; Local Error handler declaration, it will be automatic CleanUp when returning from function
	$__iLineNumber=729 & ' - Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XM ...•./Include/_XML.au3'
	Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XML_ComErrorHandler_InternalFunction)
	#forceref $oXML_COM_ErrorHandler

	$__iLineNumber=732 & ' - __XML_IsValidObject_DOMDocument($oXmlDoc)•./Include/_XML.au3'
	__XML_IsValidObject_DOMDocument($oXmlDoc)
	$__iLineNumber=733 & ' - If @error Then Return SetError(@error, @extended, $XML_RET_F ...•./Include/_XML.au3'
	If @error Then Return SetError(@error, @extended, $XML_RET_FAILURE)

	$__iLineNumber=735 & ' - Local $oChild = $oXmlDoc.createNode($XML_NODE_ELEMENT, $sNod ...•./Include/_XML.au3'
	Local $oChild = $oXmlDoc.createNode($XML_NODE_ELEMENT, $sNode, $sNameSpace)
	$__iLineNumber=736 & ' - If @error Then Return SetError($XML_ERR_NODECREATE, @error,  ...•./Include/_XML.au3'
	If @error Then Return SetError($XML_ERR_NODECREATE, @error, $XML_RET_FAILURE)

	$__iLineNumber=738 & ' - If IsObj($oChild) Then•./Include/_XML.au3'
	If IsObj($oChild) Then
		$__iLineNumber=739 & ' - If $sData <> "" Then $oChild.text = $sData•./Include/_XML.au3'
		If $sData <> "" Then $oChild.text = $sData
		$__iLineNumber=740 & ' - $oXmlDoc.appendChild($oChild)•./Include/_XML.au3'
		$oXmlDoc.appendChild($oChild)
		$__iLineNumber=741 & ' - If @error Then Return SetError($XML_ERR_NODEAPPEND, @error,  ...•./Include/_XML.au3'
		If @error Then Return SetError($XML_ERR_NODEAPPEND, @error, $XML_RET_FAILURE)

		$__iLineNumber=743 & ' - $oChild = 0•./Include/_XML.au3'
		$oChild = 0
		$__iLineNumber=744 & ' - Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCC ...•./Include/_XML.au3'
		Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCCESS)
	EndIf

	$__iLineNumber=747 & ' - Return SetError($XML_ERR_GENERAL, $XML_EXT_DEFAULT, $XML_RET ...•./Include/_XML.au3'
	Return SetError($XML_ERR_GENERAL, $XML_EXT_DEFAULT, $XML_RET_FAILURE)

EndFunc   ;==>_XML_CreateRootNode

; #FUNCTION# ====================================================================================================================
; Name ..........: _XML_CreateRootNodeWAttr
; Description ...: Create a child node under root node with attributes.
; Syntax.........: _XML_CreateRootNodeWAttr($sNode, $aAttribute_Names, $aAttribute_Values[, $sData = ""[, $sNameSpace = ""]])
; Parameters ....: $sNode       - The node to add with attibute(s)
;                  $aAttribute_Names         - The attribute name(s) -- can be array
;                  $aAttribute_Values          - The	attribute value(s) -- can be array
;                  $sData       - The optional value to give the node.
; Return values .: Success        $XML_RET_SUCCESS
;                  Failure             - $XML_RET_FAILURE and sets the @error flag to non-zero (look in #Region XML.au3 - ERROR Enums)
; Author ........: Eltorro
; Modified ......: mLipok
; Remarks .......: This function requires that each attribute name has a corresponding value.
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ===============================================================================================================================
$__iLineNumber=768 & ' - Func _XML_CreateRootNodeWAttr(ByRef $oXmlDoc, $sNode, $aAttr ...•./Include/_XML.au3'
Func _XML_CreateRootNodeWAttr(ByRef $oXmlDoc, $sNode, $aAttribute_Names, $aAttribute_Values, $sData = "", $sNameSpace = "")
	; Local Error handler declaration, it will be automatic CleanUp when returning from function
	$__iLineNumber=770 & ' - Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XM ...•./Include/_XML.au3'
	Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XML_ComErrorHandler_InternalFunction)
	#forceref $oXML_COM_ErrorHandler

	$__iLineNumber=773 & ' - __XML_IsValidObject_DOMDocument($oXmlDoc)•./Include/_XML.au3'
	__XML_IsValidObject_DOMDocument($oXmlDoc)
	$__iLineNumber=774 & ' - If @error Then Return SetError(@error, @extended, $XML_RET_F ...•./Include/_XML.au3'
	If @error Then Return SetError(@error, @extended, $XML_RET_FAILURE)

	$__iLineNumber=776 & ' - Local $oChild_Node = $oXmlDoc.createNode($XML_NODE_ELEMENT,  ...•./Include/_XML.au3'
	Local $oChild_Node = $oXmlDoc.createNode($XML_NODE_ELEMENT, $sNode, $sNameSpace)
	$__iLineNumber=777 & ' - If @error Then Return SetError($XML_ERR_NODECREATE, @error,  ...•./Include/_XML.au3'
	If @error Then Return SetError($XML_ERR_NODECREATE, @error, $XML_RET_FAILURE)

	$__iLineNumber=779 & ' - If IsObj($oChild_Node) Then•./Include/_XML.au3'
	If IsObj($oChild_Node) Then
		$__iLineNumber=780 & ' - If $sData <> "" Then $oChild_Node.text = $sData•./Include/_XML.au3'
		If $sData <> "" Then $oChild_Node.text = $sData

		$__iLineNumber=782 & ' - Local $oAttribute = Null•./Include/_XML.au3'
		Local $oAttribute = Null
		#forceref $oAttribute
		$__iLineNumber=784 & ' - If IsArray($aAttribute_Names) And IsArray($aAttribute_Values ...•./Include/_XML.au3'
		If IsArray($aAttribute_Names) And IsArray($aAttribute_Values) Then
			$__iLineNumber=785 & ' - If UBound($aAttribute_Names) <> UBound($aAttribute_Values) T ...•./Include/_XML.au3'
			If UBound($aAttribute_Names) <> UBound($aAttribute_Values) Then
				$__iLineNumber=786 & ' - Return SetError($XML_ERR_GENERAL, $XML_EXT_DEFAULT, $XML_RET ...•./Include/_XML.au3'
				Return SetError($XML_ERR_GENERAL, $XML_EXT_DEFAULT, $XML_RET_FAILURE)
			EndIf

			$__iLineNumber=789 & ' - For $iAttribute_idx = 0 To UBound($aAttribute_Names) - 1•./Include/_XML.au3'
			For $iAttribute_idx = 0 To UBound($aAttribute_Names) - 1
				$__iLineNumber=790 & ' - If $aAttribute_Names[$iAttribute_idx] = "" Then•./Include/_XML.au3'
				If $aAttribute_Names[$iAttribute_idx] = "" Then
					$__iLineNumber=791 & ' - Return SetError($XML_ERR_GENERAL, $XML_EXT_DEFAULT, $XML_RET ...•./Include/_XML.au3'
					Return SetError($XML_ERR_GENERAL, $XML_EXT_DEFAULT, $XML_RET_FAILURE)
				EndIf

				$__iLineNumber=794 & ' - $oAttribute = $oXmlDoc.createAttribute($aAttribute_Names[$iA ...•./Include/_XML.au3'
				$oAttribute = $oXmlDoc.createAttribute($aAttribute_Names[$iAttribute_idx]) ;, $sNameSpace) ; TODO Check why $sNameSpace
				$__iLineNumber=795 & ' - $oChild_Node.SetAttribute($aAttribute_Names[$iAttribute_idx] ...•./Include/_XML.au3'
				$oChild_Node.SetAttribute($aAttribute_Names[$iAttribute_idx], $aAttribute_Values[$iAttribute_idx])
			Next
		Else
			$__iLineNumber=798 & ' - $oAttribute = $oXmlDoc.createAttribute($aAttribute_Names)•./Include/_XML.au3'
			$oAttribute = $oXmlDoc.createAttribute($aAttribute_Names)
			$__iLineNumber=799 & ' - $oChild_Node.SetAttribute($aAttribute_Names, $aAttribute_Val ...•./Include/_XML.au3'
			$oChild_Node.SetAttribute($aAttribute_Names, $aAttribute_Values)
		EndIf
		$__iLineNumber=801 & ' - $oXmlDoc.appendChild($oChild_Node)•./Include/_XML.au3'
		$oXmlDoc.appendChild($oChild_Node)
		$__iLineNumber=802 & ' - If @error Then Return SetError($XML_ERR_NODEAPPEND, @error,  ...•./Include/_XML.au3'
		If @error Then Return SetError($XML_ERR_NODEAPPEND, @error, $XML_RET_FAILURE)

		$__iLineNumber=804 & ' - $oChild_Node = Null•./Include/_XML.au3'
		$oChild_Node = Null
		$__iLineNumber=805 & ' - Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCC ...•./Include/_XML.au3'
		Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCCESS)
	EndIf

	$__iLineNumber=808 & ' - Return SetError($XML_ERR_GENERAL, $XML_EXT_DEFAULT, $XML_RET ...•./Include/_XML.au3'
	Return SetError($XML_ERR_GENERAL, $XML_EXT_DEFAULT, $XML_RET_FAILURE)

EndFunc   ;==>_XML_CreateRootNodeWAttr

; #FUNCTION# ====================================================================================================================
; Name ..........: _XML_DeleteNode
; Description ...: Deletes XML Node based on XPath input from root node.
; Syntax ........: _XML_DeleteNode(ByRef $oXmlDoc, $sXPath)
; Parameters ....: $oXmlDoc   - [in/out] an object. A valid DOMDocument or IXMLDOMElement object.
;                  $sXPath    - a string value. The XML tree path from root node (root/child/child..)
; Return values .: On Success - Returns $XML_RET_SUCCESS
;                  On Failure - Returns $XML_RET_FAILURE and sets the @error flag to non-zero (look in #Region XML.au3 - ERROR Enums)
;                  |0 - No error
;                  |1 - Deletion error
;                  |2 - No object passed
; Author ........: Eltorro
; Modified ......: mLipok
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ===============================================================================================================================
$__iLineNumber=830 & ' - Func _XML_DeleteNode(ByRef $oXmlDoc, $sXPath)•./Include/_XML.au3'
Func _XML_DeleteNode(ByRef $oXmlDoc, $sXPath)
	; Local Error handler declaration, it will be automatic CleanUp when returning from function
	$__iLineNumber=832 & ' - Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XM ...•./Include/_XML.au3'
	Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XML_ComErrorHandler_InternalFunction)
	#forceref $oXML_COM_ErrorHandler

	$__iLineNumber=835 & ' - Local $oNodesColl = _XML_SelectNodes($oXmlDoc, $sXPath)•./Include/_XML.au3'
	Local $oNodesColl = _XML_SelectNodes($oXmlDoc, $sXPath)
	$__iLineNumber=836 & ' - If @error Then Return SetError(@error, @extended, $XML_RET_F ...•./Include/_XML.au3'
	If @error Then Return SetError(@error, @extended, $XML_RET_FAILURE)

	$__iLineNumber=838 & ' - For $oNode_enum In $oNodesColl•./Include/_XML.au3'
	For $oNode_enum In $oNodesColl
		$__iLineNumber=839 & ' - If $oNode_enum.hasChildNodes Then•./Include/_XML.au3'
		If $oNode_enum.hasChildNodes Then
			$__iLineNumber=840 & ' - For $oNode_enum_Child In $oNode_enum.childNodes•./Include/_XML.au3'
			For $oNode_enum_Child In $oNode_enum.childNodes
				$__iLineNumber=841 & ' - If $oNode_enum_Child.nodeType = $XML_NODE_TEXT Then•./Include/_XML.au3'
				If $oNode_enum_Child.nodeType = $XML_NODE_TEXT Then
					$__iLineNumber=842 & ' - If StringStripWS($oNode_enum_Child.text, $STR_STRIPLEADING + ...•./Include/_XML.au3'
					If StringStripWS($oNode_enum_Child.text, $STR_STRIPLEADING + $STR_STRIPTRAILING + $STR_STRIPSPACES) = "" Then
						$__iLineNumber=843 & ' - $oNode_enum.removeChild($oNode_enum_Child)•./Include/_XML.au3'
						$oNode_enum.removeChild($oNode_enum_Child)
					EndIf
				EndIf
			Next
		EndIf
		$__iLineNumber=848 & ' - $oNode_enum.parentNode.removeChild($oNode_enum)•./Include/_XML.au3'
		$oNode_enum.parentNode.removeChild($oNode_enum)
	Next

	$__iLineNumber=851 & ' - Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCC ...•./Include/_XML.au3'
	Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCCESS)

EndFunc   ;==>_XML_DeleteNode

; #FUNCTION# ====================================================================================================================
; Name ..........: _XML_GetAllAttrib
; Description ...: Get all XML Field(s) attributes based on XPath input from root node.
; Syntax ........: _XML_GetAllAttrib(ByRef $oXmlDoc, $sXPath, ByRef $aName, ByRef $aValue)
; Parameters ....: $oXmlDoc   - [in/out] an object. A valid DOMDocument or IXMLDOMElement object.
;                  $sXPath    - a string value. The XML tree path from root node (root/child/child..)
; Return values .: On Success - Returns array of fields text values (number of items is in [0][0])
;                  On Failure - Returns $XML_RET_FAILURE and sets the @error flag to non-zero (look in #Region XML.au3 - ERROR Enums)
; Author ........: Eltorro
; Modified ......: mLipok
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ===============================================================================================================================
$__iLineNumber=870 & ' - Func _XML_GetAllAttrib(ByRef $oXmlDoc, $sXPath)•./Include/_XML.au3'
Func _XML_GetAllAttrib(ByRef $oXmlDoc, $sXPath)
	; Local Error handler declaration, it will be automatic CleanUp when returning from function
	$__iLineNumber=872 & ' - Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XM ...•./Include/_XML.au3'
	Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XML_ComErrorHandler_InternalFunction)
	#forceref $oXML_COM_ErrorHandler

	$__iLineNumber=875 & ' - Local $oNodesColl = _XML_SelectNodes($oXmlDoc, $sXPath)•./Include/_XML.au3'
	Local $oNodesColl = _XML_SelectNodes($oXmlDoc, $sXPath)
	$__iLineNumber=876 & ' - If @error Then Return SetError(@error, @extended, $XML_RET_F ...•./Include/_XML.au3'
	If @error Then Return SetError(@error, @extended, $XML_RET_FAILURE)

	$__iLineNumber=878 & ' - Local $oAttributesColl = Null•./Include/_XML.au3'
	Local $oAttributesColl = Null
	$__iLineNumber=879 & ' - Local $aResponse[2][1]•./Include/_XML.au3'
	Local $aResponse[2][1]
	$__iLineNumber=880 & ' - For $oNode_enum In $oNodesColl•./Include/_XML.au3'
	For $oNode_enum In $oNodesColl
		$__iLineNumber=881 & ' - $oAttributesColl = $oNode_enum.attributes•./Include/_XML.au3'
		$oAttributesColl = $oNode_enum.attributes
		$__iLineNumber=882 & ' - If ($oAttributesColl.length) = 0 Then•./Include/_XML.au3'
		If ($oAttributesColl.length) = 0 Then
			ContinueLoop
			$__iLineNumber=884 & ' - Return SetError($XML_ERR_GENERAL, $XML_EXT_DEFAULT, $XML_RET ...•./Include/_XML.au3'
			Return SetError($XML_ERR_GENERAL, $XML_EXT_DEFAULT, $XML_RET_FAILURE)
		EndIf

		$__iLineNumber=887 & ' - ReDim $aResponse[2][$oAttributesColl.length + 2]•./Include/_XML.au3'
		ReDim $aResponse[2][$oAttributesColl.length + 2]
		$__iLineNumber=888 & ' - For $iAttribute_idx = 0 To $oAttributesColl.length - 1•./Include/_XML.au3'
		For $iAttribute_idx = 0 To $oAttributesColl.length - 1
			$__iLineNumber=889 & ' - $aResponse[0][$iAttribute_idx + 1] = $oAttributesColl.item($ ...•./Include/_XML.au3'
			$aResponse[0][$iAttribute_idx + 1] = $oAttributesColl.item($iAttribute_idx).nodeName
			$__iLineNumber=890 & ' - $aResponse[1][$iAttribute_idx + 1] = $oAttributesColl.item($ ...•./Include/_XML.au3'
			$aResponse[1][$iAttribute_idx + 1] = $oAttributesColl.item($iAttribute_idx).Value
		Next
	Next
	$__iLineNumber=893 & ' - $aResponse[0][0] = $oAttributesColl.length•./Include/_XML.au3'
	$aResponse[0][0] = $oAttributesColl.length
	$__iLineNumber=894 & ' - Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $aResponse)•./Include/_XML.au3'
	Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $aResponse)

EndFunc   ;==>_XML_GetAllAttrib

; #FUNCTION# ====================================================================================================================
; Name ..........: _XML_GetChildren
; Description ...: Selects XML child Node(s) of an element based on XPath input from root node and returns there text values.
; Syntax ........: _XML_GetChildren(ByRef $oXmlDoc, $sXPath)
; Parameters ....: $oXmlDoc      - [in/out] an object. A valid DOMDocument or IXMLDOMElement object.
;                  $sXPath       - a string value. The XML tree path from root node (root/child/child..)
; Return values .: On Success    - Returns an array where:
;                  |$array[0][0] = Size of array
;                  |$array[1][0] = Name
;                  |$array[1][1] = Text
;                  |$array[1][2] = NameSpaceURI
;                  |...
;                  |$array[n][0] = Name
;                  |$array[n][1] = Text
;                  |$array[n][2] = NamespaceURI
;                  On Failure    - $XML_RET_FAILURE and sets the @error flag to non-zero (look in #Region XML.au3 - ERROR Enums)
; Author ........: Eltorro
; Modified ......: mLipok
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ===============================================================================================================================
$__iLineNumber=921 & ' - Func _XML_GetChildren(ByRef $oXmlDoc, $sXPath)•./Include/_XML.au3'
Func _XML_GetChildren(ByRef $oXmlDoc, $sXPath)
	; Local Error handler declaration, it will be automatic CleanUp when returning from function
	$__iLineNumber=923 & ' - Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XM ...•./Include/_XML.au3'
	Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XML_ComErrorHandler_InternalFunction)
	#forceref $oXML_COM_ErrorHandler

	$__iLineNumber=926 & ' - __XML_IsValidObject_DOMDocument($oXmlDoc)•./Include/_XML.au3'
	__XML_IsValidObject_DOMDocument($oXmlDoc)
	$__iLineNumber=927 & ' - If @error Then Return SetError(@error, @extended, $XML_RET_F ...•./Include/_XML.au3'
	If @error Then Return SetError(@error, @extended, $XML_RET_FAILURE)

	$__iLineNumber=929 & ' - Local $oNode_Selected = _XML_SelectSingleNode($oXmlDoc, $sXP ...•./Include/_XML.au3'
	Local $oNode_Selected = _XML_SelectSingleNode($oXmlDoc, $sXPath)
	$__iLineNumber=930 & ' - If @error Then•./Include/_XML.au3'
	If @error Then
		$__iLineNumber=931 & ' - Return SetError(@error, @extended, $XML_RET_FAILURE)•./Include/_XML.au3'
		Return SetError(@error, @extended, $XML_RET_FAILURE)
	ElseIf $oNode_Selected.hasChildNodes() Then
		$__iLineNumber=933 & ' - Local $iResponseDimSize = 0•./Include/_XML.au3'
		Local $iResponseDimSize = 0
		$__iLineNumber=934 & ' - Local $aResponse[1][3] = [[$iResponseDimSize, "", ""]]•./Include/_XML.au3'
		Local $aResponse[1][3] = [[$iResponseDimSize, '', '']]
		$__iLineNumber=935 & ' - For $oNode_enum_Child In $oNode_Selected.childNodes()•./Include/_XML.au3'
		For $oNode_enum_Child In $oNode_Selected.childNodes()
			$__iLineNumber=936 & ' - If $oNode_enum_Child.nodeType() = $XML_NODE_ELEMENT And $oNo ...•./Include/_XML.au3'
			If $oNode_enum_Child.nodeType() = $XML_NODE_ELEMENT And $oNode_enum_Child.hasChildNodes() Then
				$__iLineNumber=937 & ' - For $oNode_enum_Descendant In $oNode_enum_Child.childNodes()•./Include/_XML.au3'
				For $oNode_enum_Descendant In $oNode_enum_Child.childNodes()
					$__iLineNumber=938 & ' - If $oNode_enum_Descendant.nodeType() = $XML_NODE_TEXT Then•./Include/_XML.au3'
					If $oNode_enum_Descendant.nodeType() = $XML_NODE_TEXT Then
						$__iLineNumber=939 & ' - $iResponseDimSize = UBound($aResponse, 1)•./Include/_XML.au3'
						$iResponseDimSize = UBound($aResponse, 1)
						$__iLineNumber=940 & ' - ReDim $aResponse[$iResponseDimSize + 1][3]•./Include/_XML.au3'
						ReDim $aResponse[$iResponseDimSize + 1][3]
						$__iLineNumber=941 & ' - $aResponse[$iResponseDimSize][0] = $oNode_enum_Descendant.pa ...•./Include/_XML.au3'
						$aResponse[$iResponseDimSize][0] = $oNode_enum_Descendant.parentNode.baseName
						$__iLineNumber=942 & ' - $aResponse[$iResponseDimSize][1] = $oNode_enum_Descendant.te ...•./Include/_XML.au3'
						$aResponse[$iResponseDimSize][1] = $oNode_enum_Descendant.text
						$__iLineNumber=943 & ' - $aResponse[$iResponseDimSize][2] = $oNode_enum_Descendant.Na ...•./Include/_XML.au3'
						$aResponse[$iResponseDimSize][2] = $oNode_enum_Descendant.NamespaceURI
						; TODO Check
						; _XML_Array_AddName($aResponse, $oNode_enum_Child.baseName)
					EndIf
				Next
			EndIf
		Next
		$__iLineNumber=950 & ' - $aResponse[0][0] = $iResponseDimSize•./Include/_XML.au3'
		$aResponse[0][0] = $iResponseDimSize
		; TODO Description for @extended
		$__iLineNumber=952 & ' - Return SetError($XML_ERR_OK, $iResponseDimSize, $aResponse)•./Include/_XML.au3'
		Return SetError($XML_ERR_OK, $iResponseDimSize, $aResponse)

	EndIf
	$__iLineNumber=955 & ' - Return SetError($XML_ERR_NOCHILDMATCH, $XML_EXT_DEFAULT, $XM ...•./Include/_XML.au3'
	Return SetError($XML_ERR_NOCHILDMATCH, $XML_EXT_DEFAULT, $XML_RET_FAILURE)

EndFunc   ;==>_XML_GetChildren

; #FUNCTION# ====================================================================================================================
; Name ..........: _XML_GetChildText
; Description ...: Selects XML child Node(s) of an element based on XPath input from root node.
; Syntax ........: _XML_GetChildText(ByRef $oXmlDoc, $sXPath)
; Parameters ....: $oXmlDoc    - [in/out] an object. A valid DOMDocument or IXMLDOMElement object.
;                  $sXPath     - a string value. The XML tree path from root node (root/child/child..)
; Return values .: On Success  - Returns an array of Node's names and text.
;                  On Failure  - Returns $XML_RET_FAILURE and sets the @error flag to non-zero (look in #Region XML.au3 - ERROR Enums)
; Author ........: Eltorro
; Modified ......: mLipok
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ===============================================================================================================================
$__iLineNumber=974 & ' - Func _XML_GetChildText(ByRef $oXmlDoc, $sXPath)•./Include/_XML.au3'
Func _XML_GetChildText(ByRef $oXmlDoc, $sXPath)
	; Local Error handler declaration, it will be automatic CleanUp when returning from function
	$__iLineNumber=976 & ' - Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XM ...•./Include/_XML.au3'
	Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XML_ComErrorHandler_InternalFunction)
	#forceref $oXML_COM_ErrorHandler

	$__iLineNumber=979 & ' - Local $oNode_Selected = _XML_SelectSingleNode($oXmlDoc, $sXP ...•./Include/_XML.au3'
	Local $oNode_Selected = _XML_SelectSingleNode($oXmlDoc, $sXPath)
	$__iLineNumber=980 & ' - If @error Then•./Include/_XML.au3'
	If @error Then
		$__iLineNumber=981 & ' - Return SetError(@error, @extended, $XML_RET_FAILURE)•./Include/_XML.au3'
		Return SetError(@error, @extended, $XML_RET_FAILURE)
	ElseIf $oNode_Selected.hasChildNodes() Then
		$__iLineNumber=983 & ' - Local $aResponse[1] = [0]•./Include/_XML.au3'
		Local $aResponse[1] = [0]
		$__iLineNumber=984 & ' - For $oNode_enum_Child In $oNode_Selected.childNodes()•./Include/_XML.au3'
		For $oNode_enum_Child In $oNode_Selected.childNodes()
			$__iLineNumber=985 & ' - If $oNode_enum_Child.nodeType = $XML_NODE_ELEMENT Then•./Include/_XML.au3'
			If $oNode_enum_Child.nodeType = $XML_NODE_ELEMENT Then
				$__iLineNumber=986 & ' - _XML_Array_AddName($aResponse, $oNode_enum_Child.baseName)•./Include/_XML.au3'
				_XML_Array_AddName($aResponse, $oNode_enum_Child.baseName)
			ElseIf $oNode_enum_Child.nodeType = $XML_NODE_TEXT Then
				$__iLineNumber=988 & ' - _XML_Array_AddName($aResponse, $oNode_enum_Child.text)•./Include/_XML.au3'
				_XML_Array_AddName($aResponse, $oNode_enum_Child.text)
			EndIf
		Next

		$__iLineNumber=992 & ' - $aResponse[0] = UBound($aResponse) - 1•./Include/_XML.au3'
		$aResponse[0] = UBound($aResponse) - 1
		$__iLineNumber=993 & ' - Return SetError($XML_ERR_OK, $aResponse[0], $aResponse) ; TO ...•./Include/_XML.au3'
		Return SetError($XML_ERR_OK, $aResponse[0], $aResponse) ; TODO Description for @extended
	EndIf
	$__iLineNumber=995 & ' - Return SetError($XML_ERR_NOCHILDMATCH, $XML_EXT_DEFAULT, $XM ...•./Include/_XML.au3'
	Return SetError($XML_ERR_NOCHILDMATCH, $XML_EXT_DEFAULT, $XML_RET_FAILURE)

EndFunc   ;==>_XML_GetChildText

; #FUNCTION# ====================================================================================================================
; Name ..........: _XML_GetField
; Description ...: Get XML Field(s) based on XPath input from root node.
; Syntax ........: _XML_GetField(ByRef $oXmlDoc, $sXPath)
; Parameters ....: $oXmlDoc   - [in/out] an object. A valid DOMDocument or IXMLDOMElement object.
;                  $sXPath    - a string value. The XML tree path from root node (root/child/child..)
; Return values .: On Success - Returns an array of fields text values (count is in first element)
;                  On Failure - $XML_RET_FAILURE and sets the @error flag to non-zero (look in #Region XML.au3 - ERROR Enums)
; Author ........: Eltorro
; Modified ......: mLipok, GMK
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ===============================================================================================================================
$__iLineNumber=1014 & ' - Func _XML_GetField(ByRef $oXmlDoc, $sXPath)•./Include/_XML.au3'
Func _XML_GetField(ByRef $oXmlDoc, $sXPath)
	; Local Error handler declaration, it will be automatic CleanUp when returning from function
	$__iLineNumber=1016 & ' - Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XM ...•./Include/_XML.au3'
	Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XML_ComErrorHandler_InternalFunction)
	#forceref $oXML_COM_ErrorHandler

	$__iLineNumber=1019 & ' - __XML_IsValidObject_DOMDocument($oXmlDoc)•./Include/_XML.au3'
	__XML_IsValidObject_DOMDocument($oXmlDoc)
	$__iLineNumber=1020 & ' - If @error Then Return SetError(@error, @extended, $XML_RET_F ...•./Include/_XML.au3'
	If @error Then Return SetError(@error, @extended, $XML_RET_FAILURE)

	$__iLineNumber=1022 & ' - Local $oNode_Selected = _XML_SelectSingleNode($oXmlDoc, $sXP ...•./Include/_XML.au3'
	Local $oNode_Selected = _XML_SelectSingleNode($oXmlDoc, $sXPath)
	$__iLineNumber=1023 & ' - If @error Then•./Include/_XML.au3'
	If @error Then
		$__iLineNumber=1024 & ' - Return SetError(@error, @extended, $XML_RET_FAILURE)•./Include/_XML.au3'
		Return SetError(@error, @extended, $XML_RET_FAILURE)
	ElseIf $oNode_Selected.hasChildNodes() Then
		$__iLineNumber=1026 & ' - Local $aResponse[1] = [0], $sNodePath = ""•./Include/_XML.au3'
		Local $aResponse[1] = [0], $sNodePath = ""
		$__iLineNumber=1027 & ' - Local $iNodeMaxCount = $oNode_Selected.childNodes.length•./Include/_XML.au3'
		Local $iNodeMaxCount = $oNode_Selected.childNodes.length
		$__iLineNumber=1028 & ' - Local $aRet•./Include/_XML.au3'
		Local $aRet
		$__iLineNumber=1029 & ' - For $iNode_idx = 1 To $iNodeMaxCount•./Include/_XML.au3'
		For $iNode_idx = 1 To $iNodeMaxCount
			$__iLineNumber=1030 & ' - If $oNode_Selected.parentNode.nodeType = $XML_NODE_DOCUMENT  ...•./Include/_XML.au3'
			If $oNode_Selected.parentNode.nodeType = $XML_NODE_DOCUMENT Then
				$__iLineNumber=1031 & ' - $sNodePath = "/" & $oNode_Selected.baseName & "/*[" & $iNode ...•./Include/_XML.au3'
				$sNodePath = "/" & $oNode_Selected.baseName & "/*[" & $iNode_idx & "]"
			Else
				$__iLineNumber=1033 & ' - $sNodePath = $oNode_Selected.baseName & "/*[" & $iNode_idx & ...•./Include/_XML.au3'
				$sNodePath = $oNode_Selected.baseName & "/*[" & $iNode_idx & "]"
			EndIf

			$__iLineNumber=1036 & ' - $aRet = _XML_GetValue($oXmlDoc, $sNodePath)•./Include/_XML.au3'
			$aRet = _XML_GetValue($oXmlDoc, $sNodePath)
			$__iLineNumber=1037 & ' - If UBound($aRet) > 1 Then•./Include/_XML.au3'
			If UBound($aRet) > 1 Then
				$__iLineNumber=1038 & ' - _XML_Array_AddName($aResponse, $aRet[1])•./Include/_XML.au3'
				_XML_Array_AddName($aResponse, $aRet[1])
			Else
				$__iLineNumber=1040 & ' - _XML_Array_AddName($aResponse, "")•./Include/_XML.au3'
				_XML_Array_AddName($aResponse, "")
			EndIf

		Next
		$__iLineNumber=1044 & ' - $aResponse[0] = UBound($aResponse) - 1•./Include/_XML.au3'
		$aResponse[0] = UBound($aResponse) - 1
		$__iLineNumber=1045 & ' - Return SetError($XML_ERR_OK, $aResponse[0], $aResponse) ; TO ...•./Include/_XML.au3'
		Return SetError($XML_ERR_OK, $aResponse[0], $aResponse) ; TODO Description for @extended

	EndIf
	$__iLineNumber=1048 & ' - Return SetError($XML_ERR_GENERAL, $XML_EXT_DEFAULT, $XML_RET ...•./Include/_XML.au3'
	Return SetError($XML_ERR_GENERAL, $XML_EXT_DEFAULT, $XML_RET_FAILURE)

EndFunc   ;==>_XML_GetField

; #FUNCTION# ====================================================================================================================
; Name ..........: _XML_GetNodesPath
; Description ...: Return a nodes full path based on XPath input from root node.
; Syntax ........: _XML_GetNodesPath(ByRef $oXmlDoc, $sXPath)
; Parameters ....: $oXmlDoc   - [in/out] an object. A valid DOMDocument or IXMLDOMElement object.
;                  $sXPath    - a string value. The XML tree path from root node (root/child/child..)
; Return values .: On Success - An array of node names from root, count in [0] element.
;                  On Failure - $XML_RET_FAILURE and sets the @error flag to non-zero (look in #Region XML.au3 - ERROR Enums)
; Author ........: Eltorro
; Modified ......: mLipok
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ===============================================================================================================================
$__iLineNumber=1067 & ' - Func _XML_GetNodesPath(ByRef $oXmlDoc, $sXPath)•./Include/_XML.au3'
Func _XML_GetNodesPath(ByRef $oXmlDoc, $sXPath)
	; Local Error handler declaration, it will be automatic CleanUp when returning from function
	$__iLineNumber=1069 & ' - Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XM ...•./Include/_XML.au3'
	Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XML_ComErrorHandler_InternalFunction)
	#forceref $oXML_COM_ErrorHandler

	$__iLineNumber=1072 & ' - If _XML_Misc_GetDomVersion() < 4 Then•./Include/_XML.au3'
	If _XML_Misc_GetDomVersion() < 4 Then
		$__iLineNumber=1073 & ' - Return SetError($XML_ERR_DOMVERSION, 4, $XML_RET_FAILURE) ;  ...•./Include/_XML.au3'
		Return SetError($XML_ERR_DOMVERSION, 4, $XML_RET_FAILURE) ; TODO @extended Description
	EndIf

	$__iLineNumber=1076 & ' - Local $oNodesColl = _XML_SelectNodes($oXmlDoc, $sXPath)•./Include/_XML.au3'
	Local $oNodesColl = _XML_SelectNodes($oXmlDoc, $sXPath)
	$__iLineNumber=1077 & ' - If @error Then Return SetError(@error, @extended, $XML_RET_F ...•./Include/_XML.au3'
	If @error Then Return SetError(@error, @extended, $XML_RET_FAILURE)

	$__iLineNumber=1079 & ' - Local $aResponse[1], $sNodePath, $sNameSpace•./Include/_XML.au3'
	Local $aResponse[1], $sNodePath, $sNameSpace

	$__iLineNumber=1081 & ' - Local $oParent, $oNode_enum_Temp•./Include/_XML.au3'
	Local $oParent, $oNode_enum_Temp
	$__iLineNumber=1082 & ' - For $oNode_enum In $oNodesColl•./Include/_XML.au3'
	For $oNode_enum In $oNodesColl
		$__iLineNumber=1083 & ' - $oNode_enum_Temp = $oNode_enum•./Include/_XML.au3'
		$oNode_enum_Temp = $oNode_enum
		$__iLineNumber=1084 & ' - $sNodePath = ""•./Include/_XML.au3'
		$sNodePath = ""
		$__iLineNumber=1085 & ' - If $oNode_enum.nodeType <> $XML_NODE_DOCUMENT Then•./Include/_XML.au3'
		If $oNode_enum.nodeType <> $XML_NODE_DOCUMENT Then
			$__iLineNumber=1086 & ' - $sNameSpace = $oNode_enum.namespaceURI()•./Include/_XML.au3'
			$sNameSpace = $oNode_enum.namespaceURI()
			$__iLineNumber=1087 & ' - If $sNameSpace <> "" Then•./Include/_XML.au3'
			If $sNameSpace <> "" Then
				$__iLineNumber=1088 & ' - $sNameSpace = StringRight($sNameSpace, StringLen($sNameSpace ...•./Include/_XML.au3'
				$sNameSpace = StringRight($sNameSpace, StringLen($sNameSpace) - StringInStr($sNameSpace, "/", $STR_NOCASESENSE, -1)) & ":"
			EndIf
			$__iLineNumber=1090 & ' - If $sNameSpace = 0 Then $sNameSpace = ""•./Include/_XML.au3'
			If $sNameSpace = 0 Then $sNameSpace = ""
			$__iLineNumber=1091 & ' - $sNodePath = "/" & $sNameSpace & $oNode_enum.nodeName() & $s ...•./Include/_XML.au3'
			$sNodePath = "/" & $sNameSpace & $oNode_enum.nodeName() & $sNodePath
		EndIf

		Do
			$__iLineNumber=1095 & ' - $oParent = $oNode_enum_Temp.parentNode()•./Include/_XML.au3'
			$oParent = $oNode_enum_Temp.parentNode()
			$__iLineNumber=1096 & ' - If $oParent.nodeType <> $XML_NODE_DOCUMENT Then•./Include/_XML.au3'
			If $oParent.nodeType <> $XML_NODE_DOCUMENT Then
				$__iLineNumber=1097 & ' - $sNameSpace = $oParent.namespaceURI()•./Include/_XML.au3'
				$sNameSpace = $oParent.namespaceURI()
				$__iLineNumber=1098 & ' - If $sNameSpace <> "" Then•./Include/_XML.au3'
				If $sNameSpace <> "" Then
					; $sNameSpace = StringRight($sNameSpace, StringLen($sNameSpace) - StringInStr($sNameSpace, "/", $STR_NOCASESENSE, -1)) & ":"
					$__iLineNumber=1100 & ' - $sNameSpace &= ":"•./Include/_XML.au3'
					$sNameSpace &= ":"
				EndIf
				$__iLineNumber=1102 & ' - If $sNameSpace = 0 Then $sNameSpace = ""•./Include/_XML.au3'
				If $sNameSpace = 0 Then $sNameSpace = ""
				$__iLineNumber=1103 & ' - $sNodePath = "/" & $sNameSpace & $oParent.nodeName() & $sNod ...•./Include/_XML.au3'
				$sNodePath = "/" & $sNameSpace & $oParent.nodeName() & $sNodePath
				$__iLineNumber=1104 & ' - $oNode_enum_Temp = $oParent•./Include/_XML.au3'
				$oNode_enum_Temp = $oParent
			Else
				$__iLineNumber=1106 & ' - $oNode_enum_Temp = Null•./Include/_XML.au3'
				$oNode_enum_Temp = Null
			EndIf
			$__iLineNumber=1108 & ' - $oParent = Null•./Include/_XML.au3'
			$oParent = Null
		$__iLineNumber=1109 & ' - Until (Not (IsObj($oNode_enum_Temp)))•./Include/_XML.au3'
		Until (Not (IsObj($oNode_enum_Temp)))

		$__iLineNumber=1111 & ' - _XML_Array_AddName($aResponse, $sNodePath)•./Include/_XML.au3'
		_XML_Array_AddName($aResponse, $sNodePath)
	Next

	$__iLineNumber=1114 & ' - $aResponse[0] = UBound($aResponse) - 1•./Include/_XML.au3'
	$aResponse[0] = UBound($aResponse) - 1
	$__iLineNumber=1115 & ' - Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $aResponse)•./Include/_XML.au3'
	Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $aResponse)

EndFunc   ;==>_XML_GetNodesPath

; #FUNCTION# ===================================================================
; Name ..........: _XML_GetNodesPathInternal
; Description ...: Returns the path of a valid node object.
; Syntax ........: _XML_GetNodesPathInternal(ByRef $oXML_Node)
; Parameters ....: $oXML_Node - A valid node object
; Return values .: On Success - Path from root as string.
;                  On Failure - @TODO
;                  On Failure - $XML_RET_FAILURE and sets the @error flag to non-zero (look in #Region XML.au3 - ERROR Enums)
;                  On Failure - An empty string and @error set to 1.
; Author ........: Eltorro
; Modified ......: mLipok
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ===============================================================================================================================
$__iLineNumber=1135 & ' - Func _XML_GetNodesPathInternal(ByRef $oXML_Node)•./Include/_XML.au3'
Func _XML_GetNodesPathInternal(ByRef $oXML_Node)
	; Local Error handler declaration, it will be automatic CleanUp when returning from function
	$__iLineNumber=1137 & ' - Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XM ...•./Include/_XML.au3'
	Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XML_ComErrorHandler_InternalFunction)
	#forceref $oXML_COM_ErrorHandler

	$__iLineNumber=1140 & ' - __XML_IsValidObject_DOMDocument($oXML_Node)•./Include/_XML.au3'
	__XML_IsValidObject_DOMDocument($oXML_Node)
	$__iLineNumber=1141 & ' - If @error Then Return SetError(@error, @extended, $XML_RET_F ...•./Include/_XML.au3'
	If @error Then Return SetError(@error, @extended, $XML_RET_FAILURE)

	$__iLineNumber=1143 & ' - Local $sNodePath = "/" & $oXML_Node.baseName•./Include/_XML.au3'
	Local $sNodePath = "/" & $oXML_Node.baseName
	$__iLineNumber=1144 & ' - Local $oParentNode = Null, $sNameSpace = ""•./Include/_XML.au3'
	Local $oParentNode = Null, $sNameSpace = ''

	Do
		$__iLineNumber=1147 & ' - $oParentNode = $oXML_Node.parentNode()•./Include/_XML.au3'
		$oParentNode = $oXML_Node.parentNode()

		$__iLineNumber=1149 & ' - If $oParentNode.nodeType <> $XML_NODE_DOCUMENT Then•./Include/_XML.au3'
		If $oParentNode.nodeType <> $XML_NODE_DOCUMENT Then
			$__iLineNumber=1150 & ' - $sNameSpace = $oParentNode.namespaceURI()•./Include/_XML.au3'
			$sNameSpace = $oParentNode.namespaceURI()
			$__iLineNumber=1151 & ' - If $sNameSpace = 0 Then $sNameSpace = ""•./Include/_XML.au3'
			If $sNameSpace = 0 Then $sNameSpace = ""
			$__iLineNumber=1152 & ' - If $sNameSpace <> "" Then•./Include/_XML.au3'
			If $sNameSpace <> "" Then
				$__iLineNumber=1153 & ' - $sNameSpace = StringRight($sNameSpace, StringLen($sNameSpace ...•./Include/_XML.au3'
				$sNameSpace = StringRight($sNameSpace, StringLen($sNameSpace) - StringInStr($sNameSpace, "/", $STR_NOCASESENSE, -1)) & ":"
			EndIf
			$__iLineNumber=1155 & ' - $sNodePath = "/" & $sNameSpace & $oParentNode.nodeName() & $ ...•./Include/_XML.au3'
			$sNodePath = "/" & $sNameSpace & $oParentNode.nodeName() & $sNodePath
			$__iLineNumber=1156 & ' - $oXML_Node = $oParentNode•./Include/_XML.au3'
			$oXML_Node = $oParentNode
		Else
			$__iLineNumber=1158 & ' - $oXML_Node = Null•./Include/_XML.au3'
			$oXML_Node = Null
		EndIf

		$__iLineNumber=1161 & ' - $oParentNode = Null•./Include/_XML.au3'
		$oParentNode = Null
	$__iLineNumber=1162 & ' - Until (Not (IsObj($oXML_Node)))•./Include/_XML.au3'
	Until (Not (IsObj($oXML_Node)))

	$__iLineNumber=1164 & ' - Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $sNodePath)•./Include/_XML.au3'
	Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $sNodePath)

EndFunc   ;==>_XML_GetNodesPathInternal

; #FUNCTION# ====================================================================================================================
; Name ..........: _XML_GetParentNodeName
; Description ...: Gets the parent node name of the node pointed to by the XPath
; Syntax ........: _XML_GetParentNodeName(ByRef $oXmlDoc, $sXPath)
; Parameters ....: $oXmlDoc   - [in/out] an object. A valid DOMDocument or IXMLDOMElement object.
;                  $sXPath    - a string value. The XML tree path from root node (root/child/child..)
; Return values .: On Success - @TODO
;                  On Failure - $XML_RET_FAILURE and sets the @error flag to non-zero (look in #Region XML.au3 - ERROR Enums)
; Author ........: Mike Rerick
; Modified.......:
; Remarks .......: Returns empty string if the XPath is not valid
; Related .......:
; Link ..........:
; Example .......: [yes/no]
; ===============================================================================================================================
$__iLineNumber=1183 & ' - Func _XML_GetParentNodeName(ByRef $oXmlDoc, $sXPath)•./Include/_XML.au3'
Func _XML_GetParentNodeName(ByRef $oXmlDoc, $sXPath)
	; Local Error handler declaration, it will be automatic CleanUp when returning from function
	$__iLineNumber=1185 & ' - Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XM ...•./Include/_XML.au3'
	Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XML_ComErrorHandler_InternalFunction)
	#forceref $oXML_COM_ErrorHandler

	$__iLineNumber=1188 & ' - If _XML_Misc_GetDomVersion() < 4 Then•./Include/_XML.au3'
	If _XML_Misc_GetDomVersion() < 4 Then
		$__iLineNumber=1189 & ' - Return SetError($XML_ERR_DOMVERSION, 4, $XML_RET_FAILURE) ;  ...•./Include/_XML.au3'
		Return SetError($XML_ERR_DOMVERSION, 4, $XML_RET_FAILURE) ; TODO @extended Description
	EndIf

	$__iLineNumber=1192 & ' - Local $oNodesColl = _XML_SelectNodes($oXmlDoc, $sXPath)•./Include/_XML.au3'
	Local $oNodesColl = _XML_SelectNodes($oXmlDoc, $sXPath)
	$__iLineNumber=1193 & ' - If @error Then Return SetError(@error, @extended, $XML_RET_F ...•./Include/_XML.au3'
	If @error Then Return SetError(@error, @extended, $XML_RET_FAILURE)

	$__iLineNumber=1195 & ' - Local $aResponse[1], $sNodePath, $sNameSpace = ""•./Include/_XML.au3'
	Local $aResponse[1], $sNodePath, $sNameSpace = ''
	$__iLineNumber=1196 & ' - Local $sParentNodeName = "", $oParent_Node = Null•./Include/_XML.au3'
	Local $sParentNodeName = "", $oParent_Node = Null

	$__iLineNumber=1198 & ' - For $oNode_enum In $oNodesColl•./Include/_XML.au3'
	For $oNode_enum In $oNodesColl
		$__iLineNumber=1199 & ' - Local $oNode_enum1 = $oNode_enum•./Include/_XML.au3'
		Local $oNode_enum1 = $oNode_enum
		$__iLineNumber=1200 & ' - $sNodePath = ""•./Include/_XML.au3'
		$sNodePath = ""
		$__iLineNumber=1201 & ' - If $oNode_enum.nodeType <> $XML_NODE_DOCUMENT Then•./Include/_XML.au3'
		If $oNode_enum.nodeType <> $XML_NODE_DOCUMENT Then
			$__iLineNumber=1202 & ' - $sNameSpace = $oNode_enum.namespaceURI()•./Include/_XML.au3'
			$sNameSpace = $oNode_enum.namespaceURI()
			$__iLineNumber=1203 & ' - If $sNameSpace = 0 Then•./Include/_XML.au3'
			If $sNameSpace = 0 Then
				$__iLineNumber=1204 & ' - $sNameSpace = ""•./Include/_XML.au3'
				$sNameSpace = ""
			ElseIf $sNameSpace <> "" Then
				$__iLineNumber=1206 & ' - $sNameSpace = StringRight($sNameSpace, StringLen($sNameSpace ...•./Include/_XML.au3'
				$sNameSpace = StringRight($sNameSpace, StringLen($sNameSpace) - StringInStr($sNameSpace, "/", $STR_NOCASESENSE, -1)) & ":"
			EndIf

			$__iLineNumber=1209 & ' - $sNodePath = "/" & $sNameSpace & $oNode_enum.nodeName() & $s ...•./Include/_XML.au3'
			$sNodePath = "/" & $sNameSpace & $oNode_enum.nodeName() & $sNodePath
		EndIf

		$__iLineNumber=1212 & ' - $oParent_Node = $oNode_enum1.parentNode()•./Include/_XML.au3'
		$oParent_Node = $oNode_enum1.parentNode()
		$__iLineNumber=1213 & ' - If $oParent_Node.nodeType <> $XML_NODE_DOCUMENT Then•./Include/_XML.au3'
		If $oParent_Node.nodeType <> $XML_NODE_DOCUMENT Then
			$__iLineNumber=1214 & ' - $sNameSpace = $oParent_Node.namespaceURI()•./Include/_XML.au3'
			$sNameSpace = $oParent_Node.namespaceURI()
			$__iLineNumber=1215 & ' - If $sNameSpace = 0 Then•./Include/_XML.au3'
			If $sNameSpace = 0 Then
				$__iLineNumber=1216 & ' - $sNameSpace = ""•./Include/_XML.au3'
				$sNameSpace = ""
			ElseIf $sNameSpace <> "" Then
				$__iLineNumber=1218 & ' - $sNameSpace &= ":"•./Include/_XML.au3'
				$sNameSpace &= ":"
			EndIf

			$__iLineNumber=1221 & ' - $sNodePath = "/" & $sNameSpace & $oParent_Node.nodeName() &  ...•./Include/_XML.au3'
			$sNodePath = "/" & $sNameSpace & $oParent_Node.nodeName() & $sNodePath
			$__iLineNumber=1222 & ' - $oNode_enum1 = $oParent_Node•./Include/_XML.au3'
			$oNode_enum1 = $oParent_Node
			$__iLineNumber=1223 & ' - $sParentNodeName = $oParent_Node.nodeName()•./Include/_XML.au3'
			$sParentNodeName = $oParent_Node.nodeName()
		Else
			$__iLineNumber=1225 & ' - $oNode_enum1 = 0•./Include/_XML.au3'
			$oNode_enum1 = 0
		EndIf

		$__iLineNumber=1228 & ' - $oParent_Node = Null•./Include/_XML.au3'
		$oParent_Node = Null
		$__iLineNumber=1229 & ' - _XML_Array_AddName($aResponse, $sNodePath)•./Include/_XML.au3'
		_XML_Array_AddName($aResponse, $sNodePath)
	Next

	$__iLineNumber=1232 & ' - $aResponse[0] = UBound($aResponse) - 1•./Include/_XML.au3'
	$aResponse[0] = UBound($aResponse) - 1
	$__iLineNumber=1233 & ' - Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $sParentNodeN ...•./Include/_XML.au3'
	Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $sParentNodeName)

EndFunc   ;==>_XML_GetParentNodeName

; #FUNCTION# ====================================================================================================================
; Name ..........: _XML_GetValue
; Description ...: Get XML values based on XPath input from root node.
; Syntax ........: _XML_GetValue(ByRef $oXmlDoc, $sXPath)
; Parameters ....: $oXmlDoc   - [in/out] an object. A valid DOMDocument or IXMLDOMElement object.
;                  $sXPath    - a string value. The XML tree path from root node (root/child/child..)
; Return values .: On Success - Returns an array of fields text values (count is in first element)
;                  On Failure - Returns $XML_RET_FAILURE and sets the @error flag to non-zero (look in #Region XML.au3 - ERROR Enums)
;                  |0 - No matching node. ; TODO
;                  |1 - No object passed. ; TODO
; Author ........: Eltorro
; Modified ......: mLipok
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ===============================================================================================================================
$__iLineNumber=1254 & ' - Func _XML_GetValue(ByRef $oXmlDoc, $sXPath)•./Include/_XML.au3'
Func _XML_GetValue(ByRef $oXmlDoc, $sXPath)
	; Local Error handler declaration, it will be automatic CleanUp when returning from function
	$__iLineNumber=1256 & ' - Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XM ...•./Include/_XML.au3'
	Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XML_ComErrorHandler_InternalFunction)
	#forceref $oXML_COM_ErrorHandler

	$__iLineNumber=1259 & ' - Local $oNodesColl = _XML_SelectNodes($oXmlDoc, $sXPath)•./Include/_XML.au3'
	Local $oNodesColl = _XML_SelectNodes($oXmlDoc, $sXPath)
	$__iLineNumber=1260 & ' - If @error Then Return SetError(@error, @extended, $XML_RET_F ...•./Include/_XML.au3'
	If @error Then Return SetError(@error, @extended, $XML_RET_FAILURE)

	$__iLineNumber=1262 & ' - Local $aResponse[1]•./Include/_XML.au3'
	Local $aResponse[1]
	$__iLineNumber=1263 & ' - For $oNode_enum In $oNodesColl•./Include/_XML.au3'
	For $oNode_enum In $oNodesColl
		$__iLineNumber=1264 & ' - If $oNode_enum.hasChildNodes() Then•./Include/_XML.au3'
		If $oNode_enum.hasChildNodes() Then
			$__iLineNumber=1265 & ' - For $oNode_enum_Child In $oNode_enum.childNodes()•./Include/_XML.au3'
			For $oNode_enum_Child In $oNode_enum.childNodes()
				$__iLineNumber=1266 & ' - If $oNode_enum_Child.nodeType = $XML_NODE_CDATA_SECTION Then•./Include/_XML.au3'
				If $oNode_enum_Child.nodeType = $XML_NODE_CDATA_SECTION Then
					$__iLineNumber=1267 & ' - _XML_Array_AddName($aResponse, $oNode_enum_Child.data)•./Include/_XML.au3'
					_XML_Array_AddName($aResponse, $oNode_enum_Child.data)
				ElseIf $oNode_enum_Child.nodeType = $XML_NODE_TEXT Then
					$__iLineNumber=1269 & ' - _XML_Array_AddName($aResponse, $oNode_enum_Child.Text)•./Include/_XML.au3'
					_XML_Array_AddName($aResponse, $oNode_enum_Child.Text)
				EndIf
			Next
		Else
			$__iLineNumber=1273 & ' - _XML_Array_AddName($aResponse, $oNode_enum.nodeValue)•./Include/_XML.au3'
			_XML_Array_AddName($aResponse, $oNode_enum.nodeValue)
		EndIf
	Next

	$__iLineNumber=1277 & ' - Local $i•./Include/_XML.au3'
	Local $i
	$__iLineNumber=1278 & ' - For $i = UBound($aResponse) - 1 To 1 Step -1•./Include/_XML.au3'
	For $i = UBound($aResponse) - 1 To 1 Step -1
		$__iLineNumber=1279 & ' - $aResponse[$i] = $aResponse[$i - 1]•./Include/_XML.au3'
		$aResponse[$i] = $aResponse[$i - 1]
	Next

	$__iLineNumber=1282 & ' - $aResponse[0] = UBound($aResponse) - 1•./Include/_XML.au3'
	$aResponse[0] = UBound($aResponse) - 1
	$__iLineNumber=1283 & ' - Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $aResponse)•./Include/_XML.au3'
	Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $aResponse)

EndFunc   ;==>_XML_GetValue

; #FUNCTION# ====================================================================================================================
; Name ..........: _XML_InsertChildNode
; Description ...: Insert a child node under the specified XPath Node.
; Syntax ........: _XML_InsertChildNode(ByRef $oXmlDoc, $sXPath, $sNode[, $sData = ""[, $sNameSpace = ""]])
; Parameters ....: $oXmlDoc    - [in/out] an object. A valid DOMDocument or IXMLDOMElement object.
;                  $sXPath     - a string value. The XML tree path from root node (root/child/child..)
;                  $sNode      - Node name to add.
;                  $iItem      - [optional] 0-based child item before which to insert. (Default = 0
;                  $sData      - [optional] Value to give the node
;                  $sNameSpace - [optional] Name Space
; Return values .: On Success  - Returns $XML_RET_SUCCESS
;                  On Failure  - Returns $XML_RET_FAILURE and sets the @error flag to non-zero (look in #Region XML.au3 - ERROR Enums)
; Author ........: GMK
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......;
; ===============================================================================================================================
$__iLineNumber=1306 & ' - Func _XML_InsertChildNode(ByRef $oXmlDoc, $sXPath, $sNode, $ ...•./Include/_XML.au3'
Func _XML_InsertChildNode(ByRef $oXmlDoc, $sXPath, $sNode, $iItem = 0, $sData = "", $sNameSpace = "")
	; Local Error handler declaration, it will be automatic CleanUp when returning from function
	$__iLineNumber=1308 & ' - Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XM ...•./Include/_XML.au3'
	Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XML_ComErrorHandler_InternalFunction)
	#forceref $oXML_COM_ErrorHandler

	$__iLineNumber=1311 & ' - Local $oNodesColl = _XML_SelectNodes($oXmlDoc, $sXPath)•./Include/_XML.au3'
	Local $oNodesColl = _XML_SelectNodes($oXmlDoc, $sXPath)
	$__iLineNumber=1312 & ' - If @error Then Return SetError(@error, @extended, $XML_RET_F ...•./Include/_XML.au3'
	If @error Then Return SetError(@error, @extended, $XML_RET_FAILURE)

	$__iLineNumber=1314 & ' - Local $oChild•./Include/_XML.au3'
	Local $oChild
	$__iLineNumber=1315 & ' - For $oNode_enum In $oNodesColl•./Include/_XML.au3'
	For $oNode_enum In $oNodesColl
		$__iLineNumber=1316 & ' - If $sNameSpace = "" Then•./Include/_XML.au3'
		If $sNameSpace = "" Then
			$__iLineNumber=1317 & ' - If Not ($oNode_enum.namespaceURI = 0 Or $oNode_enum.namespac ...•./Include/_XML.au3'
			If Not ($oNode_enum.namespaceURI = 0 Or $oNode_enum.namespaceURI = "") Then $sNameSpace = $oNode_enum.namespaceURI
		EndIf

		$__iLineNumber=1320 & ' - $oChild = $oXmlDoc.createNode($XML_NODE_ELEMENT, $sNode, $sN ...•./Include/_XML.au3'
		$oChild = $oXmlDoc.createNode($XML_NODE_ELEMENT, $sNode, $sNameSpace)
		$__iLineNumber=1321 & ' - If @error Then Return SetError($XML_ERR_NODECREATE, @error,  ...•./Include/_XML.au3'
		If @error Then Return SetError($XML_ERR_NODECREATE, @error, $XML_RET_FAILURE)

		$__iLineNumber=1323 & ' - If $sData <> "" Then $oChild.text = $sData•./Include/_XML.au3'
		If $sData <> "" Then $oChild.text = $sData
		$__iLineNumber=1324 & ' - $oNode_enum.insertBefore($oChild, $oNode_enum.childNodes.ite ...•./Include/_XML.au3'
		$oNode_enum.insertBefore($oChild, $oNode_enum.childNodes.item($iItem))
		$__iLineNumber=1325 & ' - If @error Then Return SetError($XML_ERR_NODEAPPEND, @error,  ...•./Include/_XML.au3'
		If @error Then Return SetError($XML_ERR_NODEAPPEND, @error, $XML_RET_FAILURE)

	Next

	$__iLineNumber=1329 & ' - $oNodesColl = Null•./Include/_XML.au3'
	$oNodesColl = Null
	$__iLineNumber=1330 & ' - $oChild = Null•./Include/_XML.au3'
	$oChild = Null
	$__iLineNumber=1331 & ' - Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCC ...•./Include/_XML.au3'
	Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCCESS)

EndFunc   ;==>_XML_InsertChildNode

; #FUNCTION# ====================================================================================================================
; Name ..........: _XML_RemoveAttributeNode
; Description ...: Delete XML Attribute node based on XPath input from root node.
; Syntax ........: _XML_RemoveAttributeNode(ByRef $oXmlDoc, $sXPath, $sAttribute)
; Parameters ....: $oXmlDoc    - [in/out] an object. A valid DOMDocument or IXMLDOMElement object.
;                  $sXPath     - a string value. The XML tree path from root node (root/child/child..)
;                  $sAttribute - a string value. The name of attribute node to delete
; Return values .: On Success  - Returns $XML_RET_SUCCESS
;                  On Failure  - Returns $XML_RET_FAILURE and sets the @error flag to non-zero (look in #Region XML.au3 - ERROR Enums)
; Author ........: Eltorro
; Modified ......: mLipok
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ===============================================================================================================================
$__iLineNumber=1351 & ' - Func _XML_RemoveAttributeNode(ByRef $oXmlDoc, $sXPath, $sAtt ...•./Include/_XML.au3'
Func _XML_RemoveAttributeNode(ByRef $oXmlDoc, $sXPath, $sAttribute)
	; Local Error handler declaration, it will be automatic CleanUp when returning from function
	$__iLineNumber=1353 & ' - Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XM ...•./Include/_XML.au3'
	Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XML_ComErrorHandler_InternalFunction)
	#forceref $oXML_COM_ErrorHandler

	$__iLineNumber=1356 & ' - Local $oNode_Selected = _XML_SelectSingleNode($oXmlDoc, $sXP ...•./Include/_XML.au3'
	Local $oNode_Selected = _XML_SelectSingleNode($oXmlDoc, $sXPath)
	$__iLineNumber=1357 & ' - If @error Then Return SetError(@error, @extended, $XML_RET_F ...•./Include/_XML.au3'
	If @error Then Return SetError(@error, @extended, $XML_RET_FAILURE)

	$__iLineNumber=1359 & ' - Local $oAttribute = $oNode_Selected.removeAttributeNode($oNo ...•./Include/_XML.au3'
	Local $oAttribute = $oNode_Selected.removeAttributeNode($oNode_Selected.getAttributeNode($sAttribute))
	$__iLineNumber=1360 & ' - If @error Then•./Include/_XML.au3'
	If @error Then
		$__iLineNumber=1361 & ' - Return SetError($XML_ERR_COMERROR, @error, $XML_RET_FAILURE)•./Include/_XML.au3'
		Return SetError($XML_ERR_COMERROR, @error, $XML_RET_FAILURE)
	ElseIf Not IsObj($oAttribute) Then
		$__iLineNumber=1363 & ' - Return SetError($XML_ERR_NOATTRMATCH, $XML_EXT_DEFAULT, $XML ...•./Include/_XML.au3'
		Return SetError($XML_ERR_NOATTRMATCH, $XML_EXT_DEFAULT, $XML_RET_FAILURE)
	EndIf

	$__iLineNumber=1366 & ' - Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCC ...•./Include/_XML.au3'
	Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCCESS)

EndFunc   ;==>_XML_RemoveAttributeNode

; #FUNCTION# ====================================================================================================================
; Name ..........: _XML_ReplaceChild
; Description ...: Replaces selected nodes with another
; Syntax ........: _XML_ReplaceChild(ByRef $oXmlDoc, $sXPath, $sNodeNew_Name[, $sNameSpace = ""])
; Parameters ....: $oXmlDoc       - [in/out] an object. A valid DOMDocument or IXMLDOMElement object.
;                  $sXPath        - a string value. The XML tree path from root node (root/child/child..)
;                  $sNodeNew_Name - a string value. The replacement node name.
;                  $sNameSpace    - [optional] a string value. Default is "".
; Return values .: On Success  - Returns $XML_RET_SUCCESS
;                  On Failure  - Returns $XML_RET_FAILURE and sets the @error flag to non-zero (look in #Region XML.au3 - ERROR Enums)
; Author ........: Eltorro adapted from http://www.perfectxml.com/msxmlAnswers.asp?Row_ID=65
; Modified ......: mLipok
; Remarks .......:
; Related .......:
; Link ..........: http://www.perfectxml.com/msxmlAnswers.asp?Row_ID=65
; Example .......; yes
; ===============================================================================================================================
$__iLineNumber=1387 & ' - Func _XML_ReplaceChild(ByRef $oXmlDoc, $sXPath, $sNodeNew_Na ...•./Include/_XML.au3'
Func _XML_ReplaceChild(ByRef $oXmlDoc, $sXPath, $sNodeNew_Name, $sNameSpace = "")
	; Local Error handler declaration, it will be automatic CleanUp when returning from function
	$__iLineNumber=1389 & ' - Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XM ...•./Include/_XML.au3'
	Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XML_ComErrorHandler_InternalFunction)
	#forceref $oXML_COM_ErrorHandler

	$__iLineNumber=1392 & ' - Local $oNodesColl = _XML_SelectNodes($oXmlDoc, $sXPath)•./Include/_XML.au3'
	Local $oNodesColl = _XML_SelectNodes($oXmlDoc, $sXPath)
	$__iLineNumber=1393 & ' - If @error Then Return SetError(@error, @extended, $XML_RET_F ...•./Include/_XML.au3'
	If @error Then Return SetError(@error, @extended, $XML_RET_FAILURE)

	$__iLineNumber=1395 & ' - Local $oNodeNew = Null•./Include/_XML.au3'
	Local $oNodeNew = Null
	$__iLineNumber=1396 & ' - For $oNode_enum_old In $oNodesColl•./Include/_XML.au3'
	For $oNode_enum_old In $oNodesColl
		; Create a New Node element
		$__iLineNumber=1398 & ' - $oNodeNew = $oXmlDoc.createNode($XML_NODE_ELEMENT, $sNodeNew ...•./Include/_XML.au3'
		$oNodeNew = $oXmlDoc.createNode($XML_NODE_ELEMENT, $sNodeNew_Name, $sNameSpace)
		$__iLineNumber=1399 & ' - If @error Then Return SetError($XML_ERR_NODECREATE, @error,  ...•./Include/_XML.au3'
		If @error Then Return SetError($XML_ERR_NODECREATE, @error, $XML_RET_FAILURE)

		; Copy all attributes
		$__iLineNumber=1402 & ' - For $oAttributeEnum In $oNode_enum_old.Attributes•./Include/_XML.au3'
		For $oAttributeEnum In $oNode_enum_old.Attributes
			$__iLineNumber=1403 & ' - $oNodeNew.Attributes.setNamedItem($oAttributeEnum.cloneNode( ...•./Include/_XML.au3'
			$oNodeNew.Attributes.setNamedItem($oAttributeEnum.cloneNode(True))
		Next

		; Copy all Child Nodes
		$__iLineNumber=1407 & ' - For $oNode_enum_old_Child In $oNode_enum_old.childNodes•./Include/_XML.au3'
		For $oNode_enum_old_Child In $oNode_enum_old.childNodes
			$__iLineNumber=1408 & ' - $oNodeNew.appendChild($oNode_enum_old_Child)•./Include/_XML.au3'
			$oNodeNew.appendChild($oNode_enum_old_Child)
			$__iLineNumber=1409 & ' - If @error Then Return SetError($XML_ERR_NODEAPPEND, @error,  ...•./Include/_XML.au3'
			If @error Then Return SetError($XML_ERR_NODEAPPEND, @error, $XML_RET_FAILURE)
		Next

		; Replace the specified $oNode_enum_old with the supplied $oNodeNew
		$__iLineNumber=1413 & ' - $oNode_enum_old.parentNode.replaceChild($oNodeNew, $oNode_en ...•./Include/_XML.au3'
		$oNode_enum_old.parentNode.replaceChild($oNodeNew, $oNode_enum_old)
		$__iLineNumber=1414 & ' - If $oXmlDoc.parseError.errorCode Then•./Include/_XML.au3'
		If $oXmlDoc.parseError.errorCode Then
			$__iLineNumber=1415 & ' - Return SetError($XML_ERR_PARSE, $oXmlDoc.parseError.errorCod ...•./Include/_XML.au3'
			Return SetError($XML_ERR_PARSE, $oXmlDoc.parseError.errorCode, $XML_RET_FAILURE)
		EndIf

	Next
	$__iLineNumber=1419 & ' - $oNodesColl = Null•./Include/_XML.au3'
	$oNodesColl = Null
	$__iLineNumber=1420 & ' - $oNodeNew = Null•./Include/_XML.au3'
	$oNodeNew = Null

	$__iLineNumber=1422 & ' - Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCC ...•./Include/_XML.au3'
	Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCCESS)

EndFunc   ;==>_XML_ReplaceChild

; #FUNCTION# ====================================================================================================================
; Name ..........: _XML_SetAttrib
; Description ...: Set XML Field(s) based on XPath input from root node.
; Syntax ........: _XML_SetAttrib(ByRef $oXmlDoc, $sXPath, $sAttribute[, $sValue = ""[, $iIndex = Default]])
; Parameters ....: $oXmlDoc 		- [in/out] an object. A valid DOMDocument or IXMLDOMElement object.
;                  $sXPath          - a string value. The XML tree path from root node (root/child/child..)
;                  $sAttribute     	- The attribute to set.
;                  $sValue      	- The value to give the attribute defaults to ""
;                  $iIndex        	- Used to specify a specific index for "same named" nodes.
; Return values .: Success        	- An array of fields text values
;                  Failure          - $XML_RET_FAILURE and sets the @error flag to non-zero (look in #Region XML.au3 - ERROR Enums)
; Author ........: Eltorro
; Modified ......: mLipok
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ===============================================================================================================================
$__iLineNumber=1444 & ' - Func _XML_SetAttrib(ByRef $oXmlDoc, $sXPath, $sAttribute, $s ...•./Include/_XML.au3'
Func _XML_SetAttrib(ByRef $oXmlDoc, $sXPath, $sAttribute, $sValue = "", $iIndex = Default)
	; Local Error handler declaration, it will be automatic CleanUp when returning from function
	$__iLineNumber=1446 & ' - Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XM ...•./Include/_XML.au3'
	Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XML_ComErrorHandler_InternalFunction)
	#forceref $oXML_COM_ErrorHandler

	$__iLineNumber=1449 & ' - Local $oNodesColl = _XML_SelectNodes($oXmlDoc, $sXPath)•./Include/_XML.au3'
	Local $oNodesColl = _XML_SelectNodes($oXmlDoc, $sXPath)
	$__iLineNumber=1450 & ' - If @error Then Return SetError(@error, @extended, $XML_RET_F ...•./Include/_XML.au3'
	If @error Then Return SetError(@error, @extended, $XML_RET_FAILURE)

	$__iLineNumber=1452 & ' - Local $aResponse[1]•./Include/_XML.au3'
	Local $aResponse[1]

	$__iLineNumber=1454 & ' - If IsNumber($iIndex) And $iIndex > 0 Then•./Include/_XML.au3'
	If IsNumber($iIndex) And $iIndex > 0 Then
		$__iLineNumber=1455 & ' - $aResponse[0] = $oNodesColl.item($iIndex).SetAttribute($sAtt ...•./Include/_XML.au3'
		$aResponse[0] = $oNodesColl.item($iIndex).SetAttribute($sAttribute, $sValue)
		$__iLineNumber=1456 & ' - If @error Then•./Include/_XML.au3'
		If @error Then
			$__iLineNumber=1457 & ' - Return SetError($XML_ERR_PARAMETER, $XML_EXT_DEFAULT, $XML_R ...•./Include/_XML.au3'
			Return SetError($XML_ERR_PARAMETER, $XML_EXT_DEFAULT, $XML_RET_FAILURE)
		EndIf
	ElseIf $iIndex = Default Then
		$__iLineNumber=1460 & ' - ReDim $aResponse[$oNodesColl.length]•./Include/_XML.au3'
		ReDim $aResponse[$oNodesColl.length]
		$__iLineNumber=1461 & ' - For $iNode_idx = 0 To $oNodesColl.length - 1•./Include/_XML.au3'
		For $iNode_idx = 0 To $oNodesColl.length - 1
			$__iLineNumber=1462 & ' - $aResponse[$iNode_idx] = $oNodesColl.item($iNode_idx).SetAtt ...•./Include/_XML.au3'
			$aResponse[$iNode_idx] = $oNodesColl.item($iNode_idx).SetAttribute($sAttribute, $sValue)
			$__iLineNumber=1463 & ' - If $oXmlDoc.parseError.errorCode Then•./Include/_XML.au3'
			If $oXmlDoc.parseError.errorCode Then
				$__iLineNumber=1464 & ' - Return SetError($XML_ERR_PARSE, $oXmlDoc.parseError.errorCod ...•./Include/_XML.au3'
				Return SetError($XML_ERR_PARSE, $oXmlDoc.parseError.errorCode, $XML_RET_FAILURE)
			EndIf
		Next
		$__iLineNumber=1467 & ' - Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $aResponse)•./Include/_XML.au3'
		Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $aResponse)
	EndIf
	$__iLineNumber=1469 & ' - Return SetError($XML_ERR_PARAMETER, $XML_EXT_DEFAULT, $XML_R ...•./Include/_XML.au3'
	Return SetError($XML_ERR_PARAMETER, $XML_EXT_DEFAULT, $XML_RET_FAILURE)

EndFunc   ;==>_XML_SetAttrib

; #FUNCTION# ====================================================================================================================
; Name ..........: _XML_Transform
; Description ...: Transform XML data
; Syntax ........: _XML_Transform(ByRef $oXmlDoc, $sXSL_FileFullPath)
; Parameters ....: $oXmlDoc           - [in/out] an object. A valid DOMDocument object.
;                  $sXSL_FileFullPath - a string value. The stylesheet to use
; Return values .: On Success         - Returns $XML_RET_SUCCESS
;                  On Failure         - Returns $XML_RET_FAILURE and sets the @error flag to non-zero (look in #Region XML.au3 - ERROR Enums)
; Author ........: Eltorro , Modified by WeaponX
; Modified ......: mLipok
; Remarks .......: Ref XML Object will be overwriten - will contain Transformed Data
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ===============================================================================================================================
$__iLineNumber=1488 & ' - Func _XML_Transform(ByRef $oXmlDoc, $sXSL_FileFullPath)•./Include/_XML.au3'
Func _XML_Transform(ByRef $oXmlDoc, $sXSL_FileFullPath)
	; Local Error handler declaration, it will be automatic CleanUp when returning from function
	$__iLineNumber=1490 & ' - Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XM ...•./Include/_XML.au3'
	Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XML_ComErrorHandler_InternalFunction)
	#forceref $oXML_COM_ErrorHandler

	$__iLineNumber=1493 & ' - If Not (FileExists($sXSL_FileFullPath)) Then•./Include/_XML.au3'
	If Not (FileExists($sXSL_FileFullPath)) Then
		$__iLineNumber=1494 & ' - Return SetError($XML_ERR_LOAD, $XML_EXT_DEFAULT, $XML_RET_FA ...•./Include/_XML.au3'
		Return SetError($XML_ERR_LOAD, $XML_EXT_DEFAULT, $XML_RET_FAILURE)
	EndIf

	$__iLineNumber=1497 & ' - __XML_IsValidObject_DOMDocument($oXmlDoc)•./Include/_XML.au3'
	__XML_IsValidObject_DOMDocument($oXmlDoc)
	$__iLineNumber=1498 & ' - If @error Then Return SetError(@error, @extended, $XML_RET_F ...•./Include/_XML.au3'
	If @error Then Return SetError(@error, @extended, $XML_RET_FAILURE)

	$__iLineNumber=1500 & ' - Local $oXSLT_Template = ObjCreate("Msxml2.XSLTemplate." & _X ...•./Include/_XML.au3'
	Local $oXSLT_Template = ObjCreate("Msxml2.XSLTemplate." & _XML_Misc_GetDomVersion() & ".0")
	$__iLineNumber=1501 & ' - If @error Then Return SetError($XML_ERR_OBJCREATE, $XML_EXT_ ...•./Include/_XML.au3'
	If @error Then Return SetError($XML_ERR_OBJCREATE, $XML_EXT_XSLTEMPLATE, $XML_RET_FAILURE)

	$__iLineNumber=1503 & ' - Local $oXSL_Document = ObjCreate("Msxml2.FreeThreadedDOMDocu ...•./Include/_XML.au3'
	Local $oXSL_Document = ObjCreate("Msxml2.FreeThreadedDOMDocument." & _XML_Misc_GetDomVersion() & ".0")
	$__iLineNumber=1504 & ' - If @error Then Return SetError($XML_ERR_OBJCREATE, $XML_EXT_ ...•./Include/_XML.au3'
	If @error Then Return SetError($XML_ERR_OBJCREATE, $XML_EXT_FREETHREADEDDOMDOCUMENT, $XML_RET_FAILURE)

	$__iLineNumber=1506 & ' - Local $oXmlDoc_Temp = ObjCreate("Msxml2.DOMDocument." & _XML ...•./Include/_XML.au3'
	Local $oXmlDoc_Temp = ObjCreate("Msxml2.DOMDocument." & _XML_Misc_GetDomVersion() & ".0")
	$__iLineNumber=1507 & ' - If @error Then Return SetError($XML_ERR_OBJCREATE, $XML_EXT_ ...•./Include/_XML.au3'
	If @error Then Return SetError($XML_ERR_OBJCREATE, $XML_EXT_DOMDOCUMENT, $XML_RET_FAILURE)

	$__iLineNumber=1509 & ' - $oXSL_Document.async = False•./Include/_XML.au3'
	$oXSL_Document.async = False
	$__iLineNumber=1510 & ' - $oXSL_Document.load($sXSL_FileFullPath)•./Include/_XML.au3'
	$oXSL_Document.load($sXSL_FileFullPath)
	$__iLineNumber=1511 & ' - If $oXSL_Document.parseError.errorCode Then•./Include/_XML.au3'
	If $oXSL_Document.parseError.errorCode Then
		$__iLineNumber=1512 & ' - Return SetError($XML_ERR_PARSE, $oXmlDoc.parseError.errorCod ...•./Include/_XML.au3'
		Return SetError($XML_ERR_PARSE, $oXmlDoc.parseError.errorCode, $XML_RET_FAILURE)
	EndIf

	$__iLineNumber=1515 & ' - $oXSLT_Template.stylesheet = $oXSL_Document•./Include/_XML.au3'
	$oXSLT_Template.stylesheet = $oXSL_Document
	$__iLineNumber=1516 & ' - Local $oXSL_Processor = $oXSLT_Template.createProcessor()•./Include/_XML.au3'
	Local $oXSL_Processor = $oXSLT_Template.createProcessor()
	$__iLineNumber=1517 & ' - $oXSL_Processor.input = $oXmlDoc•./Include/_XML.au3'
	$oXSL_Processor.input = $oXmlDoc

	$__iLineNumber=1519 & ' - $oXmlDoc_Temp.transformNodeToObject($oXSL_Document, $oXmlDoc ...•./Include/_XML.au3'
	$oXmlDoc_Temp.transformNodeToObject($oXSL_Document, $oXmlDoc)
	$__iLineNumber=1520 & ' - If $oXSL_Document.parseError.errorCode Then•./Include/_XML.au3'
	If $oXSL_Document.parseError.errorCode Then
		$__iLineNumber=1521 & ' - Return SetError($XML_ERR_PARSE, $oXmlDoc_Temp.parseError.err ...•./Include/_XML.au3'
		Return SetError($XML_ERR_PARSE, $oXmlDoc_Temp.parseError.errorCode, $oXmlDoc_Temp.parseError.reason)
	EndIf

	; Replace oryginal document obecject
	$__iLineNumber=1525 & ' - $oXmlDoc = $oXmlDoc_Temp•./Include/_XML.au3'
	$oXmlDoc = $oXmlDoc_Temp

	; CleanUp
	$__iLineNumber=1528 & ' - $oXSL_Processor = Null•./Include/_XML.au3'
	$oXSL_Processor = Null
	$__iLineNumber=1529 & ' - $oXSLT_Template = Null•./Include/_XML.au3'
	$oXSLT_Template = Null
	$__iLineNumber=1530 & ' - $oXSL_Document = Null•./Include/_XML.au3'
	$oXSL_Document = Null
	$__iLineNumber=1531 & ' - $oXmlDoc_Temp = Null•./Include/_XML.au3'
	$oXmlDoc_Temp = Null

	$__iLineNumber=1533 & ' - Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCC ...•./Include/_XML.au3'
	Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCCESS)

EndFunc   ;==>_XML_Transform

; #FUNCTION# ====================================================================================================================
; Name ..........: _XML_UpdateField
; Description ...: Update existing single node based on XPath specs.
; Syntax ........: _XML_UpdateField(ByRef $oXmlDoc, $sXPath, $sData)
; Parameters ....: $oXmlDoc   - [in/out] an object. A valid DOMDocument or IXMLDOMElement object
;                  $sXPath    - a string value. The XML tree path from root node (root/child/child..)
;                  $sData     - The data to update the node with.
; Return values .: On Success - Returns $XML_RET_SUCCESS
;                  On Failure - Returns $XML_RET_FAILURE and sets the @error flag to non-zero (look in #Region XML.au3 - ERROR Enums)
; Author ........: Eltorro
; Modified ......: Weaponx, mLipok
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ===============================================================================================================================
$__iLineNumber=1553 & ' - Func _XML_UpdateField(ByRef $oXmlDoc, $sXPath, $sData)•./Include/_XML.au3'
Func _XML_UpdateField(ByRef $oXmlDoc, $sXPath, $sData)
	; Local Error handler declaration, it will be automatic CleanUp when returning from function
	$__iLineNumber=1555 & ' - Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XM ...•./Include/_XML.au3'
	Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XML_ComErrorHandler_InternalFunction)
	#forceref $oXML_COM_ErrorHandler

	$__iLineNumber=1558 & ' - Local $oNode_Selected = _XML_SelectSingleNode($oXmlDoc, $sXP ...•./Include/_XML.au3'
	Local $oNode_Selected = _XML_SelectSingleNode($oXmlDoc, $sXPath)
	$__iLineNumber=1559 & ' - If @error Then•./Include/_XML.au3'
	If @error Then
		$__iLineNumber=1560 & ' - Return SetError(@error, @extended, $XML_RET_FAILURE)•./Include/_XML.au3'
		Return SetError(@error, @extended, $XML_RET_FAILURE)
	ElseIf $oNode_Selected.hasChildNodes Then
		$__iLineNumber=1562 & ' - Local $bUpdateStatus = False•./Include/_XML.au3'
		Local $bUpdateStatus = False
		$__iLineNumber=1563 & ' - For $oNode_enum_Child In $oNode_Selected.childNodes()•./Include/_XML.au3'
		For $oNode_enum_Child In $oNode_Selected.childNodes()
			$__iLineNumber=1564 & ' - If $oNode_enum_Child.nodetype = $XML_NODE_TEXT Then•./Include/_XML.au3'
			If $oNode_enum_Child.nodetype = $XML_NODE_TEXT Then
				$__iLineNumber=1565 & ' - $oNode_enum_Child.Text = $sData•./Include/_XML.au3'
				$oNode_enum_Child.Text = $sData
				$__iLineNumber=1566 & ' - $bUpdateStatus = True•./Include/_XML.au3'
				$bUpdateStatus = True
				ExitLoop
			EndIf
		Next

		$__iLineNumber=1571 & ' - If Not $bUpdateStatus Then•./Include/_XML.au3'
		If Not $bUpdateStatus Then
			$__iLineNumber=1572 & ' - Local $oNode_Created = $oXmlDoc.createTextNode($sData)•./Include/_XML.au3'
			Local $oNode_Created = $oXmlDoc.createTextNode($sData)
			$__iLineNumber=1573 & ' - $oNode_Selected.appendChild($oNode_Created)•./Include/_XML.au3'
			$oNode_Selected.appendChild($oNode_Created)
			$__iLineNumber=1574 & ' - If @error Then Return SetError($XML_ERR_NODEAPPEND, @error,  ...•./Include/_XML.au3'
			If @error Then Return SetError($XML_ERR_NODEAPPEND, @error, $XML_RET_FAILURE)
		EndIf

		$__iLineNumber=1577 & ' - Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCC ...•./Include/_XML.au3'
		Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCCESS)
	EndIf
	$__iLineNumber=1579 & ' - Return SetError($XML_ERR_GENERAL, $XML_EXT_DEFAULT, $XML_RET ...•./Include/_XML.au3'
	Return SetError($XML_ERR_GENERAL, $XML_EXT_DEFAULT, $XML_RET_FAILURE)

EndFunc   ;==>_XML_UpdateField

; #FUNCTION# ====================================================================================================================
; Name ..........: _XML_UpdateField2
; Description ...: Update existing node(s) based on XPath specs.
; Syntax ........: _XML_UpdateField2(ByRef $oXmlDoc, $sXPath, $sData)
; Parameters ....: $oXmlDoc   - [in/out] an object. A valid DOMDocument or IXMLDOMElement object.
;                  $sXPath    - a string value. The XML tree path from root node (root/child/child..)
;                  $sData     - The data to update the node with.
; Return values .: On Success - Returns $XML_RET_SUCCESS
;                  On Failure - Returns $XML_RET_FAILURE and sets the @error flag to non-zero (look in #Region XML.au3 - ERROR Enums)
; Author ........: Eltorro
; Modified.......: Weaponx, mLipok
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: [yes/no]
; ===============================================================================================================================
$__iLineNumber=1599 & ' - Func _XML_UpdateField2(ByRef $oXmlDoc, $sXPath, $sData)•./Include/_XML.au3'
Func _XML_UpdateField2(ByRef $oXmlDoc, $sXPath, $sData)
	; Local Error handler declaration, it will be automatic CleanUp when returning from function
	$__iLineNumber=1601 & ' - Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XM ...•./Include/_XML.au3'
	Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XML_ComErrorHandler_InternalFunction)
	#forceref $oXML_COM_ErrorHandler

	$__iLineNumber=1604 & ' - Local $oNodesColl = _XML_SelectNodes($oXmlDoc, $sXPath)•./Include/_XML.au3'
	Local $oNodesColl = _XML_SelectNodes($oXmlDoc, $sXPath)
	$__iLineNumber=1605 & ' - If @error Then Return SetError(@error, @extended, $XML_RET_F ...•./Include/_XML.au3'
	If @error Then Return SetError(@error, @extended, $XML_RET_FAILURE)

	$__iLineNumber=1607 & ' - For $oNode_enum In $oNodesColl•./Include/_XML.au3'
	For $oNode_enum In $oNodesColl
		$__iLineNumber=1608 & ' - If $oNode_enum.hasChildNodes() Then•./Include/_XML.au3'
		If $oNode_enum.hasChildNodes() Then
			$__iLineNumber=1609 & ' - For $oNode_enum_Child In $oNode_enum.childNodes()•./Include/_XML.au3'
			For $oNode_enum_Child In $oNode_enum.childNodes()
				$__iLineNumber=1610 & ' - If $oNode_enum_Child.nodetype = $XML_NODE_TEXT Then•./Include/_XML.au3'
				If $oNode_enum_Child.nodetype = $XML_NODE_TEXT Then
					$__iLineNumber=1611 & ' - $oNode_enum_Child.Text = $sData•./Include/_XML.au3'
					$oNode_enum_Child.Text = $sData
					ExitLoop
				EndIf
			Next
		Else
			; TODO What here ???
		EndIf
	Next
	$__iLineNumber=1619 & ' - Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCC ...•./Include/_XML.au3'
	Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCCESS)

EndFunc   ;==>_XML_UpdateField2

; #FUNCTION# ====================================================================================================================
; Name ..........: _XML_Validate_File
; Description ...: Validates a document against a dtd.
; Syntax ........: _XML_Validate_File($sXMLFile, $sNameSpace, $sXSD_FileFullPath)
; Parameters ....: $sXMLFile          - The file to validate
;                  $sNameSpace        - xml namespace
;                  $sXSD_FileFullPath - DTD file to validate against.
; Return values .: On Success         - Returns $XML_RET_SUCCESS
;                  On Failure         - Returns $XML_RET_FAILURE and sets the @error flag to non-zero (look in #Region XML.au3 - ERROR Enums)
; Author ........: Eltorro
; Modified ......: mLipok
; Remarks .......: 	; TODO: Add such function but to work with object instead files ( I mean in memory validation )
; Related .......:
; Link ..........; https://msdn.microsoft.com/en-us/library/ms760267(v=vs.85).aspx
; Example .......; [yes/no]
; ===============================================================================================================================
$__iLineNumber=1639 & ' - Func _XML_Validate_File($sXMLFile, $sNameSpace, $sXSD_FileFu ...•./Include/_XML.au3'
Func _XML_Validate_File($sXMLFile, $sNameSpace, $sXSD_FileFullPath)
	; Local Error handler declaration, it will be automatic CleanUp when returning from function
	$__iLineNumber=1641 & ' - Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XM ...•./Include/_XML.au3'
	Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XML_ComErrorHandler_InternalFunction)
	#forceref $oXML_COM_ErrorHandler

	$__iLineNumber=1644 & ' - Local $oXmlDoc = _XML_CreateDOMDocument()•./Include/_XML.au3'
	Local $oXmlDoc = _XML_CreateDOMDocument()
	$__iLineNumber=1645 & ' - If @error Then Return SetError(@error, @extended, $XML_RET_F ...•./Include/_XML.au3'
	If @error Then Return SetError(@error, @extended, $XML_RET_FAILURE)

	$__iLineNumber=1647 & ' - Local $oXML_SchemaCache = ObjCreate("Msxml2.XMLSchemaCache." ...•./Include/_XML.au3'
	Local $oXML_SchemaCache = ObjCreate("Msxml2.XMLSchemaCache." & _XML_Misc_GetDomVersion() & ".0")
	$__iLineNumber=1648 & ' - If Not IsObj($oXML_SchemaCache) Then•./Include/_XML.au3'
	If Not IsObj($oXML_SchemaCache) Then
		$__iLineNumber=1649 & ' - Return SetError($XML_ERR_GENERAL, $XML_EXT_XMLSCHEMACACHE, $ ...•./Include/_XML.au3'
		Return SetError($XML_ERR_GENERAL, $XML_EXT_XMLSCHEMACACHE, $XML_RET_FAILURE)
	EndIf

	$__iLineNumber=1652 & ' - $oXML_SchemaCache.add($sNameSpace, $sXSD_FileFullPath)•./Include/_XML.au3'
	$oXML_SchemaCache.add($sNameSpace, $sXSD_FileFullPath)
	$__iLineNumber=1653 & ' - $oXmlDoc.schemas = $oXML_SchemaCache•./Include/_XML.au3'
	$oXmlDoc.schemas = $oXML_SchemaCache
	$__iLineNumber=1654 & ' - $oXmlDoc.async = False•./Include/_XML.au3'
	$oXmlDoc.async = False
	$__iLineNumber=1655 & ' - $oXmlDoc.ValidateOnParse = False•./Include/_XML.au3'
	$oXmlDoc.ValidateOnParse = False

	$__iLineNumber=1657 & ' - $oXmlDoc.load($sXMLFile)•./Include/_XML.au3'
	$oXmlDoc.load($sXMLFile)
	$__iLineNumber=1658 & ' - $oXmlDoc.validate()•./Include/_XML.au3'
	$oXmlDoc.validate()

	$__iLineNumber=1660 & ' - If $oXmlDoc.parseError.errorCode Then•./Include/_XML.au3'
	If $oXmlDoc.parseError.errorCode Then
		$__iLineNumber=1661 & ' - Return SetError($XML_ERR_PARSE, $oXmlDoc.parseError.errorCod ...•./Include/_XML.au3'
		Return SetError($XML_ERR_PARSE, $oXmlDoc.parseError.errorCode, $XML_RET_FAILURE)
	EndIf

	$__iLineNumber=1664 & ' - Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCC ...•./Include/_XML.au3'
	Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCCESS)

EndFunc   ;==>_XML_Validate_File
#EndRegion XML.au3 - Functions - Not yet reviewed

#Region XML.au3 - Functions - Work in progress

; #FUNCTION# ====================================================================================================================
; Name ..........: _XML_GetNodesCount
; Description ...: Get node count based on $sXPath and selected $iNodeType
; Syntax ........: _XML_GetNodesCount(ByRef $oXmlDoc, $sXPath[, $iNodeType = Default])
; Parameters ....: $oXmlDoc				- [in/out] an object. A valid DOMDocument or IXMLDOMElement object.
;                  $sXPath				- a string value. The XML tree path from root node (root/child/child..)
;                  $iNodeType			- [optional] an integer value. Default value is Default which mean any type.
; Return values .: Success				- Number of nodes found (can be 0)
;                  Failure				- $XML_RET_FAILURE and sets the @error flag to non-zero (look in #Region XML.au3 - ERROR Enums)
; Author ........: Eltorro & DickB
; Modified ......: mLipok
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......; [yes/no]
; ===============================================================================================================================
$__iLineNumber=1687 & ' - Func _XML_GetNodesCount(ByRef $oXmlDoc, $sXPath, $iNodeType  ...•./Include/_XML.au3'
Func _XML_GetNodesCount(ByRef $oXmlDoc, $sXPath, $iNodeType = Default)
	; Local Error handler declaration, it will be automatic CleanUp when returning from function
	$__iLineNumber=1689 & ' - Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XM ...•./Include/_XML.au3'
	Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XML_ComErrorHandler_InternalFunction)
	#forceref $oXML_COM_ErrorHandler

	$__iLineNumber=1692 & ' - Local $oNodesColl = _XML_SelectNodes($oXmlDoc, $sXPath)•./Include/_XML.au3'
	Local $oNodesColl = _XML_SelectNodes($oXmlDoc, $sXPath)
	$__iLineNumber=1693 & ' - If @error Then Return SetError(@error, @extended, $XML_RET_F ...•./Include/_XML.au3'
	If @error Then Return SetError(@error, @extended, $XML_RET_FAILURE)

	$__iLineNumber=1695 & ' - If $iNodeType = Default Then•./Include/_XML.au3'
	If $iNodeType = Default Then
		$__iLineNumber=1696 & ' - Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $oNodesColl.l ...•./Include/_XML.au3'
		Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $oNodesColl.length)
	ElseIf $iNodeType >= $XML_NODE_ELEMENT And $iNodeType <= $XML_NODE_NOTATION Then
		$__iLineNumber=1698 & ' - Local $iNodeCount = 0•./Include/_XML.au3'
		Local $iNodeCount = 0
		$__iLineNumber=1699 & ' - For $oNode_enum In $oNodesColl•./Include/_XML.au3'
		For $oNode_enum In $oNodesColl
			$__iLineNumber=1700 & ' - If $oNode_enum.nodeType = $iNodeType Then $iNodeCount += 1•./Include/_XML.au3'
			If $oNode_enum.nodeType = $iNodeType Then $iNodeCount += 1
		Next
		$__iLineNumber=1702 & ' - Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $iNodeCount)•./Include/_XML.au3'
		Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $iNodeCount)
	EndIf
	$__iLineNumber=1704 & ' - Return SetError($XML_ERR_PARAMETER, $XML_EXT_DEFAULT, $XML_R ...•./Include/_XML.au3'
	Return SetError($XML_ERR_PARAMETER, $XML_EXT_DEFAULT, $XML_RET_FAILURE)

EndFunc   ;==>_XML_GetNodesCount

; #FUNCTION# ====================================================================================================================
; Name ..........: _XML_InsertChildWAttr
; Description ...: Inserts a child node(s) under the specified XPath NodeCollection with attributes.
; Syntax ........: _XML_InsertChildWAttr(ByRef $oXmlDoc, $sXPath, $sNodeName[, $aAttributeList = Default[, $sNodeText = ""[, $sNameSpace = ""]]])
; Parameters ....: $oXmlDoc              - [in/out] an object. A valid DOMDocument or IXMLDOMElement object.
;                  $sXPath               - a string value. The XML tree path from root node (root/child/child..)
;                  $sNodeName            - a string value. The nodeName
;                  $iItem                - [optional] Item before which to insert the child. (Default = 0)
;                  $vAttributeNameOrList - [optional] Attribute name or an array of XML Attributes and Values. (Name|Value)
;                  $sAttribute_Value     - [optional] Attribute value if $vAttributeNameOrList is a string
;                  $sNodeText			 - [optional] a string value. Default is "".
;                  $sNameSpace           - [optional] a string value. Default is "".
; Return values .: Success				 - $XML_RET_SUCCESS
;                  Failure				 - $XML_RET_FAILURE and sets the @error flag to non-zero (look in #Region XML.au3 - ERROR Enums)
; Author ........: GMK
; Modified ......:
; Remarks .......: This function requires that each attribute name has a corresponding value.
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ===============================================================================================================================
$__iLineNumber=1729 & ' - Func _XML_InsertChildWAttr(ByRef $oXmlDoc, $sXPath, $sNodeNa ...•./Include/_XML.au3'
Func _XML_InsertChildWAttr(ByRef $oXmlDoc, $sXPath, $sNodeName, $iItem = 0, $vAttributeNameOrList = Default, $sAttribute_Value = "", $sNodeText = "", $sNameSpace = "")
	; Local Error handler declaration, it will be automatic CleanUp when returning from function
	$__iLineNumber=1731 & ' - Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XM ...•./Include/_XML.au3'
	Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XML_ComErrorHandler_InternalFunction)
	#forceref $oXML_COM_ErrorHandler

	$__iLineNumber=1734 & ' - Local Enum _•./Include/_XML.au3'
	Local Enum _
			$eATTRIBUTES_NAME, _
			$eATTRIBUTES_VALUE, _
			$eATTRIBUTES_ARRAYCOLCOUNT

	$__iLineNumber=1739 & ' - If (UBound($vAttributeNameOrList) > 0 And UBound($vAttribute ...•./Include/_XML.au3'
	If (UBound($vAttributeNameOrList) > 0 And UBound($vAttributeNameOrList, 2) <> $eATTRIBUTES_ARRAYCOLCOUNT) Then Return SetError($XML_ERR_ARRAY, $XML_EXT_DEFAULT, $XML_RET_FAILURE)

	$__iLineNumber=1741 & ' - Local $iLastAttribute = UBound($vAttributeNameOrList) - 1•./Include/_XML.au3'
	Local $iLastAttribute = UBound($vAttributeNameOrList) - 1
	$__iLineNumber=1742 & ' - For $iAttribute_idx = 0 To $iLastAttribute•./Include/_XML.au3'
	For $iAttribute_idx = 0 To $iLastAttribute
		$__iLineNumber=1743 & ' - If _•./Include/_XML.au3'
		If _
				$vAttributeNameOrList[$iAttribute_idx][$eATTRIBUTES_NAME] = '' _
				Or (Not IsString($vAttributeNameOrList[$iAttribute_idx][$eATTRIBUTES_NAME])) _
				Or (Not IsString($vAttributeNameOrList[$iAttribute_idx][$eATTRIBUTES_VALUE])) _
				 Then
			$__iLineNumber=1748 & ' - Return SetError($XML_ERR_ARRAY, $XML_EXT_DEFAULT, $XML_RET_F ...•./Include/_XML.au3'
			Return SetError($XML_ERR_ARRAY, $XML_EXT_DEFAULT, $XML_RET_FAILURE)
		EndIf
	Next

	$__iLineNumber=1752 & ' - Local $oNodesColl = _XML_SelectNodes($oXmlDoc, $sXPath)•./Include/_XML.au3'
	Local $oNodesColl = _XML_SelectNodes($oXmlDoc, $sXPath)
	$__iLineNumber=1753 & ' - If @error Then Return SetError(@error, @extended, $XML_RET_F ...•./Include/_XML.au3'
	If @error Then Return SetError(@error, @extended, $XML_RET_FAILURE)

	$__iLineNumber=1755 & ' - Local $oChild_Temp = Null, $oAttribute_Temp = Null•./Include/_XML.au3'
	Local $oChild_Temp = Null, $oAttribute_Temp = Null
	$__iLineNumber=1756 & ' - For $oNode_enum In $oNodesColl•./Include/_XML.au3'
	For $oNode_enum In $oNodesColl
		$__iLineNumber=1757 & ' - If $sNameSpace = "" Then•./Include/_XML.au3'
		If $sNameSpace = "" Then
			$__iLineNumber=1758 & ' - If Not ($oNode_enum.namespaceURI = 0 Or $oNode_enum.namespac ...•./Include/_XML.au3'
			If Not ($oNode_enum.namespaceURI = 0 Or $oNode_enum.namespaceURI = "") Then $sNameSpace = $oNode_enum.namespaceURI
		EndIf

		$__iLineNumber=1761 & ' - $oChild_Temp = $oXmlDoc.createNode($XML_NODE_ELEMENT, $sNode ...•./Include/_XML.au3'
		$oChild_Temp = $oXmlDoc.createNode($XML_NODE_ELEMENT, $sNodeName, $sNameSpace)
		$__iLineNumber=1762 & ' - If @error Then Return SetError($XML_ERR_NODECREATE, @error,  ...•./Include/_XML.au3'
		If @error Then Return SetError($XML_ERR_NODECREATE, @error, $XML_RET_FAILURE)

		$__iLineNumber=1764 & ' - If $sNodeText <> "" Then $oChild_Temp.text = $sNodeText•./Include/_XML.au3'
		If $sNodeText <> "" Then $oChild_Temp.text = $sNodeText

		$__iLineNumber=1766 & ' - If IsArray($vAttributeNameOrList) And UBound($vAttributeName ...•./Include/_XML.au3'
		If IsArray($vAttributeNameOrList) And UBound($vAttributeNameOrList) > 0 Then
			$__iLineNumber=1767 & ' - For $iAttribute_idx = 0 To UBound($vAttributeNameOrList) - 1•./Include/_XML.au3'
			For $iAttribute_idx = 0 To UBound($vAttributeNameOrList) - 1
				$__iLineNumber=1768 & ' - $oAttribute_Temp = $oXmlDoc.createAttribute($vAttributeNameO ...•./Include/_XML.au3'
				$oAttribute_Temp = $oXmlDoc.createAttribute($vAttributeNameOrList[$iAttribute_idx][$eATTRIBUTES_NAME]) ;, $sNameSpace) ; TODO Check this comment
				$__iLineNumber=1769 & ' - If @error Then ExitLoop ; TODO Description ?•./Include/_XML.au3'
				If @error Then ExitLoop ; TODO Description ?
				$__iLineNumber=1770 & ' - $oAttribute_Temp.value = $vAttributeNameOrList[$iAttribute_i ...•./Include/_XML.au3'
				$oAttribute_Temp.value = $vAttributeNameOrList[$iAttribute_idx][$eATTRIBUTES_VALUE]
				$__iLineNumber=1771 & ' - $oChild_Temp.setAttributeNode($oAttribute_Temp)•./Include/_XML.au3'
				$oChild_Temp.setAttributeNode($oAttribute_Temp)
			Next
		Else
			$__iLineNumber=1774 & ' - $oAttribute_Temp = $oXmlDoc.createAttribute($vAttributeNameO ...•./Include/_XML.au3'
			$oAttribute_Temp = $oXmlDoc.createAttribute($vAttributeNameOrList) ;, $sNameSpace) ; TODO Check this comment
			$__iLineNumber=1775 & ' - $oAttribute_Temp.value = $sAttribute_Value•./Include/_XML.au3'
			$oAttribute_Temp.value = $sAttribute_Value
			$__iLineNumber=1776 & ' - $oChild_Temp.setAttributeNode($oAttribute_Temp)•./Include/_XML.au3'
			$oChild_Temp.setAttributeNode($oAttribute_Temp)
		EndIf

		; Inserts a new child node before the given item of the parent node
		$__iLineNumber=1780 & ' - $oNode_enum.insertBefore($oChild_Temp, $oNode_enum.childNode ...•./Include/_XML.au3'
		$oNode_enum.insertBefore($oChild_Temp, $oNode_enum.childNodes.item($iItem))
		$__iLineNumber=1781 & ' - If @error Then Return SetError($XML_ERR_NODEAPPEND, @error,  ...•./Include/_XML.au3'
		If @error Then Return SetError($XML_ERR_NODEAPPEND, @error, $XML_RET_FAILURE)

	Next

	$__iLineNumber=1785 & ' - $oChild_Temp = Null•./Include/_XML.au3'
	$oChild_Temp = Null
	$__iLineNumber=1786 & ' - Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCC ...•./Include/_XML.au3'
	Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCCESS)

EndFunc   ;==>_XML_InsertChildWAttr

; #FUNCTION# ====================================================================================================================
; Name ..........: _XML_RemoveAttribute
; Description ...: Delete XML Attribute based on XPath input from root node.
; Syntax ........: _XML_RemoveAttribute(ByRef $oXmlDoc, $sXPath, $sAttribute_name)
; Parameters ....: $oXmlDoc 			- [in/out] an object. A valid DOMDocument or IXMLDOMElement object.
;                  $sXPath              - a string value. The XML tree path from root node (root/child/child..)
;                  $sAttribute_name     - a string value.
; Return values .: Success        		- $XML_RET_SUCCESS
;                  Failure             	- $XML_RET_FAILURE and sets the @error flag to non-zero (look in #Region XML.au3 - ERROR Enums)
; Author ........: Eltorro
; Modified ......: mLipok
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: [yes/no]
; ===============================================================================================================================
$__iLineNumber=1806 & ' - Func _XML_RemoveAttribute(ByRef $oXmlDoc, $sXPath, $sAttribu ...•./Include/_XML.au3'
Func _XML_RemoveAttribute(ByRef $oXmlDoc, $sXPath, $sAttribute_Name)
	; Local Error handler declaration, it will be automatic CleanUp when returning from function
	$__iLineNumber=1808 & ' - Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XM ...•./Include/_XML.au3'
	Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XML_ComErrorHandler_InternalFunction)
	#forceref $oXML_COM_ErrorHandler

	$__iLineNumber=1811 & ' - Local $oNode_Selected = _XML_SelectSingleNode($oXmlDoc, $sXP ...•./Include/_XML.au3'
	Local $oNode_Selected = _XML_SelectSingleNode($oXmlDoc, $sXPath)
	$__iLineNumber=1812 & ' - If @error Then Return SetError(@error, @extended, $XML_RET_F ...•./Include/_XML.au3'
	If @error Then Return SetError(@error, @extended, $XML_RET_FAILURE)

	$__iLineNumber=1814 & ' - Local $oAttribute = $oNode_Selected.getAttributeNode($sAttri ...•./Include/_XML.au3'
	Local $oAttribute = $oNode_Selected.getAttributeNode($sAttribute_Name)
	$__iLineNumber=1815 & ' - If Not (IsObj($oAttribute)) Then•./Include/_XML.au3'
	If Not (IsObj($oAttribute)) Then
		$__iLineNumber=1816 & ' - Return SetError($XML_ERR_NOATTRMATCH, $XML_EXT_DEFAULT, $XML ...•./Include/_XML.au3'
		Return SetError($XML_ERR_NOATTRMATCH, $XML_EXT_DEFAULT, $XML_RET_FAILURE)
	EndIf

	; https://msdn.microsoft.com/en-us/library/ms757848(v=vs.85).aspx
	$__iLineNumber=1820 & ' - Local $iAttributesLength = $oNode_Selected.attributes.length•./Include/_XML.au3'
	Local $iAttributesLength = $oNode_Selected.attributes.length
	$__iLineNumber=1821 & ' - Local $oAttribute_Removed = $oNode_Selected.removeAttributeN ...•./Include/_XML.au3'
	Local $oAttribute_Removed = $oNode_Selected.removeAttributeNode($oAttribute)

	$__iLineNumber=1823 & ' - If Not IsObj($oAttribute_Removed) Or ($iAttributesLength = 1 ...•./Include/_XML.au3'
	If Not IsObj($oAttribute_Removed) Or ($iAttributesLength = 1 + $oNode_Selected.attributes.length) Then
		$__iLineNumber=1824 & ' - Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCC ...•./Include/_XML.au3'
		Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCCESS)
	EndIf
	$__iLineNumber=1826 & ' - Return SetError($XML_ERR_GENERAL, $XML_EXT_DEFAULT, $XML_RET ...•./Include/_XML.au3'
	Return SetError($XML_ERR_GENERAL, $XML_EXT_DEFAULT, $XML_RET_FAILURE)

EndFunc   ;==>_XML_RemoveAttribute

; #FUNCTION# ====================================================================================================================
; Name ..........: _XML_TransformNode
; Description ...: Process given XML file with a given XSL stylesheet, in order to transform it to given HTML file
; Syntax ........: _XML_TransformNode($sXML_FileFullPath, $sXSL_FileFullPath, $sHTML_FileFullPath[, $iEncoding = $FO_UTF8_NOBOM])
; Parameters ....: $sXML_FileFullPath   - a string value.
;                  $sXSL_FileFullPath   - a string value.
;                  $sHTML_FileFullPath  - a string value.
;                  $iEncoding           - [optional] an integer value. Default is $FO_UTF8_NOBOM.
; Return values .: Success             - 1 and set @error = 0
;                  Failure             - $XML_RET_FAILURE and sets the @error flag to non-zero (look in #Region XML.au3 - ERROR Enums)
; Author ........: mLipok
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
$__iLineNumber=1847 & ' - Func _XML_TransformNode($sXML_FileFullPath, $sXSL_FileFullPa ...•./Include/_XML.au3'
Func _XML_TransformNode($sXML_FileFullPath, $sXSL_FileFullPath, $sHTML_FileFullPath, $iEncoding = $FO_UTF8_NOBOM)
	; Local Error handler declaration, it will be automatic CleanUp when returning from function
	$__iLineNumber=1849 & ' - Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XM ...•./Include/_XML.au3'
	Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XML_ComErrorHandler_InternalFunction)
	#forceref $oXML_COM_ErrorHandler

	$__iLineNumber=1852 & ' - Local $oXSL_Document = ObjCreate("Microsoft.XMLDOM")•./Include/_XML.au3'
	Local $oXSL_Document = ObjCreate("Microsoft.XMLDOM")
	$__iLineNumber=1853 & ' - If @error Then Return SetError($XML_ERR_OBJCREATE, $XML_EXT_ ...•./Include/_XML.au3'
	If @error Then Return SetError($XML_ERR_OBJCREATE, $XML_EXT_XMLDOM, $XML_RET_FAILURE)

	$__iLineNumber=1855 & ' - Local $oXmlDoc = ObjCreate("Microsoft.XMLDOM")•./Include/_XML.au3'
	Local $oXmlDoc = ObjCreate("Microsoft.XMLDOM")
	$__iLineNumber=1856 & ' - If @error Then Return SetError($XML_ERR_OBJCREATE, $XML_EXT_ ...•./Include/_XML.au3'
	If @error Then Return SetError($XML_ERR_OBJCREATE, $XML_EXT_XMLDOM, $XML_RET_FAILURE)

	$__iLineNumber=1858 & ' - $oXSL_Document.Async = False•./Include/_XML.au3'
	$oXSL_Document.Async = False
	$__iLineNumber=1859 & ' - $oXSL_Document.Load($sXSL_FileFullPath)•./Include/_XML.au3'
	$oXSL_Document.Load($sXSL_FileFullPath)
	$__iLineNumber=1860 & ' - If $oXSL_Document.parseError.errorCode Then•./Include/_XML.au3'
	If $oXSL_Document.parseError.errorCode Then
		$__iLineNumber=1861 & ' - Return SetError($XML_ERR_PARSE_XSL, $oXSL_Document.parseErro ...•./Include/_XML.au3'
		Return SetError($XML_ERR_PARSE_XSL, $oXSL_Document.parseError.errorCode, $XML_RET_FAILURE)
	EndIf

	$__iLineNumber=1864 & ' - $oXmlDoc.Async = False•./Include/_XML.au3'
	$oXmlDoc.Async = False
	$__iLineNumber=1865 & ' - $oXmlDoc.Load($sXML_FileFullPath)•./Include/_XML.au3'
	$oXmlDoc.Load($sXML_FileFullPath)
	$__iLineNumber=1866 & ' - If $oXmlDoc.parseError.errorCode Then•./Include/_XML.au3'
	If $oXmlDoc.parseError.errorCode Then
		$__iLineNumber=1867 & ' - Return SetError($XML_ERR_PARSE, $oXmlDoc.parseError.errorCod ...•./Include/_XML.au3'
		Return SetError($XML_ERR_PARSE, $oXmlDoc.parseError.errorCode, $XML_RET_FAILURE)
	EndIf

	$__iLineNumber=1870 & ' - Local $sHTML = $oXmlDoc.transformNode($oXSL_Document)•./Include/_XML.au3'
	Local $sHTML = $oXmlDoc.transformNode($oXSL_Document)

	$__iLineNumber=1872 & ' - Local $hFile = FileOpen($sHTML_FileFullPath, $FO_OVERWRITE + ...•./Include/_XML.au3'
	Local $hFile = FileOpen($sHTML_FileFullPath, $FO_OVERWRITE + $iEncoding)
	$__iLineNumber=1873 & ' - FileWrite($hFile, $sHTML)•./Include/_XML.au3'
	FileWrite($hFile, $sHTML)
	$__iLineNumber=1874 & ' - FileClose($hFile)•./Include/_XML.au3'
	FileClose($hFile)
	$__iLineNumber=1875 & ' - Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCC ...•./Include/_XML.au3'
	Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCCESS)

EndFunc   ;==>_XML_TransformNode
#EndRegion XML.au3 - Functions - Work in progress

#Region XML.au3 - Functions - COMPLETED

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name ..........: __XML_IsValidObject_Attributes
; Description ...: Check if Object is valid IXMLDOMNamedNodeMap Object
; Syntax ........: __XML_IsValidObject_Attributes(ByRef $oAttributes)
; Parameters ....: $oAttributes                - [in/out] an object.
; Return values .: Success             - $XML_RET_SUCCESS
;                  Failure             - $XML_RET_FAILURE and sets the @error flag to non-zero (look in #Region XML.au3 - ERROR Enums)
; Author ........: mLipok
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
$__iLineNumber=1896 & ' - Func __XML_IsValidObject_Attributes(ByRef $oAttributes)•./Include/_XML.au3'
Func __XML_IsValidObject_Attributes(ByRef $oAttributes)
	$__iLineNumber=1897 & ' - If Not IsObj($oAttributes) Then•./Include/_XML.au3'
	If Not IsObj($oAttributes) Then
		$__iLineNumber=1898 & ' - Return SetError($XML_ERR_ISNOTOBJECT, $XML_EXT_DEFAULT, $XML ...•./Include/_XML.au3'
		Return SetError($XML_ERR_ISNOTOBJECT, $XML_EXT_DEFAULT, $XML_RET_FAILURE)
	ElseIf ObjName($oAttributes, $OBJ_NAME) <> 'IXMLDOMNamedNodeMap' Then
		$__iLineNumber=1900 & ' - Return SetError($XML_ERR_INVALIDATTRIB, $XML_EXT_DEFAULT, $X ...•./Include/_XML.au3'
		Return SetError($XML_ERR_INVALIDATTRIB, $XML_EXT_DEFAULT, $XML_RET_FAILURE)
	EndIf
	$__iLineNumber=1902 & ' - Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCC ...•./Include/_XML.au3'
	Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCCESS)
EndFunc   ;==>__XML_IsValidObject_Attributes

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name ..........: __XML_IsValidObject_DOMDocument
; Description ...: Check if Object is valid Msxml2.DOMDocument.xxxx Object
; Syntax ........: __XML_IsValidObject_DOMDocument(ByRef $oXML)
; Parameters ....: $oXML                - [in/out] an object.
; Return values .: Success             - $XML_RET_SUCCESS
;                  Failure             - $XML_RET_FAILURE and sets the @error flag to non-zero (look in #Region XML.au3 - ERROR Enums)
; Author ........: mLipok
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
$__iLineNumber=1919 & ' - Func __XML_IsValidObject_DOMDocument(ByRef $oXML)•./Include/_XML.au3'
Func __XML_IsValidObject_DOMDocument(ByRef $oXML)
	$__iLineNumber=1920 & ' - If Not IsObj($oXML) Then•./Include/_XML.au3'
	If Not IsObj($oXML) Then
		$__iLineNumber=1921 & ' - Return SetError($XML_ERR_ISNOTOBJECT, $XML_EXT_DEFAULT, $XML ...•./Include/_XML.au3'
		Return SetError($XML_ERR_ISNOTOBJECT, $XML_EXT_DEFAULT, $XML_RET_FAILURE)
	ElseIf StringInStr(ObjName($oXML, $OBJ_NAME), 'DOMDocument') = 0 Then
		$__iLineNumber=1923 & ' - Return SetError($XML_ERR_INVALIDDOMDOC, $XML_EXT_DOMDOCUMENT ...•./Include/_XML.au3'
		Return SetError($XML_ERR_INVALIDDOMDOC, $XML_EXT_DOMDOCUMENT, $XML_RET_FAILURE)
	EndIf
	$__iLineNumber=1925 & ' - Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCC ...•./Include/_XML.au3'
	Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCCESS)
EndFunc   ;==>__XML_IsValidObject_DOMDocument

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name ..........: __XML_IsValidObject_DOMDocumentOrElement
; Description ...: Check if Object is valid Msxml2.DOMDocument.xxxx Object or IXMLDOMElement
; Syntax ........: __XML_IsValidObject_DOMDocumentOrElement(Byref $oXML)
; Parameters ....: $oXML                - [in/out] an object.
; Return values .: Success             - $XML_RET_SUCCESS
;                  Failure             - $XML_RET_FAILURE and sets the @error flag to non-zero (look in #Region XML.au3 - ERROR Enums)
; Return values .: None
; Author ........: Your Name
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
$__iLineNumber=1943 & ' - Func __XML_IsValidObject_DOMDocumentOrElement(ByRef $oXML)•./Include/_XML.au3'
Func __XML_IsValidObject_DOMDocumentOrElement(ByRef $oXML)
	$__iLineNumber=1944 & ' - If Not IsObj($oXML) Then•./Include/_XML.au3'
	If Not IsObj($oXML) Then
		$__iLineNumber=1945 & ' - Return SetError($XML_ERR_ISNOTOBJECT, $XML_EXT_DEFAULT, $XML ...•./Include/_XML.au3'
		Return SetError($XML_ERR_ISNOTOBJECT, $XML_EXT_DEFAULT, $XML_RET_FAILURE)
	ElseIf StringInStr(ObjName($oXML, $OBJ_NAME), 'DOMDocument') = 0 And StringInStr(ObjName($oXML, $OBJ_NAME), 'IXMLDOMElement') = 0 Then
		$__iLineNumber=1947 & ' - Return SetError($XML_ERR_INVALIDDOMDOC, $XML_EXT_DOMDOCUMENT ...•./Include/_XML.au3'
		Return SetError($XML_ERR_INVALIDDOMDOC, $XML_EXT_DOMDOCUMENT, $XML_RET_FAILURE)
	EndIf
	$__iLineNumber=1949 & ' - Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCC ...•./Include/_XML.au3'
	Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCCESS)
EndFunc   ;==>__XML_IsValidObject_DOMDocumentOrElement

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name ..........: __XML_IsValidObject_Node
; Description ...: Check if Object is valid IXMLDOMSelection Object
; Syntax ........: __XML_IsValidObject_Node(ByRef $oNode[, $iNodeType = Default])
; Parameters ....: $oNode               - [in/out] an object.
;                  $iNodeType           - [optional] an integer value. Default value is Default this mean any type.
; Return values .: Success             - $XML_RET_SUCCESS
;                  Failure             - $XML_RET_FAILURE and sets the @error flag to non-zero (look in #Region XML.au3 - ERROR Enums)
; Author ........: mLipok
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
$__iLineNumber=1967 & ' - Func __XML_IsValidObject_Node(ByRef $oNode, $iNodeType = Def ...•./Include/_XML.au3'
Func __XML_IsValidObject_Node(ByRef $oNode, $iNodeType = Default)
	$__iLineNumber=1968 & ' - If Not IsObj($oNode) Then•./Include/_XML.au3'
	If Not IsObj($oNode) Then
		$__iLineNumber=1969 & ' - Return SetError($XML_ERR_ISNOTOBJECT, $XML_EXT_PARAM1, $XML_ ...•./Include/_XML.au3'
		Return SetError($XML_ERR_ISNOTOBJECT, $XML_EXT_PARAM1, $XML_RET_FAILURE)
	ElseIf ObjName($oNode, $OBJ_NAME) <> 'IXMLDOMNode' And ObjName($oNode, $OBJ_NAME) <> 'IXMLDOMElement' Then
		$__iLineNumber=1971 & ' - Return SetError($XML_ERR_INVALIDNODETYPE, $XML_EXT_DEFAULT,  ...•./Include/_XML.au3'
		Return SetError($XML_ERR_INVALIDNODETYPE, $XML_EXT_DEFAULT, ObjName($oNode, $OBJ_NAME))
	ElseIf $iNodeType = Default Then
		; do not check type
		$__iLineNumber=1974 & ' - Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCC ...•./Include/_XML.au3'
		Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCCESS)
	ElseIf $iNodeType >= $XML_NODE_ELEMENT And $iNodeType <= $XML_NODE_NOTATION Then
		$__iLineNumber=1976 & ' - If $iNodeType = $oNode.type Then•./Include/_XML.au3'
		If $iNodeType = $oNode.type Then
			$__iLineNumber=1977 & ' - Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCC ...•./Include/_XML.au3'
			Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCCESS)
		EndIf
		$__iLineNumber=1979 & ' - Return SetError($XML_ERR_INVALIDNODETYPE, $oNode.type, $XML_ ...•./Include/_XML.au3'
		Return SetError($XML_ERR_INVALIDNODETYPE, $oNode.type, $XML_RET_FAILURE)
	EndIf
	$__iLineNumber=1981 & ' - Return SetError($XML_ERR_PARAMETER, $XML_EXT_PARAM2, $XML_RE ...•./Include/_XML.au3'
	Return SetError($XML_ERR_PARAMETER, $XML_EXT_PARAM2, $XML_RET_FAILURE)
EndFunc   ;==>__XML_IsValidObject_Node

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name ..........: __XML_IsValidObject_NodesColl
; Description ...: Check if Object is valid IXMLDOMSelection Object
; Syntax ........: __XML_IsValidObject_NodesColl(ByRef $oNodesColl)
; Parameters ....: $oNodesColl                - [in/out] an object.
; Return values .: Success             - $XML_RET_SUCCESS
;                  Failure             - $XML_RET_FAILURE and sets the @error flag to non-zero (look in #Region XML.au3 - ERROR Enums)
; Author ........: mLipok
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
$__iLineNumber=1998 & ' - Func __XML_IsValidObject_NodesColl(ByRef $oNodesColl)•./Include/_XML.au3'
Func __XML_IsValidObject_NodesColl(ByRef $oNodesColl)
	$__iLineNumber=1999 & ' - If Not IsObj($oNodesColl) Then•./Include/_XML.au3'
	If Not IsObj($oNodesColl) Then
		$__iLineNumber=2000 & ' - Return SetError($XML_ERR_ISNOTOBJECT, $XML_EXT_DEFAULT, $XML ...•./Include/_XML.au3'
		Return SetError($XML_ERR_ISNOTOBJECT, $XML_EXT_DEFAULT, $XML_RET_FAILURE)
	ElseIf ObjName($oNodesColl, $OBJ_NAME) <> 'IXMLDOMSelection' Then
		$__iLineNumber=2002 & ' - Return SetError($XML_ERR_INVALIDNODETYPE, $XML_EXT_DEFAULT,  ...•./Include/_XML.au3'
		Return SetError($XML_ERR_INVALIDNODETYPE, $XML_EXT_DEFAULT, ObjName($oNodesColl, $OBJ_NAME))
	EndIf
	$__iLineNumber=2004 & ' - Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCC ...•./Include/_XML.au3'
	Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCCESS)
EndFunc   ;==>__XML_IsValidObject_NodesColl

; #FUNCTION# ====================================================================================================================
; Name ..........: _XML_CreateChildWAttr
; Description ...: Create a child node(s) under the specified XPath NodeCollection with attributes.
; Syntax ........: _XML_CreateChildWAttr(ByRef $oXmlDoc, $sXPath, $sNodeName[, $aAttributeList = Default[, $sNodeText = ""[,
;                  $sNameSpace = ""]]])
; Parameters ....: $oXmlDoc 			- [in/out] an object. A valid DOMDocument or IXMLDOMElement object.
;                  $sXPath              - a string value. The XML tree path from root node (root/child/child..)
;                  $sNodeName           - a string value. The nodeName
;                  $aAttributeList      - [optional] an array of XML Attributes. Column0=Name, Column1=Value
;                  $sNodeText			- [optional] a string value. Default is "".
;                  $sNameSpace          - [optional] a string value. Default is "".
; Return values .: Success				- $XML_RET_SUCCESS
;                  Failure				- $XML_RET_FAILURE and sets the @error flag to non-zero (look in #Region XML.au3 - ERROR Enums)
; Author ........: Eltorro
; Modified ......: mLipok
; Remarks .......: This function requires that each attribute name has a corresponding value.
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ===============================================================================================================================
$__iLineNumber=2027 & ' - Func _XML_CreateChildWAttr(ByRef $oXmlDoc, $sXPath, $sNodeNa ...•./Include/_XML.au3'
Func _XML_CreateChildWAttr(ByRef $oXmlDoc, $sXPath, $sNodeName, $aAttributeList = Default, $sNodeText = "", $sNameSpace = "")
	; Local Error handler declaration, it will be automatic CleanUp when returning from function
	$__iLineNumber=2029 & ' - Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XM ...•./Include/_XML.au3'
	Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XML_ComErrorHandler_InternalFunction)
	#forceref $oXML_COM_ErrorHandler

	$__iLineNumber=2032 & ' - Local Enum _•./Include/_XML.au3'
	Local Enum _
			$eATTRIBUTES_NAME, _
			$eATTRIBUTES_VALUE, _
			$eATTRIBUTES_ARRAYCOLCOUNT

	$__iLineNumber=2037 & ' - If IsArray($aAttributeList) Then•./Include/_XML.au3'
	If IsArray($aAttributeList) Then
		$__iLineNumber=2038 & ' - If Not (UBound($aAttributeList) > 0 And UBound($aAttributeLi ...•./Include/_XML.au3'
		If Not (UBound($aAttributeList) > 0 And UBound($aAttributeList, 2) = $eATTRIBUTES_ARRAYCOLCOUNT) Then
			$__iLineNumber=2039 & ' - Return SetError($XML_ERR_ARRAY, $XML_EXT_DEFAULT, $XML_RET_F ...•./Include/_XML.au3'
			Return SetError($XML_ERR_ARRAY, $XML_EXT_DEFAULT, $XML_RET_FAILURE)
		EndIf

		$__iLineNumber=2042 & ' - For $iAttribute_idx = 0 To UBound($aAttributeList) - 1•./Include/_XML.au3'
		For $iAttribute_idx = 0 To UBound($aAttributeList) - 1
			$__iLineNumber=2043 & ' - If _•./Include/_XML.au3'
			If _
					$aAttributeList[$iAttribute_idx][$eATTRIBUTES_NAME] = '' _
					Or (Not IsString($aAttributeList[$iAttribute_idx][$eATTRIBUTES_NAME])) _
					Or $aAttributeList[$iAttribute_idx][$eATTRIBUTES_VALUE] = '' _ ;  TODO: QUESTION: is Value must be not empty string ?
					Or (Not IsString($aAttributeList[$iAttribute_idx][$eATTRIBUTES_VALUE])) _
					 Then
				$__iLineNumber=2049 & ' - Return SetError($XML_ERR_ARRAY, $XML_EXT_DEFAULT, $XML_RET_F ...•./Include/_XML.au3'
				Return SetError($XML_ERR_ARRAY, $XML_EXT_DEFAULT, $XML_RET_FAILURE)
			EndIf
		Next
	ElseIf Not $aAttributeList = Default Then
		$__iLineNumber=2053 & ' - Return SetError($XML_ERR_ARRAY, $XML_EXT_DEFAULT, $XML_RET_F ...•./Include/_XML.au3'
		Return SetError($XML_ERR_ARRAY, $XML_EXT_DEFAULT, $XML_RET_FAILURE)
	EndIf

	$__iLineNumber=2056 & ' - Local $oNodesColl = _XML_SelectNodes($oXmlDoc, $sXPath)•./Include/_XML.au3'
	Local $oNodesColl = _XML_SelectNodes($oXmlDoc, $sXPath)
	$__iLineNumber=2057 & ' - If @error Then Return SetError(@error, @extended, $XML_RET_F ...•./Include/_XML.au3'
	If @error Then Return SetError(@error, @extended, $XML_RET_FAILURE)

	$__iLineNumber=2059 & ' - Local $oChild_Temp = Null, $oAttribute_Temp = Null•./Include/_XML.au3'
	Local $oChild_Temp = Null, $oAttribute_Temp = Null
	$__iLineNumber=2060 & ' - For $oNode_enum In $oNodesColl•./Include/_XML.au3'
	For $oNode_enum In $oNodesColl
		$__iLineNumber=2061 & ' - If $sNameSpace = "" Then•./Include/_XML.au3'
		If $sNameSpace = "" Then
			$__iLineNumber=2062 & ' - If Not ($oNode_enum.namespaceURI = 0 Or $oNode_enum.namespac ...•./Include/_XML.au3'
			If Not ($oNode_enum.namespaceURI = 0 Or $oNode_enum.namespaceURI = "") Then $sNameSpace = $oNode_enum.namespaceURI
		EndIf

		$__iLineNumber=2065 & ' - $oChild_Temp = $oXmlDoc.createNode($XML_NODE_ELEMENT, $sNode ...•./Include/_XML.au3'
		$oChild_Temp = $oXmlDoc.createNode($XML_NODE_ELEMENT, $sNodeName, $sNameSpace)
		$__iLineNumber=2066 & ' - If @error Then Return SetError($XML_ERR_NODECREATE, @error,  ...•./Include/_XML.au3'
		If @error Then Return SetError($XML_ERR_NODECREATE, @error, $XML_RET_FAILURE)

		$__iLineNumber=2068 & ' - If $sNodeText <> "" Then $oChild_Temp.text = $sNodeText•./Include/_XML.au3'
		If $sNodeText <> "" Then $oChild_Temp.text = $sNodeText

		$__iLineNumber=2070 & ' - If UBound($aAttributeList) Then•./Include/_XML.au3'
		If UBound($aAttributeList) Then
			$__iLineNumber=2071 & ' - For $iAttribute_idx = 0 To UBound($aAttributeList) - 1•./Include/_XML.au3'
			For $iAttribute_idx = 0 To UBound($aAttributeList) - 1
				$__iLineNumber=2072 & ' - $oAttribute_Temp = $oXmlDoc.createAttribute($aAttributeList[ ...•./Include/_XML.au3'
				$oAttribute_Temp = $oXmlDoc.createAttribute($aAttributeList[$iAttribute_idx][$eATTRIBUTES_NAME]) ;, $sNameSpace) ; TODO Check this comment
				$__iLineNumber=2073 & ' - If @error Then ExitLoop ; TODO Description ?•./Include/_XML.au3'
				If @error Then ExitLoop ; TODO Description ?

				$__iLineNumber=2075 & ' - $oAttribute_Temp.value = $aAttributeList[$iAttribute_idx][$e ...•./Include/_XML.au3'
				$oAttribute_Temp.value = $aAttributeList[$iAttribute_idx][$eATTRIBUTES_VALUE]
				$__iLineNumber=2076 & ' - $oChild_Temp.setAttributeNode($oAttribute_Temp)•./Include/_XML.au3'
				$oChild_Temp.setAttributeNode($oAttribute_Temp)
			Next
		EndIf

		; Appends a new child node as the last child of the node.
		$__iLineNumber=2081 & ' - $oNode_enum.appendChild($oChild_Temp)•./Include/_XML.au3'
		$oNode_enum.appendChild($oChild_Temp)
		$__iLineNumber=2082 & ' - If @error Then Return SetError($XML_ERR_NODEAPPEND, @error,  ...•./Include/_XML.au3'
		If @error Then Return SetError($XML_ERR_NODEAPPEND, @error, $XML_RET_FAILURE)
	Next

	$__iLineNumber=2085 & ' - $oChild_Temp = Null•./Include/_XML.au3'
	$oChild_Temp = Null
	$__iLineNumber=2086 & ' - Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCC ...•./Include/_XML.au3'
	Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCCESS)
EndFunc   ;==>_XML_CreateChildWAttr

; #FUNCTION# ====================================================================================================================
; Name ..........: _XML_CreateDOMDocument
; Description ...: Create DOMDocument Object
; Syntax ........: _XML_CreateDOMDocument([$iDOM_Version = Default])
; Parameters ....: $iDOM_Version        - [optional] an integer value. Default value is Default.
; Return values .: Success             - DOMDocument Object
;                  Failure             - $XML_RET_FAILURE and sets the @error flag to non-zero (look in #Region XML.au3 - ERROR Enums)
; Modified ......: mLipok
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: yes
; ===============================================================================================================================
$__iLineNumber=2103 & ' - Func _XML_CreateDOMDocument($iDOM_Version = Default)•./Include/_XML.au3'
Func _XML_CreateDOMDocument($iDOM_Version = Default)
	; Local Error handler declaration, it will be automatic CleanUp when returning from function
	$__iLineNumber=2105 & ' - Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XM ...•./Include/_XML.au3'
	Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XML_ComErrorHandler_InternalFunction)
	#forceref $oXML_COM_ErrorHandler

	$__iLineNumber=2108 & ' - If $iDOM_Version = Default Then•./Include/_XML.au3'
	If $iDOM_Version = Default Then
		$__iLineNumber=2109 & ' - For $iDOM_Version_idx = 8 To 0 Step -1•./Include/_XML.au3'
		For $iDOM_Version_idx = 8 To 0 Step -1
			$__iLineNumber=2110 & ' - If FileExists(@SystemDir & "\msxml" & $iDOM_Version_idx & ". ...•./Include/_XML.au3'
			If FileExists(@SystemDir & "\msxml" & $iDOM_Version_idx & ".dll") Then
				$__iLineNumber=2111 & ' - $iDOM_Version = $iDOM_Version_idx•./Include/_XML.au3'
				$iDOM_Version = $iDOM_Version_idx
				ExitLoop
			EndIf
		Next
		; if not found $iDOM_Version (still is Default)
		$__iLineNumber=2116 & ' - If $iDOM_Version = Default Then•./Include/_XML.au3'
		If $iDOM_Version = Default Then
			$__iLineNumber=2117 & ' - Return SetError($XML_ERR_OBJCREATE, $XML_EXT_DOMDOCUMENT, $X ...•./Include/_XML.au3'
			Return SetError($XML_ERR_OBJCREATE, $XML_EXT_DOMDOCUMENT, $XML_RET_FAILURE)
		EndIf
	Else
		$__iLineNumber=2120 & ' - If Not ($iDOM_Version > 0 And $iDOM_Version < 7) Then•./Include/_XML.au3'
		If Not ($iDOM_Version > 0 And $iDOM_Version < 7) Then
			$__iLineNumber=2121 & ' - Return SetError($XML_ERR_PARAMETER, $XML_EXT_DEFAULT, $XML_R ...•./Include/_XML.au3'
			Return SetError($XML_ERR_PARAMETER, $XML_EXT_DEFAULT, $XML_RET_FAILURE)
		EndIf
	EndIf

	$__iLineNumber=2125 & ' - Local $oXmlDoc = ObjCreate("Msxml2.DOMDocument." & $iDOM_Ver ...•./Include/_XML.au3'
	Local $oXmlDoc = ObjCreate("Msxml2.DOMDocument." & $iDOM_Version & ".0")
	$__iLineNumber=2126 & ' - If @error Then•./Include/_XML.au3'
	If @error Then
		$__iLineNumber=2127 & ' - Return SetError($XML_ERR_OBJCREATE, $XML_EXT_DOMDOCUMENT, $X ...•./Include/_XML.au3'
		Return SetError($XML_ERR_OBJCREATE, $XML_EXT_DOMDOCUMENT, $XML_RET_FAILURE)
	Else
		$__iLineNumber=2129 & ' - __XML_MiscProperty_DomVersion($iDOM_Version)•./Include/_XML.au3'
		__XML_MiscProperty_DomVersion($iDOM_Version)
	EndIf

	$__iLineNumber=2132 & ' - __XML_IsValidObject_DOMDocument($oXmlDoc)•./Include/_XML.au3'
	__XML_IsValidObject_DOMDocument($oXmlDoc)
	$__iLineNumber=2133 & ' - If @error Then Return SetError(@error, @extended, $XML_RET_F ...•./Include/_XML.au3'
	If @error Then Return SetError(@error, @extended, $XML_RET_FAILURE)

	$__iLineNumber=2135 & ' - Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $oXmlDoc)•./Include/_XML.au3'
	Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $oXmlDoc)
EndFunc   ;==>_XML_CreateDOMDocument

; #FUNCTION# ===================================================================
; Name ..........: _XML_CreateFile
; Description ...: Create a new blank metafile with header.
; Syntax.........: _XML_CreateFile($sXML_FileFullPath, $sRoot[, $bUTF8 = False[, $iDOM_Version = Default]])
; Parameters ....: $sXML_FileFullPath - The xml filename with full path to create
;                  $sRoot			  - The root of the xml file to create
;                  $bUTF8			  - boolean flag to specify UTF-8 encoding in header.
;                  $iDOM_Version	  - specifically try to use the version supplied here.
; Return values .: On Success		  - Returns $oXmlDoc
;                  On Failure		  - Returns $XML_RET_FAILURE and sets the @error flag to non-zero (look in #Region XML.au3 - ERROR Enums)
; Author ........: Eltorro
; Modified ......: mLipok
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
$__iLineNumber=2155 & ' - Func _XML_CreateFile($sXML_FileFullPath, $sRoot, $bUTF8 = Fa ...•./Include/_XML.au3'
Func _XML_CreateFile($sXML_FileFullPath, $sRoot, $bUTF8 = False, $iDOM_Version = Default)
	; Local Error handler declaration, it will be automatic CleanUp when returning from function
	$__iLineNumber=2157 & ' - Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XM ...•./Include/_XML.au3'
	Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XML_ComErrorHandler_InternalFunction)
	#forceref $oXML_COM_ErrorHandler

	; TODO $bUTF8 = False -- change to $iEncoding = $FO_UTF8_NOBOM
	$__iLineNumber=2161 & ' - If Not (IsString($sXML_FileFullPath) And $sXML_FileFullPath  ...•./Include/_XML.au3'
	If Not (IsString($sXML_FileFullPath) And $sXML_FileFullPath <> "") Then
		$__iLineNumber=2162 & ' - Return SetError($XML_ERR_PARAMETER, $XML_EXT_PARAM1, $XML_RE ...•./Include/_XML.au3'
		Return SetError($XML_ERR_PARAMETER, $XML_EXT_PARAM1, $XML_RET_FAILURE)
	ElseIf FileExists($sXML_FileFullPath) Then
		$__iLineNumber=2164 & ' - Return SetError($XML_ERR_SAVE, $XML_EXT_DEFAULT, $XML_RET_FA ...•./Include/_XML.au3'
		Return SetError($XML_ERR_SAVE, $XML_EXT_DEFAULT, $XML_RET_FAILURE)
	ElseIf Not IsString($sRoot) Then
		$__iLineNumber=2166 & ' - Return SetError($XML_ERR_PARAMETER, $XML_EXT_PARAM2, $XML_RE ...•./Include/_XML.au3'
		Return SetError($XML_ERR_PARAMETER, $XML_EXT_PARAM2, $XML_RET_FAILURE)
	EndIf

	$__iLineNumber=2169 & ' - Local $oXmlDoc = _XML_CreateDOMDocument($iDOM_Version)•./Include/_XML.au3'
	Local $oXmlDoc = _XML_CreateDOMDocument($iDOM_Version)
	$__iLineNumber=2170 & ' - If @error Then Return SetError(@error, @extended, $XML_RET_F ...•./Include/_XML.au3'
	If @error Then Return SetError(@error, @extended, $XML_RET_FAILURE)

	$__iLineNumber=2172 & ' - Local $oProcessingInstruction = $oXmlDoc.createProcessingIns ...•./Include/_XML.au3'
	Local $oProcessingInstruction = $oXmlDoc.createProcessingInstruction("xml", 'version="1.0"' & (($bUTF8) ? ' encoding="UTF-8"' : ''))
	$__iLineNumber=2173 & ' - If @error Then SetError($XML_ERR_COMERROR, @error, $XML_RET_ ...•./Include/_XML.au3'
	If @error Then SetError($XML_ERR_COMERROR, @error, $XML_RET_FAILURE)
	$__iLineNumber=2174 & ' - If $oXmlDoc.parseError.errorCode Then•./Include/_XML.au3'
	If $oXmlDoc.parseError.errorCode Then
		$__iLineNumber=2175 & ' - Return SetError($XML_ERR_PARSE, $oXmlDoc.parseError.errorCod ...•./Include/_XML.au3'
		Return SetError($XML_ERR_PARSE, $oXmlDoc.parseError.errorCode, $XML_RET_FAILURE)
	EndIf

	$__iLineNumber=2178 & ' - $oXmlDoc.appendChild($oProcessingInstruction)•./Include/_XML.au3'
	$oXmlDoc.appendChild($oProcessingInstruction)
	$__iLineNumber=2179 & ' - If @error Then Return SetError($XML_ERR_NODEAPPEND, @error,  ...•./Include/_XML.au3'
	If @error Then Return SetError($XML_ERR_NODEAPPEND, @error, $XML_RET_FAILURE)

	$__iLineNumber=2181 & ' - If $sRoot <> "" Then•./Include/_XML.au3'
	If $sRoot <> '' Then
		$__iLineNumber=2182 & ' - Local $oXML_RootElement = $oXmlDoc.createElement($sRoot)•./Include/_XML.au3'
		Local $oXML_RootElement = $oXmlDoc.createElement($sRoot)
		$__iLineNumber=2183 & ' - $oXmlDoc.documentElement = $oXML_RootElement•./Include/_XML.au3'
		$oXmlDoc.documentElement = $oXML_RootElement
	EndIf

	$__iLineNumber=2186 & ' - _XML_SaveToFile($oXmlDoc, $sXML_FileFullPath)•./Include/_XML.au3'
	_XML_SaveToFile($oXmlDoc, $sXML_FileFullPath)
	$__iLineNumber=2187 & ' - If @error Then Return SetError(@error, @extended, $XML_RET_F ...•./Include/_XML.au3'
	If @error Then Return SetError(@error, @extended, $XML_RET_FAILURE)

	$__iLineNumber=2189 & ' - If $oXmlDoc.parseError.errorCode Then•./Include/_XML.au3'
	If $oXmlDoc.parseError.errorCode Then
		$__iLineNumber=2190 & ' - Return SetError($XML_ERR_PARSE, $oXmlDoc.parseError.errorCod ...•./Include/_XML.au3'
		Return SetError($XML_ERR_PARSE, $oXmlDoc.parseError.errorCode, $XML_RET_FAILURE)
	EndIf
	$__iLineNumber=2192 & ' - Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $oXmlDoc)•./Include/_XML.au3'
	Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $oXmlDoc)

EndFunc   ;==>_XML_CreateFile

; #FUNCTION# ====================================================================================================================
; Name ..........: _XML_GetAllAttribIndex
; Description ...: Get XML attributes collection from node element based on Xpath and specific index.
; Syntax ........: _XML_GetAllAttribIndex(ByRef $oXmlDoc, $sXPath[, $iNodeIndex = 0])
; Parameters ....: $oXmlDoc 			- [in/out] an object. A valid DOMDocument or IXMLDOMElement object.
;                  $sXPath              - a string value. The XML tree path from root node (root/child/child..)
;                  $iNodeIndex          - [optional] an integer value. Default is 0. Specify which node in collection should be used.
; Return values .: Success        		- Attributes collection of object,
;                  Failure             	- $XML_RET_FAILURE and sets the @error flag to non-zero (look in #Region XML.au3 - ERROR Enums)
; Author ........: Eltorro
; Modified ......: mLipok
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: yes
; ===============================================================================================================================
$__iLineNumber=2212 & ' - Func _XML_GetAllAttribIndex(ByRef $oXmlDoc, $sXPath, $iNodeI ...•./Include/_XML.au3'
Func _XML_GetAllAttribIndex(ByRef $oXmlDoc, $sXPath, $iNodeIndex = 0)
	; Local Error handler declaration, it will be automatic CleanUp when returning from function
	$__iLineNumber=2214 & ' - Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XM ...•./Include/_XML.au3'
	Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XML_ComErrorHandler_InternalFunction)
	#forceref $oXML_COM_ErrorHandler

	$__iLineNumber=2217 & ' - Local $oNodesColl = _XML_SelectNodes($oXmlDoc, $sXPath)•./Include/_XML.au3'
	Local $oNodesColl = _XML_SelectNodes($oXmlDoc, $sXPath)
	$__iLineNumber=2218 & ' - If @error Then Return SetError(@error, @extended, $XML_RET_F ...•./Include/_XML.au3'
	If @error Then Return SetError(@error, @extended, $XML_RET_FAILURE)

	$__iLineNumber=2220 & ' - Local $oAttributesColl = $oNodesColl.item($iNodeIndex).attri ...•./Include/_XML.au3'
	Local $oAttributesColl = $oNodesColl.item($iNodeIndex).attributes
	$__iLineNumber=2221 & ' - If @error Then•./Include/_XML.au3'
	If @error Then
		$__iLineNumber=2222 & ' - Return SetError($XML_ERR_COMERROR, $XML_EXT_DEFAULT, $XML_RE ...•./Include/_XML.au3'
		Return SetError($XML_ERR_COMERROR, $XML_EXT_DEFAULT, $XML_RET_FAILURE)
	ElseIf IsObj($oAttributesColl) Then
		$__iLineNumber=2224 & ' - Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $oAttributesC ...•./Include/_XML.au3'
		Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $oAttributesColl)
	ElseIf $oAttributesColl = Null Then
		$__iLineNumber=2226 & ' - Return SetError($XML_ERR_NOATTRMATCH, $XML_EXT_DEFAULT, $XML ...•./Include/_XML.au3'
		Return SetError($XML_ERR_NOATTRMATCH, $XML_EXT_DEFAULT, $XML_RET_FAILURE)
	ElseIf $oAttributesColl.length = 0 Then
		$__iLineNumber=2228 & ' - Return SetError($XML_ERR_EMPTYCOLLECTION, $XML_EXT_DEFAULT,  ...•./Include/_XML.au3'
		Return SetError($XML_ERR_EMPTYCOLLECTION, $XML_EXT_DEFAULT, $XML_RET_FAILURE)
	EndIf
	$__iLineNumber=2230 & ' - Return SetError($XML_ERR_GENERAL, $XML_EXT_DEFAULT, $XML_RET ...•./Include/_XML.au3'
	Return SetError($XML_ERR_GENERAL, $XML_EXT_DEFAULT, $XML_RET_FAILURE)

EndFunc   ;==>_XML_GetAllAttribIndex

; #FUNCTION# ====================================================================================================================
; Name ..........: _XML_GetChildNodes
; Description ...: Get XML child Node collection of node element based on XPath input from root node.
; Syntax ........: _XML_GetChildNodes(ByRef $oXmlDoc, $sXPath)
; Parameters ....: $oXmlDoc 			- [in/out] an object. A valid DOMDocument or IXMLDOMElement object.
;                  $sXPath              - a string value. The XML tree path from root node (root/child/child..)
; Return values .: Success        		- Child Nodes collection, and @extended contains collection length (count)
;                  Failure             	- $XML_RET_FAILURE and sets the @error flag to non-zero (look in #Region XML.au3 - ERROR Enums)
; Author ........: Eltorro
; Modified ......: mLipok
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: yes
; ===============================================================================================================================
$__iLineNumber=2249 & ' - Func _XML_GetChildNodes(ByRef $oXmlDoc, $sXPath)•./Include/_XML.au3'
Func _XML_GetChildNodes(ByRef $oXmlDoc, $sXPath)
	; Local Error handler declaration, it will be automatic CleanUp when returning from function
	$__iLineNumber=2251 & ' - Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XM ...•./Include/_XML.au3'
	Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XML_ComErrorHandler_InternalFunction)
	#forceref $oXML_COM_ErrorHandler

	$__iLineNumber=2254 & ' - Local $oNode_Selected = _XML_SelectSingleNode($oXmlDoc, $sXP ...•./Include/_XML.au3'
	Local $oNode_Selected = _XML_SelectSingleNode($oXmlDoc, $sXPath)
	$__iLineNumber=2255 & ' - If @error Then•./Include/_XML.au3'
	If @error Then
		$__iLineNumber=2256 & ' - Return SetError(@error, @extended, $XML_RET_FAILURE)•./Include/_XML.au3'
		Return SetError(@error, @extended, $XML_RET_FAILURE)
	ElseIf $oNode_Selected.hasChildNodes() Then
		$__iLineNumber=2258 & ' - Return SetError($XML_ERR_OK, $oNode_Selected.childNodes().le ...•./Include/_XML.au3'
		Return SetError($XML_ERR_OK, $oNode_Selected.childNodes().length, $oNode_Selected.childNodes())
	Else
		$__iLineNumber=2260 & ' - Return SetError($XML_ERR_NOCHILDMATCH, $XML_EXT_DEFAULT, $XM ...•./Include/_XML.au3'
		Return SetError($XML_ERR_NOCHILDMATCH, $XML_EXT_DEFAULT, $XML_RET_FAILURE)
	EndIf

	; TODO Is it used ?
	$__iLineNumber=2264 & ' - Return SetError($XML_ERR_GENERAL, $XML_EXT_DEFAULT, $XML_RET ...•./Include/_XML.au3'
	Return SetError($XML_ERR_GENERAL, $XML_EXT_DEFAULT, $XML_RET_FAILURE)

EndFunc   ;==>_XML_GetChildNodes

; #FUNCTION# ====================================================================================================================
; Name ..........: _XML_GetNodeAttributeValue
; Description ...: Get attribute value of selected node
; Syntax ........: _XML_GetNodeAttributeValue(ByRef $oNode_Selected, $sAttribute_Name)
; Parameters ....: $oNode_Selected  - [in/out] A valid node object.
;                  $sAttribute_Name - A string value. Attribute name.
; Return values .: On Success       - Returns string value of selected node
;                  On Failure       - Returns $XML_RET_FAILURE and sets the @error flag to non-zero (look in #Region XML.au3 - ERROR Enums)
; Author ........: mLipok
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
$__iLineNumber=2283 & ' - Func _XML_GetNodeAttributeValue(ByRef $oNode_Selected, $sAtt ...•./Include/_XML.au3'
Func _XML_GetNodeAttributeValue(ByRef $oNode_Selected, $sAttribute_Name)
	; Local Error handler declaration, it will be automatic CleanUp when returning from function
	$__iLineNumber=2285 & ' - Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XM ...•./Include/_XML.au3'
	Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XML_ComErrorHandler_InternalFunction)
	#forceref $oXML_COM_ErrorHandler

	$__iLineNumber=2288 & ' - __XML_IsValidObject_Node($oNode_Selected) ; TODO: , $XML_NOD ...•./Include/_XML.au3'
	__XML_IsValidObject_Node($oNode_Selected) ; TODO: , $XML_NODE_ELEMENT)  ??
	$__iLineNumber=2289 & ' - If @error Then Return SetError(@error, @extended, $XML_RET_F ...•./Include/_XML.au3'
	If @error Then Return SetError(@error, @extended, $XML_RET_FAILURE)

	$__iLineNumber=2291 & ' - If Not IsString($sAttribute_Name) Or $sAttribute_Name = "" T ...•./Include/_XML.au3'
	If Not IsString($sAttribute_Name) Or $sAttribute_Name = '' Then
		$__iLineNumber=2292 & ' - Return SetError($XML_ERR_PARAMETER, $XML_EXT_DEFAULT, $XML_R ...•./Include/_XML.au3'
		Return SetError($XML_ERR_PARAMETER, $XML_EXT_DEFAULT, $XML_RET_FAILURE)
	EndIf

	$__iLineNumber=2295 & ' - Local $sAttribute_Value = $oNode_Selected.getAttribute($sAtt ...•./Include/_XML.au3'
	Local $sAttribute_Value = $oNode_Selected.getAttribute($sAttribute_Name)
	$__iLineNumber=2296 & ' - If IsString($sAttribute_Value) Then•./Include/_XML.au3'
	If IsString($sAttribute_Value) Then
		$__iLineNumber=2297 & ' - Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $sAttribute_V ...•./Include/_XML.au3'
		Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $sAttribute_Value)
	ElseIf $sAttribute_Value = Null Then
		$__iLineNumber=2299 & ' - Return SetError($XML_ERR_NOATTRMATCH, $XML_EXT_DEFAULT, $XML ...•./Include/_XML.au3'
		Return SetError($XML_ERR_NOATTRMATCH, $XML_EXT_DEFAULT, $XML_RET_FAILURE)
	EndIf
	$__iLineNumber=2301 & ' - Return SetError($XML_ERR_GENERAL, $XML_EXT_DEFAULT, $XML_RET ...•./Include/_XML.au3'
	Return SetError($XML_ERR_GENERAL, $XML_EXT_DEFAULT, $XML_RET_FAILURE)

EndFunc   ;==>_XML_GetNodeAttributeValue

; #FUNCTION# ====================================================================================================================
; Name ..........: _XML_Load
; Description ...: Load XML file to the existing object or declared empty variable.
; Syntax ........: _XML_Load(ByRef $oXmlDoc, $sXML_FileFullPath[, $sNameSpace = ""[, $bValidateOnParse = True]])
; Parameters ....: $oXmlDoc 			- [in/out] an object. A valid DOMDocument object.
;                  $sXML_FileFullPath   - a string value. The XML file to open
;                  $sNameSpace          - [optional] a string value. Default is "". The namespace to specifiy if the file uses one.
;                  $bValidateOnParse    - [optional] a boolean value. Default is True. Validate the document as it is being parsed
; Return values .: Success        		- $oXmlDoc
;                  Failure             	- $XML_RET_FAILURE and sets the @error flag to non-zero (look in #Region XML.au3 - ERROR Enums)
; Author ........: Eltorro
; Modified ......: Tom Hohmann, mLipok
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......; [yes/no]
; ===============================================================================================================================
$__iLineNumber=2323 & ' - Func _XML_Load(ByRef $oXmlDoc, $sXML_FileFullPath, $sNameSpa ...•./Include/_XML.au3'
Func _XML_Load(ByRef $oXmlDoc, $sXML_FileFullPath, $sNameSpace = "", $bValidateOnParse = True)
	; Local Error handler declaration, it will be automatic CleanUp when returning from function
	$__iLineNumber=2325 & ' - Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XM ...•./Include/_XML.au3'
	Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XML_ComErrorHandler_InternalFunction)
	#forceref $oXML_COM_ErrorHandler

	$__iLineNumber=2328 & ' - __XML_IsValidObject_DOMDocument($oXmlDoc)•./Include/_XML.au3'
	__XML_IsValidObject_DOMDocument($oXmlDoc)
	$__iLineNumber=2329 & ' - If @error Then Return SetError(@error, @extended, $XML_RET_F ...•./Include/_XML.au3'
	If @error Then Return SetError(@error, @extended, $XML_RET_FAILURE)

	$__iLineNumber=2331 & ' - If Not FileExists($sXML_FileFullPath) Then Return SetError($ ...•./Include/_XML.au3'
	If Not FileExists($sXML_FileFullPath) Then Return SetError($XML_ERR_LOAD, $XML_EXT_DEFAULT, $XML_RET_FAILURE)

	$__iLineNumber=2333 & ' - If _XML_Misc_GetDomVersion() > 4 Then $oXmlDoc.setProperty(" ...•./Include/_XML.au3'
	If _XML_Misc_GetDomVersion() > 4 Then $oXmlDoc.setProperty("ProhibitDTD", False)
	$__iLineNumber=2334 & ' - $oXmlDoc.async = False•./Include/_XML.au3'
	$oXmlDoc.async = False
	$__iLineNumber=2335 & ' - $oXmlDoc.preserveWhiteSpace = True•./Include/_XML.au3'
	$oXmlDoc.preserveWhiteSpace = True
	$__iLineNumber=2336 & ' - $oXmlDoc.validateOnParse = $bValidateOnParse•./Include/_XML.au3'
	$oXmlDoc.validateOnParse = $bValidateOnParse
	$__iLineNumber=2337 & ' - $oXmlDoc.Load($sXML_FileFullPath)•./Include/_XML.au3'
	$oXmlDoc.Load($sXML_FileFullPath)
	$__iLineNumber=2338 & ' - If $oXmlDoc.parseError.errorCode Then•./Include/_XML.au3'
	If $oXmlDoc.parseError.errorCode Then
		$__iLineNumber=2339 & ' - Return SetError($XML_ERR_PARSE, $oXmlDoc.parseError.errorCod ...•./Include/_XML.au3'
		Return SetError($XML_ERR_PARSE, $oXmlDoc.parseError.errorCode, $XML_RET_FAILURE)
	EndIf

	; SelectionLanguage do not use this as this cause a problem
	; $oXmlDoc.setProperty("SelectionLanguage", "XPath")

	$__iLineNumber=2345 & ' - $oXmlDoc.setProperty("SelectionNamespaces", $sNameSpace)•./Include/_XML.au3'
	$oXmlDoc.setProperty("SelectionNamespaces", $sNameSpace)

	$__iLineNumber=2347 & ' - Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $oXmlDoc)•./Include/_XML.au3'
	Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $oXmlDoc)

EndFunc   ;==>_XML_Load

; #FUNCTION# ====================================================================================================================
; Name ..........: _XML_LoadXML
; Description ...: Load XML String to the DOMDocument object.
; Syntax ........: _XML_LoadXML(ByRef $oXmlDoc, $sXML_Content[, $sNameSpace = ""[, $bValidateOnParse = True]])
; Parameters ....: $oXmlDoc 			- [in/out] an object. A valid DOMDocument object.
;                  $sXML_Content        - a string value. The XML string to load into the document
;                  $sNameSpace          - [optional] a string value. Default is "". The namespace to specifiy if the file uses one.
;                  $bValidateOnParse    - [optional] a boolean value. Default is True. Set the MSXML ValidateOnParse property
; Return values .: Success				- $oXmlDoc
;                  Failure				- $XML_RET_FAILURE and sets the @error flag to non-zero (look in #Region XML.au3 - ERROR Enums)
; Author ........: Eltorro, Lukasz Suleja, Tom Hohmann
; Modified ......: mLipok
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ===============================================================================================================================
$__iLineNumber=2368 & ' - Func _XML_LoadXML(ByRef $oXmlDoc, $sXML_Content, $sNameSpace ...•./Include/_XML.au3'
Func _XML_LoadXML(ByRef $oXmlDoc, $sXML_Content, $sNameSpace = "", $bValidateOnParse = True)
	; Local Error handler declaration, it will be automatic CleanUp when returning from function
	$__iLineNumber=2370 & ' - Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XM ...•./Include/_XML.au3'
	Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XML_ComErrorHandler_InternalFunction)
	#forceref $oXML_COM_ErrorHandler

	$__iLineNumber=2373 & ' - __XML_IsValidObject_DOMDocument($oXmlDoc)•./Include/_XML.au3'
	__XML_IsValidObject_DOMDocument($oXmlDoc)
	$__iLineNumber=2374 & ' - If @error Then Return SetError(@error, @extended, $XML_RET_F ...•./Include/_XML.au3'
	If @error Then Return SetError(@error, @extended, $XML_RET_FAILURE)

	$__iLineNumber=2376 & ' - If _XML_Misc_GetDomVersion() > 4 Then $oXmlDoc.setProperty(" ...•./Include/_XML.au3'
	If _XML_Misc_GetDomVersion() > 4 Then $oXmlDoc.setProperty("ProhibitDTD", False)
	$__iLineNumber=2377 & ' - $oXmlDoc.async = False•./Include/_XML.au3'
	$oXmlDoc.async = False
	$__iLineNumber=2378 & ' - $oXmlDoc.preserveWhiteSpace = True•./Include/_XML.au3'
	$oXmlDoc.preserveWhiteSpace = True
	$__iLineNumber=2379 & ' - $oXmlDoc.validateOnParse = $bValidateOnParse•./Include/_XML.au3'
	$oXmlDoc.validateOnParse = $bValidateOnParse
	$__iLineNumber=2380 & ' - $oXmlDoc.LoadXml($sXML_Content)•./Include/_XML.au3'
	$oXmlDoc.LoadXml($sXML_Content)
	$__iLineNumber=2381 & ' - If $oXmlDoc.parseError.errorCode Then•./Include/_XML.au3'
	If $oXmlDoc.parseError.errorCode Then
		$__iLineNumber=2382 & ' - Return SetError($XML_ERR_PARSE, $oXmlDoc.parseError.errorCod ...•./Include/_XML.au3'
		Return SetError($XML_ERR_PARSE, $oXmlDoc.parseError.errorCode, $XML_RET_FAILURE)
	EndIf

	; SelectionLanguage do not use this as this cause a problem
	; $oXmlDoc.setProperty("SelectionLanguage", "XPath")

	$__iLineNumber=2388 & ' - $oXmlDoc.setProperty("SelectionNamespaces", $sNameSpace)•./Include/_XML.au3'
	$oXmlDoc.setProperty("SelectionNamespaces", $sNameSpace)
	; TODO this following line was here, actualy I (mLipok) wondering why.
	; "xmlns:ms='urn:schemas-microsoft-com:xslt'"
	; here I put some reference to look in
	; https://msdn.microsoft.com/en-us/library/ms256186(v=vs.110).aspx

	$__iLineNumber=2394 & ' - Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $oXmlDoc)•./Include/_XML.au3'
	Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $oXmlDoc)

EndFunc   ;==>_XML_LoadXML

; #FUNCTION# ====================================================================================================================
; Name ..........: _XML_NodeExists
; Description ...: Checks for the existence of a node matching the specified path
; Syntax ........: _XML_NodeExists(ByRef $oXmlDoc, $sXPath)
; Parameters ....: $oXmlDoc 		- [in/out] an object. A valid DOMDocument or IXMLDOMElement object.
;                  $sXPath          - a string value. The XML tree path from root node (root/child/child..)
; Return values .: Success        	- $XML_RET_SUCCESS
;                  Failure			- $XML_RET_FAILURE and sets the @error flag to non-zero (look in #Region XML.au3 - ERROR Enums)
; Author ........: Eltorro
; Modified ......: mLipok
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......; [yes/no]
; ===============================================================================================================================
$__iLineNumber=2414 & ' - Func _XML_NodeExists(ByRef $oXmlDoc, $sXPath)•./Include/_XML.au3'
Func _XML_NodeExists(ByRef $oXmlDoc, $sXPath)
	; Local Error handler declaration, it will be automatic CleanUp when returning from function
	$__iLineNumber=2416 & ' - Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XM ...•./Include/_XML.au3'
	Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XML_ComErrorHandler_InternalFunction)
	#forceref $oXML_COM_ErrorHandler

	$__iLineNumber=2419 & ' - Local $oNode_Selected = _XML_SelectSingleNode($oXmlDoc, $sXP ...•./Include/_XML.au3'
	Local $oNode_Selected = _XML_SelectSingleNode($oXmlDoc, $sXPath)
	$__iLineNumber=2420 & ' - If @error Then•./Include/_XML.au3'
	If @error Then
		$__iLineNumber=2421 & ' - Return SetError(@error, @extended, $XML_RET_FAILURE)•./Include/_XML.au3'
		Return SetError(@error, @extended, $XML_RET_FAILURE)
	EndIf
	$__iLineNumber=2423 & ' - Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCC ...•./Include/_XML.au3'
	Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCCESS)

	#forceref $oNode_Selected

EndFunc   ;==>_XML_NodeExists

; #FUNCTION# ====================================================================================================================
; Name ..........: _XML_SaveToFile
; Description ...: Save the current $oXmlDoc content to XML file
; Syntax ........: _XML_SaveToFile(ByRef $oXmlDoc, $sXML_FileFullPath)
; Parameters ....: $oXmlDoc 			- [in/out] an object. A valid DOMDocument object.
;                  $sXML_FileFullPath   - a string value. The filename to save the $oXmlDoc content.
; Return values .: Success             - $XML_RET_SUCCESS
;                  Failure             - $XML_RET_FAILURE and sets the @error flag to non-zero (look in #Region XML.au3 - ERROR Enums)
; Author ........: Eltorro
; Modified ......: mLipok
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......; [yes/no]
; ===============================================================================================================================
$__iLineNumber=2444 & ' - Func _XML_SaveToFile(ByRef $oXmlDoc, $sXML_FileFullPath)•./Include/_XML.au3'
Func _XML_SaveToFile(ByRef $oXmlDoc, $sXML_FileFullPath)
	; Local Error handler declaration, it will be automatic CleanUp when returning from function
	$__iLineNumber=2446 & ' - Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XM ...•./Include/_XML.au3'
	Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XML_ComErrorHandler_InternalFunction)
	#forceref $oXML_COM_ErrorHandler

	$__iLineNumber=2449 & ' - __XML_IsValidObject_DOMDocument($oXmlDoc)•./Include/_XML.au3'
	__XML_IsValidObject_DOMDocument($oXmlDoc)
	$__iLineNumber=2450 & ' - If @error Then Return SetError(@error, @extended, $XML_RET_F ...•./Include/_XML.au3'
	If @error Then Return SetError(@error, @extended, $XML_RET_FAILURE)

	$__iLineNumber=2452 & ' - If Not (IsString($sXML_FileFullPath) And $sXML_FileFullPath  ...•./Include/_XML.au3'
	If Not (IsString($sXML_FileFullPath) And $sXML_FileFullPath <> '') Then
		$__iLineNumber=2453 & ' - Return SetError($XML_ERR_PARAMETER, $XML_EXT_PARAM2, $XML_RE ...•./Include/_XML.au3'
		Return SetError($XML_ERR_PARAMETER, $XML_EXT_PARAM2, $XML_RET_FAILURE)
	ElseIf FileExists($sXML_FileFullPath) Then
		$__iLineNumber=2455 & ' - Return SetError($XML_ERR_SAVE, $XML_EXT_DEFAULT, $XML_RET_FA ...•./Include/_XML.au3'
		Return SetError($XML_ERR_SAVE, $XML_EXT_DEFAULT, $XML_RET_FAILURE)
	EndIf

	$__iLineNumber=2458 & ' - $oXmlDoc.save($sXML_FileFullPath)•./Include/_XML.au3'
	$oXmlDoc.save($sXML_FileFullPath)
	$__iLineNumber=2459 & ' - If $oXmlDoc.parseError.errorCode Then•./Include/_XML.au3'
	If $oXmlDoc.parseError.errorCode Then
		$__iLineNumber=2460 & ' - Return SetError($XML_ERR_PARSE, $oXmlDoc.parseError.errorCod ...•./Include/_XML.au3'
		Return SetError($XML_ERR_PARSE, $oXmlDoc.parseError.errorCode, $XML_RET_FAILURE)
	EndIf
	$__iLineNumber=2462 & ' - Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCC ...•./Include/_XML.au3'
	Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCCESS)

EndFunc   ;==>_XML_SaveToFile

; #FUNCTION# ====================================================================================================================
; Name ..........: _XML_SelectNodes
; Description ...: Selects XML Node(s) based on XPath input from root node.
; Syntax ........: _XML_SelectNodes(ByRef $oXmlDoc, $sXPath)
; Parameters ....: $oXmlDoc 			- [in/out] an object. A valid DOMDocument or IXMLDOMElement object.
;                  $sXPath              - a string value. The XML tree path from root node (root/child/child..)
; Return values .: Success        		- $oNodesColl - Nodes collection, and set @extended = $oNodesColl.length
;                  Failure             	- $XML_RET_FAILURE and sets the @error flag to non-zero (look in #Region XML.au3 - ERROR Enums)
; Author ........: Eltorro
; Modified ......: mLipok
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......; [yes/no]
; ===============================================================================================================================
$__iLineNumber=2481 & ' - Func _XML_SelectNodes(ByRef $oXmlDoc, $sXPath)•./Include/_XML.au3'
Func _XML_SelectNodes(ByRef $oXmlDoc, $sXPath)
	; Local Error handler declaration, it will be automatic CleanUp when returning from function
	$__iLineNumber=2483 & ' - Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XM ...•./Include/_XML.au3'
	Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XML_ComErrorHandler_InternalFunction)
	#forceref $oXML_COM_ErrorHandler

	$__iLineNumber=2486 & ' - __XML_IsValidObject_DOMDocumentOrElement($oXmlDoc)•./Include/_XML.au3'
	__XML_IsValidObject_DOMDocumentOrElement($oXmlDoc)
	$__iLineNumber=2487 & ' - If @error Then Return SetError(@error, @extended, $XML_RET_F ...•./Include/_XML.au3'
	If @error Then Return SetError(@error, @extended, $XML_RET_FAILURE)

	$__iLineNumber=2489 & ' - Local $oNodesColl = $oXmlDoc.selectNodes($sXPath)•./Include/_XML.au3'
	Local $oNodesColl = $oXmlDoc.selectNodes($sXPath)
	$__iLineNumber=2490 & ' - If @error Then•./Include/_XML.au3'
	If @error Then
		$__iLineNumber=2491 & ' - Return SetError($XML_ERR_XPATH, $XML_EXT_DEFAULT, $XML_RET_F ...•./Include/_XML.au3'
		Return SetError($XML_ERR_XPATH, $XML_EXT_DEFAULT, $XML_RET_FAILURE)
	ElseIf (Not IsObj($oNodesColl)) Or $oNodesColl.length = 0 Then
		$__iLineNumber=2493 & ' - Return SetError($XML_ERR_EMPTYCOLLECTION, $XML_EXT_DEFAULT,  ...•./Include/_XML.au3'
		Return SetError($XML_ERR_EMPTYCOLLECTION, $XML_EXT_DEFAULT, $XML_RET_FAILURE)
	EndIf
	$__iLineNumber=2495 & ' - Return SetError($XML_ERR_OK, $oNodesColl.length, $oNodesColl ...•./Include/_XML.au3'
	Return SetError($XML_ERR_OK, $oNodesColl.length, $oNodesColl)

EndFunc   ;==>_XML_SelectNodes

; #FUNCTION# ====================================================================================================================
; Name ..........: _XML_SelectSingleNode
; Description ...: Select single XML Node based on XPath input from root node.
; Syntax ........: _XML_SelectSingleNode(ByRef $oXmlDoc, $sXPath)
; Parameters ....: $oXmlDoc 			- [in/out] an object. A valid DOMDocument or IXMLDOMElement object.
;                  $sXPath              - a string value. The XML tree path from root node (root/child/child..)
; Return values .: Success        		- $oNode_Selected - single node
;                  Failure              - $XML_RET_FAILURE and sets the @error flag to non-zero (look in #Region XML.au3 - ERROR Enums)
; Author ........: Eltorro
; Modified ......: mLipok
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......; [yes/no]
; ===============================================================================================================================
$__iLineNumber=2514 & ' - Func _XML_SelectSingleNode(ByRef $oXmlDoc, $sXPath)•./Include/_XML.au3'
Func _XML_SelectSingleNode(ByRef $oXmlDoc, $sXPath)
	; Local Error handler declaration, it will be automatic CleanUp when returning from function
	$__iLineNumber=2516 & ' - Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XM ...•./Include/_XML.au3'
	Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XML_ComErrorHandler_InternalFunction)
	#forceref $oXML_COM_ErrorHandler

	$__iLineNumber=2519 & ' - __XML_IsValidObject_DOMDocumentOrElement($oXmlDoc)•./Include/_XML.au3'
	__XML_IsValidObject_DOMDocumentOrElement($oXmlDoc)
	$__iLineNumber=2520 & ' - If @error Then Return SetError(@error, @extended, $XML_RET_F ...•./Include/_XML.au3'
	If @error Then Return SetError(@error, @extended, $XML_RET_FAILURE)

	$__iLineNumber=2522 & ' - Local $oNode_Selected = $oXmlDoc.selectSingleNode($sXPath)•./Include/_XML.au3'
	Local $oNode_Selected = $oXmlDoc.selectSingleNode($sXPath)
	$__iLineNumber=2523 & ' - If @error Then•./Include/_XML.au3'
	If @error Then
		$__iLineNumber=2524 & ' - Return SetError($XML_ERR_XPATH, $XML_EXT_DEFAULT, $XML_RET_F ...•./Include/_XML.au3'
		Return SetError($XML_ERR_XPATH, $XML_EXT_DEFAULT, $XML_RET_FAILURE)
	ElseIf $oNode_Selected = Null Then
		$__iLineNumber=2526 & ' - Return SetError($XML_ERR_NONODESMATCH, $XML_EXT_DEFAULT, $XM ...•./Include/_XML.au3'
		Return SetError($XML_ERR_NONODESMATCH, $XML_EXT_DEFAULT, $XML_RET_FAILURE)
	ElseIf Not IsObj($oNode_Selected) Then ; https://www.autoitscript.com/forum/topic/177176-why-isobj-0-and-vargettype-object/
		; $XML_ERR_EMPTYOBJECT
		$__iLineNumber=2529 & ' - Return SetError($XML_ERR_NONODESMATCH, $XML_EXT_DEFAULT, $XM ...•./Include/_XML.au3'
		Return SetError($XML_ERR_NONODESMATCH, $XML_EXT_DEFAULT, $XML_RET_FAILURE)
	EndIf
	$__iLineNumber=2531 & ' - Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $oNode_Select ...•./Include/_XML.au3'
	Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $oNode_Selected)
EndFunc   ;==>_XML_SelectSingleNode

; #FUNCTION# ====================================================================================================================
; Name ..........: _XML_Tidy
; Description ...: Tidy XML structure
; Syntax ........: _XML_Tidy(ByRef $oXmlDoc[, $sEncoding = Default])
; Parameters ....: $oXmlDoc 			- [in/out] an object. A valid DOMDocument object.
;                  $sEncoding           - [optional] a string value. Default value is -1 (omitXMLDeclaration) .
; Return values .: Success				- XML with indent
;                  Failure				- $XML_RET_FAILURE and sets the @error flag to non-zero (look in #Region XML.au3 - ERROR Enums)
; Author ........: mLipok
; Modified ......:
; Remarks .......: set $sEncoding = Default if you want to use default UDF encoding
; Related .......: _XML_MiscProperty_Encoding
; Link ..........:
; Example .......: No
; ===============================================================================================================================
$__iLineNumber=2549 & ' - Func _XML_Tidy(ByRef $oXmlDoc, $sEncoding = -1)•./Include/_XML.au3'
Func _XML_Tidy(ByRef $oXmlDoc, $sEncoding = -1)
	; Local Error handler declaration, it will be automatic CleanUp when returning from function
	$__iLineNumber=2551 & ' - Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XM ...•./Include/_XML.au3'
	Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XML_ComErrorHandler_InternalFunction)
	#forceref $oXML_COM_ErrorHandler

	$__iLineNumber=2554 & ' - __XML_IsValidObject_DOMDocument($oXmlDoc)•./Include/_XML.au3'
	__XML_IsValidObject_DOMDocument($oXmlDoc)
	$__iLineNumber=2555 & ' - If @error Then Return SetError(@error, @extended, $XML_RET_F ...•./Include/_XML.au3'
	If @error Then Return SetError(@error, @extended, $XML_RET_FAILURE)

	$__iLineNumber=2557 & ' - If $sEncoding = Default Then $sEncoding = _XML_MiscProperty_ ...•./Include/_XML.au3'
	If $sEncoding = Default Then $sEncoding = _XML_MiscProperty_Encoding()
	$__iLineNumber=2558 & ' - If @error Then Return SetError(@error, @extended, $XML_RET_F ...•./Include/_XML.au3'
	If @error Then Return SetError(@error, @extended, $XML_RET_FAILURE)

	$__iLineNumber=2560 & ' - Local $oReader = ObjCreate("MSXML2.SAXXMLReader")•./Include/_XML.au3'
	Local $oReader = ObjCreate("MSXML2.SAXXMLReader")
	$__iLineNumber=2561 & ' - If @error Then Return SetError($XML_ERR_OBJCREATE, $XML_EXT_ ...•./Include/_XML.au3'
	If @error Then Return SetError($XML_ERR_OBJCREATE, $XML_EXT_SAXXMLREADER, $XML_RET_FAILURE)

	$__iLineNumber=2563 & ' - Local $oWriter = ObjCreate("MSXML2.MXXMLWriter")•./Include/_XML.au3'
	Local $oWriter = ObjCreate("MSXML2.MXXMLWriter")
	$__iLineNumber=2564 & ' - If @error Then Return SetError($XML_ERR_OBJCREATE, $XML_EXT_ ...•./Include/_XML.au3'
	If @error Then Return SetError($XML_ERR_OBJCREATE, $XML_EXT_MXXMLWRITER, $XML_RET_FAILURE)

	$__iLineNumber=2566 & ' - Local $oStream = ObjCreate("ADODB.STREAM")•./Include/_XML.au3'
	Local $oStream = ObjCreate("ADODB.STREAM")
	$__iLineNumber=2567 & ' - If @error Then Return SetError($XML_ERR_OBJCREATE, $XML_EXT_ ...•./Include/_XML.au3'
	If @error Then Return SetError($XML_ERR_OBJCREATE, $XML_EXT_STREAM, $XML_RET_FAILURE)

	$__iLineNumber=2569 & ' - Local $sXML_Return = ""•./Include/_XML.au3'
	Local $sXML_Return = ''

	$__iLineNumber=2571 & ' - With $oStream•./Include/_XML.au3'
	With $oStream
		$__iLineNumber=2572 & ' - .Open•./Include/_XML.au3'
		.Open
		$__iLineNumber=2573 & ' - If $sEncoding <> -1 Then .Charset = $sEncoding•./Include/_XML.au3'
		If $sEncoding <> -1 Then .Charset = $sEncoding
		$__iLineNumber=2574 & ' - If @error Then Return SetError($XML_ERR_PARAMETER, $XML_EXT_ ...•./Include/_XML.au3'
		If @error Then Return SetError($XML_ERR_PARAMETER, $XML_EXT_ENCODING, $XML_RET_FAILURE)

		$__iLineNumber=2576 & ' - With $oWriter•./Include/_XML.au3'
		With $oWriter
			$__iLineNumber=2577 & ' - .indent = True•./Include/_XML.au3'
			.indent = True
			$__iLineNumber=2578 & ' - If $sEncoding = -1 Then•./Include/_XML.au3'
			If $sEncoding = -1 Then
				$__iLineNumber=2579 & ' - .omitXMLDeclaration = True•./Include/_XML.au3'
				.omitXMLDeclaration = True
			Else
				$__iLineNumber=2581 & ' - .encoding = $sEncoding•./Include/_XML.au3'
				.encoding = $sEncoding
			EndIf
			$__iLineNumber=2583 & ' - If @error Then Return SetError($XML_ERR_PARAMETER, $XML_EXT_ ...•./Include/_XML.au3'
			If @error Then Return SetError($XML_ERR_PARAMETER, $XML_EXT_ENCODING, $XML_RET_FAILURE)
			$__iLineNumber=2584 & ' - .output = $oStream•./Include/_XML.au3'
			.output = $oStream
		EndWith

		$__iLineNumber=2587 & ' - With $oReader•./Include/_XML.au3'
		With $oReader
			$__iLineNumber=2588 & ' - .contentHandler = $oWriter•./Include/_XML.au3'
			.contentHandler = $oWriter
			$__iLineNumber=2589 & ' - .errorHandler = $oWriter•./Include/_XML.au3'
			.errorHandler = $oWriter
			$__iLineNumber=2590 & ' - .Parse($oXmlDoc)•./Include/_XML.au3'
			.Parse($oXmlDoc)
			$__iLineNumber=2591 & ' - If @error Then•./Include/_XML.au3'
			If @error Then
				; TODO $XML_ERR_GENERAL replacement ??
				$__iLineNumber=2593 & ' - Return SetError($XML_ERR_GENERAL, $XML_EXT_SAXXMLREADER, $XM ...•./Include/_XML.au3'
				Return SetError($XML_ERR_GENERAL, $XML_EXT_SAXXMLREADER, $XML_RET_FAILURE)
			EndIf
		EndWith

		$__iLineNumber=2597 & ' - .Position = 0•./Include/_XML.au3'
		.Position = 0
		$__iLineNumber=2598 & ' - $sXML_Return = .ReadText($ADOENUM_adReadAll)•./Include/_XML.au3'
		$sXML_Return = .ReadText($ADOENUM_adReadAll)
		$__iLineNumber=2599 & ' - If $sXML_Return = Null Then $sXML_Return = ""•./Include/_XML.au3'
		If $sXML_Return = Null Then $sXML_Return = ''

	EndWith

	$__iLineNumber=2603 & ' - Local $iSizeInBytes = $oStream.size•./Include/_XML.au3'
	Local $iSizeInBytes = $oStream.size

	; CleanUp
	$__iLineNumber=2606 & ' - $oStream = Null•./Include/_XML.au3'
	$oStream = Null
	$__iLineNumber=2607 & ' - $oReader = Null•./Include/_XML.au3'
	$oReader = Null
	$__iLineNumber=2608 & ' - $oWriter = Null•./Include/_XML.au3'
	$oWriter = Null

	$__iLineNumber=2610 & ' - Return SetError($XML_ERR_OK, $iSizeInBytes, $sXML_Return) ;  ...•./Include/_XML.au3'
	Return SetError($XML_ERR_OK, $iSizeInBytes, $sXML_Return) ; TODO Description for @error and @extended

EndFunc   ;==>_XML_Tidy
#EndRegion XML.au3 - Functions - COMPLETED

#Region XML.au3 - Functions - Misc
; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name ..........: __XML_MiscProperty_DomVersion
; Description ...: TODO
; Syntax ........: __XML_MiscProperty_DomVersion([$sDomVersion = Default])
; Parameters ....: $sDomVersion         - [optional] a string value. Default value is Default.
; Return values .: DOM Version
; Author ........: mLipok
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
$__iLineNumber=2629 & ' - Func __XML_MiscProperty_DomVersion($sDomVersion = Default)•./Include/_XML.au3'
Func __XML_MiscProperty_DomVersion($sDomVersion = Default)
	$__iLineNumber=2630 & ' - Local Static $sDomVersion_Static = -1•./Include/_XML.au3'
	Local Static $sDomVersion_Static = -1

	$__iLineNumber=2632 & ' - If $sDomVersion = Default Then•./Include/_XML.au3'
	If $sDomVersion = Default Then
		; just return stored static variable
		$__iLineNumber=2634 & ' - Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $sDomVersion_ ...•./Include/_XML.au3'
		Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $sDomVersion_Static)
	ElseIf IsNumber($sDomVersion) Then
		; set and return static variable
		$__iLineNumber=2637 & ' - $sDomVersion_Static = $sDomVersion•./Include/_XML.au3'
		$sDomVersion_Static = $sDomVersion
		$__iLineNumber=2638 & ' - Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $sDomVersion_ ...•./Include/_XML.au3'
		Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $sDomVersion_Static)
	EndIf

	; reset static variable
	$__iLineNumber=2642 & ' - $sDomVersion_Static = -1•./Include/_XML.au3'
	$sDomVersion_Static = -1
	; return error as incorrect parameter was passed to this function
	$__iLineNumber=2644 & ' - Return SetError($XML_ERR_PARAMETER, $XML_EXT_DEFAULT, $XML_R ...•./Include/_XML.au3'
	Return SetError($XML_ERR_PARAMETER, $XML_EXT_DEFAULT, $XML_RET_FAILURE)

EndFunc   ;==>__XML_MiscProperty_DomVersion

; #FUNCTION# ===================================================================
; Name ..........: _XML_Misc_GetDomVersion
; Description ...: Returns the version of msxml that is in use for the document.
; Syntax.........: _XML_Misc_GetDomVersion()
; Parameters ....: none
; Return values .: Success		- msxml version
;                  Failure		- $XML_RET_FAILURE and sets the @error flag to non-zero (look in #Region XML.au3 - ERROR Enums)
; Author ........: Eltorro
; Modified ......: mLipok
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
$__iLineNumber=2662 & ' - Func _XML_Misc_GetDomVersion()•./Include/_XML.au3'
Func _XML_Misc_GetDomVersion()
	$__iLineNumber=2663 & ' - Return __XML_MiscProperty_DomVersion()•./Include/_XML.au3'
	Return __XML_MiscProperty_DomVersion()
EndFunc   ;==>_XML_Misc_GetDomVersion

; #FUNCTION# ====================================================================================================================
; Name ..........: _XML_Misc_Viewer
; Description ...: Display XML Document in default system viewer
; Syntax ........: _XML_Misc_Viewer(ByRef $oXmlDoc[, $sXML_FileFullPath = Default])
; Parameters ....: $oXmlDoc           - [in/out] an object. A valid DOMDocument object.
;                  $sXML_FileFullPath - [optional] a string value. Default is Default.
; Return values .: On Success         - Returns $XML_RET_SUCCESS
;                  On Failure         - Returns $XML_RET_FAILURE and sets the @error flag to non-zero (look in #Region XML.au3 - ERROR Enums)
;                  TODO: @extended description
; Author ........: mLipok
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
$__iLineNumber=2682 & ' - Func _XML_Misc_Viewer(ByRef $oXmlDoc, $sXML_FileFullPath = D ...•./Include/_XML.au3'
Func _XML_Misc_Viewer(ByRef $oXmlDoc, $sXML_FileFullPath = Default)
	$__iLineNumber=2683 & ' - If $sXML_FileFullPath = Default Then•./Include/_XML.au3'
	If $sXML_FileFullPath = Default Then
		$__iLineNumber=2684 & ' - $sXML_FileFullPath = @ScriptDir & "\XMLDOM_Display_TestingFi ...•./Include/_XML.au3'
		$sXML_FileFullPath = @ScriptDir & '\XMLDOM_Display_TestingFile.xml'
		$__iLineNumber=2685 & ' - FileDelete($sXML_FileFullPath)•./Include/_XML.au3'
		FileDelete($sXML_FileFullPath)
	EndIf

	$__iLineNumber=2688 & ' - _XML_SaveToFile($oXmlDoc, $sXML_FileFullPath)•./Include/_XML.au3'
	_XML_SaveToFile($oXmlDoc, $sXML_FileFullPath)
	$__iLineNumber=2689 & ' - If @error Then Return SetError(@error, @extended, $XML_RET_F ...•./Include/_XML.au3'
	If @error Then Return SetError(@error, @extended, $XML_RET_FAILURE)

	$__iLineNumber=2691 & ' - ShellExecute($sXML_FileFullPath)•./Include/_XML.au3'
	ShellExecute($sXML_FileFullPath)
	$__iLineNumber=2692 & ' - Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCC ...•./Include/_XML.au3'
	Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCCESS)

EndFunc   ;==>_XML_Misc_Viewer

; #FUNCTION# ====================================================================================================================
; Name ..........: _XML_MiscProperty_Encoding
; Description ...: Set/Get Encoding property
; Syntax ........: _XML_MiscProperty_Encoding([$sEncoding = Default])
; Parameters ....: $sEncoding             - [optional] a string value. Default value is Default.
; Return values .: Encoding as string
; Author ........: mLipok
; Modified ......:
; Remarks .......: For a list of the character set names that are known by a system, see the subkeys of HKEY_CLASSES_ROOT\MIME\Database\Charset in the Windows Registry.
; Related .......:
; Link ..........: https://msdn.microsoft.com/en-us/library/ms681424(v=vs.85).aspx
; Example .......: No
; ===============================================================================================================================
$__iLineNumber=2709 & ' - Func _XML_MiscProperty_Encoding($sEncoding = Default)•./Include/_XML.au3'
Func _XML_MiscProperty_Encoding($sEncoding = Default)
	$__iLineNumber=2710 & ' - Local Static $sEncoding_Static = Default•./Include/_XML.au3'
	Local Static $sEncoding_Static = Default

	$__iLineNumber=2712 & ' - If $sEncoding = Default Then ; get current value from static ...•./Include/_XML.au3'
	If $sEncoding = Default Then ; get current value from static variable
		$__iLineNumber=2713 & ' - If $sEncoding_Static = Default Then ; if not set yet, try to ...•./Include/_XML.au3'
		If $sEncoding_Static = Default Then ; if not set yet, try to set default encoding
			$__iLineNumber=2714 & ' - Switch @OSLang•./Include/_XML.au3'
			$__iLineNumber=2715 & ' - Case 0415 ; "pl-PL"•./Include/_XML.au3'
			Switch @OSLang
				Case 0415 ; 'pl-PL'
					$__iLineNumber=2716 & ' - $sEncoding_Static = "ISO-8859-2"•./Include/_XML.au3'
					$sEncoding_Static = 'ISO-8859-2'
				Case Else
					$__iLineNumber=2718 & ' - $sEncoding_Static = "ISO-8859-1"•./Include/_XML.au3'
					$sEncoding_Static = 'ISO-8859-1'
			EndSwitch
		EndIf
		$__iLineNumber=2721 & ' - Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $sEncoding_St ...•./Include/_XML.au3'
		Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $sEncoding_Static)

	ElseIf IsString($sEncoding) Then ; set and return current value
		$__iLineNumber=2724 & ' - $sEncoding_Static = $sEncoding•./Include/_XML.au3'
		$sEncoding_Static = $sEncoding
		$__iLineNumber=2725 & ' - Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $sEncoding_St ...•./Include/_XML.au3'
		Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $sEncoding_Static)
	EndIf
	$__iLineNumber=2727 & ' - Return SetError($XML_ERR_PARAMETER, $XML_EXT_PARAM1, $sEncod ...•./Include/_XML.au3'
	Return SetError($XML_ERR_PARAMETER, $XML_EXT_PARAM1, $sEncoding_Static)

EndFunc   ;==>_XML_MiscProperty_Encoding

; #FUNCTION# ===================================================================
; Name ..........: _XML_MiscProperty_UDFVersion
; Description ...: Returns UDF version number
; Syntax.........: _XML_MiscProperty_UDFVersion()
; Parameters ....: None
; Return values .: The UDF version number
; Author ........: mLipok
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
$__iLineNumber=2744 & ' - Func _XML_MiscProperty_UDFVersion()•./Include/_XML.au3'
Func _XML_MiscProperty_UDFVersion()
	$__iLineNumber=2745 & ' - Return "1.1.1.10"•./Include/_XML.au3'
	Return "1.1.1.10"
EndFunc   ;==>_XML_MiscProperty_UDFVersion
#EndRegion XML.au3 - Functions - Misc

#Region XML.au3 - Functions - Arrays

; #FUNCTION# ====================================================================================================================
; Name ..........: _XML_Array_AddName
; Description ...: Adds an item to an array.
; Syntax.........: _XML_Array_AddName(ByRef $avArray, $sValue)
; Parameters ....: $avArray       - The array to modify.
;                  $sValue        - The value to add to the array.
; Return values .: Success        $XML_RET_SUCCESS and value added to array.
;                  Failure             - $XML_RET_FAILURE and sets the @error flag to non-zero (look in #Region XML.au3 - ERROR Enums)
; Author ........:
; Modified ......: mLipok, guinness
; Remarks .......: Local version of _ArrayAdd to remove dependency on Array.au3
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
$__iLineNumber=2766 & ' - Func _XML_Array_AddName(ByRef $avArray, $sValue)•./Include/_XML.au3'
Func _XML_Array_AddName(ByRef $avArray, $sValue)
	$__iLineNumber=2767 & ' - Local $iUBound = UBound($avArray)•./Include/_XML.au3'
	Local $iUBound = UBound($avArray)
	$__iLineNumber=2768 & ' - If $iUBound Then ; IsArray() only tells you if it"s an array ...•./Include/_XML.au3'
	If $iUBound Then ; IsArray() only tells you if it's an array data structure and not if elements are in the array.
		; Cache function call results, as function calls are expensive compared to variable lookups.
		$__iLineNumber=2770 & ' - ReDim $avArray[$iUBound + 1]•./Include/_XML.au3'
		ReDim $avArray[$iUBound + 1]
		$__iLineNumber=2771 & ' - $avArray[$iUBound - 1] = $sValue•./Include/_XML.au3'
		$avArray[$iUBound - 1] = $sValue
		$__iLineNumber=2772 & ' - Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCC ...•./Include/_XML.au3'
		Return SetError($XML_ERR_OK, $XML_EXT_DEFAULT, $XML_RET_SUCCESS)
	EndIf

	; Else is not required, as this was always happen as a last resort.
	$__iLineNumber=2776 & ' - Return SetError($XML_ERR_GENERAL, $XML_EXT_DEFAULT, $XML_RET ...•./Include/_XML.au3'
	Return SetError($XML_ERR_GENERAL, $XML_EXT_DEFAULT, $XML_RET_FAILURE)
EndFunc   ;==>_XML_Array_AddName

; #FUNCTION# ====================================================================================================================
; Name ..........: _XML_Array_GetAttributesProperties
; Description ...: Get IXMLDOMAttribute Members - properties, and put the result to array
; Syntax ........: _XML_Array_GetAttributesProperties(ByRef $oAttributesColl)
; Parameters ....: $oAttributesColl           - [in/out] an object.
; Return values .: TODO
; Author ........: mLipok
; Modified ......:
; Remarks .......: TODO @error and description
; Related .......:
; Link ..........: https://msdn.microsoft.com/en-us/library/ms767677(v=vs.85).aspx
; Example .......: Yes
; ===============================================================================================================================
$__iLineNumber=2792 & ' - Func _XML_Array_GetAttributesProperties(ByRef $oAttributesCo ...•./Include/_XML.au3'
Func _XML_Array_GetAttributesProperties(ByRef $oAttributesColl)
	; Local Error handler declaration, it will be automatic CleanUp when returning from function
	$__iLineNumber=2794 & ' - Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XM ...•./Include/_XML.au3'
	Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XML_ComErrorHandler_InternalFunction)
	#forceref $oXML_COM_ErrorHandler

	$__iLineNumber=2797 & ' - __XML_IsValidObject_Attributes($oAttributesColl)•./Include/_XML.au3'
	__XML_IsValidObject_Attributes($oAttributesColl)
	$__iLineNumber=2798 & ' - If @error Then Return SetError(@error, @extended, $XML_RET_F ...•./Include/_XML.au3'
	If @error Then Return SetError(@error, @extended, $XML_RET_FAILURE)

	$__iLineNumber=2800 & ' - Local $avArray[1][$__g_eARRAY_ATTR_ARRAYCOLCOUNT]•./Include/_XML.au3'
	Local $avArray[1][$__g_eARRAY_ATTR_ARRAYCOLCOUNT]
	$__iLineNumber=2801 & ' - $avArray[0][$__g_eARRAY_ATTR_NAME] = "name"•./Include/_XML.au3'
	$avArray[0][$__g_eARRAY_ATTR_NAME] = 'name'
	$__iLineNumber=2802 & ' - $avArray[0][$__g_eARRAY_ATTR_TYPESTRING] = "nodeTypeString"•./Include/_XML.au3'
	$avArray[0][$__g_eARRAY_ATTR_TYPESTRING] = 'nodeTypeString'
	$__iLineNumber=2803 & ' - $avArray[0][$__g_eARRAY_ATTR_VALUE] = "value"•./Include/_XML.au3'
	$avArray[0][$__g_eARRAY_ATTR_VALUE] = 'value'
	$__iLineNumber=2804 & ' - $avArray[0][$__g_eARRAY_ATTR_TEXT] = "text"•./Include/_XML.au3'
	$avArray[0][$__g_eARRAY_ATTR_TEXT] = 'text'
	$__iLineNumber=2805 & ' - $avArray[0][$__g_eARRAY_ATTR_DATATYPE] = "dataType"•./Include/_XML.au3'
	$avArray[0][$__g_eARRAY_ATTR_DATATYPE] = 'dataType'
	$__iLineNumber=2806 & ' - $avArray[0][$__g_eARRAY_ATTR_XML] = "xml"•./Include/_XML.au3'
	$avArray[0][$__g_eARRAY_ATTR_XML] = 'xml'
	$__iLineNumber=2807 & ' - Local $iUBound = 0•./Include/_XML.au3'
	Local $iUBound = 0

	$__iLineNumber=2809 & ' - For $oAttributeEnum In $oAttributesColl•./Include/_XML.au3'
	For $oAttributeEnum In $oAttributesColl
		$__iLineNumber=2810 & ' - $iUBound = UBound($avArray)•./Include/_XML.au3'
		$iUBound = UBound($avArray)
		$__iLineNumber=2811 & ' - ReDim $avArray[$iUBound + 1][$__g_eARRAY_ATTR_ARRAYCOLCOUNT]•./Include/_XML.au3'
		ReDim $avArray[$iUBound + 1][$__g_eARRAY_ATTR_ARRAYCOLCOUNT]
		$__iLineNumber=2812 & ' - $avArray[$iUBound][$__g_eARRAY_ATTR_NAME] = $oAttributeEnum. ...•./Include/_XML.au3'
		$avArray[$iUBound][$__g_eARRAY_ATTR_NAME] = $oAttributeEnum.name
		$__iLineNumber=2813 & ' - $avArray[$iUBound][$__g_eARRAY_ATTR_TYPESTRING] = $oAttribut ...•./Include/_XML.au3'
		$avArray[$iUBound][$__g_eARRAY_ATTR_TYPESTRING] = $oAttributeEnum.nodeTypeString
		$__iLineNumber=2814 & ' - $avArray[$iUBound][$__g_eARRAY_ATTR_VALUE] = $oAttributeEnum ...•./Include/_XML.au3'
		$avArray[$iUBound][$__g_eARRAY_ATTR_VALUE] = $oAttributeEnum.value
		$__iLineNumber=2815 & ' - $avArray[$iUBound][$__g_eARRAY_ATTR_TEXT] = $oAttributeEnum. ...•./Include/_XML.au3'
		$avArray[$iUBound][$__g_eARRAY_ATTR_TEXT] = $oAttributeEnum.text
		$__iLineNumber=2816 & ' - $avArray[$iUBound][$__g_eARRAY_ATTR_DATATYPE] = $oAttributeE ...•./Include/_XML.au3'
		$avArray[$iUBound][$__g_eARRAY_ATTR_DATATYPE] = $oAttributeEnum.dataType
		$__iLineNumber=2817 & ' - $avArray[$iUBound][$__g_eARRAY_ATTR_XML] = $oAttributeEnum.x ...•./Include/_XML.au3'
		$avArray[$iUBound][$__g_eARRAY_ATTR_XML] = $oAttributeEnum.xml
	Next
	$__iLineNumber=2819 & ' - Return SetError($XML_ERR_OK, UBound($avArray), $avArray)•./Include/_XML.au3'
	Return SetError($XML_ERR_OK, UBound($avArray), $avArray)

EndFunc   ;==>_XML_Array_GetAttributesProperties

; #FUNCTION# ====================================================================================================================
; Name ..........: _XML_Array_GetNodesProperties
; Description ...: Get IXMLDOMNode Members - properties, and put the result to array
; Syntax ........: _XML_Array_GetNodesProperties(ByRef $oNodeColl)
; Parameters ....: $oNodeColl           - [in/out] an object.
; Return values .: Array with attributes description
; Author ........: mLipok
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........: https://msdn.microsoft.com/en-us/library/ms761386(v=vs.85).aspx
; Example .......: yes
; ===============================================================================================================================
$__iLineNumber=2836 & ' - Func _XML_Array_GetNodesProperties(ByRef $oNodesColl)•./Include/_XML.au3'
Func _XML_Array_GetNodesProperties(ByRef $oNodesColl)
	; Local Error handler declaration, it will be automatic CleanUp when returning from function
	$__iLineNumber=2838 & ' - Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XM ...•./Include/_XML.au3'
	Local $oXML_COM_ErrorHandler = ObjEvent("AutoIt.Error", __XML_ComErrorHandler_InternalFunction)
	#forceref $oXML_COM_ErrorHandler

	$__iLineNumber=2841 & ' - __XML_IsValidObject_NodesColl($oNodesColl)•./Include/_XML.au3'
	__XML_IsValidObject_NodesColl($oNodesColl)
	$__iLineNumber=2842 & ' - If @error Then Return SetError(@error, @extended, $XML_RET_F ...•./Include/_XML.au3'
	If @error Then Return SetError(@error, @extended, $XML_RET_FAILURE)

	$__iLineNumber=2844 & ' - Local $avArray[1][$__g_eARRAY_NODE_ARRAYCOLCOUNT]•./Include/_XML.au3'
	Local $avArray[1][$__g_eARRAY_NODE_ARRAYCOLCOUNT]
	$__iLineNumber=2845 & ' - $avArray[0][$__g_eARRAY_NODE_NAME] = "nodeName"•./Include/_XML.au3'
	$avArray[0][$__g_eARRAY_NODE_NAME] = 'nodeName'
	$__iLineNumber=2846 & ' - $avArray[0][$__g_eARRAY_NODE_TYPESTRING] = "nodeTypeString"•./Include/_XML.au3'
	$avArray[0][$__g_eARRAY_NODE_TYPESTRING] = 'nodeTypeString'
	$__iLineNumber=2847 & ' - $avArray[0][$__g_eARRAY_NODE_VALUE] = "nodeValue"•./Include/_XML.au3'
	$avArray[0][$__g_eARRAY_NODE_VALUE] = 'nodeValue'
	$__iLineNumber=2848 & ' - $avArray[0][$__g_eARRAY_NODE_TEXT] = "text"•./Include/_XML.au3'
	$avArray[0][$__g_eARRAY_NODE_TEXT] = 'text'
	$__iLineNumber=2849 & ' - $avArray[0][$__g_eARRAY_NODE_DATATYPE] = "dataType"•./Include/_XML.au3'
	$avArray[0][$__g_eARRAY_NODE_DATATYPE] = 'dataType'
	$__iLineNumber=2850 & ' - $avArray[0][$__g_eARRAY_NODE_XML] = "xml"•./Include/_XML.au3'
	$avArray[0][$__g_eARRAY_NODE_XML] = 'xml'
	$__iLineNumber=2851 & ' - $avArray[0][$__g_eARRAY_NODE_ATTRIBUTES] = "attributes"•./Include/_XML.au3'
	$avArray[0][$__g_eARRAY_NODE_ATTRIBUTES] = 'attributes'
	$__iLineNumber=2852 & ' - Local $iUBound = 0•./Include/_XML.au3'
	Local $iUBound = 0

	$__iLineNumber=2854 & ' - For $oNode_enum In $oNodesColl•./Include/_XML.au3'
	For $oNode_enum In $oNodesColl
		$__iLineNumber=2855 & ' - $iUBound = UBound($avArray)•./Include/_XML.au3'
		$iUBound = UBound($avArray)
		$__iLineNumber=2856 & ' - ReDim $avArray[$iUBound + 1][$__g_eARRAY_NODE_ARRAYCOLCOUNT]•./Include/_XML.au3'
		ReDim $avArray[$iUBound + 1][$__g_eARRAY_NODE_ARRAYCOLCOUNT]
		$__iLineNumber=2857 & ' - $avArray[$iUBound][$__g_eARRAY_NODE_NAME] = $oNode_enum.node ...•./Include/_XML.au3'
		$avArray[$iUBound][$__g_eARRAY_NODE_NAME] = $oNode_enum.nodeName
		$__iLineNumber=2858 & ' - $avArray[$iUBound][$__g_eARRAY_NODE_TYPESTRING] = $oNode_enu ...•./Include/_XML.au3'
		$avArray[$iUBound][$__g_eARRAY_NODE_TYPESTRING] = $oNode_enum.nodeTypeString
		$__iLineNumber=2859 & ' - $avArray[$iUBound][$__g_eARRAY_NODE_VALUE] = $oNode_enum.nod ...•./Include/_XML.au3'
		$avArray[$iUBound][$__g_eARRAY_NODE_VALUE] = $oNode_enum.nodeValue
		$__iLineNumber=2860 & ' - $avArray[$iUBound][$__g_eARRAY_NODE_TEXT] = $oNode_enum.text•./Include/_XML.au3'
		$avArray[$iUBound][$__g_eARRAY_NODE_TEXT] = $oNode_enum.text
		$__iLineNumber=2861 & ' - $avArray[$iUBound][$__g_eARRAY_NODE_DATATYPE] = $oNode_enum. ...•./Include/_XML.au3'
		$avArray[$iUBound][$__g_eARRAY_NODE_DATATYPE] = $oNode_enum.dataType
		$__iLineNumber=2862 & ' - $avArray[$iUBound][$__g_eARRAY_NODE_XML] = $oNode_enum.xml•./Include/_XML.au3'
		$avArray[$iUBound][$__g_eARRAY_NODE_XML] = $oNode_enum.xml

		; check if node have any attributes
		$__iLineNumber=2865 & ' - If IsObj($oNode_enum.attributes) And $oNode_enum.attributes. ...•./Include/_XML.au3'
		If IsObj($oNode_enum.attributes) And $oNode_enum.attributes.length = 0 Then
			$__iLineNumber=2866 & ' - $avArray[$iUBound][$__g_eARRAY_NODE_ATTRIBUTES] = ""•./Include/_XML.au3'
			$avArray[$iUBound][$__g_eARRAY_NODE_ATTRIBUTES] = ''
		Else
			$__iLineNumber=2868 & ' - Local $sAttributes = ""•./Include/_XML.au3'
			Local $sAttributes = ''
			$__iLineNumber=2869 & ' - For $oAttribute In $oNode_enum.attributes•./Include/_XML.au3'
			For $oAttribute In $oNode_enum.attributes
				$__iLineNumber=2870 & ' - $sAttributes &= $oAttribute.name & "="" & $oAttribute.text & ...•./Include/_XML.au3'
				$sAttributes &= $oAttribute.name & '="' & $oAttribute.text & '" '
			Next
			$__iLineNumber=2872 & ' - $avArray[$iUBound][$__g_eARRAY_NODE_ATTRIBUTES] = StringTrim ...•./Include/_XML.au3'
			$avArray[$iUBound][$__g_eARRAY_NODE_ATTRIBUTES] = StringTrimRight($sAttributes, 1)
		EndIf
	Next
	$__iLineNumber=2875 & ' - Return SetError($XML_ERR_OK, UBound($avArray), $avArray)•./Include/_XML.au3'
	Return SetError($XML_ERR_OK, UBound($avArray), $avArray)

EndFunc   ;==>_XML_Array_GetNodesProperties
#EndRegion XML.au3 - Functions - Arrays

#Region XML.au3 - Functions - Error Handling

; #INTERNAL_USE_ONLY#==========================================================
; Name ..........: __XML_ComErrorHandler_InternalFunction
; Description ...: A COM error handling routine.
; Syntax.........: __XML_ComErrorHandler_InternalFunction()
; Parameters ....: None
; Return values .: None
; Author ........: mLipok
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; [yes/no]
; ==============================================================================
$__iLineNumber=2895 & ' - Func __XML_ComErrorHandler_InternalFunction($oCOMError)•./Include/_XML.au3'
Func __XML_ComErrorHandler_InternalFunction($oCOMError)
	; If not defined ComErrorHandler_UserFunction then this function do nothing special
	; In that case you only can check @error / @extended after suspect functions

	$__iLineNumber=2899 & ' - Local $sUserFunction = _XML_ComErrorHandler_UserFunction()•./Include/_XML.au3'
	Local $sUserFunction = _XML_ComErrorHandler_UserFunction()
	$__iLineNumber=2900 & ' - If IsFunc($sUserFunction) Then $sUserFunction($oCOMError)•./Include/_XML.au3'
	If IsFunc($sUserFunction) Then $sUserFunction($oCOMError)
EndFunc   ;==>__XML_ComErrorHandler_InternalFunction

; #FUNCTION# ====================================================================================================================
; Name ..........: __XML_ComErrorHandler_UserFunction
; Description ...: Set a UserFunctionWrapper to move the Fired COM Error Error outside UDF
; Syntax ........: _XML_ComErrorHandler_UserFunction([$fnUserFunction = Default])
; Parameters ....: $fnUserFunction- [optional] a Function. Default value is Default.
; Return values .: ErrorHandler Function
; Author ........: mLipok
; Modified ......:
; Remarks .......: Description TODO
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
$__iLineNumber=2916 & ' - Func _XML_ComErrorHandler_UserFunction($fnUserFunction = Def ...•./Include/_XML.au3'
Func _XML_ComErrorHandler_UserFunction($fnUserFunction = Default)
	; in case when user do not set his own function UDF must use internal function to avoid AutoItError
	$__iLineNumber=2918 & ' - Local Static $fnUserFunction_Static = ""•./Include/_XML.au3'
	Local Static $fnUserFunction_Static = ''

	$__iLineNumber=2920 & ' - If $fnUserFunction = Default Then•./Include/_XML.au3'
	If $fnUserFunction = Default Then
		$__iLineNumber=2921 & ' - Return $fnUserFunction_Static ; just return stored static va ...•./Include/_XML.au3'
		Return $fnUserFunction_Static ; just return stored static variable
	ElseIf IsFunc($fnUserFunction) Then
		$__iLineNumber=2923 & ' - $fnUserFunction_Static = $fnUserFunction ; set and return st ...•./Include/_XML.au3'
		$fnUserFunction_Static = $fnUserFunction ; set and return static variable
		$__iLineNumber=2924 & ' - Return $fnUserFunction_Static•./Include/_XML.au3'
		Return $fnUserFunction_Static
	EndIf
	$__iLineNumber=2926 & ' - $fnUserFunction_Static = "" ; reset static variable•./Include/_XML.au3'
	$fnUserFunction_Static = '' ; reset static variable
	; return error as incorrect parameter was passed to this function
	$__iLineNumber=2928 & ' - Return SetError($XML_ERR_PARAMETER, $XML_EXT_DEFAULT, $fnUse ...•./Include/_XML.au3'
	Return SetError($XML_ERR_PARAMETER, $XML_EXT_DEFAULT, $fnUserFunction_Static)

EndFunc   ;==>_XML_ComErrorHandler_UserFunction

; #FUNCTION# ====================================================================================================================
; Name ..........: _XML_ErrorParser_GetDescription
; Description ...: Parse Error to Console
; Syntax ........: _XML_ErrorParser_GetDescription(ByRef $oXmlDoc)
; Parameters ....: $oXmlDoc 			- [in/out] an object. A valid DOMDocument object.
; Return values .: Descripition for paresed error
; Author ........: mLipok
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........: https://msdn.microsoft.com/en-us/library/ms767720(v=vs.85).aspx , https://msdn.microsoft.com/en-us/library/ms757019(v=vs.85).aspx
; Example .......: No
; ===============================================================================================================================
$__iLineNumber=2945 & ' - Func _XML_ErrorParser_GetDescription(ByRef $oXmlDoc)•./Include/_XML.au3'
Func _XML_ErrorParser_GetDescription(ByRef $oXmlDoc)
	$__iLineNumber=2946 & ' - Local $sParseError_FullDescription = ""•./Include/_XML.au3'
	Local $sParseError_FullDescription = ''
	$__iLineNumber=2947 & ' - If IsObj($oXmlDoc) And $oXmlDoc.parseError.errorCode <> 0 Th ...•./Include/_XML.au3'
	If IsObj($oXmlDoc) And $oXmlDoc.parseError.errorCode <> 0 Then
		$__iLineNumber=2948 & ' - $sParseError_FullDescription &= "IXMLDOMParseError errorCode ...•./Include/_XML.au3'
		$sParseError_FullDescription &= 'IXMLDOMParseError errorCode = ' & $oXmlDoc.parseError.errorCode & @CRLF ; Contains the error code of the last parse error.
		$__iLineNumber=2949 & ' - $sParseError_FullDescription &= "IXMLDOMParseError filepos = ...•./Include/_XML.au3'
		$sParseError_FullDescription &= 'IXMLDOMParseError filepos = ' & $oXmlDoc.parseError.filepos & @CRLF ; Contains the absolute file position where the error occurred.
		$__iLineNumber=2950 & ' - $sParseError_FullDescription &= "IXMLDOMParseError line = "  ...•./Include/_XML.au3'
		$sParseError_FullDescription &= 'IXMLDOMParseError line = ' & $oXmlDoc.parseError.line & @CRLF ; Specifies the line number that contains the error.
		$__iLineNumber=2951 & ' - $sParseError_FullDescription &= "IXMLDOMParseError linepos = ...•./Include/_XML.au3'
		$sParseError_FullDescription &= 'IXMLDOMParseError linepos = ' & $oXmlDoc.parseError.linepos & @CRLF ; Contains the character position within the line where the error occurred.
		$__iLineNumber=2952 & ' - $sParseError_FullDescription &= "IXMLDOMParseError reason =  ...•./Include/_XML.au3'
		$sParseError_FullDescription &= 'IXMLDOMParseError reason = ' & $oXmlDoc.parseError.reason & @CRLF ; Describes the reason for the error.
		$__iLineNumber=2953 & ' - $sParseError_FullDescription &= "IXMLDOMParseError srcText = ...•./Include/_XML.au3'
		$sParseError_FullDescription &= 'IXMLDOMParseError srcText = ' & $oXmlDoc.parseError.srcText & @CRLF ; Returns the full text of the line containing the error.
		$__iLineNumber=2954 & ' - $sParseError_FullDescription &= "IXMLDOMParseError url = " & ...•./Include/_XML.au3'
		$sParseError_FullDescription &= 'IXMLDOMParseError url = ' & $oXmlDoc.parseError.url & @CRLF ; Contains the URL of the XML document containing the last error.
	EndIf
	$__iLineNumber=2956 & ' - Return $sParseError_FullDescription•./Include/_XML.au3'
	Return $sParseError_FullDescription
EndFunc   ;==>_XML_ErrorParser_GetDescription
#EndRegion XML.au3 - Functions - Error Handling

#Region XML.au3 - NEW TODO

#CS
	DOM Reference
	$__iLineNumber=2964 & ' - https://msdn.microsoft.com/en-us/library/ms764730(v=vs.85).a ...•./Include/_XML.au3'
	https://msdn.microsoft.com/en-us/library/ms764730(v=vs.85).aspx

	$__iLineNumber=2966 & ' - XPath Examples•./Include/_XML.au3'
	XPath Examples
	$__iLineNumber=2967 & ' - https://msdn.microsoft.com/en-us/library/ms256086(v=vs.110). ...•./Include/_XML.au3'
	https://msdn.microsoft.com/en-us/library/ms256086(v=vs.110).aspx

#CE

$__iLineNumber=2971 & ' - Func _EncodeXML($sFileToEncode)•./Include/_XML.au3'
Func _EncodeXML($sFileToEncode)
;~ http://www.vb-helper.com/howto_encode_base64_hex.html
;~ https://www.autoitscript.com/forum/topic/138443-image-to-base64-code/?do=findComment&comment=970372
;~ http://stackoverflow.com/questions/496751/base64-encode-string-in-vbscript
;~ https://support.microsoft.com/en-us/kb/254388
;~ https://gist.github.com/wangye/1990522
	;Xroot 2011

	$__iLineNumber=2979 & ' - Local $hFile = FileOpen($sFileToEncode, $FO_BINARY)•./Include/_XML.au3'
	Local $hFile = FileOpen($sFileToEncode, $FO_BINARY)
	$__iLineNumber=2980 & ' - Local $dat = FileRead($hFile)•./Include/_XML.au3'
	Local $dat = FileRead($hFile)
	$__iLineNumber=2981 & ' - FileClose($hFile)•./Include/_XML.au3'
	FileClose($hFile)
	$__iLineNumber=2982 & ' - Local $oXML = ObjCreate("MSXML2.DOMDocument")•./Include/_XML.au3'
	Local $oXML = ObjCreate("MSXML2.DOMDocument")
	$__iLineNumber=2983 & ' - Local $oNode = $oXML.createElement("b64")•./Include/_XML.au3'
	Local $oNode = $oXML.createElement("b64")
	$__iLineNumber=2984 & ' - $oNode.dataType = "bin.base64"•./Include/_XML.au3'
	$oNode.dataType = "bin.base64"
	$__iLineNumber=2985 & ' - $oNode.nodeTypedValue = $dat•./Include/_XML.au3'
	$oNode.nodeTypedValue = $dat
	$__iLineNumber=2986 & ' - Return $oNode.Text•./Include/_XML.au3'
	Return $oNode.Text
EndFunc   ;==>_EncodeXML
#EndRegion XML.au3 - NEW TODO

