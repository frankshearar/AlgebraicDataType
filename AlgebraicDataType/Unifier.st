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


!Unifier methodsFor: 'evaluating' stamp: 'fbs 5/25/2011 22:36'!
unify: s with: t
	self addDecorations: s.
	self addDecorations: t.
	self unifClosure: (decorators at: s) and: (decorators at: t).
	self findSolution: (decorators at: s).
	^ Dictionary newFrom: sigma.! !


!Unifier methodsFor: 'private' stamp: 'fbs 5/25/2011 23:03'!
addDecorations: s
	decorators at: s ifAbsentPut: (UnificationDecoration decorate: s).
	((s isKindOf: AlgebraicDataType) and: [s hasChildren])
		ifTrue: [s children do: [:each | self addDecorations: each]].! !


!Unifier methodsFor: 'as yet unclassified' stamp: 'fbs 5/25/2011 22:40'!
findSolution: aDecorator
	| s |
	s := aDecorator findRepresentative schemaTerm.
	s acyclic ifTrue: [^self "s is not part of a cycle."].
	
	s visited ifTrue: [UnificationFailure signal. "Cycle detected."].
	
	(s node isAlgebraic and: [s node hasChildren]) ifTrue:
		[s visited: true.
		s node children do:
			[:each | self findSolution: (decorators at: each)].
		s visited: false].
	
	s acyclic: true.
	s findRepresentative vars do:
		[:x | (x ~= s node) ifTrue: [sigma addFirst: (x -> s node)]].! !

!Unifier methodsFor: 'as yet unclassified' stamp: 'fbs 5/25/2011 23:06'!
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
					[:si :ti | self unifClosure: (decorators at: si) and: (decorators at: ti)]]
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
