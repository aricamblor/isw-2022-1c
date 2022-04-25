!classDefinition: #NumeroTest category: 'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:11'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:12'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:38'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 4/15/2021 16:45:35'!
test27EnteroSubstractsEnteroCorrectly

	self assert: four - one equals: three! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:41'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:00'!
test29EnteroSubstractsFraccionCorrectly

	self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:05'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:08'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:48'!
test32SubstractingSameEnterosReturnsZero

	self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:01'!
test33SubstractingSameFraccionesReturnsZero

	self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:14'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:23'!
test35FibonacciZeroIsOne

	self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:32'!
test36FibonacciOneIsOne

	self assert: one fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:39'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: four fibonacci equals: five.
	self assert: three fibonacci equals: three. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:47'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Entero negativeFibonacciErrorDescription ].! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:55'!
test39NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.
		! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:03'!
test40NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: 'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'AEC 4/22/2022 11:25:23'!
addAFraccion: aFraccion

	^self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'AEC 4/22/2022 11:25:14'!
addAnEntero: anEntero

	^self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'AEC 4/22/2022 11:26:19'!
divideAFraccion: aFraccion

	^self subclassResponsibility! !

!Numero methodsFor: 'arithmetic operations' stamp: 'AEC 4/22/2022 11:27:12'!
divideAnEntero: anEntero

	^self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

!Numero methodsFor: 'arithmetic operations' stamp: 'AEC 4/22/2022 11:26:35'!
multiplyAFraccion: aFraccion

	^self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'AEC 4/22/2022 11:27:05'!
multiplyAnEntero: anEntero

	^self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !

!Numero methodsFor: 'arithmetic operations' stamp: 'AEC 4/22/2022 11:25:36'!
substractFromAFraccion: aFraccion

	^self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'AEC 4/22/2022 11:27:01'!
substractFromAnEntero: anEntero

	^self subclassResponsibility ! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:02'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!!!!!'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:09'!
invalidNumberTypeErrorDescription
	
	^ 'Tipo de número inválido!!!!!!'! !


!classDefinition: #Entero category: 'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'arithmetic operations' stamp: 'fm 4/20/2022 22:43:35'!
* aMultiplier 
	
	^aMultiplier multiplyAnEntero: self.
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'AEC 4/20/2022 19:33:17'!
+ anAdder 
	
	^anAdder addAnEntero: self.
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'AEC 4/20/2022 20:09:48'!
- aSubtrahend 
	
	^ aSubtrahend substractFromAnEntero: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'AEC 4/20/2022 20:48:37'!
/ aDivisor 
	
	^ aDivisor divideAnEntero: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'AEC 4/20/2022 20:47:21'!
// aDivisor 
	
	^self class with: value // aDivisor integerValue.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'fm 4/20/2022 22:42:59'!
addAFraccion: aFraction

	| newNumerator |
	newNumerator := (self * aFraction denominator) + aFraction numerator.
	
	^newNumerator / aFraction denominator.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'AEC 4/20/2022 19:33:51'!
addAnEntero: anEntero

	^self class with: value + anEntero integerValue
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'fm 4/20/2022 22:43:08'!
divideAFraccion: aFraccion 
	
	| newDenominator |
	
	newDenominator := aFraccion denominator * self.
	
	^aFraccion numerator / newDenominator! !

!Entero methodsFor: 'arithmetic operations' stamp: 'AEC 4/20/2022 20:52:28'!
divideAnEntero: anEntero 
	
	^Fraccion with: anEntero over: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'fm 4/20/2022 22:06:29'!
fibonacci

	^ self subclassResponsibility ! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:00'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'fm 4/20/2022 22:43:22'!
multiplyAFraccion: aFraccion
	
	| newNumerator |
	
	newNumerator := self * aFraccion numerator.
	
	^newNumerator / aFraccion denominator.
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'fm 4/20/2022 22:43:35'!
multiplyAnEntero: anEntero
	
	^self class with: value * anEntero integerValue
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'AEC 4/20/2022 20:02:01'!
substractFromAFraccion: aFraccion
	
	| newNumerator |
	
	newNumerator := aFraccion numerator - (aFraccion denominator * self).
	
	^newNumerator / aFraccion denominator
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'AEC 4/20/2022 20:13:04'!
substractFromAnEntero: anEntero 
	
	^ self class with: anEntero integerValue - value.! !


!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 21:01'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:17'!
hash

	^value hash! !


!Entero methodsFor: 'fraccion instance creation' stamp: 'AEC 4/21/2022 21:08:29'!
asDividendOver: aDivisor

	^ self subclassResponsibility ! !

!Entero methodsFor: 'fraccion instance creation' stamp: 'AEC 4/21/2022 21:14:32'!
asDivisorUnder: aDividend

	^ self subclassResponsibility ! !

!Entero methodsFor: 'fraccion instance creation' stamp: 'AEC 4/21/2022 21:38:42'!
asValidDenominatorOf: aNumerator

	^ self subclassResponsibility ! !


!Entero methodsFor: 'initialization' stamp: 'fm 4/20/2022 22:34:02'!
initializeWith: aValue 
	
	value := aValue! !


!Entero methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:53:19'!
printOn: aStream

	aStream print: value ! !


!Entero methodsFor: 'testing' stamp: 'fm 4/20/2022 22:09:51'!
isNegative

	self subclassResponsibility ! !

!Entero methodsFor: 'testing' stamp: 'fm 4/20/2022 22:09:55'!
isOne

	self subclassResponsibility ! !

!Entero methodsFor: 'testing' stamp: 'fm 4/20/2022 22:09:59'!
isZero

	self subclassResponsibility ! !


!Entero methodsFor: 'value' stamp: 'HernanWilkinson 5/7/2016 21:02'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'AEC 4/21/2022 21:44:48'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	"Se crean las instancias de los distintos tipos de enteros en el padre para no abrir la puerta a crear las instancias desde las clases mismas y complejizar fuertemente el modelo. - Alumnos"
	
	aValue < 0 ifTrue: [^EnteroNegativo new initializeWith: aValue].
	aValue = 0 ifTrue: [^Cero new initializeWith: aValue].
	aValue = 1 ifTrue: [^Uno new initializeWith: aValue].
	aValue > 1 ifTrue: [^EnteroPositivo new initializeWith: aValue].! !


!Entero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:24'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos!!!!!!'! !


!classDefinition: #Cero category: 'Numero-Exercise'!
Entero subclass: #Cero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Cero methodsFor: 'arithmetic operations' stamp: 'fm 4/20/2022 22:22:54'!
fibonacci

	^Entero with: 1! !


!Cero methodsFor: 'fraccion instance creation' stamp: 'AEC 4/21/2022 21:09:14'!
asDividendOver: aDivisor
	
	^self! !

!Cero methodsFor: 'fraccion instance creation' stamp: 'AEC 4/21/2022 21:15:22'!
asDivisorUnder: aDividend
	
	^self error: Fraccion canNotDivideByZeroErrorDescription.! !

!Cero methodsFor: 'fraccion instance creation' stamp: 'AEC 4/21/2022 21:39:10'!
asValidDenominatorOf: aNumerator

	^ self shouldNotHappenBecause: 'Cero no es un denominador valido para una fracción'! !


!Cero methodsFor: 'testing' stamp: 'fm 4/20/2022 22:31:07'!
isNegative

	^false! !

!Cero methodsFor: 'testing' stamp: 'fm 4/20/2022 22:31:14'!
isOne

	^false! !

!Cero methodsFor: 'testing' stamp: 'fm 4/20/2022 22:31:21'!
isZero

	^true! !


!classDefinition: #EnteroNegativo category: 'Numero-Exercise'!
Entero subclass: #EnteroNegativo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroNegativo methodsFor: 'arithmetic operations' stamp: 'fm 4/20/2022 22:26:06'!
fibonacci

	^self error: Entero negativeFibonacciErrorDescription! !


!EnteroNegativo methodsFor: 'fraccion instance creation' stamp: 'AEC 4/21/2022 21:10:21'!
asDividendOver: aDivisor

	^ Fraccion withNonZeroDividend: self over: aDivisor! !

!EnteroNegativo methodsFor: 'fraccion instance creation' stamp: 'AEC 4/21/2022 21:16:19'!
asDivisorUnder: aDividend

	^ aDividend negated / self negated.! !

!EnteroNegativo methodsFor: 'fraccion instance creation' stamp: 'AEC 4/21/2022 21:39:43'!
asValidDenominatorOf: aNumerator

	^ self shouldNotHappenBecause: 'Un número negativo no es un denominador valido para una fracción'! !


!EnteroNegativo methodsFor: 'testing' stamp: 'fm 4/20/2022 22:31:33'!
isNegative

	^true! !

!EnteroNegativo methodsFor: 'testing' stamp: 'fm 4/20/2022 22:31:42'!
isOne

	^false! !

!EnteroNegativo methodsFor: 'testing' stamp: 'fm 4/20/2022 22:31:44'!
isZero

	^false! !


!classDefinition: #EnteroPositivo category: 'Numero-Exercise'!
Entero subclass: #EnteroPositivo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroPositivo methodsFor: 'arithmetic operations' stamp: 'fm 4/20/2022 22:35:13'!
fibonacci

	| one two|
	
	one := Entero with: 1.
	two := Entero with: 2.
	
	^(self - one) fibonacci + (self - two) fibonacci! !


!EnteroPositivo methodsFor: 'fraccion instance creation' stamp: 'AEC 4/21/2022 21:10:38'!
asDividendOver: aDivisor

	^ Fraccion withNonZeroDividend: self over: aDivisor! !

!EnteroPositivo methodsFor: 'fraccion instance creation' stamp: 'AEC 4/21/2022 21:18:21'!
asDivisorUnder: aDividend

	^ Fraccion withNonZeroDividend: aDividend overPositiveDivisor: self.! !

!EnteroPositivo methodsFor: 'fraccion instance creation' stamp: 'AEC 4/21/2022 21:38:42'!
asValidDenominatorOf: aNumerator

	^ Fraccion withValidDividend: aNumerator overValidDivisor: self! !


