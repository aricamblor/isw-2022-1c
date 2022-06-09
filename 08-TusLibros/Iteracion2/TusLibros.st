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

!CartTest methodsFor: 'tests' stamp: 'AEC 6/6/2022 19:02:04'!
test05BookCannotBeAddedIfNotInCatalog

	| cart |
	
	cart := self emptyCartWithTwoBookCatalog.
	
	self should: [cart addBook: 3 quantity: 2] 
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: Cart bookNotInCatalogErrorDescription	 equals: anError messageText.
			self assert: cart isEmpty
		]! !

!CartTest methodsFor: 'tests' stamp: 'AEC 6/6/2022 19:00:59'!
test06BookCannotBeAddedWithNonPositiveQuantity

	| cart |
	
	cart := self emptyCartWithTwoBookCatalog.
	
	self should: [cart addBook: 1 quantity: 0] 
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: Cart nonPositiveBookQuantityErrorDescription	 equals: anError messageText.
			self assert: cart isEmpty
		]! !

!CartTest methodsFor: 'tests' stamp: 'AEC 6/6/2022 19:00:21'!
test07NonIntegerQuantityOfBookCantBeAdded

	| cart |
	
	cart := self emptyCartWithTwoBookCatalog.
	
	self should: [cart addBook: 1 quantity: 1.2] 
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: Cart nonIntegerBookQuantityErrorDescription	 equals: anError messageText.
			self assert: cart isEmpty
		]! !

!CartTest methodsFor: 'tests' stamp: 'AEC 6/6/2022 18:56:26'!
test08ListOfEmptyCartIsEmpty

	| cart |
	
	cart := self emptyCartWithTwoBookCatalog.
	
	self assert: cart listContents isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'fm 6/8/2022 20:25:07'!
test09ListOfCartWithBooksReturnsBooksAndQuantities

	| cart catalog expectedResult |
	
	catalog := Dictionary with: 1->5 with: 2->2.5 with: 3->1.
	cart := Cart for: catalog.
	
	cart addBook: 1 quantity: 2.
	cart addBook: 2 quantity: 3.
	cart addBook: 3 quantity: 7.
	cart addBook: 1 quantity: 2.
	
	expectedResult := SortedCollection with: 1->4 with: 2->3 with: 3->7.
	self assert: expectedResult equals: cart listContents ! !


!CartTest methodsFor: 'test-support' stamp: 'fm 6/8/2022 20:24:09'!
emptyCartWithTwoBookCatalog

	^ Cart for: (Dictionary with: 1->5 with: 2->2.5)! !


!classDefinition: #CheckoutTest category: 'TusLibros'!
TestCase subclass: #CheckoutTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CheckoutTest methodsFor: 'test-support' stamp: 'fm 6/8/2022 21:24:52'!
cashierWith: aSalesList

	^ Cashier for: aSalesList debitingTo: WorkingMerchantProcessor new! !

!CheckoutTest methodsFor: 'test-support' stamp: 'AEC 6/7/2022 21:33:55'!
expiredMonthOfYear
	
	^FixedGregorianDate today monthOfYear previous! !

!CheckoutTest methodsFor: 'test-support' stamp: 'AEC 6/6/2022 21:20:16'!
invalidCreditCardNumber

	^123! !

!CheckoutTest methodsFor: 'test-support' stamp: 'AEC 6/7/2022 21:34:03'!
nonExpiredMonthOfYear
	
	^FixedGregorianDate today monthOfYear next! !

!CheckoutTest methodsFor: 'test-support' stamp: 'AEC 6/7/2022 21:20:42'!
validCreditCard

	^CreditCard for: 'Alan Kay' number: self validCreditCardNumber expiringOn: self nonExpiredMonthOfYear.! !

!CheckoutTest methodsFor: 'test-support' stamp: 'AEC 6/6/2022 21:07:03'!
validCreditCardNumber

	^1234567890123456! !


