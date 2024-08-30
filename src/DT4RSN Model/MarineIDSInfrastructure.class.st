"
This represents the infra for nodes based Intrusion Detection System. It is a specific case of DT.


   Instance Variables
	nodes:		<IDSNode>


     
"
Class {
	#name : #MarineIDSInfrastructure,
	#superclass : #Object,
	#instVars : [
		'nodes',
		'intrusions',
		'timeStamp',
		'criteria'
	],
	#category : #'DT4RSN Model'
}

{ #category : #'instance creation' }
MarineIDSInfrastructure class >> with: nodes with: criteria [

| dt |
dt := self new.
dt nodes: nodes.
dt criteria: criteria.
^dt.

]

{ #category : #accessing }
MarineIDSInfrastructure >> criteria [

	^ criteria
]

{ #category : #accessing }
MarineIDSInfrastructure >> criteria: anObject [

	criteria := anObject
]

{ #category : #computing }
MarineIDSInfrastructure >> detectIntrusion [

| position |
"For sake of simplicity, assume only two nodes"
position := self nodes first detectIntrusion intersectionsWithLine: self nodes last detectIntrusion.
 
self intrusions addFirst: (Intruder when: self timeStamp where: position from: self intrusions last).
self reactToChange.

]

{ #category : #initializing }
MarineIDSInfrastructure >> initialize [ 

nodes := OrderedCollection new.
intrusions := OrderedCollection new.
timeStamp := 0.

]

{ #category : #accessing }
MarineIDSInfrastructure >> intrusions [

	^ intrusions
]

{ #category : #accessing }
MarineIDSInfrastructure >> intrusions: anObject [

	intrusions := anObject
]

{ #category : #accessing }
MarineIDSInfrastructure >> nodes [

	^ nodes
]

{ #category : #accessing }
MarineIDSInfrastructure >> nodes: anObject [

	nodes := anObject
]

{ #category : #computing }
MarineIDSInfrastructure >> reactToChange [

^(self criteria collect:[:a| self reactToChange: a]) reject:[:a| a isNil]
]

{ #category : #computing }
MarineIDSInfrastructure >> reactToChange: aSymbol [

"Report any change"
^(self  intrusions first perform: aSymbol) = ((self intrusions at:2) perform: aSymbol) ifTrue:[nil] ifFalse:[aSymbol]
]

{ #category : #'accessing - structure variables' }
MarineIDSInfrastructure >> state [ 
^self intrusions first
]

{ #category : #accessing }
MarineIDSInfrastructure >> timeStamp [

	^ timeStamp
]

{ #category : #accessing }
MarineIDSInfrastructure >> timeStamp: anObject [

	timeStamp := anObject
]
