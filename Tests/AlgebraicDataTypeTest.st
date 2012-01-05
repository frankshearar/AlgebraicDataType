TestCase subclass: #AlgebraicDataTypeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgebraicDataType-Tests'!

!AlgebraicDataTypeTest methodsFor: 'testing - instance creation' stamp: 'fbs 7/9/2011 17:01'!
testAccessorForNonZeroAritySelectorFails
	self should: [AlgebraicDataType accessorFor: #foo:] raise: Error.
	self should: [AlgebraicDataType accessorFor: #foo:bar:] raise: Error.! !

!AlgebraicDataTypeTest methodsFor: 'testing - instance creation' stamp: 'fbs 7/9/2011 16:56'!
testAccessorForNullarySelectorReturnsMethodString
	| src |
	src := 'foo
	^ foo.'.
	self assert: (AlgebraicDataType accessorFor: #foo) = src.! !

!AlgebraicDataTypeTest methodsFor: 'testing - instance creation' stamp: 'fbs 7/9/2011 15:40'!
testConstructorForNullarySelectorFails
	self should: [AlgebraicDataType constructorFor: #foo] raise: Error.! !

!AlgebraicDataTypeTest methodsFor: 'testing - instance creation' stamp: 'fbs 7/9/2011 14:55'!
testConstructorForReturnsMethodString
	self assert: (AlgebraicDataType constructorFor: #foo:) = 'foo: foo\	^ self new foo: foo.' withCRs.
	self assert: (AlgebraicDataType constructorFor: #foo:bar:) = 'foo: foo bar: bar\	^ self new foo: foo bar: bar.' withCRs.! !

!AlgebraicDataTypeTest methodsFor: 'testing - instance creation' stamp: 'fbs 7/9/2011 15:39'!
testInitialiserForHighAritySelectorInitialisesAllInstVars
	| src |
	src := 'foo: aFoo bar: aBar baz: aBaz
	foo := aFoo.
	bar := aBar.
	baz := aBaz.'.
	self assert: (AlgebraicDataType initialiserFor: #foo:bar:baz:) = src.! !

!AlgebraicDataTypeTest methodsFor: 'testing - instance creation' stamp: 'fbs 7/9/2011 15:15'!
testInitialiserForNullarySelectorFails
	self should: [AlgebraicDataType initialiserFor: #foo] raise: Error.! !

!AlgebraicDataTypeTest methodsFor: 'testing - instance creation' stamp: 'fbs 7/9/2011 15:39'!
testInitialiserForUnarySelectorInitialisesInstVar
	| src |
	src := 'foo: aFoo
	foo := aFoo.'.
	self assert: (AlgebraicDataType initialiserFor: #foo:) = src.! !