!CheckoutTest methodsFor: 'tests' stamp: 'fm 6/8/2022 19:49:53'!
test01CantCreateCreditCardWithBlankOwnerName

	self should: [CreditCard for: ' ' number: self validCreditCardNumber expiringOn: self nonExpiredMonthOfYear]
		raise: Error
		withMessageText: CreditCard emptyOwnerNameErrorDescription! !

!CheckoutTest methodsFor: 'tests' stamp: 'fm 6/8/2022 19:49:57'!
test02CantCreateCreditCardWithInvalidNumberOfDigits

	self should: [CreditCard for: 'Alan Kay' number: self invalidCreditCardNumber expiringOn: self nonExpiredMonthOfYear]
		raise: Error
		withMessageText: CreditCard invalidNumberOfDigitsErrorDescription! !

!CheckoutTest methodsFor: 'tests' stamp: 'fm 6/8/2022 21:13:36'!
test03SaleisNotRegisteredWhenCartIsEmpty
	
	| cart cashier catalog salesList |
	
	catalog := Set with: 1 with: 2.
	cart := Cart for: catalog.
	
	salesList := OrderedCollection new.
	cashier := self cashierWith: salesList.
	
	self should: [cashier checkout: cart withCard: self validCreditCard] 
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: Cashier emptyCartErrorDescription	 equals: anError messageText.
			self assert: salesList isEmpty
		].! !

!CheckoutTest methodsFor: 'tests' stamp: 'fm 6/8/2022 21:13:22'!
test04SaleIsNotRegisteredWhenCreditCardIsExpired
	
	| cart cashier catalog creditCard salesList |
	
	catalog := Dictionary with: 1->5 with: 2->2.5.
	cart := Cart for: catalog.
	cart addBook: 1 quantity: 1.
	cart addBook: 2 quantity: 2.
	
	salesList := OrderedCollection new.
	cashier := self cashierWith: salesList.
	creditCard := CreditCard for: 'Alan Kay' number: self validCreditCardNumber expiringOn: self expiredMonthOfYear.
	
	self should:[cashier checkout: cart withCard: creditCard]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: Cashier expiredCreditCardErrorDescription	 equals: anError messageText.
			self assert: salesList isEmpty
		].! !

!CheckoutTest methodsFor: 'tests' stamp: 'fm 6/8/2022 21:13:39'!
test05SaleIsRegisteredOnSalesListWithContentsAndPrice
	
	| cart cashier catalog expectedSale salesList |
	
	catalog := Dictionary with: 1->5 with: 2->2.5.
	cart := Cart for: catalog.
	cart addBook: 1 quantity: 1.
	cart addBook: 2 quantity: 2.
	
	salesList := OrderedCollection new.
	cashier := self cashierWith: salesList.
	cashier checkout: cart withCard: self validCreditCard.
	
	expectedSale := cart listContents -> (5 + (2*2.5)).
	
	self assert: 1 equals: salesList size.
	self assert: salesList includes: expectedSale! !

!CheckoutTest methodsFor: 'tests' stamp: 'fm 6/8/2022 21:45:58'!
test06ShouldNotSendToMerchantProcessorWhenNameIsTooLong
	
	| cart cashier catalog salesList cardWithLongName merchantProcessor |
	
	catalog := Dictionary with: 1->5 with: 2->2.5.
	cart := Cart for: catalog.
	cart addBook: 1 quantity: 1.
	cart addBook: 2 quantity: 2.
	merchantProcessor := WorkingMerchantProcessor new.
	salesList := OrderedCollection new.
	cashier := Cashier for: salesList debitingTo: merchantProcessor.
	cardWithLongName := CreditCard for: 'Una Persona Con Un Nombre Super Muy Pero Muy Largo' number: self validCreditCardNumber expiringOn: self nonExpiredMonthOfYear.
	
	self
		should: [ cashier checkout: cart withCard: cardWithLongName ]
		raise: Error
		withExceptionDo: [:anError |
			self assert: anError messageText equals: Cashier nameTooLongToSendToMerchantProcessor.
			self assert: salesList isEmpty.
			self assert: merchantProcessor timesCalled isZero]! !

