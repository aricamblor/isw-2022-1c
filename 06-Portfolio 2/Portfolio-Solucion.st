!classDefinition: #AccountSummaryTest category: 'Portfolio-Solucion'!
TestCase subclass: #AccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummaryTest methodsFor: 'tests' stamp: 'AEC 5/29/2022 19:45:42'!
test01AccountWithNoTransactionsSummaryOnlyIncludesBalanceZeroLine
	
	self assert: (self accountSummaryFor: ReceptiveAccount new) equals: (OrderedCollection with: 'Balance = 0')! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'AEC 5/29/2022 19:47:58'!
test02AccountWithOneDepositSummaryIncludesDepositAndBalanceLines

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	self assert: (self accountSummaryFor: account) equals: (OrderedCollection with: 'Deposito por 100' with: 'Balance = 100')! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'AEC 5/29/2022 19:48:10'!
test03AccountWithDepositAndWithdrawSummaryIncludesDepositWithdrawAndBalanceLines

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
	
	self assert: (self accountSummaryFor: account) equals: (OrderedCollection with: 'Deposito por 100' with: 'Extraccion por 50' with: 'Balance = 50')! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'AEC 5/29/2022 19:48:32'!
test04SummaryOfAccountsBeingPartOfATransferIncludeCorrectPartOfThatTransfer

	| account otherAccount |
	
	account := ReceptiveAccount new.
	otherAccount := ReceptiveAccount new.
	Transfer from: account  to: otherAccount for: 25.
	
	self assert: (self accountSummaryFor: account) equals: (OrderedCollection with: 'Salida por transferencia de 25' with: 'Balance = -25').
	self assert: (self accountSummaryFor: otherAccount) equals: (OrderedCollection with: 'Entrada por transferencia de 25' with: 'Balance = 25')! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'AEC 5/29/2022 19:48:55'!
test05PortfolioWithNoTransactionsSummaryOnlyIncludesBalanceZeroLine

	self assert: (self accountSummaryFor: Portfolio new) equals: (OrderedCollection with: 'Balance = 0')! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'AEC 5/29/2022 19:49:12'!
test06SummaryOfPortfolioWithEmptyChildPortfolioIsASingleBalanceZeroLine

	| childPortfolio fatherPortfolio |
	
	fatherPortfolio := Portfolio new.
	childPortfolio := Portfolio new.
	fatherPortfolio add: childPortfolio.
	
	self assert: (self accountSummaryFor: fatherPortfolio) equals: (OrderedCollection with: 'Balance = 0')! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'AEC 5/29/2022 19:49:41'!
test07PortfolioSummaryIncludesTransactionsFromChildAccounts

	| childPortfolio account fatherPortfolio |
	
	fatherPortfolio := Portfolio new.
	
	childPortfolio := Portfolio new.
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	childPortfolio add: account.
	fatherPortfolio add: childPortfolio.
	
	self assert: (self accountSummaryFor: fatherPortfolio) equals: (OrderedCollection with: 'Deposito por 100' with: 'Balance = 100')! !


!AccountSummaryTest methodsFor: 'test-support' stamp: 'AEC 5/29/2022 19:44:44'!
accountSummaryFor: account

	^ (AccountSummary for: account) executeReport! !


!classDefinition: #PortfolioStructureTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioStructureTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioStructureTest methodsFor: 'tests' stamp: 'AEC 5/29/2022 23:23:31'!
test01PortfolioStructureForEmptyPortfolioIsTheNameOfThePortfolio

	| portfolio |
	
	portfolio := Portfolio named: 'Portfolio de Tito'.
	
	self assert: (self portfolioStructureFor: portfolio) equals: (OrderedCollection with: 'Portfolio de Tito')! !

!PortfolioStructureTest methodsFor: 'tests' stamp: 'AEC 5/29/2022 23:23:22'!
test02PortfolioStructureForPortfolioWithAccountsIncludesIndentedAccountNames

	| portfolio account |
	
	account := ReceptiveAccount named: 'Cuenta de Tito'.
	portfolio := Portfolio named: 'Portfolio de Tito' with: account.
	
	self assert: (self portfolioStructureFor: portfolio) equals: (OrderedCollection with: 'Portfolio de Tito' with: '  Cuenta de Tito')! !

