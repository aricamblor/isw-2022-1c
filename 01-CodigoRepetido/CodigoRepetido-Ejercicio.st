!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing-support' stamp: 'AEC 4/14/2022 17:54:03'!
assertCustomerBook: customerBook hasOnlyACustomerAndItsNamed: customerName
	
	self assert: customerBook numberOfCustomers = 1.
	self assert: (customerBook includesCustomerNamed: customerName).! !

!CustomerBookTest methodsFor: 'testing-support' stamp: 'AEC 4/16/2022 12:41:04'!
assertCustomerBook: aCustomerBook numberOfActiveCustomersIs: aNumberOfActiveCustomers andNumberOfSuspendedCustomersIs: aNumberOfSuspendedCustomers

	self assert: aNumberOfActiveCustomers equals: aCustomerBook numberOfActiveCustomers.
	self assert: aNumberOfSuspendedCustomers equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: aNumberOfActiveCustomers + aNumberOfSuspendedCustomers equals: aCustomerBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'testing-support' stamp: 'AEC 4/14/2022 17:51:57'!
assertRunningTimeOf: aBlock isLessThan: aTimeMeasure
	
	| runningTimeInMilliseconds |
	
	runningTimeInMilliseconds := self measureRunningTimeInMillisecondsOf: aBlock.
	
	self assert: runningTimeInMilliseconds < aTimeMeasure
	
! !

!CustomerBookTest methodsFor: 'testing-support' stamp: 'AEC 4/14/2022 17:10:26'!
measureRunningTimeInMillisecondsOf: aBlock

	| millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aBlock value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	^ millisecondsAfterRunning-millisecondsBeforeRunning! !

!CustomerBookTest methodsFor: 'testing-support' stamp: 'AEC 4/14/2022 18:10:24'!
newCustomerBookWithActiveCustomerNamed: customerName
	
	| customerBook |
	
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: customerName.
	
	^customerBook ! !

!CustomerBookTest methodsFor: 'testing-support' stamp: 'AEC 4/14/2022 18:15:48'!
newCustomerBookWithSuspendedCustomerNamed: customerName
	
	| customerBook |
	
	customerBook := self newCustomerBookWithActiveCustomerNamed: customerName. 
	customerBook suspendCustomerNamed: customerName.
	
	^customerBook ! !


!CustomerBookTest methodsFor: 'testing' stamp: 'AEC 4/14/2022 17:11:15'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook addCustomerBlock |
	
	customerBook := CustomerBook new.
	addCustomerBlock := [customerBook addCustomerNamed: 'John Lennon'].
	
	self assertRunningTimeOf: addCustomerBlock isLessThan: 50 * millisecond.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AEC 4/14/2022 18:11:50'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook  paulMcCartney removeCustomerBlock |
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self newCustomerBookWithActiveCustomerNamed: paulMcCartney.
	
	removeCustomerBlock := [customerBook removeCustomerNamed: paulMcCartney].
	
	self assertRunningTimeOf: removeCustomerBlock isLessThan: 100 * millisecond.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AEC 4/16/2022 12:26:44'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
		
	self should: [customerBook addCustomerNamed: ''.]
		raise: Error
		withExceptionDo: [ :anError | 		self assert: customerBook isEmpty ]
		description: CustomerBook customerCanNotBeEmptyErrorMessage! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AEC 4/16/2022 12:27:45'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook := self newCustomerBookWithActiveCustomerNamed: johnLennon.
	
	self should: [ customerBook removeCustomerNamed: 'Paul McCartney'.]
		raise: NotFound 
		withExceptionDo: [ :anError | self assertCustomerBook: customerBook hasOnlyACustomerAndItsNamed: johnLennon].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AEC 4/16/2022 12:42:00'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self newCustomerBookWithSuspendedCustomerNamed: paulMcCartney.
	
	self assertCustomerBook: customerBook numberOfActiveCustomersIs: 0 andNumberOfSuspendedCustomersIs: 1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AEC 4/16/2022 12:41:47'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self newCustomerBookWithSuspendedCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assertCustomerBook: customerBook numberOfActiveCustomersIs: 0 andNumberOfSuspendedCustomersIs: 0.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AEC 4/16/2022 12:28:27'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook := self newCustomerBookWithActiveCustomerNamed: johnLennon .
	
	self should: [ customerBook suspendCustomerNamed: 'George Harrison'.]
		raise: CantSuspend 
		withExceptionDo: [ :anError | self assertCustomerBook: customerBook hasOnlyACustomerAndItsNamed: johnLennon].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AEC 4/16/2022 12:28:57'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook := self newCustomerBookWithSuspendedCustomerNamed: johnLennon.
	
	self should: [ customerBook suspendCustomerNamed: johnLennon.]
		raise: CantSuspend 
		withExceptionDo: [ :anError | 		self assertCustomerBook: customerBook hasOnlyACustomerAndItsNamed: johnLennon].
! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'AEC 4/14/2022 19:15:29'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'AEC 4/14/2022 19:21:57'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'AEC 4/14/2022 19:03:30'!
removeCustomerNamed: aName 
 
	active remove: aName ifAbsent: [suspended remove: aName ifAbsent: [^NotFound signal]].! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'AEC 4/14/2022 19:11:39'!
suspendCustomerNamed: aName 
	
	active detect: [:element | element = aName] 
		ifFound: [:element | active remove: element. suspended add: element] 
		ifNone: [^CantSuspend signal]
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/11/2022 07:18:12'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/11/2022 07:18:16'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !
