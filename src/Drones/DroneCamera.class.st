Class {
	#name : #DroneCamera,
	#superclass : #DroneSensor,
	#instVars : [
		'angle',
		'resolution'
	],
	#category : #Drones
}

{ #category : #'default model values' }
DroneCamera class >> defaultBehavior [

	^ [:s| s data: (OSMap position: s host position angle: 120 ) capture ]
]

{ #category : #examples }
DroneCamera class >> example [
| tmp |
	tmp := self new. 
	tmp angle: 120.
	tmp resolution: 12000000/ 1920. "Assume squared images for 1920*1080 images of 12M"
	^ tmp  
]

{ #category : #'instance creation' }
DroneCamera class >> new [

	| tmp |
	tmp := self basicNew initialize.
	tmp behavior: self defaultBehavior; name: #camera.
	^tmp 
]

{ #category : #testing }
DroneCamera >> abilities [ 
	^#OSMap
]

{ #category : #accessing }
DroneCamera >> angle [

	^ angle
]

{ #category : #accessing }
DroneCamera >> angle: anObject [

	angle := anObject
]

{ #category : #capture }
DroneCamera >> capture [ 
	| map |
	map := OSMap new.
	map  position: self host position.
	map angle: self angle.
	data := 	map  capture
]

{ #category : #initialization }
DroneCamera >> initialize [ 


"Assume 1920*1080 dimension for 12M leads to 5,78 factor. Apply to squared images: 6250*6250"
resolution :=  6250.
angle := 120
]

{ #category : #accessing }
DroneCamera >> resolution [

	^ resolution
]

{ #category : #accessing }
DroneCamera >> resolution: anObject [

	resolution := anObject
]