!PortfolioStructureTest methodsFor: 'tests' stamp: 'AEC 5/29/2022 23:22:11'!
test03PortfolioStructureForPortfolioWithPortfoliosAndAccountsIncludesIndentedPortfolioNames

	| portfolio childPortfolio expectedResult |	
	
	childPortfolio := Portfolio named: 'Portfolio de Pepe' with: (ReceptiveAccount named: 'Cuenta de Pepe').
	portfolio := Portfolio named: 'Portfolio de Tito' with: childPortfolio with: (ReceptiveAccount named: 'Cuenta de Tito').
	
	expectedResult := OrderedCollection with: 'Portfolio de Tito' 
									with: '  Portfolio de Pepe' 
									with: '    Cuenta de Pepe' 
									with: '  Cuenta de Tito'.
	
	self assert: (self portfolioStructureFor: portfolio) equals: expectedResult! !


!PortfolioStructureTest methodsFor: 'test-support' stamp: 'AEC 5/29/2022 23:21:24'!
portfolioStructureFor: portfolio

	^ (PortfolioStructure for: portfolio) executeReport! !


!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #SpecialAccountSummaryTest category: 'Portfolio-Solucion'!
TestCase subclass: #SpecialAccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!SpecialAccountSummaryTest methodsFor: 'tests' stamp: 'AEC 5/29/2022 23:20:04'!
test01SpecialAccountSummaryForEmptyPortfolioIsTheNameOfThePortfolioWithItsBalanceIndented

	| portfolio |
	
	portfolio := Portfolio named: 'Portfolio de Tito'.
	
	self assert: (self specialAccountSummaryFor: portfolio) equals: (OrderedCollection with: 'Portfolio de Tito' with: '  Balance = 0')! !

!SpecialAccountSummaryTest methodsFor: 'tests' stamp: 'AEC 5/29/2022 23:19:25'!
test02SpecialAccountSummaryForPortfolioWithEmptyAccountsIncludesAccountNamesWithItsIndentedBalances

	| portfolio expectedResult |
	
	portfolio := Portfolio named: 'Portfolio de Tito' with: (ReceptiveAccount named: 'Cuenta de Tito').
	
	expectedResult := OrderedCollection with: 'Portfolio de Tito' 
									with: '  Cuenta de Tito' 
									with: '    Balance = 0' 
									with: '  Balance = 0'.
	
	self assert: (self specialAccountSummaryFor: portfolio) equals: expectedResult! !

!SpecialAccountSummaryTest methodsFor: 'tests' stamp: 'AEC 5/29/2022 23:18:25'!
test03SpecialAccountSummaryForPortfolioWithAccountsWithTransactionsIncludesIndentedTransactions

	| portfolio account expectedResult otherAccount |
	
	otherAccount := ReceptiveAccount named: 'Cuenta de Juana'.
	account := ReceptiveAccount named: 'Cuenta de Tito'.
	Deposit register: 100 on: account.
	Withdraw register: 10 on: account.
	Transfer from: account to: otherAccount for: 50.
	Transfer from: otherAccount to: account for: 25.
	
	portfolio := Portfolio named: 'Portfolio de Tito' with: account.
	
	expectedResult := OrderedCollection new
						add: 'Portfolio de Tito'; 
						add: '  Cuenta de Tito'; 
						add: '    Deposito por 100';
						add: '    Extraccion por 10';
						add: '    Salida por transferencia de 50';
						add: '    Entrada por transferencia de 25';
						add: '    Balance = 65'; 
						add: '  Balance = 65'; yourself.
						
	self assert: (self specialAccountSummaryFor: portfolio) equals: expectedResult! !


!SpecialAccountSummaryTest methodsFor: 'test-support' stamp: 'AEC 5/29/2022 23:18:25'!
specialAccountSummaryFor: portfolio

	^ (SpecialAccountSummary for: portfolio) executeReport! !


!classDefinition: #TransferNetTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferNetTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetTest methodsFor: 'test-support' stamp: 'fm 5/28/2022 19:58:50'!
transferNetFor: account

	^ (TransferNet for: account) executeReport! !


