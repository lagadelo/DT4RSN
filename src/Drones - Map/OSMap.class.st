Class {
	#name : #OSMap,
	#superclass : #Map,
	#instVars : [
		'angle'
	],
	#category : #'Drones - Map'
}

{ #category : #examples }
OSMap class >> example: aSymbol [
	"self example:#example"
	
	^ self position: (Position perform:aSymbol) angle: 120
]

{ #category : #examples }
OSMap class >> exampleCapture: aSymbol [
	"self exampleCapture:#example"
	
	^ (self example: aSymbol) capture
]

{ #category : #'instance creation' }
OSMap class >> position: aPosition [  

	| tmp |
	tmp   := self new. 
	tmp position: aPosition.
	^ tmp 
]

{ #category : #'instance creation' }
OSMap class >> position: aPosition angle: anAngle [

	| tmp |
	tmp := self position: aPosition.
	tmp angle: anAngle.
	^tmp

]

{ #category : #capture }
OSMap >> adapt: ratio [

"Constraints: 0 <ratio< 1"
"Crop then scale the image"


| defaultSize size subImage ratioTest   |
	ratioTest := ratio. ratioTest := 0.5.
	defaultSize := OSMapGetter  defaultImageSize. 
	size    := (defaultSize * ratioTest) floor. 
	subImage :=  (data crop: (1@1) * ((defaultSize - size)/2 ) rounded   h: size  w: size ).
	data := subImage scaled: defaultSize  height: defaultSize

]

{ #category : #accessing }
OSMap >> angle [
	
	angle ifNil:[self initializeAngle].
	^ angle
]

{ #category : #accessing }
OSMap >> angle: anObject [

	angle := anObject
]

{ #category : #capture }
OSMap >> capture [

	OSMapGetter capture: self 
]

{ #category : #accessing }
OSMap >> data [

	^ data
]

{ #category : #accessing }
OSMap >> data: anObject [

	data := anObject
]

{ #category : #defaults }
OSMap >> defaultAngle [ 

	^120
]

{ #category : #intialization }
OSMap >> initializeAngle [

	angle := self defaultAngle
]

{ #category : #accessing }
OSMap >> position [

	^ position
]

{ #category : #accessing }
OSMap >> position: anObject [

	position := anObject
]
