Class {
	#name : #Drone,
	#superclass : #Element,
	#instVars : [
		'position',
		'sensors'
	],
	#category : #Drones
}

{ #category : #examples }
Drone class >> example [

| tmp |
	tmp := self new initialize.
	tmp position: Position example.
	tmp attach: DroneCamera new.
^tmp 
]

{ #category : #'instance creation' }
Drone class >> position: aPosition [
^self new position:aPosition; yourself
]

{ #category : #building }
Drone >> attach: aSensor [ 

	sensors add: aSensor name -> aSensor.
	aSensor host: self.

]

{ #category : #flattening }
Drone >> flattenInto: aStream [

	aStream nextPut: self
]

{ #category : #initialization }
Drone >> initialize [ 

	sensors := Dictionary new
]

{ #category : #choosing }
Drone >> need: aSymbol [

^self sensors select:[:s| s canProcess: aSymbol]
]

{ #category : #accessing }
Drone >> position [

	^ position
]

{ #category : #accessing }
Drone >> position: anObject [

	position := anObject
]

{ #category : #processing }
Drone >> process [ 

	self sensors valuesDo:[:aSensor| aSensor process]
]

{ #category : #processing }
Drone >> processSensor: aSensor [

	aSensor process
]

{ #category : #processing }
Drone >> processSensorNamed: aSensorName [

	self processSensor: (sensors at: aSensorName)  

]

{ #category : #accessing }
Drone >> sensors [

	^ sensors
]

{ #category : #accessing }
Drone >> sensors: anObject [

	sensors := anObject
]

{ #category : #testing }
Drone >> within: aBoundingBox [

	"^aBoundingBox includes:   self position"
	^true
]
