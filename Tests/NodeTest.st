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

!NodeTest methodsFor: 'testing' stamp: 'fbs 5/25/2011 07:41'!
testNodeHasTwoParameters
	self assert: ((Node left: Tree empty) paramAt: 1) = Tree empty.
	"Sneaky!! Even a short/helper constructor fully instantiates a Node!!"
	self assert: ((Node left: Tree empty) paramAt: 2) = Tree empty.! !

!NodeTest methodsFor: 'testing' stamp: 'fbs 5/25/2011 22:32'!
testNodeIsNotVariable
	self deny: (Node left: Tree empty right: Tree empty) isMetaVariable.! !

!NodeTest methodsFor: 'testing' stamp: 'fbs 5/22/2011 20:59'!
testUnapplyShouldDestructureLazily
	| destructure tree |
	tree := Node left: (Leaf value: 1) right: (Leaf value: 2).
	destructure := tree unapply.
	self assert: destructure first = #Node.
	self assert: destructure second = tree left.
	self assert: destructure third = tree right.! !