!TransferNetTest methodsFor: 'tests' stamp: 'fm 5/28/2022 20:19:50'!
test01TransferNetForAccountWithNoTransactionsIs0

	| account |
	
	account := ReceptiveAccount new.
	
	self assert: (self transferNetFor: account) equals: 0! !

!TransferNetTest methodsFor: 'tests' stamp: 'fm 5/28/2022 20:21:43'!
test02TransferNetForAccountsInvolvedInATransferConsidersTheTransfer

	| account otherAccount |
	
	account := ReceptiveAccount new.
	otherAccount := ReceptiveAccount new.
	
	Transfer from: account to: otherAccount for: 100.
	
	self assert: (self transferNetFor: account) equals: -100.
	self assert: (self transferNetFor: otherAccount) equals: 100! !

!TransferNetTest methodsFor: 'tests' stamp: 'fm 5/28/2022 20:25:05'!
test03TransferNetForAccountsInvolvedInATransferConsidersTheTransferButNotOtherTransactions

	| account otherAccount |
	
	account := ReceptiveAccount new.
	otherAccount := ReceptiveAccount new.
	Deposit register: 50 on: account.
	Deposit register: 50 on: otherAccount.
	Withdraw register: 100 on: account.
	Withdraw register: 100 on: otherAccount.
	
	Transfer from: account to: otherAccount for: 100.
	
	self assert: (self transferNetFor: account) equals: -100.
	self assert: (self transferNetFor: otherAccount) equals: 100! !

!TransferNetTest methodsFor: 'tests' stamp: 'fm 5/28/2022 20:22:48'!
test04TransferNetForEmptyPortfolioIs0

	| portfolio |
	
	portfolio := Portfolio new.
	
	self assert: (self transferNetFor: portfolio) equals: 0! !

!TransferNetTest methodsFor: 'tests' stamp: 'fm 5/28/2022 20:23:22'!
test05TransferNetForPortfolioWithAccountInvolvedInATransferConsidersTheTransfer

	| portfolio account otherAccount |
	
	account := ReceptiveAccount new.
	otherAccount := ReceptiveAccount new.
	Transfer from: account to: otherAccount for: 100.
	
	portfolio := Portfolio new.
	portfolio add: account.
	

	self assert: (self transferNetFor: portfolio) equals: -100! !

!TransferNetTest methodsFor: 'tests' stamp: 'fm 5/28/2022 20:24:30'!
test06TransferNetForPortfolioWithAccountInvolvedInATransferConsidersTheTransferButNotOtherTransactions

	| portfolio account otherAccount |
	
	account := ReceptiveAccount new.
	otherAccount := ReceptiveAccount new.
	Transfer from: account to: otherAccount for: 100.
	Deposit register: 200 on: account.
	Withdraw register: 100 on: account.
	
	portfolio := Portfolio new.
	portfolio add: account.
	

	self assert: (self transferNetFor: portfolio) equals: -100! !


!classDefinition: #TransferTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'tests' stamp: 'AEC 5/25/2022 19:57:23'!
test01TransferBetweenTwoAccountsImpactsBothBalances

	| transfer senderAccount receiverAccount |
	
	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	
	transfer := Transfer from: senderAccount to: receiverAccount for: 100.
	
	self assert: senderAccount balance equals: -100.
	self assert: receiverAccount balance equals: 100.! !

!TransferTest methodsFor: 'tests' stamp: 'AEC 5/25/2022 19:59:48'!
test02EachAccountRegistersItsPartOfTheTransfer

	| transfer senderAccount receiverAccount |
	
	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	
	transfer := Transfer from: senderAccount to: receiverAccount for: 100.
	
	self assert: (senderAccount hasRegistered: transfer sentTransaction ).
	self assert: (receiverAccount hasRegistered: transfer receivedTransaction )! !

!TransferTest methodsFor: 'tests' stamp: 'AEC 5/25/2022 20:00:24'!
test03CanNavigateFromEndsOfTransferToTheTransfer

	| transfer senderAccount receiverAccount |
	
	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	
	transfer := Transfer from: senderAccount to: receiverAccount for: 100.
	
	self assert: (transfer sentTransaction) transfer equals: transfer.
	self assert: (transfer receivedTransaction) transfer equals: transfer
	! !

!TransferTest methodsFor: 'tests' stamp: 'AEC 5/25/2022 20:15:58'!
test04CantMakeATransferWithSameAccountAtBothEnds

	| account |
	
	account := ReceptiveAccount new.
	
	self should: [Transfer from: account to: account for: 100] raise: Error withMessageText: Transfer cantHaveSameAccountAtBothEnds.! !

!TransferTest methodsFor: 'tests' stamp: 'AEC 5/25/2022 20:18:34'!
test05CantMakeATransferWithNonPositiveAmount

	| receiverAccount senderAccount |
	
	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	
	self should: [Transfer from: senderAccount to: receiverAccount for: 0] raise: Error withMessageText: Transfer amountMustBePositive.! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'report' stamp: 'fm 5/28/2022 20:08:26'!
affectReport: anAccountSummary 
	
	^self subclassResponsibility! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'AEC 5/29/2022 20:09:58'!
initializeNamed: anAccountName 
	
	name := anAccountName.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'report' stamp: 'AEC 5/29/2022 22:31:13'!
affectReport: anAccountReport
	
	anAccountReport affectReportWithPortfolio: self.
	anAccountReport goDownALevel.
	accounts do: [ :account | account affectReport: anAccountReport ].
	anAccountReport goUpALevelFrom: self.! !


!Portfolio methodsFor: 'accesing' stamp: 'AEC 5/29/2022 20:14:52'!
accountName
	
	^name! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error-description' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !


!Portfolio class methodsFor: 'instance creation' stamp: 'AEC 5/29/2022 23:38:40'!
named: anAccountName
	
	^ super new initializeNamed: anAccountName! !

!Portfolio class methodsFor: 'instance creation' stamp: 'AEC 5/29/2022 23:39:11'!
named: anAccountName with: aReceptiveAccount 
	
	^super new 
		initializeNamed: anAccountName; 
		add: aReceptiveAccount; 
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'AEC 5/29/2022 23:39:16'!
named: anAccountName with: aReceptiveAccount with: anotherReceptiveAccount 
 	
	^super new 
		initializeNamed: anAccountName; 
		add: aReceptiveAccount; 
		add: anotherReceptiveAccount; 
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'AEC 5/29/2022 23:41:56'!
new

	^self named: self defaultName ! !

!Portfolio class methodsFor: 'instance creation' stamp: 'AEC 5/29/2022 23:42:02'!
with: anAccount

	^self named: self defaultName with: anAccount! !

!Portfolio class methodsFor: 'instance creation' stamp: 'AEC 5/29/2022 23:42:06'!
with: anAccount with: anotherAccount

	^self named: self defaultName with: anAccount with: anotherAccount! !


!Portfolio class methodsFor: 'accessing' stamp: 'AEC 5/29/2022 23:41:28'!
defaultName

	^'Portfolio sin nombre'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'AEC 5/29/2022 19:31:43'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'AEC 5/29/2022 20:21:13'!
initializeNamed: anAccountName 

	name := anAccountName.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'report' stamp: 'AEC 5/29/2022 22:31:47'!
affectReport: anAccountReport
	
	anAccountReport affectReportWithReceptiveAccount: self.
	anAccountReport goDownALevel.
	transactions do: [:transaction | transaction affectReport: anAccountReport ].
	anAccountReport goUpALevelFrom: self! !


!ReceptiveAccount methodsFor: 'accessing' stamp: 'AEC 5/29/2022 20:30:26'!
accountName
	
	^name! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'instance creation' stamp: 'AEC 5/29/2022 23:36:42'!
named: anAccountName 

	^ super new initializeNamed: anAccountName! !

!ReceptiveAccount class methodsFor: 'instance creation' stamp: 'AEC 5/29/2022 23:41:03'!
new

	^self named: self defaultName! !


!ReceptiveAccount class methodsFor: 'accessing' stamp: 'AEC 5/29/2022 23:40:49'!
defaultName
	
	^'Cuenta sin nombre'! !


