AlgebraicDataType subclass: #Tree
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgebraicDataType-Trees'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Tree class
	instanceVariableNames: 'EmptyTree'!

!Tree class methodsFor: 'instance creation' stamp: 'fbs 7/22/2011 18:00'!
apply: aCollection
	| knownTags tag |
	aCollection isEmpty ifTrue: [ApplyError signal: 'Cannot apply the empty list'].
	tag := aCollection first.
	tag = #Empty ifTrue: [^ Empty apply: aCollection].
	tag = #Leaf ifTrue: [^ Leaf apply: aCollection].
	tag = #Node ifTrue: [^ Node apply: aCollection].
	knownTags := 'Empty, Leaf, Node'.
	ApplyError signal: ('Unknown tag {1}, expected one of {2}' format: {tag. knownTags}). ! !


!Tree class methodsFor: 'accessing' stamp: 'fbs 5/22/2011 20:27'!
empty
	^ EmptyTree.! !


!Tree class methodsFor: 'class initialization' stamp: 'fbs 5/22/2011 20:28'!
initialize
	EmptyTree := Empty new.! !


Tree initialize!
dsFor: 'accessing' stamp: 'fbs 5/22/2011 20:27'!
empty
	^ EmptyTree.! !


!Tree class methodsFor: 'class initialization' stamp: 'fbs 5/22/2011 20:28'!
initialize
	EmptyTree := Empty new.! !


Tree initialize!
