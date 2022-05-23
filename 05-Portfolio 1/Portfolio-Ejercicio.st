!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'test support' stamp: 'AEC 5/16/2022 21:44:55'!
accountWithDepositOf: anAmount

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: anAmount on: account.
	^account ! !

!PortfolioTest methodsFor: 'test support' stamp: 'AEC 5/22/2022 21:41:40'!
portfolioChildOfPortfolioWithAccount: anAccount

	| childPortfolio rootPortfolio |

	rootPortfolio := self portfolioWithAccount: anAccount.
	childPortfolio := Portfolio new.

	rootPortfolio add: childPortfolio.
	
	^childPortfolio! !

!PortfolioTest methodsFor: 'test support' stamp: 'AEC 5/22/2022 21:56:42'!
portfolioGrandchildOfPortfolioWithAccount: anAccount

	| childPortfolio grandchildPortfolio |

	childPortfolio := self portfolioChildOfPortfolioWithAccount: anAccount.
	grandchildPortfolio := Portfolio new.

	childPortfolio add: grandchildPortfolio.
	
	^grandchildPortfolio! !

!PortfolioTest methodsFor: 'test support' stamp: 'AEC 5/22/2022 23:37:26'!
portfolioGrandparentOfPortfolioWithAccount: anAccount

	| childPortfolio rootPortfolio |
	
	childPortfolio := self portfolioParentOfPortfolioWithAccount: anAccount.
	rootPortfolio := self portfolioWith: (OrderedCollection with: childPortfolio).
	
	^rootPortfolio! !

!PortfolioTest methodsFor: 'test support' stamp: 'AEC 5/22/2022 23:38:55'!
portfolioParentOfPortfolioWithAccount: anAccount

	| childPortfolio rootPortfolio |
	
	childPortfolio := self portfolioWithAccount: anAccount. 
	rootPortfolio := self portfolioWith: (OrderedCollection with: childPortfolio).
	
	^rootPortfolio! !

!PortfolioTest methodsFor: 'test support' stamp: 'AEC 5/22/2022 22:02:17'!
portfolioWith: aCollectionOfAccountTreeElements

	| portfolio |
	
	portfolio := Portfolio new.
	aCollectionOfAccountTreeElements do:[ :treeElement | portfolio add: treeElement ].
	^portfolio! !

!PortfolioTest methodsFor: 'test support' stamp: 'AEC 5/22/2022 22:12:39'!
portfolioWithAccount: anAccount

	^ self portfolioWith: (OrderedCollection with: anAccount)! !


!PortfolioTest methodsFor: 'testing' stamp: 'AEC 5/19/2022 20:07:44'!
test01EmptyPortfolioBalanceIsZero

	| portfolio |
	
	portfolio := Portfolio new.
	
	self assert: portfolio balance equals: 0! !

!PortfolioTest methodsFor: 'testing' stamp: 'AEC 5/22/2022 22:45:54'!
test02PortfolioBalanceWhenHavingOneAccountEqualsAccountBalance

	| portfolio |
	
	portfolio := self portfolioWithAccount: (self accountWithDepositOf: 100).
	
	self assert: portfolio balance equals: 100! !

!PortfolioTest methodsFor: 'testing' stamp: 'AEC 5/22/2022 22:43:43'!
test03PortfolioBalanceWhenHavingTwoAccountsEqualsSumOfBothBalances

	| portfolio |
	
	portfolio := self portfolioWith: (OrderedCollection with: (self accountWithDepositOf: 100) with: (self accountWithDepositOf: 200)).
	
	self assert: portfolio balance equals: 300! !

!PortfolioTest methodsFor: 'testing' stamp: 'AEC 5/22/2022 22:45:00'!
test04PortfolioBalanceWhenHavingOnePortfolioEqualsThatPortfolioBalance

	| portfolio |
	
	portfolio := self portfolioParentOfPortfolioWithAccount: (self accountWithDepositOf: 100).
	
	self assert: portfolio balance equals: 100! !