!classDefinition: #AccountReport category: 'Portfolio-Solucion'!
Object subclass: #AccountReport
	instanceVariableNames: 'account level'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountReport methodsFor: 'initialization' stamp: 'AEC 5/29/2022 22:59:40'!
initializeFor: anAccount

	account := anAccount.
	level := 0.! !


!AccountReport methodsFor: 'executing' stamp: 'AEC 5/29/2022 22:40:14'!
affectReportWithDeposit: aDeposit

	self subclassResponsibility! !

!AccountReport methodsFor: 'executing' stamp: 'AEC 5/29/2022 22:40:01'!
affectReportWithPortfolio: aPortfolio

	self subclassResponsibility! !

!AccountReport methodsFor: 'executing' stamp: 'AEC 5/29/2022 22:39:56'!
affectReportWithReceptiveAccount: aReceptiveAccount

	self subclassResponsibility! !

!AccountReport methodsFor: 'executing' stamp: 'AEC 5/29/2022 22:40:18'!
affectReportWithTransferDeposit: aTransferDeposit

	self subclassResponsibility! !

!AccountReport methodsFor: 'executing' stamp: 'AEC 5/29/2022 22:40:22'!
affectReportWithTransferWithdraw: aTransferWithdraw

	self subclassResponsibility! !

!AccountReport methodsFor: 'executing' stamp: 'AEC 5/29/2022 22:40:25'!
affectReportWithWithdraw: aWithdraw

	self subclassResponsibility! !

!AccountReport methodsFor: 'executing' stamp: 'fm 5/28/2022 19:57:27'!
executeReport

	^ self subclassResponsibility! !

!AccountReport methodsFor: 'executing' stamp: 'AEC 5/29/2022 22:33:28'!
goDownALevel

	level := level + 1! !

!AccountReport methodsFor: 'executing' stamp: 'AEC 5/29/2022 22:34:13'!
goUpALevelFrom: anAccount

	level := level - 1! !


!AccountReport methodsFor: 'executing - private' stamp: 'AEC 5/30/2022 00:01:25'!
prefixValue: aNumber withString: aPrefix

	^(aPrefix,aNumber asString)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountReport class' category: 'Portfolio-Solucion'!
AccountReport class
	instanceVariableNames: ''!

!AccountReport class methodsFor: 'instance creation' stamp: 'fm 5/28/2022 19:53:08'!
for: anAccount

	^self new initializeFor: anAccount! !


!classDefinition: #AccountSummary category: 'Portfolio-Solucion'!
AccountReport subclass: #AccountSummary
	instanceVariableNames: 'report'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'executing - private' stamp: 'AEC 5/30/2022 00:01:12'!
addAccountBalanceLine

	^ report add: (self prefixValue: account balance withString: 'Balance = ')! !

!AccountSummary methodsFor: 'executing - private' stamp: 'AEC 5/30/2022 00:00:31'!
addToReport: aTransaction beginningWith: aPrefix

	report add: (self prefixValue: aTransaction value withString: aPrefix)! !


!AccountSummary methodsFor: 'executing' stamp: 'AEC 5/29/2022 23:51:07'!
affectReportWithDeposit: aDeposit

	self addToReport: aDeposit beginningWith: 'Deposito por '! !

!AccountSummary methodsFor: 'executing' stamp: 'AEC 5/29/2022 22:58:22'!
affectReportWithPortfolio: aPortfolio! !

!AccountSummary methodsFor: 'executing' stamp: 'AEC 5/29/2022 22:58:12'!
affectReportWithReceptiveAccount: aReceptiveAccount! !

!AccountSummary methodsFor: 'executing' stamp: 'AEC 5/29/2022 23:51:29'!
affectReportWithTransferDeposit: aTransferDeposit

	self addToReport: aTransferDeposit beginningWith: 'Entrada por transferencia de '! !

!AccountSummary methodsFor: 'executing' stamp: 'AEC 5/29/2022 23:51:48'!
affectReportWithTransferWithdraw: aTransferWithdraw

	self addToReport: aTransferWithdraw beginningWith: 'Salida por transferencia de '! !

