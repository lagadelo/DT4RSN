Class {
	#name : #BackgroudMap,
	#superclass : #MapLayer,
	#instVars : [
		'bottomPosition',
		'cornerPosition'
	],
	#category : #'Drones - Map'
}

{ #category : #drawing }
BackgroudMap >> draw [

^self data
]
