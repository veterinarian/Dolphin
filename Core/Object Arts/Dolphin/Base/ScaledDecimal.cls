"Filed out from Dolphin Smalltalk X6.1"!

Number subclass: #ScaledDecimal
	instanceVariableNames: 'fraction scale'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
ScaledDecimal guid: (GUID fromString: '{F44C914B-2B3F-11D3-8368-7A8B5A000000}')!
ScaledDecimal comment: 'ScaledDecimal is a Number class to represent fixed point decimal numbers. It supports unbounded precision, with no practical limit to the number of digits before and after the decimal point.

ScaledDecimal conforms to the following ANSI protocols:
	Float
	magnitude
	number
	Object
	rational
	scaledDecimal

A ScaledDecimal represents a value as a Fraction and the number of digits after the decimal point. This representation allows us to take advantage of the implementation of unbounded rational numbers provided by Fraction with very small amount of simple code.

We are grateful to Richard A. Harmon for contributing his ANSI compliant ScaledDecimal implementation from which this class was derived.
'!
!ScaledDecimal categoriesForClass!Magnitude-Numbers! !
!ScaledDecimal methodsFor!

- operand
	"Answer the difference between the receiver and the <number>
	argument, operand."

	^operand subtractFromScaledDecimal: self!

* operand
	"Answer the result of multiplying the receiver by the <number>
	argument, operand."

	^operand multiplyByScaledDecimal: self!

/ operand
	"Answer the result of dividing the receiver by <number> argument, 
	operand. Raise a <ZeroDivide> exception if the operand is zero."

	^operand divideIntoScaledDecimal: self!

// operand 
	"Answer the <integer> quotient defined by division with truncation toward negative infinity
	of the receiver by the <number> operand."

	^fraction // operand!

+ operand
	"Answer the sum of the receiver and the <number> argument, 
	operand."

	^operand addToScaledDecimal: self
!

< operand
	"Answer whether the receiver is less than the <number>, operand."

	^operand greaterThanScaledDecimal: self
!

addToScaledDecimal: operand
	"Private - Answer the <ScaledDecimal> result of adding the receiver
	to the known <ScaledDecimal>."

	^self species
		newFromNumber: operand asFraction + fraction
		scale: (self scale max: operand scale)!

asFloat
	"Answer the receiver represented as the nearest possible <Float>."

	^fraction asFloat
!

asFraction
	"Answer an <integer> or <fraction> approximating the receiver."

	^fraction!

asScaledDecimal: newScale
	"Answer a new <ScaledDecimal>, with a fractional precision of scale, 
	which most nearly approximates the receiver."

	^self species
		newFromNumber: fraction
		scale: newScale!

coerce: coercee
	"Private - Coerce the <ArithmeticValue>, coercee, which must be of a lower generality than the receiver, to be the 
	same type as the receiver."

	^coercee asScaledDecimal: scale
!

denominator
	"Answer the <integer> denominator of the receiver."

	^fraction denominator
!

displayOn: target 
	"Append, to the <puttableStream, aStream, a String whose characters are a 
	representation of the receiver as a user would want to see it."

	| scaler quoRem num denom scaled |
	scaler := 10 raisedToInteger: scale.
	num := fraction numerator.
	denom := fraction denominator.
	scaled := (num * scaler + (denom bitShift: -1)) // denom.
	num negative 
		ifTrue: 
			[target nextPut: $-.
			scaled := scaled negated].
	quoRem := scaled quoAndRem: scaler.
	(quoRem at: 1) printOn: target.
	scale > 0 
		ifTrue: 
			[target nextPut: $..
			scale timesRepeat: 
					[| rem |
					rem := (quoRem at: 2) * 10.
					quoRem := rem quoAndRem: scaler.
					target nextPut: (Character digitValue: (quoRem at: 1))]]!

divideIntoScaledDecimal: operand
	"Private - Answer the result of dividing the known <ScaledDecimal>, operand, by the receiver."

	^self species
		newFromNumber: operand asFraction / fraction
		scale: (scale max: operand scale)!

fractionPart
	"Answer a <number> of the same type as the receiver, representing the 
	fractional part of  the receiver."

	^self species
		newFromNumber: fraction fractionPart
		scale: scale!

generality
	"Private - Answer the Smalltalk generality of the receiver, used for performing type conversions.
	ScaledDecimals are considered more general than Fractions but less general than Floats."

	"There is some controversy as to whether this is the correct generality for ScaledDecimals.
	Theoretically ScaledDecimals are more general than Floats, however traditionally Floats
	have been considered more general than Fractions although they clearly aren't (perhaps
	this arrangement was chosen for reasons of efficiency). Therefore making ScaledDecimals
	sit in between fits with the historic arrangements. It may be that the whole scheme needs to
	be altered for ANSI compatibility (or that the ANSI standard needs to be altered for
	compatibility with existing applications)."

	^35!

greaterThanScaledDecimal: comperand
	"Private - Answer whether the receiver is greater than the known <ScaledDecimal>, comperand."

	^comperand asFraction < fraction!

hash
	"Answer the <integer> hash value for the receiver." 

	^fraction hash
!

integerPart
	"Answer a <ScaledDecimal> representing the integral part of the receiver."

	^self species
		newFromNumber: fraction integerPart
		scale: scale!

isZero
	"Answer whether the receiver is equal to its class' zero"

	^fraction isZero!

multiplyByScaledDecimal: operand
	"Private - Multiply the receiver by the known <ScaledDecimal>, operand,
	answering the result."

	^self species
		newFromNumber: operand asFraction * fraction
		scale: (scale max: operand scale)!

