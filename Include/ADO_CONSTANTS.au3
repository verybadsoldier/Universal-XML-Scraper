$__iLineNumber=0
#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w- 4 -w 5 -w 6 -w 7

;~ ADO Enumerated Constants
;~ http://msdn.microsoft.com/en-us/library/windows/desktop/ms678353%28v=vs.85%29.aspx

; ADCPROP_ASYNCTHREADPRIORITY_ENUM
$__iLineNumber=7 & ' - Global Const $ADOENUM_adPriorityLowest = 1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adPriorityLowest = 1
$__iLineNumber=8 & ' - Global Const $ADOENUM_adPriorityBelowNormal = 2•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adPriorityBelowNormal = 2
$__iLineNumber=9 & ' - Global Const $ADOENUM_adPriorityNormal = 3•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adPriorityNormal = 3
$__iLineNumber=10 & ' - Global Const $ADOENUM_adPriorityAboveNormal = 4•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adPriorityAboveNormal = 4
$__iLineNumber=11 & ' - Global Const $ADOENUM_adPriorityHighest = 5•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adPriorityHighest = 5

; ADCPROP_AUTORECALC_ENUM
$__iLineNumber=14 & ' - Global Const $ADOENUM_adRecalcUpFront = 0•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adRecalcUpFront = 0
$__iLineNumber=15 & ' - Global Const $ADOENUM_adRecalcAlways = 1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adRecalcAlways = 1

; ADCPROP_UPDATECRITERIA_ENUM
$__iLineNumber=18 & ' - Global Const $ADOENUM_adCriteriaKey = 0•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adCriteriaKey = 0
$__iLineNumber=19 & ' - Global Const $ADOENUM_adCriteriaAllCols = 1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adCriteriaAllCols = 1
$__iLineNumber=20 & ' - Global Const $ADOENUM_adCriteriaUpdCols = 2•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adCriteriaUpdCols = 2
$__iLineNumber=21 & ' - Global Const $ADOENUM_adCriteriaTimeStamp = 3•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adCriteriaTimeStamp = 3

; ADCPROP_UPDATERESYNC_ENUM
$__iLineNumber=24 & ' - Global Const $ADOENUM_adResyncNone = 0•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adResyncNone = 0
$__iLineNumber=25 & ' - Global Const $ADOENUM_adResyncAutoIncrement = 1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adResyncAutoIncrement = 1
$__iLineNumber=26 & ' - Global Const $ADOENUM_adResyncConflicts = 2•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adResyncConflicts = 2
$__iLineNumber=27 & ' - Global Const $ADOENUM_adResyncUpdates = 4•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adResyncUpdates = 4
$__iLineNumber=28 & ' - Global Const $ADOENUM_adResyncInserts = 8•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adResyncInserts = 8
$__iLineNumber=29 & ' - Global Const $ADOENUM_adResyncAll = 15•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adResyncAll = 15

; AffectEnum
$__iLineNumber=32 & ' - Global Const $ADOENUM_adAffectCurrent = 1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adAffectCurrent = 1
$__iLineNumber=33 & ' - Global Const $ADOENUM_adAffectGroup = 2•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adAffectGroup = 2
$__iLineNumber=34 & ' - Global Const $ADOENUM_adAffectAll = 3•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adAffectAll = 3
$__iLineNumber=35 & ' - Global Const $ADOENUM_adAffectAllChapters = 4•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adAffectAllChapters = 4

; BookmarkEnum
$__iLineNumber=38 & ' - Global Const $ADOENUM_adBookmarkCurrent = 0•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adBookmarkCurrent = 0
$__iLineNumber=39 & ' - Global Const $ADOENUM_adBookmarkFirst = 1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adBookmarkFirst = 1
$__iLineNumber=40 & ' - Global Const $ADOENUM_adBookmarkLast = 2•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adBookmarkLast = 2

; CommandTypeEnum
$__iLineNumber=43 & ' - Global Const $ADOENUM_adCmdUnspecified = -1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adCmdUnspecified = -1
$__iLineNumber=44 & ' - Global Const $ADOENUM_adCmdText = 1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adCmdText = 1
$__iLineNumber=45 & ' - Global Const $ADOENUM_adCmdTable = 2•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adCmdTable = 2
$__iLineNumber=46 & ' - Global Const $ADOENUM_adCmdStoredProc = 4•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adCmdStoredProc = 4
$__iLineNumber=47 & ' - Global Const $ADOENUM_adCmdUnknown = 8•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adCmdUnknown = 8
$__iLineNumber=48 & ' - Global Const $ADOENUM_adCmdFile = 256•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adCmdFile = 256
$__iLineNumber=49 & ' - Global Const $ADOENUM_adCmdTableDirect = 512•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adCmdTableDirect = 512

; CompareEnum
$__iLineNumber=52 & ' - Global Const $ADOENUM_adCompareLessThan = 0•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adCompareLessThan = 0
$__iLineNumber=53 & ' - Global Const $ADOENUM_adCompareEqual = 1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adCompareEqual = 1
$__iLineNumber=54 & ' - Global Const $ADOENUM_adCompareGreaterThan = 2•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adCompareGreaterThan = 2
$__iLineNumber=55 & ' - Global Const $ADOENUM_adCompareNotEqual = 3•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adCompareNotEqual = 3
$__iLineNumber=56 & ' - Global Const $ADOENUM_adCompareNotComparable = 4•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adCompareNotComparable = 4

; ConnectModeEnum
$__iLineNumber=59 & ' - Global Const $ADOENUM_adModeUnknown = 0•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adModeUnknown = 0
$__iLineNumber=60 & ' - Global Const $ADOENUM_adModeRead = 1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adModeRead = 1
$__iLineNumber=61 & ' - Global Const $ADOENUM_adModeWrite = 2•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adModeWrite = 2
$__iLineNumber=62 & ' - Global Const $ADOENUM_adModeReadWrite = 3•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adModeReadWrite = 3
$__iLineNumber=63 & ' - Global Const $ADOENUM_adModeShareDenyRead = 4•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adModeShareDenyRead = 4
$__iLineNumber=64 & ' - Global Const $ADOENUM_adModeShareDenyWrite = 8•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adModeShareDenyWrite = 8
$__iLineNumber=65 & ' - Global Const $ADOENUM_adModeShareExclusive = 12•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adModeShareExclusive = 12
$__iLineNumber=66 & ' - Global Const $ADOENUM_adModeShareDenyNone = 16•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adModeShareDenyNone = 16
$__iLineNumber=67 & ' - Global Const $ADOENUM_adModeRecursive = 0x400000•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adModeRecursive = 0x400000

; ConnectOptionEnum
$__iLineNumber=70 & ' - Global Const $ADOENUM_adConnectUnspecified = -1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adConnectUnspecified = -1
$__iLineNumber=71 & ' - Global Const $ADOENUM_adAsyncConnect = 16•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adAsyncConnect = 16

; ConnectPromptEnum
$__iLineNumber=74 & ' - Global Const $ADOENUM_adPromptAlways = 1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adPromptAlways = 1
$__iLineNumber=75 & ' - Global Const $ADOENUM_adPromptComplete = 2•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adPromptComplete = 2
$__iLineNumber=76 & ' - Global Const $ADOENUM_adPromptCompleteRequired = 3•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adPromptCompleteRequired = 3
$__iLineNumber=77 & ' - Global Const $ADOENUM_adPromptNever = 4•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adPromptNever = 4

; CopyRecordOptionsEnum
$__iLineNumber=80 & ' - Global Const $ADOENUM_adCopyUnspecified = -1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adCopyUnspecified = -1
$__iLineNumber=81 & ' - Global Const $ADOENUM_adCopyOverWrite = 1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adCopyOverWrite = 1
$__iLineNumber=82 & ' - Global Const $ADOENUM_adCopyNonRecursive = 2•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adCopyNonRecursive = 2
$__iLineNumber=83 & ' - Global Const $ADOENUM_adCopyAllowEmulation = 4•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adCopyAllowEmulation = 4

; CursorLocationEnum
$__iLineNumber=86 & ' - Global Const $ADOENUM_adUseNone = 1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adUseNone = 1
$__iLineNumber=87 & ' - Global Const $ADOENUM_adUseServer = 2•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adUseServer = 2
$__iLineNumber=88 & ' - Global Const $ADOENUM_adUseClient = 3•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adUseClient = 3

; CursorOptionEnum
$__iLineNumber=91 & ' - Global Const $ADOENUM_adAddNew = 0x1000400•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adAddNew = 0x1000400
$__iLineNumber=92 & ' - Global Const $ADOENUM_adApproxPosition = 0x4000•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adApproxPosition = 0x4000
$__iLineNumber=93 & ' - Global Const $ADOENUM_adBookmark = 0x2000•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adBookmark = 0x2000
$__iLineNumber=94 & ' - Global Const $ADOENUM_adDelete = 0x1000800•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adDelete = 0x1000800
$__iLineNumber=95 & ' - Global Const $ADOENUM_adFind = 0x80000•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFind = 0x80000
$__iLineNumber=96 & ' - Global Const $ADOENUM_adHoldRecords = 0x100•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adHoldRecords = 0x100
$__iLineNumber=97 & ' - Global Const $ADOENUM_adIndex = 0x100000•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adIndex = 0x100000
$__iLineNumber=98 & ' - Global Const $ADOENUM_adMovePrevious = 0x200•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adMovePrevious = 0x200
$__iLineNumber=99 & ' - Global Const $ADOENUM_adNotify = 0x40000•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adNotify = 0x40000
$__iLineNumber=100 & ' - Global Const $ADOENUM_adResync = 0x20000•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adResync = 0x20000
$__iLineNumber=101 & ' - Global Const $ADOENUM_adSeek = 0x200000•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSeek = 0x200000
$__iLineNumber=102 & ' - Global Const $ADOENUM_adUpdate = 0x1008000•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adUpdate = 0x1008000
$__iLineNumber=103 & ' - Global Const $ADOENUM_adUpdateBatch = 0x10000•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adUpdateBatch = 0x10000

;~ CursorTypeEnum
;~ https://msdn.microsoft.com/en-us/library/windows/desktop/ms681771(v=vs.85).aspx
$__iLineNumber=107 & ' - Global Const $ADOENUM_adOpenUnspecified = -1 ; Does not spec ...•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adOpenUnspecified = -1 ; Does not specify the type of cursor.
$__iLineNumber=108 & ' - Global Const $ADOENUM_adOpenForwardOnly = 0 ; Default. Uses  ...•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adOpenForwardOnly = 0 ; Default. Uses a forward-only cursor. Identical to a static cursor, except that you can only scroll forward through records. This improves performance when you need to make only one pass through a Recordset.
$__iLineNumber=109 & ' - Global Const $ADOENUM_adOpenKeyset = 1 ; Uses a keyset curso ...•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adOpenKeyset = 1 ; Uses a keyset cursor. Like a dynamic cursor, except that you can't see records that other users add, although records that other users delete are inaccessible from your Recordset. Data changes by other users are still visible.
$__iLineNumber=110 & ' - Global Const $ADOENUM_adOpenDynamic = 2 ; Uses a dynamic cur ...•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adOpenDynamic = 2 ; Uses a dynamic cursor. Additions, changes, and deletions by other users are visible, and all types of movement through the Recordset are allowed, except for bookmarks, if the provider doesn't support them.
$__iLineNumber=111 & ' - Global Const $ADOENUM_adOpenStatic = 3 ; Uses a static curso ...•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adOpenStatic = 3 ; Uses a static cursor, which is a static copy of a set of records that you can use to find data or generate reports. Additions, changes, or deletions by other users are not visible.

