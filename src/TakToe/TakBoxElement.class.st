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

]

{ #category : #public }
TakBoxElement >> click [
	self box isTakEmptyBox 
		ifTrue: [  ]
		ifFalse: [  ]
]

{ #category : #'as yet unclassified' }
TakBoxElement >> colorDictionary [

	^ ColorDictionary
]
