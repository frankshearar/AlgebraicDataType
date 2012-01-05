
!Object methodsFor: '*AlgebraicDataType' stamp: 'fbs 5/25/2011 22:34'!
isAlgebraic
	^ false.! !

!Object methodsFor: '*AlgebraicDataType' stamp: 'fbs 5/25/2011 22:33'!
isMetaVariable
	^ false.! !

!Object methodsFor: '*AlgebraicDataType' stamp: 'fbs 5/26/2011 20:42'!
unifyWith: anObject
	^ Unifier unify: self with: anObject.! !