; DataTypeEnum
$__iLineNumber=114 & ' - Global Const $ADOENUM_adArray = 0x2000•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adArray = 0x2000
$__iLineNumber=115 & ' - Global Const $ADOENUM_adBigInt = 20•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adBigInt = 20
$__iLineNumber=116 & ' - Global Const $ADOENUM_adBinary = 128•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adBinary = 128
$__iLineNumber=117 & ' - Global Const $ADOENUM_adBoolean = 11•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adBoolean = 11
$__iLineNumber=118 & ' - Global Const $ADOENUM_adBSTR = 8•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adBSTR = 8
$__iLineNumber=119 & ' - Global Const $ADOENUM_adChapter = 136•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adChapter = 136
$__iLineNumber=120 & ' - Global Const $ADOENUM_adChar = 129•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adChar = 129
$__iLineNumber=121 & ' - Global Const $ADOENUM_adCurrency = 6•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adCurrency = 6
$__iLineNumber=122 & ' - Global Const $ADOENUM_adDate = 7•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adDate = 7
$__iLineNumber=123 & ' - Global Const $ADOENUM_adDBDate = 133•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adDBDate = 133
$__iLineNumber=124 & ' - Global Const $ADOENUM_adDBTime = 134•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adDBTime = 134
$__iLineNumber=125 & ' - Global Const $ADOENUM_adDBTimeStamp = 135•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adDBTimeStamp = 135
$__iLineNumber=126 & ' - Global Const $ADOENUM_adDecimal = 14•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adDecimal = 14
$__iLineNumber=127 & ' - Global Const $ADOENUM_adDouble = 5•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adDouble = 5
$__iLineNumber=128 & ' - Global Const $ADOENUM_adEmpty = 0•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adEmpty = 0
$__iLineNumber=129 & ' - Global Const $ADOENUM_adError = 10•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adError = 10
$__iLineNumber=130 & ' - Global Const $ADOENUM_adFileTime = 64•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFileTime = 64
$__iLineNumber=131 & ' - Global Const $ADOENUM_adGUID = 72•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adGUID = 72
$__iLineNumber=132 & ' - Global Const $ADOENUM_adIDispatch = 9•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adIDispatch = 9
$__iLineNumber=133 & ' - Global Const $ADOENUM_adInteger = 3•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adInteger = 3
$__iLineNumber=134 & ' - Global Const $ADOENUM_adIUnknown = 13•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adIUnknown = 13
$__iLineNumber=135 & ' - Global Const $ADOENUM_adLongVarBinary = 205•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adLongVarBinary = 205
$__iLineNumber=136 & ' - Global Const $ADOENUM_adLongVarChar = 201•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adLongVarChar = 201
$__iLineNumber=137 & ' - Global Const $ADOENUM_adLongVarWChar = 203•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adLongVarWChar = 203
$__iLineNumber=138 & ' - Global Const $ADOENUM_adNumeric = 131•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adNumeric = 131
$__iLineNumber=139 & ' - Global Const $ADOENUM_adPropVariant = 138•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adPropVariant = 138
$__iLineNumber=140 & ' - Global Const $ADOENUM_adSingle = 4•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSingle = 4
$__iLineNumber=141 & ' - Global Const $ADOENUM_adSmallInt = 2•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSmallInt = 2
$__iLineNumber=142 & ' - Global Const $ADOENUM_adTinyInt = 16•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adTinyInt = 16
$__iLineNumber=143 & ' - Global Const $ADOENUM_adUnsignedBigInt = 21•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adUnsignedBigInt = 21
$__iLineNumber=144 & ' - Global Const $ADOENUM_adUnsignedInt = 19•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adUnsignedInt = 19
$__iLineNumber=145 & ' - Global Const $ADOENUM_adUnsignedSmallInt = 18•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adUnsignedSmallInt = 18
$__iLineNumber=146 & ' - Global Const $ADOENUM_adUnsignedTinyInt = 17•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adUnsignedTinyInt = 17
$__iLineNumber=147 & ' - Global Const $ADOENUM_adUserDefined = 132•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adUserDefined = 132
$__iLineNumber=148 & ' - Global Const $ADOENUM_adVarBinary = 204•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adVarBinary = 204
$__iLineNumber=149 & ' - Global Const $ADOENUM_adVarChar = 200•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adVarChar = 200
$__iLineNumber=150 & ' - Global Const $ADOENUM_adVariant = 12•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adVariant = 12
$__iLineNumber=151 & ' - Global Const $ADOENUM_adVarNumeric = 139•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adVarNumeric = 139
$__iLineNumber=152 & ' - Global Const $ADOENUM_adVarWChar = 202•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adVarWChar = 202
$__iLineNumber=153 & ' - Global Const $ADOENUM_adWChar = 130•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adWChar = 130

; EditModeEnum
$__iLineNumber=156 & ' - Global Const $ADOENUM_adEditNone = 0•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adEditNone = 0
$__iLineNumber=157 & ' - Global Const $ADOENUM_adEditInProgress = 1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adEditInProgress = 1
$__iLineNumber=158 & ' - Global Const $ADOENUM_adEditAdd = 2•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adEditAdd = 2
$__iLineNumber=159 & ' - Global Const $ADOENUM_adEditDelete = 4•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adEditDelete = 4

; ErrorValueEnum ; https://msdn.microsoft.com/en-us/library/windows/desktop/ms681549(v=vs.85).aspx

#CS
	$__iLineNumber=164 & ' - Global Const $ADOENUM_adErrBoundToCommand = 3707•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrBoundToCommand = 3707
	$__iLineNumber=165 & ' - Global Const $ADOENUM_adErrCannotComplete = 3732•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrCannotComplete = 3732
	$__iLineNumber=166 & ' - Global Const $ADOENUM_adErrCantChangeConnection = 3748•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrCantChangeConnection = 3748
	$__iLineNumber=167 & ' - Global Const $ADOENUM_adErrCantChangeProvider = 3220•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrCantChangeProvider = 3220
	$__iLineNumber=168 & ' - Global Const $ADOENUM_adErrCantConvertvalue = 3724•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrCantConvertvalue = 3724
	$__iLineNumber=169 & ' - Global Const $ADOENUM_adErrCantCreate = 3725•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrCantCreate = 3725
	$__iLineNumber=170 & ' - Global Const $ADOENUM_adErrCatalogNotSet = 3747•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrCatalogNotSet = 3747
	$__iLineNumber=171 & ' - Global Const $ADOENUM_adErrColumnNotOnThisRow = 3726•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrColumnNotOnThisRow = 3726
	$__iLineNumber=172 & ' - Global Const $ADOENUM_adErrDataConversion = 3421•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrDataConversion = 3421
	$__iLineNumber=173 & ' - Global Const $ADOENUM_adErrDataOverflow = 3721•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrDataOverflow = 3721
	$__iLineNumber=174 & ' - Global Const $ADOENUM_adErrDelResOutOfScope = 3738•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrDelResOutOfScope = 3738
	$__iLineNumber=175 & ' - Global Const $ADOENUM_adErrDenyNotSupported = 3750•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrDenyNotSupported = 3750
	$__iLineNumber=176 & ' - Global Const $ADOENUM_adErrDenyTypeNotSupported = 3751•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrDenyTypeNotSupported = 3751
	$__iLineNumber=177 & ' - Global Const $ADOENUM_adErrFeatureNotAvailable = 3251•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrFeatureNotAvailable = 3251
	$__iLineNumber=178 & ' - Global Const $ADOENUM_adErrFieldsUpdateFailed = 3749•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrFieldsUpdateFailed = 3749
	$__iLineNumber=179 & ' - Global Const $ADOENUM_adErrIllegalOperation = 3219•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrIllegalOperation = 3219
	$__iLineNumber=180 & ' - Global Const $ADOENUM_adErrIntegrityViolation = 3719•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrIntegrityViolation = 3719
	$__iLineNumber=181 & ' - Global Const $ADOENUM_adErrInTransaction = 3246•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrInTransaction = 3246
	$__iLineNumber=182 & ' - Global Const $ADOENUM_adErrInvalidArgument = 3001•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrInvalidArgument = 3001
	$__iLineNumber=183 & ' - Global Const $ADOENUM_adErrInvalidConnection = 3709•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrInvalidConnection = 3709
	$__iLineNumber=184 & ' - Global Const $ADOENUM_adErrInvalidParamInfo = 3708•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrInvalidParamInfo = 3708
	$__iLineNumber=185 & ' - Global Const $ADOENUM_adErrInvalidTransaction = 3714•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrInvalidTransaction = 3714
	$__iLineNumber=186 & ' - Global Const $ADOENUM_adErrInvalidURL = 3729•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrInvalidURL = 3729
	$__iLineNumber=187 & ' - Global Const $ADOENUM_adErrItemNotFound = 3265•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrItemNotFound = 3265
	$__iLineNumber=188 & ' - Global Const $ADOENUM_adErrNoCurrentRecord = 3021•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrNoCurrentRecord = 3021
	$__iLineNumber=189 & ' - Global Const $ADOENUM_adErrNotExecuting = 3715•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrNotExecuting = 3715
	$__iLineNumber=190 & ' - Global Const $ADOENUM_adErrNotReentrant = 3710•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrNotReentrant = 3710
	$__iLineNumber=191 & ' - Global Const $ADOENUM_adErrObjectClosed = 3704•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrObjectClosed = 3704
	$__iLineNumber=192 & ' - Global Const $ADOENUM_adErrObjectInCollection = 3367•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrObjectInCollection = 3367
	$__iLineNumber=193 & ' - Global Const $ADOENUM_adErrObjectNotSet = 3420•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrObjectNotSet = 3420
	$__iLineNumber=194 & ' - Global Const $ADOENUM_adErrObjectOpen = 3705•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrObjectOpen = 3705
	$__iLineNumber=195 & ' - Global Const $ADOENUM_adErrOpeningFile = 3002•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrOpeningFile = 3002
	$__iLineNumber=196 & ' - Global Const $ADOENUM_adErrOperationCancelled = 3712•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrOperationCancelled = 3712
	$__iLineNumber=197 & ' - Global Const $ADOENUM_adErrOutOfSpace = 3734•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrOutOfSpace = 3734
	$__iLineNumber=198 & ' - Global Const $ADOENUM_adErrPermissionDenied = 3720•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrPermissionDenied = 3720
	$__iLineNumber=199 & ' - Global Const $ADOENUM_adErrProviderFailed = 3000•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrProviderFailed = 3000
	$__iLineNumber=200 & ' - Global Const $ADOENUM_adErrProviderNotFound = 3706•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrProviderNotFound = 3706
	$__iLineNumber=201 & ' - Global Const $ADOENUM_adErrReadFile = 3003•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrReadFile = 3003
	$__iLineNumber=202 & ' - Global Const $ADOENUM_adErrResourceExists = 3731•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrResourceExists = 3731
	$__iLineNumber=203 & ' - Global Const $ADOENUM_adErrResourceLocked = 3730•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrResourceLocked = 3730
	$__iLineNumber=204 & ' - Global Const $ADOENUM_adErrResourceOutOfScope = 3735•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrResourceOutOfScope = 3735
	$__iLineNumber=205 & ' - Global Const $ADOENUM_adErrSchemaViolation = 3722•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrSchemaViolation = 3722
	$__iLineNumber=206 & ' - Global Const $ADOENUM_adErrSignMismatch = 3723•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrSignMismatch = 3723
	$__iLineNumber=207 & ' - Global Const $ADOENUM_adErrStillConnecting = 3713•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrStillConnecting = 3713
	$__iLineNumber=208 & ' - Global Const $ADOENUM_adErrStillExecuting = 3711•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrStillExecuting = 3711
	$__iLineNumber=209 & ' - Global Const $ADOENUM_adErrTreePermissionDenied = 3728•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrTreePermissionDenied = 3728
	$__iLineNumber=210 & ' - Global Const $ADOENUM_adErrUnavailable = 3736•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrUnavailable = 3736
	$__iLineNumber=211 & ' - Global Const $ADOENUM_adErrUnsafeOperation = 3716•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrUnsafeOperation = 3716
	$__iLineNumber=212 & ' - Global Const $ADOENUM_adErrURLDoesNotExist = 3727•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrURLDoesNotExist = 3727
	$__iLineNumber=213 & ' - Global Const $ADOENUM_adErrURLNamedRowDoesNotExist = 3737•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrURLNamedRowDoesNotExist = 3737
	$__iLineNumber=214 & ' - Global Const $ADOENUM_adErrVolumeNotFound = 3733•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrVolumeNotFound = 3733
	$__iLineNumber=215 & ' - Global Const $ADOENUM_adErrWriteFile = 3004•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adErrWriteFile = 3004
	$__iLineNumber=216 & ' - Global Const $ADOENUM_adWrnSecurityDialog = 3717•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adWrnSecurityDialog = 3717
	$__iLineNumber=217 & ' - Global Const $ADOENUM_adWrnSecurityDialogHeader = 3718•ADO_CONSTANTS.au3'
	Global Const $ADOENUM_adWrnSecurityDialogHeader = 3718