!PortfolioTest methodsFor: 'testing' stamp: 'AEC 5/22/2022 22:42:36'!
test05PortfolioBalanceWhenHavingTwoPortfoliosEqualsSumOfBothBalances

	| portfolio firstPortfolioToAdd secondPortfolioToAdd |
	
	firstPortfolioToAdd := self portfolioWithAccount: (self accountWithDepositOf: 100).
	secondPortfolioToAdd := self portfolioWithAccount: (self accountWithDepositOf: 200).
	
	portfolio := self portfolioWith: (OrderedCollection with: firstPortfolioToAdd with: secondPortfolioToAdd ).
	
	self assert: portfolio balance equals: 300! !

!PortfolioTest methodsFor: 'testing' stamp: 'AEC 5/19/2022 21:00:21'!
test06EmptyPortfolioHasNotRegisteredATransaction
	
	| account portfolio transaction |
	
	account := ReceptiveAccount new.
	transaction := Deposit register: 100 on: account.
	portfolio := Portfolio new.
	
	self deny: (portfolio hasRegistered: transaction)! !

!PortfolioTest methodsFor: 'testing' stamp: 'AEC 5/19/2022 21:01:18'!
test07PortfolioWithOneAccountHasRegisteredATransactionFromThatAccount
	
	| account portfolio transaction |
	
	account := ReceptiveAccount new.
	transaction := Deposit register: 100 on: account.
	portfolio := self portfolioWithAccount: account.
	
	self assert: (portfolio hasRegistered: transaction)! !

!PortfolioTest methodsFor: 'testing' stamp: 'AEC 5/19/2022 21:06:24'!
test08PortfolioWithOneAccountHasNotRegisteredATransactionFromAnotherAccount
	
	| accountWithTransaction portfolio transaction accountWithoutTransaction |
	
	accountWithTransaction := ReceptiveAccount new.
	transaction := Deposit register: 100 on: accountWithTransaction.
	
	accountWithoutTransaction := self accountWithDepositOf: 200.
	
	portfolio := self portfolioWithAccount: accountWithoutTransaction.
	
	self deny: (portfolio hasRegistered: transaction)! !

!PortfolioTest methodsFor: 'testing' stamp: 'AEC 5/22/2022 22:27:28'!
test09PortfolioWithTwoAccountsHasRegisteredATransactionFromTheSecondAccount
	
	| accountWithTransactionToAssert portfolio transactionToAssert otherAccount |
	
	accountWithTransactionToAssert := ReceptiveAccount new.
	transactionToAssert := Deposit register: 100 on: accountWithTransactionToAssert.
	
	otherAccount := self accountWithDepositOf: 200.
	
	portfolio := self portfolioWith: (OrderedCollection with: otherAccount with: accountWithTransactionToAssert ).
	
	self assert: (portfolio hasRegistered: transactionToAssert)! !

!PortfolioTest methodsFor: 'testing' stamp: 'AEC 5/22/2022 21:43:23'!
test10PortfolioWithOnePortfolioHasRegisteredATransactionFromThatPortfolio
	
	| account rootPortfolio transaction |
	
	account := ReceptiveAccount new.
	transaction := Deposit register: 100 on: account.
	rootPortfolio := self portfolioParentOfPortfolioWithAccount: account. 
	
	self assert: (rootPortfolio hasRegistered: transaction)! !

!PortfolioTest methodsFor: 'testing' stamp: 'AEC 5/22/2022 21:43:23'!
test11PortfolioWithOnePortfolioHasNotRegisteredATransactionFromAnAccountNotInThatPortfolio
	
	| accountWithTransactionToAssert rootPortfolio transactionToAssert |
	
	accountWithTransactionToAssert := ReceptiveAccount new.
	transactionToAssert := Deposit register: 100 on: accountWithTransactionToAssert.
	
	rootPortfolio := self portfolioParentOfPortfolioWithAccount: (self accountWithDepositOf: 300).
	
	self deny: (rootPortfolio hasRegistered: transactionToAssert)! !

!PortfolioTest methodsFor: 'testing' stamp: 'AEC 5/22/2022 22:25:52'!
test12PortfolioWithTwoPortfoliosHasRegisteredATransactionFromSecondPortfolio
	
	| accountWithTransactionToAssert rootPortfolio transactionToAssert otherAccount childPortfolioWithTransactionToAssert |
	
	accountWithTransactionToAssert := ReceptiveAccount new.
	transactionToAssert := Deposit register: 100 on: accountWithTransactionToAssert.
	childPortfolioWithTransactionToAssert := self portfolioWithAccount: accountWithTransactionToAssert.
	
	otherAccount := self accountWithDepositOf: 300.	
	
	rootPortfolio := self portfolioParentOfPortfolioWithAccount: otherAccount.
	rootPortfolio add: childPortfolioWithTransactionToAssert.
	
	self assert: (rootPortfolio hasRegistered: transactionToAssert)! !

