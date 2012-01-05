Object subclass: #Unifier
	instanceVariableNames: 'decorators'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgebraicDataType'!
!Unifier commentStamp: 'fbs 5/25/2011 17:36' prior: 0!
I attempt to unify two structures, that is, find mappings between the MetaVariables (if any) within the two structures such that the structures represent the same structure.

I return a Dictionary containing the most general unifier.

classes holds the equivalence classes we build up as part of our term relation. It's a Dictionary mapping nodes to parent nodes.
sigma holds our unifications in triangular form.
vars is a Dictionary mapping the representative of each equivalence class to the variables in that class.!


!Unifier methodsFor: 'evaluating' stamp: 'fbs 5/28/2011 13:41'!
unify: s with: t
	"^ self recursivelyUnify: s with: t."
	self unifClosure: (self decoratorFor: s) and: (self decoratorFor: t).
	^ self findSolution: (self decoratorFor: s) withUnifier: Dictionary new.! !


!Unifier methodsFor: 'private' stamp: 'fbs 5/28/2011 11:26'!
decoratorFor: anObject
	^ decorators
		at: anObject
		ifAbsentPut: [UnificationEquivalenceClass decorate: anObject].! !

!Unifier methodsFor: 'private' stamp: 'fbs 5/28/2011 13:48'!
findSolution: aDecorator withUnifier: aDictionary
	| newUnifier s |
	s := aDecorator findRepresentative schemaTerm.
	s acyclic ifTrue: [^aDictionary "s is not part of a cycle."].
	
	s visited ifTrue: [UnificationFailure signal. "Cycle detected."].

	newUnifier := aDictionary copy.	
	(s node isAlgebraic and: [s node hasChildren]) ifTrue:
		[s visited: true.
		s node children do:
			[:each | newUnifier addAll: (self findSolution: (self decoratorFor: each) withUnifier: newUnifier)].
		s visited: false].
	
	s acyclic: true.
	s findRepresentative vars do:
		[:x | (x ~= s node) ifTrue: [newUnifier at: x put: s node]].
	
	^ newUnifier.! !

!Unifier methodsFor: 'private' stamp: 'fbs 5/28/2011 12:23'!
unifClosure: leftDecorator and: rightDecorator
	| left right s sTerm t tTerm |
	s := leftDecorator findRepresentative.
	t := rightDecorator findRepresentative.
	(s = t) ifTrue: [^ self."do nothing"].
		
	sTerm := s schemaTerm.
	tTerm := t schemaTerm.
	left := sTerm node.
	right := tTerm node.
	
	(left isMetaVariable or: [right isMetaVariable])
		ifTrue: [^ s union: t].

	"s, t are both terms."
	(left isAlgebraic and: [right isAlgebraic])
		ifTrue:
			["s = f(s1, ..., sn), t = g(t1, ..., tn) where m, n > 0"
			(left type = right type) ifFalse: [UnificationFailure signal. "f ~= g"].
			(left arity = right arity) ifFalse: [UnificationFailure signal].
			sTerm union: tTerm.
			left children with: right children do:
				[:si :ti | self unifClosure: (self decoratorFor: si) and: (self decoratorFor: ti)]]
		ifFalse:
			["At least one of s, t are not AlgebraicDataTypes, but some other kind of value."
			(left = right)
				ifTrue: [sTerm union: tTerm]
				ifFalse: ["s ~= t" UnificationFailure signal]].! !


!Unifier methodsFor: 'initialize-release' stamp: 'fbs 5/28/2011 13:49'!
initialize
	super initialize.
	decorators := Dictionary new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Unifier class
	instanceVariableNames: ''!

!Unifier class methodsFor: 'instance creation' stamp: 'fbs 5/25/2011 07:12'!
unify: left with: right
	^ self new unify: left with: right.! !
unify: left with: right.! !
'!

!Unifier class methodsFor: 'instance creation' stamp: 'fbs 5/25/2011 07:12'!
unify: left with: right
	^ self new unify: left with: right.! !
