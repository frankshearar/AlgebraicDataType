TestCase subclass: #TreeNodeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgebraicDataType-Tests'!

!TreeNodeTest methodsFor: 'testing - instance creation' stamp: 'fbs 8/3/2011 07:48'!
testApplyIsInverseOfUnapply
	| node |
	node := TreeNode left: (Leaf value: 1) right: (Leaf value: 2).
	self assert: node = (TreeNode apply: node unapplyFully).! !

!TreeNodeTest methodsFor: 'testing - instance creation' stamp: 'fbs 8/3/2011 07:48'!
testEmptyListFailsToApply
	self should: [TreeNode apply: {}] raise: ApplyError.! !

!TreeNodeTest methodsFor: 'testing - instance creation' stamp: 'fbs 8/3/2011 07:48'!
testProperListApplies
	| node |
	node := TreeNode apply: {#TreeNode. {#Empty}. {#Leaf. 1.}}.
	self assert: (node isKindOf: TreeNode).
	self assert: (node left isKindOf: Empty).
	self assert: node right value = 1.! !

!TreeNodeTest methodsFor: 'testing - instance creation' stamp: 'fbs 8/3/2011 07:49'!
testTooIncorrectlyTaggedListFailsToApply
	self should: [TreeNode apply: {#TreeNod. {#Empty}. {#Empty}}] raise: ApplyError.! !

!TreeNodeTest methodsFor: 'testing - instance creation' stamp: 'fbs 8/3/2011 07:49'!
testTooLongListFailsToApply
	self should: [TreeNode apply: {#Tree. {#Empty}. {#Empty}. {#Empty}}] raise: ApplyError.! !

!TreeNodeTest methodsFor: 'testing - instance creation' stamp: 'fbs 8/3/2011 07:49'!
testTooShortListFailsToApply
	self should: [TreeNode apply: {#Tree.}] raise: ApplyError.! !


!TreeNodeTest methodsFor: 'testing' stamp: 'fbs 8/3/2011 07:48'!
testEqualsTestsStructuralEquality
	| t1 t2 t3 |
	t1 := TreeNode left: Tree empty.
	t2 := TreeNode left: Tree empty.
	t3 := t1 unapply.
	self deny: t1 == t2. "Not the same object."
	self assert: t1 = t2. "But are equal objects."
	self assert: t1 = t3. "Equality means structural equality."! !

!TreeNodeTest methodsFor: 'testing' stamp: 'fbs 8/3/2011 07:48'!
testNodeHasChildren
	self assert: (TreeNode left: Tree empty right: Tree empty) hasChildren.
	
	self assert: (TreeNode left: (Leaf value: 1) right: (Leaf value: 2)) children = {Leaf value: 1. Leaf value: 2}.! !


!TreeNodeTest methodsFor: 'testing - unapply' stamp: 'fbs 8/3/2011 07:49'!
testUnapplyFullyShouldDestructureEagerly
	| destructure tree |
	tree := TreeNode left: (Leaf value: 1) right: (Leaf value: 2).
	destructure := tree unapplyFully.
	self assert: destructure first = #TreeNode.
	self assert: destructure second isCollection.
	self assert: destructure second first = #Leaf.
	self assert: destructure third isCollection.
	self assert: destructure third first = #Leaf.! !

!TreeNodeTest methodsFor: 'testing - unapply' stamp: 'fbs 8/3/2011 07:49'!
testUnapplyShouldDestructureLazily
	| destructure tree |
	tree := TreeNode left: (Leaf value: 1) right: (Leaf value: 2).
	destructure := tree unapply.
	self assert: destructure first = #TreeNode.
	self assert: destructure second = tree left.
	self assert: destructure third = tree right.! !
ructure := tree unapply.
	self assert: destructure first = #TreeNode.
	self assert: destructure second = tree left.
	self assert: destructure third = tree right.! !
fbs 8/3/2011 07:49'!
testUnapplyShouldDestructureLazily
	| destructure tree |
	tree := TreeNode left: (Leaf value: 1) right: (Leaf value: 2).
	destructure := tree unapply.
	self assert: destructure first = #TreeNode.
	self assert: destructure second = tree left.
	self assert: destructure third = tree right.! !
