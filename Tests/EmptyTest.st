TestCase subclass: #EmptyTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgebraicDataType-Tests'!

!EmptyTest methodsFor: 'testing - instance creation' stamp: 'fbs 7/22/2011 17:35'!
testApplyIsInverseOfUnapply
	| e |
	e := Empty new.
	self assert: e = (Empty apply: e unapply)! !

!EmptyTest methodsFor: 'testing - instance creation' stamp: 'fbs 7/22/2011 17:32'!
testEmptyListFailsToApply
	self should: [Empty apply: {}] raise: ApplyError.! !

!EmptyTest methodsFor: 'testing - instance creation' stamp: 'fbs 7/22/2011 17:33'!
testIncorrectlyTaggedListFailsToApply
	self should: [Empty apply: {#empty}] raise: ApplyError.! !

!EmptyTest methodsFor: 'testing - instance creation' stamp: 'fbs 7/22/2011 17:34'!
testProperlyFormedListApplies
	self assert: ((Empty apply: {#Empty}) isKindOf: Empty)! !

!EmptyTest methodsFor: 'testing - instance creation' stamp: 'fbs 7/22/2011 17:33'!
testTwoElementListFailsToApply
	self should: [Empty apply: {#Empty. 1.}] raise: ApplyError.! !


!EmptyTest methodsFor: 'testing' stamp: 'fbs 5/25/2011 07:38'!
testEmptyTreeHasNoChildren
	self deny: Empty new hasChildren.
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