#CE
$__iLineNumber=219 & ' - Global Const $ADOENUM_adErrProviderFailed = 3000•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrProviderFailed = 3000
$__iLineNumber=220 & ' - Global Const $ADOENUM_adErrInvalidArgument = 3001•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrInvalidArgument = 3001
$__iLineNumber=221 & ' - Global Const $ADOENUM_adErrOpeningFile = 3002•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrOpeningFile = 3002
$__iLineNumber=222 & ' - Global Const $ADOENUM_adErrReadFile = 3003•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrReadFile = 3003
$__iLineNumber=223 & ' - Global Const $ADOENUM_adErrWriteFile = 3004•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrWriteFile = 3004
$__iLineNumber=224 & ' - Global Const $ADOENUM_adErrNoCurrentRecord = 3021•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrNoCurrentRecord = 3021
$__iLineNumber=225 & ' - Global Const $ADOENUM_adErrCantChangeProvider = 3220•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrCantChangeProvider = 3220
$__iLineNumber=226 & ' - Global Const $ADOENUM_adErrInTransaction = 3246•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrInTransaction = 3246
$__iLineNumber=227 & ' - Global Const $ADOENUM_adErrFeatureNotAvailable = 3251•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrFeatureNotAvailable = 3251
$__iLineNumber=228 & ' - Global Const $ADOENUM_adErrItemNotFound = 3265•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrItemNotFound = 3265
$__iLineNumber=229 & ' - Global Const $ADOENUM_adErrObjectInCollection = 3367•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrObjectInCollection = 3367
$__iLineNumber=230 & ' - Global Const $ADOENUM_adErrObjectNotSet = 3420•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrObjectNotSet = 3420
$__iLineNumber=231 & ' - Global Const $ADOENUM_adErrDataConversion = 3421•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrDataConversion = 3421
$__iLineNumber=232 & ' - Global Const $ADOENUM_adErrObjectClosed = 3704•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrObjectClosed = 3704
$__iLineNumber=233 & ' - Global Const $ADOENUM_adErrObjectOpen = 3705•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrObjectOpen = 3705
$__iLineNumber=234 & ' - Global Const $ADOENUM_adErrProviderNotFound = 3706•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrProviderNotFound = 3706
$__iLineNumber=235 & ' - Global Const $ADOENUM_adErrInvalidParamInfo = 3708•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrInvalidParamInfo = 3708
$__iLineNumber=236 & ' - Global Const $ADOENUM_adErrInvalidConnection = 3709•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrInvalidConnection = 3709
$__iLineNumber=237 & ' - Global Const $ADOENUM_adErrNotReentrant = 3710•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrNotReentrant = 3710
$__iLineNumber=238 & ' - Global Const $ADOENUM_adErrStillExecuting = 3711•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrStillExecuting = 3711
$__iLineNumber=239 & ' - Global Const $ADOENUM_adErrOperationCancelled = 3712•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrOperationCancelled = 3712
$__iLineNumber=240 & ' - Global Const $ADOENUM_adErrStillConnecting = 3713•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrStillConnecting = 3713
$__iLineNumber=241 & ' - Global Const $ADOENUM_adErrInvalidTransaction = 3714•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrInvalidTransaction = 3714
$__iLineNumber=242 & ' - Global Const $ADOENUM_adErrNotExecuting = 3715•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrNotExecuting = 3715
$__iLineNumber=243 & ' - Global Const $ADOENUM_adErrUnsafeOperation = 3716•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrUnsafeOperation = 3716
$__iLineNumber=244 & ' - Global Const $ADOENUM_adWrnSecurityDialog = 3717•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adWrnSecurityDialog = 3717
$__iLineNumber=245 & ' - Global Const $ADOENUM_adWrnSecurityDialogHeader = 3718•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adWrnSecurityDialogHeader = 3718
$__iLineNumber=246 & ' - Global Const $ADOENUM_adErrIntegrityViolation = 3719•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrIntegrityViolation = 3719
$__iLineNumber=247 & ' - Global Const $ADOENUM_adErrPermissionDenied = 3720•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrPermissionDenied = 3720
$__iLineNumber=248 & ' - Global Const $ADOENUM_adErrDataOverflow = 3721•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrDataOverflow = 3721
$__iLineNumber=249 & ' - Global Const $ADOENUM_adErrSchemaViolation = 3722•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrSchemaViolation = 3722
$__iLineNumber=250 & ' - Global Const $ADOENUM_adErrSignMismatch = 3723•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrSignMismatch = 3723
$__iLineNumber=251 & ' - Global Const $ADOENUM_adErrCantConvertvalue = 3724•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrCantConvertvalue = 3724
$__iLineNumber=252 & ' - Global Const $ADOENUM_adErrCantCreate = 3725•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrCantCreate = 3725
$__iLineNumber=253 & ' - Global Const $ADOENUM_adErrColumnNotOnThisRow = 3726•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrColumnNotOnThisRow = 3726
$__iLineNumber=254 & ' - Global Const $ADOENUM_adErrURLDoesNotExist = 3727•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrURLDoesNotExist = 3727
$__iLineNumber=255 & ' - Global Const $ADOENUM_adErrTreePermissionDenied = 3728•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrTreePermissionDenied = 3728
$__iLineNumber=256 & ' - Global Const $ADOENUM_adErrInvalidURL = 3729•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrInvalidURL = 3729
$__iLineNumber=257 & ' - Global Const $ADOENUM_adErrResourceLocked = 3730•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrResourceLocked = 3730
$__iLineNumber=258 & ' - Global Const $ADOENUM_adErrResourceExists = 3731•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrResourceExists = 3731
$__iLineNumber=259 & ' - Global Const $ADOENUM_adErrCannotComplete = 3732•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrCannotComplete = 3732
$__iLineNumber=260 & ' - Global Const $ADOENUM_adErrVolumeNotFound = 3733•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrVolumeNotFound = 3733
$__iLineNumber=261 & ' - Global Const $ADOENUM_adErrOutOfSpace = 3734•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrOutOfSpace = 3734
$__iLineNumber=262 & ' - Global Const $ADOENUM_adErrResourceOutOfScope = 3735•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrResourceOutOfScope = 3735
$__iLineNumber=263 & ' - Global Const $ADOENUM_adErrUnavailable = 3736•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrUnavailable = 3736
$__iLineNumber=264 & ' - Global Const $ADOENUM_adErrURLNamedRowDoesNotExist = 3737•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrURLNamedRowDoesNotExist = 3737
$__iLineNumber=265 & ' - Global Const $ADOENUM_adErrDelResOutOfScope = 3738•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrDelResOutOfScope = 3738
$__iLineNumber=266 & ' - Global Const $ADOENUM_adErrCatalogNotSet = 3747•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrCatalogNotSet = 3747
$__iLineNumber=267 & ' - Global Const $ADOENUM_adErrCantChangeConnection = 3748•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrCantChangeConnection = 3748
$__iLineNumber=268 & ' - Global Const $ADOENUM_adErrFieldsUpdateFailed = 3749•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrFieldsUpdateFailed = 3749
$__iLineNumber=269 & ' - Global Const $ADOENUM_adErrDenyTypeNotSupported = 3751•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adErrDenyTypeNotSupported = 3751

; EventReasonEnum
$__iLineNumber=272 & ' - Global Const $ADOENUM_adRsnAddNew = 1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adRsnAddNew = 1
$__iLineNumber=273 & ' - Global Const $ADOENUM_adRsnDelete = 2•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adRsnDelete = 2
$__iLineNumber=274 & ' - Global Const $ADOENUM_adRsnUpdate = 3•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adRsnUpdate = 3
$__iLineNumber=275 & ' - Global Const $ADOENUM_adRsnUndoUpdate = 4•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adRsnUndoUpdate = 4
$__iLineNumber=276 & ' - Global Const $ADOENUM_adRsnUndoAddNew = 5•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adRsnUndoAddNew = 5
$__iLineNumber=277 & ' - Global Const $ADOENUM_adRsnUndoDelete = 6•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adRsnUndoDelete = 6
$__iLineNumber=278 & ' - Global Const $ADOENUM_adRsnRequery = 7•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adRsnRequery = 7
$__iLineNumber=279 & ' - Global Const $ADOENUM_adRsnResynch = 8•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adRsnResynch = 8
$__iLineNumber=280 & ' - Global Const $ADOENUM_adRsnClose = 9•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adRsnClose = 9
$__iLineNumber=281 & ' - Global Const $ADOENUM_adRsnMove = 10•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adRsnMove = 10
$__iLineNumber=282 & ' - Global Const $ADOENUM_adRsnFirstChange = 11•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adRsnFirstChange = 11
$__iLineNumber=283 & ' - Global Const $ADOENUM_adRsnMoveFirst = 12•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adRsnMoveFirst = 12
$__iLineNumber=284 & ' - Global Const $ADOENUM_adRsnMoveNext = 13•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adRsnMoveNext = 13
$__iLineNumber=285 & ' - Global Const $ADOENUM_adRsnMovePrevious = 14•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adRsnMovePrevious = 14
$__iLineNumber=286 & ' - Global Const $ADOENUM_adRsnMoveLast = 15•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adRsnMoveLast = 15

