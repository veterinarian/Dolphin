"Filed out from Dolphin Smalltalk X6"!

Object subclass: #Stream
	instanceVariableNames: ''
	classVariableNames: 'EndOfStreamSignal'
	poolDictionaries: ''
	classInstanceVariableNames: ''!
Stream guid: (GUID fromString: '{87B4C4C4-026E-11D3-9FD7-00A0CC3E4A32}')!
Stream comment: 'Stream represents a class of objects which can be used for streaming I/O. Stream itself is abstract.

InstanceVariables
	None.

Class Variables:
	EndOfStreamSignal	<exceptionSignaler/exeptionSelector>. Exception to mark attempts to read off the end of the stream.'!
!Stream categoriesForClass!Collections-Streams! !
!Stream methodsFor!

atEnd
	"Answer whether the receiver is at the end of its values."

	^self subclassResponsibility!

close
	"Relinquish any external resources associated with the receiver, and put the
	receiver into a 'closed' state (as appropriate to the subclass). Answer the receiver."

	^self!

contentsSpecies
	"Private - Answer the class of Object to be used when answering collections of elements
	from the receiver."

	^Array!

do: aMonadicValuable 
	"Evaluate the <monadicValuable> argument for each of the receiver's future sequence values,
	terminating only when there are no more future sequence values (i.e. the stream is at an
	end). N.B. If evaluating the valuable has side effects on the receiver stream, then the
	behaviour is undefined."

	[self atEnd] whileFalse: [aMonadicValuable value: self next]!

errorEndOfStream
	"Raise an error to the effect that an attempt was made to read off the end of the collection
	over which the receiver is streaming."

	^self class endOfStreamSignal signalWith: self!

isReadable
	"Answer whether the receiver can be read from (i.e. it implements the gettableStream
	protocol)."

	^false!

isWriteable
	"Answer whether the receiver can be written to (i.e. it implements the puttableStream
	protocol)."

	^false!

next
	"Answer the next object accessible by the receiver."

	"Implementation Note: Must be defined by subclasses which wish to implement the 
	<gettableStream> protocol."

	^self subclassResponsibility!

next: anInteger 
	"Answer a <sequencedReadableCollection> containing the next anInteger number of objects
	accessible by the receiver."

	"Implementation Note: Subclasses should not generally override this method, but the more
	flexible #next:into:startingAt: message which this uses."

	^self 
		next: anInteger
		into: (self contentsSpecies new: anInteger)
		startingAt: 1!

next: countInteger into: aSequenceableCollection startingAt: startInteger 
	"Destructively replace the elements of the <sequenceableCollection> argument in the
	<integer> interval (startAt..startAt+count-1) with the next countInteger elements of the
	receiver. Answer aSequenceableCollection."

	"Implementation Note: This will fail if the receiver is not readable."

	startInteger to: startInteger + countInteger - 1
		do: [:i | aSequenceableCollection at: i put: self next].
	^aSequenceableCollection!

nextAvailable: anInteger 
	"Answer up to anInteger elements of the receiver's collection. Generally, the answer will be
	a collection of the same class as the one accessed by the receiver (though this is
	determined by the receiver), and will contain anInteger elements, or as many as are left in
	the receiver's collection."

	| newStream count |
	count := 0.
	newStream := self contentsSpecies writeStream: anInteger.
	[count == anInteger or: [self atEnd]] whileFalse: 
			[newStream nextPut: self next.
			count := count + 1].
	^newStream contents!

nextMatchFor: anObject 
	"Access the next object and answer whether it is equal to the argument, anObject. Raise an
	end of stream exception (via #next) if there are no more elements in the receiver."

	^anObject = self next!

skipThrough: anObject 
	"Set the receivers position reference to be past the next occurrence of the argument,
	anObject, in the collection. Answer the receiver, or nil if no such occurrence existed."

	"Included for compatibility with VisualWorks - the ANSI standard message #skipTo: should be
	used in preference"

	[self atEnd] whileFalse: [self next = anObject ifTrue: [^self]].
	^nil!

skipTo: anObject 
	"Set the receivers position reference to be past the next occurrence of the argument,
	anObject, in the collection. Answer whether such an occurrence existed."

	[self atEnd] whileFalse: [self next = anObject ifTrue: [^true]].
	^false!

upTo: anObject 
	"Answer a collection of elements starting with the next element accessed by the receiver,
	and up to, not inclusive of, the next element that is equal to anObject. Positions the
	stream after anObject if found. If anObject is not in the collection, answer the entire rest
	of the collection. If the receiver is at its end, answer an empty Collection."

	| newStream nextObject |
	newStream := self contentsSpecies writeStream: 128.
	[self atEnd or: 
			[nextObject := self next.
			nextObject = anObject]] 
		whileFalse: [newStream nextPut: nextObject].
	^newStream contents!

upToEnd
	"Answer a collection consisting of the future sequence values of the receiver (i.e. from the
	current position to the end)."

	| remainder |
	remainder := self contentsSpecies writeStream: 128.
	[self atEnd] whileFalse: [remainder nextPut: self next].
	^remainder contents! !
!Stream categoriesFor: #atEnd!public!testing! !
!Stream categoriesFor: #close!operations!public! !
!Stream categoriesFor: #contentsSpecies!accessing!private! !
!Stream categoriesFor: #do:!enumerating!public! !
!Stream categoriesFor: #errorEndOfStream!exceptions!public! !
!Stream categoriesFor: #isReadable!public!testing! !
!Stream categoriesFor: #isWriteable!public!testing! !
!Stream categoriesFor: #next!accessing!public! !
!Stream categoriesFor: #next:!accessing!public! !
!Stream categoriesFor: #next:into:startingAt:!accessing!public! !
!Stream categoriesFor: #nextAvailable:!accessing!public! !
!Stream categoriesFor: #nextMatchFor:!accessing!public! !
!Stream categoriesFor: #skipThrough:!positioning!public! !
!Stream categoriesFor: #skipTo:!positioning!public! !
!Stream categoriesFor: #upTo:!accessing!public! !
!Stream categoriesFor: #upToEnd!accessing!public! !

!Stream class methodsFor!

endOfStreamSignal
	"Answer an exceptionSignaler/exceptionSelector object raised when an attempt is 
	made to read off the end of the stream. Those interested in catching end of 
	Stream exceptions should use this accessor to get the exceptionSelector to pass
	as the first parameter to an #on:do: message. Current the answer is a Signal
	instance, but it could be an Exception subclass in future."

	^EndOfStreamSignal!

initialize
	"Private - Initialize the receiver's class variables.
		Stream initialize
	"

	EndOfStreamSignal := Signal description: 'End of stream'!

new
	"Streams must be instantiated onto something."

	^self shouldNotImplement! !
!Stream class categoriesFor: #endOfStreamSignal!constants!public! !
!Stream class categoriesFor: #initialize!development!initializing!private! !
!Stream class categoriesFor: #new!instance creation!public! !

