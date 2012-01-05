Object subclass: #UnificationDecoration
	instanceVariableNames: 'classPointer classSize schemaTerm visited acyclic vars node'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgebraicDataType'!
!UnificationDecoration commentStamp: 'fbs 5/25/2011 21:01' prior: 0!
I decorate the nodes undergoing unification. Unifier associates a node with a UnificationDecoration to allow the unification state to remain separate from the immutable nodes.

node points to the thing that I decorate.!


!UnificationDecoration methodsFor: 'accessing' stamp: 'fbs 5/25/2011 17:59'!
acyclic
	^ acyclic.! !

!UnificationDecoration methodsFor: 'accessing' stamp: 'fbs 5/25/2011 17:59'!
acyclic: aBoolean
	acyclic := aBoolean.! !

!UnificationDecoration methodsFor: 'accessing' stamp: 'fbs 5/25/2011 17:58'!
classPointer
	^ classPointer.! !

!UnificationDecoration methodsFor: 'accessing' stamp: 'fbs 5/25/2011 17:58'!
classPointer: aDecorator
	classPointer := aDecorator.! !

!UnificationDecoration methodsFor: 'accessing' stamp: 'fbs 5/25/2011 17:58'!
classSize
	^ classSize.! !

!UnificationDecoration methodsFor: 'accessing' stamp: 'fbs 5/25/2011 17:58'!
classSize: anInteger
	classSize := anInteger.! !

!UnificationDecoration methodsFor: 'accessing' stamp: 'fbs 5/25/2011 20:07'!
node
	^ node.! !

!UnificationDecoration methodsFor: 'accessing' stamp: 'fbs 5/25/2011 20:07'!
node: anObject
	node := anObject.! !

!UnificationDecoration methodsFor: 'accessing' stamp: 'fbs 5/25/2011 17:58'!
schemaTerm
	^ schemaTerm.! !

!UnificationDecoration methodsFor: 'accessing' stamp: 'fbs 5/25/2011 17:59'!
schemaTerm: aDecorator
	schemaTerm := aDecorator.! !

!UnificationDecoration methodsFor: 'accessing' stamp: 'fbs 5/25/2011 19:47'!
vars
	^ vars! !

!UnificationDecoration methodsFor: 'accessing' stamp: 'fbs 5/25/2011 21:19'!
vars: aCollection
	vars := aCollection.! !

!UnificationDecoration methodsFor: 'accessing' stamp: 'fbs 5/25/2011 17:59'!
visited
	^ visited.! !

!UnificationDecoration methodsFor: 'accessing' stamp: 'fbs 5/25/2011 17:59'!
visited: aBoolean
	visited := aBoolean.! !


!UnificationDecoration methodsFor: 'initialize-release' stamp: 'fbs 5/25/2011 22:31'!
decorate: aNode
	self node: aNode.
	vars := aNode isMetaVariable
		ifTrue: [aNode asOrderedCollection]
		ifFalse: [OrderedCollection new].
	
	acyclic := false.
	classPointer := self. "All nodes start as the sole element in an equivalence class; this makes each node a representative of its class."
	schemaTerm := self.
	classSize := 1.
	visited := false.! !


!UnificationDecoration methodsFor: 'unification' stamp: 'fbs 5/25/2011 20:44'!
findRepresentative
	"Walk up the tree representing this equivalence class to find the representative. As a side effect, compress the path to the representative."
	| result |
	(self classPointer = self) ifTrue: [^ self].
	
	result := self classPointer findRepresentative.
	self classPointer: result.
	^ result.! !

!UnificationDecoration methodsFor: 'unification' stamp: 'fbs 5/26/2011 22:30'!
union: aDecorator
	"Given myself, a representative, and aDecorator, another representative, merge the two equivalence classes by folding the smaller into the larger."
	| s t |
	(self classSize >= aDecorator classSize)
		ifTrue: [s := self. t := aDecorator]
		ifFalse: [t := self. s := aDecorator].
	
	s classSize: s classSize + t classSize.
	s vars: s vars, t vars.
	s schemaTerm node isMetaVariable ifTrue: [s schemaTerm: t schemaTerm].
	t classPointer: s.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

UnificationDecoration class
	instanceVariableNames: ''!

!UnificationDecoration class methodsFor: 'instance creation' stamp: 'fbs 5/25/2011 21:16'!
decorate: anObject
	^ self new decorate: anObject.! !
.! !
