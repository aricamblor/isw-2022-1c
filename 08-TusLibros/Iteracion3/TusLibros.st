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

!CartTest methodsFor: 'tests' stamp: 'AEC 6/12/2022 19:18:15'!
test09ListOfCartWithBooksReturnsBooksAndQuantities

	| cart catalog expectedResult |
	
	catalog := Dictionary with: 1->5 with: 2->2.5 with: 3->1.
	cart := Cart for: catalog.
	
	cart addBook: 1 quantity: 2.
	cart addBook: 2 quantity: 3.
	cart addBook: 3 quantity: 7.
	cart addBook: 1 quantity: 2.
	
	expectedResult := Bag new 
					add: 1 withOccurrences: 4;
					add: 2 withOccurrences: 3;
					add: 3 withOccurrences: 7; yourself.
					
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

!CheckoutTest methodsFor: 'test-support' stamp: 'fm 6/12/2022 11:29:46'!
cashierWithWorkingMerchantProcessor

	^ Cashier debitingTo: WorkingMerchantProcessor new! !

!CheckoutTest methodsFor: 'test-support' stamp: 'fm 6/12/2022 14:43:07'!
checkout: aCart using: aCashier debitingOn: aCreditCard registeringOn: aSalesList

	^ aCashier checkout: aCart for: 'ID' withCard: aCreditCard on: self today registeringOn: aSalesList! !

!CheckoutTest methodsFor: 'test-support' stamp: 'AEC 6/9/2022 17:58:32'!
defaultCart

	| cart |
	
	cart := Cart for: self defaultCatalog.
	cart addBook: 1 quantity: 1.
	cart addBook: 2 quantity: 2.
	
	^cart! !

!CheckoutTest methodsFor: 'test-support' stamp: 'AEC 6/9/2022 17:55:15'!
defaultCatalog

	^ Dictionary with: 1->5 with: 2->2.5! !

!CheckoutTest methodsFor: 'test-support' stamp: 'AEC 6/7/2022 21:33:55'!
expiredMonthOfYear
	
	^FixedGregorianDate today monthOfYear previous! !

!CheckoutTest methodsFor: 'test-support' stamp: 'AEC 6/6/2022 21:20:16'!
invalidCreditCardNumber

	^123! !

!CheckoutTest methodsFor: 'test-support' stamp: 'AEC 6/7/2022 21:34:03'!
nonExpiredMonthOfYear
	
	^FixedGregorianDate today monthOfYear next! !

!CheckoutTest methodsFor: 'test-support' stamp: 'fm 6/12/2022 12:11:15'!
today

	^ FixedGregorianDate today! !

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

!CheckoutTest methodsFor: 'tests' stamp: 'fm 6/12/2022 13:34:22'!
test03SaleIsNotRegisteredWhenCartIsEmpty
	
	| cart cashier salesList |
	
	cart := Cart for: self defaultCatalog.
	cashier := self cashierWithWorkingMerchantProcessor.
	salesList := OrderedCollection new.
	
	self should: [self checkout: cart using: cashier debitingOn: self validCreditCard registeringOn: salesList] 
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: Cashier emptyCartErrorDescription	 equals: anError messageText.
			self assert: salesList isEmpty
		]! !

!CheckoutTest methodsFor: 'tests' stamp: 'fm 6/12/2022 13:35:50'!
test04SaleIsNotRegisteredWhenCreditCardIsExpired
	
	| cart cashier creditCard salesList |
	
	cart := self defaultCart.
	
	salesList := OrderedCollection new.
	cashier := self cashierWithWorkingMerchantProcessor.
	creditCard := CreditCard for: 'Alan Kay' number: self validCreditCardNumber expiringOn: self expiredMonthOfYear.
	
	self should:[self checkout: cart using: cashier debitingOn: creditCard registeringOn: salesList]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: Cashier expiredCreditCardErrorDescription	 equals: anError messageText.
			self assert: salesList isEmpty
		]! !

