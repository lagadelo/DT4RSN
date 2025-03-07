Class {
	#name : #MapLayer,
	#superclass : #Object,
	#instVars : [
		'data',
		'name',
		'boundingBox'
	],
	#category : #'Drones - Map'
}

{ #category : #'instance creation' }
MapLayer class >> data: someData [

^self new data: someData
]

{ #category : #accessing }
MapLayer >> boundingBox [

	^ boundingBox
]

{ #category : #accessing }
MapLayer >> boundingBox: anObject [

	boundingBox := anObject
]

{ #category : #accessing }
MapLayer >> data [

	^ data
]

{ #category : #accessing }
MapLayer >> data: anObject [

	data := anObject
]

{ #category : #drawing }
MapLayer >> draw [

| semanticLayer window |
window:= 0@0 extent: 600@400.
semanticLayer :=self drawWithin: self boundingBox. "extract meaningfull data"
semanticLayer size: window. "set up graphical counterpart (needs zoom, offset)"
]

{ #category : #drawing }
MapLayer >> drawWithin: aRectange [
]

{ #category : #accessing }
MapLayer >> name [

	^ name
]

{ #category : #accessing }
MapLayer >> name: anObject [

	name := anObject
]