!PortfolioTest methodsFor: 'testing' stamp: 'AEC 5/19/2022 21:42:39'!
test13EmptyPortfolioHasNoTransactions

	| portfolio |
	
	portfolio := Portfolio new.
	
	self assert: portfolio transactions isEmpty! !

!PortfolioTest methodsFor: 'testing' stamp: 'AEC 5/19/2022 21:43:32'!
test14PortfolioWithOneAccountTransactionsAreThatAccountTransactions

	| portfolio account |
	
	account := self accountWithDepositOf: 300.
	portfolio := self portfolioWithAccount: account.
	
	self assert: portfolio transactions equals: account transactions.! !

!PortfolioTest methodsFor: 'testing' stamp: 'AEC 5/22/2022 22:20:30'!
test15PortfolioWithTwoAccountsTransactionsAreBothAccountTransactions

	| portfolio otherAccount account |
	
	account := self accountWithDepositOf: 300.
	otherAccount := self accountWithDepositOf: 300.
	
	portfolio := self portfolioWith: (OrderedCollection with: account with: otherAccount ).
	
	self assert: portfolio transactions equals: account transactions,(otherAccount transactions).! !

!PortfolioTest methodsFor: 'testing' stamp: 'AEC 5/22/2022 22:18:42'!
test16PortfolioWithOnePortfolioTransactionsAreThatPortfolioTransactions
	
	| childPortfolio rootPortfolio |
	
	childPortfolio := self portfolioWithAccount: (self accountWithDepositOf: 200).
	
	rootPortfolio := self portfolioWith: (OrderedCollection with: childPortfolio).
	
	self assert: rootPortfolio transactions equals: childPortfolio transactions.! !

!PortfolioTest methodsFor: 'testing' stamp: 'AEC 5/22/2022 22:17:37'!
test17PortfolioWithTwoPortfolioTransactionsAreBothPortfoliosTransactions
	
	| childPortfolio rootPortfolio anotherChildPortfolio |
	
	childPortfolio := self portfolioWithAccount: (self accountWithDepositOf: 200).
	anotherChildPortfolio := self portfolioWithAccount: (self accountWithDepositOf: 300).
	
	rootPortfolio := self portfolioWith: (OrderedCollection with: childPortfolio with: anotherChildPortfolio ).
	
	self assert: rootPortfolio transactions equals: childPortfolio transactions,(anotherChildPortfolio transactions).! !

!PortfolioTest methodsFor: 'testing' stamp: 'AEC 5/22/2022 23:03:57'!
test18PortfolioCantAddSameAccountTwice

	| account portfolio |
	
	account := self accountWithDepositOf: 100.
	portfolio := self portfolioWithAccount: account.
	
	self should: [ portfolio add: account ] raise: Error description: Portfolio duplicatedAccountErrorDescription! !

!PortfolioTest methodsFor: 'testing' stamp: 'AEC 5/22/2022 23:04:49'!
test19PortfolioCantAddAccountIfHasAChildPortfolioContainingThatAccount

	| account portfolio |
	
	account := self accountWithDepositOf: 100.
	portfolio := self portfolioParentOfPortfolioWithAccount: account.
	
	self should: [ portfolio add: account ] raise: Error description: Portfolio duplicatedAccountErrorDescription.! !

!PortfolioTest methodsFor: 'testing' stamp: 'AEC 5/22/2022 23:07:35'!
test20PortfolioCantAddAccountIfHasAParentContainingThatAccount

	| account portfolio |
	
	account := self accountWithDepositOf: 100.
	portfolio := self portfolioChildOfPortfolioWithAccount: account.
	
	self should: [ portfolio add: account ] raise: Error description: Portfolio duplicatedAccountErrorDescription! !

