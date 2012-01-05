Object subclass: #Unifier
	instanceVariableNames: 'decorators schemaFunction sigma visited acyclic classes vars'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgebraicDataType'!
!Unifier commentStamp: 'fbs 5/25/2011 17:36' prior: 0!
I attempt to unify two structures, that is, find mappings between the MetaVariables (if any) within the two structures such that the structures represent the same structure.

I return a Dictionary containing the most general unifier.

classes holds the equivalence classes we build up as part of our term relation. It's a Dictionary mapping nodes to parent nodes.
sigma holds our unifications in triangular form.
vars is a Dictionary mapping the representative of each equivalence class to the variables in that class.!


!Unifier methodsFor: 'evaluating' stamp: 'fbs 5/26/2011 19:09'!
unify: s with: t
	self unifClosure: (self decoratorFor: s) and: (self decoratorFor: t).
	self findSolution: (self decoratorFor: s).
	^ Dictionary newFrom: sigma.! !


!Unifier methodsFor: 'private' stamp: 'fbs 5/26/2011 19:09'!
decoratorFor: anObject
	^ decorators at: anObject ifAbsentPut: [UnificationDecoration decorate: anObject].! !

!Unifier methodsFor: 'private' stamp: 'fbs 5/26/2011 19:10'!
findSolution: aDecorator
	| s |
	s := aDecorator findRepresentative schemaTerm.
	s acyclic ifTrue: [^self "s is not part of a cycle."].
	
	s visited ifTrue: [UnificationFailure signal. "Cycle detected."].
	
	(s node isAlgebraic and: [s node hasChildren]) ifTrue:
		[s visited: true.
		s node children do:
			[:each | self findSolution: (self decoratorFor: each)].
		s visited: false].
	
	s acyclic: true.
	s findRepresentative vars do:
		[:x | (x ~= s node) ifTrue: [sigma addFirst: (x -> s node)]].! !

!Unifier methodsFor: 'private' stamp: 'fbs 5/26/2011 19:10'!
unifClosure: leftDecorator and: rightDecorator
	| left right s sTerm t tTerm |
	s := leftDecorator findRepresentative.
	t := rightDecorator findRepresentative.
	(s = t) ifTrue: [^ self."do nothing"].
		
	sTerm := s schemaTerm.
	tTerm := t schemaTerm.
	left := sTerm node.
	right := tTerm node.
	((left isAlgebraic and: [left hasChildren]) and: [right isAlgebraic and: [right hasChildren]])
		ifTrue: [(left type = right type)
					ifTrue: [sTerm union: tTerm].
				left children with: right children do:
					[:si :ti | self unifClosure: (self decoratorFor: si) and: (self decoratorFor: ti)]]
		 ifFalse: [s union: t].! !


!Unifier methodsFor: 'initialize-release' stamp: 'fbs 5/25/2011 21:15'!
initialize
	super initialize.
	decorators := Dictionary new.
	sigma := OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Unifier class
	instanceVariableNames: ''!

!Unifier class methodsFor: 'instance creation' stamp: 'fbs 5/25/2011 07:12'!
unify: left with: right
	^ self new unify: left with: right.! !
ce creation' stamp: 'fbs 5/25/2011 07:12'!
unify: left with: right
	^ self new unify: left with: right.! !
ht
	^ self new unify: left with: right.! !