negated
	"Answer a <number> of the same type of the receiver
	which is its negation."

	^self species
		newFromNumber: fraction negated
		scale: scale!

numerator
	"Answer the <integer> numerator of the receiver."

	^fraction numerator
!

printOn: target
	"Append, to the <puttableStream>, target, a string whose characters are a 
	the same as those which would result from sending a #printString
	message to the receiver."

	self displayOn: target.
	target nextPut: $s!

raisedToInteger: operand
	"Answer the receiver raised to the <integer> power, operand."

	^self species
		newFromNumber: (fraction raisedToInteger: operand)
		scale: self scale
!

reciprocal
	"Answer a <ScaledDecimal> which is the reciprocal of the receiver (i.e. 1/receiver).
	Raise a ZeroDivide exception if the receiver is zero.
	Implementation Note: Override because we can implement this much more
	efficiently by simply flipping over our Fraction (done in its own efficient reciprocal)."

	^self species
		newFromNumber: fraction reciprocal
		scale: scale
!

scale
	"Answer an <integer> which represents the total number of digits used to 
	represent the fraction part of the receiver, including trailing zeroes."

	^scale
!

setFraction: f scale: s 
	"Private - Initialize the receiver's identity variables."

	fraction := f.
	scale := s.
	self isImmutable: true!

subtractFromScaledDecimal: operand
	"Private - Answer the result of subtracting the receiver from the 
	known <ScaledDecimal>, operand."

	^self species
		newFromNumber: operand asFraction - fraction
		scale: (scale max: operand scale)!

truncated
	"Answer the <integer> nearest the receiver toward zero."

	^fraction truncated
! !
!ScaledDecimal categoriesFor: #-!arithmetic!public! !
!ScaledDecimal categoriesFor: #*!arithmetic!public! !
!ScaledDecimal categoriesFor: #/!arithmetic!public! !
!ScaledDecimal categoriesFor: #//!arithmetic!public! !
!ScaledDecimal categoriesFor: #+!arithmetic!public! !
!ScaledDecimal categoriesFor: #<!comparing!public! !
!ScaledDecimal categoriesFor: #addToScaledDecimal:!double dispatch!private! !
!ScaledDecimal categoriesFor: #asFloat!converting!public! !
!ScaledDecimal categoriesFor: #asFraction!converting!public! !
!ScaledDecimal categoriesFor: #asScaledDecimal:!converting!public! !
!ScaledDecimal categoriesFor: #coerce:!coercing!private! !
!ScaledDecimal categoriesFor: #denominator!accessing!public! !
!ScaledDecimal categoriesFor: #displayOn:!printing!public! !
!ScaledDecimal categoriesFor: #divideIntoScaledDecimal:!double dispatch!private! !
!ScaledDecimal categoriesFor: #fractionPart!accessing!public! !
!ScaledDecimal categoriesFor: #generality!coercing!private! !
!ScaledDecimal categoriesFor: #greaterThanScaledDecimal:!double dispatch!private! !
!ScaledDecimal categoriesFor: #hash!comparing!public! !
!ScaledDecimal categoriesFor: #integerPart!accessing!public! !
!ScaledDecimal categoriesFor: #isZero!public!testing! !
!ScaledDecimal categoriesFor: #multiplyByScaledDecimal:!double dispatch!private! !
!ScaledDecimal categoriesFor: #negated!arithmetic!public! !
!ScaledDecimal categoriesFor: #numerator!accessing!public! !
!ScaledDecimal categoriesFor: #printOn:!printing!public! !
!ScaledDecimal categoriesFor: #raisedToInteger:!mathematical functions!public! !
!ScaledDecimal categoriesFor: #reciprocal!arithmetic!public! !
!ScaledDecimal categoriesFor: #scale!accessing!public! !
!ScaledDecimal categoriesFor: #setFraction:scale:!initializing!private! !
!ScaledDecimal categoriesFor: #subtractFromScaledDecimal:!double dispatch!private! !
!ScaledDecimal categoriesFor: #truncated!public!truncation and round off! !

ScaledDecimal methodProtocol: #scaledDecimal attributes: #(#ansi #readOnly) selectors: #(#- #* #/ #// #\\ #+ #< #<= #> #>= #abs #asFloat #asFloatD #asFloatE #asFloatQ #asFraction #asInteger #asScaledDecimal: #between:and: #ceiling #floor #fractionPart #integerPart #max: #min: #negated #negative #positive #quo: #raisedTo: #raisedToInteger: #reciprocal #rem: #rounded #roundTo: #scale #sign #sqrt #squared #strictlyPositive #to: #to:by: #to:by:do: #to:do: #truncated #truncateTo:)!

!ScaledDecimal class methodsFor!

icon
	"Answers an Icon that can be used to represent this class"

	^##(self) defaultIcon!

newFromNumber: aNumber scale: scaleInteger
	"Answer a new instance of me."

	^self basicNew
		setFraction: aNumber asFraction scale: scaleInteger;
		yourself!

one
	"Answer the receiver's representation of one."

	^self
		newFromNumber: 1
		scale: 0!

zero
	"Answer the receiver's representation of zero."

	^self
		newFromNumber: 0
		scale: 0
! !
!ScaledDecimal class categoriesFor: #icon!constants!public! !
!ScaledDecimal class categoriesFor: #newFromNumber:scale:!instance creation!public! !
!ScaledDecimal class categoriesFor: #one!instance creation!public! !
!ScaledDecimal class categoriesFor: #zero!instance creation!public! !

