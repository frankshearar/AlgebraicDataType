AlgebraicDataType subclass: #VariadicTerm
	instanceVariableNames: 'subterms'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgebraicDataType-Tests'!
!VariadicTerm commentStamp: 'fbs 5/29/2011 16:47' prior: 0!
A general term that may contain any (variable) number of subterms. It's mainly just for testing.!


!VariadicTerm methodsFor: 'destructuring' stamp: 'fbs 5/27/2011 20:27'!
unapply
	^ #Term asOrderedCollection, subterms.! !


!VariadicTerm methodsFor: 'private' stamp: 'fbs 5/27/2011 20:26'!
with: aCollection
	subterms := aCollection! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

VariadicTerm class
	instanceVariableNames: ''!

!VariadicTerm class methodsFor: 'instance variables' stamp: 'fbs 5/27/2011 20:26'!
with: aCollection
	^ self new with: aCollection.! !
