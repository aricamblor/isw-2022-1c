!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'AEC 6/5/2022 19:43:23'!
test01CartIsEmptyWhenCreated

	| cart |
	
	cart := self emptyCartWithTwoBookCatalog.
	self assert: cart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'AEC 6/5/2022 19:43:23'!
test02CartOnlyHasTheBookWhenAddingIt

	| cart |
	
	cart := self emptyCartWithTwoBookCatalog.
	cart addBook: 1 quantity: 1.
	
	self deny: cart isEmpty.
	self assert: (cart hasBook: 1)! !

!CartTest methodsFor: 'tests' stamp: 'AEC 6/5/2022 19:43:23'!
test03BooksCanBeAddedMultipleTimes

	| cart |
	
	cart := self emptyCartWithTwoBookCatalog.
	cart addBook: 1 quantity: 3.
	
	self assert: 3 equals: (cart quantityOfBooksWithISBN: 1)! !

!CartTest methodsFor: 'tests' stamp: 'AEC 6/5/2022 19:43:23'!
test04BooksCanBeAddedMultipleTimesInDifferentMoments

	| cart |
	
	cart := self emptyCartWithTwoBookCatalog.
	cart addBook: 1 quantity: 3.
	cart addBook: 1 quantity: 5.
	
	self assert: 8 equals: (cart quantityOfBooksWithISBN: 1)! !

!CartTest methodsFor: 'tests' stamp: 'AEC 6/5/2022 19:43:23'!
test05BookCannotBeAddedIfNotInCatalog

	| cart |
	
	cart := self emptyCartWithTwoBookCatalog.
	
	self should: [cart addBook: 3 quantity: 2] raise: Error withMessageText: Cart bookNotInCatalogErrorDescription! !

!CartTest methodsFor: 'tests' stamp: 'AEC 6/5/2022 20:10:46'!
test06BookCannotBeAddedWithNonPositiveQuantity

	| cart |
	
	cart := self emptyCartWithTwoBookCatalog.
	
	self should: [cart addBook: 1 quantity: 0] raise: Error withMessageText: Cart nonPositiveBookQuantityErrorDescription! !

!CartTest methodsFor: 'tests' stamp: 'AEC 6/5/2022 20:10:55'!
test07ListOfEmptyCartIsEmpty

	| cart |
	
	cart := self emptyCartWithTwoBookCatalog.
	
	self assert: cart listContents isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'AEC 6/5/2022 20:10:51'!
test08ListOfCartWithBooksReturnsBooksAndQuantities

	| cart catalog expectedResult |
	
	catalog := Set with: 1 with: 2 with: 3.
	cart := Cart for: catalog.
	
	cart addBook: 1 quantity: 2.
	cart addBook: 2 quantity: 3.
	cart addBook: 3 quantity: 7.
	cart addBook: 1 quantity: 2.
	
	expectedResult := SortedCollection with: 1->4 with: 2->3 with: 3->7.
	self assert: expectedResult equals: cart listContents ! !


!CartTest methodsFor: 'test-support' stamp: 'AEC 6/5/2022 19:43:23'!
emptyCartWithTwoBookCatalog

	^ Cart for: (Set with: 1 with: 2)! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'books catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'accessing' stamp: 'AEC 6/5/2022 20:02:57'!
listContents
	
	^books sortedElements ! !


!Cart methodsFor: 'adding' stamp: 'AEC 6/5/2022 20:09:58'!
addBook: aBookISBN quantity: aQuantity 
	
	self assertBookIsInCatalog: aBookISBN.
	self assertQuantityIsPositive: aQuantity.
	books add: aBookISBN withOccurrences: aQuantity ! !


!Cart methodsFor: 'asserting' stamp: 'AEC 6/5/2022 20:13:01'!
assertBookIsInCatalog: aBookISBN

	(catalog includes: aBookISBN) ifFalse:[self error: self class bookNotInCatalogErrorDescription]! !

!Cart methodsFor: 'asserting' stamp: 'AEC 6/5/2022 20:10:20'!
assertQuantityIsPositive: aQuantity

	^ aQuantity > 0 ifFalse:[self error: self class nonPositiveBookQuantityErrorDescription ]! !


!Cart methodsFor: 'initialization' stamp: 'AEC 6/5/2022 19:44:18'!
initializeFor: aCatalog

	books := Bag new.
	catalog := aCatalog ! !


!Cart methodsFor: 'testing' stamp: 'AEC 6/2/2022 21:15:22'!
hasBook: aBookISBN
 
	^ books includes: aBookISBN! !

!Cart methodsFor: 'testing' stamp: 'AEC 6/2/2022 20:51:53'!
isEmpty
	
	^ books isEmpty! !

!Cart methodsFor: 'testing' stamp: 'AEC 6/5/2022 19:45:09'!
quantityOfBooksWithISBN: aBookISBN 
	
	^ books occurrencesOf: aBookISBN ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'AEC 6/5/2022 19:38:48'!
for: aCatalog 
	
	^self new initializeFor: aCatalog ! !


!Cart class methodsFor: 'error-description' stamp: 'AEC 6/5/2022 19:35:59'!
bookNotInCatalogErrorDescription
	
	^'El libro no se encuentra en el catalogo.'! !

!Cart class methodsFor: 'error-description' stamp: 'AEC 6/5/2022 20:08:12'!
nonPositiveBookQuantityErrorDescription
	
	^'La cantidad de libros a agregar no es positiva.'! !
