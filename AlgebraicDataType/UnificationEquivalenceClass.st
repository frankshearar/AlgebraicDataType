Object subclass: #UnificationEquivalenceClass
	instanceVariableNames: 'classPointer classSize schemaTerm visited acyclic vars node'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgebraicDataType'!
!UnificationEquivalenceClass commentStamp: 'fbs 5/28/2011 15:45' prior: 0!
I decorate the nodes undergoing unification. Unifier associates a node with a UnificationDecoration to allow the unification state to remain separate from the immutable nodes.

* classPointer points to my equivalence class; if classPointer = self then I am the representative for my class.
* classSize is an optimisation: when we merge two equivalence classes, we merge the smaller class with the larger class.
* node points to the thing that I decorate.!


!UnificationEquivalenceClass methodsFor: 'accessing' stamp: 'fbs 5/28/2011 15:46'!
classPointer: anEquivClass
	classPointer := anEquivClass.! !

!UnificationEquivalenceClass methodsFor: 'accessing' stamp: 'fbs 5/25/2011 17:58'!
classSize
	^ classSize.! !

!UnificationEquivalenceClass methodsFor: 'accessing' stamp: 'fbs 5/25/2011 20:07'!
node
	^ node.! !

!UnificationEquivalenceClass methodsFor: 'accessing' stamp: 'fbs 5/25/2011 20:07'!
node: anObject
	node := anObject.! !

!UnificationEquivalenceClass methodsFor: 'accessing' stamp: 'fbs 5/25/2011 17:58'!
schemaTerm
	^ schemaTerm.! !

!UnificationEquivalenceClass methodsFor: 'accessing' stamp: 'fbs 5/25/2011 19:47'!
vars
	^ vars! !


!UnificationEquivalenceClass methodsFor: 'initialize-release' stamp: 'fbs 5/25/2011 22:31'!
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


!UnificationEquivalenceClass methodsFor: 'unification' stamp: 'fbs 5/29/2011 13:44'!
findRepresentative
	"Walk up the tree representing this equivalence class to find the representative. As a side effect, compress the path to the representative."
	| result |
	self isRepresentative ifTrue: [^ self].
	
	result := classPointer findRepresentative.
	classPointer := result.
	^ result.! !

!UnificationEquivalenceClass methodsFor: 'unification' stamp: 'fbs 5/29/2011 13:39'!
findSolutionWithUnifier: aDictionary in: termRelation
	^ (self isSchemaTerm)
		ifTrue: [self privFindSolutionWithUnifier: aDictionary in: termRelation]
		ifFalse: [self findRepresentative schemaTerm findSolutionWithUnifier: aDictionary in: termRelation]! !

!UnificationEquivalenceClass methodsFor: 'unification' stamp: 'fbs 5/29/2011 13:36'!
privFindSolutionWithUnifier: aDictionary in: termRelation
	"Assume that we are the schema term for our equivalence class."
	| newUnifier |
	acyclic ifTrue: [^aDictionary "s is not part of a cycle."].
	
	visited ifTrue: [UnificationFailure signal. "Cycle detected."].

	newUnifier := aDictionary copy.	
	(node isAlgebraic and: [node hasChildren]) ifTrue:
		[visited := true.
		node children do:
			[:each | newUnifier addAll: ((termRelation classFor: each) findSolutionWithUnifier: newUnifier in: termRelation)].
		visited := false].
	
	acyclic := true.
	self findRepresentative vars do:
		[:x | (x ~= node) ifTrue: [newUnifier at: x put: node]].
	
	^ newUnifier.! !

!UnificationEquivalenceClass methodsFor: 'unification' stamp: 'fbs 5/29/2011 13:46'!
unificationClosureWith: rightEquivClass in: termRelation
	| left right sTerm t tTerm |
	t := rightEquivClass findRepresentative.
	self isRepresentative ifFalse: [^ self findRepresentative unificationClosureWith: t in: termRelation].

	(self = t) ifTrue: [^ self."do nothing"].
		
	sTerm := schemaTerm.
	tTerm := t schemaTerm.
	left := sTerm node.
	right := tTerm node.
	
	(left isMetaVariable or: [right isMetaVariable])
		ifTrue: [^ self union: t].

	"s, t are both terms."
	(left isAlgebraic and: [right isAlgebraic])
		ifTrue:
			["s = f(s1, ..., sn), t = g(t1, ..., tn) where m, n > 0"
			(left type = right type) ifFalse: [UnificationFailure signal. "f ~= g"].
			(left arity = right arity) ifFalse: [UnificationFailure signal].
			sTerm union: tTerm.
			left children with: right children do:
				[:si :ti | (termRelation classFor: si) unificationClosureWith: (termRelation classFor: ti) in: termRelation]]
		ifFalse:
			["At least one of s, t are not AlgebraicDataTypes, but some other kind of value."
			(left = right)
				ifTrue: [sTerm union: tTerm]
				ifFalse: ["s ~= t" UnificationFailure signal]].! !

!UnificationEquivalenceClass methodsFor: 'unification' stamp: 'fbs 5/29/2011 13:45'!
union: anEquivClass
	"Given myself, a representative, and aDecorator, another representative, merge the two equivalence classes by folding the smaller into the larger."
	(self classSize >= anEquivClass classSize)
		ifFalse: [^ anEquivClass union: self].
	
	classSize := classSize + anEquivClass classSize.
	vars addAll: anEquivClass vars.
	schemaTerm node isMetaVariable ifTrue: [schemaTerm := anEquivClass schemaTerm].
	anEquivClass classPointer: self.! !


!UnificationEquivalenceClass methodsFor: 'testing' stamp: 'fbs 5/29/2011 13:44'!
isRepresentative
	^ classPointer = self! !

!UnificationEquivalenceClass methodsFor: 'testing' stamp: 'fbs 5/29/2011 13:39'!
isSchemaTerm
	^ self = self findRepresentative schemaTerm.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

UnificationEquivalenceClass class
	instanceVariableNames: ''!

!UnificationEquivalenceClass class methodsFor: 'instance creation' stamp: 'fbs 5/25/2011 21:16'!
decorate: anObject
	^ self new decorate: anObject.! !
onEquivalenceClass class methodsFor: 'instance creation' stamp: 'fbs 5/25/2011 21:16'!
decorate: anObject
	^ self new decorate: anObject.! !