!CheckoutTest methodsFor: 'tests' stamp: 'fm 6/8/2022 21:47:41'!
test07ShouldNotSendToMerchantProcessorWhenAmountIsTooBig
	
	| cart cashier catalog salesList merchantProcessor |
	
	catalog := Dictionary with: 1->5000000000000000 with: 2->2.5.
	cart := Cart for: catalog.
	cart addBook: 1 quantity: 1.
	cart addBook: 2 quantity: 2.
	merchantProcessor := WorkingMerchantProcessor new.
	salesList := OrderedCollection new.
	cashier := Cashier for: salesList debitingTo: merchantProcessor.
	
	self
		should: [ cashier checkout: cart withCard: self validCreditCard ]
		raise: Error
		withExceptionDo: [:anError |
			self assert: anError messageText equals: Cashier amountTooBigToSendToMerchantProcessor.
			self assert: salesList isEmpty.
			self assert: merchantProcessor timesCalled isZero ]! !

!CheckoutTest methodsFor: 'tests' stamp: 'fm 6/8/2022 21:48:23'!
test08AmountIsSentFormattedToMerchantProcessor
	
	| cart cashier catalog salesList merchantProcessor |
	
	catalog := Dictionary with: 1->5 with: 2->2.5.
	cart := Cart for: catalog.
	cart addBook: 1 quantity: 1.
	cart addBook: 2 quantity: 2.
	merchantProcessor := WorkingMerchantProcessor new.
	
	salesList := OrderedCollection new.
	cashier := Cashier for: salesList debitingTo: merchantProcessor.
	
	cashier checkout: cart withCard: self validCreditCard.
	
	self assert: '10.00' equals: merchantProcessor amountReceived! !

!CheckoutTest methodsFor: 'tests' stamp: 'fm 6/8/2022 21:49:47'!
test09CannotCheckoutWhenMerchantProcessorCannotProcessDebit
	
	| cart cashier catalog salesList merchantProcessor |
	
	catalog := Dictionary with: 1->5 with: 2->2.5.
	cart := Cart for: catalog.
	cart addBook: 1 quantity: 1.
	cart addBook: 2 quantity: 2.
	merchantProcessor := FailingMerchantProcessorTestDouble new.
	
	salesList := OrderedCollection new.
	cashier := Cashier for: salesList debitingTo: merchantProcessor.
	
	self
		should:	[ cashier checkout: cart withCard: self validCreditCard ]
		raise: Error
		withExceptionDo: [:anError |
			self assert: anError messageText equals: FailingMerchantProcessorTestDouble cannotProcessDebit.
			self assert: salesList isEmpty ]! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'books catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'accessing' stamp: 'AEC 6/5/2022 20:02:57'!
listContents
	
	^books sortedElements ! !


!Cart methodsFor: 'adding' stamp: 'AEC 6/6/2022 18:57:00'!
addBook: aBookISBN quantity: aQuantity 
	
	self assertBookIsInCatalog: aBookISBN.
	self assertQuantityIsValid: aQuantity.
	books add: aBookISBN withOccurrences: aQuantity ! !


!Cart methodsFor: 'asserting' stamp: 'AEC 6/6/2022 19:35:51'!
assertBookIsInCatalog: aBookISBN

	(catalog includesKey: aBookISBN) ifFalse:[self error: self class bookNotInCatalogErrorDescription]! !

!Cart methodsFor: 'asserting' stamp: 'AEC 6/6/2022 18:58:37'!
assertQuantityIsValid: aQuantity

	aQuantity > 0 ifFalse:[self error: self class nonPositiveBookQuantityErrorDescription ].
	aQuantity isInteger ifFalse:[self error: self class nonIntegerBookQuantityErrorDescription ]
	! !


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