; EventStatusEnum
$__iLineNumber=289 & ' - Global Const $ADOENUM_adStatusOK = 1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adStatusOK = 1
$__iLineNumber=290 & ' - Global Const $ADOENUM_adStatusErrorsOccurred = 2•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adStatusErrorsOccurred = 2
$__iLineNumber=291 & ' - Global Const $ADOENUM_adStatusCantDeny = 3•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adStatusCantDeny = 3
$__iLineNumber=292 & ' - Global Const $ADOENUM_adStatusCancel = 4•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adStatusCancel = 4
$__iLineNumber=293 & ' - Global Const $ADOENUM_adStatusUnwantedEvent = 5•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adStatusUnwantedEvent = 5

; ExecuteOptionEnum
$__iLineNumber=296 & ' - Global Const $ADOENUM_adAsyncExecute = 0x10•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adAsyncExecute = 0x10
$__iLineNumber=297 & ' - Global Const $ADOENUM_adAsyncFetch = 0x20•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adAsyncFetch = 0x20
$__iLineNumber=298 & ' - Global Const $ADOENUM_adAsyncFetchNonBlocking = 0x40•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adAsyncFetchNonBlocking = 0x40
$__iLineNumber=299 & ' - Global Const $ADOENUM_adExecuteNoRecords = 0x80•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adExecuteNoRecords = 0x80
$__iLineNumber=300 & ' - Global Const $ADOENUM_adExecuteStream = 0x400•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adExecuteStream = 0x400
$__iLineNumber=301 & ' - Global Const $ADOENUM_adExecuteRecord = 2048•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adExecuteRecord = 2048
$__iLineNumber=302 & ' - Global Const $ADOENUM_adOptionUnspecified = -1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adOptionUnspecified = -1

; FieldEnum
$__iLineNumber=305 & ' - Global Const $ADOENUM_adDefaultStream = -1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adDefaultStream = -1
$__iLineNumber=306 & ' - Global Const $ADOENUM_adRecordURL = -2•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adRecordURL = -2

; FieldAttributeEnum
$__iLineNumber=309 & ' - Global Const $ADOENUM_adFldCacheDeferred = 0x1000•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFldCacheDeferred = 0x1000
$__iLineNumber=310 & ' - Global Const $ADOENUM_adFldFixed = 0x10•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFldFixed = 0x10
$__iLineNumber=311 & ' - Global Const $ADOENUM_adFldIsChapter = 0x2000•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFldIsChapter = 0x2000
$__iLineNumber=312 & ' - Global Const $ADOENUM_adFldIsCollection = 0x40000•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFldIsCollection = 0x40000
$__iLineNumber=313 & ' - Global Const $ADOENUM_adFldKeyColumn = 0x8000•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFldKeyColumn = 0x8000
$__iLineNumber=314 & ' - Global Const $ADOENUM_adFldIsDefaultStream = 0x20000•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFldIsDefaultStream = 0x20000
$__iLineNumber=315 & ' - Global Const $ADOENUM_adFldIsNullable = 0x20•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFldIsNullable = 0x20
$__iLineNumber=316 & ' - Global Const $ADOENUM_adFldIsRowURL = 0x10000•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFldIsRowURL = 0x10000
$__iLineNumber=317 & ' - Global Const $ADOENUM_adFldLong = 0x80•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFldLong = 0x80
$__iLineNumber=318 & ' - Global Const $ADOENUM_adFldMayBeNull = 0x40•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFldMayBeNull = 0x40
$__iLineNumber=319 & ' - Global Const $ADOENUM_adFldMayDefer = 0x2•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFldMayDefer = 0x2
$__iLineNumber=320 & ' - Global Const $ADOENUM_adFldNegativeScalem = 0x4000•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFldNegativeScalem = 0x4000
$__iLineNumber=321 & ' - Global Const $ADOENUM_adFldRowID = 0x100•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFldRowID = 0x100
$__iLineNumber=322 & ' - Global Const $ADOENUM_adFldRowVersion = 0x200•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFldRowVersion = 0x200
$__iLineNumber=323 & ' - Global Const $ADOENUM_adFldUnknownUpdatable = 0x8•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFldUnknownUpdatable = 0x8
$__iLineNumber=324 & ' - Global Const $ADOENUM_adFldUnspecified = -1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFldUnspecified = -1
$__iLineNumber=325 & ' - Global Const $ADOENUM_adFldUpdatable = 0x4•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFldUpdatable = 0x4

; FieldStatusEnum
$__iLineNumber=328 & ' - Global Const $ADOENUM_adFieldOK = 0•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFieldOK = 0
$__iLineNumber=329 & ' - Global Const $ADOENUM_adFieldCantConvertValue = 2•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFieldCantConvertValue = 2
$__iLineNumber=330 & ' - Global Const $ADOENUM_adFieldIsNull = 3•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFieldIsNull = 3
$__iLineNumber=331 & ' - Global Const $ADOENUM_adFieldTruncated = 4•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFieldTruncated = 4
$__iLineNumber=332 & ' - Global Const $ADOENUM_adFieldSignMismatch = 5•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFieldSignMismatch = 5
$__iLineNumber=333 & ' - Global Const $ADOENUM_adFieldDataOverflow = 6•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFieldDataOverflow = 6
$__iLineNumber=334 & ' - Global Const $ADOENUM_adFieldCantCreate = 7•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFieldCantCreate = 7
$__iLineNumber=335 & ' - Global Const $ADOENUM_adFieldUnavailable = 8•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFieldUnavailable = 8
$__iLineNumber=336 & ' - Global Const $ADOENUM_adFieldIntegrityViolation = 10•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFieldIntegrityViolation = 10
$__iLineNumber=337 & ' - Global Const $ADOENUM_adFieldSchemaViolation = 11•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFieldSchemaViolation = 11
$__iLineNumber=338 & ' - Global Const $ADOENUM_adFieldBadStatus = 12•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFieldBadStatus = 12
$__iLineNumber=339 & ' - Global Const $ADOENUM_adFieldDefault = 13•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFieldDefault = 13
$__iLineNumber=340 & ' - Global Const $ADOENUM_adFieldIgnore = 15•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFieldIgnore = 15
$__iLineNumber=341 & ' - Global Const $ADOENUM_adFieldDoesNotExist = 16•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFieldDoesNotExist = 16
$__iLineNumber=342 & ' - Global Const $ADOENUM_adFieldInvalidURL = 17•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFieldInvalidURL = 17
$__iLineNumber=343 & ' - Global Const $ADOENUM_adFieldResourceLocked = 18•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFieldResourceLocked = 18
$__iLineNumber=344 & ' - Global Const $ADOENUM_adFieldResourceExists = 19•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFieldResourceExists = 19
$__iLineNumber=345 & ' - Global Const $ADOENUM_adFieldCannotComplete = 20•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFieldCannotComplete = 20
$__iLineNumber=346 & ' - Global Const $ADOENUM_adFieldVolumeNotFound = 21•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFieldVolumeNotFound = 21
$__iLineNumber=347 & ' - Global Const $ADOENUM_adFieldOutOfSpace = 22•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFieldOutOfSpace = 22
$__iLineNumber=348 & ' - Global Const $ADOENUM_adFieldCannotDeleteSource = 23•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFieldCannotDeleteSource = 23
$__iLineNumber=349 & ' - Global Const $ADOENUM_adFieldResourceOutOfScope = 25•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFieldResourceOutOfScope = 25
$__iLineNumber=350 & ' - Global Const $ADOENUM_adFieldAlreadyExists = 26•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFieldAlreadyExists = 26
$__iLineNumber=351 & ' - Global Const $ADOENUM_adFieldPendingChange = 0x40000•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFieldPendingChange = 0x40000
$__iLineNumber=352 & ' - Global Const $ADOENUM_adFieldPendingDelete = 0x20000•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFieldPendingDelete = 0x20000
$__iLineNumber=353 & ' - Global Const $ADOENUM_adFieldPendingInsert = 0x10000•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFieldPendingInsert = 0x10000
$__iLineNumber=354 & ' - Global Const $ADOENUM_adFieldPendingUnknown = 0x80000•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFieldPendingUnknown = 0x80000
$__iLineNumber=355 & ' - Global Const $ADOENUM_adFieldPendingUnknownDelete = 0x100000•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFieldPendingUnknownDelete = 0x100000
$__iLineNumber=356 & ' - Global Const $ADOENUM_adFieldPermissionDenied = 0x9•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFieldPermissionDenied = 0x9
$__iLineNumber=357 & ' - Global Const $ADOENUM_adFieldReadOnly = 0x24•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFieldReadOnly = 0x24

; FilterGroupEnum
$__iLineNumber=360 & ' - Global Const $ADOENUM_adFilterNone = 0•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFilterNone = 0
$__iLineNumber=361 & ' - Global Const $ADOENUM_adFilterPendingRecords = 1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFilterPendingRecords = 1
$__iLineNumber=362 & ' - Global Const $ADOENUM_adFilterAffectedRecords = 2•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFilterAffectedRecords = 2
$__iLineNumber=363 & ' - Global Const $ADOENUM_adFilterFetchedRecords = 3•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFilterFetchedRecords = 3
$__iLineNumber=364 & ' - Global Const $ADOENUM_adFilterConflictingRecords = 5•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFilterConflictingRecords = 5

; GetRowsOptionEnum
$__iLineNumber=367 & ' - Global Const $ADOENUM_adGetRowsRest = -1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adGetRowsRest = -1

; IsolationLevelEnum
$__iLineNumber=370 & ' - Global Const $ADOENUM_adXactUnspecified = -1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adXactUnspecified = -1
$__iLineNumber=371 & ' - Global Const $ADOENUM_adXactChaos = 16•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adXactChaos = 16
$__iLineNumber=372 & ' - Global Const $ADOENUM_adXactBrowse = 256•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adXactBrowse = 256
$__iLineNumber=373 & ' - Global Const $ADOENUM_adXactReadUncommitted = 256•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adXactReadUncommitted = 256
$__iLineNumber=374 & ' - Global Const $ADOENUM_adXactCursorStability = 4096•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adXactCursorStability = 4096
$__iLineNumber=375 & ' - Global Const $ADOENUM_adXactReadCommitted = 4096•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adXactReadCommitted = 4096
$__iLineNumber=376 & ' - Global Const $ADOENUM_adXactRepeatableRead = 65536•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adXactRepeatableRead = 65536
$__iLineNumber=377 & ' - Global Const $ADOENUM_adXactIsolated = 1048576•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adXactIsolated = 1048576
$__iLineNumber=378 & ' - Global Const $ADOENUM_adXactSerializable = 1048576•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adXactSerializable = 1048576