!AccountSummary methodsFor: 'executing' stamp: 'AEC 5/29/2022 23:52:42'!
affectReportWithWithdraw: aWithdraw

	self addToReport: aWithdraw beginningWith: 'Extraccion por '! !

!AccountSummary methodsFor: 'executing' stamp: 'fm 5/28/2022 20:08:26'!
executeReport
	
	report := OrderedCollection new.
	account affectReport: self.
	self addAccountBalanceLine.
	
	^report! !


!classDefinition: #PortfolioStructure category: 'Portfolio-Solucion'!
AccountReport subclass: #PortfolioStructure
	instanceVariableNames: 'report'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioStructure methodsFor: 'executing' stamp: 'AEC 5/29/2022 23:02:33'!
affectReportWithDeposit: aTransferDeposit! !

!PortfolioStructure methodsFor: 'executing' stamp: 'AEC 5/29/2022 22:39:23'!
affectReportWithPortfolio: aPortfolio

	self addToReport: aPortfolio! !

!PortfolioStructure methodsFor: 'executing' stamp: 'AEC 5/29/2022 22:48:30'!
affectReportWithReceptiveAccount: aReceptiveAccount

	self addToReport: aReceptiveAccount! !

!PortfolioStructure methodsFor: 'executing' stamp: 'AEC 5/29/2022 22:42:37'!
affectReportWithTransferDeposit: aTransferDeposit! !

!PortfolioStructure methodsFor: 'executing' stamp: 'AEC 5/29/2022 22:42:30'!
affectReportWithTransferWithdraw: aTransferWithdraw! !

!PortfolioStructure methodsFor: 'executing' stamp: 'AEC 5/29/2022 22:42:23'!
affectReportWithWithdraw: aWithdraw! !

!PortfolioStructure methodsFor: 'executing' stamp: 'AEC 5/29/2022 23:00:12'!
executeReport
	
	report := OrderedCollection new.
	
	account affectReport: self.
	
	^report! !


!PortfolioStructure methodsFor: 'executing - private' stamp: 'AEC 5/29/2022 20:57:51'!
addLevelSpacesTo: anAccount

	| accountName |
	
	accountName := anAccount accountName.
	^accountName padded:#left to:(accountName size + (2*level)) with:$ .! !

!PortfolioStructure methodsFor: 'executing - private' stamp: 'AEC 5/29/2022 20:56:37'!
addToReport: anAccount

	report add: (self addLevelSpacesTo: anAccount)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioStructure class' category: 'Portfolio-Solucion'!
PortfolioStructure class
	instanceVariableNames: ''!

!PortfolioStructure class methodsFor: 'instance creation' stamp: 'AEC 5/29/2022 20:10:49'!
for: aPortfolio
	
	^self new initializeFor: aPortfolio ! !


!classDefinition: #SpecialAccountSummary category: 'Portfolio-Solucion'!
AccountReport subclass: #SpecialAccountSummary
	instanceVariableNames: 'report'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!SpecialAccountSummary methodsFor: 'executing' stamp: 'AEC 5/30/2022 00:02:01'!
affectReportWithDeposit: aDeposit

	self addToReport: (self prefixValue: aDeposit value withString: 'Deposito por ')! !

!SpecialAccountSummary methodsFor: 'executing' stamp: 'AEC 5/29/2022 23:56:43'!
affectReportWithPortfolio: aPortfolio

	self addToReport: aPortfolio accountName! !

!SpecialAccountSummary methodsFor: 'executing' stamp: 'AEC 5/29/2022 23:56:49'!
affectReportWithReceptiveAccount: aReceptiveAccount

	self addToReport: aReceptiveAccount accountName ! !

!SpecialAccountSummary methodsFor: 'executing' stamp: 'AEC 5/30/2022 00:08:01'!
affectReportWithTransferDeposit: aTransferDeposit

	self addToReport: (self prefixValue: aTransferDeposit value withString: 'Entrada por transferencia de ')! !

!SpecialAccountSummary methodsFor: 'executing' stamp: 'AEC 5/30/2022 00:03:19'!
affectReportWithTransferWithdraw: aTransferWithdraw

	self addToReport: (self prefixValue: aTransferWithdraw value withString: 'Salida por transferencia de ')! !

