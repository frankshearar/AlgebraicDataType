TestCase subclass: #LeafTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgebraicDataType-Tests'!

!LeafTest methodsFor: 'testing - instance creation' stamp: 'fbs 7/22/2011 17:41'!
testApplyIsInverseOfUnapply
	| leaf |
	leaf := Leaf value: 1.
	self assert: leaf = (Leaf apply: leaf unapply)! !

!LeafTest methodsFor: 'testing - instance creation' stamp: 'fbs 7/22/2011 17:38'!
testEmptyListFailsToApply
	self should: [Leaf apply: {}] raise: ApplyError.! !

!LeafTest methodsFor: 'testing - instance creation' stamp: 'fbs 7/22/2011 17:38'!
testNoValueListFailsToApply
	self should: [Leaf apply: {#Leaf.}] raise: ApplyError.! !

!LeafTest methodsFor: 'testing - instance creation' stamp: 'fbs 7/22/2011 17:40'!
testProperlyFormedListApplies
	| leaf |
	leaf := Leaf apply: {#Leaf. 1}.
	
	self assert: (leaf isKindOf: Leaf).
	self assert: leaf value = 1.! !

!LeafTest methodsFor: 'testing - instance creation' stamp: 'fbs 7/22/2011 17:38'!
testTooLongListFailsToApply
	self should: [Leaf apply: {#Leaf. 1. 2.}] raise: ApplyError.! !


!LeafTest methodsFor: 'testing' stamp: 'fbs 5/22/2011 21:15'!
testEqualsTestsStructuralEquality
	| t1 t2 t3 |
	t1 := Leaf value: 1.
	t2 := Leaf value: 1.
	t3 := t1 unapply.
	self deny: t1 == t2. "Not the same object."
	self assert: t1 = t2. "But are equal objects."
	self assert: t1 = t3. "Equality means structural equality."! !

!LeafTest methodsFor: 'testing' stamp: 'fbs 5/24/2011 22:07'!
testLeafHasChildren
	self assert: (Leaf value: 1) hasChildren.
	
	self assert: (Leaf value: 1) children = #(1).! !

!LeafTest methodsFor: 'testing' stamp: 'fbs 5/22/2011 21:15'!
testUnapplyShouldDestructure
	| destructure tree |
	tree := Leaf value: 1.
	destructure := tree unapply.
	self assert: destructure first = #Leaf.
	self assert: destructure second = tree value.! !

value: 1.
	destructure := tree unapply.
	self assert: destructure first = #Leaf.
	self assert: destructure second = tree value.! !

value: 1) height.! !

!LeafTest methodsFor: 'testing - accessing' stamp: 'fbs 9/12/2011 15:41'!
testSizeOfaLeafNodeIsOne
	self assert: 1 equals: (Leaf value: 1) size.! !