; LineSeparatorsEnum
$__iLineNumber=381 & ' - Global Const $ADOENUM_adCRLF = -1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adCRLF = -1
$__iLineNumber=382 & ' - Global Const $ADOENUM_adLF = 10•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adLF = 10
$__iLineNumber=383 & ' - Global Const $ADOENUM_adCR = 13•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adCR = 13

; LockTypeEnum
$__iLineNumber=386 & ' - Global Const $ADOENUM_adLockUnspecified = -1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adLockUnspecified = -1
$__iLineNumber=387 & ' - Global Const $ADOENUM_adLockReadOnly = 1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adLockReadOnly = 1
$__iLineNumber=388 & ' - Global Const $ADOENUM_adLockPessimistic = 2•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adLockPessimistic = 2
$__iLineNumber=389 & ' - Global Const $ADOENUM_adLockOptimistic = 3•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adLockOptimistic = 3
$__iLineNumber=390 & ' - Global Const $ADOENUM_adLockBatchOptimistic = 4•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adLockBatchOptimistic = 4

; MarshalOptionsEnum
$__iLineNumber=393 & ' - Global Const $ADOENUM_adMarshalAll = 0•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adMarshalAll = 0
$__iLineNumber=394 & ' - Global Const $ADOENUM_adMarshalModifiedOnly = 1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adMarshalModifiedOnly = 1

; MoveRecordOptionsEnum
$__iLineNumber=397 & ' - Global Const $ADOENUM_adMoveUnspecified = -1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adMoveUnspecified = -1
$__iLineNumber=398 & ' - Global Const $ADOENUM_adMoveOverWrite = 1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adMoveOverWrite = 1
$__iLineNumber=399 & ' - Global Const $ADOENUM_adMoveDontUpdateLinks = 2•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adMoveDontUpdateLinks = 2
$__iLineNumber=400 & ' - Global Const $ADOENUM_adMoveAllowEmulation = 4•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adMoveAllowEmulation = 4

;~ ObjectStateEnum
;~ https://msdn.microsoft.com/en-us/library/windows/desktop/ms675546(v=vs.85).aspx
$__iLineNumber=404 & ' - Global Const $ADOENUM_adStateClosed = 0 ;   The object is cl ...•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adStateClosed = 0 ;   The object is closed
$__iLineNumber=405 & ' - Global Const $ADOENUM_adStateOpen = 1 ;   The object is open•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adStateOpen = 1 ;   The object is open
$__iLineNumber=406 & ' - Global Const $ADOENUM_adStateConnecting = 2 ;   The object i ...•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adStateConnecting = 2 ;   The object is connecting
$__iLineNumber=407 & ' - Global Const $ADOENUM_adStateExecuting = 4 ;   The object is ...•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adStateExecuting = 4 ;   The object is executing a command
$__iLineNumber=408 & ' - Global Const $ADOENUM_adStateFetching = 8 ;   The rows of th ...•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adStateFetching = 8 ;   The rows of the object are being retrieved

; ParameterAttributesEnum
$__iLineNumber=411 & ' - Global Const $ADOENUM_adParamSigned = 16•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adParamSigned = 16
$__iLineNumber=412 & ' - Global Const $ADOENUM_adParamNullable = 64•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adParamNullable = 64
$__iLineNumber=413 & ' - Global Const $ADOENUM_adParamLong = 128•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adParamLong = 128

; ParameterDirectionEnum
$__iLineNumber=416 & ' - Global Const $ADOENUM_adParamUnknown = 0•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adParamUnknown = 0
$__iLineNumber=417 & ' - Global Const $ADOENUM_adParamInput = 1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adParamInput = 1
$__iLineNumber=418 & ' - Global Const $ADOENUM_adParamOutput = 2•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adParamOutput = 2
$__iLineNumber=419 & ' - Global Const $ADOENUM_adParamInputOutput = 3•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adParamInputOutput = 3
$__iLineNumber=420 & ' - Global Const $ADOENUM_adParamReturnValue = 4•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adParamReturnValue = 4

; PersistFormatEnum
$__iLineNumber=423 & ' - Global Const $ADOENUM_adPersistADTG = 0•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adPersistADTG = 0
;!!!!
$__iLineNumber=425 & ' - Global Const $ADOENUM_adPersistADO = 1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adPersistADO = 1
;!!!!
$__iLineNumber=427 & ' - Global Const $ADOENUM_adPersistXML = 1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adPersistXML = 1
$__iLineNumber=428 & ' - Global Const $ADOENUM_adPersistProviderSpecific = 2•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adPersistProviderSpecific = 2

; PositionEnum
$__iLineNumber=431 & ' - Global Const $ADOENUM_adPosEOF = -3•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adPosEOF = -3
$__iLineNumber=432 & ' - Global Const $ADOENUM_adPosBOF = -2•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adPosBOF = -2
$__iLineNumber=433 & ' - Global Const $ADOENUM_adPosUnknown = -1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adPosUnknown = -1

; PropertyAttributesEnum
$__iLineNumber=436 & ' - Global Const $ADOENUM_adPropNotSupported = 0•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adPropNotSupported = 0
$__iLineNumber=437 & ' - Global Const $ADOENUM_adPropRequired = 1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adPropRequired = 1
$__iLineNumber=438 & ' - Global Const $ADOENUM_adPropOptional = 2•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adPropOptional = 2
$__iLineNumber=439 & ' - Global Const $ADOENUM_adPropRead = 512•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adPropRead = 512
$__iLineNumber=440 & ' - Global Const $ADOENUM_adPropWrite = 1024•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adPropWrite = 1024

; RecordCreateOptionsEnum
$__iLineNumber=443 & ' - Global Const $ADOENUM_adFailIfNotExists = -1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adFailIfNotExists = -1
$__iLineNumber=444 & ' - Global Const $ADOENUM_adCreateNonCollection = 0•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adCreateNonCollection = 0
$__iLineNumber=445 & ' - Global Const $ADOENUM_adCreateCollection = 0x2000•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adCreateCollection = 0x2000
$__iLineNumber=446 & ' - Global Const $ADOENUM_adCreateOverwrite = 0x4000000•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adCreateOverwrite = 0x4000000
$__iLineNumber=447 & ' - Global Const $ADOENUM_adCreateStructDoc = 0x80000000•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adCreateStructDoc = 0x80000000
$__iLineNumber=448 & ' - Global Const $ADOENUM_adOpenIfExists = 0x2000000•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adOpenIfExists = 0x2000000

; RecordOpenOptionsEnum
$__iLineNumber=451 & ' - Global Const $ADOENUM_adDelayFetchFields = 0x8000•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adDelayFetchFields = 0x8000
$__iLineNumber=452 & ' - Global Const $ADOENUM_adDelayFetchStream = 0x4000•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adDelayFetchStream = 0x4000
$__iLineNumber=453 & ' - Global Const $ADOENUM_adOpenAsync = 0x1000•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adOpenAsync = 0x1000
$__iLineNumber=454 & ' - Global Const $ADOENUM_adOpenExecuteCommand = 0x10000•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adOpenExecuteCommand = 0x10000
$__iLineNumber=455 & ' - Global Const $ADOENUM_adOpenRecordUnspecified = -1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adOpenRecordUnspecified = -1
$__iLineNumber=456 & ' - Global Const $ADOENUM_adOpenOutput = 0x800000•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adOpenOutput = 0x800000

; RecordStatusEnum
$__iLineNumber=459 & ' - Global Const $ADOENUM_adRecCanceled = 0x100•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adRecCanceled = 0x100
$__iLineNumber=460 & ' - Global Const $ADOENUM_adRecCantRelease = 0x400•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adRecCantRelease = 0x400
$__iLineNumber=461 & ' - Global Const $ADOENUM_adRecConcurrencyViolation = 0x800•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adRecConcurrencyViolation = 0x800
$__iLineNumber=462 & ' - Global Const $ADOENUM_adRecDBDeleted = 0x40000•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adRecDBDeleted = 0x40000
$__iLineNumber=463 & ' - Global Const $ADOENUM_adRecDeleted = 0x4•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adRecDeleted = 0x4
$__iLineNumber=464 & ' - Global Const $ADOENUM_adRecIntegrityViolation = 0x1000•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adRecIntegrityViolation = 0x1000
$__iLineNumber=465 & ' - Global Const $ADOENUM_adRecInvalid = 0x10•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adRecInvalid = 0x10
$__iLineNumber=466 & ' - Global Const $ADOENUM_adRecMaxChangesExceeded = 0x2000•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adRecMaxChangesExceeded = 0x2000
$__iLineNumber=467 & ' - Global Const $ADOENUM_adRecModified = 0x2•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adRecModified = 0x2
$__iLineNumber=468 & ' - Global Const $ADOENUM_adRecMultipleChanges = 0x40•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adRecMultipleChanges = 0x40
$__iLineNumber=469 & ' - Global Const $ADOENUM_adRecNew = 0x1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adRecNew = 0x1
$__iLineNumber=470 & ' - Global Const $ADOENUM_adRecObjectOpen = 0x4000•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adRecObjectOpen = 0x4000
$__iLineNumber=471 & ' - Global Const $ADOENUM_adRecOK = 0•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adRecOK = 0
$__iLineNumber=472 & ' - Global Const $ADOENUM_adRecOutOfMemory = 0x8000•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adRecOutOfMemory = 0x8000
$__iLineNumber=473 & ' - Global Const $ADOENUM_adRecPendingChanges = 0x80•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adRecPendingChanges = 0x80
$__iLineNumber=474 & ' - Global Const $ADOENUM_adRecPermissionDenied = 0x10000•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adRecPermissionDenied = 0x10000
$__iLineNumber=475 & ' - Global Const $ADOENUM_adRecSchemaViolation = 0x20000•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adRecSchemaViolation = 0x20000
$__iLineNumber=476 & ' - Global Const $ADOENUM_adRecUnmodified = 0x8•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adRecUnmodified = 0x8

; RecordTypeEnum
$__iLineNumber=479 & ' - Global Const $ADOENUM_adSimpleRecord = 0•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSimpleRecord = 0
$__iLineNumber=480 & ' - Global Const $ADOENUM_adCollectionRecord = 1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adCollectionRecord = 1
$__iLineNumber=481 & ' - Global Const $ADOENUM_adRecordUnknown = -1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adRecordUnknown = -1
$__iLineNumber=482 & ' - Global Const $ADOENUM_adStructDoc = 2•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adStructDoc = 2

; ResyncEnum
$__iLineNumber=485 & ' - Global Const $ADOENUM_adResyncUnderlyingValues = 1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adResyncUnderlyingValues = 1
$__iLineNumber=486 & ' - Global Const $ADOENUM_adResyncAllValues = 2•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adResyncAllValues = 2

; SaveOptionsEnum
$__iLineNumber=489 & ' - Global Const $ADOENUM_adSaveCreateNotExist = 1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSaveCreateNotExist = 1
$__iLineNumber=490 & ' - Global Const $ADOENUM_adSaveCreateOverWrite = 2•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSaveCreateOverWrite = 2