!SpecialAccountSummary methodsFor: 'executing' stamp: 'AEC 5/30/2022 00:03:49'!
affectReportWithWithdraw: aWithdraw

	self addToReport: (self prefixValue: aWithdraw value withString: 'Extraccion por ')! !

!SpecialAccountSummary methodsFor: 'executing' stamp: 'AEC 5/29/2022 23:00:18'!
executeReport
	
	report := OrderedCollection new.
	
	account affectReport: self.
	
	^report! !

!SpecialAccountSummary methodsFor: 'executing' stamp: 'AEC 5/29/2022 22:52:50'!
goUpALevelFrom: anAccount

	self addBalance: anAccount balance.
	super goUpALevelFrom: anAccount! !


!SpecialAccountSummary methodsFor: 'executing - private' stamp: 'AEC 5/30/2022 00:04:33'!
addBalance: aBalance

	| balance |
	
	balance := self addLevelSpacesTo: (self prefixValue: aBalance withString: 'Balance = ').
	
	report add: balance
	! !

!SpecialAccountSummary methodsFor: 'executing - private' stamp: 'AEC 5/29/2022 21:47:01'!
addLevelSpacesTo: aReportLine

	^aReportLine padded:#left to:(aReportLine size + (2*level)) with:$ .! !

!SpecialAccountSummary methodsFor: 'executing - private' stamp: 'AEC 5/29/2022 23:57:01'!
addToReport: aLine

	report add: (self addLevelSpacesTo: aLine)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SpecialAccountSummary class' category: 'Portfolio-Solucion'!
SpecialAccountSummary class
	instanceVariableNames: ''!

!SpecialAccountSummary class methodsFor: 'instance creation' stamp: 'AEC 5/29/2022 22:49:46'!
for: aPortfolio 

	^ self new initializeFor: aPortfolio! !


!classDefinition: #TransferNet category: 'Portfolio-Solucion'!
AccountReport subclass: #TransferNet
	instanceVariableNames: 'report'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNet methodsFor: 'executing' stamp: 'fm 5/28/2022 20:30:04'!
affectReportWithDeposit: aDeposit! !

!TransferNet methodsFor: 'executing' stamp: 'AEC 5/29/2022 22:58:27'!
affectReportWithPortfolio: aPortfolio! !

!TransferNet methodsFor: 'executing' stamp: 'AEC 5/29/2022 22:58:37'!
affectReportWithReceptiveAccount: aReceptiveAccount! !

!TransferNet methodsFor: 'executing' stamp: 'fm 5/28/2022 20:30:16'!
affectReportWithTransferDeposit: aTransferDeposit

	^ report := report + aTransferDeposit value! !

!TransferNet methodsFor: 'executing' stamp: 'fm 5/28/2022 20:30:25'!
affectReportWithTransferWithdraw: aTransferWithdraw

	^ report := report - aTransferWithdraw value! !

!TransferNet methodsFor: 'executing' stamp: 'fm 5/28/2022 20:30:36'!
affectReportWithWithdraw: aWithdraw! !

!TransferNet methodsFor: 'executing' stamp: 'fm 5/28/2022 20:10:04'!
executeReport
	
	report := 0.
	account affectReport: self.
	
	^report! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'report' stamp: 'fm 5/28/2022 20:05:30'!
affectReport: anAccountReport 
	
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'AEC 5/25/2022 19:46:09'!
register: aValueOrTransfer on: account

	| transaction |
	
	transaction := self for: aValueOrTransfer.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'report' stamp: 'fm 5/28/2022 20:30:04'!
affectReport: anAccountReport 
	
	^anAccountReport affectReportWithDeposit: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferDeposit category: 'Portfolio-Solucion'!
AccountTransaction subclass: #TransferDeposit
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferDeposit methodsFor: 'balance' stamp: 'AEC 5/25/2022 19:51:59'!
affectBalance: aBalance
	
	^ aBalance + self value! !


!TransferDeposit methodsFor: 'initialization' stamp: 'AEC 5/25/2022 19:49:11'!
initializeFor: aTransfer

	transfer := aTransfer ! !