!CheckoutTest methodsFor: 'tests' stamp: 'fm 6/12/2022 14:43:12'!
test05SaleIsRegisteredOnSalesListWithContentsAndPrice
	
	| cart cashier salesList |
	
	cart := self defaultCart.
	
	salesList := OrderedCollection new.
	cashier := self cashierWithWorkingMerchantProcessor.
	self checkout: cart using: cashier debitingOn: self validCreditCard registeringOn: salesList.
	
	self
		assert: 1 equals: salesList size;
		assert: cart listContents equals: salesList first items;
		assert: 5 + (2*2.5) equals: salesList first price;
		assert: (salesList first belongsTo: 'ID')! !

!CheckoutTest methodsFor: 'tests' stamp: 'fm 6/12/2022 13:41:31'!
test06ShouldNotSendToMerchantProcessorWhenNameIsTooLong
	
	| cart cashier salesList cardWithLongName merchantProcessor |
	
	cart := self defaultCart.
	
	merchantProcessor := WorkingMerchantProcessor new.
	salesList := OrderedCollection new.
	cashier := Cashier debitingTo: merchantProcessor.
	cardWithLongName := CreditCard for: 'Una Persona Con Un Nombre Super Muy Pero Muy Largo' number: self validCreditCardNumber expiringOn: self nonExpiredMonthOfYear.
	
	self
		should: [ self checkout: cart using: cashier debitingOn: cardWithLongName registeringOn: salesList ]
		raise: Error
		withExceptionDo: [:anError |
			self assert: anError messageText equals: Cashier nameTooLongToSendToMerchantProcessor.
			self assert: salesList isEmpty.
			self assert: merchantProcessor timesCalled isZero]! !

!CheckoutTest methodsFor: 'tests' stamp: 'fm 6/12/2022 13:41:49'!
test07ShouldNotSendToMerchantProcessorWhenAmountIsTooBig
	
	| cart cashier catalog salesList merchantProcessor |
	
	catalog := Dictionary with: 1->5000000000000000 with: 2->2.5.
	cart := Cart for: catalog.
	cart addBook: 1 quantity: 1.
	cart addBook: 2 quantity: 2.
	merchantProcessor := WorkingMerchantProcessor new.
	salesList := OrderedCollection new.
	cashier := Cashier debitingTo: merchantProcessor.
	
	self
		should: [ self checkout: cart using: cashier debitingOn: self validCreditCard registeringOn: salesList ]
		raise: Error
		withExceptionDo: [:anError |
			self assert: anError messageText equals: Cashier amountTooBigToSendToMerchantProcessor.
			self assert: salesList isEmpty.
			self assert: merchantProcessor timesCalled isZero ]! !

!CheckoutTest methodsFor: 'tests' stamp: 'fm 6/12/2022 13:42:28'!
test08AmountIsSentFormattedToMerchantProcessor
	
	| cart cashier merchantProcessor salesList |
	
	cart := self defaultCart.
	merchantProcessor := WorkingMerchantProcessor new.
	cashier := Cashier debitingTo: merchantProcessor.
	salesList := OrderedCollection new.
	self checkout: cart using: cashier debitingOn: self validCreditCard registeringOn: salesList.
	
	self assert: '10.00' equals: merchantProcessor amountToDebit! !

!CheckoutTest methodsFor: 'tests' stamp: 'fm 6/12/2022 13:42:59'!
test09CannotCheckoutWhenMerchantProcessorCannotProcessDebit
	
	| cart cashier salesList merchantProcessor |
	
	cart := self defaultCart.
	merchantProcessor := FailingMerchantProcessor new.
	salesList := OrderedCollection new.
	cashier := Cashier debitingTo: merchantProcessor.
	
	self
		should:	[ self checkout: cart using: cashier debitingOn: self validCreditCard registeringOn: salesList ]
		raise: Error
		withExceptionDo: [:anError |
			self assert: anError messageText equals: FailingMerchantProcessor cannotProcessDebit.
			self assert: salesList isEmpty ]! !


