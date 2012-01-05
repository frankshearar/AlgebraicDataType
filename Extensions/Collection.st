
!Collection methodsFor: '*AlgebraicDataType' stamp: 'fbs 7/9/2011 16:02'!
join: delimiter
	^ String streamContents: [ :stream |
		self
			do: [ :each | each putOn: stream ]
			separatedBy: [ delimiter putOn: stream ] ]! !
