Tree subclass: #Node
	instanceVariableNames: 'left right'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgebraicDataType-Trees'!

!Node methodsFor: 'accessing' stamp: 'fbs 5/22/2011 20:22'!
left
	^ left.! !

!Node methodsFor: 'accessing' stamp: 'fbs 5/22/2011 20:22'!
right
	^ right.! !


!Node methodsFor: 'private' stamp: 'fbs 5/22/2011 20:22'!
left: aLeftObject right: aRightObject
	left := aLeftObject.
	right := aRightObject.! !


!Node methodsFor: 'destructuring' stamp: 'fbs 5/22/2011 20:51'!
unapply
	^ {#Node. left. right.}! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Node class
	instanceVariableNames: ''!

!Node class methodsFor: 'instance creation' stamp: 'fbs 5/22/2011 20:21'!
left: aLeftObject 
	^ self left: aLeftObject right: Tree empty.! !

!Node class methodsFor: 'instance creation' stamp: 'fbs 5/22/2011 20:21'!
left: aLeftObject right: aRightObject
	^ self new left: aLeftObject right: aRightObject.! !

!Node class methodsFor: 'instance creation' stamp: 'fbs 5/22/2011 20:21'!
right: aRightObject
	^ self left: Tree empty right: aRightObject.! !
