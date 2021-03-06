"Filed out from Dolphin Smalltalk X6"!

GdiplusInitializer subclass: #GdiplusBitmapFromBlankInitializer
	instanceVariableNames: 'width height format'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
GdiplusBitmapFromBlankInitializer guid: (GUID fromString: '{0A5BEB4B-18F8-4EBE-BB4E-68CE5D088F33}')!
GdiplusBitmapFromBlankInitializer comment: ''!
!GdiplusBitmapFromBlankInitializer categoriesForClass!Unclassified! !
!GdiplusBitmapFromBlankInitializer methodsFor!

createHandle
	" Bitmap::Bitmap(
	    IN INT width,
	    IN INT height,
	    IN PixelFormat format
	    )
	{
	    GpBitmap *bitmap = NULL;

	    lastResult = DllExports::GdipCreateBitmapFromScan0(width,
                                                       height,
                                                       0,
                                                       format,
                                                       NULL,
                                                       &bitmap);"

	| gpHandle status |
	gpHandle := ExternalHandle new.
	status := self library 
				gdipCreateBitmapFromScan0: width
				height: height
				stride: 0
				format: format
				scan0: 0
				bitmap: gpHandle.
	self assertStatusOk: status.
	^gpHandle!

gdiplusConstructorErrorDescription
	^'Error creating Bitmap'!

width: widthInteger height: heightInteger format: aPixelFormat
	width := widthInteger.
	height := heightInteger.
	format := aPixelFormat! !
!GdiplusBitmapFromBlankInitializer categoriesFor: #createHandle!public!realizing/unrealizing! !
!GdiplusBitmapFromBlankInitializer categoriesFor: #gdiplusConstructorErrorDescription!constants!private! !
!GdiplusBitmapFromBlankInitializer categoriesFor: #width:height:format:!accessing!public! !

!GdiplusBitmapFromBlankInitializer class methodsFor!

width: width height: height format: aPixelFormat
	^self new 
		width: width
		height: height
		format: aPixelFormat! !
!GdiplusBitmapFromBlankInitializer class categoriesFor: #width:height:format:!instance creation!public! !

