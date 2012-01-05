Tree subclass: #Leaf
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgebraicDataType-Trees'!

!Leaf methodsFor: 'accessing' stamp: 'fbs 5/22/2011 20:20'!
value
	^ value.! !


!Leaf methodsFor: 'destructuring' stamp: 'fbs 5/22/2011 21:16'!
unapply
	^ {#Leaf. value.}! !


!Leaf methodsFor: 'private' stamp: 'fbs 5/22/2011 20:19'!
value: anObject
	value := anObject.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Leaf class
	instanceVariableNames: ''!

!Leaf class methodsFor: 'instance creation' stamp: 'fbs 5/22/2011 20:19'!
value: anObject
	^ self new value: anObject.! !

	instanceVariableNames: ''!

!Leaf class methodsFor: 'instance creation' stamp: 'fbs 7/22/2011 17:48'!
apply: aCollection
	self assertCorrectSize: aCollection.
	self assertCorrectTag: aCollection.
	^ self value: aCollection second.! !

!Leaf class methodsFor: 'instance creation' stamp: 'fbs 5/22/2011 20:19'!
value: anObject
	^ self new value: anObject.! !