!EnteroPositivo methodsFor: 'testing' stamp: 'fm 4/20/2022 22:31:55'!
isNegative

	^false! !

!EnteroPositivo methodsFor: 'testing' stamp: 'fm 4/20/2022 22:32:01'!
isOne

	^false! !

!EnteroPositivo methodsFor: 'testing' stamp: 'fm 4/20/2022 22:32:05'!
isZero

	^false! !


!classDefinition: #Uno category: 'Numero-Exercise'!
Entero subclass: #Uno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Uno methodsFor: 'arithmetic operations' stamp: 'fm 4/20/2022 22:23:37'!
fibonacci

	^Entero with: 1! !


!Uno methodsFor: 'fraccion instance creation' stamp: 'AEC 4/21/2022 21:10:48'!
asDividendOver: aDivisor

	^ Fraccion withNonZeroDividend: self over: aDivisor! !

!Uno methodsFor: 'fraccion instance creation' stamp: 'AEC 4/21/2022 21:18:40'!
asDivisorUnder: aDividend

	^ Fraccion withNonZeroDividend: aDividend overPositiveDivisor: self.! !

!Uno methodsFor: 'fraccion instance creation' stamp: 'AEC 4/21/2022 21:38:42'!
asValidDenominatorOf: aNumerator

	^ aNumerator! !


!Uno methodsFor: 'testing' stamp: 'fm 4/20/2022 22:32:14'!
isNegative

	^false! !

!Uno methodsFor: 'testing' stamp: 'fm 4/20/2022 22:32:24'!
isOne

	^true! !

!Uno methodsFor: 'testing' stamp: 'fm 4/20/2022 22:32:19'!
isZero

	^false! !


!classDefinition: #Fraccion category: 'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'fm 4/20/2022 22:43:22'!
* aMultiplier 
	
	^aMultiplier multiplyAFraccion: self.
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'fm 4/20/2022 22:42:59'!
+ anAdder 
	
	^anAdder addAFraccion: self.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'AEC 4/20/2022 20:08:28'!
- aSubtrahend 
	
	^aSubtrahend substractFromAFraccion: self.
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'fm 4/20/2022 22:43:08'!
/ aDivisor 
	
	^aDivisor divideAFraccion: self.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'fm 4/20/2022 22:42:59'!
addAFraccion: aFraccion
	
	| newNumerator newDenominator |
	
	newNumerator := (numerator * aFraccion denominator) + (denominator * aFraccion numerator).
	newDenominator := denominator * aFraccion denominator.
	
	^newNumerator / newDenominator ! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'AEC 4/20/2022 19:53:12'!
addAnEntero: anEntero

	| newNumerator |
	newNumerator := self numerator + (self denominator * anEntero).
	
	^newNumerator / denominator.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'fm 4/20/2022 22:43:08'!
divideAFraccion: aFraccion 
	
	^(aFraccion numerator * denominator) / (aFraccion denominator * numerator)! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'AEC 4/20/2022 20:39:12'!
divideAnEntero: anEntero 
	
	| newDenominator newNumerator |
	
	newNumerator := self denominator * anEntero.
	newDenominator := self numerator.
	
	^ newNumerator / newDenominator! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'fm 4/20/2022 22:43:22'!
multiplyAFraccion: aFraccion
	
	^(numerator * aFraccion numerator) / (denominator * aFraccion denominator)
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'fm 4/20/2022 22:43:35'!
multiplyAnEntero: anEntero
	
	| newNumerator |
	
	newNumerator := self numerator * anEntero.
	
	^newNumerator / denominator.
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'AEC 4/20/2022 20:00:46'!
substractFromAFraccion: aFraccion
	
	| newNumerator newDenominator |
	
	newNumerator := (aFraccion numerator * denominator) - (aFraccion denominator * numerator).
	newDenominator := denominator * aFraccion denominator.
	
	^newNumerator / newDenominator 
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'AEC 4/20/2022 20:03:56'!
substractFromAnEntero: anEntero
	
	| newNumerator |
	
	newNumerator := (anEntero * denominator) - numerator.
	
	^newNumerator / denominator! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 22:54'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'instance creation' stamp: 'AEC 4/21/2022 21:12:38'!
with: aDividend over: aDivisor

	^aDividend asDividendOver: aDivisor.
	
	! !

!Fraccion class methodsFor: 'instance creation' stamp: 'AEC 4/21/2022 21:19:33'!
withNonZeroDividend: aDividend over: aDivisor
		
	^aDivisor asDivisorUnder: aDividend.
	
	! !

!Fraccion class methodsFor: 'instance creation' stamp: 'AEC 4/21/2022 21:38:42'!
withNonZeroDividend: aDividend overPositiveDivisor: aDivisor
	
	| denominator greatestCommonDivisor numerator |
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	^denominator asValidDenominatorOf: numerator.
	
	! !

!Fraccion class methodsFor: 'instance creation' stamp: 'AEC 4/21/2022 21:34:41'!
withValidDividend: aDividend overValidDivisor: aDivisor
	
	^self new initializeWith: aDividend over: aDivisor
	
	! !
