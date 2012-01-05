TestCase subclass: #EmptyTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgebraicDataType-Tests'!


!EmptyTest methodsFor: 'testing' stamp: 'fbs 5/25/2011 07:38'!
testEmptyTreeHasNoChildren
	self deny: Empty new hasChildren.
	self deny: Tree empty hasChildren.
	
	self assert: Tree empty children isEmpty.! !

!EmptyTest methodsFor: 'testing' stamp: 'fbs 5/25/2011 07:38'!
testEmptyTreeHasNoParameters
	self should: [Tree empty paramAt: 1] raise: Error.! !

!EmptyTest methodsFor: 'testing' stamp: 'fbs 5/25/2011 22:33'!
testEmptyTreeIsNotVariable
	self deny: Empty new isMetaVariable.
	self deny: Tree empty isMetaVariable.! !

!EmptyTest methodsFor: 'testing' stamp: 'fbs 5/22/2011 21:09'!
testEqualsTestsStructuralEquality
	| t1 t2 t3 |
	t1 := Empty new.
	t2 := Empty new.
	t3 := t1 unapply.
	self deny: t1 == t2. "Not the same object."
	self assert: t1 = t2. "But are equal objects."
	self assert: t1 = t3. "Equality means structural equality."! !

!EmptyTest methodsFor: 'testing' stamp: 'fbs 5/22/2011 21:27'!
testUnapplyShouldDestructure
	self assert: Tree empty unapply = {#Empty}.! !

sChildren.
	self deny: Tree empty hasChildren.
	
	self assert: Tree empty children isEmpty.! !

!EmptyTest methodsFor: 'testing' stamp: 'fbs 5/22/2011 21:09'!
testEqualsTestsStructuralEquality
	| t1 t2 t3 |
	t1 := Empty new.
	t2 := Empty new.
	t3 := t1 unapply.
	self deny: t1 == t2. "Not the same object."
	self assert: t1 = t2. "But are equal objects."
	self assert: t1 = t3. "Equality means structural equality."! !

!EmptyTest methodsFor: 'testing' stamp: 'fbs 5/22/2011 21:27'!
testUnapplyShouldDestructure
	self assert: Tree empty unapply = {#Empty}.! !


!EmptyTest methodsFor: 'testing - accessing' stamp: 'fbs 9/12/2011 15:36'!
testHeightOfAnEmptyTreeIsZero
	self assert: 0 equals: Tree empty height.! !

!EmptyTest methodsFor: 'testing - accessing' stamp: 'fbs 9/12/2011 15:41'!
testSizeOfAnEmptyTreeIsZero
	self assert: 0 equals: Tree empty size.! !
