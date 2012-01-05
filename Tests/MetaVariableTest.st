TestCase subclass: #MetaVariableTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgebraicDataType-Tests'!

!MetaVariableTest methodsFor: 'testing' stamp: 'fbs 5/24/2011 11:03'!
testUnapplyShouldDestructureCorrectly
	self assert: (MetaVariable named: #a) unapply = {#Variable. #a.}! !

!MetaVariableTest methodsFor: 'testing' stamp: 'fbs 5/24/2011 22:08'!
testVariableHasNoChildren
	self deny: (MetaVariable named: #foo) hasChildren.

	self assert: (MetaVariable named: #foo) children isEmpty.! !

!MetaVariableTest methodsFor: 'testing' stamp: 'fbs 5/25/2011 22:32'!
testVariableIsVariable
	self assert: (MetaVariable named: #foo) isMetaVariable.! !

!MetaVariableTest methodsFor: 'testing' stamp: 'fbs 5/25/2011 22:32'!
testVariableIsVariable
	self assert: (MetaVariable named: #foo) isMetaVariable.! !


!MetaVariableTest methodsFor: 'testing - comparing' stamp: 'fbs 1/4/2012 20:34'!
testMetaVariableEqualToSameNamedMetaVariable
	self assert: #x asVariable equals: #x asVariable.! !

!MetaVariableTest methodsFor: 'testing - comparing' stamp: 'fbs 1/4/2012 20:35'!
testMetaVariableHashEqualToSameNamedMetaVariableHash
	self assert: #x asVariable hash equals: #x asVariable hash.! !

!MetaVariableTest methodsFor: 'testing - comparing' stamp: 'fbs 1/4/2012 20:36'!
testMetaVariableHashNotEqualToDifferentlyNamedMetaVariableHash
	self deny: #x asVariable hash = #X asVariable hash.! !

!MetaVariableTest methodsFor: 'testing - comparing' stamp: 'fbs 1/4/2012 20:35'!
testMetaVariableNotEqualToDifferentlyNamedMetaVariable
	self deny: #x asVariable = #X asVariable.! !

!MetaVariableTest methodsFor: 'testing - comparing' stamp: 'fbs 1/4/2012 20:35'!
testMetaVariableNotEqualToNil
	self deny: #x asVariable = nil! !
