TestCase subclass: #UnificationTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgebraicDataType-Tests'!

!UnificationTest methodsFor: 'testing' stamp: 'fbs 5/26/2011 07:24'!
testCyclicStructuresCantUnify
	| y |
	y := MetaVariable named: #y.
	self should: [y unifyWith: (Node left: y right: (Leaf value: y))] raise: UnificationFailure.! !

!UnificationTest methodsFor: 'testing' stamp: 'fbs 5/27/2011 20:28'!
testDifferentArityTermsShouldNotUnify
	"f(x) ~= g(x,y)"
	|f g |
	f := VariadicTerm with: #(#x).
	g := VariadicTerm with: #(#x #y).
	self should: [f unifyWith: g] raise: UnificationFailure.! !

!UnificationTest methodsFor: 'testing' stamp: 'fbs 5/27/2011 13:29'!
testDifferentConstantsShouldntUnify
	self should: [(Leaf value: 1) unifyWith: (Leaf value: 2)] raise: UnificationFailure.! !

!UnificationTest methodsFor: 'testing' stamp: 'fbs 5/27/2011 11:26'!
testImpossibleUnificationShouldNotUnify
	self should: [(Leaf value: 2) unifyWith: (Leaf value: 1)] raise: UnificationFailure.! !

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

!UnificationTest methodsFor: 'testing' stamp: 'fbs 5/27/2011 12:45'!
testTrivialUnificationsShouldUnify
	| matches x leaf |
	leaf := MetaVariable named: #leaf.
	matches := leaf unifyWith: (Leaf value: 1).
	self assert: matches = (Dictionary newFrom: {leaf -> (Leaf value: 1)}).
	
	x := MetaVariable named: #x.
	matches := x unifyWith: 2.
	self assert: matches = (Dictionary newFrom: {x -> 2}).
	
	matches := 1 unifyWith: 1.
	self assert: matches isEmpty.! !

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

!UnificationTest methodsFor: 'testing' stamp: 'fbs 5/27/2011 12:43'!
testVariableSelfUnificationShouldUnify
	| matches x |
	x := MetaVariable named: #x.
	matches := x unifyWith: x.
	self assert: matches = Dictionary new. "A tautology"! !

!UnificationTest methodsFor: 'testing' stamp: 'fbs 5/26/2011 08:24'!
testVariableUnifyingAgainstTwoVariables
	| matches x y z |
	x := MetaVariable named: #x.
	y := MetaVariable named: #y.
	z := MetaVariable named: #z.
	matches := (Node left: x right: x) unifyWith: (Node left: y right: z).
	self assert: matches = (Dictionary newFrom: {y -> z. x -> z}).! !