!Cart methodsFor: 'valuating' stamp: 'AEC 6/6/2022 19:46:54'!
value

	^books sum:[ :aBookISBN |  catalog at: aBookISBN ]! !

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

!Cart class methodsFor: 'error-description' stamp: 'AEC 6/6/2022 18:59:02'!
nonIntegerBookQuantityErrorDescription
	
	^'La cantidad de libros a agregar no es un numero entero.'! !

!Cart class methodsFor: 'error-description' stamp: 'AEC 6/5/2022 20:08:12'!
nonPositiveBookQuantityErrorDescription
	
	^'La cantidad de libros a agregar no es positiva.'! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'salesList merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'asserting' stamp: 'fm 6/8/2022 20:40:16'!
assertAmountIsValidToSendToMerchantProcessor: anAmount

	(anAmount truncated numberOfDigitsInBase: 10)  > 15 ifTrue: [ self error: self class amountTooBigToSendToMerchantProcessor ]! !

!Cashier methodsFor: 'asserting' stamp: 'AEC 6/6/2022 19:11:54'!
assertCartIsNotEmpty: aCart

	^ aCart isEmpty ifTrue:[self error: self class emptyCartErrorDescription]! !

!Cashier methodsFor: 'asserting' stamp: 'fm 6/8/2022 23:38:32'!
assertNameIsValidToSendToMerchantProcessor: aCreditCard

	aCreditCard owner withBlanksTrimmed size > 30 ifTrue: [ self error: self class nameTooLongToSendToMerchantProcessor ]! !


!Cashier methodsFor: 'initialization' stamp: 'fm 6/8/2022 20:58:47'!
initializeFor: aSalesList debitingTo: aMerchantProcessor 
	
	salesList := aSalesList.
	merchantProcessor := aMerchantProcessor ! !


!Cashier methodsFor: 'paying' stamp: 'fm 6/8/2022 21:14:52'!
checkout: aCart withCard: aCreditCard 
	
	| price |
	
	self assertCartIsNotEmpty: aCart.
	price := aCart value.
	(aCreditCard isExpiredOn: FixedGregorianDate today) ifTrue:[self error: self class expiredCreditCardErrorDescription].
	self assertNameIsValidToSendToMerchantProcessor: aCreditCard.
	self assertAmountIsValidToSendToMerchantProcessor: price.
	
	merchantProcessor debit: (self formatAmount: price) from: aCreditCard.
	salesList add: aCart listContents -> price! !


!Cashier methodsFor: 'paying - private' stamp: 'fm 6/8/2022 21:07:39'!
formatAmount: anAmount

	^ anAmount printStringFractionDigits: 2! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error-description' stamp: 'fm 6/8/2022 20:29:42'!
amountTooBigToSendToMerchantProcessor
	
	^'El monto puede tener hasta 15 digitos.'! !

!Cashier class methodsFor: 'error-description' stamp: 'AEC 6/6/2022 19:10:13'!
emptyCartErrorDescription
	
	^ 'El carrito esta vacio.'! !

!Cashier class methodsFor: 'error-description' stamp: 'AEC 6/7/2022 21:17:36'!
expiredCreditCardErrorDescription
	
	^'La tarjeta de credito esta vencida.'! !

!Cashier class methodsFor: 'error-description' stamp: 'fm 6/8/2022 20:13:35'!
nameTooLongToSendToMerchantProcessor
	
	^'El nombre del cliente debe tener como maximo 30 digitos.'! !


!Cashier class methodsFor: 'instance creation' stamp: 'fm 6/8/2022 20:58:33'!
for: aSalesList debitingTo: aMerchantProcessor
	
	^self new initializeFor: aSalesList debitingTo: aMerchantProcessor ! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'owner number expirationMonthOfYear'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'fm 6/8/2022 20:18:51'!
initializeFor: anOwner number: aCreditCardNumber expiringOn: aGregorianMonthOfYear 

	owner := anOwner.
	number := aCreditCardNumber.
	expirationMonthOfYear := aGregorianMonthOfYear! !


