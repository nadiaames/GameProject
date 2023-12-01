Class {
	#name : #TakBoxElement,
	#superclass : #BlElement,
	#instVars : [
		'box',
		'board'
	],
	#classVars : [
		'ColorDictionary',
		'icons'
	],
	#category : #'TakToe-UI'
}

{ #category : #'class initialization' }
TakBoxElement class >> initialize [ 

	ColorDictionary := { 0 -> Color red.
	1 -> Color black.
	nil -> Color lightGray } asDictionary 

]

{ #category : #accessing }
TakBoxElement >> board [

	^ board
]

{ #category : #accessing }
TakBoxElement >> board: aTBoard [

	board := aTBoard
]

{ #category : #accessing }
TakBoxElement >> box [ 
	^ box
]

{ #category : #accessing }
TakBoxElement >> box: aTBox [
	box := aTBox.

]

{ #category : #public }
TakBoxElement >> clickbox [
	self box isTakEmptyBox 
		ifTrue: [  ]
		ifFalse: [  ]
]

{ #category : #'as yet unclassified' }
TakBoxElement >> colorDictionary [

	^ ColorDictionary
]

{ #category : #public }
TakBoxElement >> initialize [
	super initialize.
	
	self geometry: (BlRoundedRectangleGeometry cornerRadius: 5).
	self constraintsDo: [ :aLayoutConstraints |
		aLayoutConstraints horizontal matchParent.
		aLayoutConstraints vertical matchParent ].

	self addEventHandlerOn: BlMouseUpEvent do: [ :anEvent | self clickbox ]
]
