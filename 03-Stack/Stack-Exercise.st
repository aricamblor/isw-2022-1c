!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'fm 4/26/2022 21:36:45'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'fm 4/26/2022 21:36:54'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'fm 4/26/2022 21:37:05'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'fm 4/26/2022 21:40:23'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'fm 4/26/2022 21:40:40'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'fm 4/26/2022 21:40:50'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'fm 4/26/2022 21:41:03'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'fm 4/26/2022 21:41:15'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
! !

!OOStackTest methodsFor: 'test' stamp: 'fm 4/26/2022 21:41:51'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
! !

!OOStackTest methodsFor: 'test' stamp: 'fm 4/26/2022 21:42:06'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'emptyStack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'fm 4/27/2022 01:31:49'!
test01FindWithEmptyPrefixFailsWithEmptyPrefixErrorDescription
	
	| sentenceFinder |
	
	sentenceFinder := self sentenceFinderWithEmptyStack.
	
	self should: [ sentenceFinder find: ''] raise: Error description: SentenceFinderByPrefix emptyPrefixErrorDescription.! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'AEC 4/28/2022 11:15:03'!
test02FindWithPrefixWithSpacesFailsWithPrefixWithSpacesErrorDescription

	| sentenceFinder |

	sentenceFinder := self sentenceFinderWithEmptyStack.
	
	self should: [sentenceFinder find: 'Prefix with spaces'] raise: Error description: SentenceFinderByPrefix prefixWithSpacesErrorDescription.! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'AEC 4/28/2022 11:15:16'!
test03FindWithValidPrefixAndEmptyStackShouldReturnEmptyCollection

	| sentenceFinder |
	
	sentenceFinder := self sentenceFinderWithEmptyStack.
	
	self assertNoResultsForFindOf: 'Pre' on: sentenceFinder.! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'AEC 4/27/2022 19:54:23'!
test04FindWithValidPrefixAbsentOnAllSentencesShouldReturnAnEmptyCollection

	| sentenceFinder sentences |
	
	sentences := OrderedCollection
		with: 'Oracion que no debe ser encontrada'
		with: 'Otra oracion a no ser encontrada'.
	sentenceFinder := self sentenceFinderFindingIn: sentences.
	
	self assertNoResultsForFindOf: 'Pre' on: sentenceFinder.! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'AEC 4/27/2022 20:18:11'!
test05FindWithValidPrefixPresentButNotPrefixingAnySentenceShouldReturnAnEmptyCollection
	
	| sentenceFinder sentences |
	
	sentences := OrderedCollection
		with: 'Oracion que no debe ser encontrada al buscar Pre'
		with: 'Buscar con Pre tampoco deberia encontrar esta oracion'.
	sentenceFinder := self sentenceFinderFindingIn: sentences.
	
	self assertNoResultsForFindOf: 'Pre' on: sentenceFinder.! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'fm 4/27/2022 01:42:21'!
test06FindWithValidPrefixPresentOnASentenceNotMatchingCaseShouldReturnAnEmptyCollection

	| sentenceFinder sentences |
	
	sentences := OrderedCollection with: 'prefijo que no debe ser encontrado'.
	sentenceFinder := self sentenceFinderFindingIn: sentences.
	
	self assertNoResultsForFindOf: 'Pre' on: sentenceFinder.! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'AEC 4/28/2022 11:16:04'!
test07FindWithValidPrefixPresentOnASentenceShouldReturnACollectionWithThatSentence

	| sentenceFinder sentences |
	
	sentences := OrderedCollection with: 'Prefijo a ser encontrado'.
	sentenceFinder := self sentenceFinderFindingIn: sentences.
	
	self assert: (sentenceFinder find: 'Pre') equals: sentences.! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'AEC 4/28/2022 11:18:23'!
test08FindWithValidPrefixPresentOnMoreThanASentenceShouldReturnACollectionWithAllThoseSentences

	| sentenceFinder sentences |
	
	sentences := OrderedCollection with: 'Prefijo a ser encontrado' with: 'Prefijo que tambien debe ser encontrado'. 
	sentenceFinder := self sentenceFinderFindingIn: sentences.
	
	self assert: (sentenceFinder find: 'Pre') equals: sentences.! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'AEC 4/28/2022 11:14:23'!
test09OriginalStackRemainsUnchangedAfterInitializationAndFind

	| stack  stackCopy sentenceFinder |
	
	stack := emptyStack.
	stack push: 'Presiento que va a llover.'.
	stack push: 'No va a llover'.
	
	stackCopy := stack copy.
	
	sentenceFinder := SentenceFinderByPrefix for: stack.
	self assertStack: stack hasSameElementsAndInSameOrderThan: stackCopy.
	
	sentenceFinder find: 'Pre'.
	self assertStack: stack hasSameElementsAndInSameOrderThan: stackCopy.! !


