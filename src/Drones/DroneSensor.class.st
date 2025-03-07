Class {
	#name : #DroneSensor,
	#superclass : #Object,
	#instVars : [
		'behavior',
		'host',
		'name',
		'data'
	],
	#category : #Drones
}

{ #category : #'instance creation' }
DroneSensor class >> new [

^self subclassResponsibility
]

{ #category : #testing }
DroneSensor >> abilities [
"Provide a lst of abilities. Used by the drone to identify which sensor to activate"
^self subclassResponsibility 
]

{ #category : #accessing }
DroneSensor >> behavior [

	^ behavior
]

{ #category : #accessing }
DroneSensor >> behavior: anObject [

	behavior := anObject
]

{ #category : #processing }
DroneSensor >> canProcess: aSymbol [

^self abilities includes: aSymbol
]

{ #category : #accessing }
DroneSensor >> data [

	^ data
]

{ #category : #accessing }
DroneSensor >> data: aData [

	data := aData
]

{ #category : #accessing }
DroneSensor >> host [

	^ host
]

{ #category : #accessing }
DroneSensor >> host: anObject [

	host := anObject
]

{ #category : #accessing }
DroneSensor >> name [

	^ name
]

{ #category : #accessing }
DroneSensor >> name: anObject [

	name := anObject
]

{ #category : #notification }
DroneSensor >> notify:event [

self host notify:event from: self
]

{ #category : #processing }
DroneSensor >> process [

   (self behavior value: self) 
]
