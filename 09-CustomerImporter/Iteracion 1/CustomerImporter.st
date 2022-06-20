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

!ImportTest methodsFor: 'asserting' stamp: 'AEC 6/16/2022 21:44:38'!
assertPepeSanchezIsImportedCorrectly

	| importedCustomer |
	
	importedCustomer := self customerWithIdType: 'D' number: '22333444'.
	
	self assert: importedCustomer hasFirstName: 'Pepe' lastName: 'Sanchez' idType: 'D' idNumber: '22333444'.
	
	self assert: importedCustomer hasAddressAt: 'San Martin' number: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	
	self assert: importedCustomer hasAddressAt: 'Maipu' number: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.! !


!ImportTest methodsFor: 'running' stamp: 'AEC 6/16/2022 20:34:02'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction! !

!ImportTest methodsFor: 'running' stamp: 'AEC 6/16/2022 20:35:26'!
tearDown

	session commit.
	session close! !


!ImportTest methodsFor: 'tests' stamp: 'AEC 6/16/2022 21:45:29'!
test01Import
	
	(CustomerImporter from: self validData into: session) value.
	
	self assert: 2 equals: (session selectAllOfType: Customer) size.
	
	self assertPepeSanchezIsImportedCorrectly.
	
	self assertJuanPerezIsImportedCorrectly.
	
! !


!ImportTest methodsFor: 'test-support' stamp: 'AEC 6/16/2022 21:11:47'!
customerWithIdType: anIdType number: anIdNumber 

	^ (session select: [:customer | customer idTypeIs: anIdType andIdNumberIs: anIdNumber] ofType: Customer) anyOne! !

!ImportTest methodsFor: 'test-support' stamp: 'AEC 6/16/2022 21:21:50'!
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
	instanceVariableNames: 'session stream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'AEC 6/16/2022 21:22:57'!
initializeFrom: aStream into: aSession
	session := aSession.
	stream := aStream.! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'AEC 6/16/2022 21:22:57'!
value

	| newCustomer line |

	line := stream nextLine.
	[ line notNil ] whileTrue: [
		(line beginsWith: 'C') ifTrue: [ | customerData |
			customerData := line findTokens: $,.
			newCustomer := Customer new.
			newCustomer firstName: customerData second.
			newCustomer lastName: customerData third.
			newCustomer identificationType: customerData fourth.
			newCustomer identificationNumber: customerData fifth.
			session persist: newCustomer ].

		(line beginsWith: 'A') ifTrue: [ | addressData newAddress |
			addressData := line findTokens: $,.
			newAddress := Address new.
			newCustomer addAddress: newAddress.
			newAddress streetName: addressData second.
			newAddress streetNumber: addressData third asNumber .
			newAddress town: addressData fourth.
			newAddress zipCode: addressData fifth asNumber .
			newAddress province: addressData sixth ].

		line := stream nextLine. ].

	stream close.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'AEC 6/16/2022 21:22:57'!
from: aStream into: aSession
	^self new initializeFrom: aStream into: aSession! !


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