; SchemaEnum
; https://msdn.microsoft.com/en-us/library/ms675274(v=vs.85).aspx
$__iLineNumber=494 & ' - Global Const $ADOENUM_adSchemaProviderSpecific = -1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSchemaProviderSpecific = -1
$__iLineNumber=495 & ' - Global Const $ADOENUM_adSchemaAsserts = 0•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSchemaAsserts = 0
$__iLineNumber=496 & ' - Global Const $ADOENUM_adSchemaCatalogs = 1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSchemaCatalogs = 1
$__iLineNumber=497 & ' - Global Const $ADOENUM_adSchemaCharacterSets = 2•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSchemaCharacterSets = 2
$__iLineNumber=498 & ' - Global Const $ADOENUM_adSchemaCollations = 3•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSchemaCollations = 3
$__iLineNumber=499 & ' - Global Const $ADOENUM_adSchemaCheckConstraints = 5•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSchemaCheckConstraints = 5
$__iLineNumber=500 & ' - Global Const $ADOENUM_adSchemaColumns = 4•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSchemaColumns = 4
$__iLineNumber=501 & ' - Global Const $ADOENUM_adSchemaConstraintColumnUsage = 6•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSchemaConstraintColumnUsage = 6
$__iLineNumber=502 & ' - Global Const $ADOENUM_adSchemaConstraintTableUsage = 7•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSchemaConstraintTableUsage = 7
$__iLineNumber=503 & ' - Global Const $ADOENUM_adSchemaKeyColumnUsage = 8•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSchemaKeyColumnUsage = 8
$__iLineNumber=504 & ' - Global Const $ADOENUM_adSchemaReferentialConstraints = 9•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSchemaReferentialConstraints = 9
$__iLineNumber=505 & ' - Global Const $ADOENUM_adSchemaTableConstraints = 10•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSchemaTableConstraints = 10
$__iLineNumber=506 & ' - Global Const $ADOENUM_adSchemaColumnsDomainUsage = 11•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSchemaColumnsDomainUsage = 11
$__iLineNumber=507 & ' - Global Const $ADOENUM_adSchemaIndexes = 12•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSchemaIndexes = 12
$__iLineNumber=508 & ' - Global Const $ADOENUM_adSchemaColumnPrivileges = 13•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSchemaColumnPrivileges = 13
$__iLineNumber=509 & ' - Global Const $ADOENUM_adSchemaTablePrivileges = 14•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSchemaTablePrivileges = 14
$__iLineNumber=510 & ' - Global Const $ADOENUM_adSchemaUsagePrivileges = 15•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSchemaUsagePrivileges = 15
$__iLineNumber=511 & ' - Global Const $ADOENUM_adSchemaProcedures = 16•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSchemaProcedures = 16
$__iLineNumber=512 & ' - Global Const $ADOENUM_adSchemaSchemata = 17•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSchemaSchemata = 17
$__iLineNumber=513 & ' - Global Const $ADOENUM_adSchemaSQLLanguages = 18•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSchemaSQLLanguages = 18
$__iLineNumber=514 & ' - Global Const $ADOENUM_adSchemaStatistics = 19•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSchemaStatistics = 19
$__iLineNumber=515 & ' - Global Const $ADOENUM_adSchemaTables = 20•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSchemaTables = 20
$__iLineNumber=516 & ' - Global Const $ADOENUM_adSchemaTranslations = 21•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSchemaTranslations = 21
$__iLineNumber=517 & ' - Global Const $ADOENUM_adSchemaProviderTypes = 22•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSchemaProviderTypes = 22
$__iLineNumber=518 & ' - Global Const $ADOENUM_adSchemaViews = 23•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSchemaViews = 23
$__iLineNumber=519 & ' - Global Const $ADOENUM_adSchemaViewColumnUsage = 24•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSchemaViewColumnUsage = 24
$__iLineNumber=520 & ' - Global Const $ADOENUM_adSchemaViewTableUsage = 25•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSchemaViewTableUsage = 25
$__iLineNumber=521 & ' - Global Const $ADOENUM_adSchemaProcedureParameters = 26•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSchemaProcedureParameters = 26
$__iLineNumber=522 & ' - Global Const $ADOENUM_adSchemaForeignKeys = 27•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSchemaForeignKeys = 27
$__iLineNumber=523 & ' - Global Const $ADOENUM_adSchemaPrimaryKeys = 28•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSchemaPrimaryKeys = 28
$__iLineNumber=524 & ' - Global Const $ADOENUM_adSchemaProcedureColumns = 29•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSchemaProcedureColumns = 29
$__iLineNumber=525 & ' - Global Const $ADOENUM_adSchemaDBInfoKeywords = 30•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSchemaDBInfoKeywords = 30
$__iLineNumber=526 & ' - Global Const $ADOENUM_adSchemaDBInfoLiterals = 31•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSchemaDBInfoLiterals = 31
$__iLineNumber=527 & ' - Global Const $ADOENUM_adSchemaCubes = 32•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSchemaCubes = 32
$__iLineNumber=528 & ' - Global Const $ADOENUM_adSchemaDimensions = 33•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSchemaDimensions = 33
$__iLineNumber=529 & ' - Global Const $ADOENUM_adSchemaHierarchies = 34•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSchemaHierarchies = 34
$__iLineNumber=530 & ' - Global Const $ADOENUM_adSchemaLevels = 35•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSchemaLevels = 35
$__iLineNumber=531 & ' - Global Const $ADOENUM_adSchemaMeasures = 36•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSchemaMeasures = 36
$__iLineNumber=532 & ' - Global Const $ADOENUM_adSchemaProperties = 37•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSchemaProperties = 37
$__iLineNumber=533 & ' - Global Const $ADOENUM_adSchemaMembers = 38•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSchemaMembers = 38
$__iLineNumber=534 & ' - Global Const $ADOENUM_adSchemaTrustees = 39•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSchemaTrustees = 39

; SearchDirectionEnum
; https://msdn.microsoft.com/en-us/library/ms676696(v=vs.85).aspx
$__iLineNumber=538 & ' - Global Const $ADOENUM_adSearchBackward = -1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSearchBackward = -1
$__iLineNumber=539 & ' - Global Const $ADOENUM_adSearchForward = 1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSearchForward = 1

; SeekEnum
; https://msdn.microsoft.com/en-us/library/ms681524(v=vs.85).aspx
$__iLineNumber=543 & ' - Global Const $ADOENUM_adSeekFirstEQ = 1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSeekFirstEQ = 1
$__iLineNumber=544 & ' - Global Const $ADOENUM_adSeekLastEQ = 2•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSeekLastEQ = 2
$__iLineNumber=545 & ' - Global Const $ADOENUM_adSeekAfterEQ = 4•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSeekAfterEQ = 4
$__iLineNumber=546 & ' - Global Const $ADOENUM_adSeekAfter = 8•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSeekAfter = 8
$__iLineNumber=547 & ' - Global Const $ADOENUM_adSeekBeforeEQ = 16•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSeekBeforeEQ = 16
$__iLineNumber=548 & ' - Global Const $ADOENUM_adSeekBefore = 32•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adSeekBefore = 32

; StreamOpenOptionsEnum
; https://msdn.microsoft.com/en-us/library/ms676706(v=vs.85).aspx
$__iLineNumber=552 & ' - Global Const $ADOENUM_adOpenStreamUnspecified = -1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adOpenStreamUnspecified = -1
$__iLineNumber=553 & ' - Global Const $ADOENUM_adOpenStreamAsync = 1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adOpenStreamAsync = 1
$__iLineNumber=554 & ' - Global Const $ADOENUM_adOpenStreamFromRecord = 4•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adOpenStreamFromRecord = 4

; StreamReadEnum
; https://msdn.microsoft.com/en-us/library/ms679794(v=vs.85).aspx
$__iLineNumber=558 & ' - Global Const $ADOENUM_adReadLine = -2•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adReadLine = -2
$__iLineNumber=559 & ' - Global Const $ADOENUM_adReadAll = -1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adReadAll = -1

; StreamTypeEnum
; https://msdn.microsoft.com/en-us/library/ms675277(v=vs.85).aspx
$__iLineNumber=563 & ' - Global Const $ADOENUM_adTypeBinary = 1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adTypeBinary = 1
$__iLineNumber=564 & ' - Global Const $ADOENUM_adTypeText = 2•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adTypeText = 2

; StreamWriteEnum
; https://msdn.microsoft.com/en-us/library/ms678072(v=vs.85).aspx
$__iLineNumber=568 & ' - Global Const $ADOENUM_adWriteChar = 0•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adWriteChar = 0
$__iLineNumber=569 & ' - Global Const $ADOENUM_adWriteLine = 1•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adWriteLine = 1

; StringFormatEnum
$__iLineNumber=572 & ' - Global Const $ADOENUM_adClipString = 2•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adClipString = 2

; XactAttributeEnum
$__iLineNumber=575 & ' - Global Const $ADOENUM_adXactCommitRetaining = 131072•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adXactCommitRetaining = 131072
$__iLineNumber=576 & ' - Global Const $ADOENUM_adXactAbortRetaining = 262144•ADO_CONSTANTS.au3'
Global Const $ADOENUM_adXactAbortRetaining = 262144


