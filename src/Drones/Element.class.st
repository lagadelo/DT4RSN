"
This class implements a Composite DP
"
Class {
	#name : #Element,
	#superclass : #Object,
	#instVars : [
		'id'
	],
	#category : #Drones
}

{ #category : #flattening }
Element >> flattens [

	| aStream |
	aStream := ReadWriteStream new.
	self flattensInto: aStream.
	^	aStream contents

	 
]

{ #category : #flattening }
Element >> flattensInto: aStream [

	^self subclassResponsibility
]

{ #category : #accessing }
Element >> id [

	^ id
]

{ #category : #accessing }
Element >> id: anObject [

	id := anObject
]

{ #category : #testing }
Element >> within: aBoundingBox [

	^self subclassResponsibility
]