!classDefinition: #TusLibrosSystemFacadeTest category: 'TusLibros'!
TestCase subclass: #TusLibrosSystemFacadeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosSystemFacadeTest methodsFor: 'tests' stamp: 'AEC 6/13/2022 00:23:02'!
test01ListCartOfNewlyCreatedCartIsEmpty

	| cartID systemFacade |
	
	systemFacade := self defaultSystemFacade.
	
	cartID := self createCartWithDefaultCredentialsOn: systemFacade.
	
	self assert: Bag new equals: (systemFacade listCartWithID: cartID).
	
	
	
	
	
	
	! !

!TusLibrosSystemFacadeTest methodsFor: 'tests' stamp: 'AEC 6/13/2022 00:23:18'!
test02CannotCreateCartWithInvalidCredentials

	| systemFacade |
	
	systemFacade := self systemFacadeWithFailingAuthenticator.
	
	self
		should:[self createCartWithDefaultCredentialsOn: systemFacade]
		raise: Error
		withExceptionDo:[:anError |
			self assert: anError messageText equals: TusLibrosSystemFacade authenticationErrorMessage.	
		]
	
	
	
	
	
	! !

!TusLibrosSystemFacadeTest methodsFor: 'tests' stamp: 'AEC 6/13/2022 00:23:38'!
test03ListCartWithBooksAddedWillShowThem

	| systemFacade cartID expectedResult |
	
	systemFacade := self defaultSystemFacade.
	
	cartID := self createCartWithDefaultCredentialsOn: systemFacade.
	systemFacade addToCartWithID: cartID book: 1 quantity: 2.
	
	expectedResult := Bag new.
	expectedResult add: 1 withOccurrences: 2.
	
	self assert: expectedResult equals: (systemFacade listCartWithID: cartID)
	
	
	
	
	
	
	! !

!TusLibrosSystemFacadeTest methodsFor: 'tests' stamp: 'fm 6/11/2022 17:25:45'!
test04CannotAddBooksToInvalidCartID

	| systemFacade |
	
	systemFacade := self defaultSystemFacade.
	
	self 
		should:[systemFacade addToCartWithID: 1 book: 1 quantity: 2]
		raise: Error
		withExceptionDo:[:anError |
			self assert: anError messageText equals: TusLibrosSystemFacade invalidCartIDErrorMessage.
		]
	
	
	
	
	
	
	
	! !

!TusLibrosSystemFacadeTest methodsFor: 'tests' stamp: 'AEC 6/13/2022 00:24:46'!
test05SaleDoneThroughCheckoutCartAppearsOnListPurchasesOfCustomer

	| systemFacade cartID purchases expectedPurchasedItems |
	
	systemFacade := self defaultSystemFacade.
	
	cartID := self createCartWithDefaultCredentialsOn: systemFacade.
	systemFacade addToCartWithID: cartID book: 1 quantity: 2.
	systemFacade
		checkoutCartWithID: cartID 
		usingCreditCardNumber: self validCreditCardNumber 
		expiringOn: self nonExpiredMonthOfYear
		ownedBy: 'Alan Kay'.
	purchases := systemFacade listPurchasesOfCustomerID: self defaultID andPassword: self defaultPassword.
	
	expectedPurchasedItems := Bag new.
	expectedPurchasedItems add: 1 withOccurrences: 2.
	
	self
		assert: expectedPurchasedItems equals: purchases key;
		assert: 10 equals: purchases value! !

!TusLibrosSystemFacadeTest methodsFor: 'tests' stamp: 'AEC 6/13/2022 00:25:18'!
test06CantListPurchasesWithInvalidCredentials

	| systemFacade |
	
	systemFacade := self systemFacadeWithFailingAuthenticator.
	
	self 
		should: [systemFacade listPurchasesOfCustomerID: self defaultID andPassword: self defaultPassword ]
		raise: Error
		withMessageText: TusLibrosSystemFacade authenticationErrorMessage.
		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests' stamp: 'AEC 6/13/2022 00:23:56'!
test07CartIDIsNotValidAnymoreAfterCheckout

	| systemFacade cartID |
	
	systemFacade := self defaultSystemFacade.
	
	cartID := self createCartWithDefaultCredentialsOn: systemFacade.
	systemFacade addToCartWithID: cartID book: 1 quantity: 2.
	systemFacade
		checkoutCartWithID: cartID 
		usingCreditCardNumber: self validCreditCardNumber 
		expiringOn: self nonExpiredMonthOfYear
		ownedBy: 'Alan Kay'.
	
	self
		should: [systemFacade listCartWithID: cartID ]
		raise: Error
		withMessageText: TusLibrosSystemFacade invalidCartIDErrorMessage! !

