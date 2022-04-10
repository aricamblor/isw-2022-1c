!classDefinition: #I category: 'NumerosNaturales'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosNaturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'NumerosNaturales'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'next' stamp: 'fm 4/9/2022 11:43:33'!
next

	^II! !


!I class methodsFor: 'operations' stamp: 'AEC 4/10/2022 00:04:16'!
* aMultiplier

	^aMultiplier.! !

!I class methodsFor: 'operations' stamp: 'AEC 4/10/2022 00:04:13'!
+ anAddend

	^anAddend next.! !

!I class methodsFor: 'operations' stamp: 'AEC 4/10/2022 00:04:09'!
- aSubtrahend

	^ self error: self negativeNumbersNotSupportedErrorDescription.! !

!I class methodsFor: 'operations' stamp: 'AEC 4/9/2022 23:09:13'!
/ aDivisor

	self = aDivisor ifTrue: [^I].
	self error: self canNotDivideByBiggerNumberErrorDescription.! !

!I class methodsFor: 'operations' stamp: 'AEC 4/10/2022 00:03:58'!
< aNaturalNumber
	
	^ self ~= aNaturalNumber.! !

!I class methodsFor: 'operations' stamp: 'AEC 4/10/2022 00:04:03'!
> aNaturalNumber
	
	^false.! !

!I class methodsFor: 'operations' stamp: 'AEC 4/10/2022 00:03:40'!
divide: aDividend alreadyDividedTimes: numberOfTimesAlreadyDivided

	^aDividend + numberOfTimesAlreadyDivided.! !

!I class methodsFor: 'operations' stamp: 'AEC 4/10/2022 00:03:45'!
isBiggerThan: aNaturalNumber
	
	^false.! !

!I class methodsFor: 'operations' stamp: 'fm 4/9/2022 11:47:32'!
substractFrom: aMinnuend

	^ aMinnuend previous! !


!I class methodsFor: 'errors' stamp: 'fm 4/9/2022 12:02:51'!
canNotDivideByBiggerNumberErrorDescription

	^'Cannot attempt to divide a number by a bigger number.'! !

!I class methodsFor: 'errors' stamp: 'fm 4/9/2022 12:07:53'!
negativeNumbersNotSupportedErrorDescription

	^'Cannot attempt to substract a number by a bigger number.'! !


!classDefinition: #II category: 'NumerosNaturales'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosNaturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'NumerosNaturales'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'operations' stamp: 'AEC 4/9/2022 22:22:07'!
* aMultiplier

	^previous * aMultiplier + aMultiplier.! !

!II class methodsFor: 'operations' stamp: 'AEC 4/10/2022 00:04:28'!
+ anAddend

	^ previous + anAddend next.! !

!II class methodsFor: 'operations' stamp: 'AEC 4/9/2022 22:23:00'!
- aSubtrahend

	^ aSubtrahend substractFrom: self.! !

!II class methodsFor: 'operations' stamp: 'AEC 4/9/2022 23:44:07'!
/ aDivisor
	
	self < aDivisor ifTrue: [self error: self canNotDivideByBiggerNumberErrorDescription].
	self = aDivisor ifTrue: [^I].
	"aDivisor = I ifTrue: [^self]."
	
	^ aDivisor divide: self - aDivisor alreadyDividedTimes: I.
	! !

!II class methodsFor: 'operations' stamp: 'AEC 4/9/2022 23:53:59'!
< aNaturalNumber
	
	self = aNaturalNumber ifTrue: [^false].
	
	^ aNaturalNumber isBiggerThan: self.
	! !

!II class methodsFor: 'operations' stamp: 'AEC 4/10/2022 13:21:44'!
> aNaturalNumber
	
	^aNaturalNumber < self! !

!II class methodsFor: 'operations' stamp: 'AEC 4/9/2022 23:40:30'!
divide: aDividend alreadyDividedTimes: numberOfTimesAlreadyDivided

	self > aDividend ifTrue: [^ numberOfTimesAlreadyDivided ].
	self = aDividend ifTrue: [^ numberOfTimesAlreadyDivided + I].
	^ self divide: aDividend - self alreadyDividedTimes: numberOfTimesAlreadyDivided + I.
	! !

