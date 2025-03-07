Class {
	#name : #GPSSensor,
	#superclass : #DroneSensor,
	#instVars : [
		'position'
	],
	#category : #Drones
}

{ #category : #'default model values' }
GPSSensor class >> defaultBehavior [
"Update drone perceived position"
	^[:s | s host position: s position]
]

{ #category : #'instance creation' }
GPSSensor class >> new [

	| tmp |
	tmp := self basicNew initialize.
	tmp behavior: self defaultBehavior; name: #gps.
	^tmp 
]

{ #category : #testing }
GPSSensor >> abilities [ 
	^(#Position)
]

{ #category : #accessing }
GPSSensor >> position [

	^ position
]

{ #category : #accessing }
GPSSensor >> position: anObject [

	position := anObject
]