!TusLibrosSystemFacadeTest methodsFor: 'tests' stamp: 'AEC 6/12/2022 23:35:20'!
test08CantAddItemsToExpiredCart

	self whenCartSessionExpiredCantDo: [ :systemFacade :cartID | 
		systemFacade addToCartWithID: cartID book: 1 quantity: 2. ]! !

!TusLibrosSystemFacadeTest methodsFor: 'tests' stamp: 'AEC 6/12/2022 23:35:20'!
test09CantListExpiredCart

	self whenCartSessionExpiredCantDo: [ :systemFacade :cartID | 
		systemFacade listCartWithID: cartID ]! !

!TusLibrosSystemFacadeTest methodsFor: 'tests' stamp: 'AEC 6/12/2022 23:51:37'!
test10CantCheckoutExpiredCart

	self whenCartSessionExpiredCantDo: [ :systemFacade :cartID | 
		systemFacade
				checkoutCartWithID: cartID 
				usingCreditCardNumber: self validCreditCardNumber 
				expiringOn: self nonExpiredMonthOfYear
				ownedBy: 'Alan Kay'.  
	]! !


!TusLibrosSystemFacadeTest methodsFor: 'test-support' stamp: 'AEC 6/13/2022 00:21:39'!
createCartWithDefaultCredentialsOn: aSystemFacade

	^ aSystemFacade createCartForCustomerID: self defaultID andPassword: self defaultPassword.! !

!TusLibrosSystemFacadeTest methodsFor: 'test-support' stamp: 'AEC 6/9/2022 20:36:32'!
defaultCatalog
	
	^ Dictionary with: 1->5 with: 2->2.5! !

!TusLibrosSystemFacadeTest methodsFor: 'test-support' stamp: 'AEC 6/13/2022 00:22:12'!
defaultID

	^ 'ID'! !

!TusLibrosSystemFacadeTest methodsFor: 'test-support' stamp: 'AEC 6/13/2022 00:22:19'!
defaultPassword

	^ 'Password'! !

!TusLibrosSystemFacadeTest methodsFor: 'test-support' stamp: 'AEC 6/12/2022 23:25:33'!
defaultSystemFacade

	^ TusLibrosSystemFacade withCatalog: self defaultCatalog withAuthenticator: WorkingAuthenticator new andMerchantProcessor: WorkingMerchantProcessor new andClock: ClockTestDouble new.! !

!TusLibrosSystemFacadeTest methodsFor: 'test-support' stamp: 'AEC 6/12/2022 23:51:13'!
nonExpiredMonthOfYear
	
	^FixedGregorianDate today monthOfYear next! !

!TusLibrosSystemFacadeTest methodsFor: 'test-support' stamp: 'AEC 6/13/2022 00:17:32'!
systemFacadeWithFailingAuthenticator

	^ TusLibrosSystemFacade withCatalog: self defaultCatalog withAuthenticator: FailingAuthenticator new andMerchantProcessor: WorkingMerchantProcessor new andClock: ClockTestDouble new.! !

!TusLibrosSystemFacadeTest methodsFor: 'test-support' stamp: 'AEC 6/9/2022 21:14:43'!
validCreditCardNumber
	
	^1234567890123456! !

!TusLibrosSystemFacadeTest methodsFor: 'test-support' stamp: 'AEC 6/13/2022 00:24:18'!
whenCartSessionExpiredCantDo: aBlock

	| systemFacade cartID clock time |
	
	time := GregorianDateTime now.
	clock := ClockTestDouble new.
	
	systemFacade := TusLibrosSystemFacade withCatalog: self defaultCatalog withAuthenticator: WorkingAuthenticator new andMerchantProcessor: WorkingMerchantProcessor new andClock: clock.
	
	cartID := self createCartWithDefaultCredentialsOn: systemFacade. 
	
	clock changeTime: (time next: 31 * minute).
	
	self
		should: [aBlock value: systemFacade value: cartID]
		raise: Error
		withMessageText: TusLibrosSystemFacade expiredCartErrorMessage! !