!SentenceFinderByPrefixTest methodsFor: 'testing - support' stamp: 'fm 4/26/2022 22:48:49'!
assertNoResultsForFindOf: aPrefix on: aSentenceFinder

	self assert: (aSentenceFinder find: aPrefix) equals: OrderedCollection new.! !

!SentenceFinderByPrefixTest methodsFor: 'testing - support' stamp: 'AEC 4/28/2022 11:02:03'!
assertStack: aStack hasSameElementsAndInSameOrderThan: anotherStack

	| firstStackElements secondStackElements |
	self assert: aStack size equals: anotherStack size.
	
	firstStackElements := self getStackElementsInOrder: aStack.
	secondStackElements := self getStackElementsInOrder: anotherStack.
	
	self assert: firstStackElements equals: secondStackElements.
	
	 
	! !

!SentenceFinderByPrefixTest methodsFor: 'testing - support' stamp: 'AEC 4/28/2022 11:11:14'!
getStackElementsInOrder: aStack

	| stackElements stackCopy |
	
	stackCopy := aStack copy.
	stackElements := OrderedCollection new.
		
	[stackCopy isEmpty] whileFalse: [
		| sentence |
		
		sentence := stackCopy pop.
		stackElements add: sentence
	].

	^stackElements! !

!SentenceFinderByPrefixTest methodsFor: 'testing - support' stamp: 'fm 4/27/2022 01:28:22'!
sentenceFinderFindingIn: aCollectionOfSentences

	|stack|
	
	stack := emptyStack.
	aCollectionOfSentences do: [:aSentence | stack push: aSentence ].
	
	^SentenceFinderByPrefix for: stack.! !

!SentenceFinderByPrefixTest methodsFor: 'testing - support' stamp: 'fm 4/27/2022 01:31:32'!
sentenceFinderWithEmptyStack

	^self sentenceFinderFindingIn: OrderedCollection new.! !

!SentenceFinderByPrefixTest methodsFor: 'testing - support' stamp: 'fm 4/26/2022 23:00:29'!
setUp

	emptyStack := OOStack new.! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'topElement'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'fm 4/26/2022 21:32:07'!
initialize

	topElement := OOBaseElement new.! !


!OOStack methodsFor: 'observation' stamp: 'fm 4/26/2022 21:32:19'!
isEmpty

	^topElement isBase! !

!OOStack methodsFor: 'observation' stamp: 'AEC 4/28/2022 11:24:14'!
size

	^topElement distanceFromBase! !


!OOStack methodsFor: 'operations - private' stamp: 'fm 4/26/2022 21:33:13'!
popStackedElement: anElement

	topElement := anElement previous.
	
	^anElement value! !

!OOStack methodsFor: 'operations - private' stamp: 'fm 4/26/2022 21:33:17'!
topElementIsBase

	^self error: self class stackEmptyErrorDescription.! !

!OOStack methodsFor: 'operations - private' stamp: 'fm 4/26/2022 21:33:22'!
topStackedElement: aStackElement

	^aStackElement value! !


!OOStack methodsFor: 'operations' stamp: 'fm 4/26/2022 21:32:35'!
pop

	^topElement popFrom: self.! !

!OOStack methodsFor: 'operations' stamp: 'fm 4/26/2022 21:33:35'!
push: anElementValue

	| newElement |
	newElement := OOStackedElement withValue: anElementValue andPrevious: topElement.
	topElement := newElement! !

!OOStack methodsFor: 'operations' stamp: 'fm 4/26/2022 21:33:40'!
top

	^topElement topFrom: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'fm 4/26/2022 21:34:15'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #OOStackElement category: 'Stack-Exercise'!
Object subclass: #OOStackElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackElement methodsFor: 'observation' stamp: 'AEC 4/28/2022 11:24:14'!
distanceFromBase

	^self subclassResponsibility ! !

!OOStackElement methodsFor: 'observation' stamp: 'fm 4/26/2022 21:34:27'!
isBase

	^self subclassResponsibility ! !


!OOStackElement methodsFor: 'operation' stamp: 'fm 4/26/2022 21:34:34'!
popFrom: aStack

	^self subclassResponsibility ! !

!OOStackElement methodsFor: 'operation' stamp: 'fm 4/26/2022 21:34:38'!
topFrom: aStack

	^self subclassResponsibility ! !


!classDefinition: #OOBaseElement category: 'Stack-Exercise'!
OOStackElement subclass: #OOBaseElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOBaseElement methodsFor: 'observation' stamp: 'AEC 4/28/2022 11:24:14'!
distanceFromBase

	^0! !

