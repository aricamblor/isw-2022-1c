!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'asserting' stamp: 'AEC 6/16/2022 21:14:54'!
assert: importedCustomer hasAddressAt: aStreetName number: aStreetNumber town: aTown zipCode: aZipCode province: aProvince     
	
	| address |
	
	address := importedCustomer addressAt: aStreetName number: aStreetNumber.
	
	self assert: aStreetName equals: address streetName.
	self assert: aStreetNumber equals: address streetNumber.
	self assert: aTown equals: address town.
	self assert: aZipCode equals: address zipCode.
	self assert: aProvince equals: address province.! !

!ImportTest methodsFor: 'asserting' stamp: 'AEC 6/16/2022 21:18:19'!
assert: importedCustomer hasFirstName: aName lastName: aLastName idType: anIdType idNumber: anIdNumber    

	self assert: aName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdType equals: importedCustomer identificationType.
	self assert: anIdNumber equals: importedCustomer identificationNumber! !

!ImportTest methodsFor: 'asserting' stamp: 'AEC 6/16/2022 21:45:11'!
assertJuanPerezIsImportedCorrectly

	| importedCustomer |
	
	importedCustomer := self customerWithIdType: 'C' number: '23-25666777-9'.
	
	self assert: importedCustomer hasFirstName: 'Juan' lastName: 'Perez' idType: 'C' idNumber: '23-25666777-9'.
	
	self assert: importedCustomer hasAddressAt: 'Alem' number: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'.! !

!ImportTest methodsFor: 'asserting' stamp: 'fm 6/27/2022 14:21:23'!
assertNoAddressWasImported

	self assert: 0 equals: (session selectAllOfType: Address) size! !

!ImportTest methodsFor: 'asserting' stamp: 'fm 6/27/2022 14:04:46'!
assertNoCustomerWasImported

	self assert: 0 equals: (session selectAllOfType: Customer) size! !

!ImportTest methodsFor: 'asserting' stamp: 'fm 6/27/2022 14:23:27'!
assertPepeSanchezAddressesAreImportedCorrectly

	| importedCustomer |
	
	importedCustomer := self customerWithIdType: 'D' number: '22333444'.
	
	self assert: importedCustomer hasAddressAt: 'San Martin' number: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	
	self assert: importedCustomer hasAddressAt: 'Maipu' number: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'! !

!ImportTest methodsFor: 'asserting' stamp: 'fm 6/27/2022 14:23:42'!
assertPepeSanchezIsImportedCorrectly
	
	self assertPepeSanchezPersonalInformationIsImportedCorrectly.
	self assertPepeSanchezAddressesAreImportedCorrectly.! !

!ImportTest methodsFor: 'asserting' stamp: 'fm 6/27/2022 14:13:16'!
assertPepeSanchezPersonalInformationIsImportedCorrectly

	| importedCustomer |
	
	importedCustomer := self customerWithIdType: 'D' number: '22333444'.
	
	self assert: importedCustomer hasFirstName: 'Pepe' lastName: 'Sanchez' idType: 'D' idNumber: '22333444'.! !


!ImportTest methodsFor: 'running' stamp: 'AEC 6/16/2022 20:34:02'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction! !

!ImportTest methodsFor: 'running' stamp: 'AEC 6/16/2022 20:35:26'!
tearDown

	session commit.
	session close! !


!ImportTest methodsFor: 'tests' stamp: 'AEC 6/23/2022 21:20:07'!
test01CanImportValidCustomersWithVaildAddresses
	
	(CustomerImporter from: self validData into: session) value.
	
	self assert: 2 equals: (session selectAllOfType: Customer) size.
	
	self assertPepeSanchezIsImportedCorrectly.
	
	self assertJuanPerezIsImportedCorrectly.
	
! !

!ImportTest methodsFor: 'tests' stamp: 'fm 6/27/2022 14:04:18'!
test02CustomerRecordMustStartWithLetterCOnly

	self should: [ self importFrom: self invalidCustomerTypeRecord ]
	raise: Error
	withExceptionDo: [:anError |
		self assert: anError messageText equals: CustomerImporter invalidRecordTypeErrorDescription.	
		self assertNoCustomerWasImported.
	].! !

