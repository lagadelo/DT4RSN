Class {
	#name : #DroneExample,
	#superclass : #Object,
	#category : #'Drones - Example'
}

{ #category : #examples }
DroneExample class >> example1 [ 

	"self example1"
	
	"This is a simple example for setting up a fleet"
	
| drone1 drone2 fleet |

	drone1 := Drone   position: Position example.
	drone1 attach: DroneCamera new.
	drone2 := Drone   position: Position example2.
	drone2 attach: DroneCamera new.
 	drone2 attach: GPSSensor  new.
	fleet := Fleet elements: (Array with: drone1 with: drone2).
	^fleet
]

{ #category : #examples }
DroneExample class >> example2 [ 

	"self example2"
	
	"This is a simple example for setting up a fleetMap on example1"
	| fleet fleetMap |
	fleet := self example1.
	fleetMap := FleetMap new data: fleet.
^fleetMap

]