!TransferDeposit methodsFor: 'transfer' stamp: 'AEC 5/25/2022 19:54:26'!
transfer
	
	^transfer! !


!TransferDeposit methodsFor: 'value' stamp: 'AEC 5/25/2022 19:51:06'!
value

	^transfer value! !


!TransferDeposit methodsFor: 'report' stamp: 'fm 5/28/2022 20:30:16'!
affectReport: anAccountReport 
	
	^ anAccountReport affectReportWithTransferDeposit: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDeposit class' category: 'Portfolio-Solucion'!
TransferDeposit class
	instanceVariableNames: ''!

!TransferDeposit class methodsFor: 'instance creation' stamp: 'AEC 5/25/2022 19:47:32'!
for: aTransfer

	^ self new initializeFor: aTransfer! !


!classDefinition: #TransferWithdraw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #TransferWithdraw
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferWithdraw methodsFor: 'balance' stamp: 'AEC 5/25/2022 19:52:10'!
affectBalance: aBalance
	
	^ aBalance - self value! !


!TransferWithdraw methodsFor: 'initialization' stamp: 'AEC 5/25/2022 19:49:22'!
initializeFor: aTransfer

	transfer := aTransfer ! !


!TransferWithdraw methodsFor: 'transfer' stamp: 'AEC 5/25/2022 19:54:18'!
transfer
	
	^transfer! !


!TransferWithdraw methodsFor: 'value' stamp: 'AEC 5/25/2022 19:52:19'!
value
	
	^transfer value! !


!TransferWithdraw methodsFor: 'report' stamp: 'fm 5/28/2022 20:30:26'!
affectReport: anAccountReport 
	
	^anAccountReport affectReportWithTransferWithdraw: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferWithdraw class' category: 'Portfolio-Solucion'!
TransferWithdraw class
	instanceVariableNames: ''!

!TransferWithdraw class methodsFor: 'instance creation' stamp: 'AEC 5/25/2022 19:47:37'!
for: aTransfer

	^ self new initializeFor: aTransfer! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'report' stamp: 'fm 5/28/2022 20:30:36'!
affectReport: anAccountReport 
	
	^anAccountReport affectReportWithWithdraw: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'amount sentTransaction receivedTransaction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'initialization' stamp: 'AEC 5/25/2022 19:43:26'!
initializeFrom: aSender to: aReceiver for: anAmount

	amount := anAmount.
	sentTransaction := TransferWithdraw register: self on: aSender.
	receivedTransaction := TransferDeposit register: self  on: aReceiver.! !


!Transfer methodsFor: 'accessing' stamp: 'AEC 5/25/2022 19:43:17'!
receivedTransaction

	^receivedTransaction ! !

!Transfer methodsFor: 'accessing' stamp: 'AEC 5/25/2022 19:43:26'!
sentTransaction

	^sentTransaction ! !

!Transfer methodsFor: 'accessing' stamp: 'fm 5/23/2022 21:12:50'!
value

	^amount! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'AEC 5/25/2022 20:05:58'!
assert: aReceiver isNotTheSameAs: aSender

	^ aSender = aReceiver ifTrue:[self error: self cantHaveSameAccountAtBothEnds ]! !

!Transfer class methodsFor: 'instance creation' stamp: 'AEC 5/25/2022 20:17:32'!
assertAmountIsPositive: anAmount

	^ anAmount > 0 ifFalse:[self error: self amountMustBePositive ]! !

!Transfer class methodsFor: 'instance creation' stamp: 'AEC 5/25/2022 20:17:32'!
from: aSender to: aReceiver for: anAmount

	self assert: aReceiver isNotTheSameAs: aSender.
	self assertAmountIsPositive: anAmount.
	^ self new initializeFrom: aSender to: aReceiver for: anAmount! !


!Transfer class methodsFor: 'error-description' stamp: 'AEC 5/25/2022 20:09:44'!
amountMustBePositive
	
	^'El monto de la transferencia debe ser mayor a cero'! !

!Transfer class methodsFor: 'error-description' stamp: 'AEC 5/25/2022 20:04:14'!
cantHaveSameAccountAtBothEnds
	
	^'No se puede poner una misma cuenta como emisora y receptora de la misma transferencia.' ! !