!PortfolioTest methodsFor: 'testing' stamp: 'AEC 5/22/2022 23:08:37'!
test21PortfolioCantAddOtherPortfolioIfHasAChildWithAnAccountInCommon

	| account rootPortfolio childPortfolio |
	
	account := self accountWithDepositOf: 100.
	rootPortfolio := self portfolioParentOfPortfolioWithAccount: account.
	childPortfolio := self portfolioWithAccount: account.
	
	self should: [ rootPortfolio add: childPortfolio ] raise: Error description: Portfolio duplicatedAccountErrorDescription! !

!PortfolioTest methodsFor: 'testing' stamp: 'AEC 5/22/2022 23:10:23'!
test22PortfolioCantAddOtherPortfolioIfHasGrandchildWithAnAccountInCommon

	| account rootPortfolio portfolioToAdd |
	
	account := self accountWithDepositOf: 100.
	rootPortfolio := self portfolioGrandparentOfPortfolioWithAccount: account.
	portfolioToAdd := self portfolioWithAccount: account.
		
	self should: [ rootPortfolio add: portfolioToAdd ] raise: Error description: Portfolio duplicatedAccountErrorDescription! !

!PortfolioTest methodsFor: 'testing' stamp: 'AEC 5/22/2022 23:13:20'!
test23PortfolioCantAddAccountIfHasGranchildContainingThatAccount

	| account rootPortfolio |
	
	account := self accountWithDepositOf: 100.
	rootPortfolio := self portfolioGrandparentOfPortfolioWithAccount: account.
		
	self should: [ rootPortfolio add: account ] raise: Error description: Portfolio duplicatedAccountErrorDescription! !

!PortfolioTest methodsFor: 'testing' stamp: 'AEC 5/22/2022 23:14:18'!
test24PortfolioCantAddAccountIfHasGrandparentContainingSameAccount

	| account grandchildPortfolio |
	
	account := self accountWithDepositOf: 100.
	grandchildPortfolio := self portfolioGrandchildOfPortfolioWithAccount: account.
	
	self should: [ grandchildPortfolio add: account ] raise: Error description: Portfolio duplicatedAccountErrorDescription! !

!PortfolioTest methodsFor: 'testing' stamp: 'AEC 5/22/2022 23:18:20'!
test25PortfolioCantAddOtherPortfolioIfHasParentWithAnAccountInCommon

	| account childPortfolio portfolioToAdd |
	
	account := self accountWithDepositOf: 100.
	childPortfolio := self portfolioChildOfPortfolioWithAccount: account.
	portfolioToAdd := self portfolioWithAccount: account.
	
	self should: [ childPortfolio add: portfolioToAdd ] raise: Error description: Portfolio duplicatedAccountErrorDescription! !

!PortfolioTest methodsFor: 'testing' stamp: 'AEC 5/22/2022 23:46:45'!
test26PortfolioCantAddPortfolioIfHasChildWithAnAccountInCommonWithGrandchildFromSecond

	| account rootPortfolio portfolioToAdd |
	
	account := self accountWithDepositOf: 100.
	rootPortfolio := self portfolioParentOfPortfolioWithAccount: account.
	portfolioToAdd := self portfolioGrandparentOfPortfolioWithAccount: account.
	
	self should: [ rootPortfolio add: portfolioToAdd ] raise: Error description: Portfolio duplicatedAccountErrorDescription! !

!PortfolioTest methodsFor: 'testing' stamp: 'AEC 5/22/2022 23:45:44'!
test27PortfolioCantAddOtherPortfolioIfHasAnAccountContainedByTheSecond

	| account rootPortfolio portfolioToAdd |
	
	account := self accountWithDepositOf: 100.
	
	rootPortfolio := self portfolioWithAccount: account.
	
	portfolioToAdd := self portfolioParentOfPortfolioWithAccount: account.
	
	self should: [ rootPortfolio add: portfolioToAdd] raise: Error description: Portfolio duplicatedAccountErrorDescription! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/16/2022 16:18:39'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/16/2022 16:19:11'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
	
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'AEC 5/16/2022 21:03:43'!
updateBalance: aBalance

	^ self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'AEC 5/16/2022 21:03:29'!
updateBalance: aBalance

	^ aBalance + self value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'AEC 5/16/2022 21:03:20'!
updateBalance: aBalance

	^ aBalance - self value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #AccountTreeElement category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTreeElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTreeElement methodsFor: 'adding - private' stamp: 'AEC 5/22/2022 21:06:45'!