; #FUNCTION# ====================================================================================================================
; Name ..........: _ADO_ERROR_GetErrorInfo
; Description ...:
; Syntax ........: _ADO_ERROR_Description($iError)
; Parameters ....: $iError              - an integer value.
; Return values .: $sDescription
; Author ........: mLipok
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........: https://msdn.microsoft.com/en-us/library/windows/desktop/ms681549(v=vs.85).aspx
; Example .......: No
; ===============================================================================================================================
$__iLineNumber=592 & ' - Func _ADO_ERROR_GetErrorInfo($iError)•ADO_CONSTANTS.au3'
Func _ADO_ERROR_GetErrorInfo($iError)
	$__iLineNumber=593 & ' - Local $sDescription = ""•ADO_CONSTANTS.au3'
	Local $sDescription = ''
	$__iLineNumber=594 & ' - Switch $iError•ADO_CONSTANTS.au3'
	$__iLineNumber=595 & ' - Case $ADOENUM_adErrProviderFailed•ADO_CONSTANTS.au3'
	Switch $iError
		Case $ADOENUM_adErrProviderFailed
			$__iLineNumber=596 & ' - $sDescription = "Provider failed to perform the requested op ...•ADO_CONSTANTS.au3'
			$sDescription = "Provider failed to perform the requested operation."
		$__iLineNumber=597 & ' - Case $ADOENUM_adErrInvalidArgument•ADO_CONSTANTS.au3'
		Case $ADOENUM_adErrInvalidArgument
			$__iLineNumber=598 & ' - $sDescription = "Arguments are of the wrong type, are out of ...•ADO_CONSTANTS.au3'
			$sDescription = "Arguments are of the wrong type, are out of acceptable range, or are in conflict with one another. This error is often caused by a typographical error in an SQL SELECT statement. For example, a misspelled field name or table name can generate this error. This error can also occur when a field or table named in a SELECT statement does not exist in the data store."
		$__iLineNumber=599 & ' - Case $ADOENUM_adErrOpeningFile•ADO_CONSTANTS.au3'
		Case $ADOENUM_adErrOpeningFile
			$__iLineNumber=600 & ' - $sDescription = "File could not be opened. A misspelled file ...•ADO_CONSTANTS.au3'
			$sDescription = "File could not be opened. A misspelled file name was specified, or a file has been moved, renamed, or deleted. Over a network, the drive might be temporarily unavailable or network traffic might be preventing a connection."
		$__iLineNumber=601 & ' - Case $ADOENUM_adErrReadFile•ADO_CONSTANTS.au3'
		Case $ADOENUM_adErrReadFile
			$__iLineNumber=602 & ' - $sDescription = "File could not be read. The name of the fil ...•ADO_CONSTANTS.au3'
			$sDescription = "File could not be read. The name of the file is specified incorrectly, the file might have been moved or deleted, or the file might have become corrupted."
		$__iLineNumber=603 & ' - Case $ADOENUM_adErrWriteFile•ADO_CONSTANTS.au3'
		Case $ADOENUM_adErrWriteFile
			$__iLineNumber=604 & ' - $sDescription = "Write to file failed. You might have closed ...•ADO_CONSTANTS.au3'
			$sDescription = "Write to file failed. You might have closed a file and then tried to write to it, or the file might be corrupted. If the file is located on a network drive, transient network conditions might prevent writing to a network drive."
		$__iLineNumber=605 & ' - Case $ADOENUM_adErrNoCurrentRecord•ADO_CONSTANTS.au3'
		Case $ADOENUM_adErrNoCurrentRecord
			$__iLineNumber=606 & ' - $sDescription = "Either BOF or EOF is True, or the current r ...•ADO_CONSTANTS.au3'
			$sDescription = "Either BOF or EOF is True, or the current record has been deleted. Requested operation requires a current record. 3219	adErrIllegalOperation	Operation is not allowed in this context."
		$__iLineNumber=607 & ' - Case $ADOENUM_adErrCantChangeProvider•ADO_CONSTANTS.au3'
		Case $ADOENUM_adErrCantChangeProvider
			$__iLineNumber=608 & ' - $sDescription = "Supplied provider is different from the one ...•ADO_CONSTANTS.au3'
			$sDescription = "Supplied provider is different from the one already in use."
		$__iLineNumber=609 & ' - Case $ADOENUM_adErrInTransaction•ADO_CONSTANTS.au3'
		Case $ADOENUM_adErrInTransaction
			$__iLineNumber=610 & ' - $sDescription = "Connection object cannot be explicitly clos ...•ADO_CONSTANTS.au3'
			$sDescription = "Connection object cannot be explicitly closed while in a transaction. A Recordset or Connection object that is currently participating in a transaction cannot be closed. Call either RollbackTrans or CommitTrans before closing the object."
		$__iLineNumber=611 & ' - Case $ADOENUM_adErrFeatureNotAvailable•ADO_CONSTANTS.au3'
		Case $ADOENUM_adErrFeatureNotAvailable
			$__iLineNumber=612 & ' - $sDescription = "The object or provider is not capable of pe ...•ADO_CONSTANTS.au3'
			$sDescription = "The object or provider is not capable of performing the requested operation. Some operations depend on a particular provider version."
		$__iLineNumber=613 & ' - Case $ADOENUM_adErrItemNotFound•ADO_CONSTANTS.au3'
		Case $ADOENUM_adErrItemNotFound
			$__iLineNumber=614 & ' - $sDescription = "Item cannot be found in the collection corr ...•ADO_CONSTANTS.au3'
			$sDescription = "Item cannot be found in the collection corresponding to the requested name or ordinal. An incorrect field or table name has been specified."
		$__iLineNumber=615 & ' - Case $ADOENUM_adErrObjectInCollection•ADO_CONSTANTS.au3'
		Case $ADOENUM_adErrObjectInCollection
			$__iLineNumber=616 & ' - $sDescription = "Object is already in collection. Cannot app ...•ADO_CONSTANTS.au3'
			$sDescription = "Object is already in collection. Cannot append. An object cannot be added to the same collection twice."
		$__iLineNumber=617 & ' - Case $ADOENUM_adErrObjectNotSet•ADO_CONSTANTS.au3'
		Case $ADOENUM_adErrObjectNotSet
			$__iLineNumber=618 & ' - $sDescription = "Object is no longer valid."•ADO_CONSTANTS.au3'
			$sDescription = "Object is no longer valid."
		$__iLineNumber=619 & ' - Case $ADOENUM_adErrDataConversion•ADO_CONSTANTS.au3'
		Case $ADOENUM_adErrDataConversion
			$__iLineNumber=620 & ' - $sDescription = "Application uses a value of the wrong type  ...•ADO_CONSTANTS.au3'
			$sDescription = "Application uses a value of the wrong type for the current operation. You might have supplied a string to an operation that expects a stream, for example."
		$__iLineNumber=621 & ' - Case $ADOENUM_adErrObjectClosed•ADO_CONSTANTS.au3'
		Case $ADOENUM_adErrObjectClosed
			$__iLineNumber=622 & ' - $sDescription = "Operation is not allowed when the object is ...•ADO_CONSTANTS.au3'
			$sDescription = "Operation is not allowed when the object is closed. TheConnection or Recordset has been closed. For example, some other routine might have closed a global object. You can prevent this error by checking the State property before you attempt an operation."
		$__iLineNumber=623 & ' - Case $ADOENUM_adErrObjectOpen•ADO_CONSTANTS.au3'
		Case $ADOENUM_adErrObjectOpen
			$__iLineNumber=624 & ' - $sDescription = "Operation is not allowed when the object is ...•ADO_CONSTANTS.au3'
			$sDescription = "Operation is not allowed when the object is open. An object that is open cannot be opened. Fields cannot be appended to an open Recordset."
		$__iLineNumber=625 & ' - Case $ADOENUM_adErrProviderNotFound•ADO_CONSTANTS.au3'
		Case $ADOENUM_adErrProviderNotFound
			$__iLineNumber=626 & ' - $sDescription = "Provider cannot be found. It may not be pro ...•ADO_CONSTANTS.au3'
			$sDescription = "Provider cannot be found. It may not be properly installed. 3707	adErrBoundToCommand	The ActiveConnection property of a Recordset object, which has a Command object as its source, cannot be changed. The application attempted to assign a newConnection object to a Recordset that has a Commandobject as its source."
		$__iLineNumber=627 & ' - Case $ADOENUM_adErrInvalidParamInfo•ADO_CONSTANTS.au3'
		Case $ADOENUM_adErrInvalidParamInfo
			$__iLineNumber=628 & ' - $sDescription = "Parameter object is improperly defined. Inc ...•ADO_CONSTANTS.au3'
			$sDescription = "Parameter object is improperly defined. Inconsistent or incomplete information was provided."
		$__iLineNumber=629 & ' - Case $ADOENUM_adErrInvalidConnection•ADO_CONSTANTS.au3'
		Case $ADOENUM_adErrInvalidConnection
			$__iLineNumber=630 & ' - $sDescription = "The connection cannot be used to perform th ...•ADO_CONSTANTS.au3'
			$sDescription = "The connection cannot be used to perform this operation. It is either closed or invalid in this context."
		$__iLineNumber=631 & ' - Case $ADOENUM_adErrNotReentrant•ADO_CONSTANTS.au3'
		Case $ADOENUM_adErrNotReentrant
			$__iLineNumber=632 & ' - $sDescription = "Operation cannot be performed while process ...•ADO_CONSTANTS.au3'
			$sDescription = "Operation cannot be performed while processing event. An operation cannot be performed within an event handler that causes the event to fire again. For example, navigation methods should not be called from within aWillMove event handler."
		$__iLineNumber=633 & ' - Case $ADOENUM_adErrStillExecuting•ADO_CONSTANTS.au3'
		Case $ADOENUM_adErrStillExecuting
			$__iLineNumber=634 & ' - $sDescription = "Operation cannot be performed while executi ...•ADO_CONSTANTS.au3'
			$sDescription = "Operation cannot be performed while executing asynchronously."
		$__iLineNumber=635 & ' - Case $ADOENUM_adErrOperationCancelled•ADO_CONSTANTS.au3'
		Case $ADOENUM_adErrOperationCancelled
			$__iLineNumber=636 & ' - $sDescription = "Operation has been canceled by the user. Th ...•ADO_CONSTANTS.au3'
			$sDescription = "Operation has been canceled by the user. The application has called the CancelUpdate or CancelBatch method and the current operation has been canceled."
		$__iLineNumber=637 & ' - Case $ADOENUM_adErrStillConnecting•ADO_CONSTANTS.au3'
		Case $ADOENUM_adErrStillConnecting
			$__iLineNumber=638 & ' - $sDescription = "Operation cannot be performed while connect ...•ADO_CONSTANTS.au3'
			$sDescription = "Operation cannot be performed while connecting asynchronously."
		$__iLineNumber=639 & ' - Case $ADOENUM_adErrInvalidTransaction•ADO_CONSTANTS.au3'
		Case $ADOENUM_adErrInvalidTransaction
			$__iLineNumber=640 & ' - $sDescription = "Coordinating transaction is invalid or has  ...•ADO_CONSTANTS.au3'
			$sDescription = "Coordinating transaction is invalid or has not started."
		$__iLineNumber=641 & ' - Case $ADOENUM_adErrNotExecuting•ADO_CONSTANTS.au3'
		Case $ADOENUM_adErrNotExecuting
			$__iLineNumber=642 & ' - $sDescription = "Operation cannot be performed while not exe ...•ADO_CONSTANTS.au3'
			$sDescription = "Operation cannot be performed while not executing."
		$__iLineNumber=643 & ' - Case $ADOENUM_adErrUnsafeOperation•ADO_CONSTANTS.au3'
		Case $ADOENUM_adErrUnsafeOperation
			$__iLineNumber=644 & ' - $sDescription = "Safety settings on this computer prohibit a ...•ADO_CONSTANTS.au3'
			$sDescription = "Safety settings on this computer prohibit accessing a data source on another domain."
		$__iLineNumber=645 & ' - Case $ADOENUM_adWrnSecurityDialog•ADO_CONSTANTS.au3'
		Case $ADOENUM_adWrnSecurityDialog
			$__iLineNumber=646 & ' - $sDescription = "For internal use only. Don"t use. (Entry wa ...•ADO_CONSTANTS.au3'
			$sDescription = "For internal use only. Don't use. (Entry was included for the sake of completeness. This error should not appear in your code.)"
		$__iLineNumber=647 & ' - Case $ADOENUM_adWrnSecurityDialogHeader•ADO_CONSTANTS.au3'
		Case $ADOENUM_adWrnSecurityDialogHeader
			$__iLineNumber=648 & ' - $sDescription = "For internal use only. Don"t use. (Entry in ...•ADO_CONSTANTS.au3'
			$sDescription = "For internal use only. Don't use. (Entry included for the sake of completeness. This error should not appear in your code.)"
		$__iLineNumber=649 & ' - Case $ADOENUM_adErrIntegrityViolation•ADO_CONSTANTS.au3'
		Case $ADOENUM_adErrIntegrityViolation
			$__iLineNumber=650 & ' - $sDescription = "Data value conflicts with the integrity con ...•ADO_CONSTANTS.au3'
			$sDescription = "Data value conflicts with the integrity constraints of the field. A new value for a Field would cause a duplicate key. A value that forms one side of a relationship between two records might not be updatable."
		$__iLineNumber=651 & ' - Case $ADOENUM_adErrPermissionDenied•ADO_CONSTANTS.au3'
		Case $ADOENUM_adErrPermissionDenied
			$__iLineNumber=652 & ' - $sDescription = "Insufficient permission prevents writing to ...•ADO_CONSTANTS.au3'
			$sDescription = "Insufficient permission prevents writing to the field. The user named in the connection string does not have the proper permissions to write to a Field."
		$__iLineNumber=653 & ' - Case $ADOENUM_adErrDataOverflow•ADO_CONSTANTS.au3'
		Case $ADOENUM_adErrDataOverflow
			$__iLineNumber=654 & ' - $sDescription = "Data value is too large to be represented b ...•ADO_CONSTANTS.au3'
			$sDescription = "Data value is too large to be represented by the field data type. A numeric value that is too large for the intended field was assigned. For example, a long integer value was assigned to a short integer field."
		$__iLineNumber=655 & ' - Case $ADOENUM_adErrSchemaViolation•ADO_CONSTANTS.au3'
		Case $ADOENUM_adErrSchemaViolation
			$__iLineNumber=656 & ' - $sDescription = "Data value conflicts with the data type or  ...•ADO_CONSTANTS.au3'
			$sDescription = "Data value conflicts with the data type or constraints of the field. The data store has validation constraints that differ from the Field value."
		$__iLineNumber=657 & ' - Case $ADOENUM_adErrSignMismatch•ADO_CONSTANTS.au3'
		Case $ADOENUM_adErrSignMismatch
			$__iLineNumber=658 & ' - $sDescription = "Conversion failed because the data value wa ...•ADO_CONSTANTS.au3'
			$sDescription = "Conversion failed because the data value was signed and the field data type used by the provider was unsigned."
		$__iLineNumber=659 & ' - Case $ADOENUM_adErrCantConvertvalue•ADO_CONSTANTS.au3'
		Case $ADOENUM_adErrCantConvertvalue
			$__iLineNumber=660 & ' - $sDescription = "Data value cannot be converted for reasons  ...•ADO_CONSTANTS.au3'
			$sDescription = "Data value cannot be converted for reasons other than sign mismatch or data overflow. For example, conversion would have truncated data."
		$__iLineNumber=661 & ' - Case $ADOENUM_adErrCantCreate•ADO_CONSTANTS.au3'
		Case $ADOENUM_adErrCantCreate
			$__iLineNumber=662 & ' - $sDescription = "Data value cannot be set or retrieved becau ...•ADO_CONSTANTS.au3'
			$sDescription = "Data value cannot be set or retrieved because the field data type was unknown, or the provider had insufficient resources to perform the operation."
		$__iLineNumber=663 & ' - Case $ADOENUM_adErrColumnNotOnThisRow•ADO_CONSTANTS.au3'
		Case $ADOENUM_adErrColumnNotOnThisRow
			$__iLineNumber=664 & ' - $sDescription = "Record does not contain this field. An inco ...•ADO_CONSTANTS.au3'
			$sDescription = "Record does not contain this field. An incorrect field name was specified or a field not in the Fields collection of the current record was referenced."
		$__iLineNumber=665 & ' - Case $ADOENUM_adErrURLDoesNotExist•ADO_CONSTANTS.au3'
		Case $ADOENUM_adErrURLDoesNotExist
			$__iLineNumber=666 & ' - $sDescription = "Either the source URL or the parent of the  ...•ADO_CONSTANTS.au3'
			$sDescription = "Either the source URL or the parent of the destination URL does not exist. There is a typographical error in either the source or destination URL. You might havehttp://mysite/photo/myphoto.jpg when you should actually have http://mysite/photos/myphoto.jpginstead. The typographical error in the parent URL (in this case, photo instead of photos) has caused the error."
		$__iLineNumber=667 & ' - Case $ADOENUM_adErrTreePermissionDenied•ADO_CONSTANTS.au3'
		Case $ADOENUM_adErrTreePermissionDenied
			$__iLineNumber=668 & ' - $sDescription = "Permissions are insufficient to access tree ...•ADO_CONSTANTS.au3'
			$sDescription = "Permissions are insufficient to access tree or subtree. The user named in the connection string does not have the appropriate permissions."
		$__iLineNumber=669 & ' - Case $ADOENUM_adErrInvalidURL•ADO_CONSTANTS.au3'
		Case $ADOENUM_adErrInvalidURL
			$__iLineNumber=670 & ' - $sDescription = "URL contains invalid characters. Make sure  ...•ADO_CONSTANTS.au3'
			$sDescription = "URL contains invalid characters. Make sure the URL is typed correctly. The URL follows the scheme registered to the current provider (for example, Internet Publishing Provider is registered for http)."
		$__iLineNumber=671 & ' - Case $ADOENUM_adErrResourceLocked•ADO_CONSTANTS.au3'
		Case $ADOENUM_adErrResourceLocked
			$__iLineNumber=672 & ' - $sDescription = "Object represented by the specified URL is  ...•ADO_CONSTANTS.au3'
			$sDescription = "Object represented by the specified URL is locked by one or more other processes. Wait until the process has finished and attempt the operation again. The object you are trying to access has been locked by another user or by another process in your application. This is most likely to arise in a multi-user environment."
		$__iLineNumber=673 & ' - Case $ADOENUM_adErrResourceExists•ADO_CONSTANTS.au3'
		Case $ADOENUM_adErrResourceExists
			$__iLineNumber=674 & ' - $sDescription = "Copy operation cannot be performed. Object  ...•ADO_CONSTANTS.au3'
			$sDescription = "Copy operation cannot be performed. Object named by destination URL already exists. Specify adCopyOverwriteto replace the object. If you do not specifyadCopyOverwrite when copying the files in a directory, the copy fails when you try to copy an item that already exists in the destination location."
		$__iLineNumber=675 & ' - Case $ADOENUM_adErrCannotComplete•ADO_CONSTANTS.au3'
		Case $ADOENUM_adErrCannotComplete
			$__iLineNumber=676 & ' - $sDescription = "The server cannot complete the operation. T ...•ADO_CONSTANTS.au3'
			$sDescription = "The server cannot complete the operation. This might be because the server is busy with other operations or it might be low on resources."
		$__iLineNumber=677 & ' - Case $ADOENUM_adErrVolumeNotFound•ADO_CONSTANTS.au3'
		Case $ADOENUM_adErrVolumeNotFound
			$__iLineNumber=678 & ' - $sDescription = "Provider cannot locate the storage device i ...•ADO_CONSTANTS.au3'
			$sDescription = "Provider cannot locate the storage device indicated by the URL. Make sure the URL is typed correctly. The URL of the storage device might be incorrect, but this error can occur for other reasons. The device might be offline or a large volume of network traffic might prevent the connection from being made."
		$__iLineNumber=679 & ' - Case $ADOENUM_adErrOutOfSpace•ADO_CONSTANTS.au3'
		Case $ADOENUM_adErrOutOfSpace
			$__iLineNumber=680 & ' - $sDescription = "Operation cannot be performed. Provider can ...•ADO_CONSTANTS.au3'
			$sDescription = "Operation cannot be performed. Provider cannot obtain enough storage space. There might not be enough RAM or hard-drive space for temporary files on the server."
		$__iLineNumber=681 & ' - Case $ADOENUM_adErrResourceOutOfScope•ADO_CONSTANTS.au3'
		Case $ADOENUM_adErrResourceOutOfScope
			$__iLineNumber=682 & ' - $sDescription = "Source or destination URL is outside the sc ...•ADO_CONSTANTS.au3'
			$sDescription = "Source or destination URL is outside the scope of the current record."
		$__iLineNumber=683 & ' - Case $ADOENUM_adErrUnavailable•ADO_CONSTANTS.au3'
		Case $ADOENUM_adErrUnavailable
			$__iLineNumber=684 & ' - $sDescription = "Operation failed to complete and the status ...•ADO_CONSTANTS.au3'
			$sDescription = "Operation failed to complete and the status is unavailable. The field may be unavailable or the operation was not attempted. Another user might have changed or deleted the field you are trying to access."
		$__iLineNumber=685 & ' - Case $ADOENUM_adErrURLNamedRowDoesNotExist•ADO_CONSTANTS.au3'
		Case $ADOENUM_adErrURLNamedRowDoesNotExist
			$__iLineNumber=686 & ' - $sDescription = "Record named by this URL does not exist. Wh ...•ADO_CONSTANTS.au3'
			$sDescription = "Record named by this URL does not exist. While attempting to open a file using a Record object, either the file name or the path to the file was misspelled."
		$__iLineNumber=687 & ' - Case $ADOENUM_adErrDelResOutOfScope•ADO_CONSTANTS.au3'
		Case $ADOENUM_adErrDelResOutOfScope
			$__iLineNumber=688 & ' - $sDescription = "The URL of the object to be deleted is outs ...•ADO_CONSTANTS.au3'
			$sDescription = "The URL of the object to be deleted is outside the scope of the current record."
		$__iLineNumber=689 & ' - Case $ADOENUM_adErrCatalogNotSet•ADO_CONSTANTS.au3'
		Case $ADOENUM_adErrCatalogNotSet
			$__iLineNumber=690 & ' - $sDescription = "Operation requires a valid ParentCatalog."•ADO_CONSTANTS.au3'
			$sDescription = "Operation requires a valid ParentCatalog."
		$__iLineNumber=691 & ' - Case $ADOENUM_adErrCantChangeConnection•ADO_CONSTANTS.au3'
		Case $ADOENUM_adErrCantChangeConnection
			$__iLineNumber=692 & ' - $sDescription = "Connection was denied. The new connection y ...•ADO_CONSTANTS.au3'
			$sDescription = "Connection was denied. The new connection you requested has different characteristics than the one already in use."
		$__iLineNumber=693 & ' - Case $ADOENUM_adErrFieldsUpdateFailed•ADO_CONSTANTS.au3'
		Case $ADOENUM_adErrFieldsUpdateFailed
			$__iLineNumber=694 & ' - $sDescription = "Fields update failed. For further informati ...•ADO_CONSTANTS.au3'
			$sDescription = "Fields update failed. For further information, examine theStatus property of individual field objects. This error can occur in two situations: when changing a Field object's value in the process of changing or adding a record to the database; and when changing the properties of the Fieldobject itself. 3750	adErrDenyNotSupported	Provider does not support sharing restrictions. An attempt was made to restrict file sharing and your provider does not support the concept."
		$__iLineNumber=695 & ' - Case $ADOENUM_adErrDenyTypeNotSupported•ADO_CONSTANTS.au3'
		Case $ADOENUM_adErrDenyTypeNotSupported
			$__iLineNumber=696 & ' - $sDescription = "Provider does not support the requested kin ...•ADO_CONSTANTS.au3'
			$sDescription = "Provider does not support the requested kind of sharing restriction. An attempt was made to establish a particular type of file-sharing restriction that is not supported by your provider. See the provider's documentation to determine what file-sharing restrictions are supported."
	EndSwitch
	$__iLineNumber=698 & ' - Return $sDescription•ADO_CONSTANTS.au3'
	Return $sDescription
EndFunc   ;==>_ADO_ERROR_GetErrorInfo
