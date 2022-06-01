!classDefinition: #MarsRoverLoggerTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverLoggerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'fm 6/1/2022 20:10:26'!
test01LogsNothingWhenRoverDoesNotMove

	| marsRover logger |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := MarsRoverLogger followingPositionChangesOn: marsRover.
	
	marsRover process: ''.
	
	self assert: logger readStream atEnd.
! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'fm 6/1/2022 20:11:25'!
test02LogsNewPositionWhenRoverMovesForward

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := MarsRoverLogger followingPositionChangesOn: marsRover.
	
	marsRover process: 'f'.
	
	logStream := logger readStream.
	self assert: '1@2' equals: logStream nextLine.
	self assert: logStream atEnd.
! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'fm 6/1/2022 20:11:35'!
test03LogsNewPositionWhenRoverMovesBackward

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := MarsRoverLogger followingPositionChangesOn: marsRover.
	
	marsRover process: 'b'.
	
	logStream := logger readStream.
	self assert: '1@0' equals: logStream nextLine.
	self assert: logStream atEnd.
! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'fm 6/1/2022 20:12:37'!
test04LogsALineForEveryRoverMovement

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingEast.
	logger := MarsRoverLogger followingPositionChangesOn: marsRover.
	
	marsRover process: 'fb'.
	
	logStream := logger readStream.
	self assert: '2@1' equals: logStream nextLine.
	self assert: '1@1' equals: logStream nextLine.
	self assert: logStream atEnd.
! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'fm 6/1/2022 20:13:04'!
test05LogsNewHeadingWhenRoverRotatesRight

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := MarsRoverLogger followingHeadingChangesOn: marsRover.
	
	marsRover process: 'r'.
	
	logStream := logger readStream.
	self assert: 'East' equals: logStream nextLine.
	self assert: logStream atEnd.! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'fm 6/1/2022 20:13:29'!
test06LogsALineForEveryRoverRotation

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingEast.
	logger := MarsRoverLogger followingHeadingChangesOn: marsRover.
	
	marsRover process: 'lll'.
	
	logStream := logger readStream.
	self assert: 'North' equals: logStream nextLine.
	self assert: 'West' equals: logStream nextLine.
	self assert: 'South' equals: logStream nextLine.
	self assert: logStream atEnd.! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'fm 6/1/2022 20:14:09'!
test07LogsALineForEveryRoverAction

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingEast.
	logger := MarsRoverLogger followingPositionAndHeadingChangesOn: marsRover.
	
	marsRover process: 'rfr'.
	
	logStream := logger readStream.
	self assert: 'South' equals: logStream nextLine.
	self assert: '1@0' equals: logStream nextLine.
	self assert: 'West' equals: logStream nextLine.
	self assert: logStream atEnd.! !


!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:21:23'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:12'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:31'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:17'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:45'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !


!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:31'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:38'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:45'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:54'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'HAW 10/7/2021 20:20:47'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !


!classDefinition: #MarsRoverWindowTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverWindowTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'fm 6/1/2022 20:15:52'!
test01ShowsNothingWhenRoverDoesNotMove

	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingEast.
	window := MarsRoverWindow followPositionChangesOn: marsRover.
	
	marsRover process: ''.
	
	self assert: '' equals: window show! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'fm 6/1/2022 20:16:26'!
test02ShowsNewPositionWhenRoverMoves

	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingEast.
	window := MarsRoverWindow followPositionChangesOn: marsRover.
	
	marsRover process: 'f'.
	
	self assert: '2@1' equals: window show! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'fm 6/1/2022 20:18:07'!
test03ShowsNothingWhenRoverDoesNotRotate

	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingEast.
	window := MarsRoverWindow followHeadingChangesOn: marsRover.
	
	marsRover process: ''.
	
	self assert: '' equals: window show! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'fm 6/1/2022 20:18:29'!
test04ShowsLastHeadingWhenRoverRotatesManyTimes

	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingEast.
	window := MarsRoverWindow followHeadingChangesOn: marsRover.
	
	marsRover process: 'rrr'.
	
	self assert: 'Apuntando al Norte' equals: window show! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'fm 6/1/2022 20:22:49'!
test05ShowsOnlyUpdatedFieldsAccordingToRoverActions

	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingSouth.
	window := MarsRoverWindow followPositionAndHeadingChangesOn: marsRover.
	
	self assert: '' equals: window show.
	
	marsRover process: 'l'.
	
	self assert: 'Apuntando al Este' equals: window show.
	
	marsRover process: 'f'.
	
	self assert: '2@1 Apuntando al Este' equals: window show. ! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'command processing' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 8/22/2019 12:08:50'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'heading' stamp: 'AEC 5/31/2022 19:15:39'!
headEast
	
	head update: (MarsRoverHeadingEast for: self).! !

!MarsRover methodsFor: 'heading' stamp: 'AEC 5/31/2022 19:16:02'!
headNorth
	
	head update: (MarsRoverHeadingNorth for: self).! !

!MarsRover methodsFor: 'heading' stamp: 'AEC 5/31/2022 19:16:15'!
headSouth
	
	head update: (MarsRoverHeadingSouth for: self).! !

!MarsRover methodsFor: 'heading' stamp: 'AEC 5/31/2022 19:16:29'!
headWest
	
	head update: (MarsRoverHeadingWest for: self).! !

!MarsRover methodsFor: 'heading' stamp: 'AEC 5/31/2022 19:26:26'!
rotateLeft
	
	self headProxyValue rotateLeft! !

!MarsRover methodsFor: 'heading' stamp: 'AEC 5/31/2022 19:26:26'!
rotateRight
	
	self headProxyValue rotateRight! !


!MarsRover methodsFor: 'initialization' stamp: 'AEC 5/31/2022 19:11:44'!
initializeAt: aPosition heading: aHeadingType

	position := PositionProxy on: aPosition.
	head := HeadingProxy on: (aHeadingType for: self).! !


!MarsRover methodsFor: 'moving' stamp: 'AEC 6/1/2022 13:15:18'!
addToPosition: newPosition

	position update: (self positionProxyValue + newPosition).! !

!MarsRover methodsFor: 'moving' stamp: 'AEC 5/31/2022 19:26:26'!
headProxyValue

	^ head value! !

!MarsRover methodsFor: 'moving' stamp: 'AEC 5/31/2022 19:26:26'!
moveBackward
	
	self headProxyValue moveBackward! !

!MarsRover methodsFor: 'moving' stamp: 'AEC 6/1/2022 13:15:18'!
moveEast
	
	self addToPosition: 1@0.
	! !

!MarsRover methodsFor: 'moving' stamp: 'AEC 5/31/2022 19:26:26'!
moveForward
	
	self headProxyValue moveForward! !

!MarsRover methodsFor: 'moving' stamp: 'AEC 6/1/2022 13:15:18'!
moveNorth
	
	self addToPosition: 0@1.
	! !

!MarsRover methodsFor: 'moving' stamp: 'AEC 6/1/2022 13:15:18'!
moveSouth
	
	self addToPosition: 0@-1.
	! !

!MarsRover methodsFor: 'moving' stamp: 'AEC 6/1/2022 13:15:18'!
moveWest
	
	self addToPosition: -1@0! !

!MarsRover methodsFor: 'moving' stamp: 'AEC 5/31/2022 19:26:44'!
positionProxyValue

	^ position value! !


!MarsRover methodsFor: 'observing' stamp: 'AEC 5/31/2022 19:43:56'!
followHeadingChangesWith: anObserver

	head attach: anObserver! !

!MarsRover methodsFor: 'observing' stamp: 'AEC 5/31/2022 19:43:47'!
followPositionChangesWith: anObserver

	position attach: anObserver! !


!MarsRover methodsFor: 'testing' stamp: 'AEC 5/31/2022 19:26:44'!
isAt: aPosition heading: aHeadingType

	^self positionProxyValue = aPosition and: [ self headProxyValue isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:15:38'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:11:59'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !


!MarsRoverHeading methodsFor: 'visiting' stamp: 'AEC 6/1/2022 13:14:00'!
accept: aVisitor

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:11:35'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headSouth! !


!MarsRoverHeadingEast methodsFor: 'visiting' stamp: 'fm 6/1/2022 20:28:26'!
accept: aVisitor

	^aVisitor visitMarsRoverHeadingEast! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !


!MarsRoverHeadingNorth methodsFor: 'visiting' stamp: 'fm 6/1/2022 20:28:33'!
accept: aVisitor

	^aVisitor visitMarsRoverHeadingNorth! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !


!MarsRoverHeadingSouth methodsFor: 'visiting' stamp: 'fm 6/1/2022 20:28:40'!
accept: aVisitor

	^aVisitor visitMarsRoverHeadingSouth! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !


!MarsRoverHeadingWest methodsFor: 'visiting' stamp: 'fm 6/1/2022 20:28:52'!
accept: aVisitor

	^aVisitor visitMarsRoverHeadingWest! !


!classDefinition: #MarsRoverObserver category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverObserver
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverObserver methodsFor: 'initialization' stamp: 'AEC 6/1/2022 13:26:10'!
initialize

	self subclassResponsibility ! !

!MarsRoverObserver methodsFor: 'initialization' stamp: 'AEC 6/1/2022 13:24:24'!
initializeFollowingHeadingChangesOn: aMarsRover 

	aMarsRover followHeadingChangesWith: self
	! !

!MarsRoverObserver methodsFor: 'initialization' stamp: 'AEC 6/1/2022 13:25:51'!
initializeFollowingPositionAndHeadingChangesOn: aMarsRover 

	self initializeFollowingHeadingChangesOn: aMarsRover.
	self initializeFollowingPositionChangesOn: aMarsRover ! !

!MarsRoverObserver methodsFor: 'initialization' stamp: 'AEC 6/1/2022 13:25:43'!
initializeFollowingPositionChangesOn: aMarsRover 
	
	aMarsRover followPositionChangesWith: self! !


!MarsRoverObserver methodsFor: 'updating' stamp: 'AEC 6/1/2022 13:29:50'!
updateHeading: aMarsRoverHeading

	aMarsRoverHeading accept: self! !

!MarsRoverObserver methodsFor: 'updating' stamp: 'AEC 6/1/2022 13:29:14'!
updatePosition: aPosition

	self subclassResponsibility ! !

!MarsRoverObserver methodsFor: 'updating' stamp: 'fm 6/1/2022 20:28:26'!
visitMarsRoverHeadingEast

	self subclassResponsibility ! !

!MarsRoverObserver methodsFor: 'updating' stamp: 'fm 6/1/2022 20:28:33'!
visitMarsRoverHeadingNorth

	self subclassResponsibility ! !

!MarsRoverObserver methodsFor: 'updating' stamp: 'fm 6/1/2022 20:28:40'!
visitMarsRoverHeadingSouth

	self subclassResponsibility ! !

!MarsRoverObserver methodsFor: 'updating' stamp: 'fm 6/1/2022 20:28:51'!
visitMarsRoverHeadingWest

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverObserver class' category: 'MarsRover-WithHeading'!
MarsRoverObserver class
	instanceVariableNames: ''!

!MarsRoverObserver class methodsFor: 'instance creation' stamp: 'fm 6/1/2022 19:58:16'!
followingHeadingChangesOn: aMarsRover 
	
	^self new initializeFollowingHeadingChangesOn: aMarsRover.! !

!MarsRoverObserver class methodsFor: 'instance creation' stamp: 'fm 6/1/2022 19:58:19'!
followingPositionAndHeadingChangesOn: aMarsRover 

	^self new initializeFollowingPositionAndHeadingChangesOn: aMarsRover.! !

!MarsRoverObserver class methodsFor: 'instance creation' stamp: 'fm 6/1/2022 19:58:23'!
followingPositionChangesOn: aMarsRover 
	
	^self new initializeFollowingPositionChangesOn: aMarsRover.! !


!classDefinition: #MarsRoverLogger category: 'MarsRover-WithHeading'!
MarsRoverObserver subclass: #MarsRoverLogger
	instanceVariableNames: 'log'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLogger methodsFor: 'accessing' stamp: 'HAW 5/30/2022 20:23:26'!
readStream
	
	^ReadStream on: log contents ! !


!MarsRoverLogger methodsFor: 'initialization' stamp: 'AEC 6/1/2022 12:11:23'!
initialize

	log  := WriteStream on: ''! !


!MarsRoverLogger methodsFor: 'updating' stamp: 'AEC 5/31/2022 22:17:50'!
updatePosition: aPosition

	self addToLog: aPosition asString! !

!MarsRoverLogger methodsFor: 'updating' stamp: 'fm 6/1/2022 20:28:26'!
visitMarsRoverHeadingEast
	
	self addToLog: 'East'.! !

!MarsRoverLogger methodsFor: 'updating' stamp: 'fm 6/1/2022 20:28:33'!
visitMarsRoverHeadingNorth
	
	self addToLog: 'North'.! !

!MarsRoverLogger methodsFor: 'updating' stamp: 'fm 6/1/2022 20:28:40'!
visitMarsRoverHeadingSouth
	
	self addToLog: 'South'.! !

!MarsRoverLogger methodsFor: 'updating' stamp: 'fm 6/1/2022 20:28:52'!
visitMarsRoverHeadingWest
	
	self addToLog: 'West'.! !


!MarsRoverLogger methodsFor: 'updating - private' stamp: 'AEC 5/31/2022 22:17:59'!
addToLog: aLine

	log nextPutAll: aLine; newLine! !


!classDefinition: #MarsRoverWindow category: 'MarsRover-WithHeading'!
MarsRoverObserver subclass: #MarsRoverWindow
	instanceVariableNames: 'positionField headingField'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverWindow methodsFor: 'accessing' stamp: 'AEC 6/1/2022 13:17:29'!
show

	^(positionField,' ',headingField) withBlanksTrimmed! !


!MarsRoverWindow methodsFor: 'initialization' stamp: 'AEC 6/1/2022 12:46:09'!
initialize

	headingField  := ''.
	positionField  := ''! !


!MarsRoverWindow methodsFor: 'updating' stamp: 'AEC 5/31/2022 22:28:56'!
updatePosition: aPosition

	positionField := aPosition asString! !

!MarsRoverWindow methodsFor: 'updating' stamp: 'fm 6/1/2022 20:28:26'!
visitMarsRoverHeadingEast
	
	headingField := 'Apuntando al Este'.! !

!MarsRoverWindow methodsFor: 'updating' stamp: 'fm 6/1/2022 20:28:33'!
visitMarsRoverHeadingNorth
	
	headingField := 'Apuntando al Norte'.! !

!MarsRoverWindow methodsFor: 'updating' stamp: 'fm 6/1/2022 20:28:40'!
visitMarsRoverHeadingSouth
	
	headingField := 'Apuntando al Sur'.! !

!MarsRoverWindow methodsFor: 'updating' stamp: 'fm 6/1/2022 20:28:52'!
visitMarsRoverHeadingWest
	
	headingField := 'Apuntando al Oeste'.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverWindow class' category: 'MarsRover-WithHeading'!
MarsRoverWindow class
	instanceVariableNames: ''!

!MarsRoverWindow class methodsFor: 'instance-creation' stamp: 'AEC 5/31/2022 22:29:20'!
followHeadingChangesOn: aMarsRover 
	
	^self new initializeFollowingHeadingChangesOn: aMarsRover.! !

!MarsRoverWindow class methodsFor: 'instance-creation' stamp: 'AEC 5/31/2022 22:29:29'!
followPositionAndHeadingChangesOn: aMarsRover 

	^self new initializeFollowingPositionAndHeadingChangesOn: aMarsRover.! !

!MarsRoverWindow class methodsFor: 'instance-creation' stamp: 'AEC 5/31/2022 22:29:37'!
followPositionChangesOn: aMarsRover 
	
	^self new initializeFollowingPositionChangesOn: aMarsRover.! !


!classDefinition: #MarsRoverVariableProxy category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverVariableProxy
	instanceVariableNames: 'value observers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverVariableProxy methodsFor: 'accessing' stamp: 'AEC 5/31/2022 19:49:50'!
value

	^value! !


!MarsRoverVariableProxy methodsFor: 'initialization' stamp: 'AEC 5/31/2022 19:49:30'!
initializeOn: anInitialValue

	value := anInitialValue.
	observers := Set new.! !


!MarsRoverVariableProxy methodsFor: 'notifying' stamp: 'fm 6/1/2022 19:18:15'!
notify

	observers do: [:observer | self notifyObserver: observer ]! !


!MarsRoverVariableProxy methodsFor: 'notifying - private' stamp: 'AEC 6/1/2022 13:10:40'!
notifyObserver: anObserver

	self subclassResponsibility ! !


!MarsRoverVariableProxy methodsFor: 'observing' stamp: 'AEC 5/31/2022 19:48:20'!
attach: anObserver

	observers add: anObserver! !

!MarsRoverVariableProxy methodsFor: 'observing' stamp: 'AEC 5/31/2022 20:04:23'!
update: aNewValue

	value := aNewValue.
	self notify! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverVariableProxy class' category: 'MarsRover-WithHeading'!
MarsRoverVariableProxy class
	instanceVariableNames: ''!

!MarsRoverVariableProxy class methodsFor: 'as yet unclassified' stamp: 'AEC 5/31/2022 19:50:37'!
on: anInitialValue

	^ self new initializeOn: anInitialValue! !


!classDefinition: #HeadingProxy category: 'MarsRover-WithHeading'!
MarsRoverVariableProxy subclass: #HeadingProxy
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!HeadingProxy methodsFor: 'notifying - private' stamp: 'AEC 5/31/2022 20:03:33'!
notifyObserver: anObserver

	anObserver updateHeading: value! !


!classDefinition: #PositionProxy category: 'MarsRover-WithHeading'!
MarsRoverVariableProxy subclass: #PositionProxy
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!PositionProxy methodsFor: 'notifying - private' stamp: 'AEC 5/31/2022 20:03:47'!
notifyObserver: anObserver

	anObserver updatePosition: value! !
