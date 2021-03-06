"Filed out from Dolphin Smalltalk X6"!

RelativeFileLocator subclass: #PackageRelativeFileLocator
	instanceVariableNames: 'packageName'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
PackageRelativeFileLocator guid: (GUID fromString: '{01881AC6-D4EC-4FC2-BE62-F07236BE9753}')!
PackageRelativeFileLocator comment: 'PackageRelativeFileLocator is a <RelativeFileLocator> that can be used to map between an absolute path and a path relative to a certain package''s directory. At runtime (i.e. in a deployed application from which packages have been stripped) PackageRelativeFileLocator''s behave in the same way as <ImageRelativeFileLocator>s.

Thanks to Chris Uppal for the original idea behind this class.'!
!PackageRelativeFileLocator categoriesForClass!Unclassified! !
!PackageRelativeFileLocator methodsFor!

basePath
	^self package ifNil: [super basePath] ifNotNil: [:pkg | pkg path]!

package
	"Answer the <Package> who's folder is used as the base path, or nil if the package is not loaded."

	^Smalltalk at: #Package ifPresent: [:class | class manager packageNamed: packageName ifNone: []]!

packageName
	"Answer the <readableString> name of the Package who's folder is used as the base path."

	^packageName!

setPackageName: aString 
	packageName := aString! !
!PackageRelativeFileLocator categoriesFor: #basePath!accessing!public! !
!PackageRelativeFileLocator categoriesFor: #package!accessing!public! !
!PackageRelativeFileLocator categoriesFor: #packageName!accessing!public! !
!PackageRelativeFileLocator categoriesFor: #setPackageName:!initializing!private! !

!PackageRelativeFileLocator class methodsFor!

package: aPackage 
	"Answer a new instance of the receiver for locating files relative to the folder containing
	the specified <Package>. Should the package be unloaded subsequently, then the instance will
	behave as if it were an ,ImageRelativeFileLocator>."

	^self packageNamed: aPackage name!

packageNamed: aString 
	"Answer a new instance of the receiver for locating files relative to the folder containing
	the named package. If the package is not loaded, then the instance will behave as if it were
	an <ImageRelativeFileLocator>."

	^(super new)
		setPackageName: aString;
		yourself! !
!PackageRelativeFileLocator class categoriesFor: #package:!instance creation!public! !
!PackageRelativeFileLocator class categoriesFor: #packageNamed:!instance creation!public! !

