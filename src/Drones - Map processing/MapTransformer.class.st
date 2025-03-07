Class {
	#name : #MapTransformer,
	#superclass : #Object,
	#instVars : [
		'transformations',
		'behavior'
	],
	#category : #'Drones - Map processing'
}

{ #category : #example }
MapTransformer class >> defaultBehavior [ 

^[:s :aMap| aMap data: (s dominant:  aMap )]
]

{ #category : #'instance creation' }
MapTransformer class >> example [

^self processing: self defaultBehavior 
]

{ #category : #'instance creation' }
MapTransformer class >> processing: aBlock [

^self new behavior: aBlock; yourself
]

{ #category : #'color transformation' }
MapTransformer >> average: aMap [ 
^
	ImageForm newImageColor: (self averageColor:aMap) width: aMap data width height: aMap data height
]

{ #category : #'color mapping' }
MapTransformer >> averageColor: aMap [ 
^Color colorFromPixelValue: ((aMap   data bits inject:0 into:[:a :b| a+b]) / (aMap data width* aMap data height)) asInteger depth: 32
]

{ #category : #accessing }
MapTransformer >> behavior [

	^ behavior
]

{ #category : #accessing }
MapTransformer >> behavior: anObject [

	behavior := anObject
]

{ #category : #'private - transforming' }
MapTransformer >> darker: aValue [

self transformations  add: (Array with: #darker: with: (Array with: aValue))
]

{ #category : #'color transformation' }
MapTransformer >> dominant: aMap [
	
	^ImageForm newImageColor: (self dominantColor:aMap) width: aMap data width height: aMap data height
]

{ #category : #'color mapping' }
MapTransformer >> dominantColor: aMap [ 
^aMap data dominantColor
]

{ #category : #'private - transforming' }
MapTransformer >> grayScale [

self transformations  add: (Array with: #asGrayScale with: #())
]

{ #category : #initializing }
MapTransformer >> initialize [
transformations := OrderedCollection new 
]

{ #category : #'private - transforming' }
MapTransformer >> magnifyBy: aFactor [

self transformations  add: (Array with: #magnifyBy: with: (Array with: aFactor))
]

{ #category : #processing }
MapTransformer >> processOver: aMap [
"
| img |
img := image copy.
self transformations do:[:a| img := img perform a first withArguments: a last.].
^image "

self behavior value: self value: aMap
]

{ #category : #'color transformation' }
MapTransformer >> rgbDominant: aMap [
	
	^ImageForm newImageColor: (self rgbDominantColor:aMap) width: aMap data width height: aMap data height
]

{ #category : #'color mapping' }
MapTransformer >> rgbDominantColor: aMap [ 
| color |
color := self averageColor: aMap.
(color red >= color blue) & (color red >= color green) ifTrue:[^Color red].
(color blue >= color red) & (color blue >= color green) ifTrue:[^Color blue].
^Color green
]

{ #category : #accessing }
MapTransformer >> transformations [

	^ transformations
]