!II class methodsFor: 'operations' stamp: 'AEC 4/9/2022 23:53:24'!
isBiggerThan: aNaturalNumber
	
	^ aNaturalNumber previous < self previous.
	! !

!II class methodsFor: 'operations' stamp: 'AEC 4/10/2022 00:06:47'!
substractFrom: aMinuend

	^ aMinuend previous - previous.! !


!II class methodsFor: 'previous & next' stamp: 'fm 4/9/2022 11:51:39'!
ifNumberEndsIn: aSuffix then: aClosure

	(self name endsWith: aSuffix) ifTrue: [aClosure value]! !

!II class methodsFor: 'previous & next' stamp: 'AEC 4/9/2022 21:38:33'!
nameOfNext
	
	self ifNumberEndsIn: 'CMXCIX' then: [^self swapSuffix: 'CMXCIX' for: 'M'].
	self ifNumberEndsIn: 'DCCCXCIX' then: [^self swapSuffix: 'DCCCXCIX' for: 'CM'].
	self ifNumberEndsIn: 'CDXCIX' then: [^self swapSuffix: 'CDXCIX' for: 'D'].
	self ifNumberEndsIn: 'CCCXCIX' then: [^self swapSuffix: 'CCCXCIX' for: 'CD'].
	self ifNumberEndsIn: 'XCIX' then: [^self swapSuffix: 'XCIX' for: 'C'].
	self ifNumberEndsIn: 'LXXXIX' then: [^self swapSuffix: 'LXXXIX' for: 'XC'].
	self ifNumberEndsIn: 'XLIX' then: [^self swapSuffix: 'XLIX' for: 'L'].
	self ifNumberEndsIn: 'XXXIX' then: [^self swapSuffix: 'XXXIX' for: 'XL'].
	self ifNumberEndsIn: 'IX' then: [^self swapSuffix: 'IX' for: 'X'].
	self ifNumberEndsIn: 'VIII' then: [^self swapSuffix: 'VIII' for: 'IX'].
	self ifNumberEndsIn: 'IV' then: [^self swapSuffix: 'IV' for: 'V'].
	self ifNumberEndsIn: 'III' then: [^self swapSuffix: 'III' for: 'IV'].
	^ self name, 'I'! !

!II class methodsFor: 'previous & next' stamp: 'fm 4/9/2022 11:50:18'!
next
	
	next ifNotNil: [^next].
	next _ II createChildNamed: self nameOfNext.
	next previous: self.
	^next.! !

!II class methodsFor: 'previous & next' stamp: 'fm 4/9/2022 11:47:50'!
previous

	^previous! !

!II class methodsFor: 'previous & next' stamp: 'fm 4/9/2022 11:50:00'!
previous: aNaturalNumber
	
	previous _ aNaturalNumber.! !

!II class methodsFor: 'previous & next' stamp: 'fm 4/9/2022 11:53:30'!
swapSuffix: aSuffix for: newSuffix
	
	^(self name withoutSuffix: aSuffix), newSuffix! !


!II class methodsFor: 'support' stamp: 'fm 4/9/2022 11:54:26'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !


!II class methodsFor: 'errors' stamp: 'fm 4/9/2022 12:17:39'!
canNotDivideByBiggerNumberErrorDescription

	^ I canNotDivideByBiggerNumberErrorDescription ! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'AEC 4/10/2022 13:31:57'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !


!classDefinition: #III category: 'NumerosNaturales'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosNaturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'NumerosNaturales'!
III class
	instanceVariableNames: ''!

!III class methodsFor: '--** private fileout/in **--' stamp: 'AEC 4/10/2022 13:31:57'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IV.
	previous := II.! !


!classDefinition: #IV category: 'NumerosNaturales'!
II subclass: #IV
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosNaturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IV class' category: 'NumerosNaturales'!
IV class
	instanceVariableNames: ''!

!IV class methodsFor: '--** private fileout/in **--' stamp: 'AEC 4/10/2022 13:31:57'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := III.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IV initializeAfterFileIn!