!OOBaseElement methodsFor: 'observation' stamp: 'fm 4/26/2022 21:34:52'!
isBase

	^true! !


!OOBaseElement methodsFor: 'operation' stamp: 'fm 4/26/2022 21:35:00'!
popFrom: aStack

	^aStack topElementIsBase! !

!OOBaseElement methodsFor: 'operation' stamp: 'fm 4/26/2022 21:35:04'!
topFrom: aStack

	^aStack topElementIsBase! !


!classDefinition: #OOStackedElement category: 'Stack-Exercise'!
OOStackElement subclass: #OOStackedElement
	instanceVariableNames: 'value previous'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackedElement methodsFor: 'initialization' stamp: 'fm 4/26/2022 21:36:15'!
initializeWithValue: aValue andPrevious: aStackElement

	value := aValue .
	previous := aStackElement.! !


!OOStackedElement methodsFor: 'observation' stamp: 'AEC 4/28/2022 11:24:14'!
distanceFromBase

	^ 1 + previous distanceFromBase! !

!OOStackedElement methodsFor: 'observation' stamp: 'fm 4/26/2022 21:35:46'!
isBase

	^false! !

!OOStackedElement methodsFor: 'observation' stamp: 'fm 4/26/2022 21:35:51'!
previous

	^previous! !


!OOStackedElement methodsFor: 'operation' stamp: 'fm 4/26/2022 21:36:04'!
popFrom: aStack

	^aStack popStackedElement: self.! !

!OOStackedElement methodsFor: 'operation' stamp: 'fm 4/26/2022 21:36:09'!
topFrom: aStack

	^aStack topStackedElement: self.! !


!OOStackedElement methodsFor: 'evaluating' stamp: 'fm 4/26/2022 21:36:22'!
value

	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackedElement class' category: 'Stack-Exercise'!
OOStackedElement class
	instanceVariableNames: ''!

!OOStackedElement class methodsFor: 'as yet unclassified' stamp: 'fm 4/26/2022 21:36:29'!
withValue: aValue andPrevious: anElement

	^self basicNew initializeWithValue: aValue andPrevious: anElement! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'operations - private' stamp: 'AEC 4/28/2022 09:43:05'!
restoreStackWithSentences: collectionOfSentences
	
	collectionOfSentences do: [:aSentence | stack push: aSentence]! !

!SentenceFinderByPrefix methodsFor: 'operations - private' stamp: 'AEC 4/28/2022 13:29:31'!
searchStackForSentencesPrefixedWith: aPrefixString
	
	| allSentences matchingSentences |
	
	matchingSentences := OrderedCollection new.
	allSentences := OrderedCollection new.
	
	[stack isEmpty] whileFalse: [
		| sentence |
		
		sentence := stack pop.
		(sentence beginsWith: aPrefixString) ifTrue: [matchingSentences addFirst: sentence].
		allSentences addFirst: sentence.	
	].
	
	self restoreStackWithSentences: allSentences.
	
	^matchingSentences! !


!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'AEC 4/28/2022 13:26:40'!
find: aPrefixString

	| matchingSentences |
	
	self assertIsNotEmpty: aPrefixString.
	self assertDoesNotHaveEmptySpaces: aPrefixString.
	
	matchingSentences := self searchStackForSentencesPrefixedWith: aPrefixString.
	
	^matchingSentences! !


!SentenceFinderByPrefix methodsFor: 'assertions' stamp: 'fm 4/26/2022 23:02:02'!
assertDoesNotHaveEmptySpaces: aPrefixString

	^ (aPrefixString includes: $ ) ifTrue: [self error: self class prefixWithSpacesErrorDescription]! !

!SentenceFinderByPrefix methodsFor: 'assertions' stamp: 'fm 4/26/2022 23:01:49'!
assertIsNotEmpty: aPrefixString

	^ aPrefixString ifEmpty: [self error: self class emptyPrefixErrorDescription]! !


!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'fm 4/26/2022 21:42:45'!
initializeFor: anOOStack 

	stack := anOOStack.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'fm 4/26/2022 21:42:57'!
emptyPrefixErrorDescription
	
	^ 'El prefijo no puede ser vacio.'! !

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'fm 4/26/2022 21:43:01'!
prefixWithSpacesErrorDescription
	
	^'El prefijo no puede contener espacios!!!!'! !


!SentenceFinderByPrefix class methodsFor: 'instance creation' stamp: 'fm 4/26/2022 21:43:06'!
for: anOOStack 

	^self new initializeFor: anOOStack ! !