!classDefinition: #AuthenticatorTestDouble category: 'TusLibros'!
Object subclass: #AuthenticatorTestDouble
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!AuthenticatorTestDouble methodsFor: 'authentication' stamp: 'AEC 6/9/2022 20:57:46'!
authenticateUserID: aCustomerID withPassword: aPassword

	self subclassResponsibility ! !


!classDefinition: #FailingAuthenticator category: 'TusLibros'!
AuthenticatorTestDouble subclass: #FailingAuthenticator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!FailingAuthenticator methodsFor: 'authentication' stamp: 'AEC 6/9/2022 21:32:56'!
authenticateUserID: aCustomerID withPassword: aPassword

	^false ! !


!classDefinition: #WorkingAuthenticator category: 'TusLibros'!
AuthenticatorTestDouble subclass: #WorkingAuthenticator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!WorkingAuthenticator methodsFor: 'authentication' stamp: 'AEC 6/9/2022 21:33:04'!
authenticateUserID: aCustomerID withPassword: aPassword

	^true! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'books catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'accessing' stamp: 'AEC 6/12/2022 19:15:55'!
listContents
	
	^books copy! !


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


!Cart methodsFor: 'evaluating' stamp: 'AEC 6/13/2022 00:02:03'!
totalPrice

	^books sum:[ :aBookISBN |  catalog at: aBookISBN ]! !


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


!Cart class methodsFor: 'error description' stamp: 'AEC 6/5/2022 19:35:59'!
bookNotInCatalogErrorDescription
	
	^'El libro no se encuentra en el catalogo.'! !

!Cart class methodsFor: 'error description' stamp: 'AEC 6/6/2022 18:59:02'!
nonIntegerBookQuantityErrorDescription
	
	^'La cantidad de libros a agregar no es un numero entero.'! !

!Cart class methodsFor: 'error description' stamp: 'AEC 6/5/2022 20:08:12'!
nonPositiveBookQuantityErrorDescription
	
	^'La cantidad de libros a agregar no es positiva.'! !


!classDefinition: #CartSession category: 'TusLibros'!
Object subclass: #CartSession
	instanceVariableNames: 'customerID cart lastAccessTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartSession methodsFor: 'accessing' stamp: 'fm 6/12/2022 12:34:33'!
cart

	^ cart! !

!CartSession methodsFor: 'accessing' stamp: 'fm 6/12/2022 12:34:43'!
customerID

	^ customerID! !

!CartSession methodsFor: 'accessing' stamp: 'AEC 6/12/2022 22:42:27'!
isExpiredAt: aGregorianDateTime

	^ (lastAccessTime distanceTo: aGregorianDateTime) > (30 * minute)! !


!CartSession methodsFor: 'initialization' stamp: 'AEC 6/12/2022 22:33:00'!
initializeFor: aCart belongingTo: aCustomerID at: aGregorianDateTime 

	cart := aCart.
	customerID := aCustomerID.
	lastAccessTime := aGregorianDateTime ! !


!CartSession methodsFor: 'updating' stamp: 'AEC 6/12/2022 22:33:34'!
updateLastAccessTime: aGregorianDateTime

	lastAccessTime := aGregorianDateTime ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartSession class' category: 'TusLibros'!
CartSession class
	instanceVariableNames: ''!

!CartSession class methodsFor: 'instance creation' stamp: 'AEC 6/12/2022 23:10:35'!
for: aCart belongingTo: aCustomerID at: aGregorianDateTime 

	^ self new initializeFor: aCart belongingTo: aCustomerID at: aGregorianDateTime ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'merchantProcessor lastTransactionID'
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


!Cashier methodsFor: 'initialization' stamp: 'AEC 6/12/2022 19:19:41'!
initializeDebitingTo: aMerchantProcessor 
	
	merchantProcessor := aMerchantProcessor.
	lastTransactionID := 0! !


