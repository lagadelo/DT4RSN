Class {
	#name : #Position,
	#superclass : #Object,
	#instVars : [
		'longitude',
		'latitude',
		'altitude'
	],
	#category : #'Drones - Support'
}

{ #category : #example }
Position class >> example [

"Brest, France, at an altitude of 1000m"

^self latitude: 48.380247380573806 longitude: -4.524116460558902  altitude:1000
]

{ #category : #example }
Position class >> example2 [

"Carhaix, France, at an altitude of 1000m"

^self latitude: 48.27594 longitude: -3.57326 altitude:1000
]

{ #category : #'as yet unclassified' }
Position class >> latitude: lat longitude: lon altitude: alt [
^self new latitude: lat; longitude: lon; altitude: alt; yourself
]

{ #category : #accessing }
Position >> altitude [

	^ altitude
]

{ #category : #accessing }
Position >> altitude: anObject [

	altitude := anObject
]

{ #category : #accessing }
Position >> latitude [

	^ latitude
]

{ #category : #accessing }
Position >> latitude: anObject [

	latitude := anObject
]

{ #category : #accessing }
Position >> longitude [

	^ longitude
]

{ #category : #accessing }
Position >> longitude: anObject [

	longitude := anObject
]
