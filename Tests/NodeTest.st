TestCase subclass: #NodeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgebraicDataType-Tests'!

!NodeTest methodsFor: 'testing' stamp: 'fbs 5/22/2011 20:58'!
testEqualsTestsStructuralEquality
	| t1 t2 t3 |
	t1 := Node left: Tree empty.
	t2 := Node left: Tree empty.
	t3 := t1 unapply.
	self deny: t1 == t2. "Not the same object."
	self assert: t1 = t2. "But are equal objects."
	self assert: t1 = t3. "Equality means structural equality."! !

!NodeTest methodsFor: 'testing' stamp: 'fbs 5/24/2011 22:08'!
testNodeHasChildren
	self assert: (Node left: Tree empty right: Tree empty) hasChildren.
	
	self assert: (Node left: (Leaf value: 1) right: (Leaf value: 2)) children = {Leaf value: 1. Leaf value: 2}.! !

!NodeTest methodsFor: 'testing' stamp: 'fbs 5/25/2011 22:32'!
testNodeIsNotVariable
	self deny: (Node left: Tree empty right: Tree empty) isMetaVariable.! !


!NodeTest methodsFor: 'testing - instance creation' stamp: 'fbs 7/23/2011 10:53'!
testApplyIsInverseOfUnapply
	| node |
	node := Node left: (Leaf value: 1) right: (Leaf value: 2).
	self assert: node = (Node apply: node unapplyFully).! !

!NodeTest methodsFor: 'testing - instance creation' stamp: 'fbs 7/22/2011 17:50'!
testEmptyListFailsToApply
	self should: [Node apply: {}] raise: ApplyError.! !

!NodeTest methodsFor: 'testing - instance creation' stamp: 'fbs 7/23/2011 10:44'!
testProperListApplies
	| node |
	node := Node apply: {#Node. {#Empty}. {#Leaf. 1.}}.
	self assert: (node isKindOf: Node).
	self assert: (node left isKindOf: Empty).
	self assert: node right value = 1.! !

!NodeTest methodsFor: 'testing - instance creation' stamp: 'fbs 7/22/2011 17:55'!
testTooIncorrectlyTaggedListFailsToApply
	self should: [Node apply: {#Nod. {#Empty}. {#Empty}}] raise: ApplyError.! !

!NodeTest methodsFor: 'testing - instance creation' stamp: 'fbs 7/22/2011 17:52'!
testTooLongListFailsToApply
	self should: [Node apply: {#Tree. {#Empty}. {#Empty}. {#Empty}}] raise: ApplyError.! !

!NodeTest methodsFor: 'testing - instance creation' stamp: 'fbs 7/22/2011 17:52'!
testTooShortListFailsToApply
	self should: [Node apply: {#Tree.}] raise: ApplyError.! !


!NodeTest methodsFor: 'testing - unapply' stamp: 'fbs 7/23/2011 10:56'!
testUnapplyFullyShouldDestructureEagerly
	| destructure tree |
	tree := Node left: (Leaf value: 1) right: (Leaf value: 2).
	destructure := tree unapplyFully.
	self assert: destructure first = #Node.
	self assert: destructure second isCollection.
	self assert: destructure second first = #Leaf.
	self assert: destructure third isCollection.
	self assert: destructure third first = #Leaf.! !

!NodeTest methodsFor: 'testing - unapply' stamp: 'fbs 5/22/2011 20:59'!
testUnapplyShouldDestructureLazily
	| destructure tree |
	tree := Node left: (Leaf value: 1) right: (Leaf value: 2).
	destructure := tree unapply.
	self assert: destructure first = #Node.
	self assert: destructure second = tree left.
	self assert: destructure third = tree right.! !