!Cashier methodsFor: 'paying' stamp: 'AEC 6/13/2022 00:04:31'!
checkout: aCart for: aCustomerID withCard: aCreditCard on: aGregorianDate registeringOn: aSalesList 

	| price transactionID |
	
	self assertCartIsNotEmpty: aCart.
	price := aCart totalPrice.
	(aCreditCard isExpiredOn: aGregorianDate) ifTrue:[self error: self class expiredCreditCardErrorDescription].
	self assertNameIsValidToSendToMerchantProcessor: aCreditCard.
	self assertAmountIsValidToSendToMerchantProcessor: price.
	
	merchantProcessor debit: (self formatAmount: price) from: aCreditCard.

	transactionID := self nextTransactionID.
	aSalesList add: (Sale of: aCart listContents totalling: price to: aCustomerID withTransactionID: transactionID).
	
	^transactionID! !


!Cashier methodsFor: 'paying - private' stamp: 'fm 6/8/2022 21:07:39'!
formatAmount: anAmount

	^ anAmount printStringFractionDigits: 2! !


!Cashier methodsFor: 'transaction id' stamp: 'AEC 6/12/2022 19:05:57'!
nextTransactionID
	
	lastTransactionID := lastTransactionID + 1.
	^lastTransactionID! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error description' stamp: 'fm 6/8/2022 20:29:42'!
amountTooBigToSendToMerchantProcessor
	
	^'El monto puede tener hasta 15 digitos.'! !

!Cashier class methodsFor: 'error description' stamp: 'AEC 6/6/2022 19:10:13'!
emptyCartErrorDescription
	
	^ 'El carrito esta vacio.'! !

!Cashier class methodsFor: 'error description' stamp: 'AEC 6/7/2022 21:17:36'!
expiredCreditCardErrorDescription
	
	^'La tarjeta de credito esta vencida.'! !

!Cashier class methodsFor: 'error description' stamp: 'fm 6/8/2022 20:13:35'!
nameTooLongToSendToMerchantProcessor
	
	^'El nombre del cliente debe tener como maximo 30 digitos.'! !


!Cashier class methodsFor: 'instance creation' stamp: 'fm 6/11/2022 18:04:31'!
debitingTo: aMerchantProcessor
	
	^self new initializeDebitingTo: aMerchantProcessor ! !


!classDefinition: #ClockTestDouble category: 'TusLibros'!
Object subclass: #ClockTestDouble
	instanceVariableNames: 'time'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ClockTestDouble methodsFor: 'initialization' stamp: 'AEC 6/12/2022 23:25:08'!
initialize

	time := GregorianDateTime now.! !


!ClockTestDouble methodsFor: 'accessing' stamp: 'AEC 6/12/2022 22:35:18'!
now

	^ time! !


!ClockTestDouble methodsFor: 'updating' stamp: 'AEC 6/12/2022 22:37:16'!
changeTime: aGregorianDateTime

	time := aGregorianDateTime! !


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


!CreditCard class methodsFor: 'error description' stamp: 'AEC 6/6/2022 21:06:22'!
emptyOwnerNameErrorDescription
	
	^ 'El nombre de titular de la tarjeta esta vacio'! !

!CreditCard class methodsFor: 'error description' stamp: 'AEC 6/6/2022 21:12:37'!
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


!classDefinition: #FailingMerchantProcessor category: 'TusLibros'!
MerchantProcessorTestDouble subclass: #FailingMerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!FailingMerchantProcessor methodsFor: 'paying' stamp: 'fm 6/8/2022 21:29:19'!
debit: anAmount from: aCreditCard

	self error: self class cannotProcessDebit! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FailingMerchantProcessor class' category: 'TusLibros'!
FailingMerchantProcessor class
	instanceVariableNames: ''!

!FailingMerchantProcessor class methodsFor: 'as yet unclassified' stamp: 'fm 6/8/2022 21:38:15'!
cannotProcessDebit

	^ 'No se puede procesar el pago.'! !


!classDefinition: #WorkingMerchantProcessor category: 'TusLibros'!
MerchantProcessorTestDouble subclass: #WorkingMerchantProcessor
	instanceVariableNames: 'amountToDebit timesCalled'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!WorkingMerchantProcessor methodsFor: 'accessing' stamp: 'fm 6/12/2022 11:59:23'!