!ImportTest methodsFor: 'tests' stamp: 'fm 6/27/2022 14:21:23'!
test03AddressRecordMustStartWithLetterAOnly

	self should: [ self importFrom: (self validCustomerWithAddress: self addressWithInvalidType) ]
	raise: Error
	withExceptionDo: [:anError |
		self assert: anError messageText equals: CustomerImporter invalidRecordTypeErrorDescription.	
		self assertPepeSanchezPersonalInformationIsImportedCorrectly.
		self assertNoAddressWasImported.
	].! !

!ImportTest methodsFor: 'tests' stamp: 'fm 6/27/2022 14:19:28'!
test04CustomerRecordCantHaveMoreThanFiveFields
	
	self should: [self importFrom: self customerRecordWithSixFields]
	raise: Error
	withExceptionDo: [:anError |
		self assert: anError messageText equals: CustomerImporter customerRecordWithTooManyFieldsErrorDescription.	
		self assertNoCustomerWasImported
	].! !

!ImportTest methodsFor: 'tests' stamp: 'fm 6/27/2022 14:19:37'!
test05CustomerRecordCantHaveLessThanFiveFields
	
	self should: [self importFrom: self customerRecordWithFourFields]
	raise: Error
	withExceptionDo: [:anError |
		self assert: anError messageText equals: CustomerImporter customerRecordWithNotEnoughFieldsErrorDescription.	
		self assertNoCustomerWasImported
	].! !

!ImportTest methodsFor: 'tests' stamp: 'fm 6/27/2022 14:21:23'!
test06AddressRecordCantHaveMoreThanSixFields
	
	self should: [self importFrom:(self validCustomerWithAddress: self addressWithSevenFields)]
	raise: Error
	withExceptionDo: [:anError |
		self assert: anError messageText equals: CustomerImporter addressRecordWithTooManyFieldsErrorDescription.	
		self assertPepeSanchezPersonalInformationIsImportedCorrectly.
		self assertNoAddressWasImported
	].! !

!ImportTest methodsFor: 'tests' stamp: 'fm 6/27/2022 14:21:23'!
test07AddressRecordCantHaveLessThanSixFields
	
	self should: [self importFrom:(self validCustomerWithAddress: self addressWithFiveFields)]
	raise: Error
	withExceptionDo: [:anError |
		self assert: anError messageText equals: CustomerImporter addressRecordWithNotEnoughFieldsErrorDescription.	
		self assertPepeSanchezPersonalInformationIsImportedCorrectly.
		self assertNoAddressWasImported
	].! !

!ImportTest methodsFor: 'tests' stamp: 'fm 6/27/2022 14:21:23'!
test08CantImportAddressIfNoCustomerHasBeenImported
	
	self should: [self importFrom: self validAddressRecord]
	raise: Error
	withExceptionDo: [:anError |
		self assert: anError messageText equals: CustomerImporter noCustomerToImportAddressErrorDescription.	
		self assertNoAddressWasImported
	].! !

!ImportTest methodsFor: 'tests' stamp: 'fm 6/27/2022 14:21:23'!
test09CantImportEmptyRecord
	
	self should: [self importFrom: self streamWithEmptyLine]
	raise: Error
	withExceptionDo: [:anError |
		self assert: anError messageText equals: CustomerImporter emptyRecordErrorDescription.	
		self assertNoCustomerWasImported.
		self assertNoAddressWasImported
	].! !


!ImportTest methodsFor: 'test-support' stamp: 'AEC 6/23/2022 20:25:45'!
addressWithFiveFields

	^ 'A,San Martin,3322,Olivos,1636'! !

!ImportTest methodsFor: 'test-support' stamp: 'AEC 6/23/2022 20:14:38'!
addressWithInvalidType

	^ 'Af,San Martin,3322,Olivos,1636,BsAs'! !

!ImportTest methodsFor: 'test-support' stamp: 'AEC 6/23/2022 20:25:58'!
addressWithSevenFields

	^ 'A,San Martin,3322,Olivos,1636,BsAs,Argentina'! !

!ImportTest methodsFor: 'test-support' stamp: 'AEC 6/23/2022 19:59:07'!
customerRecordWithFourFields

	^ ReadStream on: 'C,Pepe,Sanchez,D'! !

!ImportTest methodsFor: 'test-support' stamp: 'AEC 6/23/2022 19:58:54'!
customerRecordWithSixFields

	^ ReadStream on: 'C,Jose,Pepe,Sanchez,D,22333444'! !

