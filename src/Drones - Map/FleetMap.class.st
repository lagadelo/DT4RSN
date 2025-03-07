Class {
	#name : #FleetMap,
	#superclass : #MapLayer,
	#category : #'Drones - Map'
}

{ #category : #drawing }
FleetMap >> draw [


]

{ #category : #drawing }
FleetMap >> drawWithIn:  aBoundingBox [ 

| allElements allEments consideredElements |
allElements := self data flattens.
allElements do:[:aDrone| aDrone process: #gps]. "Might suppose lazy synchronization"
consideredElements := allEments select:[:element| element within: aBoundingBox].
consideredElements  do:[:aDrone| aDrone process:#camera].



]
