"Filed out from Dolphin Smalltalk X6"!

ADODBRecordset20 subclass: #ADODBRecordset21
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: 'ADODBConstants'
	classInstanceVariableNames: ''!
ADODBRecordset21 guid: (IID fromString: '{00000555-0000-0010-8000-00AA006D2EA4}')!
ADODBRecordset21 comment: '<ADODBRecordset21> is a wrapper class for the COM interface ''ADODB.Recordset21'' generated from type information in the ''Microsoft ActiveX Data Objects 2.5 Library'' library. It contains methods to invoke the member functions exposed by that interface.

ADODBRecordSet21 is the ADO RecordSet interface as defined in version 2.1 of ADO, and has been superceded by later versions (see the subclasses).'!
!ADODBRecordset21 categoriesForClass!ADODB-Interfaces!COM-Interfaces! !
!ADODBRecordset21 methodsFor!

get_Index: pbstrIndex
	"Private - Get the value of the 'Index' property of the receiver.
				HRESULT __stdcall Index(
			[out, retval] BSTR* pbstrIndex);"

	<virtual stdcall: hresult 84 bstr*>
	^self invalidCall
!

index
	"Answer the <bstr> value of the 'Index' property of the receiver."

	| answer |
	answer := BSTR new.
	self get_Index: answer.
	^answer asObject
!

index: pbstrIndex
	"Set the 'Index' property of the receiver to the <bstr> value of the argument."

	self put_Index: pbstrIndex
!

put_Index: pbstrIndex
	"Private - Set the value of the 'Index' property of the object wrapped by the 
	 receiver to the <bstr> argument, pbstrIndex.
				HRESULT __stdcall Index(
			[in] BSTR pbstrIndex);"

	<virtual stdcall: hresult 83 bstr>
	^self invalidCall
!

seek: keyValues
	"Invoke the Seek() method of the COM object.
	Default values are passed for all optional parameters."

	^self
		 seek: keyValues
		 seekOption: 1!

seek: keyValues seekOption: seekOption
	"Invoke the Seek() method of the COM object."

	^self
		Seek: keyValues asVariant
		SeekOption: seekOption
!

Seek: keyValues SeekOption: seekOption
	"Private - Invoke the Seek() method of the COM object.

		HRESULT __stdcall Seek(
			[in] VARIANT KeyValues,
			[in, optional, defaultvalue(1)] SeekEnum SeekOption);"

	<virtual stdcall: hresult 82 variant sdword>
	^self invalidCall
! !
!ADODBRecordset21 categoriesFor: #get_Index:!**auto generated**!COM Interfaces-Recordset21!private! !
!ADODBRecordset21 categoriesFor: #index!**auto generated**!properties!public! !
!ADODBRecordset21 categoriesFor: #index:!**auto generated**!properties!public! !
!ADODBRecordset21 categoriesFor: #put_Index:!**auto generated**!COM Interfaces-Recordset21!private! !
!ADODBRecordset21 categoriesFor: #seek:!**auto generated**!methods!public! !
!ADODBRecordset21 categoriesFor: #seek:seekOption:!**auto generated**!methods!public! !
!ADODBRecordset21 categoriesFor: #Seek:SeekOption:!**auto generated**!COM Interfaces-Recordset21!private! !

!ADODBRecordset21 class methodsFor!

defineFunctions
	"Declare the virtual function table for the COM interface 'ADODB.Recordset21'
		ADODBRecordset21 defineTemplate"

	self
		defineFunction: #Seek:SeekOption:
			argumentTypes: 'variant sdword';
		defineFunction: #put_Index:
			argumentTypes: 'bstr';
		defineFunction: #get_Index:
			argumentTypes: 'bstr*'
! !
!ADODBRecordset21 class categoriesFor: #defineFunctions!**auto generated**!initializing!public! !

