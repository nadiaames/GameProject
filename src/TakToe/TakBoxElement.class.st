Class {
	#name : #TakBoxElement,
	#superclass : #BlElement,
	#instVars : [
		'box',
		'board',
		'field',
		'positionInField'
	],
	#classVars : [
		'Icons'
	],
	#category : #'TakToe-UI'
}

{ #category : #accessing }
TakBoxElement class >> createWithBox: aTBox [
	^ self new box: aTBox
]

{ #category : #accessing }
TakBoxElement >> box [ 
	^ box
]

{ #category : #accessing }
TakBoxElement >> box: aTBox [
	box := aTBox.

]

{ #category : #accessing }
TakBoxElement >> field [ 
	^field 
]

{ #category : #accessing }
TakBoxElement >> field: aTField [
	field:= aTField.
	self size: (75@75) * aTField magnifier.
]

{ #category : #accessing }
TakBoxElement >> positionInField [ 
	^ positionInField 
]

{ #category : #accessing }
TakBoxElement >> positionInField: aPoint [
	positionInField := aPoint 
]
