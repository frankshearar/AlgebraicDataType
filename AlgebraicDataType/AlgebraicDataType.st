Object subclass: #AlgebraicDataType
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgebraicDataType'!
!AlgebraicDataType commentStamp: 'fbs 5/25/2011 07:30' prior: 0!
My subclasses represent algebraic types. My subclasses know how to destructure themselves through implementing #unapply.

Further, for unification between two graphs of instances of my subclasses, you may think of the instances as functions. For instance, Node left: a right: b is conceptually the same as some function Node(left, right) taking Trees as parameters. Thus, you may access a structure's parts through a parameter-like API in #paramAt:, #numArgs, etc.!


!AlgebraicDataType methodsFor: 'comparing' stamp: 'fbs 5/22/2011 21:14'!
= anObject
	^ (anObject respondsTo: #unapply)
		ifTrue: [self unapply = anObject unapply]
		ifFalse: [anObject isCollection
			ifTrue: [self unapply = anObject]
			ifFalse: [false]]! !

!AlgebraicDataType methodsFor: 'comparing' stamp: 'fbs 5/25/2011 22:54'!
hash
	"17's a prime."
	^ self unapply inject: 17 into: [:acc :each | 17 * each hash].! !


!AlgebraicDataType methodsFor: 'testing' stamp: 'fbs 5/27/2011 22:06'!
arity
	^ self children size.! !

!AlgebraicDataType methodsFor: 'testing' stamp: 'fbs 5/30/2011 13:28'!
hasChildren
	"Return true if self contains substructures/is of the form f(x1, x2, ..., xn)."
	"This covers most bases, but see MetaVariable for an exception."
	^ self children isEmpty not.! !

!AlgebraicDataType methodsFor: 'testing' stamp: 'fbs 5/25/2011 22:34'!
isAlgebraic
	^ true.! !


!AlgebraicDataType methodsFor: 'accessing' stamp: 'fbs 5/24/2011 22:06'!
children
	^ self unapply allButFirst.! !

!AlgebraicDataType methodsFor: 'accessing' stamp: 'fbs 5/25/2011 23:06'!
type
	^ self unapply first.! !


!AlgebraicDataType methodsFor: 'printing' stamp: 'fbs 7/23/2011 10:52'!
printOn: aStream
	aStream nextPut: $(.
	aStream nextPutAll: ((self unapply collect: [:token | token printString])
		reduce: [:acc :each | acc , ' ', each]).
	aStream nextPut: $).! !


!AlgebraicDataType methodsFor: 'destructuring' stamp: 'fbs 5/22/2011 20:29'!
unapply
	self subclassResponsibility.! !

!AlgebraicDataType methodsFor: 'destructuring' stamp: 'fbs 7/23/2011 10:55'!
unapplyFully
	^ self unapply collect: [:token | token unapplyFully]! !


!AlgebraicDataType methodsFor: '*Unification' stamp: 'fbs 8/9/2011 07:32'!
or: anObject
	^ OrUnifier left: self right: anObject! !

!AlgebraicDataType methodsFor: '*Unification' stamp: 'fbs 1/4/2012 20:20'!
unificationClosureWith: anObject in: termRelation
	anObject isMetaVariable
		ifTrue: [^ termRelation union: self with: anObject].

	^ anObject unificationClosureWithAlgebraic: self in: termRelation.! !

!AlgebraicDataType methodsFor: '*Unification' stamp: 'fbs 12/30/2011 22:14'!
unificationClosureWithAlgebraic: anObject in: termRelation
	"s = f(s1, ..., sm), t = g(t1, ..., tn) where m, n > 0"
	| partition |
	(self type = anObject type) ifFalse: [UnificationFailure signal. "f ~= g"].
	(self arity = anObject arity) ifFalse: [UnificationFailure signal. "m ~= n"].
	partition := termRelation.
	self children with: anObject children do:
		[:si :ti | partition := (partition find: si) unificationClosureWith: (partition find: ti) in: partition].
	^ partition.! !



"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

AlgebraicDataType class
	instanceVariableNames: ''!

!AlgebraicDataType class methodsFor: 'instance creation' stamp: 'fbs 7/22/2011 17:31'!
apply: aCollection
	"The inverse operation to #unapply: given a tagged collection, create an object."
	self subclassResponsibility.! !

!AlgebraicDataType class methodsFor: 'instance creation' stamp: 'fbs 7/9/2011 17:20'!
define: className in: category
	"Define the root class of an algebraic data type.
	- Return the new class."
	^ AlgebraicDataType
		subclass: className
		instanceVariableNames: ''
		classVariableNames: ''
		poolDictionaries: ''
		category: category.! !

!AlgebraicDataType class methodsFor: 'instance creation' stamp: 'fbs 7/10/2011 08:55'!
define: className in: category ofType: superclass withConstructor: selector
	"Define a new class with superclass superclass.
	- Define a class-side constructor called selector. This calls out to a private instance-side initialiser.
	- Define instvars by deconstructing selector - #a:b:c: will define instvars 'a b c'.
	- Define accessors for those instvars.
	- Return the new class."
	| newClass varNames |
	selector numArgs = 0 ifTrue: [Error signal: 'Selector must have arity > 0'].
	varNames := selector allButLast splitBy: #:.
	newClass := superclass
		subclass: className
		instanceVariableNames: (varNames reduce: [:acc :each | acc, ' ', each asString])
		classVariableNames: ''
		poolDictionaries: ''
		category: category.
	"Type constructor"
	newClass class compile: (self constructorFor: selector).
	newClass class organization addCategory: 'instance creation'.
	newClass class organization classify: selector under: 'instance creation'.
	"Accessors"
	newClass organization addCategory: 'accessing'.
	varNames do: [:each |
		newClass compile: (self accessorFor: each).
		newClass organization classify: each under: 'accessing'].
	"Initialiser"
	newClass organization addCategory: 'private'.
	newClass compile: (self initialiserFor: selector).
	newClass organization classify: selector under: 'private'.
	^ newClass.! !

!AlgebraicDataType class methodsFor: 'instance creation' stamp: 'fbs 7/9/2011 17:09'!
define: className in: category withConstructor: selector
	^ self
		define: className
		in: category
		ofType: AlgebraicDataType
		withConstructor: selector.! !

!AlgebraicDataType class methodsFor: 'instance creation' stamp: 'fbs 7/9/2011 14:32'!
define: className withConstructor: selector
	^ self
		define: className
		in: AlgebraicDataType category
		ofType: AlgebraicDataType
		withConstructor: selector.! !


!AlgebraicDataType class methodsFor: 'testing' stamp: 'fbs 7/22/2011 17:47'!
assertCorrectSize: aCollection
	| expected |
	expected := self new unapply size.
	(aCollection size = expected)
		ifFalse: [ApplyError signal: ('Incorrect number of arguments: was {1}, expected {2}' format: {aCollection size. expected})].! !

!AlgebraicDataType class methodsFor: 'testing' stamp: 'fbs 7/22/2011 17:46'!
assertCorrectTag: aCollection
	| expected |
	expected := self new unapply first.
	(aCollection first = expected)
		ifFalse: [ApplyError signal: ('Unexpected tag: was {1}, expected {2}' format: {aCollection first. expected})].! !


!AlgebraicDataType class methodsFor: 'private' stamp: 'fbs 7/9/2011 16:55'!
accessorFor: selector
	selector numArgs > 0 ifTrue: [Error signal: 'Accessor must have arity 0'].
	
	^ {selector asString. '	^ ', selector asString , '.'} join: Character cr.! !

!AlgebraicDataType class methodsFor: 'private' stamp: 'fbs 7/9/2011 15:07'!
constructorFor: selector
	| tokens interleavedNames |
	selector numArgs = 0 ifTrue: [Error signal: 'Selector must have arity > 0'].
	tokens := selector allButLast splitBy: #:.
	interleavedNames := (tokens collect: [:each | each, ': ', each]) reduce: [:acc :each | acc, ' ', each].
	^ interleavedNames, Character cr,
		'	^ self new ', interleavedNames, '.'! !

!AlgebraicDataType class methodsFor: 'private' stamp: 'fbs 7/9/2011 16:03'!
initialiserFor: selector
	| tokens names |
	selector numArgs = 0 ifTrue: [Error signal: 'Selector must have arity > 0'].
	
	tokens := selector allButLast splitBy: #:.
	names := tokens collect: [:each | each -> ('a', each capitalized)].

	^ ({(names collect: [:each | each key asString, ': ', each value]) join: ' '} ,
		(names collect: [:each | ('	{1} := {2}.' format: {each key. each value.})]))
			join: Character cr.! !
n: Character cr.! !
or: selector
	| tokens names |
	selector numArgs = 0 ifTrue: [Error signal: 'Selector must have arity > 0'].
	
	tokens := selector allButLast splitBy: #:.
	names := tokens collect: [:each | each -> ('a', each capitalized)].

	^ ({(names collect: [:each | each key asString, ': ', each value]) join: ' '} ,
		(names collect: [:each | ('	{1} := {2}.' format: {each key. each value.})]))
			join: Character cr.! !