amountToDebit

	^ amountToDebit! !


!WorkingMerchantProcessor methodsFor: 'initialization' stamp: 'fm 6/8/2022 21:43:17'!
initialize

	timesCalled := 0! !


!WorkingMerchantProcessor methodsFor: 'paying' stamp: 'fm 6/12/2022 11:51:48'!
debit: anAmount from: aCreditCard

	amountToDebit := anAmount.
	timesCalled := timesCalled + 1! !

!WorkingMerchantProcessor methodsFor: 'paying' stamp: 'fm 6/8/2022 21:46:15'!
timesCalled

	^ timesCalled ! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'items price customerID transactionID'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'accessing' stamp: 'fm 6/12/2022 13:55:21'!
belongsTo: aCustomerID

	^ aCustomerID = customerID! !

!Sale methodsFor: 'accessing' stamp: 'AEC 6/12/2022 20:24:34'!
items

	^ items copy! !

!Sale methodsFor: 'accessing' stamp: 'fm 6/12/2022 14:30:39'!
price

	^ price! !


!Sale methodsFor: 'initialization' stamp: 'AEC 6/12/2022 19:03:37'!
initializeOf: itemsSold totalling: aPrice to: aCustomerID withTransactionID: aTransactionID  

	transactionID := aTransactionID.
	items := itemsSold.
	price := aPrice.
	customerID := aCustomerID! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'AEC 6/12/2022 23:54:15'!
of: itemsSold totalling: aPrice to: aCustomerID withTransactionID: aTransactionID  

	^ self new initializeOf: itemsSold totalling: aPrice to: aCustomerID withTransactionID: aTransactionID ! !


!classDefinition: #TusLibrosSystemFacade category: 'TusLibros'!
Object subclass: #TusLibrosSystemFacade
	instanceVariableNames: 'cartSessions lastCartID catalog authenticator cashier salesList clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosSystemFacade methodsFor: 'accessing - private' stamp: 'AEC 6/12/2022 21:27:29'!
cartSessionFor: aCartID

	^ cartSessions at: aCartID ifAbsent: [self error: self class invalidCartIDErrorMessage]! !

!TusLibrosSystemFacade methodsFor: 'accessing - private' stamp: 'AEC 6/9/2022 20:35:10'!
emptyCart
	
	^Cart for: catalog! !

!TusLibrosSystemFacade methodsFor: 'accessing - private' stamp: 'AEC 6/12/2022 19:47:26'!
getAllPurchasesFrom: aCustomerID

	| customerPurchases totalAmount |
	
	customerPurchases := Bag new.
	totalAmount := 0.
	
	salesList do: [:aSale | (aSale belongsTo: aCustomerID) ifTrue: [
			customerPurchases addAll: aSale items.
			totalAmount := totalAmount + aSale price.
	]].

	^ customerPurchases -> totalAmount ! !


!TusLibrosSystemFacade methodsFor: 'operating' stamp: 'fm 6/11/2022 19:03:51'!
ifCanAuthenticateUsing: aCustomerID and: aPassword do: aBlock

	(authenticator authenticateUserID: aCustomerID withPassword: aPassword)
		ifTrue: aBlock
		ifFalse: [ self error: self class authenticationErrorMessage ]! !

!TusLibrosSystemFacade methodsFor: 'operating' stamp: 'AEC 6/12/2022 23:16:08'!
ifSessionNotExpiredFor: aCartID do: aBlock

	| currentTime cartSession |
	
	cartSession := self cartSessionFor: aCartID. 
	currentTime := clock now.
	(cartSession isExpiredAt: currentTime)
		ifTrue: [ self error: self class expiredCartErrorMessage ]
		ifFalse: [ 
			cartSession updateLastAccessTime: currentTime.
			aBlock value: cartSession
		]! !


!TusLibrosSystemFacade methodsFor: 'id creation' stamp: 'fm 6/11/2022 18:21:12'!
nextCartID
	
	lastCartID := lastCartID + 1.
	^lastCartID! !