!ImportTest methodsFor: 'test-support' stamp: 'AEC 6/16/2022 21:11:47'!
customerWithIdType: anIdType number: anIdNumber 

	^ (session select: [:customer | customer idTypeIs: anIdType andIdNumberIs: anIdNumber] ofType: Customer) anyOne! !

!ImportTest methodsFor: 'test-support' stamp: 'AEC 6/23/2022 20:22:11'!
importFrom: stream

	^ (CustomerImporter from: stream into: session) value! !

!ImportTest methodsFor: 'test-support' stamp: 'AEC 6/23/2022 20:15:12'!
invalidCustomerTypeRecord

	^ ReadStream on: 'Cw,Pepe,Sanchez,D,22333444'! !

!ImportTest methodsFor: 'test-support' stamp: 'AEC 6/23/2022 21:02:32'!
streamWithEmptyLine

	^ ReadStream on: (String crString,self validCustomer)! !

!ImportTest methodsFor: 'test-support' stamp: 'AEC 6/23/2022 20:30:47'!
validAddressRecord

	^ ReadStream on: 'A,San Martin,3322,Olivos,1636,BsAs'! !

!ImportTest methodsFor: 'test-support' stamp: 'AEC 6/23/2022 20:12:28'!
validCustomer

	^'C,Pepe,Sanchez,D,22333444'! !

!ImportTest methodsFor: 'test-support' stamp: 'AEC 6/23/2022 20:12:35'!
validCustomerWithAddress: anAddress

	^ReadStream on: self validCustomer,String crString,anAddress! !

!ImportTest methodsFor: 'test-support' stamp: 'AEC 6/23/2022 20:57:23'!
validData

	^ ReadStream on: 
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !


!classDefinition: #Address category: 'CustomerImporter'!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province

	^province! !

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province: aProvince

	province := aProvince
	! !


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !


!Address methodsFor: 'testing' stamp: 'AEC 6/16/2022 20:59:38'!
isAt: aStreetName number: aStreetNumber 

	^ streetName = aStreetName and: [streetNumber = aStreetNumber]! !


!Address methodsFor: 'town' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !

!Address methodsFor: 'town' stamp: 'HAW 5/22/2022 00:19:29'!
town: aTown

	town := aTown! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode: aZipCode

	zipCode := aZipCode! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'accessing' stamp: 'AEC 6/16/2022 21:00:17'!
addressAt: aStreetName number: aStreetNumber  

	^ addresses detect: [:anAddress | anAddress isAt: aStreetName number: aStreetNumber]! !


!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !


!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


!Customer methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !


!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName: aName

	firstName := aName! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName

	^lastName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName: aLastName

	lastName := aLastName
! !


!Customer methodsFor: 'testing' stamp: 'AEC 6/16/2022 20:53:16'!
idTypeIs: anIdType andIdNumberIs: anIdNumber  

	^ identificationType = anIdType and: [identificationNumber = anIdNumber]! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'session stream record line newCustomer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'fm 6/27/2022 13:39:49'!
initializeFrom: aStream into: aSession

	session := aSession.
	stream := aStream.! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'AEC 6/23/2022 20:40:20'!
assertCustomerWasImported

	^ newCustomer ifNil:[ self error: self class noCustomerToImportAddressErrorDescription ]! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'AEC 6/23/2022 21:03:02'!
assertRecordIsNotEmpty

	^ record ifEmpty: [ self error: self class emptyRecordErrorDescription ]! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'AEC 6/23/2022 20:41:16'!
assertRecordSizeIsCorrectForAddress

	(record size > 6) ifTrue: [self error: self class addressRecordWithTooManyFieldsErrorDescription].
	(record size < 6) ifTrue: [self error: self class addressRecordWithNotEnoughFieldsErrorDescription]! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'AEC 6/23/2022 20:41:05'!
assertRecordSizeIsCorrectForCustomer

	(record size > 5) ifTrue: [self error: self class customerRecordWithTooManyFieldsErrorDescription].
	(record size < 5) ifTrue: [self error: self class customerRecordWithNotEnoughFieldsErrorDescription]! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'AEC 6/23/2022 21:03:34'!
createRecord

	record := line findTokens: $,.! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'AEC 6/23/2022 18:36:55'!
