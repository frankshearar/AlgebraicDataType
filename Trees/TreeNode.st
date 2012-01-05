AlgebraicDataType subclass: #TreeNode
	instanceVariableNames: 'left right'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgebraicDataType-Trees'!

!TreeNode methodsFor: 'accessing' stamp: 'fbs 5/22/2011 20:22'!
left
	^ left.! !

!TreeNode methodsFor: 'accessing' stamp: 'fbs 5/22/2011 20:22'!
right
	^ right.! !


!TreeNode methodsFor: 'private' stamp: 'fbs 5/22/2011 20:22'!
left: aLeftObject right: aRightObject
	left := aLeftObject.
	right := aRightObject.! !


!TreeNode methodsFor: 'destructuring' stamp: 'fbs 8/3/2011 07:51'!
unapply
	^ {#TreeNode. left. right.}! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

TreeNode class
	instanceVariableNames: ''!

!TreeNode class methodsFor: 'instance creation' stamp: 'fbs 7/22/2011 17:56'!
apply: aCollection
	self assertCorrectSize: aCollection.
	self assertCorrectTag: aCollection.
	^ self left: (Tree apply: aCollection second) right: (Tree apply: aCollection third).! !

!TreeNode class methodsFor: 'instance creation' stamp: 'fbs 5/22/2011 20:21'!
left: aLeftObject 
	^ self left: aLeftObject right: Tree empty.! !

!TreeNode class methodsFor: 'instance creation' stamp: 'fbs 5/22/2011 20:21'!
left: aLeftObject right: aRightObject
	^ self new left: aLeftObject right: aRightObject.! !

!TreeNode class methodsFor: 'instance creation' stamp: 'fbs 5/22/2011 20:21'!
right: aRightObject
	^ self left: Tree empty right: aRightObject.! !
ht: aRightObject
	^ self new left: aLeftObject right: aRightObject.! !

!TreeNode class methodsFor: 'instance creation' stamp: 'fbs 5/22/2011 20:21'!
right: aRightObject
	^ self left: Tree empty right: aRightObject.! !