becomeChildOf: aPortfolio

	self subclassResponsibility ! !


!AccountTreeElement methodsFor: 'asserting' stamp: 'AEC 5/22/2022 23:28:21'!
assertChildrenDontContain: aChildCandidate

	self subclassResponsibility ! !

!AccountTreeElement methodsFor: 'asserting' stamp: 'AEC 5/22/2022 23:28:34'!
assertDoesNotContainAccount: anAccount

	self subclassResponsibility ! !


!AccountTreeElement methodsFor: 'balance' stamp: 'AEC 5/22/2022 21:02:09'!
balance

	self subclassResponsibility ! !


!AccountTreeElement methodsFor: 'testing' stamp: 'AEC 5/22/2022 21:00:39'!
hasRegistered: aTransaction

	self subclassResponsibility ! !


!AccountTreeElement methodsFor: 'transactions' stamp: 'AEC 5/22/2022 21:01:28'!
transactions

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTreeElement class' category: 'Portfolio-Ejercicio'!
AccountTreeElement class
	instanceVariableNames: ''!

!AccountTreeElement class methodsFor: 'error-description' stamp: 'AEC 5/22/2022 21:09:47'!
duplicatedAccountErrorDescription
	
	^'La cuenta ya existe dentro del portfolio.'! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
AccountTreeElement subclass: #Portfolio
	instanceVariableNames: 'parents children'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'adding' stamp: 'AEC 5/22/2022 23:29:08'!
add: aChildCandidate 

	self assertChildrenDontContain: aChildCandidate.
	self assertParentsDontContain: aChildCandidate.
	children add: aChildCandidate.
	aChildCandidate becomeChildOf: self! !


!Portfolio methodsFor: 'adding - private' stamp: 'AEC 5/22/2022 20:05:31'!
becomeChildOf: aPortfolio

	parents add: aPortfolio ! !


!Portfolio methodsFor: 'asserting' stamp: 'AEC 5/22/2022 23:28:21'!
assertChildrenDontContain: aChildCandidate

	children do: [:child | child assertChildrenDontContain: aChildCandidate ]! !

!Portfolio methodsFor: 'asserting' stamp: 'AEC 5/22/2022 23:28:34'!
assertDoesNotContainAccount: anAccount

	children do:[:child | child assertDoesNotContainAccount: anAccount]! !

!Portfolio methodsFor: 'asserting' stamp: 'AEC 5/22/2022 23:29:08'!
assertParentsDontContain: aChildCandidate
	
	parents do: [:aParent | 
		aParent assertChildrenDontContain: aChildCandidate. 
		aParent assertParentsDontContain: aChildCandidate 
	]! !


!Portfolio methodsFor: 'balance' stamp: 'AEC 5/22/2022 19:42:13'!
balance

	^children sum: [:child | child balance] ifEmpty: [0]! !


!Portfolio methodsFor: 'initialization' stamp: 'AEC 5/22/2022 21:26:55'!
initialize

	children := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'testing' stamp: 'AEC 5/22/2022 19:41:58'!
hasRegistered: aTransaction
	
	^children anySatisfy:[ :child | child hasRegistered: aTransaction ]! !


!Portfolio methodsFor: 'transactions' stamp: 'AEC 5/22/2022 19:41:36'!
transactions
	
	^children inject: OrderedCollection new into: [:transactions :child | transactions,(child transactions)]! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
AccountTreeElement subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'adding - private' stamp: 'AEC 5/22/2022 20:05:44'!
becomeChildOf: aPortfolio! !


!ReceptiveAccount methodsFor: 'asserting' stamp: 'AEC 5/22/2022 23:28:34'!
assertChildrenDontContain: aChildCandidate

	aChildCandidate assertDoesNotContainAccount: self! !

!ReceptiveAccount methodsFor: 'asserting' stamp: 'AEC 5/22/2022 23:28:34'!
assertDoesNotContainAccount: anAccount

	self = anAccount ifTrue:[self error: self class duplicatedAccountErrorDescription]! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'AEC 5/16/2022 21:02:52'!
balance

	^transactions inject: 0 into: [:balance :transaction | transaction updateBalance: balance]! !


!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !
