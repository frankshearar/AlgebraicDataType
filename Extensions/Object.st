
!Object methodsFor: '*AlgebraicDataType' stamp: 'fbs 5/25/2011 22:34'!
isAlgebraic
	^ false.! !

!Object methodsFor: '*AlgebraicDataType' stamp: 'fbs 7/23/2011 10:56'!
unapply
	^ self.! !

!Object methodsFor: '*AlgebraicDataType' stamp: 'fbs 7/23/2011 10:56'!
unapplyFully
	^ self.! !
ct
	^ Unifier unify: self with: anObject.! !
