AlgebraicDataType subclass: #MetaVariable
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgebraicDataType'!
!MetaVariable commentStamp: 'fbs 5/24/2011 11:04' prior: 0!
A MetaVariable is a reified variable, that is, an object representing a variable. It is a placeholder in a structure that says "we don't know what the value is of this part of the structure, but we can give it a name."!


!MetaVariable methodsFor: 'accessing' stamp: 'fbs 5/24/2011 22:06'!
children
	^ #().! !

!MetaVariable methodsFor: 'accessing' stamp: 'fbs 5/24/2011 07:30'!
name
	^ name.! !



!MetaVariable methodsFor: 'destructuring' stamp: 'fbs 5/24/2011 07:34'!
unapply
	^ {#Variable. name.}! !



!MetaVariable methodsFor: 'testing' stamp: 'fbs 5/24/2011 22:05'!
hasChildren
	"Even though unapplied a variable looks like it has a parameter, that's just its name."
	^ false.! !



!MetaVariable methodsFor: 'private' stamp: 'fbs 5/24/2011 07:32'!
name: aSymbol
	name := aSymbol.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

MetaVariable class
	instanceVariableNames: ''!

!MetaVariable class methodsFor: 'instance creation' stamp: 'fbs 5/24/2011 07:31'!
named: aSymbol
	^ self new name: aSymbol.! !
tance creation' stamp: 'fbs 5/24/2011 07:31'!
named: aSymbol
	^ self new name: aSymbol.! !
able methodsFor: 'testing' stamp: 'fbs 5/24/2011 22:05'!
hasChildren
	"Even though unapplied a variable looks like it has a parameter, that's just its name."
	^ false.! !

!MetaVariable methodsFor: 'testing' stamp: 'fbs 1/4/2012 20:16'!
isMetaVariable
	^ true.! !


!MetaVariable methodsFor: 'unification' stamp: 'fbs 1/3/2012 15:30'!
unificationClosureWith: anObject in: termRelation
	^ termRelation union: self with: anObject.! !


!MetaVariable methodsFor: 'private' stamp: 'fbs 5/24/2011 07:32'!
name: aSymbol
	name := aSymbol.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

MetaVariable class
	instanceVariableNames: ''!

!MetaVariable class methodsFor: 'instance creation' stamp: 'fbs 5/24/2011 07:31'!
named: aSymbol
	^ self new name: aSymbol.! !
