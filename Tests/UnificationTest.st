TestCase subclass: #UnificationTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgebraicDataType-Tests'!

!UnificationTest methodsFor: 'testing' stamp: 'fbs 5/26/2011 19:08'!
testConstantsShouldntUnify
	self should: [(Leaf value: 1) unifyWith: (Leaf value: 2)] raise: UnificationFailure.! !

!UnificationTest methodsFor: 'testing' stamp: 'fbs 5/26/2011 07:24'!
testCyclicStructuresCantUnify
	| y |
	y := MetaVariable named: #y.
	self should: [y unifyWith: (Node left: y right: (Leaf value: y))] raise: UnificationFailure.! !

!UnificationTest methodsFor: 'testing' stamp: 'fbs 5/24/2011 07:25'!
testImpossibleUnificationShouldNotUnify
	self assert: ((Leaf value: 2) unifyWith: (Leaf value: 1)) = Dictionary new.! !

!UnificationTest methodsFor: 'testing' stamp: 'fbs 5/26/2011 09:28'!
testSelfUnificationShouldUnify
	| matches x |
	x := MetaVariable named: #x.
	matches := x unifyWith: x.
	self assert: matches = Dictionary new. "A tautology"! !

!UnificationTest methodsFor: 'testing' stamp: 'fbs 5/26/2011 07:43'!
testTrivialBidirectionalUnificationShouldUnify
	| matches x y |
	x := MetaVariable named: #x.
	y := MetaVariable named: #y.
	matches := x unifyWith: y.
	self assert: matches = (Dictionary newFrom: {x -> y}).! !

!UnificationTest methodsFor: 'testing' stamp: 'fbs 5/26/2011 07:44'!
testTrivialUnificationsShouldUnify
	| matches x |
	matches := (MetaVariable named: #leaf) unifyWith: (Leaf value: 1).
	self assert: matches = (Dictionary newFromPairs: {MetaVariable named: #leaf. Leaf value: 1}).
	
	x := MetaVariable named: #x.
	matches := x unifyWith: 2.
	self assert: matches = (Dictionary newFrom: {x -> 2}).! !

!UnificationTest methodsFor: 'testing' stamp: 'fbs 5/26/2011 07:50'!
testTwoVariableBidirectionalUnificationShouldUnifyBoth
	| matches left right |
	left := MetaVariable named: #left.
	right := MetaVariable named: #right.
	matches := (Node left: left right: (Leaf value: 2))
		unifyWith: (Node left: (Leaf value: 1) right: right).
	self assert: matches = (Dictionary newFrom: {
		left -> (Leaf value: 1).
		right -> (Leaf value: 2)}).! !

!UnificationTest methodsFor: 'testing' stamp: 'fbs 5/26/2011 07:51'!
testTwoVariableUnificationShouldUnifyBoth
	| matches left right |
	left := MetaVariable named: #left.
	right := MetaVariable named: #right.
	matches := (Node left: left right: right)
		unifyWith: (Node left: (Leaf value: 1) right: (Leaf value: 2)).
	self assert: matches = (Dictionary newFrom: {
		left -> (Leaf value: 1).
		right -> (Leaf value: 2)}).! !

!UnificationTest methodsFor: 'testing' stamp: 'fbs 5/26/2011 07:52'!
testUnificationWorksOnDeepStructures
	| matches x y |
	x := MetaVariable named: #x.
	y := MetaVariable named: #y.
	matches := (Node left: (Node left: (Node left: x))) unifyWith: (Node left: y).
	self assert: matches = (Dictionary newFrom: {y -> (Node left: (Node left: x))}).! !

!UnificationTest methodsFor: 'testing' stamp: 'fbs 5/26/2011 08:24'!
testVariableUnifyingAgainstTwoVariables
	| matches x y z |
	x := MetaVariable named: #x.
	y := MetaVariable named: #y.
	z := MetaVariable named: #z.
	matches := (Node left: x right: x) unifyWith: (Node left: y right: z).
	self assert: matches = (Dictionary newFrom: {y -> z. x -> z}).! !
ctionsUnify
	| matches |
	matches := {1. 2. #x asVariable. 4} =? #(1 2 3 4).
	self assert: matches equals: (Dictionary newFromPairs: {#x asVariable. 3.}).
	
	matches := #(1 2 3 4) =? {1. 2. #x asVariable. 4}.
	self assert: matches equals: (Dictionary newFromPairs: {#x asVariable. 3.}).! !
