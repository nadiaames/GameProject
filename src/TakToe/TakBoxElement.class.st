Class {
	#name : #TakBoxElement,
	#superclass : #BlElement,
	#instVars : [
		'box',
		'board'
	],
	#classVars : [
		'ColorDictionary'
	],
	#category : #'TakToe-UI'
}

{ #category : #accessing }
TakBoxElement class >> box: aMBox [

	^ self new box: aMBox
]

{ #category : #'class initialization' }
TakBoxElement class >> initialize [ 

	ColorDictionary := { 0 -> Color orange.
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
	self changeColor 

]

{ #category : #public }
TakBoxElement >> changeColor [
	self background: (self colorDictionary at: self box value)
]

{ #category : #public }
TakBoxElement >> clickbox [
			self board clickOnBox: self box.
			self changeColor
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
