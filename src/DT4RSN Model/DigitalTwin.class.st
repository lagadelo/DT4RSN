Class {
	#name : #DigitalTwin,
	#superclass : #Object,
	#instVars : [
		'reality',
		'expectedState',
		'remediationPolicies',
		'introspectionPolicies'
	],
	#category : #'DT4RSN Model'
}

{ #category : #accessing }
DigitalTwin >> expectedState [

	^ expectedState
]

{ #category : #accessing }
DigitalTwin >> expectedState: anObject [

	expectedState := anObject
]

{ #category : #accessing }
DigitalTwin >> introspectionPolicies [

	^ introspectionPolicies
]

{ #category : #accessing }
DigitalTwin >> introspectionPolicies: anObject [

	introspectionPolicies := anObject
]

{ #category : #updating }
DigitalTwin >> process [
self reality process.
self expectedState = self reality state ifFalse:[self update].


]

{ #category : #accessing }
DigitalTwin >> reality [

	^ reality
]

{ #category : #accessing }
DigitalTwin >> reality: anObject [

	reality := anObject
]

{ #category : #accessing }
DigitalTwin >> remediationPolicies [

	^ remediationPolicies
]

{ #category : #accessing }
DigitalTwin >> remediationPolicies: anObject [

	remediationPolicies := anObject
]

{ #category : #updating }
DigitalTwin >> update [
self reality isInWorkingCondition ifTrue:[self expectedState: self reality state] ifFalse:[self rebuildStateFromWorkingElements. self applyRemediationPolicy]
]
