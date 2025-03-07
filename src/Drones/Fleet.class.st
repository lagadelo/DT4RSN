Class {
	#name : #Fleet,
	#superclass : #Element,
	#instVars : [
		'elements'
	],
	#category : #Drones
}

{ #category : #'instance creation' }
Fleet class >> elements: aCollection [

| fleet |
fleet := self new.
aCollection do:[:anElement| fleet addElement: anElement].
^fleet 
]

{ #category : #'managing elements groups' }
Fleet >> addElement: anElement [
elements add: anElement
]

{ #category : #flattening }
Fleet >> flattensInto: aStream [

	elements do:  [ :anElement| anElement flattensInto: aStream. ]
]

{ #category : #initializing }
Fleet >> initialize [ 
super initialize.
elements := OrderedCollection new.

]

{ #category : #'managing elements groups' }
Fleet >> removeElement: anElement [
elements remove: anElement
]

{ #category : #testing }
Fleet >> within: aBoundingBox [

	^self shouldBeImplemented 
]
