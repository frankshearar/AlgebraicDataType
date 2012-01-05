TestCase subclass: #UnificationTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgebraicDataType-Tests'!

!UnificationTest methodsFor: 'testing' stamp: 'fbs 1/4/2012 22:16'!
testCyclicStructuresCantUnify
	| y |
	y := MetaVariable named: #y.
	self should: [y unifyWith: {y}] raise: UnificationFailure.! !

!UnificationTest methodsFor: 'testing' stamp: 'fbs 5/24/2011 07:25'!
testImpossibleUnificationShouldNotUnify
	self assert: ((Leaf value: 2) unifyWith: (Leaf value: 1)) = Dictionary new.! !

!UnificationTest methodsFor: 'testing' stamp: 'fbs 5/25/2011 23:00'!
testSelfUnificationShouldUnify
	| matches |
	matches := (MetaVariable named: #x) unifyWith: (MetaVariable named: #x).
	self assert: matches = (Dictionary newFromPairs: {MetaVariable named: #x. MetaVariable named: #x}).! !

!UnificationTest methodsFor: 'testing' stamp: 'fbs 5/25/2011 23:00'!
testTrivialBidirectionalUnificationShouldUnify
	| matches |
	matches := (MetaVariable named: #x) unifyWith: (MetaVariable named: #y).
	self assert: matches = (Dictionary newFromPairs: {MetaVariable named: #x. MetaVariable named: #y}).! !

!UnificationTest methodsFor: 'testing' stamp: 'fbs 5/25/2011 22:57'!
testTrivialUnificationsShouldUnify
	| matches |
	matches := (MetaVariable named: #leaf) unifyWith: (Leaf value: 1).
	self assert: matches = (Dictionary newFromPairs: {MetaVariable named: #leaf. Leaf value: 1}).
	
	matches := (MetaVariable named: #x) unifyWith: 2.
	self assert: matches = (Dictionary newFromPairs: {MetaVariable named: #x. 2}).! !

!UnificationTest methodsFor: 'testing' stamp: 'fbs 5/25/2011 23:30'!
testTwoVariableBidirectionalUnificationShouldUnifyBoth
	| matches |
	matches := (Node left: (MetaVariable named: #left) right: (Leaf value: 2))
		unifyWith: (Node left: (Leaf value: 1) right: (MetaVariable named: #right)).
	self assert: matches = (Dictionary newFromPairs: {
		MetaVariable named: #left. Leaf value: 1.
		MetaVariable named: #right. Leaf value: 2}).! !

!UnificationTest methodsFor: 'testing' stamp: 'fbs 5/25/2011 23:30'!
testTwoVariableUnificationShouldUnifyBoth
	| matches |
	matches := (Node left: (MetaVariable named: #left) right: (MetaVariable named: #right))
		unifyWith: (Node left: (Leaf value: 1) right: (Leaf value: 2)).
	self assert: matches = (Dictionary newFromPairs: {
		MetaVariable named: #left. Leaf value: 1.
		MetaVariable named: #right. Leaf value: 2}).! !

!UnificationTest methodsFor: 'testing' stamp: 'fbs 1/5/2012 09:27'!
testUnificationWorksOnDeepStructures
	| matches x y |
	x := MetaVariable named: #x.
	y := MetaVariable named: #y.
	matches := { {{x}} } unifyWith: {y}.
	self assert: matches = (Dictionary newFrom: { y -> {{x}} }).! !

!UnificationTest methodsFor: 'testing' stamp: 'fbs 5/25/2011 23:38'!
testVariableUnifyingAgainstTwoVariables
	| matches |
	matches := (Node left: (MetaVariable named: #x) right: (MetaVariable named: #x))
		unifyWith: (Node left: (MetaVariable named: #y) right: (MetaVariable named: #z)).
	self assert: matches = (Dictionary newFromPairs: {
		MetaVariable named: #y. MetaVariable named: #z.
		MetaVariable named: #x. MetaVariable named: #z}).! !

!UnificationTest methodsFor: 'testing' stamp: 'fbs 1/4/2012 21:36'!
testVariablesInsideCollectionsUnify
	| matches |
	matches := {1. 2. #x asVariable. 4} =? #(1 2 3 4).
	self assert: matches equals: (Dictionary newFromPairs: {#x asVariable. 3.}).
	
	matches := #(1 2 3 4) =? {1. 2. #x asVariable. 4}.
	self assert: matches equals: (Dictionary newFromPairs: {#x asVariable. 3.}).! !
