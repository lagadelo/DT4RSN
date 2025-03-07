Class {
	#name : #OSMapGetter,
	#superclass : #Object,
	#instVars : [
		'zoom',
		'url',
		'tile',
		'point',
		'map'
	],
	#category : #'Drones - Map'
}

{ #category : #conversion }
OSMapGetter class >> altitudeForDistance: d angle: angle [
"e.g capturing 100*100 meters with a 120° camera means your altitude is  28.87
 self distance:100 angle: 120
"
 ^d / (Float pi /360 * angle) tan / 2
 

]

{ #category : #capture }
OSMapGetter class >> capture: aMap [

self new capture: aMap
]

{ #category : #conversion }
OSMapGetter class >> coverageWithAltitude: h angle: angle [
"e.g 100 meters altitude with 120° camera means you capture 346x346 squared meters"
"self coverageWithAltitude: 100 angle: 120 "
 
	^h  * (Float pi * angle / 360)   tan  *2 

]

{ #category : #'accessing - defaults' }
OSMapGetter class >> defaultImageSize [
^256
]

{ #category : #examples }
OSMapGetter class >> example [ 
^self example: 12
 
]

{ #category : #examples }
OSMapGetter class >> example2 [ 

"Brest, France, 1 squared kilometer"
^self latitude: 48.380247380573806 longitude: -4.524116460558902 area:1000000
]

{ #category : #examples }
OSMapGetter class >> example: zoom [

"Brest, France"
^self latitude: 48.380247380573806 longitude: -4.524116460558902 zoom: zoom
]

{ #category : #conversion }
OSMapGetter class >> meterByPixel: zoom [

 
]

{ #category : #resolution }
OSMapGetter class >> metersPerPixelWithZoom: zoom [

^  (1700/256) / (2 raisedTo:zoom -14)
]

{ #category : #resolution }
OSMapGetter class >> pixelsPerMeterWithZoom: zoom [

^  1/ (self metersPerPixelWithZoom:zoom)
]

{ #category : #zoom }
OSMapGetter class >> zoomForAltitude: altitude withAngle: angle [

^self zoomToShowMeters: (self altitude: altitude angle: angle) usingPixels: 256 "default size" 
]

{ #category : #zoom }
OSMapGetter class >> zoomToShowMeters: meters usingPixels: pixels [ 

"self zoomToShowMeters: 100000 usingPixels: 256 "

19 to:1 by: -1  do:[:zoom| (self metersPerPixelWithZoom: zoom) * pixels > meters ifTrue:[^zoom]]
]

{ #category : #capture }
OSMapGetter >> capture: aMap [
| weight fineSize fineImage |

self captureCoarseView: aMap.
weight := self defaultZoom fractionPart.
.
fineSize := "MapGetter defaultImageSize * (2 raisedTo:(1- weight) negated)." 256.
fineImage := (self captureFineView: aMap) scaledIntoFormOfSize: fineSize.
 aMap data: (aMap data mergeWith:fineImage weight: 0.1 startingAt: 1@1 * (OSMapGetter defaultImageSize - fineSize))
 
]

{ #category : #capture }
OSMapGetter >> captureCoarseView: aMap [
map := aMap.
zoom := self defaultZoom floor.
Transcript show: zoom printString ;cr.
map data: self getCenteredImage .
map adapt: (2 raisedTo: (self defaultZoom fractionPart) negated) 
]

{ #category : #capture }
OSMapGetter >> captureFineView: aMap [
map := aMap.
zoom := self defaultZoom ceiling.
Transcript show: zoom printString ;cr.
^self getCenteredImage .

"zoom := zoom +1.
finerData := self getCenteredImage .
map mergeWith: finerData weigh: self defaultZoom fractionPart"
]

{ #category : #capture }
OSMapGetter >> captureTile: aMap [
map := aMap.
zoom := self defaultZoom ceiling.
Transcript show: zoom printString ;cr.
^self getImage 
]

{ #category : #url }
OSMapGetter >> computePosition [

|   x sinLat y pos targetPosition |

	targetPosition  := self map position.

 

	"Normalize longitude, ie compute x"
	x :=   targetPosition longitude + 180 / 360 .
	
	"Sin requires degrees to radians conversion"
	sinLat := (targetPosition latitude * Float pi /180) sin.
	
	"Compute y"
	y := 0.5 - (((1 + sinLat/ (1 - sinLat)) ln) / ( 4*Float pi)).

	"The tiling system relies on a grid of 2^^n tiles, with n the zoom factor, ranging from 0 to 19"
	pos := (x@y *(2 raisedTo: zoom)).
	
	"Two values to be computed: the tiling indexes, and the position within the tile"
	tile := pos floor.
	point := (pos - tile) * self defaultImageSize.
]

{ #category : #defaults }
OSMapGetter >> defaultImageSize [

	" This comes from the openStreetMap specs. 256*256 images"
	
	^256 
]

{ #category : #defaults }
OSMapGetter >> defaultZoom [

"Stick Map defaultImageSize. Should refactor"

	"Considers 2 times sin of haft angle"
	|  distance |
	distance := 2 * self map position altitude * (self map angle  * Float pi / 360) sin.
	^((1700 / distance ) log: 2)  + 14 
	"Potential refactoring: use the zoom, keep the franction to crop and expand"
]

{ #category : #'images retrieval' }
OSMapGetter >> getCenteredImage [

	"This method return a centered image. This requires to get four images, split then into parts, 4 of which to be further re-assembled"
	
	|xRange yRange  position wideImage  |

	
	self computePosition.
	
	xRange :=self point x < 128 ifTrue:[  #(-1 0)] ifFalse:[ #(0 1)].
	yRange :=self point y < 128 ifTrue:[   #(-1 0)] ifFalse:[ #(0 1)].

	wideImage := ImageForm newFrom:(Form extent: (2@2) * self defaultImageSize  depth:16).

	xRange keysAndValuesDo:  [:xIndex :aX|
		yRange  keysAndValuesDo:  [:yIndex :aY|
			|subImage|
			"Get one partial image"
			subImage := ImageForm newFrom:((self getPngFromUrl: (self getUrlForTile: self tile +(aX@aY)))asFormOfDepth: 16).
			"Display the image"
			subImage displayOn: wideImage at: (xIndex@yIndex - 1) * self defaultImageSize]].
	
	"Crop to extract the centered subImage"
	position := point rounded - (self defaultImageSize/2).
	
	^wideImage crop:  (position x - (self defaultImageSize *xRange first)) @ (position y - (self defaultImageSize *yRange first))  h:self defaultImageSize  w:self defaultImageSize 


  
]

{ #category : #'images retrieval' }
OSMapGetter >> getGif [

	^self error:'Currently not supported'

	"^ZnEasy getGif: self url,'.gif'"
]

{ #category : #'images retrieval' }
OSMapGetter >> getImage [

	"Default format is PNG"
	^self getPng 
]

{ #category : #'images retrieval' }
OSMapGetter >> getJpeg [

	^self error:'Currently not supported'

	"^ZnEasy getJpeg: self url,'.jpeg'"
]

{ #category : #'images retrieval' }
OSMapGetter >> getPng [ 

	^self getPngFromUrl: self url
]

{ #category : #'images retrieval' }
OSMapGetter >> getPngFromFile: x [

	"Assumes tile/zoom have been properly precomputed"
	
^self error:'Not yet implemented'


]

{ #category : #'images retrieval' }
OSMapGetter >> getPngFromUrl: anUrl [

	"Assumes URL has been properly precomputed"
	
	^ZnEasy getPng: anUrl,'.png'.


]

{ #category : #url }
OSMapGetter >> getUrl [

	tile ifNil:[self computePosition].
	url := self getUrlForTile: self tile.
]

{ #category : #url }
OSMapGetter >> getUrlForTile:tileRef [ 
 
 
	^ 'https://tile.openstreetmap.org/',zoom printString,'/', tileRef x printString,'/',tileRef y printString .
 
]

{ #category : #accessing }
OSMapGetter >> map [

	^map
]

{ #category : #accessing }
OSMapGetter >> map: aMap [

"aMap is a client"

	map := aMap
]

{ #category : #accessing }
OSMapGetter >> point [

"position within the tile (ranging from O to tileSize -1)"

	^ point
]

{ #category : #accessing }
OSMapGetter >> tile [

	^ tile
]

{ #category : #accessing }
OSMapGetter >> url [

	url ifNil: [self getUrl] .
	^url 
	
]

{ #category : #accessing }
OSMapGetter >> zoom [

	^ zoom
]

{ #category : #accessing }
OSMapGetter >> zoom: anObject [

	zoom := anObject
]