!TusLibrosSystemFacade methodsFor: 'initialization' stamp: 'AEC 6/12/2022 22:09:54'!
initializeWithCatalog: aCatalog withAuthenticator: anAuthenticator andMerchantProcessor: aMerchantProcessor andClock: aClock 
	
	lastCartID := 0.
	cartSessions := Dictionary new.
	catalog := aCatalog.
	authenticator := anAuthenticator.
	cashier := Cashier debitingTo: aMerchantProcessor.
	salesList := OrderedCollection new.
	clock := aClock! !


!TusLibrosSystemFacade methodsFor: 'interface' stamp: 'AEC 6/12/2022 23:17:23'!
addToCartWithID: aCartID book: aBook quantity: aQuantity

	self ifSessionNotExpiredFor: aCartID do: [:aCartSession |
		aCartSession cart addBook: aBook quantity: aQuantity
	]! !

!TusLibrosSystemFacade methodsFor: 'interface' stamp: 'AEC 6/12/2022 23:46:54'!
checkoutCartWithID: aCartID usingCreditCardNumber: aCreditCardNumber expiringOn: aMonthOfYear ownedBy: anOwner

	| creditCard transactionID |
	
	creditCard := CreditCard for: anOwner number: aCreditCardNumber expiringOn: aMonthOfYear.
	
	self ifSessionNotExpiredFor: aCartID do: [:aCartSession |
		transactionID := cashier checkout: aCartSession cart for: aCartSession customerID withCard: creditCard on: clock now registeringOn: salesList.
		
		self invalidateCartSessionFor: aCartID.
		
		^transactionID
	] ! !

!TusLibrosSystemFacade methodsFor: 'interface' stamp: 'AEC 6/12/2022 23:10:35'!
createCartForCustomerID: aCustomerID andPassword: aPassword

	| newID |

	self
		ifCanAuthenticateUsing: aCustomerID
		and: aPassword
		do: [
			newID := self nextCartID.
			cartSessions at: newID put: (CartSession for: self emptyCart belongingTo: aCustomerID at: clock now)
		].

	^ newID! !

!TusLibrosSystemFacade methodsFor: 'interface' stamp: 'AEC 6/12/2022 23:16:51'!
listCartWithID: aCartID

	self ifSessionNotExpiredFor: aCartID do: [:aCartSession |
		 ^aCartSession cart listContents
	]
	
	! !

!TusLibrosSystemFacade methodsFor: 'interface' stamp: 'AEC 6/12/2022 19:48:01'!
listPurchasesOfCustomerID: aCustomerID andPassword: aPassword
	
	self
		ifCanAuthenticateUsing: aCustomerID
		and: aPassword
		do: [ ^self getAllPurchasesFrom: aCustomerID ].
	
	! !


!TusLibrosSystemFacade methodsFor: 'checkout - private' stamp: 'AEC 6/12/2022 23:12:56'!
invalidateCartSessionFor: aCartID

	^ cartSessions removeKey: aCartID! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosSystemFacade class' category: 'TusLibros'!
TusLibrosSystemFacade class
	instanceVariableNames: ''!

!TusLibrosSystemFacade class methodsFor: 'instance creation' stamp: 'AEC 6/12/2022 22:34:51'!
withCatalog: aCatalog withAuthenticator: anAuthenticator andMerchantProcessor: aMerchantProcessor andClock: aClock 
	
	^self new initializeWithCatalog: aCatalog withAuthenticator: anAuthenticator andMerchantProcessor: aMerchantProcessor andClock: aClock! !


!TusLibrosSystemFacade class methodsFor: 'error-description' stamp: 'AEC 6/9/2022 21:32:04'!
authenticationErrorMessage

	^'Error al autenticarse.'! !

!TusLibrosSystemFacade class methodsFor: 'error-description' stamp: 'AEC 6/12/2022 21:47:41'!
expiredCartErrorMessage
	
	^'El carrito ha expirado.'! !

!TusLibrosSystemFacade class methodsFor: 'error-description' stamp: 'AEC 6/9/2022 21:08:12'!
invalidCartIDErrorMessage
	
	^'El ID de carrito no es valido.'! !
