TestCase subclass: #LeafTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgebraicDataType-Tests'!


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

!LeafTest methodsFor: 'testing' stamp: 'fbs 5/25/2011 22:32'!
testLeafIsNotVariable
	self deny: (Leaf value: 1) isMetaVariable.! !

!LeafTest methodsFor: 'testing' stamp: 'fbs 5/22/2011 21:15'!
testUnapplyShouldDestructure
	| destructure tree |
	tree := Leaf value: 1.
	destructure := tree unapply.
	self assert: destructure first = #Leaf.
	self assert: destructure second = tree value.! !

 := Leaf value: 1.
	destructure := tree unapply.
	self assert: destructure first = #Leaf.
	self assert: destructure second = tree value.! !


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


!LeafTest methodsFor: 'testing - accessing' stamp: 'fbs 9/12/2011 15:36'!
testHeightOfaLeafNodeIsOne
	self assert: 1 equals: (Leaf value: 1) height.! !

!LeafTest methodsFor: 'testing - accessing' stamp: 'fbs 9/12/2011 15:41'!
testSizeOfaLeafNodeIsOne
	self assert: 1 equals: (Leaf value: 1) size.! !
