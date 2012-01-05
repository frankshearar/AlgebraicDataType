Tree subclass: #Empty
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgebraicDataType-Trees'!

!Empty methodsFor: 'accessing' stamp: 'fbs 9/12/2011 15:32'!
height
	^ 0.! !

!Empty methodsFor: 'accessing' stamp: 'fbs 9/12/2011 15:31'!
size
	^ 0.! !


!Empty methodsFor: 'destructuring' stamp: 'fbs 5/22/2011 21:05'!
unapply
	^ #(#Empty).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Empty class
	instanceVariableNames: ''!

!Empty class methodsFor: 'instance creation' stamp: 'fbs 7/22/2011 17:48'!
apply: aCollection
	self assertCorrectSize: aCollection.
	self assertCorrectTag: aCollection.
	^ self new.! !