hasLineToImport

	line := stream nextLine.
	^ line notNil! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'AEC 6/23/2022 20:41:16'!
importAddress

	| newAddress |
	
	self assertRecordSizeIsCorrectForAddress.
	self assertCustomerWasImported.
	
	newAddress := Address new.
	newCustomer addAddress: newAddress.
	newAddress streetName: record second.
	newAddress streetNumber: record third asNumber .
	newAddress town: record fourth.
	newAddress zipCode: record fifth asNumber .
	newAddress province: record sixth! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'AEC 6/23/2022 20:41:05'!
importCustomer

	self assertRecordSizeIsCorrectForCustomer.
	
	newCustomer := Customer new.
	newCustomer firstName: record second.
	newCustomer lastName: record third.
	newCustomer identificationType: record fourth.
	newCustomer identificationNumber: record fifth.
	session persist: newCustomer! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'AEC 6/23/2022 21:03:47'!
importRecord

	self assertRecordIsNotEmpty.
	
	self isCustomerRecord ifTrue: [ ^ self importCustomer ].
	self isAddressRecord ifTrue: [ ^ self importAddress ].
	
	self error: self class invalidRecordTypeErrorDescription
	! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'AEC 6/23/2022 19:39:39'!
isAddressRecord

	^ record first = 'A'! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'AEC 6/23/2022 19:34:56'!
isCustomerRecord

	^ record first = 'C'! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'AEC 6/23/2022 19:37:12'!
value

	[ self hasLineToImport ] whileTrue: [
		self createRecord.
		self importRecord.
	].
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'fm 6/27/2022 13:39:08'!
from: aStream into: aSession

	^self new initializeFrom: aStream into: aSession! !


!CustomerImporter class methodsFor: 'error-description' stamp: 'AEC 6/23/2022 20:26:54'!
addressRecordWithNotEnoughFieldsErrorDescription
	
	 ^ 'El registro de direccion tiene menos campos de los esperados.'! !

!CustomerImporter class methodsFor: 'error-description' stamp: 'AEC 6/23/2022 20:08:53'!
addressRecordWithTooManyFieldsErrorDescription
	
	^ 'El registro de direccion tiene mas campos de los esperados.'! !

!CustomerImporter class methodsFor: 'error-description' stamp: 'AEC 6/23/2022 20:04:18'!
customerRecordWithNotEnoughFieldsErrorDescription
	
	^ 'El registro de customer no tiene la cantidad de campos esperados.'! !

!CustomerImporter class methodsFor: 'error-description' stamp: 'AEC 6/23/2022 20:01:02'!
customerRecordWithTooManyFieldsErrorDescription

	^'El registro de customer tiene mas campos de los esperados.'! !

!CustomerImporter class methodsFor: 'error-description' stamp: 'AEC 6/23/2022 21:00:13'!
emptyRecordErrorDescription
	
	^ 'El registro esta vacio.'! !

!CustomerImporter class methodsFor: 'error-description' stamp: 'AEC 6/23/2022 19:25:07'!
invalidRecordTypeErrorDescription

	^'El campo de tipo del registro tiene un valor invalido.'! !

!CustomerImporter class methodsFor: 'error-description' stamp: 'AEC 6/23/2022 20:35:37'!
noCustomerToImportAddressErrorDescription
	
	^ 'No se importo un customer previo a importar la direccion.'! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 00:19:29'!
beginTransaction

	! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 19:17:36'!
commit

	(tables at: Customer ifAbsent: [#()]) do: [ :aCustomer | self persistAddressesOf: aCustomer ]
	! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 5/22/2022 00:19:29'!
close

	! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 19:29:06'!
objectsOfType: aType

	^ tables at: aType ifAbsent: [ #() ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
persistAddressesOf: anObjectWithAddresses

	anObjectWithAddresses addresses do: [ :anAddress | self persist: anAddress ]
	! !


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'HAW 5/22/2022 00:19:29'!
persist: anObject

	| table |

	self delay.
	table := tables at: anObject class ifAbsentPut: [ Set new ].

	self defineIdOf: anObject.
	table add: anObject.

	(anObject isKindOf: Customer) ifTrue: [ self persistAddressesOf: anObject ].! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
select: aCondition ofType: aType

	self delay.
	^(self objectsOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
selectAllOfType: aType

	self delay.
	^(self objectsOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !
