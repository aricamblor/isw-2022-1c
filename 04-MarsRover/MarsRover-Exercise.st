!classDefinition: #MarsRoverTest category: 'MarsRover-Exercise'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRoverTest methodsFor: 'rover instance creation' stamp: 'AEC 5/16/2022 13:34:33'!
marsRoverHeadingEast

	^ MarsRover heading: East new! !

!MarsRoverTest methodsFor: 'rover instance creation' stamp: 'AEC 5/16/2022 13:34:19'!
marsRoverHeadingNorth

	^ MarsRover heading: North new! !

!MarsRoverTest methodsFor: 'rover instance creation' stamp: 'AEC 5/16/2022 13:33:30'!
marsRoverHeadingSouth

	^ MarsRover heading: South new! !

!MarsRoverTest methodsFor: 'rover instance creation' stamp: 'AEC 5/16/2022 13:34:46'!
marsRoverHeadingWest

	^ MarsRover heading: West new! !


!MarsRoverTest methodsFor: 'tests' stamp: 'AEC 5/16/2022 13:33:30'!
test01RoverStaysAtOriginHeadingSouthWhenItRecievesAnEmptyString

	| rover |
	rover := self marsRoverHeadingSouth.
	
	rover process: ''.
	
	self assert: rover position equals: (0@0).
	self assert: rover isHeadingSouth.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AEC 5/16/2022 13:33:30'!
test02RoverRotatesToEastWhenReceivesRotateLeftAndIsHeadingSouth

	| rover |
	rover := self marsRoverHeadingSouth.
	
	rover process: 'l'.
	
	self assert: rover position equals: (0@0).
	self deny: rover isHeadingSouth.
	self assert: rover isHeadingEast! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AEC 5/16/2022 13:34:19'!
test03RoverRotatesToWestWhenReceivesRotateLeftAndIsHeadingNorth

	| rover |
	rover := self marsRoverHeadingNorth.
	
	rover process: 'l'.
	
	self assert: rover position equals: (0@0).
	self deny: rover isHeadingNorth.
	self assert: rover isHeadingWest! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AEC 5/16/2022 13:34:34'!
test04RoverRotatesToNorthWhenReceivesRotateLeftAndIsHeadingEast

	| rover |
	rover := self marsRoverHeadingEast.
	
	rover process: 'l'.
	
	self assert: rover position equals: (0@0).
	self deny: rover isHeadingEast.
	self assert: rover isHeadingNorth! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AEC 5/16/2022 13:34:46'!
test05RoverRotatesToSouthWhenReceivesRotateLeftAndIsHeadingWest

	| rover |
	rover := self marsRoverHeadingWest.
	
	rover process: 'l'.
	
	self assert: rover position equals: (0@0).
	self deny: rover isHeadingWest.
	self assert: rover isHeadingSouth! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AEC 5/16/2022 13:33:30'!
test06RoverRotatesToWestWhenReceivesRotateRightAndIsHeadingSouth

	| rover |
	rover := self marsRoverHeadingSouth.
	
	rover process: 'r'.
	
	self assert: rover position equals: (0@0).
	self deny: rover isHeadingSouth.
	self assert: rover isHeadingWest! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AEC 5/16/2022 13:34:19'!
test07RoverRotatesToEastWhenReceivesRotateRightAndIsHeadingNorth

	| rover |
	rover := self marsRoverHeadingNorth.
	
	rover process: 'r'.
	
	self assert: rover position equals: (0@0).
	self deny: rover isHeadingNorth.
	self assert: rover isHeadingEast! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AEC 5/16/2022 13:34:34'!
test08RoverRotatesToSouthWhenReceivesRotateRightAndIsHeadingEast

	| rover |
	rover := self marsRoverHeadingEast.
	
	rover process: 'r'.
	
	self assert: rover position equals: (0@0).
	self deny: rover isHeadingEast.
	self assert: rover isHeadingSouth! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AEC 5/16/2022 13:34:46'!
test09RoverRotatesToNorthWhenReceivesRotateRightAndIsHeadingWest

	| rover |
	rover := self marsRoverHeadingWest.
	
	rover process: 'r'.
	
	self assert: rover position equals: (0@0).
	self deny: rover isHeadingWest.
	self assert: rover isHeadingNorth! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AEC 5/16/2022 13:33:30'!
test10RoverAdvancesOneStepSouthWhenReceivesForwardAndIsHeadingSouth

	| rover |
	rover := self marsRoverHeadingSouth.
	
	rover process: 'f'.
	
	self assert: rover position equals: (0@-1).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AEC 5/16/2022 13:34:19'!
test11RoverAdvancesOneStepNorthWhenReceivesForwardAndIsHeadingNorth

	| rover |
	rover := self marsRoverHeadingNorth.
	
	rover process: 'f'.
	
	self assert: rover position equals: (0@1).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AEC 5/16/2022 13:34:34'!
test12RoverAdvancesOneStepEastWhenReceivesForwardAndIsHeadingEast

	| rover |
	rover := self marsRoverHeadingEast.
	
	rover process: 'f'.
	
	self assert: rover position equals: (1@0).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AEC 5/16/2022 13:34:46'!
test13RoverAdvancesOneStepWestWhenReceivesForwardAndIsHeadingWest

	| rover |
	rover := self marsRoverHeadingWest.
	
	rover process: 'f'.
	
	self assert: rover position equals: (-1@0).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AEC 5/16/2022 13:33:30'!
test14RoverMovesOneStepNorthWhenReceivesBackwardAndIsHeadingSouth

	| rover |
	rover := self marsRoverHeadingSouth.
	
	rover process: 'b'.
	
	self assert: rover position equals: (0@1).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AEC 5/16/2022 13:34:19'!
test15RoverMovesOneStepSouthWhenReceivesBackwardAndIsHeadingNorth

	| rover |
	rover := self marsRoverHeadingNorth.
	
	rover process: 'b'.
	
	self assert: rover position equals: (0@-1).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AEC 5/16/2022 13:34:34'!
test16RoverMovesOneStepWestWhenReceivesBackwardAndIsHeadingEast

	| rover |
	rover := self marsRoverHeadingEast.
	
	rover process: 'b'.
	
	self assert: rover position equals: (-1@0).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AEC 5/16/2022 13:34:46'!
test17RoverMovesOneStepEastWhenReceivesBackwardAndIsHeadingWest

	| rover |
	rover := self marsRoverHeadingWest.
	
	rover process: 'b'.
	
	self assert: rover position equals: (1@0).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AEC 5/16/2022 13:34:19'!
test18RoverRotatesRightAndAdvancesOneStepEastWhenReceivesRotateRightAndForwardHeadingNorth

	| rover |
	rover := self marsRoverHeadingNorth.
	
	rover process: 'rf'.
	
	self assert: rover isHeadingEast.
	self assert: rover position equals: (1@0)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AEC 5/16/2022 13:34:19'!
test19RoverRotatesRightAndAdvancesTwoStepsEastWhenReceivesRotateRightOnceAndForwardTwiceHeadingNorth

	| rover |
	rover := self marsRoverHeadingNorth.
	
	rover process: 'rff'.
	
	self assert: rover isHeadingEast.
	self assert: rover position equals: (2@0)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AEC 5/16/2022 13:34:19'!
test20RoverRaisesErrorWhenFirstCommandIsInvalid

	| rover |
	rover := self marsRoverHeadingNorth.
	
	self should: [ rover process: 'xrff'. ] raise: Error description: MarsRover invalidCommandErrorDescription.
	self assert: rover isHeadingNorth.
	self assert: rover position equals: (0@0)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AEC 5/16/2022 13:34:19'!
test21RoverProcessesValidCommandsThenReachesInvalidCommandAndRaisesError

	| rover |
	rover := self marsRoverHeadingNorth.
	
	self should: [ rover process: 'rffxbbl'. ] raise: Error description: MarsRover invalidCommandErrorDescription.
	self assert: rover isHeadingEast.
	self assert: rover position equals: (2@0)! !


!classDefinition: #Direction category: 'MarsRover-Exercise'!
Object subclass: #Direction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!Direction methodsFor: 'assertions' stamp: 'AEC 5/16/2022 12:20:32'!
is: aSymbol

	^self class name = aSymbol ! !


!Direction methodsFor: 'rotation' stamp: 'AEC 5/16/2022 12:20:14'!
rotateLeft

	^self subclassResponsibility ! !

!Direction methodsFor: 'rotation' stamp: 'AEC 5/16/2022 12:33:18'!
rotateRight

	^self subclassResponsibility ! !


!Direction methodsFor: 'movement' stamp: 'AEC 5/16/2022 13:12:13'!
moveBackwards: aMarsRover

	^ self subclassResponsibility ! !

!Direction methodsFor: 'movement' stamp: 'AEC 5/16/2022 12:54:12'!
moveForward: aMarsRover

	^ self subclassResponsibility ! !


!classDefinition: #East category: 'MarsRover-Exercise'!
Direction subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!East methodsFor: 'rotation' stamp: 'AEC 5/16/2022 12:20:58'!
rotateLeft

	^North new! !

!East methodsFor: 'rotation' stamp: 'AEC 5/16/2022 12:35:37'!
rotateRight

	^South new! !


!East methodsFor: 'movement' stamp: 'AEC 5/16/2022 13:12:48'!
moveBackwards: aMarsRover

	^aMarsRover moveWest! !

!East methodsFor: 'movement' stamp: 'AEC 5/16/2022 12:51:01'!
moveForward: aMarsRover

	^aMarsRover moveEast! !


!classDefinition: #North category: 'MarsRover-Exercise'!
Direction subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!North methodsFor: 'rotation' stamp: 'AEC 5/16/2022 12:21:10'!
rotateLeft

	^West new! !

!North methodsFor: 'rotation' stamp: 'AEC 5/16/2022 12:34:06'!
rotateRight

	^East new! !


!North methodsFor: 'movement' stamp: 'AEC 5/16/2022 13:13:02'!
moveBackwards: aMarsRover

	^aMarsRover moveSouth! !

!North methodsFor: 'movement' stamp: 'AEC 5/16/2022 12:51:17'!
moveForward: aMarsRover

	^aMarsRover moveNorth! !


!classDefinition: #South category: 'MarsRover-Exercise'!
Direction subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!South methodsFor: 'rotation' stamp: 'AEC 5/16/2022 12:21:19'!
rotateLeft

	^East new! !

!South methodsFor: 'rotation' stamp: 'AEC 5/16/2022 12:33:46'!
rotateRight

	^West new! !


!South methodsFor: 'movement' stamp: 'AEC 5/16/2022 13:13:12'!
moveBackwards: aMarsRover

	^aMarsRover moveNorth! !

!South methodsFor: 'movement' stamp: 'AEC 5/16/2022 12:51:36'!
moveForward: aMarsRover

	^aMarsRover moveSouth! !


!classDefinition: #West category: 'MarsRover-Exercise'!
Direction subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!West methodsFor: 'rotation' stamp: 'AEC 5/16/2022 12:21:26'!
rotateLeft

	^South new! !

!West methodsFor: 'rotation' stamp: 'AEC 5/16/2022 12:37:28'!
rotateRight

	^North new! !


!West methodsFor: 'movement' stamp: 'AEC 5/16/2022 13:13:19'!
moveBackwards: aMarsRover

	^aMarsRover moveEast! !

!West methodsFor: 'movement' stamp: 'AEC 5/16/2022 12:51:29'!
moveForward: aMarsRover

	^aMarsRover moveWest! !


!classDefinition: #MarsRover category: 'MarsRover-Exercise'!
Object subclass: #MarsRover
	instanceVariableNames: 'heading symbol position'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRover methodsFor: 'command-process' stamp: 'AEC 5/16/2022 13:29:18'!
process: aCommandsString
	
	aCommandsString do: [:command | self processCommand: command ]! !

!MarsRover methodsFor: 'command-process' stamp: 'AEC 5/16/2022 13:29:50'!
processCommand: aCommandCharacter

	aCommandCharacter = $l ifTrue:[ ^self rotateLeft ].
	aCommandCharacter = $r ifTrue:[ ^self rotateRight ].
	aCommandCharacter = $f ifTrue:[ ^self moveForward ].
	aCommandCharacter = $b ifTrue:[ ^self moveBackwards ].
	
	self error: self class invalidCommandErrorDescription! !


!MarsRover methodsFor: 'accesing' stamp: 'AEC 5/16/2022 12:22:24'!
isHeadingEast
	
	^ heading is: #East! !

!MarsRover methodsFor: 'accesing' stamp: 'AEC 5/16/2022 12:22:33'!
isHeadingNorth
	
	^heading is: #North! !

!MarsRover methodsFor: 'accesing' stamp: 'AEC 5/16/2022 12:22:39'!
isHeadingSouth
	
	^ heading is: #South! !

!MarsRover methodsFor: 'accesing' stamp: 'AEC 5/16/2022 12:22:46'!
isHeadingWest
	
	^heading is: #West! !


!MarsRover methodsFor: 'initialization' stamp: 'AEC 5/16/2022 12:40:33'!
initializeHeading: aDirection at: aPosition
	
	heading := aDirection.
	position := aPosition! !


!MarsRover methodsFor: 'rotation' stamp: 'AEC 5/16/2022 12:22:10'!
rotateLeft

	^ heading := heading rotateLeft! !

!MarsRover methodsFor: 'rotation' stamp: 'AEC 5/16/2022 12:44:47'!
rotateRight

	^ heading := heading rotateRight! !


!MarsRover methodsFor: 'testing' stamp: 'AEC 5/16/2022 12:39:44'!
position
	
	^position! !


!MarsRover methodsFor: 'movement' stamp: 'AEC 5/16/2022 13:37:23'!
moveBackwards

	heading moveBackwards: self! !

!MarsRover methodsFor: 'movement' stamp: 'AEC 5/16/2022 12:52:12'!
moveEast

	position := position + (1@0)! !

!MarsRover methodsFor: 'movement' stamp: 'AEC 5/16/2022 12:53:21'!
moveForward
	
	heading moveForward: self! !

!MarsRover methodsFor: 'movement' stamp: 'AEC 5/16/2022 12:52:57'!
moveNorth

	position := position + (0@1)! !

!MarsRover methodsFor: 'movement' stamp: 'AEC 5/16/2022 12:52:50'!
moveSouth

	position := position - (0@1)! !

!MarsRover methodsFor: 'movement' stamp: 'AEC 5/16/2022 12:52:32'!
moveWest

	position := position - (1@0)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-Exercise'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'AEC 5/16/2022 12:41:09'!
heading: aDirection
	
	^self heading: aDirection at: 0@0! !

!MarsRover class methodsFor: 'instance creation' stamp: 'AEC 5/16/2022 12:41:03'!
heading: aDirection at: aPosition
	
	^self new initializeHeading: aDirection at: aPosition! !


!MarsRover class methodsFor: 'error descriptions' stamp: 'AEC 5/16/2022 13:26:57'!
invalidCommandErrorDescription

	^'Comando invalido, no se procesaran los comandos restantes.'! !