!CreditCard methodsFor: 'testing' stamp: 'AEC 6/7/2022 21:35:10'!
isExpiredOn: aFixedGregorianDate

	^ expirationMonthOfYear lastDate < aFixedGregorianDate! !


!CreditCard methodsFor: 'accessing' stamp: 'fm 6/8/2022 20:17:13'!
owner

	^ owner! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'fm 6/8/2022 20:19:54'!
for: anOwner number: aCreditCardNumber expiringOn: aGregorianMonthOfYear 

	self assertNumberHas16Digits: aCreditCardNumber.
	self assertOwnerNameIsNotBlank: anOwner.
	
	^ self new initializeFor: anOwner number: aCreditCardNumber expiringOn: aGregorianMonthOfYear! !


!CreditCard class methodsFor: 'error-description' stamp: 'AEC 6/6/2022 21:06:22'!
emptyOwnerNameErrorDescription
	
	^ 'El nombre de titular de la tarjeta esta vacio'! !

!CreditCard class methodsFor: 'error-description' stamp: 'AEC 6/6/2022 21:12:37'!
invalidNumberOfDigitsErrorDescription
	
	^'El numero de tarjeta no tiene 16 digitos.'! !


!CreditCard class methodsFor: 'asserting' stamp: 'fm 6/8/2022 20:22:21'!
assertNumberHas16Digits: aCreditCardNumber

	((aCreditCardNumber numberOfDigitsInBase: 10) = 16) ifFalse:[ self error: self invalidNumberOfDigitsErrorDescription ]! !

!CreditCard class methodsFor: 'asserting' stamp: 'fm 6/8/2022 20:22:26'!
assertOwnerNameIsNotBlank: anOwner

	anOwner withBlanksTrimmed isEmpty ifTrue:[ self error: self emptyOwnerNameErrorDescription ].! !


!classDefinition: #MerchantProcessorTestDouble category: 'TusLibros'!
Object subclass: #MerchantProcessorTestDouble
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorTestDouble methodsFor: 'paying' stamp: 'fm 6/8/2022 21:37:41'!
debit: anAmount from: aCreditCard

	self subclassResponsibility ! !


!classDefinition: #FailingMerchantProcessorTestDouble category: 'TusLibros'!
MerchantProcessorTestDouble subclass: #FailingMerchantProcessorTestDouble
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!FailingMerchantProcessorTestDouble methodsFor: 'paying' stamp: 'fm 6/8/2022 21:29:19'!
debit: anAmount from: aCreditCard

	self error: self class cannotProcessDebit! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FailingMerchantProcessorTestDouble class' category: 'TusLibros'!
FailingMerchantProcessorTestDouble class
	instanceVariableNames: ''!

!FailingMerchantProcessorTestDouble class methodsFor: 'as yet unclassified' stamp: 'fm 6/8/2022 21:38:15'!
cannotProcessDebit

	^ 'No se puede procesar el pago.'! !


!classDefinition: #WorkingMerchantProcessor category: 'TusLibros'!
MerchantProcessorTestDouble subclass: #WorkingMerchantProcessor
	instanceVariableNames: 'amountReceived timesCalled'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!WorkingMerchantProcessor methodsFor: 'accessing' stamp: 'fm 6/8/2022 21:01:59'!
amountReceived

	^ amountReceived! !


!WorkingMerchantProcessor methodsFor: 'initialization' stamp: 'fm 6/8/2022 21:43:17'!
initialize

	timesCalled := 0! !


!WorkingMerchantProcessor methodsFor: 'paying' stamp: 'fm 6/8/2022 21:43:09'!
debit: anAmount from: aCreditCard

	amountReceived := anAmount.
	timesCalled := timesCalled + 1! !

!WorkingMerchantProcessor methodsFor: 'paying' stamp: 'fm 6/8/2022 21:46:15'!
timesCalled

	^ timesCalled ! !
